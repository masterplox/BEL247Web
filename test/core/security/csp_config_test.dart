import 'package:bel247_web/core/security/csp_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CSPConfig', () {
    test('should generate valid CSP headers', () {
      final developmentCSP = CSPConfig.getCSPHeader(isDevelopment: true);
      final productionCSP = CSPConfig.getCSPHeader(isDevelopment: false);
      final strictCSP = CSPConfig.getCSPHeader(isDevelopment: false, isStrict: true);

      expect(CSPConfig.isValidCSP(developmentCSP), isTrue);
      expect(CSPConfig.isValidCSP(productionCSP), isTrue);
      expect(CSPConfig.isValidCSP(strictCSP), isTrue);
    });

    test('should include Flutter web requirements in development CSP', () {
      final developmentCSP = CSPConfig.getCSPHeader(isDevelopment: true);
      
      // Check for Flutter web requirements
      expect(developmentCSP.contains("'unsafe-inline'"), isTrue);
      expect(developmentCSP.contains("'unsafe-eval'"), isTrue);
      expect(developmentCSP.contains('https://www.gstatic.com'), isTrue);
      expect(developmentCSP.contains('https://fonts.gstatic.com'), isTrue);
      expect(developmentCSP.contains('localhost:*'), isTrue);
      expect(developmentCSP.contains('127.0.0.1:*'), isTrue);
    });

    test('should validate Flutter web compatibility', () {
      final developmentCSP = CSPConfig.getCSPHeader(isDevelopment: true);
      final validation = CSPConfig.validateFlutterWebCompatibility(developmentCSP);
      
      expect(validation['isCompatible'], isTrue);
      expect(validation['issues'], isEmpty);
    });

    test('should generate nonce', () {
      final nonce1 = CSPConfig.generateNonce();
      final nonce2 = CSPConfig.generateNonce();
      
      expect(nonce1, isNotEmpty);
      expect(nonce2, isNotEmpty);
      expect(nonce1.length, equals(16));
      expect(nonce2.length, equals(16));
      // Nonces should be different
      expect(nonce1, isNot(equals(nonce2)));
    });

    test('should generate CSP with nonce', () {
      const nonce = 'test-nonce-123';
      final cspWithNonce = CSPConfig.getCSPWithNonce(nonce);
      
      expect(cspWithNonce.contains('nonce-test-nonce-123'), isTrue);
    });

    test('should provide environment configurations', () {
      final configs = CSPConfig.getEnvironmentConfigs();
      
      expect(configs.containsKey('development'), isTrue);
      expect(configs.containsKey('production'), isTrue);
      expect(configs.containsKey('staging'), isTrue);
      
      expect(configs['development'], isNotEmpty);
      expect(configs['production'], isNotEmpty);
      expect(configs['staging'], isNotEmpty);
    });

    test('should validate CSP configuration', () {
      final validation = CSPConfig.validateCSPConfiguration();
      
      expect(validation.containsKey('isValid'), isTrue);
      expect(validation.containsKey('csp'), isTrue);
      expect(validation.containsKey('environment'), isTrue);
      expect(validation.containsKey('recommendations'), isTrue);
      
      expect(validation['isValid'], isTrue);
      expect(validation['csp'], isNotEmpty);
    });

    test('should get Flutter web requirements', () {
      final requirements = CSPConfig.getFlutterWebRequirements();
      
      expect(requirements.containsKey('script-src'), isTrue);
      expect(requirements.containsKey('connect-src'), isTrue);
      expect(requirements.containsKey('font-src'), isTrue);
      expect(requirements.containsKey('style-src'), isTrue);
      expect(requirements.containsKey('img-src'), isTrue);
      
      expect(requirements['script-src'], contains("'unsafe-inline'"));
      expect(requirements['script-src'], contains("'unsafe-eval'"));
      expect(requirements['script-src'], contains('https://www.gstatic.com'));
    });

    test('should parse violation reports', () {
      final report = {
        'csp-report': {
          'violated-directive': 'script-src',
          'blocked-uri': 'https://example.com/script.js',
          'source-file': 'https://example.com/page.html',
          'line-number': 10,
          'column-number': 5,
          'disposition': 'enforce',
          'effective-directive': 'script-src',
          'original-policy': 'script-src \'self\'',
          'referrer': 'https://example.com/',
          'status-code': 200,
        }
      };
      
      final parsed = CSPConfig.parseViolationReport(report);
      
      expect(parsed['violatedDirective'], equals('script-src'));
      expect(parsed['blockedURI'], equals('https://example.com/script.js'));
      expect(parsed['sourceFile'], equals('https://example.com/page.html'));
      expect(parsed['lineNumber'], equals(10));
      expect(parsed['timestamp'], isNotEmpty);
    });
  });
}
