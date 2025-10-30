import 'package:bel247_web/core/services/url_encryption_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UrlEncryptionService urlEncryptionService;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // EnvConfig now reads from compile-time --dart-define values; no loading required
    urlEncryptionService = UrlEncryptionService.instance;
  });

  group('UrlEncryptionService Tests', () {
    test('should initialize successfully', () {
      expect(() => UrlEncryptionService.instance, returnsNormally);
    });

    test('should encrypt and decrypt query parameters correctly', () {
      final originalParams = {'userId': '123', 'billId': 'abc', 'amount': '150.0'};
      final encrypted = urlEncryptionService.encryptQueryParams(originalParams);
      final decrypted = urlEncryptionService.decryptQueryParams(encrypted);
      
      expect(decrypted['userId'], equals(originalParams['userId']));
      expect(decrypted['billId'], equals(originalParams['billId']));
      expect(decrypted['amount'], equals(originalParams['amount']));
      expect(encrypted, isNot(equals(originalParams.toString())));
    });

    test('should encrypt and decrypt single parameters correctly', () {
      const original = 'sensitive-data-123';
      final encrypted = urlEncryptionService.encryptParameter(original);
      final decrypted = urlEncryptionService.decryptParameter(encrypted);
      
      expect(decrypted, equals(original));
      expect(encrypted, isNot(equals(original)));
    });

    test('should create encrypted URLs correctly', () {
      const baseUrl = 'https://example.com/bills';
      final params = {'userId': '123', 'billId': 'abc'};
      final encryptedUrl = urlEncryptionService.createEncryptedUrl(baseUrl, params);
      
      expect(encryptedUrl, contains('enc='));
      expect(encryptedUrl, startsWith(baseUrl));
    });

    test('should parse encrypted URLs correctly', () {
      const baseUrl = 'https://example.com/bills';
      final params = {'userId': '123', 'billId': 'abc'};
      final encryptedUrl = urlEncryptionService.createEncryptedUrl(baseUrl, params);
      final parsedParams = urlEncryptionService.parseEncryptedUrl(encryptedUrl);
      
      expect(parsedParams['userId'], equals(params['userId']));
      expect(parsedParams['billId'], equals(params['billId']));
    });

    test('should handle empty parameters gracefully', () {
      expect(urlEncryptionService.encryptQueryParams({}), isEmpty);
      expect(urlEncryptionService.decryptQueryParams(''), isEmpty);
      expect(urlEncryptionService.createEncryptedUrl('https://example.com', {}), equals('https://example.com'));
    });

    test('should handle empty parameter values gracefully', () {
      expect(urlEncryptionService.encryptParameter(''), isEmpty);
      expect(urlEncryptionService.decryptParameter(''), isEmpty);
    });

    test('should detect encrypted parameters in URLs', () {
      const baseUrl = 'https://example.com/bills';
      final params = {'userId': '123'};
      final encryptedUrl = urlEncryptionService.createEncryptedUrl(baseUrl, params);
      const regularUrl = 'https://example.com/bills?userId=123';
      
      expect(urlEncryptionService.hasEncryptedParams(encryptedUrl), isTrue);
      expect(urlEncryptionService.hasEncryptedParams(regularUrl), isFalse);
    });

    test('should add encrypted parameters to existing path', () {
      const currentPath = 'https://example.com/bills?existing=value';
      final params = {'userId': '123'};
      final newPath = urlEncryptionService.addEncryptedParams(currentPath, params);
      
      expect(newPath, contains('enc='));
      expect(newPath, contains('existing=value'));
    });

    test('should get encryption info', () {
      final info = urlEncryptionService.getEncryptionInfo();
      
      expect(info['service'], equals('UrlEncryptionService'));
      expect(info['encryptedParamKey'], equals('enc'));
      expect(info['timestamp'], isA<String>());
    });

    test('should throw UrlEncryptionException for invalid encrypted data', () {
      expect(() => urlEncryptionService.decryptQueryParams('invalid_base64'), 
             throwsA(isA<UrlEncryptionException>()));
      expect(() => urlEncryptionService.decryptParameter('invalid_base64'), 
             throwsA(isA<UrlEncryptionException>()));
    });

    test('should work with string extensions', () {
      const original = 'Extension Test';
      final encrypted = original.encryptForUrl();
      final decrypted = encrypted.decryptFromUrl();
      
      expect(decrypted, equals(original));
    });

    test('should work with map extensions', () {
      final original = {'ext_key': 'ext_value'};
      final encrypted = original.encryptForUrl();
      final encryptedUrl = original.createEncryptedUrl('https://example.com');
      
      expect(encrypted, isNotEmpty);
      expect(encryptedUrl, contains('enc='));
    });

    test('should produce different encrypted values for same input', () {
      const original = 'Sensitive Data';
      final encrypted1 = urlEncryptionService.encryptParameter(original);
      final encrypted2 = urlEncryptionService.encryptParameter(original);
      
      expect(encrypted1, isNot(equals(encrypted2)));
    });

    test('should handle complex parameter values', () {
      final complexParams = {
        'email': 'user@example.com',
        'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        'amount': '123.45',
        'description': r'Bill payment with special chars: @#$%^&*()',
      };
      
      final encrypted = urlEncryptionService.encryptQueryParams(complexParams);
      final decrypted = urlEncryptionService.decryptQueryParams(encrypted);
      
      expect(decrypted, equals(complexParams));
    });

    test('should handle URL with existing query parameters', () {
      const baseUrl = 'https://example.com/bills?existing=value&other=123';
      final params = {'userId': '456'};
      final encryptedUrl = urlEncryptionService.createEncryptedUrl(baseUrl, params);
      
      expect(encryptedUrl, contains('existing=value'));
      expect(encryptedUrl, contains('other=123'));
      expect(encryptedUrl, contains('enc='));
    });

    test('should handle malformed URLs gracefully', () {
      // Uri.parse doesn't throw for malformed URLs, it returns empty URI
      expect(urlEncryptionService.parseEncryptedUrl('not-a-url'), isEmpty);
      expect(urlEncryptionService.hasEncryptedParams('not-a-url'), 
             isFalse);
    });
  });
}
