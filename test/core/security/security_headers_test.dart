import 'package:bel247_web/core/security/csp_config.dart';
import 'package:bel247_web/core/security/security_headers_service.dart';
import 'package:bel247_web/core/security/security_middleware_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CSP Configuration Tests', () {
    test('should generate valid CSP header for development', () {
      final csp = CSPConfig.getCSPHeader(isDevelopment: true);
      expect(csp, isNotEmpty);
      expect(csp, contains('default-src'));
      expect(csp, contains('script-src'));
      expect(csp, contains('style-src'));
    });

    test('should generate valid CSP header for production', () {
      final csp = CSPConfig.getCSPHeader(isDevelopment: false, isStrict: true);
      expect(csp, isNotEmpty);
      expect(csp, contains('default-src'));
      expect(csp, contains('script-src'));
      expect(csp, contains('style-src'));
    });

    test('should generate valid CSP header for staging', () {
      final csp = CSPConfig.getCSPHeader(isDevelopment: false, isStrict: false);
      expect(csp, isNotEmpty);
      expect(csp, contains('default-src'));
      expect(csp, contains('script-src'));
      expect(csp, contains('style-src'));
    });

    test('should generate nonce for CSP', () {
      final nonce = CSPConfig.generateNonce();
      expect(nonce, isNotEmpty);
      expect(nonce.length, equals(16));
    });

    test('should generate CSP with nonce', () {
      const nonce = 'test-nonce-123';
      final csp = CSPConfig.getCSPWithNonce(nonce);
      expect(csp, contains(nonce));
      expect(csp, contains('nonce-test-nonce-123'));
    });

    test('should validate CSP header format', () {
      const validCSP = "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self' https:;";
      const invalidCSP = 'invalid csp format';
      
      expect(CSPConfig.isValidCSP(validCSP), isTrue);
      expect(CSPConfig.isValidCSP(invalidCSP), isFalse);
    });

    test('should parse CSP violation report', () {
      final report = {
        'csp-report': {
          'violated-directive': 'script-src',
          'blocked-uri': 'https://evil.com/script.js',
          'source-file': 'https://example.com/page.html',
          'line-number': 10,
          'column-number': 5,
          'disposition': 'enforce',
          'effective-directive': 'script-src',
          'original-policy': "default-src 'self'; script-src 'self';",
          'referrer': 'https://example.com/',
          'status-code': 200,
        }
      };
      
      final parsed = CSPConfig.parseViolationReport(report);
      expect(parsed['violatedDirective'], equals('script-src'));
      expect(parsed['blockedURI'], equals('https://evil.com/script.js'));
      expect(parsed['sourceFile'], equals('https://example.com/page.html'));
    });

    test('should get environment configurations', () {
      final configs = CSPConfig.getEnvironmentConfigs();
      expect(configs, containsPair('development', isA<String>()));
      expect(configs, containsPair('production', isA<String>()));
      expect(configs, containsPair('staging', isA<String>()));
    });

    test('should validate CSP configuration', () {
      final validation = CSPConfig.validateCSPConfiguration();
      expect(validation, containsPair('isValid', isA<bool>()));
      expect(validation, containsPair('csp', isA<String>()));
      expect(validation, containsPair('environment', isA<String>()));
      expect(validation, containsPair('recommendations', isA<List>()));
    });
  });

  group('Security Headers Service Tests', () {
    late SecurityHeadersService service;

    setUp(() {
      service = SecurityHeadersService.instance;
    });

    test('should get all security headers', () {
      final headers = service.getAllSecurityHeaders();
      expect(headers, isNotEmpty);
      expect(headers, containsPair('Content-Security-Policy', isA<String>()));
      expect(headers, containsPair('X-Frame-Options', equals('DENY')));
      expect(headers, containsPair('X-Content-Type-Options', equals('nosniff')));
      expect(headers, containsPair('X-XSS-Protection', equals('1; mode=block')));
    });

    test('should get CSP header', () {
      final csp = service.getCSPHeader();
      expect(csp, isNotEmpty);
      expect(csp, contains('default-src'));
    });

    test('should get X-Frame-Options header', () {
      final header = service.getXFrameOptionsHeader();
      expect(header, equals('DENY'));
    });

    test('should get X-Content-Type-Options header', () {
      final header = service.getXContentTypeOptionsHeader();
      expect(header, equals('nosniff'));
    });

    test('should get X-XSS-Protection header', () {
      final header = service.getXXSSProtectionHeader();
      expect(header, equals('1; mode=block'));
    });

    test('should get Referrer-Policy header', () {
      final header = service.getReferrerPolicyHeader();
      expect(header, equals('strict-origin-when-cross-origin'));
    });

    test('should get Permissions-Policy header', () {
      final header = service.getPermissionsPolicyHeader();
      expect(header, isNotEmpty);
      expect(header, contains('accelerometer=()'));
      expect(header, contains('camera=()'));
    });

    test('should get HSTS header', () {
      final header = service.getHSTSHeader();
      expect(header, isNotEmpty);
      expect(header, contains('max-age'));
      expect(header, contains('includeSubDomains'));
    });

    test('should get cross-origin headers', () {
      final headers = service.getCrossOriginHeaders();
      expect(headers, containsPair('Cross-Origin-Embedder-Policy', equals('require-corp')));
      expect(headers, containsPair('Cross-Origin-Opener-Policy', equals('same-origin')));
      expect(headers, containsPair('Cross-Origin-Resource-Policy', equals('same-origin')));
    });

    test('should get headers for specific routes', () {
      final loginHeaders = service.getHeadersForRoute('/login');
      final dashboardHeaders = service.getHeadersForRoute('/dashboard');
      final apiHeaders = service.getHeadersForRoute('/api/');
      
      expect(loginHeaders, isNotEmpty);
      expect(dashboardHeaders, isNotEmpty);
      expect(apiHeaders, isNotEmpty);
      
      expect(loginHeaders['Content-Security-Policy'], isNotEmpty);
      expect(dashboardHeaders['Content-Security-Policy'], isNotEmpty);
      expect(apiHeaders['Content-Security-Policy'], isNotEmpty);
    });

    test('should validate security headers', () {
      final headers = service.getAllSecurityHeaders();
      final validation = service.validateHeaders(headers);
      
      expect(validation, containsPair('hasAllRequiredHeaders', isA<bool>()));
      expect(validation, containsPair('missingHeaders', isA<List>()));
      expect(validation, containsPair('cspValid', isA<bool>()));
      expect(validation, containsPair('recommendations', isA<List>()));
    });

    test('should calculate security score', () {
      final headers = service.getAllSecurityHeaders();
      final score = service.getSecurityScore(headers);
      
      expect(score, isA<int>());
      expect(score, greaterThanOrEqualTo(0));
      expect(score, lessThanOrEqualTo(100));
    });

    test('should generate security report', () {
      final report = service.getSecurityReport();
      
      expect(report, containsPair('headers', isA<Map>()));
      expect(report, containsPair('validation', isA<Map>()));
      expect(report, containsPair('securityScore', isA<int>()));
      expect(report, containsPair('environment', isA<String>()));
      expect(report, containsPair('timestamp', isA<String>()));
    });
  });

  group('Security Middleware Service Tests', () {
    late SecurityMiddlewareService service;

    setUp(() {
      service = SecurityMiddlewareService.instance;
    });

    test('should handle CSP violation event', () {
      final report = {
        'violated-directive': 'script-src',
        'blocked-uri': 'https://evil.com/script.js',
        'source-file': 'https://example.com/page.html',
      };
      
      // This test just ensures the method doesn't throw
      expect(() => service.handleSecurityEvent('csp_violation', report), returnsNormally);
    });

    test('should get security status', () {
      final status = service.getSecurityStatus();
      expect(status, containsPair('isInitialized', isTrue));
      expect(status, containsPair('isHTTPS', isA<bool>()));
      expect(status, containsPair('isSecureConnection', isA<bool>()));
      expect(status, containsPair('hasSecurityHeaders', isTrue));
      expect(status, containsPair('hasCSP', isTrue));
      expect(status, containsPair('hasHSTS', isTrue));
    });

    test('should get comprehensive security report', () {
      final report = service.getSecurityReport();
      expect(report, containsPair('timestamp', isA<String>()));
      expect(report, containsPair('environment', isA<String>()));
      expect(report, containsPair('https', isA<Map>()));
      expect(report, containsPair('headers', isA<Map>()));
      expect(report, containsPair('csp', isA<Map>()));
      expect(report, containsPair('overallSecurityScore', isA<int>()));
      expect(report, containsPair('recommendations', isA<List>()));
    });

    test('should handle different security events', () {
      final mixedContentEvent = {
        'url': 'http://insecure.example.com',
        'type': 'mixed_content',
      };
      
      final insecureRequestEvent = {
        'url': 'http://example.com',
        'type': 'insecure_request',
      };
      
      // These tests just ensure the methods don't throw
      expect(() => service.handleSecurityEvent('mixed_content', mixedContentEvent), returnsNormally);
      expect(() => service.handleSecurityEvent('insecure_request', insecureRequestEvent), returnsNormally);
    });
  });
}
