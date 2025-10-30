import 'package:bel247_web/core/services/input_validator_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputValidatorService', () {
    late InputValidatorService validator;

    setUp(() {
      validator = InputValidatorService();
    });

    group('Email Validation', () {
      test('should validate correct email addresses', () {
        final validEmails = [
          'test@example.com',
          'user.name@domain.co.uk',
          'user+tag@example.org',
          'test123@test-domain.com',
        ];

        for (final email in validEmails) {
          final result = validator.validateEmail(email);
          expect(result.isValid, true, reason: 'Email "$email" should be valid');
          expect(result.errorMessage, isNull);
          expect(result.sanitizedValue, isNotNull);
        }
      });

      test('should reject invalid email addresses', () {
        final invalidEmails = [
          '',
          'invalid-email',
          '@example.com',
          'test@',
          'test..test@example.com',
          'test@example',
        ];

        for (final email in invalidEmails) {
          final result = validator.validateEmail(email);
          expect(result.isValid, false, reason: 'Email "$email" should be invalid');
          expect(result.errorMessage, isNotNull);
        }
      });

      test('should detect XSS attempts in email', () {
        final xssEmails = [
          'test@example.com<script>alert("xss")</script>',
          'test@example.com<img src=x onerror=alert(1)>',
          'test@example.com"onmouseover="alert(1)',
        ];

        for (final email in xssEmails) {
          final result = validator.validateEmail(email);
          expect(result.isValid, false, reason: 'Email "$email" should be rejected for XSS');
          expect(result.errorMessage, 'Invalid characters detected');
        }
      });

      test('should sanitize email addresses', () {
        final result = validator.validateEmail('  TEST@EXAMPLE.COM  ');
        expect(result.isValid, true);
        expect(result.sanitizedValue, 'test@example.com');
      });
    });

    group('Phone Number Validation', () {
      test('should validate correct phone numbers', () {
        final validPhones = [
          '1234567890',
          '+1234567890',
          '123-456-7890',
          '(123) 456-7890',
          '+1 (123) 456-7890',
        ];

        for (final phone in validPhones) {
          final result = validator.validatePhoneNumber(phone);
          expect(result.isValid, true, reason: 'Phone "$phone" should be valid');
          expect(result.errorMessage, isNull);
          expect(result.sanitizedValue, isNotNull);
        }
      });

      test('should reject invalid phone numbers', () {
        final invalidPhones = [
          '',
          '123',
          'abc1234567',
          '123-abc-7890',
          '+',
        ];

        for (final phone in invalidPhones) {
          final result = validator.validatePhoneNumber(phone);
          expect(result.isValid, false, reason: 'Phone "$phone" should be invalid');
          expect(result.errorMessage, isNotNull);
        }
      });

      test('should detect XSS attempts in phone numbers', () {
        final xssPhones = [
          '1234567890<script>alert("xss")</script>',
          '1234567890<img src=x onerror=alert(1)>',
        ];

        for (final phone in xssPhones) {
          final result = validator.validatePhoneNumber(phone);
          expect(result.isValid, false, reason: 'Phone "$phone" should be rejected for XSS');
          expect(result.errorMessage, 'Invalid characters detected');
        }
      });

      test('should clean phone number formatting', () {
        final result = validator.validatePhoneNumber('(123) 456-7890');
        expect(result.isValid, true);
        expect(result.sanitizedValue, '1234567890');
      });
    });

    group('Amount Validation', () {
      test('should validate correct amounts', () {
        final validAmounts = [
          '100',
          '100.50',
          '1,000.00',
          r'$500',
          ' 250.75 ',
        ];

        for (final amount in validAmounts) {
          final result = validator.validateAmount(amount);
          expect(result.isValid, true, reason: 'Amount "$amount" should be valid');
          expect(result.errorMessage, isNull);
          expect(result.sanitizedValue, isNotNull);
        }
      });

      test('should reject invalid amounts', () {
        final invalidAmounts = [
          '',
          'abc',
          '100.999',
          '100.5.5',
          '-100',
          '1000000.00', // Exceeds max amount
        ];

        for (final amount in invalidAmounts) {
          final result = validator.validateAmount(amount);
          expect(result.isValid, false, reason: 'Amount "$amount" should be invalid');
          expect(result.errorMessage, isNotNull);
        }
      });

      test('should detect XSS attempts in amounts', () {
        final xssAmounts = [
          '100<script>alert("xss")</script>',
          '100<img src=x onerror=alert(1)>',
        ];

        for (final amount in xssAmounts) {
          final result = validator.validateAmount(amount);
          expect(result.isValid, false, reason: 'Amount "$amount" should be rejected for XSS');
          expect(result.errorMessage, 'Invalid characters detected');
        }
      });

      test('should clean amount formatting', () {
        final result = validator.validateAmount(r'$1,000.50');
        expect(result.isValid, true);
        expect(result.sanitizedValue, '1000.50');
      });
    });

    group('Password Validation', () {
      test('should validate strong passwords', () {
        final strongPasswords = [
          'Password123!',
          'MyStr0ng#Pass',
          'Test123@Pass',
        ];

        for (final password in strongPasswords) {
          final result = validator.validatePassword(password);
          expect(result.isValid, true, reason: 'Password should be valid');
          expect(result.errorMessage, isNull);
        }
      });

      test('should reject weak passwords', () {
        final weakPasswords = [
          '',
          '1234567', // Too short
          'password', // No numbers, special chars, or uppercase
          'PASSWORD', // No lowercase, numbers, or special chars
          'Password', // No numbers or special chars
          'Password123', // No special chars
        ];

        for (final password in weakPasswords) {
          final result = validator.validatePassword(password);
          expect(result.isValid, false, reason: 'Password "$password" should be invalid');
          expect(result.errorMessage, isNotNull);
        }
      });

      test('should detect XSS attempts in passwords', () {
        final xssPasswords = [
          'Password123<script>alert("xss")</script>',
          'Password123<img src=x onerror=alert(1)>',
        ];

        for (final password in xssPasswords) {
          final result = validator.validatePassword(password);
          expect(result.isValid, false, reason: 'Password should be rejected for XSS');
          expect(result.errorMessage, 'Invalid characters detected');
        }
      });
    });

    group('Text Validation', () {
      test('should validate text with length constraints', () {
        final result = validator.validateText(
          'Valid text',
          minLength: 5,
          maxLength: 20,
          fieldName: 'Name',
        );
        expect(result.isValid, true);
        expect(result.errorMessage, isNull);
      });

      test('should reject text that is too short', () {
        final result = validator.validateText(
          'Hi',
          minLength: 5,
          maxLength: 20,
          fieldName: 'Name',
        );
        expect(result.isValid, false);
        expect(result.errorMessage, 'Name must be at least 5 characters long');
      });

      test('should reject text that is too long', () {
        final result = validator.validateText(
          'This is a very long text that exceeds the maximum length',
          minLength: 5,
          maxLength: 20,
          fieldName: 'Name',
        );
        expect(result.isValid, false);
        expect(result.errorMessage, 'Name cannot exceed 20 characters');
      });

      test('should allow empty text when specified', () {
        final result = validator.validateText(
          '',
          minLength: 5,
          maxLength: 20,
          fieldName: 'Optional',
          allowEmpty: true,
        );
        expect(result.isValid, true);
      });
    });

    group('XSS Prevention', () {
      test('should sanitize HTML tags', () {
        const input = 'Hello <b>world</b>!';
        final sanitized = validator.sanitizeInput(input);
        expect(sanitized, 'Hello world!');
      });

      test('should remove script tags', () {
        const input = 'Hello <script>alert("xss")</script> world!';
        final sanitized = validator.sanitizeInput(input);
        expect(sanitized, 'Hello  world!');
      });

      test('should escape dangerous characters', () {
        const input = 'Test <>"\'& characters';
        final sanitized = validator.sanitizeInput(input);
        expect(sanitized, 'Test &lt;&gt;&quot;&#x27;&amp; characters');
      });
    });

    group('Form Data Validation', () {
      test('should validate complete form data', () {
        final formData = {
          'email': 'test@example.com',
          'phone': '1234567890',
          'amount': '100.50',
          'password': 'Password123!',
          'name': 'John Doe',
        };

        final results = validator.validateFormData(formData);
        expect(results.length, 5);
        expect(validator.isFormValid(results), true);
        expect(validator.getErrorMessages(results), isEmpty);
      });

      test('should detect invalid form data', () {
        final formData = {
          'email': 'invalid-email',
          'phone': 'abc123',
          'amount': 'invalid-amount',
          'password': 'weak',
          'name': '',
        };

        final results = validator.validateFormData(formData);
        expect(validator.isFormValid(results), false);
        expect(validator.getErrorMessages(results).length, greaterThan(0));
      });
    });

    group('Extension Methods', () {
      test('should work with string extension methods', () {
        expect('test@example.com'.validateAsEmail().isValid, true);
        expect('1234567890'.validateAsPhoneNumber().isValid, true);
        expect('100.50'.validateAsAmount().isValid, true);
        expect('Password123!'.validateAsPassword().isValid, true);
        
        final sanitized = 'Hello <b>world</b>!'.sanitize();
        expect(sanitized, 'Hello world!');
      });
    });
  });
}
