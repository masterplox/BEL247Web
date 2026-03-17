import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/account_verification_providers.dart';
import '../../../core/widgets/account_access_activation_dialog.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Banner shown on the dashboard when the current account is not verified.
class AccountVerificationBanner extends ConsumerWidget {
  const AccountVerificationBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationAsync = ref.watch(accountVerificationStatusProvider);

    return verificationAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (isVerified) {
        if (isVerified) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(
              color: AppColors.warning.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: AppColors.warning),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification required',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      'To protect your information, you need to verify that you are the account holder before viewing full personal details or downloading bills.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              TextButton(
                onPressed: () async {
                  final result =
                      await showFullAccessActivationDialog(context);
                  if (result == true) {
                    // Refresh verification status so the banner can disappear.
                    ref.invalidate(accountVerificationStatusProvider);
                  }
                },
                child: const Text('Verify now'),
              ),
            ],
          ),
        );
      },
    );
  }
}

