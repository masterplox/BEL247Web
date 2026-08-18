import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../analytics/app_page_names.dart';
import '../providers/engagement_providers.dart';
import '../providers/meter_data_providers.dart';
import '../widgets/account_switcher.dart';
import '../widgets/app_support_dialog.dart';
import '../widgets/centered_content.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/notice_banner.dart';
import '../widgets/sidebar_nav_item.dart';
import 'navigation_providers.dart';

/// Responsive navigation widget that shows sidebar on desktop/tablet and bottom nav on mobile
class ResponsiveNavigation extends ConsumerWidget {
  const ResponsiveNavigation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(navigationProvider);
    final navigationNotifier = ref.watch(navigationNotifierProvider);

    // Update screen size and sync with current route when widget builds
    // Only update if screen size actually changed to avoid resetting manual sidebar toggle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      navigationNotifier.updateScreenSize(screenSize);

      // Sync navigation state with current route (only updates if route changed)
      final currentLocation = GoRouterState.of(context).matchedLocation;
      final items = ref.read(navigationItemsProvider);
      navigationNotifier.navigateToRoute(currentLocation, items);

      // Ensure route matches current account's meter type.
      // If user switches between AMI and non-AMI while on a usage route,
      // automatically swap between `/usage` and `/ami-usage` so the page layout updates.
      final isAmi = ref.read(isAmiMeterProvider);
      if (isAmi && currentLocation == '/usage') {
        context.go('/ami-usage');
      } else if (!isAmi && currentLocation == '/ami-usage') {
        context.go('/usage');
      }
    });

    final shell = navigation.shouldShowSidebar
        ? _SidebarLayout(
            navigation: navigation,
            navigationNotifier: navigationNotifier,
            child: child,
          )
        : _BottomNavLayout(
            navigation: navigation,
            navigationNotifier: navigationNotifier,
            child: child,
          );

    return _ShellRouteAnalytics(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          shell,
          Positioned(
            right: 16,
            bottom: navigation.shouldShowBottomNav ? 80 : 16,
            child: const _FeedbackFab(),
          ),
        ],
      ),
    );
  }
}

/// Logs Navigation device events when the shell route changes (authenticated shell only).
class _ShellRouteAnalytics extends ConsumerStatefulWidget {
  const _ShellRouteAnalytics({required this.child});

  final Widget child;

  @override
  ConsumerState<_ShellRouteAnalytics> createState() => _ShellRouteAnalyticsState();
}

class _ShellRouteAnalyticsState extends ConsumerState<_ShellRouteAnalytics> {
  String? _lastLogged;

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (!next.isAuthenticated) {
        _lastLogged = null;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final auth = ref.read(authNotifierProvider);
      if (!auth.isAuthenticated) return;
      final loc = GoRouterState.of(context).matchedLocation;
      if (loc == _lastLogged) return;
      _lastLogged = loc;
      ref.read(deviceEventsRepositoryProvider).logNavigationForLocation(loc);
    });

    return widget.child;
  }
}

class _FeedbackFab extends ConsumerWidget {
  const _FeedbackFab();

  @override
  Widget build(BuildContext context, WidgetRef ref) => FloatingActionButton.small(
        tooltip: 'Customer Portal Support',
        onPressed: () => showAppSupportDialog(context, ref),
        child: const Icon(Icons.feedback_outlined),
      );
}

/// Sidebar layout for desktop and tablet
class _SidebarLayout extends StatelessWidget {
  const _SidebarLayout({
    required this.child,
    required this.navigation,
    required this.navigationNotifier,
  });

