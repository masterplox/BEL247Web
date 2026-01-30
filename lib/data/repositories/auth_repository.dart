import 'package:dio/dio.dart';

import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../models/auth.dart';
import '../services/token_storage_service.dart';
import 'base_repository.dart';

/// Abstract authentication repository interface
abstract class AuthRepository extends BaseRepository {
  /// Authenticate user with email and password
  Future<ApiResponse<AuthResponse>> login(AuthRequest request);
  
  /// Logout user and clear session
  Future<ApiResponse<void>> logout(LogoutRequest request);
  
  /// Refresh access token using refresh token
  Future<ApiResponse<TokenRefreshResponse>> refreshToken(TokenRefreshRequest request);
  
  /// Validate current session
  Future<ApiResponse<UserSession>> validateSession();
  
  /// Change user password
  Future<ApiResponse<void>> changePassword(PasswordChangeRequest request);
  
  /// Send OTP to user's contact for verification
  Future<ApiResponse<void>> sendOtp(OtpSendRequest request);

  /// Verify OTP for user's contact
  Future<ApiResponse<void>> verifyOtp(OtpVerifyRequest request);
  
  /// Register a new user
  Future<ApiResponse<AuthResponse>> signup(SignUpRequest request);

  /// Sign up Step 1 - Deliver OTP
  Future<ApiResponse<void>> signUpStep1(SignUpStep1Request request);

  /// Sign up Step 2 - Activate device with OTP
  Future<ApiResponse<String>> signUpStep2(SignUpStep2Request request); // Returns GuestUUID

  /// Sign up Step 3 - Register user
  Future<ApiResponse<AuthResponse>> signUpStep3(SignUpStep3Request request);

  /// Reset password using phone, new password, and OTP
  Future<ApiResponse<void>> resetPassword(PasswordResetRequest request);

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
  
  /// Get current user session
  Future<UserSession?> getCurrentSession();
}

/// Mock implementation of authentication repository
class MockAuthRepository implements AuthRepository {

  MockAuthRepository();

