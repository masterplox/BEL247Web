import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/logger.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/auth.dart';
import '../../../theme/colors.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen for OTP sent success
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.otpSent && !(previous?.otpSent ?? false)) {
        Logger.info('OTP sent successfully, navigating to reset password page');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final contact = _contactController.text.trim();
            context.go('/reset-password?contact=$contact');
          }
        });
      }
      
      // Show error messages
      if (next.error != null && (previous?.error != next.error)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(next.error!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/login'),
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
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildContactForm(authState),
                  const SizedBox(height: 24),
                  if (authState.error != null) _buildErrorDisplay(authState.error!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
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
            'Forgot Password?',
            style: AppTextStyle.title,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Enter your email or phone number to receive a verification code',
            style: AppTextStyle.body,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _buildContactForm(AuthState authState) => AppCard(
        elevation: 8,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email or Phone Number',
                  hintText: 'Enter your email or phone',
                  prefixIcon: const Icon(Icons.contact_mail_outlined),
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
                    return 'Email or phone number is required';
                  }
                  final trimmedValue = value.trim();
                  // Validate email format
                  final isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(trimmedValue);
                  // Validate phone format (allows +, digits, spaces, dashes, parentheses)
                  final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');
                  final digitsOnly = trimmedValue.replaceAll(RegExp(r'[\s-()]'), '');
                  final isPhone = phoneRegex.hasMatch(trimmedValue) && digitsOnly.length >= 7;
                  
                  if (!isEmail && !isPhone) {
                    return 'Please enter a valid email or phone number';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _handleSendOtp(),
              ),
              const SizedBox(height: 24),
              AppButton(
                onPressed: _handleSendOtp,
                text: 'Continue',
                isLoading: authState.isLoading,
              ),
              const SizedBox(height: 16),
              AppButton(
                onPressed: () => context.go('/login'),
                text: 'Back to Login',
                buttonType: AppButtonType.text,
              ),
            ],
          ),
        ),
      );

  Widget _buildErrorDisplay(String error) => AppErrorState(
        message: error,
        icon: Icons.error_outline,
        onRetry: () {
          ref.read(authNotifierProvider.notifier).clearError();
        },
        padding: const EdgeInsets.all(16),
      );

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      final contact = _contactController.text.trim();
      Logger.info('Sending OTP to: $contact');
      ref.read(authNotifierProvider.notifier).sendOtp(contact);
    }
  }
}