  final Widget child;
  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(
        children: [
          const ConnectivityBanner(),
          const NoticeBanner(),
          Expanded(
            child: Row(
              children: [
                _Sidebar(
                  navigation: navigation,
                  navigationNotifier: navigationNotifier,
                ),
                Expanded(
                  child: CenteredContent(child: child),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}

/// Bottom navigation layout for mobile
class _BottomNavLayout extends StatelessWidget {
  const _BottomNavLayout({
    required this.child,
    required this.navigation,
    required this.navigationNotifier,
  });

  final Widget child;
  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(
        children: [
          const ConnectivityBanner(),
          const NoticeBanner(),
          Expanded(
            child: CenteredContent(child: child),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        navigation: navigation,
        navigationNotifier: navigationNotifier,
      ),
    );
}

/// Sidebar widget
class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.navigation,
    required this.navigationNotifier,
  });

  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context) => Container(
      width: navigation.isSidebarOpen ? 280 : 72,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      // At high zoom the logo, account switcher, and profile would otherwise
      // pin and clip the nav items with no way to scroll. Scroll the whole
      // sidebar, and pin the profile to the bottom only when height allows.
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SidebarHeader(
                      isExpanded: navigation.isSidebarOpen,
                      onToggle: navigationNotifier.toggleSidebar,
                    ),
                    AccountSwitcherCard(
                      isExpanded: navigation.isSidebarOpen,
                    ),
                    _SidebarMenu(
                      navigation: navigation,
                      navigationNotifier: navigationNotifier,
                    ),
                  ],
                ),
                _SidebarFooter(
                  isExpanded: navigation.isSidebarOpen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

/// Sidebar header with logo and toggle button
class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader({
    required this.isExpanded,
    required this.onToggle,
  });

  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    // Material 3 IconButton keeps a 48px tap target even when
    // `constraints`/`padding` are tightened, which overflows the 72px rail.
    final toggle = Tooltip(
      message: isExpanded ? 'Collapse sidebar' : 'Expand sidebar',
      child: InkWell(
        onTap: onToggle,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(
            isExpanded ? Icons.chevron_left : Icons.chevron_right,
            color: AppColors.textSecondary,
            size: 20,
          ),
        ),
      ),
    );

    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? AppTheme.spacing16 : AppTheme.spacing4,
        vertical: AppTheme.spacing8,
      ),
      child: Row(
        mainAxisAlignment:
            isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              'assets/bel_logo.png',
              width: isExpanded ? 36 : 24,
              height: isExpanded ? 36 : 24,
              fit: BoxFit.cover,
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Text(
                'BEL24-7',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            const SizedBox(width: AppTheme.spacing4),
          toggle,
        ],
      ),
    );
  }
}

/// Sidebar menu items
class _SidebarMenu extends ConsumerWidget {
  const _SidebarMenu({
    required this.navigation,
    required this.navigationNotifier,
  });

  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(navigationItemsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < items.length; index++)
          SidebarNavItem(
            label: items[index].label,
            icon: items[index].icon,
            activeIcon: items[index].activeIcon,
            badge: items[index].badge,
            isSelected: navigation.selectedIndex == index,
            isExpanded: navigation.isSidebarOpen,
            onTap: () {
              final item = items[index];
              final from = AppPageNames.navigationSubtypeForRoute(
                GoRouterState.of(context).matchedLocation,
              );
              final to = AppPageNames.navigationSubtypeForRoute(item.route);
              if (from != to) {
                ref.read(deviceEventsRepositoryProvider).logInteractionOpen(
                      destinationPageName: to,
                      sourcePageName: from,
                    );
              }
              navigationNotifier.setSelectedIndex(index);
              context.go(item.route);
            },
          ),
      ],
    );
  }
}

/// Sidebar footer
class _SidebarFooter extends ConsumerWidget {
  const _SidebarFooter({
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final userSession = authState.userSession;
    
    final userName = userSession != null 
        ? '${userSession.firstName} ${userSession.lastName}'
        : 'John Doe';
    final userEmail = userSession?.email ?? 'asdf@fasd';

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: isExpanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: AppColors.white, size: 16),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            userEmail,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton.icon(
                      onPressed: () => context.go('/account/reset-password'),
                      icon: const Icon(Icons.lock_reset, size: 14),
                      label: const Text('Change password', style: TextStyle(fontSize: 11)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing8,
                          vertical: AppTheme.spacing4,
                        ),
                        minimumSize: const Size(0, 28),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await ref.read(authNotifierProvider.notifier).logout();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                      icon: const Icon(Icons.logout, size: 14, color: AppColors.error),
                      label: Text(
                        'Sign Out',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error, width: 1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing8,
                          vertical: AppTheme.spacing4,
                        ),
                        minimumSize: const Size(0, 28),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                IconButton(
                  onPressed: () async {
                    await ref.read(authNotifierProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: AppColors.error,
                    size: 20,
                  ),
                  tooltip: 'Sign Out',
                ),
              ],
            ),
    );
  }
}

/// Bottom navigation bar
class _BottomNavigationBar extends ConsumerWidget {
  const _BottomNavigationBar({
    required this.navigation,
    required this.navigationNotifier,
  });

  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(navigationItemsProvider);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = navigation.selectedIndex == index;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      final from = AppPageNames.navigationSubtypeForRoute(
                        GoRouterState.of(context).matchedLocation,
                      );
                      final to = AppPageNames.navigationSubtypeForRoute(item.route);
                      if (from != to) {
                        ref.read(deviceEventsRepositoryProvider).logInteractionOpen(
                              destinationPageName: to,
                              sourcePageName: from,
                            );
                      }
                      navigationNotifier.setSelectedIndex(index);
                      context.go(item.route);
                    },
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                size: 24,
                              ),
                              if (item.badge != null)
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Text(
                                      item.badge!,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // const SizedBox(height: AppTheme.spacing4),
                          // Only show label when this item is selected to avoid overflow on mobile
                          // if (isSelected)
                          //   Text(
                          //     item.label,
                          //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          //           color: AppColors.primary,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     textAlign: TextAlign.center,
                          //   ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
