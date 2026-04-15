import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Dialog display mode
enum DialogMode {
  /// Standard centered dialog
  center,
  /// Slide-up dialog from bottom (like bottom sheet)
  bottom,
}

/// Reusable dialog widget that supports both center and bottom slide-up modes
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.actions,
    this.mode = DialogMode.center,
    this.maxWidth,
    this.showCloseButton = true,
    this.onClose,
    this.contentPadding,
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final List<Widget>? actions;
  final DialogMode mode;
  final double? maxWidth;
  final bool showCloseButton;
  final VoidCallback? onClose;

  /// Padding around [content] in bottom-sheet mode (scroll area).
  final EdgeInsetsGeometry? contentPadding;

  /// Show the dialog in center mode.
  ///
  /// [barrierDismissible] defaults to `true` so tapping the scrim closes the dialog.
  static Future<T?> showCenter<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget content,
    List<Widget>? actions,
    double? maxWidth,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        subtitle: subtitle,
        content: content,
        actions: actions,
        mode: DialogMode.center,
        maxWidth: maxWidth,
        showCloseButton: showCloseButton,
      ),
    );
  }

  /// Show the dialog in bottom slide-up mode.
  ///
  /// [isDismissible] defaults to `true` (tap outside / drag down dismisses).
  static Future<T?> showBottom<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget content,
    List<Widget>? actions,
    double? maxWidth,
    bool showCloseButton = true,
    bool isDismissible = true,
    bool enableDrag = true,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => AppDialog(
        title: title,
        subtitle: subtitle,
        content: content,
        actions: actions,
        mode: DialogMode.bottom,
        maxWidth: maxWidth,
        showCloseButton: showCloseButton,
        // Pop the modal route only — rootNavigator would pop the wrong route in nested navigator setups.
        onClose: () => Navigator.of(sheetContext).pop(),
        contentPadding: contentPadding,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mode == DialogMode.bottom) {
      return _buildBottomSheet(context);
    }
    return _buildCenterDialog(context);
  }

  Widget _buildCenterDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 500,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppTheme.spacing16),
              Flexible(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: AppTheme.spacing24),
                _buildActions(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final scrollPadding = contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        );
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        maxWidth: maxWidth ?? double.infinity,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: AppTheme.spacing8,
              ),
              child: _buildHeader(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: scrollPadding,
                child: content,
              ),
            ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                child: _buildActions(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ],
          ),
        ),
        if (showCloseButton)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose ?? () => Navigator.of(context, rootNavigator: true).pop(),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    if (actions == null || actions!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (mode == DialogMode.bottom) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: actions!
            .map((action) => SizedBox(
                  width: double.infinity,
                  child: action,
                ))
            .toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: actions!,
    );
  }
}
