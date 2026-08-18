import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/env.dart';
import '../../core/constants/customer_portal_support_types.dart';
import '../../core/services/storage_service.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/mobile_detection.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text.dart';
import '../../core/widgets/bel_mobile_app_qr_card.dart';
import '../../core/widgets/customer_portal_support_button.dart';
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

    // Redirect mobile phone users to the app download landing.
    // Gated by EnvConfig.blockMobilePhones, which is off by default.
    if (EnvConfig.blockMobilePhones && MobileDetection.isMobilePhone) {
      return _buildMobileLandingView();
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
                  const SizedBox(height: 24),

                  // AMI Access Notice
                  _buildAmiAccessNotice(),
                  const SizedBox(height: 24),
                  
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

  Widget _buildMobileLandingView() => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildMobileDeviceNotice(),
                    const SizedBox(height: 20),
                    const BelMobileAppQrCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildMobileDeviceNotice() => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.warning, width: 1.5),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.smartphone,
                    color: Color(0xFF92400E),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: AppText(
                    'You\'re on a Mobile Device',
                    style: AppTextStyle.subtitle,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF92400E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const AppText(
              'The BEL24-7 Customer Portal is designed for desktop web browsers and is not optimized for mobile phones.',
              style: AppTextStyle.body,
              color: Color(0xFF78350F),
            ),
            const SizedBox(height: 8),
            const AppText(
              'For the best experience, please download the BEL 24-7 mobile app which is built specifically for your device.',
              style: AppTextStyle.body,
              color: Color(0xFF78350F),
            ),
          ],
        ),
      );

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
          'BEL24-7 Portal',
          style: AppTextStyle.title,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ],
    );

  Widget _buildAmiAccessNotice() => AppCard(
        elevation: 0,
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderColor: AppColors.primary.withValues(alpha: 0.25),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: const Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Welcome!',
                    style: AppTextStyle.subtitle,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(height: 6),
                  AppText(
                    'This portal is optimized for Customers with Advanced Metering Infrastructure (AMI).',
                    style: AppTextStyle.body,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 4),
                  AppText(
                    'Access to data may be limited for Customers without AMI at this time.',
                    style: AppTextStyle.body,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
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
        AppButton(
          onPressed: () {
            Logger.info('Forgot password clicked');
            context.go('/forgot-password');
          },
          text: 'Forgot Password?',
          buttonType: AppButtonType.text,
        ),
        const Center(
          child: CustomerPortalSupportButton(
            sourcePage: '/login',
            initialSupportType: CustomerPortalSupportTypes.general,
          ),
        ),
        const SizedBox(height: 16),
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