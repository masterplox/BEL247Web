import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' hide Key;
import 'package:encrypt/encrypt.dart' as encrypt show Key;
import 'package:flutter/foundation.dart';

import '../config/env.dart';
import '../utils/logger.dart';

/// Service for AES-256 encryption and decryption of sensitive data
class CryptoService {

  CryptoService._() {
    _initializeEncryption();
  }
  static CryptoService? _instance;
  late final Encrypter _encrypter;
  late final IV _defaultIV;

  /// Get singleton instance of CryptoService
  static CryptoService get instance {
    _instance ??= CryptoService._();
    return _instance!;
  }

  /// Initialize encryption with key from environment
  void _initializeEncryption() {
    try {
      final encryptionKey = EnvConfig.encryptionKey;
      if (encryptionKey.isEmpty) {
        throw Exception('Encryption key is not configured in environment');
      }

      // Convert string key to 32-byte key for AES-256
      final keyBytes = _generateKeyFromString(encryptionKey);
      final key = encrypt.Key(keyBytes);
      
      // Generate a default IV (Initialization Vector)
      _defaultIV = IV.fromSecureRandom(16);
      
      _encrypter = Encrypter(AES(key));
      
      Logger.info('CryptoService initialized successfully');
    } catch (e) {
      Logger.error('Failed to initialize CryptoService: $e');
      rethrow;
    }
  }

