import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation state for managing responsive navigation
class NavigationState {
  const NavigationState({
    this.selectedIndex = 0,
    this.isSidebarOpen = true, // Default to open (snapped) for desktop/tablet
    this.mode = NavigationMode.auto,
    this.isMobile = false,
    this.isTablet = false,
    this.isDesktop = false,
  });

  final int selectedIndex;
  final bool isSidebarOpen;
  final NavigationMode mode;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  /// Check if sidebar should be visible
  /// On desktop/tablet, sidebar is always visible (even when collapsed to show icons)
  /// On mobile, sidebar is never visible (use bottom nav instead)
  bool get shouldShowSidebar => isDesktop || isTablet;

  /// Check if bottom navigation should be visible
  bool get shouldShowBottomNav => isMobile;

  /// Get navigation mode based on screen size
  NavigationMode get effectiveMode => mode == NavigationMode.auto 
      ? (isMobile ? NavigationMode.bottomNav : NavigationMode.sidebar)
      : mode;

  /// Get current route based on selected index
  String get currentRoute {
    if (selectedIndex < NavigationConfig.items.length) {
      return NavigationConfig.items[selectedIndex].route;
    }
    return '/dashboard';
  }

  /// Check if route is active
  bool isRouteActive(String route) => currentRoute == route;

  /// Create a copy with updated values
  NavigationState copyWith({
    int? selectedIndex,
    bool? isSidebarOpen,
    NavigationMode? mode,
    bool? isMobile,
    bool? isTablet,
    bool? isDesktop,
  }) => NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isSidebarOpen: isSidebarOpen ?? this.isSidebarOpen,
      mode: mode ?? this.mode,
      isMobile: isMobile ?? this.isMobile,
      isTablet: isTablet ?? this.isTablet,
      isDesktop: isDesktop ?? this.isDesktop,
    );
}

/// Navigation modes
enum NavigationMode {
  sidebar,
  bottomNav,
  auto,
}

/// Navigation items configuration
class NavigationItem {
  const NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
    this.activeIcon,
    this.badge,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;
  final String? badge;
}

/// Navigation configuration
class NavigationConfig {
  static const List<NavigationItem> items = [
    NavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      route: '/dashboard',
    ),
    NavigationItem(
      label: 'Transaction History',
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
      route: '/bills',
    ),
    NavigationItem(
      label: 'Usage History',
      icon: Icons.show_chart_outlined,
      activeIcon: Icons.show_chart,
      route: '/usage',
    ),
    NavigationItem(
      label: 'Smart Meter Data',
      icon: Icons.electric_meter_outlined,
      activeIcon: Icons.electric_meter,
      route: '/ami-usage',
    ),
    /*
    NavigationItem(
      label: 'Daily Bill',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      route: '/daily-bill',
    ),
    */
  ];

  static const List<NavigationItem> bottomNavItems = [
    NavigationItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      route: '/dashboard',
    ),
    NavigationItem(
      label: 'Transaction History',
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
      route: '/bills',
    ),
    NavigationItem(
      label: 'Usage History',
      icon: Icons.show_chart_outlined,
      activeIcon: Icons.show_chart,
      route: '/usage',
    ),
    NavigationItem(
      label: 'Smart Meter Data',
      icon: Icons.electric_meter_outlined,
      activeIcon: Icons.electric_meter,
      route: '/ami-usage',
    ),
    /*
    NavigationItem(
      label: 'Daily Bill',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      route: '/daily-bill',
    ),
    */
  ];
}

/// Navigation notifier for managing navigation state
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState());
  
  // Track if sidebar was manually toggled to preserve state during resizes
  bool _sidebarManuallyToggled = false;

  /// Update screen size information
  /// Automatically opens sidebar for desktop/tablet (snapped behavior)
  /// Only resets sidebar state if screen size category changed
  void updateScreenSize(Size screenSize) {
    final isMobile = screenSize.width < 600;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1200;
    final isDesktop = screenSize.width >= 1200;

    // Check if screen size category changed
    final sizeCategoryChanged = 
        state.isMobile != isMobile || 
        state.isTablet != isTablet || 
        state.isDesktop != isDesktop;

    // Only auto-open/close sidebar if screen size category changed
    // If sidebar was manually toggled, preserve its state even when category changes
    final shouldOpenSidebar = isDesktop || isTablet;
    final newSidebarState = sizeCategoryChanged && !_sidebarManuallyToggled
        ? shouldOpenSidebar 
        : state.isSidebarOpen;
    
    // Reset manual toggle flag when category changes (user can toggle again)
    if (sizeCategoryChanged) {
      _sidebarManuallyToggled = false;
    }

    state = state.copyWith(
      isMobile: isMobile,
      isTablet: isTablet,
      isDesktop: isDesktop,
      isSidebarOpen: newSidebarState,
    );
  }

  /// Set navigation mode
  void setNavigationMode(NavigationMode mode) {
    state = state.copyWith(mode: mode);
  }

  /// Toggle sidebar
  /// Only allows toggling on tablet/desktop (not on mobile)
  void toggleSidebar() {
    // Don't allow closing sidebar on mobile (mobile uses bottom nav)
    if (state.isMobile) return;
    
    // Mark as manually toggled to preserve state during resizes
    _sidebarManuallyToggled = true;
    
    // On desktop/tablet, allow toggling but ensure it stays open on navigation
    state = state.copyWith(isSidebarOpen: !state.isSidebarOpen);
  }

  /// Set sidebar open state
  /// On mobile, sidebar is always closed (uses bottom nav instead)
  void setSidebarOpen(bool isOpen) {
    // Don't allow opening sidebar on mobile (mobile uses bottom nav)
    if (state.isMobile) {
      state = state.copyWith(isSidebarOpen: false);
      return;
    }
    
    state = state.copyWith(isSidebarOpen: isOpen);
  }

  /// Set selected index
  /// Preserves current sidebar state instead of forcing it open
  void setSelectedIndex(int index) {
    // Preserve current sidebar state instead of forcing it open
    state = state.copyWith(
      selectedIndex: index,
      // Don't modify isSidebarOpen - preserve user's manual toggle
    );
  }

  /// Navigate to route and update selected index
  /// Preserves current sidebar state instead of forcing it open
  void navigateToRoute(String route) {
    final index = NavigationConfig.items.indexWhere((item) => item.route == route);
    if (index != -1 && index != state.selectedIndex) {
      // Only update if the route actually changed
      // Preserve current sidebar state instead of forcing it open
      state = state.copyWith(
        selectedIndex: index,
        // Don't modify isSidebarOpen - preserve user's manual toggle
      );
    }
  }

  /// Get current route based on selected index
  String get currentRoute {
    if (state.selectedIndex < NavigationConfig.items.length) {
      return NavigationConfig.items[state.selectedIndex].route;
    }
    return '/dashboard';
  }

  /// Check if route is active
  bool isRouteActive(String route) => currentRoute == route;
}

/// Provider for navigation state
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) => NavigationNotifier());

/// Provider for navigation notifier
final navigationNotifierProvider = Provider<NavigationNotifier>((ref) => ref.watch(navigationProvider.notifier));

/// Provider for current route
final currentRouteProvider = Provider<String>((ref) {
  final navigation = ref.watch(navigationProvider);
  return navigation.currentRoute;
});

/// Provider for navigation items
final navigationItemsProvider = Provider<List<NavigationItem>>((ref) {
  final navigation = ref.watch(navigationProvider);
  return navigation.shouldShowBottomNav 
      ? NavigationConfig.bottomNavItems 
      : NavigationConfig.items;
});
