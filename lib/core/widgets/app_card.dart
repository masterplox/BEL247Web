import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.child,
    this.title,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
  });

  final Widget? child;
  final Widget? title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      color: color,
      margin: margin,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              title!,
              const SizedBox(height: AppTheme.spacing16),
            ],
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
