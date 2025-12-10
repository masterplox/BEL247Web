import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_page.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/forgot_password/forgot_password_page.dart';
import '../../features/auth/forgot_password/reset_password_page.dart';
import '../../features/auth/signup/signup_contact_page.dart';
import '../../features/auth/signup/signup_credentials_page.dart';
import '../../features/auth/signup/signup_success_page.dart';
import '../../features/auth/signup/signup_verify_otp_page.dart';
import '../../features/bills/bills_page.dart';
import '../../features/daily_bill/pages/daily_bill_page.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/usage/usage_page.dart';
import '../navigation/responsive_navigation.dart';
import '../services/url_encryption_service.dart';
import '../utils/logger.dart';

/// Router configuration with encrypted URL parameters
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    
    // Global redirect function for authentication
    redirect: (context, state) {
      // Get the auth state from Riverpod
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authNotifierProvider);
      
      final isLoggedIn = authState.isAuthenticated;
      final isInitialized = authState.isInitialized;
      final isPublicRoute = state.matchedLocation == '/login' 
          || state.matchedLocation.startsWith('/signup')
          || state.matchedLocation == '/forgot-password'
          || state.matchedLocation == '/reset-password';
      
      Logger.debug('Router redirect check - isInitialized: $isInitialized, isLoggedIn: $isLoggedIn, isPublicRoute: $isPublicRoute');
      
      // Don't redirect if auth is not initialized yet
      if (!isInitialized) {
        Logger.debug('Auth not initialized, staying on current route');
        return null;
      }
      
      // If user is not logged in and not on a public page, redirect to login
      if (!isLoggedIn && !isPublicRoute) {
        Logger.debug('User not authenticated, redirecting to login');
        return '/login';
      }
      
      // If user is logged in and on a public page, redirect to dashboard
      if (isLoggedIn && isPublicRoute) {
        Logger.debug('User already authenticated, redirecting to dashboard');
        return '/dashboard';
      }
      
      // No redirect needed
      Logger.debug('No redirect needed');
      return null;
    },
    
    routes: [
      // Public routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) {
          final contact = state.uri.queryParameters['contact'];
          return ResetPasswordPage(contact: contact);
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupContactPage(),
        routes: [
          GoRoute(
            path: 'verify',
            name: 'signup-verify',
            builder: (context, state) => const SignupVerifyOtpPage(),
          ),
          GoRoute(
            path: 'credentials',
            name: 'signup-credentials',
            builder: (context, state) => const SignupCredentialsPage(),
          ),
          GoRoute(
            path: 'success',
            name: 'signup-success',
            builder: (context, state) {
              final args = state.extra as Map<String, String>?;
              if (args == null || !args.containsKey('email') || !args.containsKey('password')) {
                // Handle error case, maybe redirect to login
                return const Scaffold(
                  body: Center(
                    child: Text('Error: Missing credentials.'),
                  ),
                );
              }
              return SignupSuccessPage(
                email: args['email']!,
                password: args['password']!,
              );
            },
          ),
        ],
      ),
      
      // Protected routes (wrapped with a shell route for persistent navigation)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ResponsiveNavigation(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/bills',
            name: 'bills',
            builder: (context, state) => const BillsPage(),
          ),
          GoRoute(
            path: '/bills/:billId',
            name: 'bill-detail',
            builder: (context, state) {
              final billId = state.pathParameters['billId'];
              final encryptedParams = UrlEncryptionService.instance.extractEncryptedParams(state);
              
              Logger.debug('Navigating to bill detail: $billId');
              Logger.debug('Encrypted params: $encryptedParams');
              
              return const BillsPage();
            },
          ),
          GoRoute(
            path: '/usage',
            name: 'usage',
            builder: (context, state) => const UsagePage(),
          ),
          GoRoute(
            path: '/usage/:period',
            name: 'usage-period',
            builder: (context, state) {
              final period = state.pathParameters['period'];
              final encryptedParams = UrlEncryptionService.instance.extractEncryptedParams(state);
              
              Logger.debug('Navigating to usage period: $period');
              Logger.debug('Encrypted params: $encryptedParams');
              
              return const UsagePage();
            },
          ),
          GoRoute(
            path: '/daily-bill/:date',
            name: 'daily-bill-date',
            builder: (context, state) {
              final date = state.pathParameters['date'];
              final encryptedParams = UrlEncryptionService.instance.extractEncryptedParams(state);
              
              Logger.debug('Navigating to daily bill for date: $date');
              Logger.debug('Encrypted params: $encryptedParams');
              
              return const DailyBillPage();
            },
          ),
        ],
      ),
      
      // Redirect routes for encrypted navigation
      GoRoute(
        path: '/secure/:route',
        name: 'secure-route',
        builder: (context, state) {
          final route = state.pathParameters['route'];
          final encryptedParams = UrlEncryptionService.instance.extractEncryptedParams(state);
          
          Logger.debug('Secure route: $route');
          Logger.debug('Encrypted params: $encryptedParams');
          
          // This part of the logic might need to be re-evaluated with ShellRoute
          // For now, returning the pages directly.
          switch (route) {
            case 'dashboard':
              return const DashboardPage();
            case 'bills':
              return const BillsPage();
            case 'usage':
              return const UsagePage();
            case 'daily-bill':
              return const DailyBillPage();
            default:
              return const DashboardPage();
          }
        },
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );

  /// Get the router instance
  static GoRouter get router => _router;
}

/// Router service for encrypted navigation
class RouterService {
  factory RouterService() => _instance;
  RouterService._internal();
  static final RouterService _instance = RouterService._internal();

  final UrlEncryptionService _urlEncryptionService = UrlEncryptionService.instance;

