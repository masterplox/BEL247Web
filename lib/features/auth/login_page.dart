import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/logger.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_error_state.dart';
import '../../core/widgets/app_text.dart';
import '../../data/models/auth.dart';
import '../../theme/colors.dart';
import 'providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  initState() {
    super.initState();
    _usernameController.text = '';
    _passwordController.text = '';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.info('LoginPage build() called');
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    Logger.info('Auth state - isInitialized: ${authState.isInitialized}, isAuthenticated: ${authState.isAuthenticated}, isLoading: ${authState.isLoading}');

    // Debug: Show auth state in UI
    if (!authState.isInitialized) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const AppText('Initializing authentication...'),
              const SizedBox(height: 8),
              AppText('isInitialized: ${authState.isInitialized}'),
              AppText('isAuthenticated: ${authState.isAuthenticated}'),
              AppText('isLoading: ${authState.isLoading}'),
            ],
          ),
        ),
      );
    }

    // Listen for authentication state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.isAuthenticated && !(previous?.isAuthenticated ?? false)) {
        Logger.info('User authenticated, navigating to dashboard');
        // Defer navigation to prevent rebuild loops
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go('/dashboard');
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo and Title
                  _buildHeader(),
                  const SizedBox(height: 48),
                  
                  // Login Form
                  _buildLoginForm(authNotifier, authState),
                  
                  const SizedBox(height: 24),
                  
                  // Error Display
                  if (authState.error != null) _buildErrorDisplay(authState.error!),
                  
                  const SizedBox(height: 24),
                  
                  // Additional Options
                  _buildAdditionalOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
      children: [
        // BEL247 Logo placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.flash_on,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        const AppText(
          'BEL247',
          style: AppTextStyle.title,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        const SizedBox(height: 8),
        const AppText(
          'Energy Management Portal',
          style: AppTextStyle.body,
          color: AppColors.textSecondary,
        ),
      ],
    );

  Widget _buildLoginForm(AuthNotifier authNotifier, AuthState authState) => AppCard(
      elevation: 8,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText(
              'Sign In',
              style: AppTextStyle.title,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Username Field
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleLogin(),
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Remember Me Checkbox
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
                const AppText('Remember me'),
              ],
            ),
            const SizedBox(height: 24),
            
            // Login Button
            AppButton(
              onPressed: _handleLogin,
              text: 'Sign In',
              isLoading: authState.isLoading,
            ),
          ],
        ),
      ),
    );

  Widget _buildErrorDisplay(String error) => AppErrorState(
        message: error,
        icon: Icons.error_outline,
        onRetry: () {
          ref.read(authNotifierProvider.notifier).clearError();
        },
        padding: const EdgeInsets.all(16),
      );

  Widget _buildAdditionalOptions() => Column(
      children: [
        // AppButton(
        //   onPressed: () {
        //     Logger.info('Forgot password clicked');
        //     context.go('/forgot-password');
        //   },
        //   text: 'Forgot Password?',
        //   buttonType: AppButtonType.text,
        // ),
        // const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText("Don't have an account? "),
            AppButton(
              onPressed: () {
                // TODO: Navigate to registration
                context.go('/signup');
              },
              text: 'Sign Up',
              buttonType: AppButtonType.text,
            ),
          ],
        ),
      ],
    );

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;
      
      Logger.info('Attempting login for: $username');
      ref.read(authNotifierProvider.notifier).login(
        username,
        password,
        rememberMe: _rememberMe,
      );
    }
  }
}