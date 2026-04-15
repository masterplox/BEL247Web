import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/api_response_dtos.dart';
import '../services/api_client.dart';

/// Repository for fetching meter readings data
class MeterReadingsRepository {
  const MeterReadingsRepository();

  static final _apiClient = ApiClient.instance;

  /// Fetch meter readings for this year
  /// GET /CustomerAccounts/V3/Readings?customerNumber={customerNumber}&accountNumber={accountNumber}
  Future<List<MeterReadingDto>> fetchMeterReadingsThisYear({
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      Logger.info('Fetching meter readings for this year...', tag: 'MeterReadingsRepository');

      if (EnvConfig.useMockApi) {
        await Future.delayed(const Duration(milliseconds: 300));
        return [];
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.meterReadingsThisYear,
        authenticated: true,
        queryParameters: {
          'customerNumber': customerNumber,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = MeterReadingsResponseDto.fromJson(response.data!);
        
        Logger.info(
          'Successfully fetched ${responseDto.readings.length} readings for this year',
          tag: 'MeterReadingsRepository',
        );

        return responseDto.readings;
      } else {
        Logger.warning(
          'Failed to fetch meter readings for this year. Status: ${response.statusCode}',
          tag: 'MeterReadingsRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching meter readings for this year',
        error: e,
        stackTrace: stackTrace,
        tag: 'MeterReadingsRepository',
      );
      return [];
    }
  }

  /// Fetch meter readings for last year
  /// GET /CustomerAccounts/V3/Readings/Year?customerNumber={customerNumber}&accountNumber={accountNumber}
  Future<List<MeterReadingDto>> fetchMeterReadingsLastYear({
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      Logger.info('Fetching meter readings for last year...', tag: 'MeterReadingsRepository');

      if (EnvConfig.useMockApi) {
        await Future.delayed(const Duration(milliseconds: 300));
        return [];
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.meterReadingsLastYear,
        authenticated: true,
        queryParameters: {
          'customerNumber': customerNumber,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = MeterReadingsResponseDto.fromJson(response.data!);
        
        Logger.info(
          'Successfully fetched ${responseDto.readings.length} readings for last year',
          tag: 'MeterReadingsRepository',
        );

        return responseDto.readings;
      } else {
        Logger.warning(
          'Failed to fetch meter readings for last year. Status: ${response.statusCode}',
          tag: 'MeterReadingsRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching meter readings for last year',
        error: e,
        stackTrace: stackTrace,
        tag: 'MeterReadingsRepository',
      );
      return [];
    }
  }

  /// Fetch meter readings for the year before last (two years ago)
  /// GET /CustomerAccounts/V3/Readings/YearTwo?customerNumber={customerNumber}&accountNumber={accountNumber}
  Future<List<MeterReadingDto>> fetchMeterReadingsYearTwo({
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      Logger.info('Fetching meter readings for year -2...', tag: 'MeterReadingsRepository');

      if (EnvConfig.useMockApi) {
        await Future.delayed(const Duration(milliseconds: 300));
        return [];
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.meterReadingsYearTwo,
        authenticated: true,
        queryParameters: {
          'customerNumber': customerNumber,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = MeterReadingsResponseDto.fromJson(response.data!);

        Logger.info(
          'Successfully fetched ${responseDto.readings.length} readings for year -2',
          tag: 'MeterReadingsRepository',
        );

        return responseDto.readings;
      } else {
        Logger.warning(
          'Failed to fetch meter readings for year -2. Status: ${response.statusCode}',
          tag: 'MeterReadingsRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching meter readings for year -2',
        error: e,
        stackTrace: stackTrace,
        tag: 'MeterReadingsRepository',
      );
      return [];
    }
  }
}
