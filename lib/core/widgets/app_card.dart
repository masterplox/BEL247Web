import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

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
    this.showBorder = true,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  /// The main content of the card
  final Widget child;

  /// Optional title widget displayed above the child
  final Widget? title;

  /// Padding inside the card. Defaults to `EdgeInsets.all(AppTheme.spacing16)`
  final EdgeInsetsGeometry? padding;

  /// Margin around the card. Defaults to `null` (no margin)
  final EdgeInsetsGeometry? margin;

  /// Elevation of the card. Defaults to `0` (no elevation)
  final double? elevation;

  /// Background color of the card. Defaults to `Theme.of(context).scaffoldBackgroundColor`
  final Color? color;

  /// Border radius of the card. Defaults to `AppTheme.radius12`
  final double? borderRadius;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Optional custom border configuration
  /// Example: `Border(left: BorderSide(color: AppColors.primary, width: 4))`
  /// If provided, this overrides showBorder, borderColor, and borderWidth
  final Border? border;

  /// Clip behavior for the card. Defaults to `Clip.antiAlias`
  final Clip? clipBehavior;

  /// Whether this widget represents a single semantic container.
  /// Defaults to `true`
  final bool semanticContainer;

  /// Whether to show a thin border around the card. Defaults to `true`
  final bool showBorder;

  /// Color of the border. Defaults to `AppColors.border` or scaffold background divider
  final Color? borderColor;

  /// Width of the border. Defaults to `1.0`
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final cardContent = _buildCardContent();
    final theme = Theme.of(context);
    final cardBackgroundColor = color ?? theme.scaffoldBackgroundColor;
    final defaultBorderColor = borderColor ?? AppColors.border;
    
    // Determine the border to use
    final effectiveBorder = border ?? 
        (showBorder 
            ? Border.all(
                color: defaultBorderColor,
                width: borderWidth,
              )
            : null);

    final borderRadiusValue = borderRadius ?? AppTheme.radius12;

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadiusValue),
        border: effectiveBorder,
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation! * 2,
                  offset: Offset(0, elevation!),
                ),
              ]
            : null,
      ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      child: cardContent,
    );

    // Wrap with InkWell if onTap is provided
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadiusValue),
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
