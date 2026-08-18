import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A simple bootstrap-like container that centers page content and
/// constrains its maximum width. Use this to wrap page bodies so
/// wide screens get comfortable left/right gutters.
class CenteredContent extends StatelessWidget {
  const CenteredContent({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.horizontalPadding = AppTheme.spacing16,
  });

  final Widget child;
  final double maxWidth;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth < 400
                      ? AppTheme.spacing8
                      : horizontalPadding,
                ),
                child: child,
              ),
            ),
          ),
      );
}


