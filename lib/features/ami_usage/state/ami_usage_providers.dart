import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/api_response_dtos.dart';
import '../../../data/repositories/ami_usage_repository.dart';

/// Repository provider
final amiUsageRepositoryProvider = Provider<AmiUsageRepository>((ref) => const AmiUsageRepository());

/// Daily intervals provider - fetches interval data for a specific date
/// Used for daily filter view
final amiDailyIntervalsProvider = FutureProvider.family<List<IntervalUsageEntryDto>, ({int meterId, DateTime targetDate})>((ref, params) async {
  final targetDateStr = params.targetDate.toIso8601String().split('T')[0];
  print('[AmiUsage] amiDailyIntervalsProvider fetching for meterId=${params.meterId} targetDate=$targetDateStr');
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchDailyIntervals(
    meterId: params.meterId,
    targetDate: params.targetDate,
  );
  
  print('[AmiUsage] amiDailyIntervalsProvider loaded ${result.length} interval entries');
  return result;
});

/// Daily range provider - fetches daily usage for a date range
/// Used for weekly and monthly filter views
final amiDailyRangeProvider = FutureProvider.family<List<DailyUsageEntryDto>, ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final startDateStr = params.startDate.toIso8601String().split('T')[0];
  final endDateStr = params.endDate.toIso8601String().split('T')[0];
  print('[AmiUsage] amiDailyRangeProvider fetching for meterId=${params.meterId} startDate=$startDateStr endDate=$endDateStr');
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchDailyRange(
    meterId: params.meterId,
    startDate: params.startDate,
    endDate: params.endDate,
  );
  
  print('[AmiUsage] amiDailyRangeProvider loaded ${result.length} daily entries');
  return result;
});

/// Monthly totals provider - fetches monthly totals for a year
/// Used for year filter view
final amiMonthlyTotalsProvider = FutureProvider.family<List<MonthlyUsageEntryDto>, ({int meterId, int year})>((ref, params) async {
  print('[AmiUsage] amiMonthlyTotalsProvider fetching for meterId=${params.meterId} year=${params.year}');
  
  final repository = ref.watch(amiUsageRepositoryProvider);
  final result = await repository.fetchMonthlyTotals(
    meterId: params.meterId,
    year: params.year,
  );
  
  print('[AmiUsage] amiMonthlyTotalsProvider loaded ${result.length} monthly entries');
  return result;
});
