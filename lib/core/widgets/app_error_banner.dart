import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

/// Severity / intent of an [AppErrorBanner].
enum ErrorBannerType { error, warning, info }

/// A dismissible inline banner shown at the top of a screen for transient errors.
///
/// Use this for non-critical issues that don't block the user completely —
/// e.g. a failed data refresh that still shows cached data.
///
/// For fatal full-screen errors use [AppErrorPage].
/// For brief pop-up notifications use [AppToast].
///
/// Usage:
/// ```dart
/// AppErrorBanner(
///   message: ErrorMessages.billLoadFailed,
///   onDismiss: () => setState(() => _showBanner = false),
///   onAction: _retry,
///   actionLabel: ErrorMessages.retryAction,
/// )
/// ```
class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({
    super.key,
    required this.message,
    this.type = ErrorBannerType.error,
    this.onDismiss,
    this.onAction,
    this.actionLabel,
  });

  final String message;
  final ErrorBannerType type;

  /// Called when the user taps the ✕ button. If null, no dismiss button is shown.
  final VoidCallback? onDismiss;

  /// Called when the user taps the optional action button.
  final VoidCallback? onAction;

  /// Label for the action button. Required when [onAction] is set.
  final String? actionLabel;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border(
            bottom: BorderSide(color: _borderColor, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing12,
        ),
        child: Row(
          children: [
            Icon(_icon, color: _iconColor, size: 18),
            const SizedBox(width: AppTheme.spacing8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: _textColor, fontSize: 13),
              ),
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(width: AppTheme.spacing8),
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: _iconColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            if (onDismiss != null) ...[
              const SizedBox(width: AppTheme.spacing4),
              IconButton(
                icon: Icon(Icons.close, size: 16, color: _textColor),
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints:
                    const BoxConstraints(minWidth: 24, minHeight: 24),
                tooltip: 'Dismiss',
              ),
            ],
          ],
        ),
      );

  Color get _backgroundColor => switch (type) {
        ErrorBannerType.error => const Color(0xFFFEF2F2),
        ErrorBannerType.warning => const Color(0xFFFFFBEB),
        ErrorBannerType.info => const Color(0xFFEFF6FF),
      };

  Color get _borderColor => switch (type) {
        ErrorBannerType.error => AppColors.error,
        ErrorBannerType.warning => AppColors.warning,
        ErrorBannerType.info => AppColors.info,
      };

  Color get _iconColor => switch (type) {
        ErrorBannerType.error => AppColors.error,
        ErrorBannerType.warning => AppColors.warning,
        ErrorBannerType.info => AppColors.info,
      };

  IconData get _icon => switch (type) {
        ErrorBannerType.error => Icons.error_outline,
        ErrorBannerType.warning => Icons.warning_amber_outlined,
        ErrorBannerType.info => Icons.info_outline,
      };

  Color get _textColor => switch (type) {
        ErrorBannerType.error => const Color(0xFF991B1B),
        ErrorBannerType.warning => const Color(0xFF92400E),
        ErrorBannerType.info => const Color(0xFF1E40AF),
      };
}
