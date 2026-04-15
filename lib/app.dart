import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/widgets/data_preloader.dart';
import 'features/auth/providers/auth_provider.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

class BEL247App extends ConsumerWidget {
  const BEL247App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // Show a branded splash while auth initialises
    if (!authState.isInitialized) {
      return MaterialApp(
        title: 'BEL247',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const _SplashScreen(),
      );
    }

    return DataPreloader(
      child: MaterialApp.router(
        title: 'BEL247',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

/// Branded loading screen shown while [AuthNotifier] initialises on cold start.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/bel_logo.png',
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'BEL247',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 40),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
}
