import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation_providers.dart';
import 'responsive_navigation.dart';

/// Navigation wrapper that provides responsive navigation for pages
class NavigationWrapper extends ConsumerWidget {
  const NavigationWrapper({
    super.key,
    required this.child,
    this.showNavigation = true,
  });

  final Widget child;
  final bool showNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!showNavigation) {
      return child;
    }

    return ResponsiveNavigation(
      child: child,
    );
  }
}

/// Navigation-aware scaffold that automatically handles navigation
class NavigationScaffold extends ConsumerWidget {
  const NavigationScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.showNavigation = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool showNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffold = Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );

    if (!showNavigation) {
      return scaffold;
    }

    return ResponsiveNavigation(
      child: scaffold,
    );
  }
}

/// Hook for navigation state in widgets
class NavigationHook {
  /// Get current navigation state
  static NavigationState useNavigation(WidgetRef ref) => ref.watch(navigationProvider);

  /// Get navigation notifier
  static NavigationNotifier useNavigationNotifier(WidgetRef ref) => ref.watch(navigationNotifierProvider);

  /// Navigate to route and update navigation state
  static void navigateToRoute(WidgetRef ref, String route) {
    final notifier = ref.read(navigationNotifierProvider);
    notifier.navigateToRoute(route);
  }

  /// Toggle sidebar
  static void toggleSidebar(WidgetRef ref) {
    final notifier = ref.read(navigationNotifierProvider);
    notifier.toggleSidebar();
  }

  /// Set sidebar open state
  static void setSidebarOpen(WidgetRef ref, bool isOpen) {
    final notifier = ref.read(navigationNotifierProvider);
    notifier.setSidebarOpen(isOpen);
  }
}
