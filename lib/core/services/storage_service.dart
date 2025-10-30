import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/logger.dart';

/// Storage keys for different types of data
class StorageKeys {
  // User preferences
  static const String userPreferences = 'user_preferences';
  static const String appSettings = 'app_settings';
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  
  // Authentication
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userSession = 'user_session';
  
  // App state
  static const String lastLoginDate = 'last_login_date';
  static const String appVersion = 'app_version';
  static const String onboardingCompleted = 'onboarding_completed';
  
  // Feature-specific
  static const String dashboardData = 'dashboard_data';
  static const String billsData = 'bills_data';
  static const String usageData = 'usage_data';
  static const String dailyBillData = 'daily_bill_data';
  
  // Cache
  static const String cacheTimestamp = 'cache_timestamp';
  static const String lastSyncDate = 'last_sync_date';
}

/// Storage service for handling both secure and regular storage
class StorageService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Get SharedPreferences instance
  static Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  /// Store string value securely
  static Future<void> storeSecureString(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      Logger.info('Securely stored value for key: $key');
    } catch (e) {
      Logger.error('Failed to store secure string for key $key: $e');
      rethrow;
    }
  }

  /// Get string value securely
  static Future<String?> getSecureString(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      Logger.info('Retrieved secure value for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get secure string for key $key: $e');
      return null;
    }
  }

  /// Delete secure value
  static Future<void> deleteSecureString(String key) async {
    try {
      await _secureStorage.delete(key: key);
      Logger.info('Deleted secure value for key: $key');
    } catch (e) {
      Logger.error('Failed to delete secure string for key $key: $e');
    }
  }

  /// Store string value in SharedPreferences
  static Future<void> storeString(String key, String value) async {
    try {
      final prefs = await _prefs;
      await prefs.setString(key, value);
      Logger.info('Stored string value for key: $key');
    } catch (e) {
      Logger.error('Failed to store string for key $key: $e');
      rethrow;
    }
  }

  /// Get string value from SharedPreferences
  static Future<String?> getString(String key) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getString(key);
      Logger.info('Retrieved string value for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get string for key $key: $e');
      return null;
    }
  }

  /// Store boolean value
  static Future<void> storeBool(String key, bool value) async {
    try {
      final prefs = await _prefs;
      await prefs.setBool(key, value);
      Logger.info('Stored boolean value for key: $key');
    } catch (e) {
      Logger.error('Failed to store boolean for key $key: $e');
      rethrow;
    }
  }

  /// Get boolean value
  static Future<bool?> getBool(String key) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getBool(key);
      Logger.info('Retrieved boolean value for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get boolean for key $key: $e');
      return null;
    }
  }

  /// Store integer value
  static Future<void> storeInt(String key, int value) async {
    try {
      final prefs = await _prefs;
      await prefs.setInt(key, value);
      Logger.info('Stored integer value for key: $key');
    } catch (e) {
      Logger.error('Failed to store integer for key $key: $e');
      rethrow;
    }
  }

  /// Get integer value
  static Future<int?> getInt(String key) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getInt(key);
      Logger.info('Retrieved integer value for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get integer for key $key: $e');
      return null;
    }
  }

  /// Store double value
  static Future<void> storeDouble(String key, double value) async {
    try {
      final prefs = await _prefs;
      await prefs.setDouble(key, value);
      Logger.info('Stored double value for key: $key');
    } catch (e) {
      Logger.error('Failed to store double for key $key: $e');
      rethrow;
    }
  }

  /// Get double value
  static Future<double?> getDouble(String key) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getDouble(key);
      Logger.info('Retrieved double value for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get double for key $key: $e');
      return null;
    }
  }

  /// Store JSON object
  static Future<void> storeJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      await storeString(key, jsonString);
      Logger.info('Stored JSON object for key: $key');
    } catch (e) {
      Logger.error('Failed to store JSON for key $key: $e');
      rethrow;
    }
  }

  /// Get JSON object
  static Future<Map<String, dynamic>?> getJson(String key) async {
    try {
      final jsonString = await getString(key);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        Logger.info('Retrieved JSON object for key: $key');
        return json;
      }
      return null;
    } catch (e) {
      Logger.error('Failed to get JSON for key $key: $e');
      return null;
    }
  }

  /// Store list of strings
  static Future<void> storeStringList(String key, List<String> value) async {
    try {
      final prefs = await _prefs;
      await prefs.setStringList(key, value);
      Logger.info('Stored string list for key: $key');
    } catch (e) {
      Logger.error('Failed to store string list for key $key: $e');
      rethrow;
    }
  }

  /// Get list of strings
  static Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await _prefs;
      final value = prefs.getStringList(key);
      Logger.info('Retrieved string list for key: $key');
      return value;
    } catch (e) {
      Logger.error('Failed to get string list for key $key: $e');
      return null;
    }
  }

  /// Remove value by key
  static Future<void> remove(String key) async {
    try {
      final prefs = await _prefs;
      await prefs.remove(key);
      Logger.info('Removed value for key: $key');
    } catch (e) {
      Logger.error('Failed to remove value for key $key: $e');
    }
  }

  /// Clear all stored data
  static Future<void> clear() async {
    try {
      final prefs = await _prefs;
      await prefs.clear();
      await _secureStorage.deleteAll();
      Logger.info('Cleared all stored data');
    } catch (e) {
      Logger.error('Failed to clear stored data: $e');
    }
  }

  /// Check if key exists
  static Future<bool> containsKey(String key) async {
    try {
      final prefs = await _prefs;
      final exists = prefs.containsKey(key);
      Logger.info('Checked if key exists: $key -> $exists');
      return exists;
    } catch (e) {
      Logger.error('Failed to check if key exists $key: $e');
      return false;
    }
  }

  /// Get all keys
  static Future<Set<String>> getKeys() async {
    try {
      final prefs = await _prefs;
      final keys = prefs.getKeys();
      Logger.info('Retrieved all keys: ${keys.length} keys');
      return keys;
    } catch (e) {
      Logger.error('Failed to get all keys: $e');
      return <String>{};
    }
  }
}

