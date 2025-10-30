import '../../core/utils/logger.dart';

/// Utility class for validating JSON data structure
class JsonValidator {
  /// Validate that a JSON object contains required fields
  static bool validateRequiredFields(
    Map<String, dynamic> json,
    List<String> requiredFields,
  ) {
    try {
      for (final field in requiredFields) {
        if (!json.containsKey(field)) {
          Logger.warning('Missing required field: $field');
          return false;
        }
        if (json[field] == null) {
          Logger.warning('Required field is null: $field');
          return false;
        }
      }
      return true;
    } catch (e, stackTrace) {
      Logger.error('Error validating required fields', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Validate that a JSON object contains required fields with specific types
  static bool validateFieldTypes(
    Map<String, dynamic> json,
    Map<String, Type> fieldTypes,
  ) {
    try {
      for (final entry in fieldTypes.entries) {
        final fieldName = entry.key;
        final expectedType = entry.value;
        
        if (!json.containsKey(fieldName)) {
          Logger.warning('Missing field: $fieldName');
          return false;
        }
        
        final value = json[fieldName];
        if (value == null) {
          Logger.warning('Field is null: $fieldName');
          return false;
        }
        
        if (value.runtimeType != expectedType) {
          Logger.warning('Field $fieldName has wrong type. Expected: $expectedType, Got: ${value.runtimeType}');
          return false;
        }
      }
      return true;
    } catch (e, stackTrace) {
      Logger.error('Error validating field types', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Validate that a list contains objects with required fields
  static bool validateListStructure(
    List<dynamic> list,
    List<String> requiredFields,
  ) {
    try {
      if (list.isEmpty) {
        Logger.warning('List is empty');
        return false;
      }
      
      for (int i = 0; i < list.length; i++) {
        final item = list[i];
        if (item is! Map<String, dynamic>) {
          Logger.warning('Item at index $i is not a Map');
          return false;
        }
        
        if (!validateRequiredFields(item, requiredFields)) {
          Logger.warning('Item at index $i failed validation');
          return false;
        }
      }
      return true;
    } catch (e, stackTrace) {
      Logger.error('Error validating list structure', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Validate date format in JSON
  static bool validateDateFormat(String dateString) {
    try {
      DateTime.parse(dateString);
      return true;
    } catch (e) {
      Logger.warning('Invalid date format: $dateString');
      return false;
    }
  }

  /// Validate email format
  static bool validateEmailFormat(String email) {
    try {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      return emailRegex.hasMatch(email);
    } catch (e) {
      Logger.warning('Invalid email format: $email');
      return false;
    }
  }

  /// Validate numeric range
  static bool validateNumericRange(num value, num min, num max) {
    try {
      return value >= min && value <= max;
    } catch (e) {
      Logger.warning('Error validating numeric range for value: $value');
      return false;
    }
  }
}
