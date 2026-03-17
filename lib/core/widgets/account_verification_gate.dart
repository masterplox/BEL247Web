import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/account_verification_providers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

typedef AccountVerificationBuilder = Widget Function(
  BuildContext context,
  bool isVerified,
);

/// Reusable gate widget that can wrap any feature and optionally restrict it
/// when the current account is not verified (i.e. when `accountLocked == true`).
///
/// - Set [restrictIfUnverified] to `true` to enforce the check.
/// - Use [builder] to build the "normal" UI; it receives `isVerified`.
/// - Optionally provide [restrictedChild] to show a custom replacement when
///   the account is not verified. If omitted, a default info banner is shown.
class AccountVerificationGate extends ConsumerWidget {
  const AccountVerificationGate({
    super.key,
    required this.builder,
    this.restrictIfUnverified = true,
    this.restrictedChild,
  });

  final AccountVerificationBuilder builder;
  final bool restrictIfUnverified;
  final Widget? restrictedChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!restrictIfUnverified) {
      return builder(context, true);
    }

    final verificationAsync = ref.watch(accountVerificationStatusProvider);

    return verificationAsync.when(
      // While loading or on error we default to treating the user as verified
      // so we don't accidentally block access if the check fails.
      loading: () => builder(context, true),
      error: (_, __) => builder(context, true),
      data: (isVerified) {
        if (isVerified) {
          return builder(context, true);
        }

        if (restrictedChild != null) {
          return restrictedChild!;
        }

        return const _DefaultRestrictedMessage();
      },
    );
  }
}

class _DefaultRestrictedMessage extends StatelessWidget {
  const _DefaultRestrictedMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.warning),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Text(
              'This feature is restricted until your account has been verified as the account holder.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

