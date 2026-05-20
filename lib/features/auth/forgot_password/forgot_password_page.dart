import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/logger.dart';
import '../../../core/widgets/app_text.dart';
import '../../../theme/colors.dart';
import '../providers/auth_provider.dart';
import '../../../core/constants/customer_portal_support_types.dart';
import '../../../core/widgets/customer_portal_support_button.dart';
import '../widgets/contact_code_delivery_form.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({
    super.key,
    this.authenticated = false,
  });

  /// When true, uses authenticated password-code endpoint (dashboard flow).
  final bool authenticated;

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.otpSent && !(previous?.otpSent ?? false)) {
        Logger.info('Password code sent, navigating to reset password page');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final contact = next.otpContact ?? '';
            final base = widget.authenticated
                ? '/account/reset-password/confirm'
                : '/reset-password';
            context.go('$base?contact=${Uri.encodeComponent(contact)}');
          }
        });
      }

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
          onPressed: () {
            if (widget.authenticated) {
              context.go('/dashboard');
            } else {
              context.go('/login');
            }
          },
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
                  ContactCodeDeliveryForm(
                    isLoading: authState.isLoading,
                    onSubmit: (result) => ref
                        .read(authNotifierProvider.notifier)
                        .requestPasswordCode(
                          mobileNumber: result.mobileNumber,
                          email: result.email,
                          authenticated: widget.authenticated,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: CustomerPortalSupportButton(
                      sourcePage: widget.authenticated
                          ? '/account/reset-password'
                          : '/forgot-password',
                      initialSupportType:
                          CustomerPortalSupportTypes.passwordResetCode,
                    ),
                  ),
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
}
