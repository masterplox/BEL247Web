import 'package:flutter/foundation.dart';

/// Content Security Policy configuration for web security
class CSPConfig {
  static const String _defaultCSP = '''
    default-src 'self';
    script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.gstatic.com https://cdn.jsdelivr.net https://unpkg.com;
    style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
    font-src 'self' https://fonts.gstatic.com;
    img-src 'self' data: https: blob:;
    connect-src 'self' https: wss: ws:;
    media-src 'self' data: blob:;
    object-src 'none';
    child-src 'self' blob:;
    frame-src 'none';
    worker-src 'self' blob:;
    manifest-src 'self';
    base-uri 'self';
    form-action 'self';
    frame-ancestors 'none';
    upgrade-insecure-requests;
  ''';

  static const String _strictCSP = '''
    default-src 'self';
    script-src 'self' 'nonce-{NONCE}' https://www.gstatic.com;
    style-src 'self' 'nonce-{NONCE}' https://fonts.googleapis.com;
    font-src 'self' https://fonts.gstatic.com;
    img-src 'self' data: https:;
    connect-src 'self' https:;
    media-src 'self' data:;
    object-src 'none';
    child-src 'none';
    frame-src 'none';
    worker-src 'self';
    manifest-src 'self';
    base-uri 'self';
    form-action 'self';
    frame-ancestors 'none';
    upgrade-insecure-requests;
    block-all-mixed-content;
  ''';

  static const String _developmentCSP = '''
    default-src 'self' 'unsafe-inline' 'unsafe-eval';
    script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.gstatic.com https://cdn.jsdelivr.net;
    style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
    font-src 'self' https://fonts.gstatic.com;
    img-src 'self' data: https: blob:;
    connect-src 'self' https: http: wss: ws: localhost:* 127.0.0.1:*;
    media-src 'self' data: blob:;
    object-src 'none';
    child-src 'self' blob:;
    frame-src 'none';
    worker-src 'self' blob:;
    manifest-src 'self';
    base-uri 'self';
    form-action 'self';
    frame-ancestors 'none';
  ''';

  /// Get CSP header value based on environment
  static String getCSPHeader({bool isDevelopment = false, bool isStrict = false}) {
    if (isDevelopment) {
      return _developmentCSP.replaceAll(RegExp(r'\s+'), ' ').trim();
    } else if (isStrict) {
      return _strictCSP.replaceAll(RegExp(r'\s+'), ' ').trim();
    } else {
      return _defaultCSP.replaceAll(RegExp(r'\s+'), ' ').trim();
    }
  }

  /// Get CSP header for current environment
  static String getCurrentCSPHeader() => getCSPHeader(
      isDevelopment: kDebugMode,
      isStrict: !kDebugMode,
    );

