import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/utils/logger.dart';

/// Utility class for loading JSON data from assets
class DataLoader {
  static final Map<String, dynamic> _cache = {};

  /// Load JSON data from assets with caching
  static Future<Map<String, dynamic>> loadJsonFromAssets(String assetPath) async {
    try {
      // Log the exact path being requested
      print('[DataLoader] ===== ATTEMPTING TO LOAD ASSET =====');
      print('[DataLoader] Requested path: "$assetPath"');
      print('[DataLoader] Cache contains key: ${_cache.containsKey(assetPath)}');
      
      // Check cache first
      if (_cache.containsKey(assetPath)) {
        Logger.info('Loading $assetPath from cache');
        print('[DataLoader] ✓ Cache hit for path=$assetPath');
        return _cache[assetPath] as Map<String, dynamic>;
      }

      // Load from assets
      Logger.info('Loading $assetPath from assets');
      print('[DataLoader] ✗ Cache miss - loading from rootBundle');
      print('[DataLoader] Calling rootBundle.loadString("$assetPath")...');
      
      final String jsonString = await rootBundle.loadString(assetPath);
      
      print('[DataLoader] ✓ rootBundle.loadString succeeded');
      print('[DataLoader] JSON string length: ${jsonString.length} characters');
      
      final Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;
      
      print('[DataLoader] ✓ JSON decoded successfully');
      print('[DataLoader] JSON keys: ${jsonData.keys.toList()}');

      // Cache the data
      _cache[assetPath] = jsonData;
      
      Logger.info('Successfully loaded and cached $assetPath');
      print('[DataLoader] ✓ Successfully loaded and cached: $assetPath');
      print('[DataLoader] ===== ASSET LOAD SUCCESS =====');
      return jsonData;
    } catch (e, stackTrace) {
      Logger.error('Failed to load JSON from $assetPath', error: e, stackTrace: stackTrace);
      print('[DataLoader] ===== ASSET LOAD ERROR =====');
      print('[DataLoader][ERROR] Failed to load asset');
      print('[DataLoader][ERROR] Path: "$assetPath"');
      print('[DataLoader][ERROR] Error type: ${e.runtimeType}');
      print('[DataLoader][ERROR] Error message: $e');
      print('[DataLoader][ERROR] Stack trace:');
      print(stackTrace);
      print('[DataLoader] ===== END ERROR =====');
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
      print('[DataLoader][ERROR] failed list load path=$assetPath error=$e');
      rethrow;
    }
  }

  /// Clear cache for a specific asset
  static void clearCache(String assetPath) {
    _cache.remove(assetPath);
    Logger.info('Cleared cache for $assetPath');
    print('[DataLoader] cache cleared path=$assetPath');
  }

  /// Clear all cached data
  static void clearAllCache() {
    _cache.clear();
    Logger.info('Cleared all cached data');
    print('[DataLoader] cache cleared all');
  }

  /// Get cache size
  static int getCacheSize() => _cache.length;

  /// Check if asset is cached
  static bool isCached(String assetPath) => _cache.containsKey(assetPath);
}
