import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Styled snackbar helper for brief user notifications.
///
/// Provides presets for error, success, warning, and info states.
/// All messages automatically hide after 4 seconds.
///
/// Usage:
/// ```dart
/// AppToast.error(context, ErrorMessages.downloadFailed, onAction: retry, actionLabel: 'Retry');
/// AppToast.success(context, 'Bill downloaded!');
/// ```
class AppToast {
  AppToast._();

  /// Show an error toast — for recoverable failures the user should know about.
  static void error(
    BuildContext context,
    String message, {
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_outline,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  /// Show a success toast.
  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_outline,
    );
  }

  /// Show a warning toast.
  static void warning(
    BuildContext context,
    String message, {
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.warning_amber_outlined,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  /// Show an informational toast.
  static void info(BuildContext context, String message) {
    _show(
      context,
      message: message,
      icon: Icons.info_outline,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Row(
          children: [
            Icon(icon, color: AppColors.textInverse, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.textInverse, fontSize: 13),
              ),
            ),
          ],
        ),
        action: (onAction != null && actionLabel != null)
            ? SnackBarAction(
                label: actionLabel,
                textColor: AppColors.textInverse,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}
