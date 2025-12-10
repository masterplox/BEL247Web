import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/logger.dart';
import '../login_page.dart';
import '../providers/auth_provider.dart';

/// Authentication guard widget that redirects unauthenticated users to login
class AuthGuard extends ConsumerWidget {

  const AuthGuard({
    super.key,
    required this.child,
    this.redirectTo,
  });
  final Widget child;
  final String? redirectTo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // Show loading screen while auth is initializing
    if (!authState.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Redirect to login if not authenticated
    if (!authState.isAuthenticated) {
      Logger.info('User not authenticated, redirecting to login');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
      });
      
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // User is authenticated, show the protected content
    return child;
  }
}

/// Route guard for go_router that checks authentication
class RouteAuthGuard {
  /// Check if user is authenticated and return redirect path if not
  static String? checkAuth(WidgetRef ref, String currentPath) {
    final authState = ref.read(authNotifierProvider);
    
    // If not initialized, don't redirect yet
    if (!authState.isInitialized) {
      return null;
    }
    
    // If not authenticated, redirect to login
    if (!authState.isAuthenticated) {
      Logger.info('Route guard: User not authenticated, redirecting to login');
      return '/login';
    }
    
    return null;
  }
  
  /// Check if user is already authenticated and redirect to dashboard
  static String? checkAlreadyAuthenticated(WidgetRef ref, String currentPath) {
    final authState = ref.read(authNotifierProvider);
    
    // If not initialized, don't redirect yet
    if (!authState.isInitialized) {
      return null;
    }
    
    // If already authenticated and trying to access login, redirect to dashboard
    if (authState.isAuthenticated && currentPath == '/login') {
      Logger.info('Route guard: User already authenticated, redirecting to dashboard');
      return '/dashboard';
    }
    
    return null;
  }
}

/// Higher-order function to wrap routes with authentication guard
Widget Function(BuildContext, GoRouterState) authGuardWrapper(
  Widget Function(BuildContext, GoRouterState) builder,
) => (BuildContext context, GoRouterState state) => Consumer(
      builder: (context, ref, child) => AuthGuard(
          child: builder(context, state),
        ),
    );

/// Authentication middleware for checking auth state
class AuthMiddleware {
  /// Initialize authentication state
  static Future<void> initializeAuth(WidgetRef ref) async {
    try {
      Logger.info('Initializing authentication middleware');
      // The AuthNotifier will automatically initialize
      // This is just a placeholder for any additional initialization
    } catch (e, stackTrace) {
      Logger.error('Auth middleware initialization error', error: e, stackTrace: stackTrace);
    }
  }
  
  /// Check if current route requires authentication
  static bool requiresAuth(String path) {
    const protectedRoutes = [
      '/dashboard',
      '/bills',
      '/consumption',
      '/daily-bill',
      '/profile',
      '/settings',
    ];
    
    return protectedRoutes.any((route) => path.startsWith(route));
  }
  
  /// Get redirect path based on authentication state
  static String? getRedirectPath(WidgetRef ref, String currentPath) {
    final authState = ref.read(authNotifierProvider);
    
    if (!authState.isInitialized) {
      return null;
    }
    
    if (requiresAuth(currentPath) && !authState.isAuthenticated) {
      return '/login';
    }
    
    if (currentPath == '/login' && authState.isAuthenticated) {
      return '/dashboard';
    }
    
    return null;
  }
}

/// Authentication status widget for debugging
class AuthStatusWidget extends ConsumerWidget {
  const AuthStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Auth Status',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Initialized: ${authState.isInitialized}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            'Authenticated: ${authState.isAuthenticated}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            'Loading: ${authState.isLoading}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          if (authState.userSession != null)
            Text(
              'User: ${authState.userSession!.email}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          if (authState.error != null)
            Text(
              'Error: ${authState.error}',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
