import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable card widget that provides consistent styling across the app.
/// All customization options are available while maintaining a single source of truth
/// for default styling that can be changed in one place.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.title,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
    this.borderRadius,
    this.onTap,
    this.border,
    this.clipBehavior,
    this.semanticContainer = true,
  });

  /// The main content of the card
  final Widget child;

  /// Optional title widget displayed above the child
  final Widget? title;

  /// Padding inside the card. Defaults to `EdgeInsets.all(AppTheme.spacing16)`
  final EdgeInsetsGeometry? padding;

  /// Margin around the card. Defaults to `null` (no margin)
  final EdgeInsetsGeometry? margin;

  /// Elevation of the card. Defaults to `2`
  final double? elevation;

  /// Background color of the card. Defaults to `AppColors.surface`
  final Color? color;

  /// Border radius of the card. Defaults to `AppTheme.radius12`
  final double? borderRadius;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Optional custom border configuration
  /// Example: `Border(left: BorderSide(color: AppColors.primary, width: 4))`
  final Border? border;

  /// Clip behavior for the card. Defaults to `Clip.antiAlias`
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container.
  /// Defaults to `true`
  final bool semanticContainer;

  @override
  Widget build(BuildContext context) {
    final cardContent = _buildCardContent();

    final card = Card(
      elevation: elevation ?? 0.0,
      color: color ?? Theme.of(context).colorScheme.surface,
      margin: margin,
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      semanticContainer: semanticContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.radius12),
      ),
      child: border != null
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.radius12),
                border: border,
              ),
              child: cardContent,
            )
          : cardContent,
    );

    // Wrap with InkWell if onTap is provided
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.radius12),
        child: card,
      );
    }

    return card;
  }

  Widget _buildCardContent() {
    final contentPadding = padding ?? const EdgeInsets.all(AppTheme.spacing16);

    if (title == null) {
      return Padding(
        padding: contentPadding,
        child: child,
      );
    }

    return Padding(
      padding: contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          title!,
          const SizedBox(height: AppTheme.spacing16),
          child,
        ],
      ),
    );
  }
}
