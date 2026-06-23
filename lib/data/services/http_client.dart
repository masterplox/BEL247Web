import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/config/env.dart';
import '../../core/services/api_logger_interceptor.dart';
import '../../core/utils/logger.dart';
import '../models/auth.dart';
import 'token_storage_service.dart';

/// Centralized HTTP client powered by Dio with JWT, retry, and env switching
class HttpClient {
  HttpClient._internal();

  static final HttpClient _instance = HttpClient._internal();
  static HttpClient get instance => _instance;

  Dio? _dio;

  /// Public getter for configured Dio instance
  Dio get client => _dio ??= _createDio();

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
    dio.interceptors.add(_AuthInterceptor(dio));
    dio.interceptors.add(_RetryInterceptor(dio));
    dio.interceptors.add(ApiLoggerInterceptor(
      enabled: true, // Always enabled to see all API calls
      logRequestHeaders: true,
      logResponseHeaders: false,
      maskSensitiveData: true, // Mask passwords and tokens for security
    ));

    Logger.info('HttpClient initialized. Base URL: $baseUrl (mock=${EnvConfig.useMockApi})');
    return dio;
  }

  /// Recreate Dio with current environment (e.g., after toggling mock/live)
  void reinitialize() {
    _dio = _createDio();
  }
}

/// Interceptor that injects JWT and performs token refresh on 401
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._dio);

  final Dio _dio;
  bool _refreshInProgress = false;
  final List<Completer<void>> _refreshWaiters = <Completer<void>>[];

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final accessToken = await TokenStorageService.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e, stack) {
      Logger.error('AuthInterceptor onRequest failed', error: e, stackTrace: stack);
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only attempt refresh on 401 from live API (skip for mock scheme)
    final is401 = err.response?.statusCode == 401;
    final isMock = err.requestOptions.baseUrl.startsWith('mock://');
    if (!is401 || isMock) {
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
      final resp = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refreshToken},
        options: Options(headers: <String, dynamic>{'Authorization': null}),
      );

      final data = resp.data;
      if (data == null) return false;

      // Expected keys; adjust if API differs
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
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
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


