
/// Service for validating and sanitizing user inputs
/// Provides comprehensive input validation with XSS prevention
class InputValidatorService {
  factory InputValidatorService() => _instance;
  InputValidatorService._internal();
  static final InputValidatorService _instance = InputValidatorService._internal();

  // Email validation regex
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Phone number validation regex (supports various formats)
  static final RegExp _phoneRegex = RegExp(
    r'^[\+]?[1-9][\d]{0,15}$',
  );

  // Amount validation regex (supports decimal numbers)
  static final RegExp _amountRegex = RegExp(
    r'^\d+(\.\d{1,2})?$',
  );

  // HTML/script tag detection regex for XSS prevention
  static final RegExp _htmlTagRegex = RegExp(
    '<[^>]*>',
  );

  // Script tag detection regex
  static final RegExp _scriptTagRegex = RegExp(
    '<script[^>]*>.*?</script>',
    caseSensitive: false,
    multiLine: true,
  );

  // Dangerous characters that could be used for XSS
  static final RegExp _dangerousCharsRegex = RegExp(
    '''[<>"']''',
  );

  /// Validates email address format
  ValidationResult validateEmail(String email) {
    if (email.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Email is required',
      );
    }

    if (!_emailRegex.hasMatch(email.trim())) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid email address',
      );
    }

    // Check for XSS attempts
    if (_containsXSSAttempt(email)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected',
      );
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: email.trim().toLowerCase(),
    );
  }

  /// Validates phone number format
  ValidationResult validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Phone number is required',
      );
    }

    // Remove common formatting characters
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (!_phoneRegex.hasMatch(cleanedPhone)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid phone number',
      );
    }

    // Check for XSS attempts
    if (_containsXSSAttempt(phoneNumber)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected',
      );
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: cleanedPhone,
    );
  }

  /// Validates monetary amount
  ValidationResult validateAmount(String amount) {
    if (amount.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Amount is required',
      );
    }

    // Remove currency symbols and spaces
    final cleanedAmount = amount.replaceAll(RegExp(r'[\$,\s]'), '');
    
    if (!_amountRegex.hasMatch(cleanedAmount)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid amount (e.g., 100.50)',
      );
    }

    // Check for XSS attempts
    if (_containsXSSAttempt(amount)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected',
      );
    }

    // Convert to double to validate range
    final doubleValue = double.tryParse(cleanedAmount);
    if (doubleValue == null) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid number',
      );
    }

    if (doubleValue < 0) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Amount cannot be negative',
      );
    }

    if (doubleValue > 999999.99) {
      return const ValidationResult(
        isValid: false,
        errorMessage: r'Amount cannot exceed $999,999.99',
      );
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: cleanedAmount,
    );
  }

  /// Validates password strength
  ValidationResult validatePassword(String password) {
    if (password.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Password is required',
      );
    }

    if (password.length < 8) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Password must be at least 8 characters long',
      );
    }

    if (password.length > 128) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Password cannot exceed 128 characters',
      );
    }

    // Check for XSS attempts
    if (_containsXSSAttempt(password)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected',
      );
    }

    // Check password strength
    final strengthResult = _checkPasswordStrength(password);
    if (!strengthResult.isValid) {
      return strengthResult;
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: password,
    );
  }

  /// Validates general text input with length constraints
  ValidationResult validateText(
    String text, {
    required int minLength,
    required int maxLength,
    String? fieldName,
    bool allowEmpty = false,
  }) {
    if (!allowEmpty && text.isEmpty) {
      return ValidationResult(
        isValid: false,
        errorMessage: '${fieldName ?? 'Field'} is required',
      );
    }

    if (text.length < minLength) {
      return ValidationResult(
        isValid: false,
        errorMessage: '${fieldName ?? 'Field'} must be at least $minLength characters long',
      );
    }

    if (text.length > maxLength) {
      return ValidationResult(
        isValid: false,
        errorMessage: '${fieldName ?? 'Field'} cannot exceed $maxLength characters',
      );
    }

    // Check for XSS attempts
    if (_containsXSSAttempt(text)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected',
      );
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: _sanitizeText(text),
    );
  }

  /// Sanitizes text input to prevent XSS attacks
  String sanitizeInput(String input) {
    if (input.isEmpty) return input;

    // Remove HTML tags
    String sanitized = input.replaceAll(_htmlTagRegex, '');
    
    // Remove script tags
    sanitized = sanitized.replaceAll(_scriptTagRegex, '');
    
    // Escape dangerous characters
    sanitized = sanitized.replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('&', '&amp;');

    return sanitized.trim();
  }

  /// Checks if input contains potential XSS attempts
  bool _containsXSSAttempt(String input) => _htmlTagRegex.hasMatch(input) ||
           _scriptTagRegex.hasMatch(input) ||
           _dangerousCharsRegex.hasMatch(input);

  /// Sanitizes text for general use
  String _sanitizeText(String text) => text.trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Checks password strength requirements
  ValidationResult _checkPasswordStrength(String password) {
    final bool hasUppercase = password.contains(RegExp('[A-Z]'));
    final bool hasLowercase = password.contains(RegExp('[a-z]'));
    final bool hasDigits = password.contains(RegExp('[0-9]'));
    final bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int strengthScore = 0;
    if (hasUppercase) strengthScore++;
    if (hasLowercase) strengthScore++;
    if (hasDigits) strengthScore++;
    if (hasSpecialChar) strengthScore++;

    if (strengthScore < 3) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Password must contain at least 3 of the following: uppercase letters, lowercase letters, numbers, special characters',
      );
    }

    return const ValidationResult(isValid: true);
  }

  /// Validates and sanitizes form data
  Map<String, ValidationResult> validateFormData(Map<String, String> formData) {
    final results = <String, ValidationResult>{};

    for (final entry in formData.entries) {
      final key = entry.key;
      final value = entry.value;

      switch (key.toLowerCase()) {
        case 'email':
          results[key] = validateEmail(value);
          break;
        case 'phone':
        case 'phonenumber':
          results[key] = validatePhoneNumber(value);
          break;
        case 'amount':
        case 'price':
        case 'cost':
          results[key] = validateAmount(value);
          break;
        case 'password':
          results[key] = validatePassword(value);
          break;
        default:
          results[key] = validateText(
            value,
            minLength: 1,
            maxLength: 255,
            fieldName: key,
            allowEmpty: false,
          );
      }
    }

    return results;
  }

  /// Checks if all validation results are valid
  bool isFormValid(Map<String, ValidationResult> results) => results.values.every((result) => result.isValid);

  /// Gets all error messages from validation results
  List<String> getErrorMessages(Map<String, ValidationResult> results) => results.values
        .where((result) => !result.isValid)
        .map((result) => result.errorMessage!)
        .toList();
}

/// Result of input validation
class ValidationResult {

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.sanitizedValue,
  });
  final bool isValid;
  final String? errorMessage;
  final String? sanitizedValue;

  @override
  String toString() => 'ValidationResult(isValid: $isValid, errorMessage: $errorMessage, sanitizedValue: $sanitizedValue)';
}

/// Extension methods for easier validation
extension InputValidatorExtension on String {
  /// Validates email format
  ValidationResult validateAsEmail() => InputValidatorService().validateEmail(this);

  /// Validates phone number format
  ValidationResult validateAsPhoneNumber() => InputValidatorService().validatePhoneNumber(this);

  /// Validates amount format
  ValidationResult validateAsAmount() => InputValidatorService().validateAmount(this);

  /// Validates password strength
  ValidationResult validateAsPassword() => InputValidatorService().validatePassword(this);

  /// Sanitizes input to prevent XSS
  String sanitize() => InputValidatorService().sanitizeInput(this);
}
