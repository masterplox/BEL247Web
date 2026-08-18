import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/ami_bucket_parser.dart';
import '../models/api_response_dtos.dart';
import '../models/usage_dashboard_cards.dart';
import '../services/api_client.dart';
import '../sources/mock/data_loader.dart';
import '../sources/mock/mock_asset_paths.dart';

/// Repository for fetching AMI (Advanced Metering Infrastructure) usage data
class AmiUsageRepository {
  const AmiUsageRepository();

  static final _apiClient = ApiClient.instance;

  /// AMI meter numbers are 10-digit strings with a leading zero (e.g. 0226031929).
  /// Parsing to [int] drops that zero; the stored procedures expect the padded id.
  static String _meterIdQuery(int meterId) {
    final raw = meterId.toString();
    return raw.length >= 10 ? raw : raw.padLeft(10, '0');
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

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiIntervalUsage,
        );
        return AmiBucketParser.parseIntervals(
          jsonData,
          meterId: meterId.toString(),
          targetDate: targetDate,
        );
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiDailyIntervals,
        authenticated: true,
        queryParameters: {
          'meterId': _meterIdQuery(meterId),
          'targetDate': targetDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return AmiBucketParser.parseIntervals(
          response.data,
          meterId: _meterIdQuery(meterId),
          targetDate: targetDate,
        );
      } else {
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
  /// GET /AMI/DailyRangeBucket?meterId={meterId}&startDate={startDate}&endDate={endDate}
  ///
  /// Used for weekly and monthly filters - one call for daily totals and TOU.
  Future<DailyRangeResult> fetchDailyRange({
    required int meterId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final startDateStr = startDate.toIso8601String().split('T')[0];
      final endDateStr = endDate.toIso8601String().split('T')[0];

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiDailyUsage,
        );
        final parsed = AmiBucketParser.parseDailyRange(
          jsonData,
          startDate: startDate,
          endDate: endDate,
        );
        // Filter to requested date range so week view gets 7 days, not full month
        final startDay = DateTime(startDate.year, startDate.month, startDate.day);
        final endDay = DateTime(endDate.year, endDate.month, endDate.day);
        final days = parsed.days.where((row) {
          final d = DateTime.tryParse(row.usageDate.trim().split(RegExp('[T ]')).first);
          if (d == null) return false;
          final entryDay = DateTime(d.year, d.month, d.day);
          return !entryDay.isBefore(startDay) && !entryDay.isAfter(endDay);
        }).toList();
        return DailyRangeResult(days: days, summary: parsed.summary);
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiDailyRange,
        authenticated: true,
        queryParameters: {
          'meterId': _meterIdQuery(meterId),
          'startDate': startDateStr,
          'endDate': endDateStr,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return AmiBucketParser.parseDailyRange(
          response.data,
          startDate: startDate,
          endDate: endDate,
        );
      } else {
        return const DailyRangeResult();
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching daily range',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return const DailyRangeResult();
    }
  }

  /// Fetch interval data for a date range.
  /// Used for the day-by-day TOU fallback when DailyRangeBucket has no TOU.
  Future<List<IntervalUsageEntryDto>> fetchIntervalsForRange({
    required int meterId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final days = <DateTime>[];
    var current = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    while (!current.isAfter(end)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    const chunkSize = 7;
    final results = <IntervalUsageEntryDto>[];
    for (var i = 0; i < days.length; i += chunkSize) {
      final endIndex =
          i + chunkSize > days.length ? days.length : i + chunkSize;
      final chunk = days.sublist(i, endIndex);
      final chunkResults = await Future.wait(
        chunk.map(
          (day) => fetchDailyIntervals(meterId: meterId, targetDate: day),
        ),
      );
      for (final dayIntervals in chunkResults) {
        results.addAll(dayIntervals);
      }
    }
    return results;
  }

  /// Daily kWh totals for [startDate]..=[endDate], built from DailyIntervalsBucket.
  Future<List<DailyUsageEntryDto>> fetchDailyTotalsFromIntervals({
    required int meterId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final intervals = await fetchIntervalsForRange(
      meterId: meterId,
      startDate: startDate,
      endDate: endDate,
    );
    final byDay = <DateTime, double>{};
    for (final dto in intervals) {
      final parsed = DateTime.tryParse(
        dto.intervalDateTime.trim().replaceAll(' ', 'T'),
      );
      if (parsed == null || parsed.year < 1900) continue;
      final day = DateTime(parsed.year, parsed.month, parsed.day);
      byDay[day] = (byDay[day] ?? 0) + dto.kWh;
    }
    final days = byDay.keys.toList()..sort();
    return [
      for (final day in days)
        DailyUsageEntryDto(
          usageDate:
              '${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}',
          dailyUsageKwh: byDay[day] ?? 0,
        ),
    ];
  }

  /// Fetch monthly totals for a year
  /// GET /AMI/MonthlyTotalsBucket?meterId={meterId}&year={year}
  ///
  /// Used for year filter - shows monthly totals and TOU splits.
  Future<MonthlyTotalsResult> fetchMonthlyTotals({
    required int meterId,
    required int year,
  }) async {
    try {

      if (EnvConfig.useMockAmiUsage) {
        await Future.delayed(const Duration(milliseconds: 300));
        
        final jsonData = await DataLoader.loadJsonFromAssets(
          MockAssetPaths.amiMonthlyUsage,
        );
        return AmiBucketParser.parseMonthlyTotals(jsonData, year: year);
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiMonthlyTotals,
        authenticated: true,
        queryParameters: {
          'meterId': _meterIdQuery(meterId),
          'year': year.toString(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return AmiBucketParser.parseMonthlyTotals(response.data, year: year);
      } else {
        return const MonthlyTotalsResult();
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching monthly totals',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return const MonthlyTotalsResult();
    }
  }

  /// Fetch the four billing-period dashboard cards for a meter.
  /// GET /AMI/UsageDashboardCards?meterId={meterId}&periods={periods}
  Future<UsageDashboardCardsResult> fetchUsageDashboardCards({
    required int meterId,
    int periods = 12,
  }) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.amiUsageDashboardCards,
        authenticated: true,
        queryParameters: {
          'meterId': _meterIdQuery(meterId),
          'periods': periods.toString(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final payload = _extractObject(response.data);
        if (payload == null) return const UsageDashboardCardsResult.empty();
        return UsageDashboardCardsResult.fromJson(payload);
      }
      return const UsageDashboardCardsResult.empty();
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching usage dashboard cards',
        error: e,
        stackTrace: stackTrace,
        tag: 'AmiUsageRepository',
      );
      return const UsageDashboardCardsResult.empty();
    }
  }

  static Map<String, dynamic>? _extractObject(dynamic json) =>
      _asStringMapOrNull(json);
}
