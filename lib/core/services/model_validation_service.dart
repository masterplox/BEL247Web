import 'input_validator_service.dart';

/// Comprehensive validation service for all data models
class ModelValidationService {
  factory ModelValidationService() => _instance;
  ModelValidationService._internal();
  static final ModelValidationService _instance = ModelValidationService._internal();

  static ModelValidationService get instance => _instance;

  final InputValidatorService _inputValidator = InputValidatorService();

  /// Validate email format
  ModelValidationResult validateEmail(String email) {
    final result = _inputValidator.validateEmail(email);
    return ModelValidationResult(
      isValid: result.isValid,
      errors: result.errorMessage != null ? [result.errorMessage!] : [],
    );
  }

  /// Validate phone number format
  ModelValidationResult validatePhoneNumber(String phone) {
    final result = _inputValidator.validatePhoneNumber(phone);
    return ModelValidationResult(
      isValid: result.isValid,
      errors: result.errorMessage != null ? [result.errorMessage!] : [],
    );
  }

  /// Validate amount (positive number)
  ModelValidationResult validateAmount(String amount) {
    final result = _inputValidator.validateAmount(amount);
    return ModelValidationResult(
      isValid: result.isValid,
      errors: result.errorMessage != null ? [result.errorMessage!] : [],
    );
  }

  /// Validate text input
  ModelValidationResult validateText(
    String text, {
    int? minLength,
    int? maxLength,
    String? fieldName,
    bool allowEmpty = false,
  }) {
    final result = _inputValidator.validateText(
      text,
      minLength: minLength ?? 0,
      maxLength: maxLength ?? 1000,
      fieldName: fieldName ?? 'Text',
      allowEmpty: allowEmpty,
    );
    return ModelValidationResult(
      isValid: result.isValid,
      errors: result.errorMessage != null ? [result.errorMessage!] : [],
    );
  }

