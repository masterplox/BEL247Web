import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

import 'web_operations.dart';

/// Web-specific implementation for web platforms
class WebWebOperations implements WebOperations {
  @override
  bool get isHTTPS {
    if (kIsWeb) {
      return html.window.location.protocol == 'https:';
    }
    return true;
  }

  @override
  bool get isSecureConnection {
    if (kIsWeb) {
      return isHTTPS || html.window.location.hostname == 'localhost';
    }
    return true;
  }

  @override
  String get currentProtocol {
    if (kIsWeb) {
      return html.window.location.protocol;
    }
    return 'https:';
  }

  @override
  String get currentHostname {
    if (kIsWeb) {
      return html.window.location.hostname ?? 'localhost';
    }
    return 'localhost';
  }

  @override
  String get currentPort {
    if (kIsWeb) {
      return html.window.location.port;
    }
    return '443';
  }

  @override
  String get currentOrigin {
    if (kIsWeb) {
      return html.window.location.origin;
    }
    return 'https://localhost';
  }

  @override
  void enforceHTTPS() {
    if (kIsWeb && !isSecureConnection) {
      final httpsUrl = 'https://${html.window.location.host}${html.window.location.pathname}${html.window.location.search}';
      html.window.location.href = httpsUrl;
    }
  }

  @override
  List<String> checkMixedContent() {
    final issues = <String>[];
    
    if (kIsWeb && isHTTPS) {
      final scripts = html.document.querySelectorAll('script[src]');
      for (final script in scripts) {
        final src = script.attributes['src'];
        if (src != null && src.startsWith('http://')) {
          issues.add('Mixed content detected: HTTP script source: $src');
        }
      }

      final links = html.document.querySelectorAll('link[href]');
      for (final link in links) {
        final href = link.attributes['href'];
        if (href != null && href.startsWith('http://')) {
          issues.add('Mixed content detected: HTTP link href: $href');
        }
      }

      final images = html.document.querySelectorAll('img[src]');
      for (final image in images) {
        final src = image.attributes['src'];
        if (src != null && src.startsWith('http://')) {
          issues.add('Mixed content detected: HTTP image source: $src');
        }
      }
    }

    return issues;
  }

  @override
  void upgradeInsecureRequests() {
    if (kIsWeb && isHTTPS) {
      final metaCSP = html.document.querySelector('meta[http-equiv="Content-Security-Policy"]');
      if (metaCSP != null) {
        final content = metaCSP.attributes['content'] ?? '';
        if (!content.contains('upgrade-insecure-requests')) {
          metaCSP.attributes['content'] = '$content; upgrade-insecure-requests';
        }
      }
    }
  }

  @override
  void blockMixedContent() {
    if (kIsWeb && isHTTPS) {
      final metaCSP = html.document.querySelector('meta[http-equiv="Content-Security-Policy"]');
      if (metaCSP != null) {
        final content = metaCSP.attributes['content'] ?? '';
        if (!content.contains('block-all-mixed-content')) {
          metaCSP.attributes['content'] = '$content; block-all-mixed-content';
        }
      }
    }
  }

  @override
  void setHSTSHeader({int maxAge = 31536000, bool includeSubDomains = true, bool preload = true}) {
    if (kIsWeb) {
      final hstsValue = 'max-age=$maxAge${includeSubDomains ? '; includeSubDomains' : ''}${preload ? '; preload' : ''}';
      
      final metaHSTS = html.document.querySelector('meta[http-equiv="Strict-Transport-Security"]');
      if (metaHSTS != null) {
        metaHSTS.attributes['content'] = hstsValue;
      } else {
        final meta = html.MetaElement()
          ..httpEquiv = 'Strict-Transport-Security'
          ..content = hstsValue;
        html.document.head?.append(meta);
      }
    }
  }

