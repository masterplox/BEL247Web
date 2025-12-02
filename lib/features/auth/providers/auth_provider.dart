import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/auth.dart';
import '../../../data/repositories/accounts_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/token_storage_service.dart';

/// Authentication state notifier for managing authentication state
class AuthNotifier extends StateNotifier<AuthState> {

  AuthNotifier(this._ref, this._authRepository) : super(const AuthState()) {
    _initializeAuth();
  }
  final Ref _ref;
  final AuthRepository _authRepository;

  /// Initialize authentication state from stored data
  Future<void> _initializeAuth() async {
    try {
      state = state.copyWith(isLoading: true);
      
      final hasCredentials = await TokenStorageService.hasValidCredentials();
      if (!hasCredentials) {
        Logger.info('No stored credentials found');
        state = state.copyWith(
          isLoading: false,
          isInitialized: true,
          isAuthenticated: false,
        );
        return;
      }

      // Validate existing session
      final sessionResponse = await _authRepository.validateSession();
      if (sessionResponse.success && sessionResponse.data != null) {
        Logger.info('Valid session found, user authenticated');
        state = state.copyWith(
          isLoading: false,
          isInitialized: true,
          isAuthenticated: true,
          userSession: sessionResponse.data,
          lastRefresh: DateTime.now(),
        );
      } else {
        Logger.info('Invalid session found, clearing credentials');
        await TokenStorageService.clearAll();
        state = state.copyWith(
          isLoading: false,
          isInitialized: true,
          isAuthenticated: false,
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Auth initialization error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        isInitialized: true,
        isAuthenticated: false,
        error: 'Failed to initialize authentication: ${e.toString()}',
      );
    }
  }

  /// Login user with email and password
  Future<void> login(String email, String password, {bool rememberMe = false}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final request = AuthRequest(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      final response = await _authRepository.login(request);
      
      if (response.success && response.data != null) {
        Logger.info('Login successful');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userSession: response.data!.userSession,
          lastRefresh: DateTime.now(),
          error: null,
        );

        // Initialize accounts for this user
        final userId = response.data!.userSession.userId;
        try {
          final accountsRepo = _ref.read(accountsRepositoryProvider);
          final accounts = await accountsRepo.fetchUserAccounts(userId);
          _ref.read(accountSwitcherProvider.notifier).initializeAccounts(accounts);
          Logger.info('Accounts initialized after login for user: $userId');
        } catch (e) {
          Logger.warning('Failed to initialize accounts after login: $e');
        }
      } else {
        Logger.warning('Login failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: response.error ?? 'Login failed',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Login error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: 'Login failed: ${e.toString()}',
      );
    }
  }

  /// Sign up a new user
  Future<void> signup(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final contact = state.otpContact;
      if (contact == null) {
        throw Exception('Contact information not found for sign up.');
      }

      final request = SignUpRequest(email: email, password: password, contact: contact);
      final response = await _authRepository.signup(request);

      if (response.success && response.data != null) {
        Logger.info('Signup successful for: $email');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userSession: response.data!.userSession,
          lastRefresh: DateTime.now(),
          error: null,
        );
      } else {
        Logger.warning('Signup failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: response.error ?? 'Signup failed',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Signup error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: 'Signup failed: ${e.toString()}',
      );
    }
  }

  /// Verify OTP for user's contact
  Future<void> verifyOtp(String otp) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final contact = state.otpContact;
      if (contact == null) {
        throw Exception('Contact information not found for OTP verification.');
      }

      final request = OtpVerifyRequest(contact: contact, otp: otp);
      final response = await _authRepository.verifyOtp(request);

