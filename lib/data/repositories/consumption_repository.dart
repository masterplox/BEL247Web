import '../models/consumption.dart';
import 'base_repository.dart';
import '../../core/utils/error_handler.dart';

/// Abstract interface for consumption data operations
abstract class ConsumptionRepository extends BaseRepository {
  /// Get daily consumption data for a specific date
  Future<ApiResponse<DailyConsumption>> getDailyConsumption(String userId, DateTime date);

  /// Get daily consumption data for a date range
  Future<ApiResponse<List<DailyConsumption>>> getDailyConsumptionRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get monthly consumption data for a specific month
  Future<ApiResponse<MonthlyConsumption>> getMonthlyConsumption(String userId, String month);

  /// Get monthly consumption data for a year
  Future<ApiResponse<List<MonthlyConsumption>>> getYearlyConsumption(String userId, int year);

  /// Get consumption statistics
  Future<ApiResponse<UsageStatistics>> getUsageStatistics(String userId);

  /// Get hourly consumption for a specific date
  Future<ApiResponse<List<HourlyConsumption>>> getHourlyConsumption(String userId, DateTime date);

  /// Get consumption trends
  Future<ApiResponse<List<DailyConsumption>>> getConsumptionTrends(
    String userId,
    int days,
  );

  /// Get peak usage data
  Future<ApiResponse<DailyConsumption>> getPeakUsage(String userId, DateTime date);

  /// Get consumption comparison (current vs previous period)
  Future<ApiResponse<Map<String, dynamic>>> getConsumptionComparison(
    String userId,
    DateTime currentStart,
    DateTime currentEnd,
    DateTime previousStart,
    DateTime previousEnd,
  );

  /// Get seasonal consumption data
  Future<ApiResponse<SeasonalTrends>> getSeasonalTrends(String userId);

  /// Get consumption alerts (high usage, etc.)
  Future<ApiResponse<List<Map<String, dynamic>>>> getConsumptionAlerts(String userId);
}
