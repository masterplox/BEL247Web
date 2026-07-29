/// Temporary billing-period data for the dashboard.
///
/// Until `/V1/MeterUsage/BillingPeriods` exists, period boundaries are derived
/// from the account's bills (`BillDetailDataDto.readingDate` is already a
/// "04 Nov 25 - 04 Dec 25" range) and the in-progress period's usage is pulled
/// from the existing `/AMI/DailyRange` endpoint.
///
/// When the real endpoint lands, only [billingPeriodsProvider] needs to change:
/// it already returns [BillingPeriodsResult], which mirrors the planned
/// response shape.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/billing_period.dart';
import '../../ami_usage/state/ami_usage_providers.dart';
import '../../bills/state/bills_providers.dart';
import 'ami_dashboard_usage_providers.dart'
    show amiDashboardMeterIdProvider, amiDashboardMonthlyTotalsProvider;

/// How many past bills to pull when building the period history.
const int _maxBillHistory = 12;

/// Guard against runaway rolling when the newest bill is unusually stale.
const int _maxPeriodRollForward = 24;

/// Formats accepted for the dates inside `BillDetailDataDto.readingDate`.
final List<DateFormat> _billDateFormats = <DateFormat>[
  DateFormat('dd MMM yy'),
  DateFormat('dd MMM yyyy'),
  DateFormat('dd-MMM-yyyy'),
  DateFormat('dd-MMM-yy'),
];

DateTime? _parseBillDate(String raw) {
  final value = raw.trim();
  if (value.isEmpty) return null;

  for (final format in _billDateFormats) {
    try {
      return format.parseStrict(value);
    } catch (_) {
      // Try the next format.
    }
  }

  return DateTime.tryParse(value);
}

/// Splits "04 Nov 25 - 04 Dec 25" into its two meter read dates.
///
/// The separator is matched with surrounding whitespace so that dates which
/// themselves contain dashes ("04-Dec-2025") are not split apart.
({DateTime start, DateTime end})? _parseReadingPeriod(String? readingDate) {
  if (readingDate == null) return null;

  final parts = readingDate.split(RegExp(r'\s+-\s+'));
  if (parts.length != 2) return null;

  final start = _parseBillDate(parts[0]);
  final end = _parseBillDate(parts[1]);
  if (start == null || end == null || !end.isAfter(start)) return null;

  return (start: start, end: end);
}

