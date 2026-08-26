import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'app_page_header.dart';
import 'centered_content.dart';
import 'fill_viewport_scroll.dart';

/// A reusable page scaffold that standardizes:
/// - Optional [AppBar]
/// - Centered, max-width content with horizontal padding
/// - Optional page header (title + subtitle + actions)
///
/// This is a thin convenience wrapper around existing building blocks
/// (`CenteredContent` and `AppPageHeader`) so that feature pages can
/// focus on their specific body content while keeping layout consistent.
class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    this.appBar,
    this.title,
    this.subtitle,
    this.headerActions,
    required this.body,
    this.maxWidth = 1280,
    this.enableScroll = true,
  });

  /// Optional app bar for the page.
  final PreferredSizeWidget? appBar;

  /// Optional page title.
  final String? title;

  /// Optional page subtitle.
  final String? subtitle;

  /// Optional header actions shown to the right of the title.
  final List<Widget>? headerActions;

  /// Main page body widget.
  final Widget body;

  /// Maximum content width before adding side gutters.
  final double maxWidth;

  /// Whether to wrap the content in a [SingleChildScrollView].
  ///
  /// Most dashboard-style pages should keep this `true`, but some full-screen
  /// layouts may choose to disable it.
  final bool enableScroll;

  @override
  Widget build(BuildContext context) {
    Widget content = CenteredContent(
      maxWidth: maxWidth,
      horizontalPadding: AppTheme.spacing16,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              AppPageHeader(
                title: title!,
                subtitle: subtitle,
                actions: headerActions,
              ),
            if (title != null) const SizedBox(height: AppTheme.spacing20),
            body,
          ],
        ),
      ),
    );

    if (enableScroll) {
      content = FillViewportScroll(child: content);
    }

    return Scaffold(
      appBar: appBar,
      body: content,
    );
  }
}

