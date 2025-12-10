import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable responsive layout widget that switches between mobile, tablet, and desktop layouts.
class AppResponsiveLayout extends StatelessWidget {
  const AppResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileBreakpoint,
    this.tabletBreakpoint,
    this.desktopBreakpoint,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final double? mobileBreakpoint;
  final double? tabletBreakpoint;
  final double? desktopBreakpoint;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) {
        final desktopBreak = desktopBreakpoint ?? AppTheme.desktopBreakpoint;
        final tabletBreak = tabletBreakpoint ?? AppTheme.tabletBreakpoint;

        if (constraints.maxWidth >= desktopBreak && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= tabletBreak && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
}