/// State persistence service for Riverpod providers
class StatePersistenceService {
  /// Save state to storage
  static Future<void> saveState<T>(String key, T state) async {
    try {
      if (state is Map<String, dynamic>) {
        await StorageService.storeJson(key, state);
      } else if (state is String) {
        await StorageService.storeString(key, state);
      } else if (state is bool) {
        await StorageService.storeBool(key, state);
      } else if (state is int) {
        await StorageService.storeInt(key, state);
      } else if (state is double) {
        await StorageService.storeDouble(key, state);
      } else if (state is List<String>) {
        await StorageService.storeStringList(key, state);
      } else {
        // For complex objects, convert to JSON
        final json = state as Map<String, dynamic>;
        await StorageService.storeJson(key, json);
      }
      Logger.info('State saved for key: $key');
    } catch (e) {
      Logger.error('Failed to save state for key $key: $e');
    }
  }

  /// Load state from storage
  static Future<T?> loadState<T>(String key) async {
    try {
      if (T == Map<String, dynamic>) {
        return await StorageService.getJson(key) as T?;
      } else if (T == String) {
        return await StorageService.getString(key) as T?;
      } else if (T == bool) {
        return await StorageService.getBool(key) as T?;
      } else if (T == int) {
        return await StorageService.getInt(key) as T?;
      } else if (T == double) {
        return await StorageService.getDouble(key) as T?;
      } else if (T == List<String>) {
        return await StorageService.getStringList(key) as T?;
      } else {
        // For complex objects, load as JSON
        final json = await StorageService.getJson(key);
        return json as T?;
      }
    } catch (e) {
      Logger.error('Failed to load state for key $key: $e');
      return null;
    }
  }

  /// Delete state from storage
  static Future<void> deleteState(String key) async {
    try {
      await StorageService.remove(key);
      Logger.info('State deleted for key: $key');
    } catch (e) {
      Logger.error('Failed to delete state for key $key: $e');
    }
  }

  /// Check if state exists in storage
  static Future<bool> hasState(String key) async {
    try {
      return await StorageService.containsKey(key);
    } catch (e) {
      Logger.error('Failed to check if state exists for key $key: $e');
      return false;
    }
  }
}

/// Storage service provider
final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

/// State persistence service provider
final statePersistenceServiceProvider = Provider<StatePersistenceService>((ref) => StatePersistenceService());
