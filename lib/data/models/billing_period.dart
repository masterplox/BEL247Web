/// Billing period models used by the dashboard.
///
/// The shape deliberately mirrors the planned `/V1/MeterUsage/BillingPeriods`
/// endpoint (`BillingPeriodUsage` / `BillingPeriodsResult` server side) so that
/// replacing the temporary bill-derived implementation with the real API only
/// touches the repository/provider layer, not these models or the widgets.
library;

import 'package:intl/intl.dart';

import 'api_response_dtos.dart';

/// One billing period and its usage.
class BillingPeriod {
  const BillingPeriod({
    required this.periodId,
    required this.start,
    required this.end,
    required this.usageKwh,
    this.amount,
    this.daysWithData = 0,
    this.isCurrent = false,
    this.isComplete = true,
  });

  /// Bill number when the period came from a bill, otherwise `yyyy-MM`.
  final String periodId;

  /// Meter read date that opened the period. This matches the date printed on
  /// the bill; usage is counted from the day *after* it, since the reading on
  /// this date already belongs to the previous period.
  final DateTime start;

  /// Meter read date that closed the period. For the in-progress period this is
  /// the projected next read date, not today.
  final DateTime end;

  final double usageKwh;

  /// Billed amount. Null while the period is still open.
  final double? amount;

  /// Days that actually have meter reads.
  final int daysWithData;

  /// True for the single in-progress period.
  final bool isCurrent;

  /// True once the period is closed and billed.
  final bool isComplete;

  static final DateFormat _dayFormat = DateFormat('MMM d');

  /// Billed days in the period.
  int get days => end.difference(start).inDays;

  /// Display label, e.g. "Nov 4 - Dec 4".
  String get label => '${_dayFormat.format(start)} - ${_dayFormat.format(end)}';

  /// Average over days that have data, so the in-progress period is not diluted
  /// by days that have not happened yet.
  double get avgDailyKwh => daysWithData == 0 ? 0 : usageKwh / daysWithData;

  /// First day whose usage belongs to this period.
  DateTime get usageStart => DateTime(start.year, start.month, start.day + 1);

  /// Last day whose usage belongs to this period.
  DateTime get usageEnd => DateTime(end.year, end.month, end.day);

  BillingPeriod copyWith({
    double? usageKwh,
    double? amount,
    int? daysWithData,
    bool? isCurrent,
    bool? isComplete,
  }) =>
      BillingPeriod(
        periodId: periodId,
        start: start,
        end: end,
        usageKwh: usageKwh ?? this.usageKwh,
        amount: amount ?? this.amount,
        daysWithData: daysWithData ?? this.daysWithData,
        isCurrent: isCurrent ?? this.isCurrent,
        isComplete: isComplete ?? this.isComplete,
      );
}

/// Period history plus the in-progress period's daily usage.
class BillingPeriodsResult {
  const BillingPeriodsResult({
    this.periods = const [],
    this.currentPeriodDaily = const [],
    this.previousPeriodToDateKwh = 0,
  });

  const BillingPeriodsResult.empty() : this();

  /// Oldest to newest. The in-progress period, when present, is last.
  final List<BillingPeriod> periods;

  /// Daily rows inside the in-progress period.
  final List<DailyUsageEntryDto> currentPeriodDaily;

  /// The previous period's usage over the same number of elapsed days as the
  /// in-progress period, so the comparison card measures like for like instead
  /// of pitting a part period against a full one.
  final double previousPeriodToDateKwh;

  /// The period we are currently inside.
  BillingPeriod? get current {
    for (final p in periods) {
      if (p.isCurrent) return p;
    }
    return periods.isEmpty ? null : periods.last;
  }

  /// The period immediately before [current].
  BillingPeriod? get previous {
    final c = current;
    if (c == null) return null;
    final index = periods.indexOf(c);
    return index > 0 ? periods[index - 1] : null;
  }

  /// Closed periods only. Peak, average and totals use these so the partial
  /// in-progress period can never skew them.
  List<BillingPeriod> get closedPeriods =>
      periods.where((p) => p.isComplete && p.usageKwh > 0).toList();

  BillingPeriod? get peak {
    final closed = closedPeriods;
    if (closed.isEmpty) return null;
    return closed.reduce((a, b) => a.usageKwh > b.usageKwh ? a : b);
  }

  /// Positive means the customer used less than at the same point last period.
  double get diffVsPreviousKwh =>
      previousPeriodToDateKwh - (current?.usageKwh ?? 0);

  bool get savedEnergy => diffVsPreviousKwh > 0;

  double get totalKwh =>
      closedPeriods.fold<double>(0, (sum, p) => sum + p.usageKwh);

  double get totalAmount =>
      closedPeriods.fold<double>(0, (sum, p) => sum + (p.amount ?? 0));

  int get periodsAnalyzed => closedPeriods.length;

  double get avgPeriodKwh =>
      periodsAnalyzed == 0 ? 0 : totalKwh / periodsAnalyzed;

  DateTime? get scopeStart =>
      closedPeriods.isEmpty ? null : closedPeriods.first.start;

  DateTime? get scopeEnd =>
      closedPeriods.isEmpty ? null : closedPeriods.last.end;

  bool get hasUsageData =>
      (current?.daysWithData ?? 0) > 0 || periodsAnalyzed > 0;
}