  /// Validate date range
  ModelValidationResult validateDateRange(DateTime startDate, DateTime endDate) {
    final errors = <String>[];

    if (startDate.isAfter(endDate)) {
      errors.add('Start date cannot be after end date');
    }

    if (startDate.isAfter(DateTime.now())) {
      errors.add('Start date cannot be in the future');
    }

    if (endDate.isAfter(DateTime.now())) {
      errors.add('End date cannot be in the future');
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate required field
  ModelValidationResult validateRequired(String value, String fieldName) {
    if (value.trim().isEmpty) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName is required'],
      );
    }
    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate positive number
  ModelValidationResult validatePositiveNumber(double value, String fieldName) {
    if (value < 0) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName cannot be negative'],
      );
    }
    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate non-negative number
  ModelValidationResult validateNonNegativeNumber(double value, String fieldName) {
    if (value < 0) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName cannot be negative'],
      );
    }
    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate ID format (alphanumeric with optional hyphens/underscores)
  ModelValidationResult validateId(String id, String fieldName) {
    if (id.trim().isEmpty) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName is required'],
      );
    }

    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(id)) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName can only contain letters, numbers, hyphens, and underscores'],
      );
    }

    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate URL format
  ModelValidationResult validateUrl(String url, String fieldName) {
    if (url.trim().isEmpty) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName is required'],
      );
    }

    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return ModelValidationResult(
          isValid: false,
          errors: ['$fieldName must be a valid HTTP/HTTPS URL'],
        );
      }
    } catch (e) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName is not a valid URL'],
      );
    }

    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate enum value
  ModelValidationResult validateEnum<T>(T value, List<T> validValues, String fieldName) {
    if (!validValues.contains(value)) {
      return ModelValidationResult(
        isValid: false,
        errors: ['$fieldName must be one of: ${validValues.join(', ')}'],
      );
    }
    return const ModelValidationResult(isValid: true, errors: []);
  }

  /// Validate list length
  ModelValidationResult validateListLength<T>(
    List<T> list,
    String fieldName, {
    int? minLength,
    int? maxLength,
    bool allowEmpty = true,
  }) {
    final errors = <String>[];

    if (!allowEmpty && list.isEmpty) {
      errors.add('$fieldName cannot be empty');
    }

    if (minLength != null && list.length < minLength) {
      errors.add('$fieldName must have at least $minLength items');
    }

    if (maxLength != null && list.length > maxLength) {
      errors.add('$fieldName cannot have more than $maxLength items');
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate business rules for bills
  ModelValidationResult validateBillBusinessRules({
    required double totalAmount,
    required double currentCharges,
    required double previousBalance,
    required DateTime dueDate,
    required DateTime issueDate,
  }) {
    final errors = <String>[];

    // Business rule: Total amount should equal previous balance + current charges
    final expectedTotal = previousBalance + currentCharges;
    if ((totalAmount - expectedTotal).abs() > 0.01) {
      errors.add('Total amount does not match previous balance + current charges');
    }

    // Business rule: Due date should be at least 15 days after issue date
    final daysBetween = dueDate.difference(issueDate).inDays;
    if (daysBetween < 15) {
      errors.add('Due date must be at least 15 days after issue date');
    }

    // Business rule: Due date should not be more than 60 days after issue date
    if (daysBetween > 60) {
      errors.add('Due date cannot be more than 60 days after issue date');
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate business rules for consumption data
  ModelValidationResult validateConsumptionBusinessRules({
    required double totalKwh,
    required List<double> hourlyBreakdown,
    required double cost,
  }) {
    final errors = <String>[];

    // Business rule: Total kWh should equal sum of hourly breakdown
    final sumOfHourly = hourlyBreakdown.fold<double>(0, (sum, kwh) => sum + kwh);
    if ((totalKwh - sumOfHourly).abs() > 0.01) {
      errors.add('Total kWh does not match sum of hourly breakdown');
    }

    // Business rule: Hourly breakdown should have exactly 24 entries
    if (hourlyBreakdown.length != 24) {
      errors.add('Hourly breakdown must have exactly 24 entries');
    }

    // Business rule: Cost should be reasonable (between $0.05 and $0.50 per kWh)
    if (totalKwh > 0) {
      final costPerKwh = cost / totalKwh;
      if (costPerKwh < 0.05 || costPerKwh > 0.50) {
        errors.add(r'Cost per kWh seems unreasonable (should be between $0.05 and $0.50)');
      }
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate payment business rules
  ModelValidationResult validatePaymentBusinessRules({
    required double amount,
    required double billAmount,
    required DateTime paymentDate,
    required DateTime billDueDate,
  }) {
    final errors = <String>[];

    // Business rule: Payment amount cannot exceed bill amount by more than $10
    if (amount > billAmount + 10) {
      errors.add(r'Payment amount cannot exceed bill amount by more than $10');
    }

    // Business rule: Payment amount must be positive
    if (amount <= 0) {
      errors.add('Payment amount must be positive');
    }

    // Business rule: Payment date cannot be more than 30 days in the future
    if (paymentDate.isAfter(DateTime.now().add(const Duration(days: 30)))) {
      errors.add('Payment date cannot be more than 30 days in the future');
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate user profile business rules
  ModelValidationResult validateUserProfileBusinessRules({
    required String email,
    required String phone,
    required DateTime? dateOfBirth,
  }) {
    final errors = <String>[];

    // Business rule: User must be at least 18 years old
    if (dateOfBirth != null) {
      final age = DateTime.now().difference(dateOfBirth).inDays / 365.25;
      if (age < 18) {
        errors.add('User must be at least 18 years old');
      }
    }

    // Business rule: Email domain should not be from temporary email services
    final emailDomain = email.split('@').last.toLowerCase();
    final temporaryDomains = [
      '10minutemail.com',
      'tempmail.org',
      'guerrillamail.com',
      'mailinator.com',
    ];
    if (temporaryDomains.contains(emailDomain)) {
      errors.add('Temporary email addresses are not allowed');
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate address business rules
  ModelValidationResult validateAddressBusinessRules({
    required String zipCode,
    required String state,
    required String country,
  }) {
    final errors = <String>[];

    // Business rule: US ZIP codes should be 5 digits or 5+4 format
    if (country.toLowerCase() == 'us' || country.toLowerCase() == 'usa') {
      if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zipCode)) {
        errors.add('US ZIP code must be in format 12345 or 12345-6789');
      }
    }

    // Business rule: State should be valid for US
    if (country.toLowerCase() == 'us' || country.toLowerCase() == 'usa') {
      final validStates = [
        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
        'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
        'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
        'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
        'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY',
        'DC'
      ];
      if (!validStates.contains(state.toUpperCase())) {
        errors.add('Invalid US state code');
      }
    }

    return ModelValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Validate multiple validation results
  ModelValidationResult validateMultiple(List<ModelValidationResult> results) {
    final allErrors = <String>[];
    bool allValid = true;

    for (final result in results) {
      if (!result.isValid) {
        allValid = false;
        allErrors.addAll(result.errors);
      }
    }

    return ModelValidationResult(
      isValid: allValid,
      errors: allErrors,
    );
  }

  /// Sanitize input using the input validator
  String sanitizeInput(String input) => _inputValidator.sanitizeInput(input);
}

/// Model validation result class
class ModelValidationResult {

  const ModelValidationResult({
    required this.isValid,
    required this.errors,
  });

  /// Create a successful validation result
  factory ModelValidationResult.success() => const ModelValidationResult(
        isValid: true,
        errors: [],
      );

  /// Create a failed validation result
  factory ModelValidationResult.failure(List<String> errors) => ModelValidationResult(
        isValid: false,
        errors: errors,
      );

  /// Create a failed validation result with single error
  factory ModelValidationResult.failureSingle(String error) => ModelValidationResult(
        isValid: false,
        errors: [error],
      );
  final bool isValid;
  final List<String> errors;

  String get errorMessage => errors.join(', ');
}