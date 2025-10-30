import 'dart:convert';

import '../../core/utils/logger.dart';

/// Utility class for transforming and processing JSON data
class JsonTransformer {
  /// Transform a list of JSON objects to a specific model type
  static List<T> transformList<T>(
    List<dynamic> jsonList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final List<T> result = [];
      for (final item in jsonList) {
        if (item is Map<String, dynamic>) {
          result.add(fromJson(item));
        } else {
          Logger.warning('Skipping invalid item in list: $item');
        }
      }
      Logger.info('Transformed ${result.length} items from JSON list');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error transforming JSON list', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// Transform a single JSON object to a specific model type
  static T? transformSingle<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final result = fromJson(json);
      Logger.info('Successfully transformed JSON object');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error transforming JSON object', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Filter JSON list based on a condition
  static List<Map<String, dynamic>> filterJsonList(
    List<dynamic> jsonList,
    bool Function(Map<String, dynamic>) condition,
  ) {
    try {
      final List<Map<String, dynamic>> result = [];
      for (final item in jsonList) {
        if (item is Map<String, dynamic> && condition(item)) {
          result.add(item);
        }
      }
      Logger.info('Filtered ${result.length} items from ${jsonList.length} total items');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error filtering JSON list', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// Sort JSON list by a specific field
  static List<Map<String, dynamic>> sortJsonList(
    List<dynamic> jsonList,
    String sortField,
    {bool ascending = true}
  ) {
    try {
      final List<Map<String, dynamic>> result = [];
      for (final item in jsonList) {
        if (item is Map<String, dynamic>) {
          result.add(item);
        }
      }
      
      result.sort((a, b) {
        final aValue = a[sortField];
        final bValue = b[sortField];
        
        if (aValue == null && bValue == null) return 0;
        if (aValue == null) return ascending ? -1 : 1;
        if (bValue == null) return ascending ? 1 : -1;
        
        if (aValue is Comparable && bValue is Comparable) {
          return ascending 
            ? aValue.compareTo(bValue)
            : bValue.compareTo(aValue);
        }
        
        return 0;
      });
      
      Logger.info('Sorted ${result.length} items by $sortField (ascending: $ascending)');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error sorting JSON list', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// Group JSON list by a specific field
  static Map<String, List<Map<String, dynamic>>> groupJsonList(
    List<dynamic> jsonList,
    String groupField,
  ) {
    try {
      final Map<String, List<Map<String, dynamic>>> result = {};
      
      for (final item in jsonList) {
        if (item is Map<String, dynamic>) {
          final groupKey = item[groupField]?.toString() ?? 'null';
          result.putIfAbsent(groupKey, () => []).add(item);
        }
      }
      
      Logger.info('Grouped ${jsonList.length} items into ${result.length} groups by $groupField');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error grouping JSON list', error: e, stackTrace: stackTrace);
      return {};
    }
  }

  /// Calculate statistics for numeric fields in JSON list
  static Map<String, dynamic> calculateStatistics(
    List<dynamic> jsonList,
    String numericField,
  ) {
    try {
      final List<num> values = [];
      
      for (final item in jsonList) {
        if (item is Map<String, dynamic>) {
          final value = item[numericField];
          if (value is num) {
            values.add(value);
          }
        }
      }
      
      if (values.isEmpty) {
        Logger.warning('No numeric values found for field: $numericField');
        return {};
      }
      
      values.sort();
      
        final sum = values.fold<double>(0, (a, b) => a + b);
      final average = sum / values.length;
      final min = values.first;
      final max = values.last;
      final median = values.length % 2 == 0
        ? (values[values.length ~/ 2 - 1] + values[values.length ~/ 2]) / 2
        : values[values.length ~/ 2];
      
      final result = {
        'count': values.length,
        'sum': sum,
        'average': average,
        'min': min,
        'max': max,
        'median': median,
      };
      
      Logger.info('Calculated statistics for $numericField: $result');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error calculating statistics', error: e, stackTrace: stackTrace);
      return {};
    }
  }

  /// Convert JSON to pretty-printed string
  static String prettyPrint(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e, stackTrace) {
      Logger.error('Error pretty printing JSON', error: e, stackTrace: stackTrace);
      return json.toString();
    }
  }

  /// Deep merge two JSON objects
  static Map<String, dynamic> deepMerge(
    Map<String, dynamic> base,
    Map<String, dynamic> override,
  ) {
    try {
      final result = Map<String, dynamic>.from(base);
      
      for (final entry in override.entries) {
        final key = entry.key;
        final value = entry.value;
        
        if (result.containsKey(key) && 
            result[key] is Map<String, dynamic> && 
            value is Map<String, dynamic>) {
          result[key] = deepMerge(result[key] as Map<String, dynamic>, value);
        } else {
          result[key] = value;
        }
      }
      
      Logger.info('Deep merged JSON objects');
      return result;
    } catch (e, stackTrace) {
      Logger.error('Error deep merging JSON', error: e, stackTrace: stackTrace);
      return base;
    }
  }
}
