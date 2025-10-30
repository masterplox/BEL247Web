import 'package:flutter/material.dart';

import '../services/input_validator_service.dart';
import '../widgets/validated_form_field.dart';

/// Example page demonstrating input validation usage
class InputValidationExamplePage extends StatefulWidget {
  const InputValidationExamplePage({super.key});

  @override
  State<InputValidationExamplePage> createState() => _InputValidationExamplePageState();
}

class _InputValidationExamplePageState extends State<InputValidationExamplePage>
    with FormValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidatorService();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Input Validation Example'),
      ),
      body: FormValidator(
        formKey: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Form Validation Examples',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                // Email validation example
                ValidatedTextFormField(
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  validationType: ValidationType.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  onChanged: (value) => updateFormField('email', value),
                ),
                const SizedBox(height: 16),
                
                // Phone validation example
                ValidatedTextFormField(
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  validationType: ValidationType.phone,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  onChanged: (value) => updateFormField('phone', value),
                ),
                const SizedBox(height: 16),
                
                // Amount validation example
                ValidatedTextFormField(
                  label: 'Amount',
                  hintText: 'Enter amount (e.g., 100.50)',
                  validationType: ValidationType.amount,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.attach_money),
                  onChanged: (value) => updateFormField('amount', value),
                ),
                const SizedBox(height: 16),
                
                // Password validation example
                ValidatedTextFormField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  validationType: ValidationType.password,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock),
                  onChanged: (value) => updateFormField('password', value),
                ),
                const SizedBox(height: 16),
                
                // General text validation example
                ValidatedTextFormField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  validationType: ValidationType.text,
                  maxLength: 50,
                  prefixIcon: const Icon(Icons.person),
                  onChanged: (value) => updateFormField('name', value),
                ),
                const SizedBox(height: 32),
                
                // Submit button
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Submit Form'),
                ),
                const SizedBox(height: 16),
                
                // Error messages display
                if (getFormErrors().isNotEmpty) ...[
                  const Text(
                    'Validation Errors:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  ...getFormErrors().map((error) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
                ],
                
                const SizedBox(height: 32),
                
                // XSS Protection Demo
                const Text(
                  'XSS Protection Demo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Try XSS Attack',
                    hintText: 'Enter: <script>alert("xss")</script>',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Demonstrate XSS protection
                    final sanitized = _validator.sanitizeInput(value);
                    if (sanitized != value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('XSS attempt detected and sanitized: $sanitized'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

  void _handleSubmit() {
    if (validateForm()) {
      final sanitizedData = getSanitizedFormData();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully!\nData: $sanitizedData'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fix validation errors:\n${getFormErrors().join('\n')}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

/// Utility class for common validation patterns
class ValidationUtils {
  static final InputValidatorService _validator = InputValidatorService();

  /// Validates login form data
  static Map<String, ValidationResult> validateLoginForm({
    required String email,
    required String password,
  }) => _validator.validateFormData({
      'email': email,
      'password': password,
    });

  /// Validates registration form data
  static Map<String, ValidationResult> validateRegistrationForm({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
    String? phoneNumber,
  }) {
    final results = _validator.validateFormData({
      'email': email,
      'password': password,
      'name': fullName,
      if (phoneNumber != null && phoneNumber.isNotEmpty) 'phone': phoneNumber,
    });

    // Additional validation for password confirmation
    if (password != confirmPassword) {
      results['confirmPassword'] = const ValidationResult(
        isValid: false,
        errorMessage: 'Passwords do not match',
      );
    }

    return results;
  }

  /// Validates payment form data
  static Map<String, ValidationResult> validatePaymentForm({
    required String amount,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) {
    final results = _validator.validateFormData({
      'amount': amount,
    });

    // Additional validations for payment fields
    if (cardNumber.length < 13 || cardNumber.length > 19) {
      results['cardNumber'] = const ValidationResult(
        isValid: false,
        errorMessage: 'Card number must be between 13 and 19 digits',
      );
    }

    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiryDate)) {
      results['expiryDate'] = const ValidationResult(
        isValid: false,
        errorMessage: 'Expiry date must be in MM/YY format',
      );
    }

    if (!RegExp(r'^\d{3,4}$').hasMatch(cvv)) {
      results['cvv'] = const ValidationResult(
        isValid: false,
        errorMessage: 'CVV must be 3 or 4 digits',
      );
    }

    return results;
  }

  /// Sanitizes user input for display
  static String sanitizeForDisplay(String input) => _validator.sanitizeInput(input);

  /// Validates and sanitizes search query
  static ValidationResult validateSearchQuery(String query) {
    if (query.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Search query cannot be empty',
      );
    }

    if (query.length < 2) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Search query must be at least 2 characters',
      );
    }

    if (query.length > 100) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Search query cannot exceed 100 characters',
      );
    }

    // Check for XSS attempts
    if (_validator.sanitizeInput(query) != query) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'Invalid characters detected in search query',
      );
    }

    return ValidationResult(
      isValid: true,
      sanitizedValue: query.trim(),
    );
  }
}
