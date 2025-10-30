import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../../data/services/token_storage_service.dart';
import '../providers/auth_provider.dart';

/// Session manager for handling automatic token refresh and session management
class SessionManager {
  static Timer? _refreshTimer;
  static Timer? _activityTimer;
  static DateTime? _lastActivity;
  
  // Session timeout duration (30 minutes of inactivity)
  static const Duration _sessionTimeout = Duration(minutes: 30);
  
  // Token refresh interval (check every 5 minutes)
  static const Duration _refreshInterval = Duration(minutes: 5);
  
  /// Initialize session management
  static void initialize(WidgetRef ref) {
    Logger.info('Initializing session manager');
    _startRefreshTimer(ref);
    _startActivityTimer(ref);
  }
  
  /// Start automatic token refresh timer
  static void _startRefreshTimer(WidgetRef ref) {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshInterval, (timer) {
      _checkAndRefreshToken(ref);
    });
    Logger.info('Token refresh timer started');
  }
  
  /// Start activity monitoring timer
  static void _startActivityTimer(WidgetRef ref) {
    _activityTimer?.cancel();
    _activityTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkSessionTimeout(ref);
    });
    Logger.info('Activity monitoring timer started');
  }
  
  /// Update last activity timestamp
  static void updateActivity() {
    _lastActivity = DateTime.now();
    Logger.debug('Activity updated: $_lastActivity');
  }
  
  /// Check and refresh token if needed
  static Future<void> _checkAndRefreshToken(WidgetRef ref) async {
    try {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      
      // Only refresh if user is authenticated
      if (!authNotifier.isAuthenticated) {
        return;
      }
      
      // Check if access token is expired or will expire soon (within 2 minutes)
      final isExpired = await TokenStorageService.isAccessTokenExpired();
      if (isExpired) {
        Logger.info('Access token expired, attempting refresh');
        await authNotifier.refreshToken();
      } else {
        // Check if token will expire soon
        final tokenPair = await TokenStorageService.getTokenPair();
        if (tokenPair != null) {
          final timeUntilExpiry = tokenPair.accessTokenExpiresAt.difference(DateTime.now());
          if (timeUntilExpiry.inMinutes <= 2) {
            Logger.info('Access token expires soon, refreshing proactively');
            await authNotifier.refreshToken();
          }
        }
      }
    } catch (e, stackTrace) {
      Logger.error('Token refresh check error', error: e, stackTrace: stackTrace);
    }
  }
  
  /// Check for session timeout due to inactivity
  static Future<void> _checkSessionTimeout(WidgetRef ref) async {
    try {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      
      // Only check if user is authenticated
      if (!authNotifier.isAuthenticated) {
        return;
      }
      
      // If no activity recorded, use last refresh time
      if (_lastActivity == null) {
        final lastRefresh = await TokenStorageService.getLastRefresh();
        _lastActivity = lastRefresh;
      }
      
      if (_lastActivity != null) {
        final timeSinceActivity = DateTime.now().difference(_lastActivity!);
        if (timeSinceActivity > _sessionTimeout) {
          Logger.info('Session timeout due to inactivity, logging out');
          await authNotifier.logout();
        }
      }
    } catch (e, stackTrace) {
      Logger.error('Session timeout check error', error: e, stackTrace: stackTrace);
    }
  }
  
  /// Force refresh token
  static Future<void> forceRefresh(WidgetRef ref) async {
    try {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      Logger.info('Force refreshing token');
      await authNotifier.refreshToken();
    } catch (e, stackTrace) {
      Logger.error('Force refresh error', error: e, stackTrace: stackTrace);
    }
  }
  
  /// Extend session by updating activity
  static void extendSession() {
    updateActivity();
    Logger.info('Session extended due to user activity');
  }
  
  /// Clear session and stop timers
  static void clearSession() {
    _refreshTimer?.cancel();
    _activityTimer?.cancel();
    _lastActivity = null;
    Logger.info('Session cleared and timers stopped');
  }
  
  /// Get session status
  static Future<SessionStatus> getSessionStatus() async {
    try {
      final hasCredentials = await TokenStorageService.hasValidCredentials();
      if (!hasCredentials) {
        return SessionStatus.noCredentials;
      }
      
      final isAccessExpired = await TokenStorageService.isAccessTokenExpired();
      if (isAccessExpired) {
        return SessionStatus.accessTokenExpired;
      }
      
      final isRefreshExpired = await TokenStorageService.isRefreshTokenExpired();
      if (isRefreshExpired) {
        return SessionStatus.refreshTokenExpired;
      }
      
      // Check for inactivity timeout
      if (_lastActivity != null) {
        final timeSinceActivity = DateTime.now().difference(_lastActivity!);
        if (timeSinceActivity > _sessionTimeout) {
          return SessionStatus.sessionTimeout;
        }
      }
      
      return SessionStatus.valid;
    } catch (e, stackTrace) {
      Logger.error('Session status check error', error: e, stackTrace: stackTrace);
      return SessionStatus.error;
    }
  }
  
  /// Dispose of timers and resources
  static void dispose() {
    _refreshTimer?.cancel();
    _activityTimer?.cancel();
    Logger.info('Session manager disposed');
  }
}

/// Session status enumeration
enum SessionStatus {
  valid,
  noCredentials,
  accessTokenExpired,
  refreshTokenExpired,
  sessionTimeout,
  error,
}

/// Session manager provider
final sessionManagerProvider = Provider<SessionManager>((ref) => SessionManager());

/// Session status provider
final sessionStatusProvider = FutureProvider<SessionStatus>((ref) => SessionManager.getSessionStatus());

/// Activity tracker widget that updates session activity
class ActivityTracker extends StatefulWidget {
  
  const ActivityTracker({
    super.key,
    required this.child,
  });
  final Widget child;
  
  @override
  State<ActivityTracker> createState() => _ActivityTrackerState();
}

class _ActivityTrackerState extends State<ActivityTracker> {
  @override
  void initState() {
    super.initState();
    _setupActivityTracking();
  }
  
  void _setupActivityTracking() {
    // Track various user interactions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will be called after the widget is built
      SessionManager.updateActivity();
    });
  }
  
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: SessionManager.extendSession,
      onPanStart: (_) {
        SessionManager.extendSession();
      },
      onScaleStart: (_) {
        SessionManager.extendSession();
      },
      child: widget.child,
    );
}

/// Session timeout warning dialog
class SessionTimeoutDialog extends StatelessWidget {
  
  const SessionTimeoutDialog({
    super.key,
    required this.onExtend,
    required this.onLogout,
    required this.remainingSeconds,
  });
  final VoidCallback onExtend;
  final VoidCallback onLogout;
  final int remainingSeconds;
  
  @override
  Widget build(BuildContext context) => AlertDialog(
      title: const Text('Session Timeout Warning'),
      content: Text(
        'Your session will expire in $remainingSeconds seconds due to inactivity. '
        'Would you like to extend your session?',
      ),
      actions: [
        TextButton(
          onPressed: onLogout,
          child: const Text('Logout'),
        ),
        ElevatedButton(
          onPressed: onExtend,
          child: const Text('Extend Session'),
        ),
      ],
    );
}