  /// Generate a nonce for CSP
  static String generateNonce() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp * 1000 + (timestamp % 1000)).toString();
    return random.substring(0, 16);
  }

  /// Get CSP with nonce for strict mode
  static String getCSPWithNonce(String nonce) => _strictCSP.replaceAll('{NONCE}', nonce).replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Validate CSP header format
  static bool isValidCSP(String csp) {
    try {
      // Basic validation - check for required directives
      final requiredDirectives = [
        'default-src',
        'script-src',
        'style-src',
        'img-src',
        'connect-src',
      ];

      for (final directive in requiredDirectives) {
        if (!csp.contains(directive)) {
          return false;
        }
      }

      // Check for dangerous patterns
      final dangerousPatterns = [
        "'unsafe-inline'",
        "'unsafe-eval'",
        '*',
        'data:',
        'javascript:',
      ];

      // In strict mode, these patterns should be avoided
      for (final pattern in dangerousPatterns) {
        if (csp.contains(pattern) && !csp.contains('nonce-')) {
          // Allow unsafe patterns only in development or with nonce
          if (!kDebugMode) {
            return false;
          }
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get CSP violation report endpoint
  static String getReportEndpoint() => '/api/csp-violation-report';

  /// Get CSP with reporting enabled
  static String getCSPWithReporting(String baseCSP) {
    final reportEndpoint = getReportEndpoint();
    return '$baseCSP; report-uri $reportEndpoint; report-to csp-endpoint';
  }

  /// Parse CSP violations from report
  static Map<String, dynamic> parseViolationReport(Map<String, dynamic> report) {
    try {
      final cspReport = report['csp-report'] as Map<String, dynamic>?;
      if (cspReport == null) return {};

      return {
        'violatedDirective': cspReport['violated-directive'] as String?,
        'blockedURI': cspReport['blocked-uri'] as String?,
        'sourceFile': cspReport['source-file'] as String?,
        'lineNumber': cspReport['line-number'] as int?,
        'columnNumber': cspReport['column-number'] as int?,
        'disposition': cspReport['disposition'] as String?,
        'effectiveDirective': cspReport['effective-directive'] as String?,
        'originalPolicy': cspReport['original-policy'] as String?,
        'referrer': cspReport['referrer'] as String?,
        'statusCode': cspReport['status-code'] as int?,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Get CSP configuration for different environments
  static Map<String, String> getEnvironmentConfigs() => {
      'development': getCSPHeader(isDevelopment: true),
      'production': getCSPHeader(isDevelopment: false, isStrict: true),
      'staging': getCSPHeader(isDevelopment: false, isStrict: false),
    };

  /// Check if CSP is properly configured
  static Map<String, dynamic> validateCSPConfiguration() {
    final currentCSP = getCurrentCSPHeader();
    final isValid = isValidCSP(currentCSP);
    
    return {
      'isValid': isValid,
      'csp': currentCSP,
      'environment': kDebugMode ? 'development' : 'production',
      'recommendations': _getRecommendations(currentCSP),
    };
  }

  /// Get security recommendations based on CSP
  static List<String> _getRecommendations(String csp) {
    final recommendations = <String>[];

    if (csp.contains("'unsafe-inline'")) {
      recommendations.add('Consider using nonces instead of unsafe-inline for better security');
    }

    if (csp.contains("'unsafe-eval'")) {
      recommendations.add('Remove unsafe-eval in production for better security');
    }

    if (!csp.contains('upgrade-insecure-requests')) {
      recommendations.add('Add upgrade-insecure-requests to force HTTPS');
    }

    if (!csp.contains('block-all-mixed-content')) {
      recommendations.add('Add block-all-mixed-content to prevent mixed content');
    }

    if (csp.contains('frame-ancestors') && !csp.contains("'none'")) {
      recommendations.add('Consider setting frame-ancestors to none to prevent clickjacking');
    }

    return recommendations;
  }

  /// Get Flutter web specific CSP requirements
  static Map<String, List<String>> getFlutterWebRequirements() => {
      'script-src': [
        "'self'",
        "'unsafe-inline'", // Required for Flutter web
        "'unsafe-eval'", // Required for Flutter web
        'https://www.gstatic.com', // CanvasKit
      ],
      'connect-src': [
        "'self'",
        'https:', // For API calls
        'ws:', // WebSocket support
        'wss:', // Secure WebSocket support
        'localhost:*', // Development server
        '127.0.0.1:*', // Development server
      ],
      'font-src': [
        "'self'",
        'https://fonts.gstatic.com', // Google Fonts
      ],
      'style-src': [
        "'self'",
        "'unsafe-inline'", // Required for Flutter web
        'https://fonts.googleapis.com', // Google Fonts CSS
      ],
      'img-src': [
        "'self'",
        'data:', // Data URLs
        'blob:', // Blob URLs
        'https:', // External images
      ],
    };

  /// Validate CSP for Flutter web compatibility
  static Map<String, dynamic> validateFlutterWebCompatibility(String csp) {
    final requirements = getFlutterWebRequirements();
    final issues = <String>[];
    final warnings = <String>[];

    for (final entry in requirements.entries) {
      final directive = entry.key;
      final requiredSources = entry.value;

      if (!csp.contains(directive)) {
        issues.add('Missing required directive: $directive');
        continue;
      }

      for (final source in requiredSources) {
        if (!csp.contains(source)) {
          if (source == "'unsafe-inline'" || source == "'unsafe-eval'") {
            warnings.add('Missing $source in $directive - Flutter web may not work properly');
          } else {
            issues.add('Missing required source $source in $directive');
          }
        }
      }
    }

    return {
      'isCompatible': issues.isEmpty,
      'issues': issues,
      'warnings': warnings,
      'requirements': requirements,
    };
  }
}
