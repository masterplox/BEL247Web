import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../constants/error_messages.dart';
import '../services/connectivity_service.dart';

/// Slides in automatically when the user goes offline and slides out when
/// connectivity is restored.
///
/// Place this near the top of your layout stack, above the main content area.
/// It is already included in [ResponsiveNavigation] for all authenticated routes.
///
/// Usage (if needed outside the shell):
/// ```dart
/// Column(
///   children: [
///     const ConnectivityBanner(),
///     Expanded(child: content),
///   ],
/// )
/// ```
class ConnectivityBanner extends ConsumerStatefulWidget {
  const ConnectivityBanner({super.key});

  @override
  ConsumerState<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends ConsumerState<ConnectivityBanner> {
  /// Track whether connectivity was previously offline so we can show a
  /// "back online" confirmation before hiding the banner.
  bool _wasOffline = false;
  bool _showOnlineConfirmation = false;

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);

    // When we come back online, briefly show a success confirmation
    if (!isOnline && !_wasOffline) {
      _wasOffline = true;
    } else if (isOnline && _wasOffline) {
      _wasOffline = false;
      // Show "back online" message for 2.5 seconds
      _showOnlineConfirmation = true;
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) setState(() => _showOnlineConfirmation = false);
      });
    }

    final showBanner = !isOnline || _showOnlineConfirmation;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1,
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: showBanner
          ? (_showOnlineConfirmation
              ? _OnlineBanner(key: const ValueKey('online'))
              : _OfflineBanner(key: const ValueKey('offline')))
          : const SizedBox.shrink(key: ValueKey('hidden')),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: AppColors.grey800,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: AppColors.white, size: 16),
            const SizedBox(width: AppTheme.spacing8),
            Flexible(
              child: Text(
                ErrorMessages.offline,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}

class _OnlineBanner extends StatelessWidget {
  const _OnlineBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: AppColors.success,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi, color: AppColors.white, size: 16),
            const SizedBox(width: AppTheme.spacing8),
            Text(
              ErrorMessages.backOnline,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
}
