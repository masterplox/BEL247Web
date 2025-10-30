import 'package:flutter/material.dart';

import '../services/input_validator_service.dart';

/// A text form field with built-in validation
class ValidatedTextFormField extends StatefulWidget {

  const ValidatedTextFormField({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validationType = ValidationType.text,
    this.enableXSSProtection = true,
  });
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;
  final String? initialValue;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValidationType validationType;
  final bool enableXSSProtection;

  @override
  State<ValidatedTextFormField> createState() => _ValidatedTextFormFieldState();
}

class _ValidatedTextFormFieldState extends State<ValidatedTextFormField> {
  late TextEditingController _controller;
  final InputValidatorService _validator = InputValidatorService();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String? _validateInput(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }

    if (value == null || value.isEmpty) {
      return '${widget.label} is required';
    }

    ValidationResult result;

    switch (widget.validationType) {
      case ValidationType.email:
        result = _validator.validateEmail(value);
        break;
      case ValidationType.phone:
        result = _validator.validatePhoneNumber(value);
        break;
      case ValidationType.amount:
        result = _validator.validateAmount(value);
        break;
      case ValidationType.password:
        result = _validator.validatePassword(value);
        break;
      case ValidationType.text:
        result = _validator.validateText(
          value,
          minLength: 1,
          maxLength: widget.maxLength ?? 255,
          fieldName: widget.label,
        );
        break;
    }

    if (!result.isValid) {
      return result.errorMessage;
    }

    // Apply XSS protection if enabled
    if (widget.enableXSSProtection && result.sanitizedValue != null) {
      final sanitized = _validator.sanitizeInput(result.sanitizedValue!);
      if (sanitized != value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.text = sanitized;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitized.length),
          );
        });
      }
    }

    return null;
  }

  void _onChanged(String value) {
    setState(() {
      _errorText = _validateInput(value);
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorText: _errorText,
        border: const OutlineInputBorder(),
        enabled: widget.enabled,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      validator: _validateInput,
      onChanged: _onChanged,
      onSaved: (value) {
        if (widget.onSaved != null) {
          widget.onSaved!(value ?? '');
        }
      },
    );
}

/// Validation types for different input fields
enum ValidationType {
  email,
  phone,
  amount,
  password,
  text,
}

/// A form validator widget that provides real-time validation feedback
class FormValidator extends StatefulWidget {

  const FormValidator({
    super.key,
    required this.child,
    this.formKey,
    this.initialValues = const {},
    this.enableRealTimeValidation = true,
  });
  final Widget child;
  final GlobalKey<FormState>? formKey;
  final Map<String, String> initialValues;
  final bool enableRealTimeValidation;

  @override
  State<FormValidator> createState() => _FormValidatorState();
}

class _FormValidatorState extends State<FormValidator> {
  final Map<String, String> _formData = {};
  final Map<String, ValidationResult> _validationResults = {};
  final InputValidatorService _validator = InputValidatorService();

  @override
  void initState() {
    super.initState();
    _formData.addAll(widget.initialValues);
  }

  void updateField(String fieldName, String value) {
    setState(() {
      _formData[fieldName] = value;
      
      if (widget.enableRealTimeValidation) {
        _validationResults[fieldName] = _validateField(fieldName, value);
      }
    });
  }

  ValidationResult _validateField(String fieldName, String value) {
    switch (fieldName.toLowerCase()) {
      case 'email':
        return _validator.validateEmail(value);
      case 'phone':
      case 'phonenumber':
        return _validator.validatePhoneNumber(value);
      case 'amount':
      case 'price':
      case 'cost':
        return _validator.validateAmount(value);
      case 'password':
        return _validator.validatePassword(value);
      default:
        return _validator.validateText(
          value,
          minLength: 1,
          maxLength: 255,
          fieldName: fieldName,
        );
    }
  }

  bool validateForm() {
    final results = _validator.validateFormData(_formData);
    setState(() {
      _validationResults.addAll(results);
    });
    return _validator.isFormValid(results);
  }

  List<String> getErrorMessages() => _validator.getErrorMessages(_validationResults);

  Map<String, String> getSanitizedData() {
    final sanitizedData = <String, String>{};
    for (final entry in _formData.entries) {
      final result = _validationResults[entry.key];
      if (result != null && result.isValid && result.sanitizedValue != null) {
        sanitizedData[entry.key] = result.sanitizedValue!;
      } else {
        sanitizedData[entry.key] = entry.value;
      }
    }
    return sanitizedData;
  }

  @override
  Widget build(BuildContext context) => FormValidatorProvider(
      formValidator: this,
      child: widget.child,
    );
}

/// Provider for accessing form validator from child widgets
class FormValidatorProvider extends InheritedWidget {

  const FormValidatorProvider({
    super.key,
    required this.formValidator,
    required super.child,
  });
  final _FormValidatorState formValidator;

  static _FormValidatorState? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FormValidatorProvider>()
        ?.formValidator;

  @override
  bool updateShouldNotify(FormValidatorProvider oldWidget) => formValidator != oldWidget.formValidator;
}

/// Mixin for widgets that need form validation
mixin FormValidationMixin<T extends StatefulWidget> on State<T> {
  _FormValidatorState? get formValidator => FormValidatorProvider.of(context);

  void updateFormField(String fieldName, String value) {
    formValidator?.updateField(fieldName, value);
  }

  bool validateForm() => formValidator?.validateForm() ?? false;

  List<String> getFormErrors() => formValidator?.getErrorMessages() ?? [];

  Map<String, String> getSanitizedFormData() => formValidator?.getSanitizedData() ?? {};
}
