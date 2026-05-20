import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/env.dart';
import '../../../core/providers/feature_providers.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/auth.dart';
import '../../../data/repositories/accounts_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/live_auth_repository.dart';
import '../../../data/services/api_client.dart';
import '../../../core/services/user_preferences_storage.dart';
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

        // Fetch and initialize connected accounts after session validation
        // For session validation, we read token from storage (it should already be there)
        Logger.info('[_initializeAuth] Valid session found, fetching connected accounts...', tag: 'AuthProvider');
        await _fetchAndInitializeAccounts(); // No token parameter - read from storage
        Logger.info('[_initializeAuth] Account fetch completed', tag: 'AuthProvider');
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

  /// Helper method to fetch and initialize connected accounts
  ///
  /// Note: the login/validateSession flows ensure tokens are stored,
  /// so here we just do a lightweight availability check and then fetch.
  Future<void> _fetchAndInitializeAccounts() async {
    Logger.info('[_fetchAndInitializeAccounts] Starting to fetch connected accounts...', tag: 'AuthProvider');
    try {
      // Lightweight check – don't fail auth flow if this is briefly null,
      // the ApiClient / interceptor will handle refresh if needed.
      final tokenAvailable = await TokenStorageService.getAccessToken();
      if (tokenAvailable == null || tokenAvailable.isEmpty) {
        Logger.warning(
          '[_fetchAndInitializeAccounts] Access token not available at fetch time; proceeding anyway',
          tag: 'AuthProvider',
        );
      } else {
      }

      final accountsRepo = _ref.read(accountsRepositoryProvider);
      Logger.info('[_fetchAndInitializeAccounts] Repository obtained, calling fetchConnectedAccounts...', tag: 'AuthProvider');
      final accounts = await accountsRepo.fetchConnectedAccounts();
      
      Logger.info(
        '[_fetchAndInitializeAccounts] Received ${accounts.length} accounts from API',
        tag: 'AuthProvider',
      );
      
      String? restoredAccountId;
      final session = state.userSession ?? await TokenStorageService.getUserSession();
      if (session != null) {
        final lastId =
            await UserPreferencesStorage.getLastActiveAccountId(session.userId);
        if (lastId != null && accounts.any((a) => a.id == lastId)) {
          restoredAccountId = lastId;
        }
      }

      _ref.read(accountSwitcherProvider.notifier).initializeAccounts(
            accounts,
            activeAccountId: restoredAccountId,
          );
      
      if (accounts.isNotEmpty) {
        Logger.info(
          '[_fetchAndInitializeAccounts] Successfully initialized ${accounts.length} connected accounts',
          tag: 'AuthProvider',
        );
      } else {
        Logger.warning('[_fetchAndInitializeAccounts] No connected accounts found - marked as initialized with empty list', tag: 'AuthProvider');
      }
    } catch (e, stackTrace) {
      Logger.error(
        '[_fetchAndInitializeAccounts] Failed to fetch connected accounts',
        error: e,
        stackTrace: stackTrace,
        tag: 'AuthProvider',
      );
      // Don't fail auth if account fetch fails - user can still use the app
    }
  }

  /// Login user with email and password
  Future<void> login(String email, String password, {bool rememberMe = false}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final request = AuthRequest(
        username: email, 
        password: password,
        rememberMe: rememberMe,
      );

      final response = await _authRepository.login(request);

      if (response.success && response.data != null) {
        Logger.info('Login successful');

        // At this point LiveAuthRepository has already stored the tokens.
        // We trust that path; if storage has issues it will be logged there.
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userSession: response.data!.userSession,
          lastRefresh: DateTime.now(),
          error: null,
        );

        // Fetch and initialize connected accounts after successful login.
        // Any transient token issues are handled by ApiClient/interceptors.
        Logger.info('[login] Login successful, fetching connected accounts...', tag: 'AuthProvider');
        await _fetchAndInitializeAccounts();
        Logger.info('[login] Account fetch completed', tag: 'AuthProvider');
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
          signupCompleted: true,
          // We don't authenticate immediately, we wait for the user to click through the success page
          // isAuthenticated: true, 
          // userSession: response.data!.userSession,
          // lastRefresh: DateTime.now(),
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

  /// Send OTP to user's contact for verification (legacy)
  Future<void> sendOtp(String contact) async {
    final isEmail = contact.contains('@');
    await requestPasswordCode(
      mobileNumber: isEmail ? null : contact,
      email: isEmail ? contact : null,
      authenticated: false,
    );
  }

  /// Request password reset verification code (exactly one contact channel).
  Future<void> requestPasswordCode({
    String? mobileNumber,
    String? email,
    String? username,
    required bool authenticated,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null, otpSent: false);

      final request = PasswordCodeRequest(
        mobileNumber: mobileNumber,
        email: email,
        username: username,
      );
      final response = await _authRepository.requestPasswordCode(
        request,
        authenticated: authenticated,
      );

      if (response.success) {
        final contactType = mobileNumber != null
            ? 'phone'
            : (email != null ? 'email' : 'username');
        final contact = mobileNumber ?? email ?? username ?? '';
        Logger.info('Password code sent to: $contact');
        state = state.copyWith(
          isLoading: false,
          otpSent: true,
          otpContact: contact,
          passwordResetContactType: contactType,
          error: null,
        );
      } else {
        Logger.warning('Password code request failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          otpSent: false,
          error: response.error ?? 'Failed to send verification code',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Request password code error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        otpSent: false,
        otpContact: null,
        error: 'Failed to send verification code: ${e.toString()}',
      );
    }
  }

  /// Sign up Step 1 - Deliver OTP
  Future<void> signUpStep1({String? mobileNumber, String? email, String? username}) async {
    try {
      state = state.copyWith(isLoading: true, error: null, otpSent: false);
      
      final request = SignUpStep1Request(
        mobileNumber: mobileNumber,
        email: email,
        username: username,
      );
      final response = await _authRepository.signUpStep1(request);
      
      if (response.success) {
        Logger.info('Sign up Step 1 successful');
        // Determine contact type
        final contactType = mobileNumber != null ? 'phone' : 'email';
        final contact = mobileNumber ?? email ?? '';
        state = state.copyWith(
          isLoading: false,
          otpSent: true,
          otpContact: contact,
          signupContactType: contactType,
          error: null,
        );
      } else {
        Logger.warning('Sign up Step 1 failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          otpSent: false,
          error: response.error ?? 'Failed to send OTP',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 1 error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        otpSent: false,
        error: 'Failed to send OTP: ${e.toString()}',
      );
    }
  }

  /// Sign up Step 2 - Activate device with OTP
  Future<void> signUpStep2(String code) async {
    try {
      state = state.copyWith(isLoading: true, error: null, otpVerified: false);
      
      final contact = state.otpContact;
      final contactType = state.signupContactType;
      
      if (contact == null || contactType == null) {
        throw Exception('Contact information not found for OTP verification.');
      }

      final request = SignUpStep2Request(
        code: code,
        phoneNumber: contactType == 'phone' ? contact : null,
        email: contactType == 'email' ? contact : null,
      );
      final response = await _authRepository.signUpStep2(request);
      
      if (response.success && response.data != null) {
        Logger.info('Sign up Step 2 successful - GuestUUID: ${response.data}');
        state = state.copyWith(
          isLoading: false,
          otpVerified: true,
          guestUUID: response.data,
          error: null,
        );
      } else {
        Logger.warning('Sign up Step 2 failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          otpVerified: false,
          error: response.error ?? 'Failed to verify OTP',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 2 error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        otpVerified: false,
        error: 'Failed to verify OTP: ${e.toString()}',
      );
    }
  }

  /// Sign up Step 3 - Register user
  Future<void> signUpStep3(
    String username,
    String password, {
    String? email,
    String? phoneNumber,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final contact = state.otpContact;
      final contactType = state.signupContactType;
      final guestUUID = state.guestUUID ?? ''; // Use empty string if not provided

      // Use provided email/phoneNumber, or fall back to contact from step 1
      final finalEmail = email ?? (contactType == 'email' ? contact : null);
      final finalPhoneNumber = phoneNumber ?? (contactType == 'phone' ? contact : null);

      final request = SignUpStep3Request(
        username: username,
        password: password,
        email: finalEmail,
        mobileNumber: finalPhoneNumber,
        guestUUID: guestUUID, // Can be empty string
      );
      final response = await _authRepository.signUpStep3(request);
      
      if (response.success && response.data != null) {
        Logger.info('Sign up Step 3 successful for: $username');
        state = state.copyWith(
          isLoading: false,
          signupCompleted: true,
          error: null,
        );
      } else {
        Logger.warning('Sign up Step 3 failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: response.error ?? 'Registration failed',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 3 error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: 'Registration failed: ${e.toString()}',
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

      // Clear local state - tokens and all stored data
      await TokenStorageService.clearAll();
      
      // Reset account switcher state
      _ref.read(accountSwitcherProvider.notifier).reset();
      
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
        passwordResetContactType: null,
      );
    } catch (e, stackTrace) {
      Logger.error('Logout error', error: e, stackTrace: stackTrace);
      // Clear state even if logout request fails
      await TokenStorageService.clearAll();
      
      // Reset account switcher state even on error
      _ref.read(accountSwitcherProvider.notifier).reset();
      
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        userSession: null,
        lastRefresh: null,
        error: 'Logout failed: ${e.toString()}',
        otpSent: false,
        otpContact: null,
        otpVerified: false,
        passwordResetContactType: null,
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

  /// Reset password using username, new password, and verification code.
  Future<void> resetDevicePassword({
    required String username,
    required String newPassword,
    required String confirmPassword,
    required String passwordCode,
    required bool authenticated,
  }) async {
    try {
      if (newPassword != confirmPassword) {
        state = state.copyWith(
          isLoading: false,
          error: 'Passwords do not match',
        );
        return;
      }

      state = state.copyWith(isLoading: true, error: null);

      final request = DevicePasswordResetRequest(
        username: username.trim(),
        password: newPassword,
        passwordCode: passwordCode.trim(),
      );

      final response = await _authRepository.resetDevicePassword(
        request,
        authenticated: authenticated,
      );

      if (response.success) {
        Logger.info('Password reset successful for: $username');
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
      } else {
        Logger.warning('Password reset failed: ${response.error}');
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Password reset failed',
        );
      }
    } catch (e, stackTrace) {
      Logger.error('Password reset error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'Password reset failed: ${e.toString()}',
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
    state = state.copyWith(
      otpSent: false,
      otpContact: null,
      otpVerified: false,
      passwordResetContactType: null,
    );
  }

  /// Reset all signup-related state (use this when signup flow is complete)
  void resetSignupState() {
    state = state.copyWith(
      otpSent: false,
      otpContact: null,
      otpVerified: false,
      signupCompleted: false,
      guestUUID: null,
      signupContactType: null,
    );
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
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final currentApiUrl = EnvConfig.currentApiUrl;
  
  // Always use the live API now; mock auth is fully disabled.
  Logger.info('🌐 Using LiveAuthRepository with real API', tag: 'AuthProvider');
  Logger.info('   API URL: $currentApiUrl', tag: 'AuthProvider');
  Logger.info('   API logging enabled - check console for detailed logs', tag: 'AuthProvider');
  return LiveAuthRepository(ApiClient.instance);
});

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
