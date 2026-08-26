import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../providers/feature_providers.dart';
import '../providers/meter_data_providers.dart';

/// Persistent notice banner that appears at the top of all pages
class NoticeBanner extends ConsumerWidget {
  const NoticeBanner({super.key});

  static const String nonAmiMeterMessage =
      'This account is not an AMI meter. Interval and time-of-use usage breakdowns are not available.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeState = ref.watch(noticeBannerProvider);
    final activeAccount = ref.watch(accountSwitcherProvider).activeAccount;
    final isAmiMeter = ref.watch(isAmiMeterProvider);
    final dismissedAccountId = ref.watch(nonAmiNoticeDismissedAccountIdProvider);

    final showNonAmiNotice = activeAccount != null &&
        !isAmiMeter &&
        dismissedAccountId != activeAccount.id;

    if (showNonAmiNotice) {
      return _banner(
        context,
        message: nonAmiMeterMessage,
        colors: _NoticeBannerColors.nonAmi,
        onDismiss: () {
          ref.read(nonAmiNoticeDismissedAccountIdProvider.notifier).state =
              activeAccount.id;
        },
      );
    }

    if (!noticeState.isVisible) {
      return const SizedBox.shrink();
    }

    return _banner(
      context,
      message: noticeState.message,
      colors: _NoticeBannerColors.warning,
      onDismiss: () {
        ref.read(noticeBannerProvider.notifier).hide();
      },
    );
  }

  Widget _banner(
    BuildContext context, {
    required String message,
    required _NoticeBannerColors colors,
    required VoidCallback onDismiss,
  }) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.background,
          border: Border(
            top: BorderSide(color: colors.border, width: 1),
            bottom: BorderSide(color: colors.border, width: 1),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing8,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.accent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '!',
                      style: TextStyle(
                        color: colors.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.text,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing8),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: colors.text,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  onPressed: onDismiss,
                  tooltip: 'Dismiss',
                ),
              ],
            ),
          ),
        ),
      );
}

class _NoticeBannerColors {
  const _NoticeBannerColors({
    required this.background,
    required this.border,
    required this.accent,
    required this.text,
  });

  final Color background;
  final Color border;
  final Color accent;
  final Color text;

  /// TOU / maintenance: existing orange strip.
  static const warning = _NoticeBannerColors(
    background: Color(0xFFFFF4E6),
    border: Color(0xFFFF8C42),
    accent: Color(0xFFD97706),
    text: Color(0xFF9A3412),
  );

  /// Non-AMI: quieter slate-blue that still reads on the white page.
  static const nonAmi = _NoticeBannerColors(
    background: Color(0xFFEEF4F8),
    border: Color(0xFF6B8CA8),
    accent: Color(0xFF3D5A73),
    text: Color(0xFF2A4458),
  );
}

