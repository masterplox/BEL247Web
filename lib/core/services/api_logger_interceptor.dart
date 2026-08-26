import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/env.dart';
import '../utils/logger.dart';

@JS('console.log')
external void _jsLog(JSAny? object);

@JS('console.error')
external void _jsError(JSAny? object);

@JS('console.groupCollapsed')
external void _jsGroupCollapsed(JSString label);

@JS('console.group')
external void _jsGroup(JSString label);

@JS('console.groupEnd')
external void _jsGroupEnd();

/// Comprehensive API logging interceptor for Dio
/// 
/// Logs all API endpoint calls including:
/// - HTTP method and full URL
/// - Request parameters (query, body, headers)
/// - Response status code and body
/// - Request duration
/// - Errors with full details
class ApiLoggerInterceptor extends Interceptor {
  ApiLoggerInterceptor({
    bool? enabled,
    bool logRequestHeaders = true,
    bool logResponseHeaders = false,
    bool maskSensitiveData = true,
  })  : _enabled = enabled ?? EnvConfig.isDevelopment,
        _logRequestHeaders = logRequestHeaders,
        _logResponseHeaders = logResponseHeaders,
        _maskSensitiveData = maskSensitiveData;

  final bool _enabled;
  final bool _logRequestHeaders;
  final bool _logResponseHeaders;
  final bool _maskSensitiveData;

  /// Enable or disable logging
  bool get enabled => _enabled;

