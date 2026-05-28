import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Logger {
  static const String _appName = 'BEL247';
  
  static void debug(String message, {String? tag}) {
    // debugPrint('DEBUG: $message');
    if (kDebugMode) {
      developer.log(
        message,
        name: tag ?? _appName,
        level: 500, // DEBUG level
      );
    }
  }
  
  static void info(String message, {String? tag}) {
    // debugPrint('INFO: $message');
    developer.log(
      message,
      name: tag ?? _appName,
      level: 800, // INFO level
    );
  }
  
  static void warning(String message, {String? tag}) {
    // debugPrint('WARNING: $message');
    developer.log(
      message,
      name: tag ?? _appName,
      level: 900, // WARNING level
    );
  }
  
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    // debugPrint('ERROR: $message');
    developer.log(
      message,
      name: tag ?? _appName,
      level: 1000, // ERROR level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  static void api(String method, String url, {Map<String, dynamic>? data, int? statusCode}) {
    final message = 'API $method $url${statusCode != null ? ' - Status: $statusCode' : ''}';
    if (data != null) {
      debug('$message - Data: $data', tag: 'API');
    } else {
      debug(message, tag: 'API');
    }
  }
}
