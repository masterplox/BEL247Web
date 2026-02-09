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

  static List<Map<String, dynamic>> _extractList(dynamic json) {
    if (json is List) {
      return json
          .whereType<Object?>()
          .map<Map<String, dynamic>?>(_asStringMapOrNull)
          .whereType<Map<String, dynamic>>()
          .toList();
    }

    if (json is Map) {
      final data = json['data'];
      if (data is List) {
        return data
            .whereType<Object?>()
            .map<Map<String, dynamic>?>(_asStringMapOrNull)
            .whereType<Map<String, dynamic>>()
            .toList();
      }
    }

    return const <Map<String, dynamic>>[];
  }

  static Map<String, dynamic>? _asStringMapOrNull(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map(
        (k, v) => MapEntry(k.toString(), v),
      );
    }
    return null;
  }

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
      print('[AmiUsage] Repository.fetchDailyIntervals start meterId=$meterId targetDate=$targetDateStr');

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        print('[AmiUsage] Repository.fetchDailyIntervals using mock data');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiIntervalUsage,
        );
        final rows = _extractList(jsonData);
        final entries = rows.map((row) => IntervalUsageEntryDto.fromJson({
            ...row,
            // Live API no longer includes meterId; ensure DTO always has it.
            'meterId': (row['meterId'] ?? meterId).toString(),
          })).toList();
        print('[AmiUsage] ✅ Successfully fetched ${entries.length} interval entries for daily view');
        return entries;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiDailyIntervals,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'targetDate': targetDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final rows = _extractList(response.data);
        final entries = rows.map((row) => IntervalUsageEntryDto.fromJson({
            ...row,
            // Live API no longer includes meterId; ensure DTO always has it.
            'meterId': (row['meterId'] ?? meterId).toString(),
          })).toList();
        print('[AmiUsage] ✅ Successfully fetched ${entries.length} interval entries for daily view');
        return entries;
      } else {
        print('[AmiUsage] Repository.fetchDailyIntervals [ERROR] Failed to fetch. Status: ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('[AmiUsage] Repository.fetchDailyIntervals [ERROR] $e');
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
      print('[AmiUsage] Repository.fetchDailyRange start meterId=$meterId startDate=$startDateStr endDate=$endDateStr');

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        print('[AmiUsage] Repository.fetchDailyRange using mock data');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiDailyUsage,
        );
        final rows = _extractList(jsonData);
        final allEntries = rows.map(DailyUsageEntryDto.fromJson).toList();
        // Filter to requested date range so week view gets 7 days, not full month
        final startDay = DateTime(startDate.year, startDate.month, startDate.day);
        final endDay = DateTime(endDate.year, endDate.month, endDate.day);
        final filteredData = allEntries.where((dto) {
          final d = DateTime.tryParse(dto.usageDate.trim().split(RegExp('[T ]')).first);
          if (d == null) return false;
          final entryDay = DateTime(d.year, d.month, d.day);
          return !entryDay.isBefore(startDay) && !entryDay.isAfter(endDay);
        }).toList();
        print('[AmiUsage] ✅ Successfully fetched ${filteredData.length} daily entries for range view');
        return filteredData;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiDailyRange,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'startDate': startDateStr,
          'endDate': endDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final rows = _extractList(response.data);
        final entries = rows.map(DailyUsageEntryDto.fromJson).toList();
        print('[AmiUsage] ✅ Successfully fetched ${entries.length} daily entries for range view');
        return entries;
      } else {
        print('[AmiUsage] Repository.fetchDailyRange [ERROR] Failed to fetch. Status: ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('[AmiUsage] Repository.fetchDailyRange [ERROR] $e');
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
      print('[AmiUsage] Repository.fetchMonthlyTotals start meterId=$meterId year=$year');

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        print('[AmiUsage] Repository.fetchMonthlyTotals using mock data');
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiMonthlyUsage,
        );
        final rows = _extractList(jsonData);
        final entries = rows.map(MonthlyUsageEntryDto.fromJson).toList();
        print('[AmiUsage] ✅ Successfully fetched ${entries.length} monthly totals for year view');
        return entries;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiMonthlyTotals,
        authenticated: true,
        queryParameters: {
          'meterId': meterId.toString(),
          'year': year.toString(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final rows = _extractList(response.data);
        final entries = rows.map(MonthlyUsageEntryDto.fromJson).toList();
        print('[AmiUsage] ✅ Successfully fetched ${entries.length} monthly totals for year view');
        return entries;
      } else {
        print('[AmiUsage] Repository.fetchMonthlyTotals [ERROR] Failed to fetch. Status: ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('[AmiUsage] Repository.fetchMonthlyTotals [ERROR] $e');
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