  /// Navigate to dashboard with encrypted user data
  void goToDashboard(BuildContext context, {String? userId, String? userRole}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (userRole != null) params['userRole'] = userRole;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/dashboard', params);
      } else {
        context.go('/dashboard');
      }
    } catch (e) {
      Logger.error('Failed to navigate to dashboard: $e');
      context.go('/dashboard');
    }
  }

  /// Navigate to bills with encrypted parameters
  void goToBills(BuildContext context, {String? userId, String? filter}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (filter != null) params['filter'] = filter;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/bills', params);
      } else {
        context.go('/bills');
      }
    } catch (e) {
      Logger.error('Failed to navigate to bills: $e');
      context.go('/bills');
    }
  }

  /// Navigate to specific bill with encrypted parameters
  void goToBillDetail(BuildContext context, String billId, {String? userId, String? returnTo}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (returnTo != null) params['returnTo'] = returnTo;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/bills/$billId', params);
      } else {
        context.go('/bills/$billId');
      }
    } catch (e) {
      Logger.error('Failed to navigate to bill detail: $e');
      context.go('/bills/$billId');
    }
  }

  /// Navigate to usage with encrypted parameters
  void goToUsage(BuildContext context, {String? userId, String? period}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (period != null) params['period'] = period;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/usage', params);
      } else {
        context.go('/usage');
      }
    } catch (e) {
      Logger.error('Failed to navigate to usage: $e');
      context.go('/usage');
    }
  }

  /// Navigate to usage period with encrypted parameters
  void goToUsagePeriod(BuildContext context, String period, {String? userId, String? year}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (year != null) params['year'] = year;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/usage/$period', params);
      } else {
        context.go('/usage/$period');
      }
    } catch (e) {
      Logger.error('Failed to navigate to usage period: $e');
      context.go('/usage/$period');
    }
  }

  /// Navigate to daily bill with encrypted parameters
  void goToDailyBill(BuildContext context, {String? userId, String? date}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (date != null) params['date'] = date;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/daily-bill', params);
      } else {
        context.go('/daily-bill');
      }
    } catch (e) {
      Logger.error('Failed to navigate to daily bill: $e');
      context.go('/daily-bill');
    }
  }

  /// Navigate to daily bill for specific date with encrypted parameters
  void goToDailyBillDate(BuildContext context, String date, {String? userId, String? returnTo}) {
    try {
      final params = <String, String>{};
      if (userId != null) params['userId'] = userId;
      if (returnTo != null) params['returnTo'] = returnTo;
      
      if (params.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams('/daily-bill/$date', params);
      } else {
        context.go('/daily-bill/$date');
      }
    } catch (e) {
      Logger.error('Failed to navigate to daily bill date: $e');
      context.go('/daily-bill/$date');
    }
  }

  /// Navigate to secure route with encrypted parameters
  void goToSecureRoute(BuildContext context, String route, Map<String, String> params) {
    try {
      AppRouter.router.goWithEncryptedParams('/secure/$route', params);
    } catch (e) {
      Logger.error('Failed to navigate to secure route: $e');
      context.go('/dashboard');
    }
  }

  /// Get current encrypted parameters from router state
  Map<String, String> getCurrentEncryptedParams(BuildContext context) {
    try {
      final state = GoRouterState.of(context);
      return _urlEncryptionService.extractEncryptedParams(state);
    } catch (e) {
      Logger.error('Failed to get current encrypted parameters: $e');
      return {};
    }
  }

  /// Check if current route has encrypted parameters
  bool hasEncryptedParams(BuildContext context) {
    try {
      final state = GoRouterState.of(context);
      return _urlEncryptionService.hasEncryptedParams(state.uri.toString());
    } catch (e) {
      Logger.error('Failed to check encrypted parameters: $e');
      return false;
    }
  }
}

/// Provider for RouterService
final routerServiceProvider = Provider<RouterService>((ref) => RouterService());

/// Extension for easy encrypted navigation
extension EncryptedNavigationExtension on BuildContext {
  /// Navigate to dashboard with encrypted parameters
  void goToDashboardEncrypted({String? userId, String? userRole}) {
    RouterService().goToDashboard(this, userId: userId, userRole: userRole);
  }

  /// Navigate to bills with encrypted parameters
  void goToBillsEncrypted({String? userId, String? filter}) {
    RouterService().goToBills(this, userId: userId, filter: filter);
  }

  /// Navigate to bill detail with encrypted parameters
  void goToBillDetailEncrypted(String billId, {String? userId, String? returnTo}) {
    RouterService().goToBillDetail(this, billId, userId: userId, returnTo: returnTo);
  }

  /// Navigate to usage with encrypted parameters
  void goToUsageEncrypted({String? userId, String? period}) {
    RouterService().goToUsage(this, userId: userId, period: period);
  }

  /// Navigate to usage period with encrypted parameters
  void goToUsagePeriodEncrypted(String period, {String? userId, String? year}) {
    RouterService().goToUsagePeriod(this, period, userId: userId, year: year);
  }

  /// Navigate to daily bill with encrypted parameters
  void goToDailyBillEncrypted({String? userId, String? date}) {
    RouterService().goToDailyBill(this, userId: userId, date: date);
  }

  /// Navigate to daily bill for specific date with encrypted parameters
  void goToDailyBillDateEncrypted(String date, {String? userId, String? returnTo}) {
    RouterService().goToDailyBillDate(this, date, userId: userId, returnTo: returnTo);
  }

  /// Get current encrypted parameters
  Map<String, String> getEncryptedParams() => RouterService().getCurrentEncryptedParams(this);

  /// Check if current route has encrypted parameters
  bool hasEncryptedParams() => RouterService().hasEncryptedParams(this);
}
