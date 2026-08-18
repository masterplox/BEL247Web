import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/ami_bucket_parser.dart';
import '../../../data/models/ami_data.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/repositories/ami_usage_repository.dart';

/// Repository provider
final amiUsageRepositoryProvider = Provider<AmiUsageRepository>((ref) => const AmiUsageRepository());

/// Daily intervals provider - fetches interval data for a specific date
/// Used for daily filter view
final amiDailyIntervalsProvider = FutureProvider.family<List<IntervalUsageEntryDto>, ({int meterId, DateTime targetDate})>((ref, params) async {
  final targetDateStr = params.targetDate.toIso8601String().split('T')[0];
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchDailyIntervals(
    meterId: params.meterId,
    targetDate: params.targetDate,
  );
  
  return result;
});

/// Daily range provider - fetches daily usage for a date range
/// Used for weekly and monthly filter views (chart + TOU from the same call)
final amiDailyRangeRowsProvider = FutureProvider.family<
    DailyRangeResult,
    ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchDailyRange(
    meterId: params.meterId,
    startDate: params.startDate,
    endDate: params.endDate,
  );
});

/// Same DailyRangeBucket payload as [amiDailyRangeRowsProvider], mapped to DTOs.
final amiDailyRangeProvider = FutureProvider.family<
    List<DailyUsageEntryDto>,
    ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final result = await ref.watch(amiDailyRangeRowsProvider(params).future);
  return result.days.map((row) => row.toDto()).toList();
});

/// Monthly totals provider - fetches monthly totals for a year
/// Used for year filter view
final amiMonthlyTotalsResultProvider = FutureProvider.family<
    MonthlyTotalsResult,
    ({int meterId, int year})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchMonthlyTotals(
    meterId: params.meterId,
    year: params.year,
  );
});

final amiMonthlyTotalsProvider = FutureProvider.family<
    List<MonthlyBucketRow>,
    ({int meterId, int year})>((ref, params) async {
  final result = await ref.watch(amiMonthlyTotalsResultProvider(params).future);
  return result.months;
});

List<DayTou> dayTouFromMonthlyRows(List<MonthlyBucketRow> rows) => [
      for (final row in rows)
        if (row.offPeakKwh + row.peakKwh + row.midPeakKwh > 0)
          (
            date: DateTime(row.year, row.month, 1),
            offKwh: row.offPeakKwh,
            peakKwh: row.peakKwh,
            midPeakKwh: row.midPeakKwh,
          ),
    ];

TouConsumption touTotalFromMonthlyRows(List<MonthlyBucketRow> rows) {
  var off = 0.0, peak = 0.0, mid = 0.0;
  for (final row in rows) {
    off += row.offPeakKwh;
    peak += row.peakKwh;
    mid += row.midPeakKwh;
  }
  return TouConsumption(
    offPeakKwh: off,
    peakKwh: peak,
    midPeakKwh: mid,
  );
}

/// Per-day TOU: (date, offKwh, peakKwh, midPeakKwh)
typedef DayTou = ({DateTime date, double offKwh, double peakKwh, double midPeakKwh});

List<DayTou> dayTouFromDailyRows(List<DailyBucketRow> rows) {
  final result = <DayTou>[];
  for (final row in rows) {
    final date = _usageDateOnly(row.usageDate);
    if (date == null) continue;
    if (row.offPeakKwh + row.peakKwh + row.midPeakKwh <= 0) continue;
    result.add((
      date: date,
      offKwh: row.offPeakKwh,
      peakKwh: row.peakKwh,
      midPeakKwh: row.midPeakKwh,
    ));
  }
  return result;
}

TouConsumption touTotalFromDailyRows(List<DailyBucketRow> rows) {
  var off = 0.0, peak = 0.0, mid = 0.0;
  for (final row in rows) {
    off += row.offPeakKwh;
    peak += row.peakKwh;
    mid += row.midPeakKwh;
  }
  return TouConsumption(
    offPeakKwh: off,
    peakKwh: peak,
    midPeakKwh: mid,
  );
}

DateTime? _usageDateOnly(String raw) {
  final dateStr = raw.trim().split(RegExp('[T ]')).first;
  final parsed = DateTime.tryParse(dateStr);
  if (parsed == null || parsed.year < 1900) return null;
  return DateTime(parsed.year, parsed.month, parsed.day);
}

/// TOU for week/month from DailyRangeBucket (same call as the daily chart).
final amiTouRangeDataProvider = FutureProvider.family<
    ({TouConsumption total, List<DayTou> perDay}),
    ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final result = await ref.watch(amiDailyRangeRowsProvider(params).future);
  return (
    total: touTotalFromDailyRows(result.days),
    perDay: dayTouFromDailyRows(result.days),
  );
});