  @override
  Future<ApiResponse<void>> verifyOtp(OtpVerifyRequest request) async {
    try {
      Logger.info('Attempting to verify OTP for: ${request.contact}');

      if (request.otp == '12345') {
        Logger.info('OTP verified successfully for: ${request.contact}');
        return ApiResponse.success(null);
      } else {
        Logger.warning('OTP verification failed for: ${request.contact}');
        return ApiResponse.error('Invalid OTP');
      }
    } catch (e, stackTrace) {
      Logger.error('Verify OTP error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Verify OTP failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> signup(SignUpRequest request) async {
    try {
      Logger.info('Attempting to sign up user: ${request.email}');
      
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock signup logic
      final now = DateTime.now();
      final accessTokenExpiry = now.add(const Duration(minutes: 15));
      final refreshTokenExpiry = now.add(const Duration(days: 7));

      final userSession = UserSession(
        userId: 'user_${now.millisecondsSinceEpoch}',
        email: request.email,
        firstName: 'New',
        lastName: 'User',
        loginTime: now,
        lastActivity: now,
        isActive: true,
        preferences: {},
      );

      final authResponse = AuthResponse(
        accessToken: 'mock_access_token_${now.millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${now.millisecondsSinceEpoch}',
        userId: userSession.userId,
        expiresAt: accessTokenExpiry,
        userSession: userSession,
      );

      // Store tokens and session
      await TokenStorageService.storeTokenPair(TokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        accessTokenExpiresAt: accessTokenExpiry,
        refreshTokenExpiresAt: refreshTokenExpiry,
      ));
      await TokenStorageService.storeUserSession(userSession);
      await TokenStorageService.updateLastRefresh();

      Logger.info('Signup successful for user: ${request.email}');
      return ApiResponse.success(authResponse);
    } catch (e, stackTrace) {
      Logger.error('Signup error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Signup failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> sendOtp(OtpSendRequest request) async {
    try {
      Logger.info('Attempting to send OTP to: ${request.contact}');
      
      final validation = _validateOtpSendRequest(request);
      if (!validation.isValid) {
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      await Future.delayed(const Duration(milliseconds: 500));

      Logger.info('OTP sent successfully to: ${request.contact}');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Send OTP error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Send OTP failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> signUpStep1(SignUpStep1Request request) async {
    try {
      Logger.info('Mock Sign up Step 1 - MobileNumber: ${request.mobileNumber ?? 'null'}, Email: ${request.email ?? 'null'}');
      await Future.delayed(const Duration(milliseconds: 500));
      Logger.info('Mock OTP sent successfully');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Mock Sign up Step 1 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Send OTP failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<String>> signUpStep2(SignUpStep2Request request) async {
    try {
      Logger.info('Mock Sign up Step 2 - Code: ${request.code}');
      await Future.delayed(const Duration(milliseconds: 500));
      if (request.code == '12345') {
        Logger.info('Mock OTP verified successfully');
        return ApiResponse.success('mock_guest_uuid_${DateTime.now().millisecondsSinceEpoch}');
      } else {
        Logger.warning('Mock OTP verification failed');
        return ApiResponse.error('Invalid OTP');
      }
    } catch (e, stackTrace) {
      Logger.error('Mock Sign up Step 2 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Verify OTP failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> signUpStep3(SignUpStep3Request request) async {
    try {
      Logger.info('Mock Sign up Step 3 - Username: ${request.username}');
      await Future.delayed(const Duration(milliseconds: 500));
      
      final now = DateTime.now();
      final accessTokenExpiry = now.add(const Duration(minutes: 15));
      final refreshTokenExpiry = now.add(const Duration(days: 7));

      final userSession = UserSession(
        userId: 'user_${now.millisecondsSinceEpoch}',
        email: request.email ?? request.username,
        firstName: 'New',
        lastName: 'User',
        loginTime: now,
        lastActivity: now,
        isActive: true,
        preferences: {},
      );

      final authResponse = AuthResponse(
        accessToken: 'mock_access_token_${now.millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${now.millisecondsSinceEpoch}',
        userId: userSession.userId,
        expiresAt: accessTokenExpiry,
        userSession: userSession,
      );

      await TokenStorageService.storeTokenPair(TokenPair(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        accessTokenExpiresAt: accessTokenExpiry,
        refreshTokenExpiresAt: refreshTokenExpiry,
      ));
      await TokenStorageService.storeUserSession(userSession);
      await TokenStorageService.updateLastRefresh();

      Logger.info('Mock Sign up Step 3 successful');
      return ApiResponse.success(authResponse);
    } catch (e, stackTrace) {
      Logger.error('Mock Sign up Step 3 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> login(AuthRequest request) async {
    try {
      Logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', tag: 'MockAuthRepository');
      Logger.info('🔐 MOCK LOGIN ATTEMPT', tag: 'MockAuthRepository');
      Logger.info('Username: ${request.username}', tag: 'MockAuthRepository');
      Logger.info('Password: ${request.password.isEmpty ? '(empty)' : '***MASKED***'}', tag: 'MockAuthRepository');
      
      // Validate request
      final validation = _validateAuthRequest(request);
      if (!validation.isValid) {
        Logger.warning('❌ Validation failed: ${validation.errors.join(', ')}', tag: 'MockAuthRepository');
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock authentication logic - ONLY accepts hardcoded credentials
      Logger.info('Checking credentials against mock data...', tag: 'MockAuthRepository');
      Logger.info('Expected: user@bel247.com / password123', tag: 'MockAuthRepository');
      
      if (request.username == 'user@bel247.com' && request.password == 'password123') {
        Logger.info('✅ Credentials match! Login successful.', tag: 'MockAuthRepository');
        final now = DateTime.now();
        final accessTokenExpiry = now.add(const Duration(minutes: 15));
        final refreshTokenExpiry = now.add(const Duration(days: 7));

        final userSession = UserSession(
          userId: 'user_001',
          email: request.username,
          firstName: 'John',
          lastName: 'Doe',
          loginTime: now,
          lastActivity: now,
          isActive: true,
          preferences: {
            'theme': 'light',
            'notifications': true,
            'language': 'en',
          },
        );

        final authResponse = AuthResponse(
          accessToken: 'mock_access_token_${now.millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_${now.millisecondsSinceEpoch}',
          userId: 'user_001',
          expiresAt: accessTokenExpiry,
          userSession: userSession,
        );

        // Store tokens and session
        await TokenStorageService.storeTokenPair(TokenPair(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          accessTokenExpiresAt: accessTokenExpiry,
          refreshTokenExpiresAt: refreshTokenExpiry,
        ));
        await TokenStorageService.storeUserSession(userSession);
        await TokenStorageService.updateLastRefresh();

        Logger.info('✅ Login successful for user: ${request.username}', tag: 'MockAuthRepository');
        Logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', tag: 'MockAuthRepository');
        return ApiResponse.success(authResponse);
      } else {
        Logger.warning('❌ Login failed for user: ${request.username}', tag: 'MockAuthRepository');
        Logger.warning('💡 Note: Mock mode only accepts: user@bel247.com / password123', tag: 'MockAuthRepository');
        Logger.warning('💡 To use real API, set USE_MOCK=false in your environment', tag: 'MockAuthRepository');
        Logger.warning('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', tag: 'MockAuthRepository');
        return ApiResponse.error('Invalid email or password');
      }
    } catch (e, stackTrace) {
      Logger.error('Login error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> logout(LogoutRequest request) async {
    try {
      Logger.info('Logging out user: ${request.userId}');
      
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Clear stored authentication data
      if (request.logoutAllDevices) {
        await TokenStorageService.clearAll();
      } else {
        await TokenStorageService.clearTokens();
      }

      Logger.info('Logout successful for user: ${request.userId}');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Logout error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<TokenRefreshResponse>> refreshToken(TokenRefreshRequest request) async {
    try {
      Logger.info('Refreshing token for user: ${request.userId}');
      
      // Check if refresh token is expired
      final isRefreshExpired = await TokenStorageService.isRefreshTokenExpired();
      if (isRefreshExpired) {
        Logger.warning('Refresh token is expired');
        return ApiResponse.error('Refresh token has expired. Please login again.');
      }

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      // Generate new tokens
      final now = DateTime.now();
      final accessTokenExpiry = now.add(const Duration(minutes: 15));
      final refreshTokenExpiry = now.add(const Duration(days: 7));

      final response = TokenRefreshResponse(
        accessToken: 'mock_refreshed_access_token_${now.millisecondsSinceEpoch}',
        refreshToken: 'mock_refreshed_refresh_token_${now.millisecondsSinceEpoch}',
        expiresAt: accessTokenExpiry,
      );

      // Store new tokens
      await TokenStorageService.storeTokenPair(TokenPair(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        accessTokenExpiresAt: accessTokenExpiry,
        refreshTokenExpiresAt: refreshTokenExpiry,
      ));
      await TokenStorageService.updateLastRefresh();

      Logger.info('Token refresh successful for user: ${request.userId}');
      return ApiResponse.success(response);
    } catch (e, stackTrace) {
      Logger.error('Token refresh error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Token refresh failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<UserSession>> validateSession() async {
    try {
      Logger.info('Validating user session');
      
      // Check if we have stored credentials
      final hasCredentials = await TokenStorageService.hasValidCredentials();
      if (!hasCredentials) {
        Logger.warning('No valid credentials found');
        return ApiResponse.error('No valid session found');
      }

      // Check if access token is expired
      final isAccessExpired = await TokenStorageService.isAccessTokenExpired();
      if (isAccessExpired) {
        Logger.warning('Access token is expired');
        return ApiResponse.error('Session has expired');
      }

      // Get user session
      final userSession = await TokenStorageService.getUserSession();
      if (userSession == null) {
        Logger.warning('No user session found');
        return ApiResponse.error('No user session found');
      }

      // Update last activity
      final updatedSession = userSession.copyWith(
        lastActivity: DateTime.now(),
      );
      await TokenStorageService.storeUserSession(updatedSession);

      Logger.info('Session validation successful');
      return ApiResponse.success(updatedSession);
    } catch (e, stackTrace) {
      Logger.error('Session validation error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Session validation failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> changePassword(PasswordChangeRequest request) async {
    try {
      Logger.info('Changing password for user');
      
      // Validate request
      final validation = _validatePasswordChangeRequest(request);
      if (!validation.isValid) {
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock password change success
      Logger.info('Password change successful');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Password change error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Password change failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> resetPassword(PasswordResetRequest request) async {
    try {
      Logger.info('Resetting password for: ${request.phone}');
      
      // Validate request
      final validation = _validatePasswordResetRequest(request);
      if (!validation.isValid) {
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock password reset success
      Logger.info('Password reset successful for: ${request.phone}');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Password reset error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Password reset failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final hasCredentials = await TokenStorageService.hasValidCredentials();
      if (!hasCredentials) return false;

      final isAccessExpired = await TokenStorageService.isAccessTokenExpired();
      return !isAccessExpired;
    } catch (e, stackTrace) {
      Logger.error('Authentication check error', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future<UserSession?> getCurrentSession() async {
    try {
      final isAuth = await isAuthenticated();
      if (!isAuth) return null;

      return await TokenStorageService.getUserSession();
    } catch (e, stackTrace) {
      Logger.error('Get current session error', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Validate authentication request
  AuthValidationResult _validateAuthRequest(AuthRequest request) {
    final errors = <String>[];
    final fieldErrors = <String, String>{};

    if (request.username.isEmpty) {
      errors.add('Username is required');
      fieldErrors['username'] = 'Username is required';
    } else if (request.username.length < 3) {
      errors.add('Username must be at least 3 characters');
      fieldErrors['username'] = 'Username must be at least 3 characters';
    }

    if (request.password.isEmpty) {
      errors.add('Password is required');
      fieldErrors['password'] = 'Password is required';
    } else if (request.password.length < 6) {
      errors.add('Password must be at least 6 characters');
      fieldErrors['password'] = 'Password must be at least 6 characters';
    }

    return AuthValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      fieldErrors: fieldErrors,
    );
  }

  /// Validate password change request
  AuthValidationResult _validatePasswordChangeRequest(PasswordChangeRequest request) {
    final errors = <String>[];
    final fieldErrors = <String, String>{};

    if (request.currentPassword.isEmpty) {
      errors.add('Current password is required');
      fieldErrors['currentPassword'] = 'Current password is required';
    }

    if (request.newPassword.isEmpty) {
      errors.add('New password is required');
      fieldErrors['newPassword'] = 'New password is required';
    } else if (request.newPassword.length < 6) {
      errors.add('New password must be at least 6 characters');
      fieldErrors['newPassword'] = 'New password must be at least 6 characters';
    }

    if (request.confirmPassword.isEmpty) {
      errors.add('Confirm password is required');
      fieldErrors['confirmPassword'] = 'Confirm password is required';
    } else if (request.newPassword != request.confirmPassword) {
      errors.add('Passwords do not match');
      fieldErrors['confirmPassword'] = 'Passwords do not match';
    }

    return AuthValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      fieldErrors: fieldErrors,
    );
  }

  /// Validate OTP send request
  AuthValidationResult _validateOtpSendRequest(OtpSendRequest request) {
    final errors = <String>[];
    final fieldErrors = <String, String>{};

    if (request.contact.isEmpty) {
      errors.add('Contact information is required');
      fieldErrors['contact'] = 'Contact information is required';
    } else {
      final isEmail = _isValidEmail(request.contact);
      final isPhone = RegExp(r'^\+?[0-9]{10,}$').hasMatch(request.contact);
      if (!isEmail && !isPhone) {
        errors.add('Invalid email or phone number format');
        fieldErrors['contact'] = 'Invalid email or phone number format';
      }
    }

    return AuthValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      fieldErrors: fieldErrors,
    );
  }

  /// Validate password reset request
  AuthValidationResult _validatePasswordResetRequest(PasswordResetRequest request) {
    final errors = <String>[];
    final fieldErrors = <String, String>{};

    if (request.phone.isEmpty) {
      errors.add('Contact information is required');
      fieldErrors['phone'] = 'Contact information is required';
    } else {
      // Accept both email and phone number formats
      final isEmail = _isValidEmail(request.phone);
      final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');
      final digitsOnly = request.phone.replaceAll(RegExp(r'[\s-()]'), '');
      final isPhone = phoneRegex.hasMatch(request.phone) && digitsOnly.length >= 7;
      
      if (!isEmail && !isPhone) {
        errors.add('Invalid email or phone number format');
        fieldErrors['phone'] = 'Invalid email or phone number format';
      }
    }

    if (request.newPassword.isEmpty) {
      errors.add('New password is required');
      fieldErrors['newPassword'] = 'New password is required';
    } else if (request.newPassword.length < 6) {
      errors.add('New password must be at least 6 characters');
      fieldErrors['newPassword'] = 'New password must be at least 6 characters';
    }

    if (request.confirmPassword.isEmpty) {
      errors.add('Confirm password is required');
      fieldErrors['confirmPassword'] = 'Confirm password is required';
    } else if (request.newPassword != request.confirmPassword) {
      errors.add('Passwords do not match');
      fieldErrors['confirmPassword'] = 'Passwords do not match';
    }

    if (request.otp.isEmpty) {
      errors.add('OTP code is required');
      fieldErrors['otp'] = 'OTP code is required';
    } else if (request.otp.length != 5) {
      errors.add('OTP code must be 5 digits');
      fieldErrors['otp'] = 'OTP code must be 5 digits';
    } else if (request.otp != '12345') {
      errors.add('Invalid OTP code');
      fieldErrors['otp'] = 'Invalid OTP code';
    }

    return AuthValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      fieldErrors: fieldErrors,
    );
  }

  /// Validate email format
  bool _isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  @override
  Future<T> handleResponse<T>(
    Future<Response> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await apiCall();
      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        throw Exception('API call failed with status: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('API call failed', error: e);
      rethrow;
    }
  }

  @override
  void handleError(DioException error) {
    Logger.error('Dio error occurred', error: error);
  }
}
