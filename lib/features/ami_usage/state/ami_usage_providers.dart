import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/api_response_dtos.dart';
import '../../../data/repositories/ami_usage_repository.dart';

/// Repository provider
final amiUsageRepositoryProvider = Provider<AmiUsageRepository>((ref) => const AmiUsageRepository());

/// Daily intervals provider - fetches interval data for a specific date
/// Used for daily filter view
final amiDailyIntervalsProvider = FutureProvider.family<List<IntervalUsageEntryDto>, ({int meterId, DateTime targetDate})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchDailyIntervals(
    meterId: params.meterId,
    targetDate: params.targetDate,
  );
});

/// Daily range provider - fetches daily usage for a date range
/// Used for weekly and monthly filter views
final amiDailyRangeProvider = FutureProvider.family<List<DailyUsageEntryDto>, ({int meterId, DateTime startDate, DateTime endDate})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchDailyRange(
    meterId: params.meterId,
    startDate: params.startDate,
    endDate: params.endDate,
  );
});

/// Monthly totals provider - fetches monthly totals for a year
/// Used for year filter view
final amiMonthlyTotalsProvider = FutureProvider.family<List<MonthlyUsageEntryDto>, ({int meterId, int year})>((ref, params) async {
  final repository = ref.watch(amiUsageRepositoryProvider);
  return repository.fetchMonthlyTotals(
    meterId: params.meterId,
    year: params.year,
  );
});