  /// Generate a 32-byte key from a string using SHA-256
  Uint8List _generateKeyFromString(String keyString) {
    final bytes = utf8.encode(keyString);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  /// Encrypt a string value
  String encryptString(String value) {
    try {
      if (value.isEmpty) {
        Logger.warning('Attempted to encrypt empty string');
        return value;
      }

      // Generate a new IV for each encryption
      final iv = IV.fromSecureRandom(16);
      final encrypted = _encrypter.encrypt(value, iv: iv);
      
      // Prepend IV to encrypted data (IV + encrypted data)
      final combined = iv.bytes + encrypted.bytes;
      Logger.debug('String encrypted successfully');
      return base64Encode(combined);
    } catch (e) {
      Logger.error('Failed to encrypt string: $e');
      throw CryptoException('Encryption failed: $e');
    }
  }

  /// Decrypt a string value
  String decryptString(String encryptedValue) {
    try {
      if (encryptedValue.isEmpty) {
        Logger.warning('Attempted to decrypt empty string');
        return encryptedValue;
      }

      // Decode base64 and extract IV and encrypted data
      final combined = base64Decode(encryptedValue);
      final iv = IV(combined.sublist(0, 16));
      final encryptedBytes = combined.sublist(16);
      final encrypted = Encrypted(encryptedBytes);
      
      final decrypted = _encrypter.decrypt(encrypted, iv: iv);
      Logger.debug('String decrypted successfully');
      return decrypted;
    } catch (e) {
      Logger.error('Failed to decrypt string: $e');
      throw CryptoException('Decryption failed: $e');
    }
  }

  /// Encrypt a JSON object
  String encryptJson(Map<String, dynamic> jsonObject) {
    try {
      final jsonString = jsonEncode(jsonObject);
      return encryptString(jsonString);
    } catch (e) {
      Logger.error('Failed to encrypt JSON: $e');
      throw CryptoException('JSON encryption failed: $e');
    }
  }

  /// Decrypt a JSON object
  Map<String, dynamic> decryptJson(String encryptedJson) {
    try {
      final decryptedString = decryptString(encryptedJson);
      final jsonObject = jsonDecode(decryptedString) as Map<String, dynamic>;
      return jsonObject;
    } catch (e) {
      Logger.error('Failed to decrypt JSON: $e');
      throw CryptoException('JSON decryption failed: $e');
    }
  }

  /// Encrypt query parameters for URL
  String encryptQueryParams(Map<String, String> params) {
    try {
      if (params.isEmpty) {
        return '';
      }

      // Convert params to JSON and encrypt
      final jsonString = jsonEncode(params);
      final encrypted = encryptString(jsonString);
      
      // URL encode the encrypted string
      return Uri.encodeComponent(encrypted);
    } catch (e) {
      Logger.error('Failed to encrypt query parameters: $e');
      throw CryptoException('Query parameter encryption failed: $e');
    }
  }

  /// Decrypt query parameters from URL
  Map<String, String> decryptQueryParams(String encryptedParams) {
    try {
      if (encryptedParams.isEmpty) {
        return {};
      }

      // URL decode the encrypted string
      final decoded = Uri.decodeComponent(encryptedParams);
      
      // Decrypt and parse JSON
      final decryptedString = decryptString(decoded);
      final jsonObject = jsonDecode(decryptedString) as Map<String, dynamic>;
      
      // Convert to Map<String, String>
      return jsonObject.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      Logger.error('Failed to decrypt query parameters: $e');
      throw CryptoException('Query parameter decryption failed: $e');
    }
  }

  /// Encrypt sensitive user data
  String encryptUserData(Map<String, dynamic> userData) {
    try {
      // Filter out non-sensitive data
      final sensitiveData = <String, dynamic>{};
      const sensitiveFields = ['email', 'phone', 'ssn', 'address', 'paymentinfo'];
      
      for (final entry in userData.entries) {
        if (sensitiveFields.contains(entry.key.toLowerCase())) {
          sensitiveData[entry.key] = entry.value;
        }
      }

      if (sensitiveData.isEmpty) {
        Logger.warning('No sensitive data found to encrypt');
        return '';
      }

      return encryptJson(sensitiveData);
    } catch (e) {
      Logger.error('Failed to encrypt user data: $e');
      throw CryptoException('User data encryption failed: $e');
    }
  }

  /// Decrypt sensitive user data
  Map<String, dynamic> decryptUserData(String encryptedUserData) {
    try {
      if (encryptedUserData.isEmpty) {
        return {};
      }

      return decryptJson(encryptedUserData);
    } catch (e) {
      Logger.error('Failed to decrypt user data: $e');
      throw CryptoException('User data decryption failed: $e');
    }
  }

  /// Generate a secure random string
  String generateSecureRandomString(int length) {
    try {
      final random = Random.secure();
      const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      
      return String.fromCharCodes(
        Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
      );
    } catch (e) {
      Logger.error('Failed to generate secure random string: $e');
      throw CryptoException('Random string generation failed: $e');
    }
  }

  /// Validate encryption key strength
  bool validateEncryptionKey(String key) {
    try {
      // Check minimum length (at least 8 characters for reasonable security)
      if (key.length < 8) {
        Logger.warning('Encryption key is too short (minimum 8 characters)');
        return false;
      }

      // Check for common weak patterns
      final weakPatterns = [
        RegExp(r'^[0-9]+$'), // Only numbers
        RegExp(r'^[a-zA-Z]+$'), // Only letters
        RegExp(r'^(.)\1+$'), // Repeated characters
      ];

      for (final pattern in weakPatterns) {
        if (pattern.hasMatch(key)) {
          Logger.warning('Encryption key matches weak pattern');
          return false;
        }
      }

      Logger.debug('Encryption key validation passed');
      return true;
    } catch (e) {
      Logger.error('Failed to validate encryption key: $e');
      return false;
    }
  }

  /// Get encryption status and key info (for debugging only)
  Map<String, dynamic> getEncryptionInfo() {
    try {
      return {
        'isInitialized': _encrypter != null,
        'algorithm': 'AES-256',
        'keyLength': 32,
        'ivLength': 16,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      Logger.error('Failed to get encryption info: $e');
      return {'error': e.toString()};
    }
  }
}

/// Custom exception for crypto operations
class CryptoException implements Exception {
  
  const CryptoException(this.message);
  final String message;
  
  @override
  String toString() => 'CryptoException: $message';
}

/// Extension for easy encryption/decryption of strings
extension StringCryptoExtension on String {
  /// Encrypt this string
  String encrypt() => CryptoService.instance.encryptString(this);
  
  /// Decrypt this string
  String decrypt() => CryptoService.instance.decryptString(this);
}

/// Extension for easy encryption/decryption of maps
extension MapCryptoExtension on Map<String, dynamic> {
  /// Encrypt this map as JSON
  String encryptJson() => CryptoService.instance.encryptJson(this);
  
  /// Encrypt this map as query parameters
  String encryptQueryParams() => CryptoService.instance.encryptQueryParams(
    map((key, value) => MapEntry(key, value.toString())),
  );
}
