import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/storage_service.dart';
import '../../core/utils/logger.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
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
  static const String _rememberMeKey = 'login_remember_me';
  static const String _rememberedUsernameKey = 'login_remembered_username';

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
    _loadRememberedLogin();
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
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/bel_logo.png',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const AppText(
          'BEL247 Portal',
          style: AppTextStyle.title,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
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
            if (authState.error != null) ...[
              const SizedBox(height: 12),
              _buildLoginErrorSection(authState.error!),
            ],
            const SizedBox(height: 16),
            
            // Remember Me Checkbox (pointer cursor on web/desktop)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _toggleRememberMe(!_rememberMe),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) => _toggleRememberMe(value ?? false),
                      activeColor: AppColors.primary,
                    ),
                    const AppText('Remember me'),
                  ],
                ),
              ),
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

  /// Inline error below the password field (info-style section card).
  Widget _buildLoginErrorSection(String error) => AppCard(
        elevation: 0,
        color: const Color(0xFFEFF6FF),
        borderColor: AppColors.info.withValues(alpha: 0.45),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: AppColors.info, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: AppText(
                error,
                style: AppTextStyle.body,
                color: const Color(0xFF1E40AF),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, size: 18, color: AppColors.info.withValues(alpha: 0.85)),
              onPressed: () {
                ref.read(authNotifierProvider.notifier).clearError();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              tooltip: 'Dismiss',
            ),
          ],
        ),
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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 4,
          runSpacing: 4,
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

      if (_rememberMe) {
        _saveRememberedLogin(username);
      } else {
        _clearRememberedLogin();
      }
      
      Logger.info('Attempting login for: $username');
      ref.read(authNotifierProvider.notifier).login(
        username,
        password,
        rememberMe: _rememberMe,
      );
    }
  }

  Future<void> _loadRememberedLogin() async {
    try {
      final savedRememberMe = await StorageService.getBool(_rememberMeKey) ?? false;
      final savedUsername = await StorageService.getString(_rememberedUsernameKey) ?? '';

      if (!mounted) return;
      setState(() {
        _rememberMe = savedRememberMe;
        _usernameController.text = savedRememberMe ? savedUsername : '';
      });
    } catch (e, stackTrace) {
      Logger.error('Failed to load remembered login', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> _saveRememberedLogin(String username) async {
    try {
      await StorageService.storeBool(_rememberMeKey, true);
      await StorageService.storeString(_rememberedUsernameKey, username);
    } catch (e, stackTrace) {
      Logger.error('Failed to save remembered login', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> _clearRememberedLogin() async {
    try {
      await StorageService.storeBool(_rememberMeKey, false);
      await StorageService.remove(_rememberedUsernameKey);
    } catch (e, stackTrace) {
      Logger.error('Failed to clear remembered login', error: e, stackTrace: stackTrace);
    }
  }

  void _toggleRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });

    if (_rememberMe) {
      _saveRememberedLogin(_usernameController.text.trim());
    } else {
      _clearRememberedLogin();
    }
  }
}