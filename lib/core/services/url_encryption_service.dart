import 'package:go_router/go_router.dart';

import '../services/crypto_service.dart';
import '../utils/logger.dart';

/// Service for encrypting and decrypting URL parameters
class UrlEncryptionService {

  UrlEncryptionService._() {
    _cryptoService = CryptoService.instance;
  }
  static UrlEncryptionService? _instance;
  late final CryptoService _cryptoService;

  /// Get singleton instance of UrlEncryptionService
  static UrlEncryptionService get instance {
    _instance ??= UrlEncryptionService._();
    return _instance!;
  }

  /// Encrypt query parameters for URL
  String encryptQueryParams(Map<String, String> params) {
    try {
      if (params.isEmpty) {
        Logger.debug('No parameters to encrypt');
        return '';
      }

      // Use the crypto service to encrypt the parameters
      final encrypted = _cryptoService.encryptQueryParams(params);
      Logger.debug('Query parameters encrypted successfully');
      return encrypted;
    } catch (e) {
      Logger.error('Failed to encrypt query parameters: $e');
      throw UrlEncryptionException('Query parameter encryption failed: $e');
    }
  }

  /// Decrypt query parameters from URL
  Map<String, String> decryptQueryParams(String encryptedParams) {
    try {
      if (encryptedParams.isEmpty) {
        Logger.debug('No parameters to decrypt');
        return {};
      }

      // Use the crypto service to decrypt the parameters
      final decrypted = _cryptoService.decryptQueryParams(encryptedParams);
      Logger.debug('Query parameters decrypted successfully');
      return decrypted;
    } catch (e) {
      Logger.error('Failed to decrypt query parameters: $e');
      throw UrlEncryptionException('Query parameter decryption failed: $e');
    }
  }

  /// Encrypt a single parameter value
  String encryptParameter(String value) {
    try {
      if (value.isEmpty) {
        return value;
      }

      final encrypted = _cryptoService.encryptString(value);
      Logger.debug('Parameter encrypted successfully');
      return encrypted;
    } catch (e) {
      Logger.error('Failed to encrypt parameter: $e');
      throw UrlEncryptionException('Parameter encryption failed: $e');
    }
  }

  /// Decrypt a single parameter value
  String decryptParameter(String encryptedValue) {
    try {
      if (encryptedValue.isEmpty) {
        return encryptedValue;
      }

      final decrypted = _cryptoService.decryptString(encryptedValue);
      Logger.debug('Parameter decrypted successfully');
      return decrypted;
    } catch (e) {
      Logger.error('Failed to decrypt parameter: $e');
      throw UrlEncryptionException('Parameter decryption failed: $e');
    }
  }

  /// Create an encrypted URL with query parameters
  String createEncryptedUrl(String baseUrl, Map<String, String> params) {
    try {
      if (params.isEmpty) {
        return baseUrl;
      }

      final encryptedParams = encryptQueryParams(params);
      final separator = baseUrl.contains('?') ? '&' : '?';
      final url = '$baseUrl$separator$_encryptedParamKey=$encryptedParams';
      
      Logger.debug('Encrypted URL created successfully');
      return url;
    } catch (e) {
      Logger.error('Failed to create encrypted URL: $e');
      throw UrlEncryptionException('URL creation failed: $e');
    }
  }

  /// Parse encrypted URL and extract parameters
  Map<String, String> parseEncryptedUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final encryptedParams = uri.queryParameters[_encryptedParamKey];
      
      if (encryptedParams == null || encryptedParams.isEmpty) {
        Logger.debug('No encrypted parameters found in URL');
        return {};
      }