double _parseAmount(String? raw) {
  if (raw == null || raw.trim().isEmpty) return 0;

  final isCredit = raw.toUpperCase().contains('CR') ||
      (raw.contains('(') && raw.contains(')'));

  final cleaned = raw
      .replaceAll(r'$', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('CR', '')
      .replaceAll(',', '')
      .trim();

  final value = double.tryParse(cleaned) ?? 0.0;
  return isCredit && value > 0 ? -value : value;
}

DateTime _dayOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

/// Adds a month, clamping to the last day when the target month is shorter.
DateTime _addOneMonth(DateTime value) {
  final year = value.month == 12 ? value.year + 1 : value.year;
  final month = value.month == 12 ? 1 : value.month + 1;
  final lastDayOfMonth = DateTime(year, month + 1, 0).day;
  return DateTime(year, month, value.day.clamp(1, lastDayOfMonth));
}

/// Sums daily rows, keeping the max per day.
///
/// Some backends return duplicate rows for a day; taking the max avoids double
/// counting. Mirrors the behaviour of the month-based dashboard provider.
({double totalKwh, int daysWithData}) _sumDailyRows(
  List<DailyUsageEntryDto> rows, {
  required DateTime start,
  required DateTime end,
}) {
  final byDay = <String, double>{};
  final startDay = _dayOnly(start);
  final endDay = _dayOnly(end);

  for (final row in rows) {
    final dateStr = row.usageDate.trim().split(RegExp('[T ]')).first;
    final parsed = DateTime.tryParse(dateStr);
    if (parsed == null) continue;

    final day = _dayOnly(parsed);
    if (day.isBefore(startDay) || day.isAfter(endDay)) continue;

    final previous = byDay[dateStr];
    if (previous == null || row.dailyUsageKwh > previous) {
      byDay[dateStr] = row.dailyUsageKwh;
    }
  }

  return (
    totalKwh: byDay.values.fold<double>(0, (sum, value) => sum + value),
    daysWithData: byDay.length,
  );
}

/// Bill numbers for the active account, oldest first.
///
/// Bills come from the transaction ledger; payments are filtered out the same
/// way `AccountLedgerWidget` does it.
final billNumbersProvider = FutureProvider<List<String>>((ref) async {
  final transactions = await ref.watch(transactionHistoryProvider.future);

  final billEntries = transactions.where((t) {
    final reference = t.referenceNumber;
    if (reference == null || reference.isEmpty) return false;
    return !(t.notes ?? '').toLowerCase().contains('payment');
  }).toList()
    ..sort((a, b) => a.paymentDate.compareTo(b.paymentDate));

  final numbers = <String>[];
  for (final entry in billEntries) {
    final number = entry.referenceNumber!;
    if (!numbers.contains(number)) numbers.add(number);
  }

  return numbers.length > _maxBillHistory
      ? numbers.sublist(numbers.length - _maxBillHistory)
      : numbers;
});

/// Closed billing periods built from the account's bills, oldest first.
///
/// Usage and amount come straight off the bill, so no AMI calls are needed for
/// the peak and average cards.
final closedBillingPeriodsProvider =
    FutureProvider<List<BillingPeriod>>((ref) async {
  final billNumbers = await ref.watch(billNumbersProvider.future);
  if (billNumbers.isEmpty) return const [];

  final details = await Future.wait(
    billNumbers.map((number) => ref.watch(billDetailProvider(number).future)),
  );

  final periods = <BillingPeriod>[];
  for (final bill in details) {
    if (bill == null) continue;

    final range = _parseReadingPeriod(bill.readingDate);
    if (range == null) continue;

    final usageKwh = _parseAmount(bill.totalConsumption);
    if (usageKwh <= 0) continue;

    periods.add(
      BillingPeriod(
        periodId: bill.billNumber,
        start: range.start,
        end: range.end,
        usageKwh: usageKwh,
        amount: _parseAmount(bill.amountDue),
        daysWithData: range.end.difference(range.start).inDays,
      ),
    );
  }

  periods.sort((a, b) => a.end.compareTo(b.end));
  return periods;
});

/// Billing period history plus the in-progress period, for the dashboard.
final billingPeriodsProvider =
    FutureProvider<BillingPeriodsResult>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) {
    return const BillingPeriodsResult.empty();
  }

  final closed = await ref.watch(closedBillingPeriodsProvider.future);
  if (closed.isEmpty) {
    return _calendarMonthFallback(ref, meterId);
  }

  final today = _dayOnly(DateTime.now());
  final newestBilled = closed.last;

  // The in-progress period opens on the newest bill's read date. Roll forward
  // in case that bill is more than one cycle old.
  var currentStart = newestBilled.end;
  var currentEnd = _addOneMonth(currentStart);
  var rolls = 0;
  while (currentEnd.isBefore(today) && rolls < _maxPeriodRollForward) {
    currentStart = currentEnd;
    currentEnd = _addOneMonth(currentEnd);
    rolls++;
  }

  final currentUsageStart = DateTime(
    currentStart.year,
    currentStart.month,
    currentStart.day + 1,
  );

  // Nothing to show yet if the new cycle has not started.
  if (currentUsageStart.isAfter(today)) {
    return BillingPeriodsResult(periods: closed);
  }

  final currentDaily = await ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: currentUsageStart,
      endDate: today,
    )).future,
  );

  final currentTotals = _sumDailyRows(
    currentDaily,
    start: currentUsageStart,
    end: today,
  );

  // Compare against the same number of elapsed days in the previous period, so
  // a part period is never measured against a full one.
  final elapsedDays = today.difference(currentUsageStart).inDays + 1;
  final previousToDateEnd = newestBilled.usageStart.add(
    Duration(days: elapsedDays - 1),
  );
  final clampedPreviousEnd = previousToDateEnd.isAfter(newestBilled.usageEnd)
      ? newestBilled.usageEnd
      : previousToDateEnd;

  final previousDaily = await ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: newestBilled.usageStart,
      endDate: clampedPreviousEnd,
    )).future,
  );

  final previousToDate = _sumDailyRows(
    previousDaily,
    start: newestBilled.usageStart,
    end: clampedPreviousEnd,
  );

  final currentPeriod = BillingPeriod(
    periodId: DateFormat('yyyy-MM').format(currentEnd),
    start: currentStart,
    end: currentEnd,
    usageKwh: currentTotals.totalKwh,
    daysWithData: currentTotals.daysWithData,
    isCurrent: true,
    isComplete: false,
  );

  return BillingPeriodsResult(
    periods: [...closed, currentPeriod],
    currentPeriodDaily: currentDaily,
    // Fall back to the previous period's full total when AMI has no history for
    // it, so the comparison card still shows something meaningful.
    previousPeriodToDateKwh: previousToDate.daysWithData > 0
        ? previousToDate.totalKwh
        : newestBilled.usageKwh,
  );
});

/// Fallback for accounts with no parseable bills: treat calendar months as
/// periods, which is what the dashboard did before this change.
Future<BillingPeriodsResult> _calendarMonthFallback(Ref ref, int meterId) async {
  final monthlyTotals = await ref.watch(amiDashboardMonthlyTotalsProvider.future);
  final now = DateTime.now();
  final today = _dayOnly(now);

  final periods = <BillingPeriod>[];
  for (final month in monthlyTotals) {
    if (month.month < 1 || month.month > 12) continue;
    if (month.monthlyUsageKwh <= 0) continue;

    final isCurrentMonth = month.year == now.year && month.month == now.month;
    final monthEnd = DateTime(month.year, month.month + 1, 0);

    periods.add(
      BillingPeriod(
        // Day 0 of the month is the last day of the previous one, which keeps
        // the exclusive-start convention used for bill-derived periods.
        periodId: '${month.year}-${month.month.toString().padLeft(2, '0')}',
        start: DateTime(month.year, month.month, 0),
        end: monthEnd,
        usageKwh: month.monthlyUsageKwh,
        daysWithData: isCurrentMonth ? now.day : monthEnd.day,
        isCurrent: isCurrentMonth,
        isComplete: !isCurrentMonth,
      ),
    );
  }

  periods.sort((a, b) => a.end.compareTo(b.end));

  final monthStart = DateTime(now.year, now.month, 1);
  final currentDaily = await ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: monthStart,
      endDate: today,
    )).future,
  );

  final previousMonthStart = DateTime(now.year, now.month - 1, 1);
  final previousMonthEnd = DateTime(now.year, now.month - 1, now.day);
  final previousDaily = await ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: previousMonthStart,
      endDate: previousMonthEnd,
    )).future,
  );

  return BillingPeriodsResult(
    periods: periods,
    currentPeriodDaily: currentDaily,
    previousPeriodToDateKwh: _sumDailyRows(
      previousDaily,
      start: previousMonthStart,
      end: previousMonthEnd,
    ).totalKwh,
  );
}

/// Gate for the dashboard usage section.
final hasBillingPeriodUsageProvider = FutureProvider<bool>((ref) async {
  final result = await ref.watch(billingPeriodsProvider.future);
  return result.hasUsageData;
});
