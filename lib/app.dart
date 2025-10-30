import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'features/auth/providers/auth_provider.dart';
import 'theme/app_theme.dart';

class BEL247App extends ConsumerWidget {
  const BEL247App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    // Debug: Show auth state in console
    print('BEL247App build - isInitialized: ${authState.isInitialized}, isAuthenticated: ${authState.isAuthenticated}, isLoading: ${authState.isLoading}');
    
    // Show loading screen while auth is initializing
    if (!authState.isInitialized) {
      return MaterialApp(
        title: 'BEL247 WebApp',
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text('Initializing...'),
                const SizedBox(height: 8),
                Text('isInitialized: ${authState.isInitialized}'),
                Text('isAuthenticated: ${authState.isAuthenticated}'),
                Text('isLoading: ${authState.isLoading}'),
              ],
            ),
          ),
        ),
      );
    }
    
    return MaterialApp.router(
      title: 'BEL247 WebApp',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
