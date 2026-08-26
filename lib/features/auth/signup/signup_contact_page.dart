import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/colors.dart';
import '../../../core/widgets/fill_viewport_scroll.dart';
import '../providers/auth_provider.dart';
import '../widgets/contact_code_delivery_form.dart';

class SignupContactPage extends ConsumerStatefulWidget {
  const SignupContactPage({super.key});

  @override
  ConsumerState<SignupContactPage> createState() => _SignupContactPageState();
}

class _SignupContactPageState extends ConsumerState<SignupContactPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.otpSent && !next.signupCompleted && !(previous?.otpSent ?? false)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go('/signup/verify');
          }
        });
      }
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
          tooltip: 'Back to Login',
        ),
      ),
      body: SafeArea(
        child: FillViewportScroll(
          padding: const EdgeInsets.all(24),
          child: Center(
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
                    onSubmit: (result) async {
                      await ref.read(authNotifierProvider.notifier).signUpStep1(
                            mobileNumber: result.mobileNumber,
                            email: result.email,
                          );
                    },
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
          Text(
            'Create your account',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your email or phone number to get started.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
