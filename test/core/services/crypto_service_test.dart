import 'package:bel247_web/core/services/crypto_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CryptoService Tests', () {
    late CryptoService cryptoService;

    setUpAll(() async {
      // Load environment variables
      // EnvConfig now reads from compile-time --dart-define values; no loading required
      cryptoService = CryptoService.instance;
    });

    test('should initialize successfully', () {
      expect(cryptoService, isNotNull);
      final info = cryptoService.getEncryptionInfo();
      expect(info['isInitialized'], isTrue);
      expect(info['algorithm'], equals('AES-256'));
    });

    test('should encrypt and decrypt strings correctly', () {
      const testString = 'Hello, World!';
      
      final encrypted = cryptoService.encryptString(testString);
      expect(encrypted, isNotEmpty);
      expect(encrypted, isNot(equals(testString)));
      
      final decrypted = cryptoService.decryptString(encrypted);
      expect(decrypted, equals(testString));
    });

    test('should encrypt and decrypt JSON objects correctly', () {
      final testJson = {
        'name': 'John Doe',
        'email': 'john@example.com',
        'age': 30,
        'isActive': true,
      };
      
      final encrypted = cryptoService.encryptJson(testJson);
      expect(encrypted, isNotEmpty);
      
      final decrypted = cryptoService.decryptJson(encrypted);
      expect(decrypted, equals(testJson));
    });

    test('should encrypt and decrypt query parameters correctly', () {
      final testParams = {
        'userId': '123',
        'token': 'abc123',
        'action': 'view',
      };
      
      final encrypted = cryptoService.encryptQueryParams(testParams);
      expect(encrypted, isNotEmpty);
      
      final decrypted = cryptoService.decryptQueryParams(encrypted);
      expect(decrypted, equals(testParams));
    });

    test('should encrypt and decrypt user data correctly', () {
      final testUserData = {
        'name': 'John Doe',
        'email': 'john@example.com',
        'phone': '+1234567890',
        'ssn': '123-45-6789',
        'address': '123 Main St',
        'paymentInfo': 'card123',
        'preferences': {'theme': 'dark'},
      };
      
      final encrypted = cryptoService.encryptUserData(testUserData);
      expect(encrypted, isNotEmpty);
      
      final decrypted = cryptoService.decryptUserData(encrypted);
      expect(decrypted['email'], equals('john@example.com'));
      expect(decrypted['phone'], equals('+1234567890'));
      expect(decrypted['ssn'], equals('123-45-6789'));
      expect(decrypted['address'], equals('123 Main St'));
      expect(decrypted['paymentInfo'], equals('card123'));
      // Non-sensitive data should not be included
      expect(decrypted.containsKey('name'), isFalse);
      expect(decrypted.containsKey('preferences'), isFalse);
    });

    test('should generate secure random strings', () {
      final randomString1 = cryptoService.generateSecureRandomString(16);
      final randomString2 = cryptoService.generateSecureRandomString(16);
      
      expect(randomString1.length, equals(16));
      expect(randomString2.length, equals(16));
      expect(randomString1, isNot(equals(randomString2)));
    });

    test('should validate encryption key strength', () {
      // Test weak keys
      expect(cryptoService.validateEncryptionKey('123456789012345'), isFalse); // Only numbers
      expect(cryptoService.validateEncryptionKey('abcdefghijklmnop'), isFalse); // Only letters
      expect(cryptoService.validateEncryptionKey('aaaaaaaaaaaaaaaa'), isFalse); // Repeated chars
      expect(cryptoService.validateEncryptionKey('short'), isFalse); // Too short
      
      // Test strong key
      expect(cryptoService.validateEncryptionKey('StrongKey123!@#'), isTrue);
    });

    test('should handle empty strings gracefully', () {
      expect(cryptoService.encryptString(''), equals(''));
      expect(cryptoService.decryptString(''), equals(''));
      expect(cryptoService.encryptQueryParams({}), equals(''));
      expect(cryptoService.decryptQueryParams(''), equals({}));
    });

    test('should throw CryptoException for invalid encrypted data', () {
      expect(
        () => cryptoService.decryptString('invalid_base64'),
        throwsA(isA<CryptoException>()),
      );
      
      expect(
        () => cryptoService.decryptJson('invalid_json'),
        throwsA(isA<CryptoException>()),
      );
    });

    test('should work with string extensions', () {
      const testString = 'Test String';
      
      final encrypted = testString.encrypt();
      expect(encrypted, isNotEmpty);
      
      final decrypted = encrypted.decrypt();
      expect(decrypted, equals(testString));
    });

    test('should work with map extensions', () {
      final testMap = {'key1': 'value1', 'key2': 'value2'};
      
      final encryptedJson = testMap.encryptJson();
      expect(encryptedJson, isNotEmpty);
      
      final encryptedParams = testMap.encryptQueryParams();
      expect(encryptedParams, isNotEmpty);
    });

    test('should produce different encrypted values for same input', () {
      const testString = 'Same Input';
      
      final encrypted1 = cryptoService.encryptString(testString);
      final encrypted2 = cryptoService.encryptString(testString);
      
      // Due to different IVs, encrypted values should be different
      expect(encrypted1, isNot(equals(encrypted2)));
      
      // But both should decrypt to the same value
      expect(cryptoService.decryptString(encrypted1), equals(testString));
      expect(cryptoService.decryptString(encrypted2), equals(testString));
    });
  });
}
