import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/logger.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/auth.dart';
import '../../../theme/colors.dart';
import '../providers/auth_provider.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key, this.contact});

  final String? contact;

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isResetting = false;
  Map<String, String> _fieldErrors = {};

  String? get _contact {
    // Get contact from route parameter or auth state
    final contact = widget.contact ?? 
        ref.read(authNotifierProvider).otpContact;
    if (contact == null) {
      Logger.warning('No contact information found for password reset');
    }
    return contact;
  }

  @override
  void initState() {
    super.initState();
    // Validate that we have contact info
    if (_contact == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showErrorDialog('Missing contact information. Please start over.');
          context.go('/forgot-password');
        }
      });
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final contact = _contact;

    // Listen for password reset success/error
    ref.listen(authNotifierProvider, (previous, next) {
      // Check for success (no error and not loading after we initiated the request)
      if (_isResetting && !next.isLoading && next.error == null && (previous?.isLoading ?? false)) {
        // Password reset successful
        setState(() {
          _isResetting = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSuccessDialog();
          }
        });
      }
      
      if (next.error != null && previous?.error != next.error && _isResetting) {
        // Parse error message to extract field errors if present
        final errorMessage = next.error!;
        setState(() {
          _isResetting = false; // Reset loading state on error
          
          // Try to extract field-specific errors from error message
          if (errorMessage.contains('password') || errorMessage.contains('Password')) {
            if (errorMessage.contains('match')) {
              _fieldErrors['confirmPassword'] = 'Passwords do not match';
            } else if (errorMessage.contains('6')) {
              _fieldErrors['newPassword'] = 'Password must be at least 6 characters';
            }
          }
          if (errorMessage.contains('OTP') || errorMessage.contains('otp') || errorMessage.contains('code')) {
            _fieldErrors['otp'] = errorMessage.contains('Invalid') 
                ? 'Invalid OTP code' 
                : 'OTP code error';
          }
        });
      }
    });

    if (contact == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              const AppText(
                'Missing contact information',
                style: AppTextStyle.title,
              ),
              const SizedBox(height: 8),
              const AppText(
                'Please start the password reset process again',
                style: AppTextStyle.body,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: () => context.go('/forgot-password'),
                text: 'Go Back',
              ),
            ],
          ),
        ),
      );
    }

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.error),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/forgot-password'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(contact),
                  const SizedBox(height: 48),
                  _buildForm(authState, defaultPinTheme, focusedPinTheme, errorPinTheme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String contact) => Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.lock_reset,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const AppText(
            'Reset Password',
            style: AppTextStyle.title,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          AppText(
            'Enter your new password and the verification code sent to\n$contact',
            style: AppTextStyle.body,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _buildForm(
    AuthState authState,
    PinTheme defaultPinTheme,
    PinTheme focusedPinTheme,
    PinTheme errorPinTheme,
  ) =>
      AppCard(
        elevation: 8,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // New Password Field
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _fieldErrors.containsKey('newPassword') ? AppColors.error : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  if (_fieldErrors.containsKey('newPassword')) {
                    return _fieldErrors['newPassword'];
                  }
                  return null;
                },
                onChanged: (_) {
                  // Clear field error when user starts typing
                  if (_fieldErrors.containsKey('newPassword')) {
                    setState(() {
                      _fieldErrors.remove('newPassword');
                    });
                  }
                },
              ),
              if (_fieldErrors.containsKey('newPassword')) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    _fieldErrors['newPassword']!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              
              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your new password',
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _fieldErrors.containsKey('confirmPassword') ? AppColors.error : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  if (_fieldErrors.containsKey('confirmPassword')) {
                    return _fieldErrors['confirmPassword'];
                  }
                  return null;
                },
                onChanged: (_) {
                  // Clear field error when user starts typing
                  if (_fieldErrors.containsKey('confirmPassword')) {
                    setState(() {
                      _fieldErrors.remove('confirmPassword');
                    });
                  }
                },
              ),
              if (_fieldErrors.containsKey('confirmPassword')) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    _fieldErrors['confirmPassword']!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              
              // OTP Code Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Verification Code',
                    style: AppTextStyle.body,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  Pinput(
                    controller: _otpController,
                    length: 5,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    errorPinTheme: errorPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the verification code';
                      }
                      if (value.length != 5) {
                        return 'Code must be 5 digits';
                      }
                      if (_fieldErrors.containsKey('otp')) {
                        return _fieldErrors['otp'];
                      }
                      return null;
                    },
                    onCompleted: (pin) {
                      // Auto-validate when OTP is complete
                      _formKey.currentState?.validate();
                    },
                    onChanged: (_) {
                      // Clear field error when user starts typing
                      if (_fieldErrors.containsKey('otp')) {
                        setState(() {
                          _fieldErrors.remove('otp');
                        });
                      }
                    },
                  ),
                  if (_fieldErrors.containsKey('otp')) ...[
                    const SizedBox(height: 4),
                    Text(
                      _fieldErrors['otp']!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              
              // Reset Password Button
              AppButton(
                onPressed: (_isResetting || authState.isLoading) ? null : _handleResetPassword,
                text: 'Reset Password',
                isLoading: _isResetting || authState.isLoading,
              ),
              const SizedBox(height: 16),
              AppButton(
                onPressed: () => context.go('/forgot-password'),
                text: 'Back',
                buttonType: AppButtonType.text,
              ),
            ],
          ),
        ),
      );

  Future<void> _handleResetPassword() async {
    final contact = _contact;
    if (contact == null) {
      _showErrorDialog('Missing contact information. Please start over.');
      context.go('/forgot-password');
      return;
    }

    // Clear previous errors
    setState(() {
      _fieldErrors = {};
    });
    
    // Validate form - don't set loading state if validation fails
    if (!_formKey.currentState!.validate()) {
      return; // Return early, don't set loading state
    }

    // Only set loading state after validation passes
    setState(() {
      _isResetting = true;
      _fieldErrors = {};
    });

    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final otp = _otpController.text.trim();

    Logger.info('Resetting password for: $contact');

    try {
      await ref.read(authNotifierProvider.notifier).resetPassword(
            phone: contact, // API uses "phone" field but accepts email or phone
            newPassword: newPassword,
            confirmPassword: confirmPassword,
            otp: otp,
          );
      
      // Success is handled by the listener above
    } catch (e) {
      Logger.error('Error resetting password', error: e);
      setState(() {
        _isResetting = false; // Reset loading state on error
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success),
            SizedBox(width: 12),
            Text('Password Reset Successful'),
          ],
        ),
        content: const Text(
          'Your password has been successfully reset. You can now log in with your new password.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Clear OTP state
              ref.read(authNotifierProvider.notifier).resetOtpState();
              context.go('/login');
            },
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.error),
            SizedBox(width: 12),
            Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
