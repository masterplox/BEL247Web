import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../services/api_client.dart';

/// POST /General/V5/AppSupportRequestGen
class AppSupportRepository {
  AppSupportRepository([ApiClient? apiClient]) : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  static const String supportTypeGeneral = 'General Support';

  /// Returns `true` if the API accepted the request (2xx).
  Future<bool> submitRequest({
    required String contactFullName,
    required String phoneNumber,
    required String email,
    required String requestMessage,
    required String sourcePage,
    required String accountNumber,
    required String customerNumber,
    String supportType = supportTypeGeneral,
  }) async {
    if (EnvConfig.useMockApi) {
      Logger.debug('AppSupportRequest (mock skip)', tag: 'AppSupport');
      return true;
    }
    try {
      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.appSupportRequest,
        data: <String, dynamic>{
          'ContactFullName': contactFullName,
          'PhoneNumber': phoneNumber,
          'Email': email,
          'RequestMessage': requestMessage,
          'SourcePage': sourcePage,
          'AccountNumber': accountNumber,
          'CustomerNumber': customerNumber,
          'SupportType': supportType,
        },
        authenticated: true,
      );
      final ok = response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
      return ok;
    } catch (e, st) {
      Logger.error('App support request failed', error: e, stackTrace: st, tag: 'AppSupport');
      rethrow;
    }
  }
}