      final decryptedParams = decryptQueryParams(encryptedParams);
      Logger.debug('Encrypted URL parsed successfully');
      return decryptedParams;
    } catch (e) {
      Logger.error('Failed to parse encrypted URL: $e');
      throw UrlEncryptionException('URL parsing failed: $e');
    }
  }

  /// Extract encrypted parameters from GoRouter state
  Map<String, String> extractEncryptedParams(GoRouterState state) {
    try {
      final uri = state.uri;
      final encryptedParams = uri.queryParameters[_encryptedParamKey];
      
      if (encryptedParams == null || encryptedParams.isEmpty) {
        Logger.debug('No encrypted parameters found in router state');
        return {};
      }

      final decryptedParams = decryptQueryParams(encryptedParams);
      Logger.debug('Encrypted parameters extracted from router state');
      return decryptedParams;
    } catch (e) {
      Logger.error('Failed to extract encrypted parameters: $e');
      throw UrlEncryptionException('Parameter extraction failed: $e');
    }
  }

  /// Add encrypted parameters to GoRouter state
  String addEncryptedParams(String currentPath, Map<String, String> params) {
    try {
      if (params.isEmpty) {
        return currentPath;
      }

      final encryptedParams = encryptQueryParams(params);
      final uri = Uri.parse(currentPath);
      final queryParams = Map<String, String>.from(uri.queryParameters);
      queryParams[_encryptedParamKey] = encryptedParams;
      
      final newUri = uri.replace(queryParameters: queryParams);
      Logger.debug('Encrypted parameters added to path');
      return newUri.toString();
    } catch (e) {
      Logger.error('Failed to add encrypted parameters: $e');
      throw UrlEncryptionException('Parameter addition failed: $e');
    }
  }

  /// Check if URL contains encrypted parameters
  bool hasEncryptedParams(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.queryParameters.containsKey(_encryptedParamKey);
    } catch (e) {
      Logger.error('Failed to check encrypted parameters: $e');
      return false;
    }
  }

  /// Get encryption status and info
  Map<String, dynamic> getEncryptionInfo() {
    try {
      return {
        'service': 'UrlEncryptionService',
        'cryptoService': _cryptoService.getEncryptionInfo(),
        'encryptedParamKey': _encryptedParamKey,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      Logger.error('Failed to get encryption info: $e');
      return {'error': e.toString()};
    }
  }

  /// Key used for encrypted parameters in URLs
  static const String _encryptedParamKey = 'enc';
}

/// Custom exception for URL encryption operations
class UrlEncryptionException implements Exception {
  
  const UrlEncryptionException(this.message);
  final String message;
  
  @override
  String toString() => 'UrlEncryptionException: $message';
}

/// Extension for easy URL encryption/decryption
extension UrlEncryptionExtension on String {
  /// Encrypt this string as a URL parameter
  String encryptForUrl() => UrlEncryptionService.instance.encryptParameter(this);
  
  /// Decrypt this string from a URL parameter
  String decryptFromUrl() => UrlEncryptionService.instance.decryptParameter(this);
}

/// Extension for easy URL parameter encryption/decryption
extension MapUrlEncryptionExtension on Map<String, String> {
  /// Encrypt these parameters for URL
  String encryptForUrl() => UrlEncryptionService.instance.encryptQueryParams(this);
  
  /// Create encrypted URL with these parameters
  String createEncryptedUrl(String baseUrl) => UrlEncryptionService.instance.createEncryptedUrl(baseUrl, this);
}

/// GoRouter extension for encrypted parameters
extension GoRouterEncryptionExtension on GoRouter {
  /// Navigate with encrypted parameters
  void goWithEncryptedParams(String path, Map<String, String> params) {
    try {
      final encryptedPath = UrlEncryptionService.instance.addEncryptedParams(path, params);
      go(encryptedPath);
    } catch (e) {
      Logger.error('Failed to navigate with encrypted parameters: $e');
      // Fallback to regular navigation
      go(path);
    }
  }
  
  /// Push with encrypted parameters
  void pushWithEncryptedParams(String path, Map<String, String> params) {
    try {
      final encryptedPath = UrlEncryptionService.instance.addEncryptedParams(path, params);
      push(encryptedPath);
    } catch (e) {
      Logger.error('Failed to push with encrypted parameters: $e');
      // Fallback to regular push
      push(path);
    }
  }
}
