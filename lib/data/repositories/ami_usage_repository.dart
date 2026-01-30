import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/api_response_dtos.dart';
import '../services/api_client.dart';
import '../sources/mock/data_loader.dart';
import '../sources/mock/mock_asset_paths.dart';

/// Repository for fetching AMI (Advanced Metering Infrastructure) usage data
class AmiUsageRepository {
  const AmiUsageRepository();

  static final _apiClient = ApiClient.instance;

  /// Fetch daily interval kWh details for a meter and date
  /// GET /V1/MeterUsage/DailyIntervals?meterId={meterId}&targetDate={targetDate}
  /// 
  /// Used for daily filter - shows 15-minute interval data for a specific date
  Future<List<IntervalUsageEntryDto>> fetchDailyIntervals({
    required int meterId,
    required DateTime targetDate,
  }) async {
    try {
      final targetDateStr = targetDate.toIso8601String().split('T')[0];
      Logger.info(
        'Fetching daily intervals for meter $meterId on $targetDateStr...',
        tag: 'AmiUsageRepository',
      );

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        Logger.info('Using mock daily intervals data', tag: 'AmiUsageRepository');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiIntervalUsage,
        );
        final responseDto = IntervalUsageResponseDto.fromJson(jsonData);
        return responseDto.data;
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.amiDailyIntervals,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'targetDate': targetDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = IntervalUsageResponseDto.fromJson(response.data!);
        Logger.info(
          'Successfully fetched ${responseDto.data.length} daily interval entries',
          tag: 'AmiUsageRepository',
        );
        return responseDto.data;
      } else {
        Logger.warning(
          'Failed to fetch daily intervals. Status: ${response.statusCode}',
          tag: 'AmiUsageRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching daily intervals',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return [];
    }
  }

  /// Fetch daily usage for a date range
  /// GET /V1/MeterUsage/DailyRange?meterId={meterId}&startDate={startDate}&endDate={endDate}
  /// 
  /// Used for weekly and monthly filters - shows daily totals for a date range
  Future<List<DailyUsageEntryDto>> fetchDailyRange({
    required int meterId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final startDateStr = startDate.toIso8601String().split('T')[0];
      final endDateStr = endDate.toIso8601String().split('T')[0];
      Logger.info(
        'Fetching daily range for meter $meterId from $startDateStr to $endDateStr...',
        tag: 'AmiUsageRepository',
      );

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        Logger.info('Using mock daily range data', tag: 'AmiUsageRepository');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiDailyUsage,
        );
        final responseDto = DailyUsageResponseDto.fromJson(jsonData);
        // Filter to requested date range so week view gets 7 days, not full month
        final startDay = DateTime(startDate.year, startDate.month, startDate.day);
        final endDay = DateTime(endDate.year, endDate.month, endDate.day);
        return responseDto.data.where((dto) {
          final d = DateTime.tryParse(dto.usageDate.trim().split(RegExp('[T ]')).first);
          if (d == null) return false;
          final entryDay = DateTime(d.year, d.month, d.day);
          return !entryDay.isBefore(startDay) && !entryDay.isAfter(endDay);
        }).toList();
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.amiDailyRange,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'startDate': startDateStr,
          'endDate': endDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = DailyUsageResponseDto.fromJson(response.data!);
        Logger.info(
          'Successfully fetched ${responseDto.data.length} daily usage entries',
          tag: 'AmiUsageRepository',
        );
        return responseDto.data;
      } else {
        Logger.warning(
          'Failed to fetch daily range. Status: ${response.statusCode}',
          tag: 'AmiUsageRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching daily range',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return [];
    }
  }

  /// Fetch monthly totals for a year
  /// GET /V1/MeterUsage/MonthlyTotals?meterId={meterId}&year={year}
  /// 
  /// Used for year filter - shows monthly totals for a specific year
  Future<List<MonthlyUsageEntryDto>> fetchMonthlyTotals({
    required int meterId,
    required int year,
  }) async {
    try {
      Logger.info(
        'Fetching monthly totals for meter $meterId in year $year...',
        tag: 'AmiUsageRepository',
      );

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        Logger.info('Using mock monthly totals data', tag: 'AmiUsageRepository');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiMonthlyUsage,
        );
        final responseDto = MonthlyUsageResponseDto.fromJson(jsonData);
        return responseDto.data;
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.amiMonthlyTotals,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'year': year.toString(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = MonthlyUsageResponseDto.fromJson(response.data!);
        Logger.info(
          'Successfully fetched ${responseDto.data.length} monthly totals',
          tag: 'AmiUsageRepository',
        );
        return responseDto.data;
      } else {
        Logger.warning(
          'Failed to fetch monthly totals. Status: ${response.statusCode}',
          tag: 'AmiUsageRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching monthly totals',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return [];
    }
  }
}
