import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_button.dart';

/// The type of error the page is representing.
/// Each type carries its own default icon, title, and message.
enum ErrorPageType {
  notFound,
  serverError,
  offline,
  sessionExpired,
  generic,
}

/// Full-screen error page for fatal or route-level errors.
///
/// Use this when the user cannot proceed and needs to take a clear action
/// (reload, navigate home, log in again). For transient errors that don't
/// block the whole screen, use [AppErrorBanner] or [AppToast] instead.
///
/// Usage (in GoRouter errorBuilder):
/// ```dart
/// errorBuilder: (context, state) => AppErrorPage(
///   type: ErrorPageType.notFound,
///   onPrimaryAction: () => context.go('/dashboard'),
/// ),
/// ```
class AppErrorPage extends StatelessWidget {
  const AppErrorPage({
    super.key,
    this.type = ErrorPageType.generic,
    this.title,
    this.message,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  final ErrorPageType type;

  /// Overrides the default title for this error type.
  final String? title;

  /// Overrides the default body message for this error type.
  final String? message;

  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;

  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    final content = _pageContent(type);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: content.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    content.icon,
                    size: 44,
                    color: content.iconColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),

                // Title
                Text(
                  title ?? content.defaultTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacing12),

                // Message
                Text(
                  message ?? content.defaultMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacing32),

                // Primary action
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    onPressed: onPrimaryAction,
                    text: primaryActionLabel ?? content.defaultPrimaryLabel,
                  ),
                ),

                // Secondary action (optional)
                if (onSecondaryAction != null &&
                    secondaryActionLabel != null) ...[
                  const SizedBox(height: AppTheme.spacing12),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onPressed: onSecondaryAction,
                      text: secondaryActionLabel!,
                      buttonType: AppButtonType.outlined,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Private helpers ────────────────────────────────────────────────────────

class _PageContent {
  const _PageContent({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.defaultTitle,
    required this.defaultMessage,
    required this.defaultPrimaryLabel,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String defaultTitle;
  final String defaultMessage;
  final String defaultPrimaryLabel;
}

_PageContent _pageContent(ErrorPageType type) => switch (type) {
      ErrorPageType.notFound => const _PageContent(
          icon: Icons.search_off_rounded,
          iconColor: AppColors.info,
          iconBgColor: Color(0xFFEFF6FF),
          defaultTitle: "Page not found",
          defaultMessage:
              "We couldn't find that page. Let's get you back on track.",
          defaultPrimaryLabel: "Go to Dashboard",
        ),
      ErrorPageType.serverError => const _PageContent(
          icon: Icons.cloud_off_rounded,
          iconColor: AppColors.warning,
          iconBgColor: Color(0xFFFFFBEB),
          defaultTitle: "Something went wrong",
          defaultMessage:
              "Our servers are having a moment. Try refreshing — it usually fixes things.",
          defaultPrimaryLabel: "Refresh Page",
        ),
      ErrorPageType.offline => const _PageContent(
          icon: Icons.wifi_off_rounded,
          iconColor: AppColors.grey500,
          iconBgColor: Color(0xFFF3F4F6),
          defaultTitle: "You're offline",
          defaultMessage:
              "Check your internet connection and try again.",
          defaultPrimaryLabel: "Try Again",
        ),
      ErrorPageType.sessionExpired => const _PageContent(
          icon: Icons.lock_clock_rounded,
          iconColor: AppColors.primary,
          iconBgColor: Color(0xFFDCFCE7),
          defaultTitle: "Session expired",
          defaultMessage:
              "Your session expired for security. Please log in again to continue.",
          defaultPrimaryLabel: "Log In Again",
        ),
      ErrorPageType.generic => const _PageContent(
          icon: Icons.error_outline_rounded,
          iconColor: AppColors.error,
          iconBgColor: Color(0xFFFEF2F2),
          defaultTitle: "Something unexpected happened",
          defaultMessage:
              "Refresh the page to start fresh. If this keeps happening, we're here to help.",
          defaultPrimaryLabel: "Refresh Page",
        ),
    };
