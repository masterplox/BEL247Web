import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/colors.dart';

/// Result of submitting contact info for code delivery (exactly one field set).
class ContactCodeDeliveryResult {
  const ContactCodeDeliveryResult({
    this.mobileNumber,
    this.email,
    this.username,
    required this.contactType,
    required this.contactDisplay,
  });

  final String? mobileNumber;
  final String? email;
  final String? username;
  final String contactType; // 'phone', 'email', or 'username'
  final String contactDisplay;
}

/// Reusable email/phone form for OTP or password-reset code delivery.
class ContactCodeDeliveryForm extends StatefulWidget {
  const ContactCodeDeliveryForm({
    required this.onSubmit,
    this.isLoading = false,
    this.submitLabel = 'Send Code',
    super.key,
  });

  final Future<void> Function(ContactCodeDeliveryResult result) onSubmit;
  final bool isLoading;
  final String submitLabel;

  @override
  State<ContactCodeDeliveryForm> createState() => _ContactCodeDeliveryFormState();
}

class _ContactCodeDeliveryFormState extends State<ContactCodeDeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  bool _isPhoneMode = false;
  static const String _phonePrefix = '+501';

  @override
  void initState() {
    super.initState();
    _contactController.addListener(_onContactChanged);
  }

  @override
  void dispose() {
    _contactController.removeListener(_onContactChanged);
    _contactController.dispose();
    super.dispose();
  }

  void _onContactChanged() {
    final text = _contactController.text;

    if (text.isNotEmpty && RegExp(r'^[0-9]+$').hasMatch(text)) {
      if (!_isPhoneMode) {
        setState(() => _isPhoneMode = true);
      }
      if (text.length > 7) {
        _contactController.value = TextEditingValue(
          text: text.substring(0, 7),
          selection: const TextSelection.collapsed(offset: 7),
        );
      }
    } else if (text.isEmpty) {
      if (_isPhoneMode) {
        setState(() => _isPhoneMode = false);
      }
    } else if (_isPhoneMode && !RegExp(r'^[0-9]+$').hasMatch(text)) {
      setState(() {
        _isPhoneMode = false;
        final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
        _contactController.value = TextEditingValue(
          text: digits,
          selection: TextSelection.collapsed(offset: digits.length),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _contactController,
                  keyboardType:
                      _isPhoneMode ? TextInputType.phone : TextInputType.emailAddress,
                  inputFormatters: _isPhoneMode
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(7),
                        ]
                      : null,
                  decoration: InputDecoration(
                    labelText:
                        _isPhoneMode ? 'Phone Number' : 'Email or Phone Number',
                    hintText: _isPhoneMode ? '1234567' : 'Enter your contact info',
                    prefixText: _isPhoneMode ? _phonePrefix : null,
                    prefixIcon: Icon(
                      _isPhoneMode ? Icons.phone : Icons.contact_mail_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact information is required';
                    }
                    if (_isPhoneMode) {
                      if (value.length != 7) {
                        return 'Please enter a valid 7-digit Belize phone number';
                      }
                      if (!RegExp(r'^[0-9]{7}$').hasMatch(value)) {
                        return 'Phone number must contain only digits';
                      }
                    } else {
                      final isEmail = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value);
                      if (!isEmail) {
                        return 'Please enter a valid email address';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: widget.isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: widget.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          widget.submitLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final contact = _contactController.text.trim();
    final ContactCodeDeliveryResult result;

    if (_isPhoneMode) {
      final phoneNumber = _phonePrefix + contact;
      result = ContactCodeDeliveryResult(
        mobileNumber: phoneNumber,
        contactType: 'phone',
        contactDisplay: phoneNumber,
      );
    } else {
      result = ContactCodeDeliveryResult(
        email: contact,
        contactType: 'email',
        contactDisplay: contact,
      );
    }

    await widget.onSubmit(result);
  }
}
