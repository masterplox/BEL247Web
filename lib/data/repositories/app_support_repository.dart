import '../../core/config/env.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../services/api_client.dart';

/// POST /General/V5/WebPortalAppSupportRequest (signed in)
/// POST /General/V5/WebPortalAppSupportRequestGen (signed out)
class AppSupportRepository {
  AppSupportRepository([ApiClient? apiClient]) : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  static const String supportTypeGeneral = 'General Support';

  /// Returns `(ok, message)` using API status and response message.
  Future<(bool ok, String message)> submitRequest({
    required String contactFullName,
    required String phoneNumber,
    required String email,
    required String requestMessage,
    required String sourcePage,
    required String accountNumber,
    required String customerNumber,
    String supportType = supportTypeGeneral,
    bool authenticated = true,
  }) async {
    if (EnvConfig.useMockApi) {
      Logger.debug('AppSupportRequest (mock skip)', tag: 'AppSupport');
      return (true, 'Thank you for submitting an App Support request.');
    }
    try {
      final endpoint = authenticated
          ? ApiEndpoints.appSupportRequest
          : ApiEndpoints.appSupportRequestGen;
      final response = await _apiClient.post<dynamic>(
        endpoint,
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
        authenticated: authenticated,
      );
      final statusCode = response.statusCode ?? 0;
      final ok = statusCode >= 200 && statusCode < 300;

      var message = ok
          ? 'Your support request was submitted successfully.'
          : 'Could not send your request. Please try again.';

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final apiMessage = data['message'];
        if (apiMessage is String && apiMessage.trim().isNotEmpty) {
          message = apiMessage.trim();
        }
      }

      return (ok, message);
    } catch (e, st) {
      Logger.error('App support request failed', error: e, stackTrace: st, tag: 'AppSupport');
      rethrow;
    }
  }
}
