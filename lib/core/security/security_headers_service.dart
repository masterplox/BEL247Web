import 'package:flutter/foundation.dart';

import 'csp_config.dart';

/// Service for managing security headers
class SecurityHeadersService {
  
  SecurityHeadersService._();
  static SecurityHeadersService? _instance;
  
  static SecurityHeadersService get instance {
    _instance ??= SecurityHeadersService._();
    return _instance!;
  }

  /// Get all security headers for web application
  Map<String, String> getAllSecurityHeaders() => {
      'Content-Security-Policy': CSPConfig.getCurrentCSPHeader(),
      'X-Frame-Options': 'DENY',
      'X-Content-Type-Options': 'nosniff',
      'X-XSS-Protection': '1; mode=block',
      'Referrer-Policy': 'strict-origin-when-cross-origin',
      'Permissions-Policy': _getPermissionsPolicy(),
      'Strict-Transport-Security': _getHSTSHeader(),
      'Cross-Origin-Embedder-Policy': 'require-corp',
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Resource-Policy': 'same-origin',
    };

  /// Get Content Security Policy header
  String getCSPHeader() => CSPConfig.getCurrentCSPHeader();

  /// Get X-Frame-Options header
  String getXFrameOptionsHeader() => 'DENY';

  /// Get X-Content-Type-Options header
  String getXContentTypeOptionsHeader() => 'nosniff';

  /// Get X-XSS-Protection header
  String getXXSSProtectionHeader() => '1; mode=block';

  /// Get Referrer-Policy header
  String getReferrerPolicyHeader() => 'strict-origin-when-cross-origin';

  /// Get Permissions-Policy header
  String getPermissionsPolicyHeader() => _getPermissionsPolicy();

  /// Get Strict-Transport-Security header
  String getHSTSHeader() => _getHSTSHeader();

  /// Get Cross-Origin headers
  Map<String, String> getCrossOriginHeaders() => {
      'Cross-Origin-Embedder-Policy': 'require-corp',
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Resource-Policy': 'same-origin',
    };

  /// Get Permissions-Policy configuration
  String _getPermissionsPolicy() => '''
      accelerometer=(), 
      ambient-light-sensor=(), 
      autoplay=(), 
      battery=(), 
      camera=(), 
      display-capture=(), 
      document-domain=(), 
      encrypted-media=(), 
      execution-while-not-rendered=(), 
      execution-while-out-of-viewport=(), 
      fullscreen=(self), 
      geolocation=(), 
      gyroscope=(), 
      keyboard-map=(), 
      magnetometer=(), 
      microphone=(), 
      midi=(), 
      navigation-override=(), 
      payment=(), 
      picture-in-picture=(), 
      publickey-credentials-get=(), 
      screen-wake-lock=(), 
      sync-xhr=(), 
      usb=(), 
      web-share=(), 
      xr-spatial-tracking=()
    '''.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Get HSTS header based on environment
  String _getHSTSHeader() {
    if (kDebugMode) {
      // In development, use shorter max-age
      return 'max-age=300; includeSubDomains; preload';
    } else {
      // In production, use longer max-age
      return 'max-age=31536000; includeSubDomains; preload';
    }
  }

  /// Get security headers for specific route
  Map<String, String> getHeadersForRoute(String route) {
    final baseHeaders = getAllSecurityHeaders();
    
    // Customize headers based on route
    switch (route) {
      case '/login':
        return {
          ...baseHeaders,
          'Content-Security-Policy': _getLoginCSP(),
        };
      case '/dashboard':
        return {
          ...baseHeaders,
          'Content-Security-Policy': _getDashboardCSP(),
        };
      case '/api/':
        return {
          ...baseHeaders,
          'Content-Security-Policy': _getAPICSP(),
        };
      default:
        return baseHeaders;
    }
  }

  /// Get CSP for login page
  String _getLoginCSP() => '''
      default-src 'self';
      script-src 'self' 'unsafe-inline';
      style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
      font-src 'self' https://fonts.gstatic.com;
      img-src 'self' data:;
      connect-src 'self';
      form-action 'self';
      frame-ancestors 'none';
      upgrade-insecure-requests;
    '''.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Get CSP for dashboard page
  String _getDashboardCSP() => '''
      default-src 'self';
      script-src 'self' 'unsafe-inline';
      style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
      font-src 'self' https://fonts.gstatic.com;
      img-src 'self' data: https:;
      connect-src 'self' https:;
      media-src 'self' data:;
      frame-ancestors 'none';
      upgrade-insecure-requests;
    '''.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Get CSP for API endpoints
  String _getAPICSP() => '''
      default-src 'none';
      connect-src 'self';
      frame-ancestors 'none';
    '''.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Validate security headers
  Map<String, dynamic> validateHeaders(Map<String, String> headers) {
    final validation = <String, dynamic>{};
    
    // Check for required headers
    final requiredHeaders = [
      'Content-Security-Policy',
      'X-Frame-Options',
      'X-Content-Type-Options',
      'X-XSS-Protection',
      'Referrer-Policy',
    ];
    
    final missingHeaders = <String>[];
    for (final header in requiredHeaders) {
      if (!headers.containsKey(header)) {
        missingHeaders.add(header);
      }
    }
    
    validation['missingHeaders'] = missingHeaders;
    validation['hasAllRequiredHeaders'] = missingHeaders.isEmpty;
    
    // Validate CSP
    final csp = headers['Content-Security-Policy'];
    if (csp != null) {
      validation['cspValid'] = CSPConfig.isValidCSP(csp);
    }
    
    // Check for security recommendations
    final recommendations = <String>[];
    if (!headers.containsKey('Strict-Transport-Security')) {
      recommendations.add('Add Strict-Transport-Security header for HTTPS enforcement');
    }
    
    if (!headers.containsKey('Permissions-Policy')) {
      recommendations.add('Add Permissions-Policy header to control browser features');
    }
    
    validation['recommendations'] = recommendations;
    
    return validation;
  }

  /// Get security score based on headers
  int getSecurityScore(Map<String, String> headers) {
    int score = 0;
    const maxScore = 10;
    
    // Required headers (5 points)
    final requiredHeaders = [
      'Content-Security-Policy',
      'X-Frame-Options',
      'X-Content-Type-Options',
      'X-XSS-Protection',
      'Referrer-Policy',
    ];
    
    for (final header in requiredHeaders) {
      if (headers.containsKey(header)) {
        score += 1;
      }
    }
    
    // Additional security headers (3 points)
    if (headers.containsKey('Strict-Transport-Security')) score += 1;
    if (headers.containsKey('Permissions-Policy')) score += 1;
    if (headers.containsKey('Cross-Origin-Embedder-Policy')) score += 1;
    
    // CSP validation (2 points)
    final csp = headers['Content-Security-Policy'];
    if (csp != null && CSPConfig.isValidCSP(csp)) {
      score += 1;
      if (!csp.contains("'unsafe-inline'") && !csp.contains("'unsafe-eval'")) {
        score += 1;
      }
    }
    
    return (score / maxScore * 100).round();
  }

  /// Get security report
  Map<String, dynamic> getSecurityReport() {
    final headers = getAllSecurityHeaders();
    final validation = validateHeaders(headers);
    final score = getSecurityScore(headers);
    
    return {
      'headers': headers,
      'validation': validation,
      'securityScore': score,
      'environment': kDebugMode ? 'development' : 'production',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