  @override
  Map<String, dynamic> validateHTTPSConfiguration() {
    final issues = <String>[];
    final warnings = <String>[];
    final recommendations = <String>[];

    if (!isHTTPS && !kDebugMode) {
      issues.add('Application is not running on HTTPS');
    }

    final mixedContentIssues = checkMixedContent();
    issues.addAll(mixedContentIssues);

    if (kIsWeb) {
      final hstsMeta = html.document.querySelector('meta[http-equiv="Strict-Transport-Security"]');
      if (hstsMeta == null) {
        warnings.add('HSTS header not found');
      } else {
        final hstsContent = hstsMeta.attributes['content'] ?? '';
        if (!hstsContent.contains('includeSubDomains')) {
          recommendations.add('Consider adding includeSubDomains to HSTS header');
        }
        if (!hstsContent.contains('preload')) {
          recommendations.add('Consider adding preload to HSTS header for better security');
        }
      }

      final cspMeta = html.document.querySelector('meta[http-equiv="Content-Security-Policy"]');
      if (cspMeta != null) {
        final cspContent = cspMeta.attributes['content'] ?? '';
        if (!cspContent.contains('upgrade-insecure-requests')) {
          recommendations.add('Add upgrade-insecure-requests to CSP for HTTPS enforcement');
        }
        if (!cspContent.contains('block-all-mixed-content')) {
          recommendations.add('Add block-all-mixed-content to CSP to prevent mixed content');
        }
      }

      final cookies = html.document.cookie?.split(';') ?? [];
      for (final cookie in cookies) {
        if (!cookie.contains('Secure') && !cookie.contains('HttpOnly')) {
          warnings.add('Cookie without Secure flag: ${cookie.split('=')[0]}');
        }
      }
    }

    return {
      'isHTTPS': isHTTPS,
      'isSecureConnection': isSecureConnection,
      'currentProtocol': currentProtocol,
      'currentHostname': currentHostname,
      'currentPort': currentPort,
      'currentOrigin': currentOrigin,
      'issues': issues,
      'warnings': warnings,
      'recommendations': recommendations,
      'hasHSTS': kIsWeb ? html.document.querySelector('meta[http-equiv="Strict-Transport-Security"]') != null : true,
      'hasCSP': kIsWeb ? html.document.querySelector('meta[http-equiv="Content-Security-Policy"]') != null : true,
      'mixedContentIssues': mixedContentIssues.length,
      'securityScore': _calculateSecurityScore(issues, warnings),
    };
  }

  int _calculateSecurityScore(List<String> issues, List<String> warnings) {
    int score = 100;
    score -= issues.length * 20;
    score -= warnings.length * 10;
    return score.clamp(0, 100);
  }

  @override
  Map<String, dynamic> getHTTPSReport() {
    final validation = validateHTTPSConfiguration();
    final mixedContentIssues = checkMixedContent();

    return {
      'timestamp': DateTime.now().toIso8601String(),
      'environment': kDebugMode ? 'development' : 'production',
      'validation': validation,
      'mixedContentIssues': mixedContentIssues,
      'recommendations': _getHTTPSRecommendations(),
    };
  }

  List<String> _getHTTPSRecommendations() {
    final recommendations = <String>[];

    if (!isHTTPS && !kDebugMode) {
      recommendations.add('Deploy application on HTTPS in production');
    }

    recommendations.add('Ensure all external resources use HTTPS');
    recommendations.add('Use HSTS with preload for better security');
    recommendations.add('Implement certificate pinning for mobile apps');
    recommendations.add('Regularly audit SSL/TLS configuration');
    recommendations.add('Monitor for mixed content issues');

    return recommendations;
  }

  @override
  Map<String, String> getHTTPSHeaders() {
    final headers = <String, String>{};

    if (isHTTPS) {
      headers['Strict-Transport-Security'] = kDebugMode 
          ? 'max-age=300; includeSubDomains; preload'
          : 'max-age=31536000; includeSubDomains; preload';
    }

    headers['X-Content-Type-Options'] = 'nosniff';
    headers['X-Frame-Options'] = 'DENY';
    headers['X-XSS-Protection'] = '1; mode=block';
    headers['Referrer-Policy'] = 'strict-origin-when-cross-origin';

    return headers;
  }

  @override
  void startHTTPSMonitoring() {
    if (kIsWeb) {
      Timer.periodic(const Duration(seconds: 30), (timer) {
        if (!isSecureConnection && !kDebugMode) {
          print('Warning: Application is not running on HTTPS');
        }
      });
    }
  }
}
