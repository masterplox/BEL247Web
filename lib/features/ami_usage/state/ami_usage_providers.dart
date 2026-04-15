import 'package:flutter_riverpod/flutter_riverpod.dart';

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
/// Used for weekly and monthly filter views
final amiDailyRangeProvider = FutureProvider.family<List<DailyUsageEntryDto>, ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final startDateStr = params.startDate.toIso8601String().split('T')[0];
  final endDateStr = params.endDate.toIso8601String().split('T')[0];
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchDailyRange(
    meterId: params.meterId,
    startDate: params.startDate,
    endDate: params.endDate,
  );
  
  return result;
});

/// Monthly totals provider - fetches monthly totals for a year
/// Used for year filter view
final amiMonthlyTotalsProvider = FutureProvider.family<List<MonthlyUsageEntryDto>, ({int meterId, int year})>((ref, params) async {
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchMonthlyTotals(
    meterId: params.meterId,
    year: params.year,
  );
  
  return result;
});

/// Per-day TOU: (date, offKwh, peakKwh, midPeakKwh)
typedef DayTou = ({DateTime date, double offKwh, double peakKwh, double midPeakKwh});

/// TOU consumption for a date range (total + per-day for stacked chart).
/// Fetches interval data for each day in range and aggregates by time-of-use.
final amiTouRangeDataProvider = FutureProvider.family<
    ({TouConsumption total, List<DayTou> perDay}),
    ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  final intervals = await repository.fetchIntervalsForRange(
    meterId: params.meterId,
    startDate: params.startDate,
    endDate: params.endDate,
  );

  // Group by date (year-month-day), then for each date collect (hour, kwh) and compute TOU
  final byDate = <String, List<(int hour, double kwh)>>{};
  for (final dto in intervals) {
    try {
      final dtStr = dto.intervalDateTime.replaceAll(' ', 'T');
      final dt = DateTime.parse(dtStr);
      final key = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
      byDate.putIfAbsent(key, () => []).add((dt.hour, dto.kWh));
    } catch (_) {}
  }

  final sortedKeys = byDate.keys.toList()..sort();
  final perDay = <DayTou>[];
  double totalOff = 0, totalPeak = 0, totalMid = 0;
  for (final key in sortedKeys) {
    final pairs = byDate[key]!;
    final tou = computeTouFromHourKwh(pairs);
    totalOff += tou.offPeakKwh;
    totalPeak += tou.peakKwh;
    totalMid += tou.midPeakKwh;
    final parts = key.split('-');
    final date = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    perDay.add((
      date: date,
      offKwh: tou.offPeakKwh,
      peakKwh: tou.peakKwh,
      midPeakKwh: tou.midPeakKwh,
    ));
  }

  return (
    total: TouConsumption(offPeakKwh: totalOff, peakKwh: totalPeak, midPeakKwh: totalMid),
    perDay: perDay,
  );
});
