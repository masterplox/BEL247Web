import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/config/env.dart';
import '../../core/services/api_logger_interceptor.dart';
import '../../core/utils/logger.dart';
import '../models/auth.dart';
import 'token_storage_service.dart';

/// Clean API client interface that automatically handles:
/// - Base URL prepending
/// - Authentication (Bearer token) when requested
/// - Request/response logging
/// - Retry logic
class ApiClient {
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();
  static ApiClient get instance => _instance;

  Dio? _dio;

  /// Get or create the configured Dio instance
  Dio get _client => _dio ??= _createDio();

  Dio _createDio() {
    final baseUrl = EnvConfig.currentApiUrl;

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 90000),
        receiveTimeout: const Duration(milliseconds: 90000),
        sendTimeout: const Duration(milliseconds: 90000),
        headers: <String, dynamic>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Order matters: auth -> retry -> logging
    dio.interceptors.add(_ConditionalAuthInterceptor(dio));
    dio.interceptors.add(_RetryInterceptor(dio));
    dio.interceptors.add(ApiLoggerInterceptor(
      enabled: true,
      logRequestHeaders: true,
      logResponseHeaders: false,
      maskSensitiveData: true,
    ));

    Logger.info('ApiClient initialized. Base URL: $baseUrl (mock=${EnvConfig.useMockApi})');
    return dio;
  }

  /// Reinitialize Dio with current environment (e.g., after toggling mock/live)
  void reinitialize() {
    _dio = _createDio();
  }

  /// GET request
  /// [endpoint] - Just the endpoint path (e.g., ApiEndpoints.connectedAccounts)
  /// [authenticated] - Whether to include Bearer token (default: true)
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional Dio request options
  Future<Response<T>> get<T>(
    String endpoint, {
    bool authenticated = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => _client.get<T>(
      endpoint,
      queryParameters: queryParameters,
      options: _mergeOptions(options, authenticated),
    );

  /// POST request
  /// [endpoint] - Just the endpoint path (e.g., ApiEndpoints.login)
  /// [data] - Request body data
  /// [authenticated] - Whether to include Bearer token (default: false for login, true for other requests)
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional Dio request options
  Future<Response<T>> post<T>(
    String endpoint, {
    dynamic data,
    bool authenticated = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => _client.post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, authenticated),
    );

  /// PUT request
  /// [endpoint] - Just the endpoint path
  /// [data] - Request body data
  /// [authenticated] - Whether to include Bearer token (default: true)
  /// [options] - Optional Dio request options
  Future<Response<T>> put<T>(
    String endpoint, {
    dynamic data,
    bool authenticated = true,
    Options? options,
  }) async => _client.put<T>(
      endpoint,
      data: data,
      options: _mergeOptions(options, authenticated),
    );

  /// DELETE request
  /// [endpoint] - Just the endpoint path
  /// [data] - Optional request body data
  /// [authenticated] - Whether to include Bearer token (default: true)
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional Dio request options
  Future<Response<T>> delete<T>(
    String endpoint, {
    dynamic data,
    bool authenticated = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async => _client.delete<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, authenticated),
    );

  /// Merge custom options with authentication flag
  Options _mergeOptions(Options? options, bool authenticated) {
    final merged = options ?? Options();
    merged.extra = {
      ...?merged.extra,
      'authenticated': authenticated,
    };
    return merged;
  }
}

/// Interceptor that conditionally adds JWT based on request extra['authenticated']
class _ConditionalAuthInterceptor extends Interceptor {
  _ConditionalAuthInterceptor(this._dio);

  final Dio _dio;
  bool _refreshInProgress = false;
  final List<Completer<void>> _refreshWaiters = <Completer<void>>[];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if this request should be authenticated
    final authenticated = options.extra['authenticated'] as bool? ?? true;

    if (authenticated) {
      try {
        final accessToken = await TokenStorageService.getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
      } catch (e, stack) {
        Logger.error(
          'ConditionalAuthInterceptor onRequest failed',
          error: e,
          stackTrace: stack,
        );
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only attempt refresh on 401 from live API (skip for mock scheme)
    final is401 = err.response?.statusCode == 401;
    final isMock = err.requestOptions.baseUrl.startsWith('mock://');
    final authenticated = err.requestOptions.extra['authenticated'] as bool? ?? true;

    // Don't refresh token for unauthenticated requests
    if (!is401 || isMock || !authenticated) {
      return handler.next(err);
    }

    // Coordinate single refresh across concurrent 401s
    if (_refreshInProgress) {
      final waiter = Completer<void>();
      _refreshWaiters.add(waiter);
      await waiter.future;
    } else {
      _refreshInProgress = true;
      try {
        final refreshed = await _refreshToken();
        if (!refreshed) {
          return handler.next(err);
        }
      } catch (e, stack) {
        Logger.error('Token refresh failed', error: e, stackTrace: stack);
        return handler.next(err);
      } finally {
        _refreshInProgress = false;
        for (final w in _refreshWaiters) {
          if (!w.isCompleted) w.complete();
        }
        _refreshWaiters.clear();
      }
    }

    // Clone and retry original request with new token
    try {
      final reqOptions = err.requestOptions;
      final newRequest = await _dio.fetch<dynamic>(reqOptions);
      return handler.resolve(newRequest);
    } catch (e, stack) {
      Logger.error('Retry after refresh failed', error: e, stackTrace: stack);
      return handler.next(err);
    }
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await TokenStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      // Create a temporary Dio instance without auth interceptor for refresh
      final dio = Dio(BaseOptions(
        baseUrl: EnvConfig.currentApiUrl,
        headers: <String, dynamic>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ));
      final resp = await dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refreshToken},
      );

      final data = resp.data;
      if (data == null) return false;

      final access = data['accessToken'] as String?;
      final refresh = data['refreshToken'] as String? ?? refreshToken;
      final accessExp = DateTime.tryParse(data['accessTokenExpiresAt'] as String? ?? '');
      final refreshExp = DateTime.tryParse(data['refreshTokenExpiresAt'] as String? ?? '');

      if (access == null || accessExp == null || refreshExp == null) {
        return false;
      }

      await TokenStorageService.storeTokenPair(
        TokenPair(
          accessToken: access,
          refreshToken: refresh,
          accessTokenExpiresAt: accessExp,
          refreshTokenExpiresAt: refreshExp,
        ),
      );
      await TokenStorageService.updateLastRefresh();
      Logger.info('Access token refreshed successfully');
      return true;
    } on DioException catch (e, stack) {
      Logger.error('Refresh request failed', error: e, stackTrace: stack);
      return false;
    } catch (e, stack) {
      Logger.error('Unexpected refresh error', error: e, stackTrace: stack);
      return false;
    }
  }
}

