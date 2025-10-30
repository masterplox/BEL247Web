import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../navigation/navigation_providers.dart';
import '../router/app_router.dart';
import '../utils/logger.dart';
import 'url_encryption_service.dart';

/// Service for handling deep linking and URL sharing
class DeepLinkingService {
  factory DeepLinkingService() => _instance;
  DeepLinkingService._internal();
  static final DeepLinkingService _instance = DeepLinkingService._internal();

  final UrlEncryptionService _urlEncryptionService = UrlEncryptionService.instance;

  /// Handle incoming deep link
  Future<void> handleDeepLink(String url, WidgetRef ref) async {
    try {
      Logger.info('Handling deep link: $url');
      
      final uri = Uri.parse(url);
      final path = uri.path;
      final queryParams = uri.queryParameters;
      
      // Extract encrypted parameters if present
      final encryptedParams = _urlEncryptionService.parseEncryptedUrl(url);
      
      // Merge regular and encrypted parameters
      final allParams = {...queryParams, ...encryptedParams};
      
      // Update navigation state if needed
      final navigationNotifier = ref.read(navigationNotifierProvider);
      navigationNotifier.navigateToRoute(path);
      
      // Navigate to the route
      if (allParams.isNotEmpty) {
        AppRouter.router.goWithEncryptedParams(path, allParams);
      } else {
        AppRouter.router.go(path);
      }
      
      Logger.info('Deep link handled successfully');
    } catch (e) {
      Logger.error('Failed to handle deep link: $e');
      // Fallback to dashboard
      AppRouter.router.go('/dashboard');
    }
  }

  /// Create a shareable deep link
  String createShareableLink(String route, {Map<String, String>? params}) {
    try {
      final baseUrl = _getBaseUrl();
      final fullUrl = '$baseUrl$route';
      
      if (params != null && params.isNotEmpty) {
        return _urlEncryptionService.createEncryptedUrl(fullUrl, params);
      }
      
      return fullUrl;
    } catch (e) {
      Logger.error('Failed to create shareable link: $e');
      return _getBaseUrl();
    }
  }

  /// Create a shareable link for current route
  String createCurrentRouteLink(BuildContext context, {Map<String, String>? additionalParams}) {
    try {
      final currentLocation = GoRouterState.of(context).matchedLocation;
      final currentParams = GoRouterState.of(context).uri.queryParameters;
      
      // Merge current params with additional params
      final allParams = {...currentParams, ...?additionalParams};
      
      return createShareableLink(currentLocation, params: allParams);
    } catch (e) {
      Logger.error('Failed to create current route link: $e');
      return _getBaseUrl();
    }
  }

  /// Share current route
  Future<void> shareCurrentRoute(BuildContext context, {Map<String, String>? additionalParams}) async {
    try {
      final link = createCurrentRouteLink(context, additionalParams: additionalParams);
      
      // TODO: Implement actual sharing using share_plus package
      Logger.info('Sharing link: $link');
      
      // For now, just copy to clipboard
      await _copyToClipboard(context, link);
    } catch (e) {
      Logger.error('Failed to share current route: $e');
    }
  }

  /// Parse route parameters from URL
  Map<String, String> parseRouteParams(String url) {
    try {
      final uri = Uri.parse(url);
      final queryParams = uri.queryParameters;
      
      // Extract encrypted parameters
      final encryptedParams = _urlEncryptionService.parseEncryptedUrl(url);
      
      return {...queryParams, ...encryptedParams};
    } catch (e) {
      Logger.error('Failed to parse route params: $e');
      return {};
    }
  }

  /// Validate deep link URL
  bool isValidDeepLink(String url) {
    try {
      final uri = Uri.parse(url);
      final path = uri.path;
      
      // Check if path is a valid route
      return _isValidRoute(path);
    } catch (e) {
      Logger.error('Failed to validate deep link: $e');
      return false;
    }
  }

  /// Check if route is valid
  bool _isValidRoute(String path) {
    const validRoutes = [
      '/dashboard',
      '/bills',
      '/usage',
      '/daily-bill',
      '/login',
    ];
    
    // Check exact matches
    if (validRoutes.contains(path)) return true;
    
    // Check parameterized routes
    if (path.startsWith('/bills/')) return true;
    if (path.startsWith('/usage/')) return true;
    if (path.startsWith('/daily-bill/')) return true;
    if (path.startsWith('/secure/')) return true;
    
    return false;
  }

  /// Get base URL for the application
  String _getBaseUrl() {
    // TODO: Get actual base URL from configuration
    return 'https://bel247.com';
  }

  /// Copy text to clipboard
  Future<void> _copyToClipboard(BuildContext context, String text) async {
    try {
      // TODO: Implement actual clipboard functionality
      Logger.info('Copied to clipboard: $text');
      
      // Show snackbar to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Link copied to clipboard'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      Logger.error('Failed to copy to clipboard: $e');
    }
  }
}

/// Deep linking provider
final deepLinkingServiceProvider = Provider<DeepLinkingService>((ref) => DeepLinkingService());

/// Deep link handler widget
class DeepLinkHandler extends ConsumerWidget {
  const DeepLinkHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => child;

  /// Handle deep link from external source
  static Future<void> handleExternalDeepLink(String url, WidgetRef ref) async {
    final deepLinkingService = ref.read(deepLinkingServiceProvider);
    await deepLinkingService.handleDeepLink(url, ref);
  }
}

/// Deep link utilities
class DeepLinkUtils {
  /// Create a deep link for sharing bill details
  static String createBillShareLink(String billId, {String? userId}) {
    final params = <String, String>{};
    if (userId != null) params['userId'] = userId;
    
    return DeepLinkingService().createShareableLink('/bills/$billId', params: params);
  }

  /// Create a deep link for sharing usage data
  static String createUsageShareLink(String period, {String? userId, String? year}) {
    final params = <String, String>{};
    if (userId != null) params['userId'] = userId;
    if (year != null) params['year'] = year;
    
    return DeepLinkingService().createShareableLink('/usage/$period', params: params);
  }

  /// Create a deep link for sharing daily bill
  static String createDailyBillShareLink(String date, {String? userId}) {
    final params = <String, String>{};
    if (userId != null) params['userId'] = userId;
    
    return DeepLinkingService().createShareableLink('/daily-bill/$date', params: params);
  }

  /// Create a deep link for dashboard
  static String createDashboardLink({String? userId, String? userRole}) {
    final params = <String, String>{};
    if (userId != null) params['userId'] = userId;
    if (userRole != null) params['userRole'] = userRole;
    
    return DeepLinkingService().createShareableLink('/dashboard', params: params);
  }
}

/// Extension for easy deep linking
extension DeepLinkingExtension on BuildContext {
  /// Share current route
  Future<void> shareCurrentRoute({Map<String, String>? additionalParams}) async {
    final deepLinkingService = ProviderScope.containerOf(this).read(deepLinkingServiceProvider);
    await deepLinkingService.shareCurrentRoute(this, additionalParams: additionalParams);
  }

  /// Create shareable link for current route
  String createShareableLink({Map<String, String>? additionalParams}) {
    final deepLinkingService = ProviderScope.containerOf(this).read(deepLinkingServiceProvider);
    return deepLinkingService.createCurrentRouteLink(this, additionalParams: additionalParams);
  }
}
