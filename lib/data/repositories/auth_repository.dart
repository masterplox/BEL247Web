import 'package:dio/dio.dart';

import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../models/auth.dart';
import '../services/mock_api_endpoints.dart';
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
  
  /// Check if user is authenticated
  Future<bool> isAuthenticated();
  
  /// Get current user session
  Future<UserSession?> getCurrentSession();
}

/// Mock implementation of authentication repository
class MockAuthRepository implements AuthRepository {

  MockAuthRepository({MockApiEndpoints? mockApiEndpoints})
      : _mockApiEndpoints = mockApiEndpoints ?? MockApiEndpoints();
  final MockApiEndpoints _mockApiEndpoints;

  @override
  Future<ApiResponse<AuthResponse>> login(AuthRequest request) async {
    try {
      Logger.info('Attempting login for user: ${request.email}');
      
      // Validate request
      final validation = _validateAuthRequest(request);
      if (!validation.isValid) {
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock authentication logic
      if (request.email == 'user@bel247.com' && request.password == 'password123') {
        final now = DateTime.now();
        final accessTokenExpiry = now.add(const Duration(minutes: 15));
        final refreshTokenExpiry = now.add(const Duration(days: 7));

        final userSession = UserSession(
          userId: 'user_001',
          email: request.email,
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

        Logger.info('Login successful for user: ${request.email}');
        return ApiResponse.success(authResponse);
      } else {
        Logger.warning('Login failed for user: ${request.email}');
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

    if (request.email.isEmpty) {
      errors.add('Email is required');
      fieldErrors['email'] = 'Email is required';
    } else if (!_isValidEmail(request.email)) {
      errors.add('Invalid email format');
      fieldErrors['email'] = 'Invalid email format';
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