/// Basic retry interceptor with exponential backoff for transient failures
class _RetryInterceptor extends Interceptor {
  _RetryInterceptor(this._dio);

  final Dio _dio;
  static const int _maxRetries = 3;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Do not retry on 4xx (except 408) or for mock scheme
    final status = err.response?.statusCode ?? 0;
    final isClientError = status >= 400 && status < 500 && status != 408;
    final isMock = err.requestOptions.baseUrl.startsWith('mock://');
    if (isClientError || isMock) {
      return handler.next(err);
    }

    final extra = err.requestOptions.extra;
    final attempt = (extra['retry_attempt'] as int?) ?? 0;
    if (attempt >= _maxRetries) {
      return handler.next(err);
    }

    // Only retry on connection/timeout/transient
    final type = err.type;
    final shouldRetry = type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.connectionError ||
        status == 408 ||
        status == 429 ||
        status >= 500;

    if (!shouldRetry) {
      return handler.next(err);
    }

    final delayMs = _backoffDelayMs(attempt);
    Logger.warning('Retrying request (attempt ${attempt + 1}) after ${delayMs}ms');
    await Future<void>.delayed(Duration(milliseconds: delayMs));

    try {
      final requestOptions = err.requestOptions;
      requestOptions.extra = Map<String, dynamic>.from(requestOptions.extra)
        ..['retry_attempt'] = attempt + 1;
      final response = await _dio.fetch<dynamic>(requestOptions);
      return handler.resolve(response);
    } catch (e, stack) {
      Logger.error('Retry attempt failed', error: e, stackTrace: stack);
      return handler.next(err);
    }
  }

  int _backoffDelayMs(int attempt) {
    // 500ms, 1000ms, 2000ms with jitter
    final base = 500 * (1 << attempt);
    return base + (base * 0.1).toInt();
  }
}
