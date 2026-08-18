import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' show accountSwitcherProvider;
import '../../../data/models/ami_data.dart' show ratePerKwh;
import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/usage_dashboard_cards.dart';
import '../../ami_usage/state/ami_usage_providers.dart';

/// Parse the active account meter number into an AMI meterId (int).
///
/// Returns null if no active account or meter number is not numeric.
final amiDashboardMeterIdProvider = Provider<int?>((ref) {
  final meterNumber = ref.watch(accountSwitcherProvider).activeAccount?.meterNumber;
  if (meterNumber == null) return null;
  final digitsOnly = meterNumber.replaceAll(RegExp(r'\D'), '');
  return int.tryParse(digitsOnly);
});

/// Four billing-period dashboard cards from `/AMI/UsageDashboardCards`.
final usageDashboardCardsProvider =
    FutureProvider<UsageDashboardCardsResult>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) {
    return const UsageDashboardCardsResult.empty();
  }

  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchUsageDashboardCards(meterId: meterId);
});

/// Fetch AMI daily data for the current month (month-to-date).
final amiDashboardCurrentMonthDailyProvider = FutureProvider<List<DailyUsageEntryDto>>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) return [];

  final now = DateTime.now();
  final start = DateTime(now.year, now.month, 1);
  // Month-to-date: limit end to "today" to avoid requesting future days.
  final end = DateTime(now.year, now.month, now.day);

  return ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: start,
      endDate: end,
    )).future,
  );
});

/// AMI daily data for the current month, but only up to *yesterday*.
///
/// This is used for the dashboard "month" trend view so we don't show a partial
/// in-progress current-day value (which can vary by data latency).
final amiDashboardCurrentMonthDailyUpToYesterdayProvider =
    FutureProvider<List<DailyUsageEntryDto>>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) return [];

  final now = DateTime.now();
  final start = DateTime(now.year, now.month, 1);
  final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));

  // If it's the 1st of the month, there's no "month-to-yesterday" data.
  if (yesterday.isBefore(start)) return [];

  return ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: start,
      endDate: yesterday,
    )).future,
  );
});

/// Fetch AMI daily data for the previous month (full month range).
final amiDashboardPreviousMonthDailyProvider = FutureProvider<List<DailyUsageEntryDto>>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) return [];

  final now = DateTime.now();
  final prevMonth = DateTime(now.year, now.month - 1, 1);
  final start = DateTime(prevMonth.year, prevMonth.month, 1);
  final end = DateTime(prevMonth.year, prevMonth.month + 1, 0);

  return ref.watch(
    amiDailyRangeProvider((
      meterId: meterId,
      startDate: start,
      endDate: end,
    )).future,
  );
});

/// Fetch AMI monthly totals for the current year (for trailing-month trend + peak month + averages).
final amiDashboardMonthlyTotalsProvider = FutureProvider<List<MonthlyUsageEntryDto>>((ref) async {
  final meterId = ref.watch(amiDashboardMeterIdProvider);
  if (meterId == null || meterId == 0) return [];

  final year = DateTime.now().year;
  final rows = await ref.watch(
    amiMonthlyTotalsProvider((meterId: meterId, year: year)).future,
  );
  return rows.map((row) => row.toDto()).toList();
});

