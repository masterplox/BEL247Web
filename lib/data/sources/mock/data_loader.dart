import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/utils/logger.dart';

/// Utility class for loading JSON data from assets
class DataLoader {
  static final Map<String, dynamic> _cache = {};

  /// Load JSON data from assets with caching
  static Future<Map<String, dynamic>> loadJsonFromAssets(String assetPath) async {
    try {
      // Check cache first
      if (_cache.containsKey(assetPath)) {
        Logger.info('Loading $assetPath from cache');
        return _cache[assetPath] as Map<String, dynamic>;
      }

      // Load from assets
      Logger.info('Loading $assetPath from assets');
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;

      // Cache the data
      _cache[assetPath] = jsonData;
      
      Logger.info('Successfully loaded and cached $assetPath');
      return jsonData;
    } catch (e, stackTrace) {
      Logger.error('Failed to load JSON from $assetPath', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Load list data from JSON assets
  static Future<List<dynamic>> loadListFromAssets(String assetPath, String listKey) async {
    try {
      final Map<String, dynamic> jsonData = await loadJsonFromAssets(assetPath);
      return jsonData[listKey] as List<dynamic>;
    } catch (e, stackTrace) {
      Logger.error('Failed to load list from $assetPath', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Clear cache for a specific asset
  static void clearCache(String assetPath) {
    _cache.remove(assetPath);
    Logger.info('Cleared cache for $assetPath');
  }

  /// Clear all cached data
  static void clearAllCache() {
    _cache.clear();
    Logger.info('Cleared all cached data');
  }

  /// Get cache size
  static int getCacheSize() => _cache.length;

  /// Check if asset is cached
  static bool isCached(String assetPath) => _cache.containsKey(assetPath);
}