      if (response.success) {
        Logger.info('OTP verified successfully for: $contact');
        state = state.copyWith(
          isLoading: false,
          otpVerified: true,
          error: null,
        );
      } else {
        Logger.warning('OTP verification failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          otpVerified: false,
          error: response.error ?? 'Failed to verify OTP',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Verify OTP error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        otpVerified: false,
        error: 'Failed to verify OTP: ${e.toString()}',
      );
    }
  }

  /// Send OTP to user's contact for verification
  Future<void> sendOtp(String contact) async {
    try {
      state = state.copyWith(isLoading: true, error: null, otpSent: false);
      
      final request = OtpSendRequest(contact: contact);
      final response = await _authRepository.sendOtp(request);
      
      if (response.success) {
        Logger.info('OTP sent successfully to: $contact');
        state = state.copyWith(
          isLoading: false,
          otpSent: true,
          otpContact: contact,
          error: null,
        );
      } else {
        Logger.warning('Send OTP failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          otpSent: false,
          error: response.error ?? 'Failed to send OTP',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Send OTP error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        otpSent: false,
        otpContact: null,
        error: 'Failed to send OTP: ${e.toString()}',
      );
    }
  }

  /// Logout user and clear session
  Future<void> logout({bool logoutAllDevices = false}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final currentSession = state.userSession;
      if (currentSession != null) {
        final request = LogoutRequest(
          userId: currentSession.userId,
          logoutAllDevices: logoutAllDevices,
        );

        await _authRepository.logout(request);
      }

      // Clear local state
      await TokenStorageService.clearAll();
      
      Logger.info('Logout successful');
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        userSession: null,
        lastRefresh: null,
        error: null,
        otpSent: false,
        otpContact: null,
        otpVerified: false,
      );
    } catch (e, stackTrace) {
      Logger.error('Logout error', error: e, stackTrace: stackTrace);
      // Clear state even if logout request fails
      await TokenStorageService.clearAll();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        userSession: null,
        lastRefresh: null,
        error: 'Logout failed: ${e.toString()}',
        otpSent: false,
        otpContact: null,
        otpVerified: false,
      );
    }
  }

  /// Refresh access token
  Future<void> refreshToken() async {
    try {
      final refreshToken = await TokenStorageService.getRefreshToken();
      final userSession = state.userSession;
      
      if (refreshToken == null || userSession == null) {
        Logger.warning('No refresh token or user session available');
        await logout();
        return;
      }

      final request = TokenRefreshRequest(
        refreshToken: refreshToken,
        userId: userSession.userId,
      );

      final response = await _authRepository.refreshToken(request);
      
      if (response.success && response.data != null) {
        Logger.info('Token refresh successful');
        state = state.copyWith(
          lastRefresh: DateTime.now(),
          error: null,
        );
      } else {
        Logger.warning('Token refresh failed: ${response.error}');
        await logout();
      }
    } catch (e, stackTrace) {
      Logger.error('Token refresh error', error: e, stackTrace: stackTrace);
      await logout();
    }
  }

  /// Change user password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final request = PasswordChangeRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      final response = await _authRepository.changePassword(request);
      
      if (response.success) {
        Logger.info('Password change successful');
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      } else {
        Logger.warning('Password change failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Password change failed',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Password change error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'Password change failed: ${e.toString()}',
      );
    }
  }

  /// Update user session with new data
  void updateUserSession(UserSession session) {
    state = state.copyWith(userSession: session);
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset OTP sent state
  void resetOtpState() {
    state = state.copyWith(otpSent: false, otpContact: null, otpVerified: false);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => state.isAuthenticated;

  /// Get current user session
  UserSession? get currentSession => state.userSession;

  /// Get current error
  String? get currentError => state.error;

  /// Check if loading
  bool get isLoading => state.isLoading;

  /// Check if initialized
  bool get isInitialized => state.isInitialized;
}

/// Provider for authentication repository
final authRepositoryProvider = Provider<AuthRepository>((ref) => MockAuthRepository());

/// Provider for authentication state notifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(ref, authRepository);
});

/// Provider for authentication state
final authStateProvider = StateProvider<AuthState>((ref) => ref.watch(authNotifierProvider));

/// Provider for current user session
final currentUserProvider = Provider<UserSession?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.userSession;
});

/// Provider for authentication status
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.isAuthenticated;
});

/// Provider for loading state
final authLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.isLoading;
});

/// Provider for authentication error
final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.error;
});

/// Provider for checking if auth is initialized
final authInitializedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.isInitialized;
});
