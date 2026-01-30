import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../widgets/account_switcher.dart';
import '../widgets/centered_content.dart';
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
      navigationNotifier.navigateToRoute(currentLocation);
    });

    if (navigation.shouldShowSidebar) {
      return _SidebarLayout(
        navigation: navigation,
        navigationNotifier: navigationNotifier,
        child: child,
      );
    } else {
      // Fallback for smaller screens (mobile)
      return _BottomNavLayout(
        navigation: navigation,
        navigationNotifier: navigationNotifier,
        child: child,
      );
    }
  }
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
      child: Column(
        children: [
          _SidebarHeader(
            isExpanded: navigation.isSidebarOpen,
            onToggle: navigationNotifier.toggleSidebar,
          ),
          AccountSwitcherCard(
            isExpanded: navigation.isSidebarOpen,
          ),
          Expanded(
            child: _SidebarMenu(
              navigation: navigation,
              navigationNotifier: navigationNotifier,
            ),
          ),
          _SidebarFooter(
            isExpanded: navigation.isSidebarOpen,
          ),
        ],
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
  Widget build(BuildContext context) => Container(
      height: 64,
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? AppTheme.spacing16 : AppTheme.spacing4,
        vertical: AppTheme.spacing8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flash_on,
            color: AppColors.primary,
            size: isExpanded ? 32 : 20,
          ),
          if (isExpanded) ...[
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Text(
                'BEL247',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            const SizedBox(width: AppTheme.spacing4),
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              isExpanded ? Icons.chevron_left : Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
            tooltip: isExpanded ? 'Collapse sidebar' : 'Expand sidebar',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
          ),
        ],
      ),
    );
}

/// Sidebar menu items
class _SidebarMenu extends StatelessWidget {
  const _SidebarMenu({
    required this.navigation,
    required this.navigationNotifier,
  });

  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context) => ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      itemCount: NavigationConfig.items.length,
      itemBuilder: (context, index) {
        final item = NavigationConfig.items[index];
        final isSelected = navigation.selectedIndex == index;

        return SidebarNavItem(
          label: item.label,
          icon: item.icon,
          activeIcon: item.activeIcon,
          badge: item.badge,
          isSelected: isSelected,
          isExpanded: navigation.isSidebarOpen,
          onTap: () {
            navigationNotifier.setSelectedIndex(index);
            context.go(item.route);
          },
        );
      },
    );
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
      padding: const EdgeInsets.all(AppTheme.spacing16),
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
              children: [
                Text(
                  'Signed in as',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  userEmail,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing12),
                OutlinedButton.icon(
                  onPressed: () async {
                    await ref.read(authNotifierProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.error,
                  ),
                  label: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error, width: 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                      vertical: AppTheme.spacing8,
                    ),
                    minimumSize: const Size(double.infinity, 36),
                  ),
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
class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.navigation,
    required this.navigationNotifier,
  });

  final NavigationState navigation;
  final NavigationNotifier navigationNotifier;

  @override
  Widget build(BuildContext context) => DecoratedBox(
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
            children: NavigationConfig.bottomNavItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = navigation.selectedIndex == index;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
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
