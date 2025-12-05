import '../../../core/utils/error_handler.dart';
import '../../../core/utils/logger.dart';
import '../../models/consumption.dart';
import '../../repositories/consumption_repository.dart';
import 'data_loader.dart';

/// Mock implementation of ConsumptionRepository using local JSON data
class MockConsumptionRepository implements ConsumptionRepository {
  static const String _consumptionDataPath = 'assets/data/mock_consumption.json';

  @override
  Future<ApiResponse<DailyConsumption>> getDailyConsumption(String userId, DateTime date) async {
    try {
      Logger.info('MockConsumptionRepository: Getting daily consumption for user: $userId, date: $date');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final List<dynamic> dailyData = consumptionData['dailyConsumption'] as List<dynamic>;
      
      // Find consumption data for the requested date
      final dailyConsumptionJson = dailyData.firstWhere(
        (item) => DateTime.parse(item['date']).year == date.year &&
                  DateTime.parse(item['date']).month == date.month &&
                  DateTime.parse(item['date']).day == date.day,
        orElse: () => throw Exception('No consumption data found for date: $date'),
      );
      
      final dailyConsumption = DailyConsumption.fromJson(dailyConsumptionJson);
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved daily consumption: ${dailyConsumption.totalKwh} kWh');
      return ApiResponse.success(dailyConsumption);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get daily consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve daily consumption: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<DailyConsumption>>> getDailyConsumptionRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      Logger.info('MockConsumptionRepository: Getting daily consumption range for user: $userId');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final List<dynamic> dailyData = consumptionData['dailyConsumption'] as List<dynamic>;
      
      final consumptionList = dailyData
          .where((item) {
            final itemDate = DateTime.parse(item['date']);
            return itemDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
                   itemDate.isBefore(endDate.add(const Duration(days: 1)));
          })
          .map((item) => DailyConsumption.fromJson(item))
          .toList();
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved ${consumptionList.length} days of consumption data');
      return ApiResponse.success(consumptionList);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get daily consumption range', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve daily consumption range: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<MonthlyConsumption>> getMonthlyConsumption(String userId, String month) async {
    try {
      Logger.info('MockConsumptionRepository: Getting monthly consumption for user: $userId, month: $month');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final Map<String, dynamic> monthlyDataByYear = consumptionData['monthlyConsumption'] as Map<String, dynamic>;

      final year = month.split('-').first;

      if (monthlyDataByYear.containsKey(year)) {
        final List<dynamic> yearData = monthlyDataByYear[year] as List<dynamic>;
        final monthlyConsumptionJson = yearData.firstWhere(
          (item) => item['month'] == month,
          orElse: () => throw Exception('No consumption data found for month: $month'),
        );
        final monthlyConsumption = MonthlyConsumption.fromJson(monthlyConsumptionJson as Map<String, dynamic>);
        Logger.info('MockConsumptionRepository: Successfully retrieved monthly consumption: ${monthlyConsumption.totalKwh} kWh');
        return ApiResponse.success(monthlyConsumption);
      } else {
        throw Exception('No consumption data found for year: $year');
      }
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get monthly consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve monthly consumption: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<MonthlyConsumption>>> getYearlyConsumption(String userId, int year) async {
    try {
      Logger.info('MockConsumptionRepository: Getting yearly consumption for user: $userId, year: $year');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final Map<String, dynamic> monthlyDataByYear = consumptionData['monthlyConsumption'] as Map<String, dynamic>;

      final String yearString = year.toString();
      if (monthlyDataByYear.containsKey(yearString)) {
        final List<dynamic> monthlyData = monthlyDataByYear[yearString] as List<dynamic>;
        final monthlyConsumptionList =
            monthlyData.map((item) => MonthlyConsumption.fromJson(item as Map<String, dynamic>)).toList();

        Logger.info('MockConsumptionRepository: Successfully retrieved ${monthlyConsumptionList.length} months of consumption data');
        return ApiResponse.success(monthlyConsumptionList);
      } else {
        Logger.info('MockConsumptionRepository: No monthly consumption data found for year $year');
        return ApiResponse.success([]); // Return empty list if no data for the year
      }
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get yearly consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve yearly consumption: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<UsageStatistics>> getUsageStatistics(String userId) async {
    try {
      Logger.info('MockConsumptionRepository: Getting usage statistics for user: $userId');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final Map<String, dynamic> statisticsData = consumptionData['usageStatistics'] as Map<String, dynamic>;
      
      final usageStatistics = UsageStatistics.fromJson(statisticsData);
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved usage statistics');
      return ApiResponse.success(usageStatistics);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get usage statistics', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve usage statistics: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<HourlyConsumption>>> getHourlyConsumption(String userId, DateTime date) async {
    try {
      Logger.info('MockConsumptionRepository: Getting hourly consumption for user: $userId, date: $date');
      
      final dailyApiResponse = await getDailyConsumption(userId, date);
      if (!dailyApiResponse.success) {
        return ApiResponse.error(dailyApiResponse.error ?? 'Failed to get daily consumption');
      }
      
      final dailyConsumption = dailyApiResponse.data!;
      
      Logger.info('MockConsumptionRepository: Successfully retrieved ${dailyConsumption.hourlyBreakdown.length} hours of consumption data');
      return ApiResponse.success(dailyConsumption.hourlyBreakdown);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get hourly consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve hourly consumption: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<DailyConsumption>>> getConsumptionTrends(String userId, int days) async {
    try {
      Logger.info('MockConsumptionRepository: Getting consumption trends for user: $userId, days: $days');
      
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: days));
      
      final result = await getDailyConsumptionRange(userId, startDate, endDate);
      if (!result.success) {
        return ApiResponse.error(result.error ?? 'Failed to get consumption trends');
      }
      
      final consumptionList = result.data!;
      
      Logger.info('MockConsumptionRepository: Successfully retrieved consumption trends for $days days');
      return ApiResponse.success(consumptionList);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get consumption trends', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve consumption trends: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<DailyConsumption>> getPeakUsage(String userId, DateTime date) async {
    try {
      Logger.info('MockConsumptionRepository: Getting peak usage for user: $userId, date: $date');
      
      final dailyApiResponse = await getDailyConsumption(userId, date);
      if (!dailyApiResponse.success) {
        return ApiResponse.error(dailyApiResponse.error ?? 'Failed to get daily consumption');
      }
      
      final dailyConsumption = dailyApiResponse.data!;
      
      Logger.info('MockConsumptionRepository: Successfully retrieved peak usage: ${dailyConsumption.totalKwh} kWh');
      return ApiResponse.success(dailyConsumption);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get peak usage', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve peak usage: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> getConsumptionComparison(
    String userId,
    DateTime currentStart,
    DateTime currentEnd,
    DateTime previousStart,
    DateTime previousEnd,
  ) async {
    try {
      Logger.info('MockConsumptionRepository: Getting consumption comparison for user: $userId');
      
      final currentApiResponse = await getDailyConsumptionRange(userId, currentStart, currentEnd);
      final previousApiResponse = await getDailyConsumptionRange(userId, previousStart, previousEnd);
      
      if (!currentApiResponse.success) return ApiResponse.error(currentApiResponse.error ?? 'Failed to get current consumption');
      if (!previousApiResponse.success) return ApiResponse.error(previousApiResponse.error ?? 'Failed to get previous consumption');
      
      final currentConsumption = currentApiResponse.data!;
      final previousConsumption = previousApiResponse.data!;
      
        final currentTotal = currentConsumption.fold<double>(0, (sum, day) => sum + day.totalKwh);
        final previousTotal = previousConsumption.fold<double>(0, (sum, day) => sum + day.totalKwh);
      
      final comparison = {
        'current': {
          'totalKwh': currentTotal,
          'averageDaily': currentTotal / currentConsumption.length,
          'days': currentConsumption.length,
        },
        'previous': {
          'totalKwh': previousTotal,
          'averageDaily': previousTotal / previousConsumption.length,
          'days': previousConsumption.length,
        },
        'change': {
          'percentage': ((currentTotal - previousTotal) / previousTotal * 100),
          'absolute': currentTotal - previousTotal,
        },
      };
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved consumption comparison');
      return ApiResponse.success(comparison);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get consumption comparison', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve consumption comparison: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<SeasonalTrends>> getSeasonalTrends(String userId) async {
    try {
      Logger.info('MockConsumptionRepository: Getting seasonal trends for user: $userId');
      
      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final Map<String, dynamic> statisticsData = consumptionData['usageStatistics'] as Map<String, dynamic>;
      final Map<String, dynamic> seasonalData = statisticsData['seasonalTrends'] as Map<String, dynamic>;
      
      final seasonalTrends = SeasonalTrends.fromJson(seasonalData);
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved seasonal trends');
      return ApiResponse.success(seasonalTrends);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get seasonal trends', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve seasonal trends: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<Map<String, dynamic>>>> getConsumptionAlerts(String userId) async {
    try {
      Logger.info('MockConsumptionRepository: Getting consumption alerts for user: $userId');
      
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate processing time
      
      // Mock consumption alerts
      final alerts = [
        {
          'id': 'alert_001',
          'type': 'high_usage',
          'message': 'Your usage today is 20% higher than average',
          'severity': 'warning',
          'date': DateTime.now().toIso8601String(),
        },
        {
          'id': 'alert_002',
          'type': 'peak_hour',
          'message': 'Peak usage detected during 6-8 PM',
          'severity': 'info',
          'date': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        },
      ];
      
      Logger.info('MockConsumptionRepository: ApiResponse.successfully retrieved ${alerts.length} consumption alerts');
      return ApiResponse.success(alerts);
    } catch (e, stackTrace) {
      Logger.error('MockConsumptionRepository: Failed to get consumption alerts', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve consumption alerts: ${e.toString()}');
    }
  }

  // BaseRepository implementation
  @override
  Future<T> handleResponse<T>(
    Future<dynamic> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await apiCall();
      return fromJson(response as Map<String, dynamic>);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }

  @override
  void handleError(Exception error) {
    Logger.error('MockConsumptionRepository: API Error', error: error);
  }
}