  /// Mask sensitive data in logs (e.g., Authorization tokens, passwords)
  bool get maskSensitiveData => _maskSensitiveData;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_enabled) {
      handler.next(options);
      return;
    }

    final method = options.method.toUpperCase();
    final url = _buildFullUrl(options);
    final timestamp = DateTime.now();

    // Log request start
    _logRequestStart(method, url, timestamp);

    // Log query parameters
    if (options.queryParameters.isNotEmpty) {
      _logQueryParameters(options.queryParameters);
    }

    // Log request body
    if (options.data != null) {
      _logRequestBody(options.data, options.contentType?.toString());
    }

    // Log request headers
    if (_logRequestHeaders) {
      _logHeaders(options.headers, isRequest: true);
    }

    // Store timestamp for duration calculation
    options.extra['_api_logger_start_time'] = timestamp.millisecondsSinceEpoch;

    _browserRequest(method, url, options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!_enabled) {
      handler.next(response);
      return;
    }

    final requestOptions = response.requestOptions;
    final method = requestOptions.method.toUpperCase();
    final url = _buildFullUrl(requestOptions);
    final statusCode = response.statusCode ?? 0;
    final duration = _calculateDuration(requestOptions);

    // Log response summary
    _logResponseSummary(method, url, statusCode, duration);

    // Log response headers
    if (_logResponseHeaders && response.headers.map.isNotEmpty) {
      _logHeaders(response.headers.map, isRequest: false);
    }

    // Log response body
    if (response.data != null) {
      _logResponseBody(response.data, response.requestOptions.responseType);
    }

    _browserResponse(method, url, statusCode, duration, response.data);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!_enabled) {
      handler.next(err);
      return;
    }

    final requestOptions = err.requestOptions;
    final method = requestOptions.method.toUpperCase();
    final url = _buildFullUrl(requestOptions);
    final statusCode = err.response?.statusCode;
    final duration = _calculateDuration(requestOptions);

    // Log error summary
    _logErrorSummary(method, url, statusCode, err.type, duration);

    // Check for CORS errors specifically
    final errorMessage = err.message ?? 'Unknown error';
    final isCorsError = errorMessage.toLowerCase().contains('cors') ||
        errorMessage.toLowerCase().contains('access-control-allow-origin') ||
        err.type == DioExceptionType.connectionError ||
        (err.response == null && errorMessage.contains('ERR_FAILED'));

    if (isCorsError) {
      Logger.error(
        '⚠️ CORS ERROR DETECTED',
        tag: 'API_Logger',
      );
      Logger.error(
        'The server at $url does not allow requests from this origin.',
        tag: 'API_Logger',
      );
      Logger.error(
        'CORS Error Details: $errorMessage',
        tag: 'API_Logger',
      );
      Logger.error(
        '💡 Solution: The API server needs to add CORS headers to allow your origin.',
        tag: 'API_Logger',
      );
      Logger.error(
        '   Required header: Access-Control-Allow-Origin: * (or specific origin)',
        tag: 'API_Logger',
      );
    }

    // Log error response if available
    if (err.response != null && err.response!.data != null) {
      _logErrorResponse(err.response!.data, statusCode);
    } else {
      // Log error message
      _logErrorMessage(errorMessage, err.type);
    }

    // Log stack trace for debugging (only in debug mode)
    Logger.debug(
      'Error Stack Trace:\n${err.stackTrace}',
      tag: 'API_Logger',
    );

    _browserError(method, url, err, duration);
    handler.next(err);
  }

  /// Browser console: request group
  void _browserRequest(String method, String url, RequestOptions options) {
    if (!kIsWeb) return;
    _jsGroupCollapsed('📤 [$method] $url'.toJS);
    if (options.queryParameters.isNotEmpty) {
      final params = _maskSensitiveData
          ? _maskSensitiveFields(options.queryParameters)
          : options.queryParameters;
      _jsLog('Query:'.toJS);
      _jsLog(params.jsify());
    }
    if (options.data != null) {
      _jsLog('Body:'.toJS);
      if (options.data is Map || options.data is List) {
        final body = _maskSensitiveData
            ? _maskSensitiveDynamic(options.data)
            : options.data;
        _jsLog((body as Object).jsify());
      } else {
        _jsLog(options.data.toString().toJS);
      }
    }
    _jsGroupEnd();
  }

  /// Browser console: response group
  void _browserResponse(
    String method,
    String url,
    int statusCode,
    Duration duration,
    dynamic data,
  ) {
    if (!kIsWeb) return;
    final emoji = _getStatusEmoji(statusCode);
    _jsGroupCollapsed(
        '$emoji [$method] $statusCode | ${duration.inMilliseconds}ms | $url'
            .toJS);
    if (data != null) {
      _jsLog('Response:'.toJS);
      if (data is Map || data is List) {
        final body =
            _maskSensitiveData ? _maskSensitiveDynamic(data) : data;
        _jsLog((body as Object).jsify());
      } else {
        _jsLog(data.toString().toJS);
      }
    }
    _jsGroupEnd();
  }

  /// Browser console: error group
  void _browserError(
      String method, String url, DioException err, Duration duration) {
    if (!kIsWeb) return;
    final statusCode = err.response?.statusCode;
    _jsGroup(
        '❌ [$method] ${statusCode ?? 'ERR'} | ${duration.inMilliseconds}ms | $url'
            .toJS);
    final info = <String, dynamic>{
      'type': err.type.toString(),
      'message': err.message ?? 'Unknown error',
      if (statusCode != null) 'statusCode': statusCode,
    };
    final responseData = err.response?.data;
    if (responseData != null) {
      info['body'] = (responseData is Map || responseData is List)
          ? (_maskSensitiveData
              ? _maskSensitiveDynamic(responseData)
              : responseData)
          : responseData.toString();
    }
    _jsError(info.jsify());
    _jsGroupEnd();
  }

  /// Build full URL from request options
  String _buildFullUrl(RequestOptions options) {
    final baseUrl = options.baseUrl;
    final path = options.path;
    
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    
    final base = baseUrl.endsWith('/') 
        ? baseUrl.substring(0, baseUrl.length - 1) 
        : baseUrl;
    final endpoint = path.startsWith('/') ? path : '/$path';
    
    return '$base$endpoint';
  }

  /// Log request start
  void _logRequestStart(String method, String url, DateTime timestamp) {
    Logger.info(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      tag: 'API_Logger',
    );
    Logger.info(
      '📤 REQUEST [$method] $url',
      tag: 'API_Logger',
    );
    Logger.debug(
      'Timestamp: ${timestamp.toIso8601String()}',
      tag: 'API_Logger',
    );
  }

  /// Log query parameters
  void _logQueryParameters(Map<String, dynamic> queryParams) {
    final maskedParams = _maskSensitiveData 
        ? _maskSensitiveFields(queryParams) 
        : queryParams;
    
    Logger.debug(
      'Query Parameters:\n${_formatJson(maskedParams)}',
      tag: 'API_Logger',
    );
  }

  /// Log request body
  void _logRequestBody(dynamic data, String? contentType) {
    if (contentType != null) {
      Logger.debug(
        'Content-Type: $contentType',
        tag: 'API_Logger',
      );
    }

    String bodyStr;
    if (data is Map || data is List) {
      final maskedData = _maskSensitiveData ? _maskSensitiveDynamic(data) : data;
      bodyStr = _formatJson(maskedData);
    } else if (data is String) {
      bodyStr = _maskSensitiveData 
          ? _maskSensitiveString(data) 
          : data;
    } else if (data is FormData) {
      bodyStr = _formatFormData(data);
    } else {
      bodyStr = data.toString();
    }

    Logger.debug(
      'Request Body:\n$bodyStr',
      tag: 'API_Logger',
    );
  }

  /// Log headers (request or response)
  void _logHeaders(dynamic headers, {required bool isRequest}) {
    final headerType = isRequest ? 'Request' : 'Response';
    String formattedHeaders;
    
    if (headers is Map<String, dynamic>) {
      final maskedHeaders = _maskSensitiveData 
          ? _maskSensitiveHeaders(headers) 
          : headers;
      formattedHeaders = _formatJson(maskedHeaders);
    } else if (headers is Map<String, List<String>>) {
      formattedHeaders = _formatHeaders(headers);
    } else {
      formattedHeaders = headers.toString();
    }
    
    Logger.debug(
      '$headerType Headers:\n$formattedHeaders',
      tag: 'API_Logger',
    );
  }

  /// Log response summary
  void _logResponseSummary(String method, String url, int statusCode, Duration duration) {
    final statusEmoji = _getStatusEmoji(statusCode);
    Logger.info(
      '$statusEmoji RESPONSE [$method] $url',
      tag: 'API_Logger',
    );
    Logger.info(
      'Status Code: $statusCode | Duration: ${duration.inMilliseconds}ms',
      tag: 'API_Logger',
    );
  }


  /// Log response body
  void _logResponseBody(dynamic data, ResponseType? responseType) {
    String bodyStr;
    
    if (responseType == ResponseType.plain) {
      bodyStr = data.toString();
    } else if (data is Map || data is List) {
      final maskedData = _maskSensitiveData ? _maskSensitiveDynamic(data) : data;
      bodyStr = _formatJson(maskedData);
    } else if (data is String) {
      try {
        // Try to parse as JSON for better formatting
        final json = _parseJsonString(data);
        if (json != null) {
          final maskedJson = _maskSensitiveData ? _maskSensitiveDynamic(json) : json;
          bodyStr = _formatJson(maskedJson);
        } else {
          bodyStr = _maskSensitiveData 
              ? _maskSensitiveString(data) 
              : data;
        }
      } catch (e) {
        bodyStr = _maskSensitiveData 
            ? _maskSensitiveString(data) 
            : data;
      }
    } else {
      bodyStr = data.toString();
    }

    Logger.debug(
      'Response Body:\n$bodyStr',
      tag: 'API_Logger',
    );
    Logger.info(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      tag: 'API_Logger',
    );
  }

  /// Log error summary
  void _logErrorSummary(
    String method,
    String url,
    int? statusCode,
    DioExceptionType errorType,
    Duration duration,
  ) {
    Logger.error(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      tag: 'API_Logger',
    );
    Logger.error(
      '❌ ERROR [$method] $url',
      tag: 'API_Logger',
    );
    Logger.error(
      'Status Code: ${statusCode ?? 'N/A'} | Duration: ${duration.inMilliseconds}ms | Type: $errorType',
      tag: 'API_Logger',
    );
  }

  /// Log error response
  void _logErrorResponse(dynamic errorData, int? statusCode) {
    String errorStr;
    if (errorData is Map || errorData is List) {
      final masked = _maskSensitiveData ? _maskSensitiveDynamic(errorData) : errorData;
      errorStr = _formatJson(masked);
    } else if (errorData is String) {
      try {
        final json = _parseJsonString(errorData);
        if (json != null) {
          final maskedJson = _maskSensitiveData ? _maskSensitiveDynamic(json) : json;
          errorStr = _formatJson(maskedJson);
        } else {
          errorStr = errorData;
        }
      } catch (e) {
        errorStr = errorData;
      }
    } else {
      errorStr = errorData.toString();
    }

    Logger.error(
      'Error Response:\n$errorStr',
      tag: 'API_Logger',
    );
    Logger.error(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      tag: 'API_Logger',
    );
  }

  /// Log error message
  void _logErrorMessage(String message, DioExceptionType errorType) {
    Logger.error(
      'Error Message: $message',
      tag: 'API_Logger',
    );
    Logger.error(
      'Error Type: $errorType',
      tag: 'API_Logger',
    );
    Logger.error(
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
      tag: 'API_Logger',
    );
  }

  /// Calculate request duration
  Duration _calculateDuration(RequestOptions options) {
    final startTime = options.extra['_api_logger_start_time'] as int?;
    if (startTime == null) {
      return Duration.zero;
    }
    final endTime = DateTime.now().millisecondsSinceEpoch;
    return Duration(milliseconds: endTime - startTime);
  }

  /// Get emoji for status code
  String _getStatusEmoji(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return '✅';
    } else if (statusCode >= 300 && statusCode < 400) {
      return '↩️';
    } else if (statusCode >= 400 && statusCode < 500) {
      return '⚠️';
    } else if (statusCode >= 500) {
      return '❌';
    }
    return '❓';
  }

  /// Mask sensitive fields in data
  Map<String, dynamic> _maskSensitiveFields(Map<String, dynamic> data) {
    final sensitiveKeys = [
      'password',
      'Password',
      'newPassword',
      'confirmPassword',
      'currentPassword',
      'accessToken',
      'refreshToken',
      'token',
      'authorization',
      'Authorization',
      'apiKey',
      'api_key',
      'secret',
      'Secret',
    ];

    final masked = <String, dynamic>{};
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (sensitiveKeys.any((sk) => key.toLowerCase().contains(sk.toLowerCase()))) {
        masked[key] = '***MASKED***';
      } else if (value is Map<String, dynamic>) {
        masked[key] = _maskSensitiveFields(value);
      } else if (value is List) {
        masked[key] = value.map((item) {
          if (item is Map<String, dynamic>) {
            return _maskSensitiveFields(item);
          }
          return item;
        }).toList();
      } else {
        masked[key] = value;
      }
    }

    return masked;
  }

  /// Mask sensitive fields in any JSON-like structure (Map/List).
  dynamic _maskSensitiveDynamic(dynamic value) {
    if (value is Map<String, dynamic>) {
      return _maskSensitiveFields(value);
    }
    if (value is Map) {
      // Convert keys to strings so masking logic can work consistently.
      final asStringMap = value.map((k, v) => MapEntry(k.toString(), v));
      return _maskSensitiveFields(Map<String, dynamic>.from(asStringMap));
    }
    if (value is List) {
      return value.map(_maskSensitiveDynamic).toList();
    }
    return value;
  }

  /// Mask sensitive headers
  Map<String, dynamic> _maskSensitiveHeaders(Map<String, dynamic> headers) {
    final masked = <String, dynamic>{};
    for (final entry in headers.entries) {
      final key = entry.key.toLowerCase();
      if (key == 'authorization' ||
          key == 'x-api-key' ||
          key == 'cookie' ||
          key == 'token') {
        masked[entry.key] = '***MASKED***';
      } else if (entry.value is List) {
        // Handle List values (from response headers)
        masked[entry.key] = entry.value;
      } else {
        masked[entry.key] = entry.value;
      }
    }
    return masked;
  }

  /// Mask sensitive string data
  String _maskSensitiveString(String data) {
    // Simple pattern matching for common sensitive data patterns
    return data
        .replaceAll(RegExp(r'(?:"password"\s*:\s*")([^"]+)'), '"password":"***MASKED***"')
        .replaceAll(RegExp(r'(?:"token"\s*:\s*")([^"]+)'), '"token":"***MASKED***"')
        .replaceAll(RegExp(r'(?:"accessToken"\s*:\s*")([^"]+)'), '"accessToken":"***MASKED***"')
        .replaceAll(RegExp(r'(?:"refreshToken"\s*:\s*")([^"]+)'), '"refreshToken":"***MASKED***"')
        .replaceAll(RegExp(r'Bearer\s+\w+'), 'Bearer ***MASKED***');
  }

  /// Format JSON data for logging
  String _formatJson(dynamic data) {
    try {
      // Use a JsonEncoder with indentation for better readability
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }

  /// Parse JSON string
  dynamic _parseJsonString(String jsonString) {
    try {
      return const JsonDecoder().convert(jsonString);
    } catch (e) {
      return null;
    }
  }

  /// Format headers for logging
  String _formatHeaders(Map<String, List<String>> headers) {
    final buffer = StringBuffer();
    for (final entry in headers.entries) {
      buffer.writeln('  ${entry.key}: ${entry.value.join(", ")}');
    }
    return buffer.toString();
  }

  /// Format FormData for logging
  String _formatFormData(FormData formData) {
    final buffer = StringBuffer();
    buffer.writeln('FormData:');
    
    // Log fields
    for (final field in formData.fields) {
      final value = _maskSensitiveData && _isSensitiveField(field.key)
          ? '***MASKED***'
          : field.value;
      buffer.writeln('  ${field.key}: $value');
    }
    
    // Log files (just names, not content)
    for (final file in formData.files) {
      buffer.writeln('  ${file.key}: [File: ${file.value.filename}]');
    }
    
    return buffer.toString();
  }

  /// Check if field name is sensitive
  bool _isSensitiveField(String fieldName) {
    final lower = fieldName.toLowerCase();
    return lower.contains('password') ||
        lower.contains('token') ||
        lower.contains('secret') ||
        lower.contains('apiKey') ||
        lower.contains('authorization');
  }
}