/// Combined dashboard stats for AMI meters (mirrors the legacy monthly widget intent).
final amiDashboardUsageStatsProvider = FutureProvider<
    ({
      double thisMonthKwh,
      double thisMonthEstimatedCost,
      int thisMonthDaysWithData,
      double lastMonthKwh,
      double diffVsLastMonthKwh,
      bool savedEnergy,
      String peakMonthLabel,
      double peakMonthKwh,
      double avgMonthlyKwh,
      double yearlyTotalKwh,
      double yearlyEstimatedCost,
      int monthsAnalyzed,
    })>((ref) async {
  Map<String, double> normalizeDailyByDay(
    List<DailyUsageEntryDto> rows, {
    required DateTime start,
    required DateTime end,
  }) {
    // Some backends can return duplicate rows for a day; we keep the max for that day
    // to avoid double-counting.
    final byDay = <String, double>{};

    final startDay = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    for (final r in rows) {
      final dateStr = r.usageDate.trim().split(RegExp('[T ]')).first;
      final d = DateTime.tryParse(dateStr);
      if (d == null) continue;
      final day = DateTime(d.year, d.month, d.day);
      if (day.isBefore(startDay) || day.isAfter(endDay)) continue;

      final prev = byDay[dateStr];
      if (prev == null || r.dailyUsageKwh > prev) {
        byDay[dateStr] = r.dailyUsageKwh;
      }
    }

    return byDay;
  }

  double sumMapValues(Map<String, double> m) =>
      m.values.fold<double>(0, (sum, v) => sum + v);

  final dailyThisMonth = await ref.watch(amiDashboardCurrentMonthDailyProvider.future);
  final dailyLastMonth = await ref.watch(amiDashboardPreviousMonthDailyProvider.future);
  final monthlyTotals = await ref.watch(amiDashboardMonthlyTotalsProvider.future);

  final now = DateTime.now();
  final thisMonthStart = DateTime(now.year, now.month, 1);
  final thisMonthEnd = DateTime(now.year, now.month, now.day);
  final prevMonth = DateTime(now.year, now.month - 1, 1);
  final lastMonthStart = DateTime(prevMonth.year, prevMonth.month, 1);
  final lastMonthEnd = DateTime(prevMonth.year, prevMonth.month + 1, 0);

  final thisMonthByDay = normalizeDailyByDay(
    dailyThisMonth,
    start: thisMonthStart,
    end: thisMonthEnd,
  );
  final lastMonthByDay = normalizeDailyByDay(
    dailyLastMonth,
    start: lastMonthStart,
    end: lastMonthEnd,
  );

  final thisMonthKwh = sumMapValues(thisMonthByDay);

  // Prefer the authoritative monthly total for last month when available.
  // This also keeps the "Month Comparison" dialog consistent with the dashboard trend chart
  // (which uses `amiMonthlyTotals`).
  final lastMonthFromMonthlyTotals = monthlyTotals
      .where((m) => m.year == prevMonth.year && m.month == prevMonth.month)
      .map((m) => m.monthlyUsageKwh)
      .cast<double?>()
      .firstWhere((v) => v != null, orElse: () => null);

  final lastMonthKwh = (lastMonthFromMonthlyTotals != null && lastMonthFromMonthlyTotals > 0)
      ? lastMonthFromMonthlyTotals
      : sumMapValues(lastMonthByDay);

  final diff = lastMonthKwh - thisMonthKwh;
  final savedEnergy = diff > 0;

  // Monthly totals: normalize to 12 months (some APIs return only months with data).
  final usableMonthly = monthlyTotals.where((m) => m.month >= 1 && m.month <= 12).toList();
  final monthsWithUsage = usableMonthly.where((m) => m.monthlyUsageKwh > 0).toList();

  const monthNames = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String peakMonthLabel = '-';
  double peakMonthKwh = 0;
  if (monthsWithUsage.isNotEmpty) {
    final peak = monthsWithUsage.reduce((a, b) => a.monthlyUsageKwh > b.monthlyUsageKwh ? a : b);
    peakMonthKwh = peak.monthlyUsageKwh;
    peakMonthLabel = monthNames[(peak.month - 1).clamp(0, 11)];
  }

  final yearlyTotalKwh = monthsWithUsage.fold<double>(0, (sum, m) => sum + m.monthlyUsageKwh);
  final monthsAnalyzed = monthsWithUsage.length;
  final avgMonthlyKwh = monthsAnalyzed == 0 ? 0 : (yearlyTotalKwh / monthsAnalyzed);

  return (
    thisMonthKwh: double.parse(thisMonthKwh.toStringAsFixed(2)),
    thisMonthEstimatedCost: double.parse((thisMonthKwh * ratePerKwh).toStringAsFixed(2)),
    thisMonthDaysWithData: thisMonthByDay.length,
    lastMonthKwh: double.parse(lastMonthKwh.toStringAsFixed(2)),
    diffVsLastMonthKwh: double.parse(diff.toStringAsFixed(2)),
    savedEnergy: savedEnergy,
    peakMonthLabel: peakMonthLabel,
    peakMonthKwh: double.parse(peakMonthKwh.toStringAsFixed(2)),
    avgMonthlyKwh: double.parse(avgMonthlyKwh.toStringAsFixed(2)),
    yearlyTotalKwh: double.parse(yearlyTotalKwh.toStringAsFixed(2)),
    yearlyEstimatedCost: double.parse((yearlyTotalKwh * ratePerKwh).toStringAsFixed(2)),
    monthsAnalyzed: monthsAnalyzed,
  );
});

/// Basic "has data" flag for dashboard gating.
final amiDashboardHasUsageDataProvider = FutureProvider<bool>((ref) async {
  final stats = await ref.watch(amiDashboardUsageStatsProvider.future);
  return stats.thisMonthDaysWithData > 0 || stats.monthsAnalyzed > 0;
});

