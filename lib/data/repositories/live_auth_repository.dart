import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../core/config/new_features_dev_mock.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../models/api_response_dtos.dart';
import '../models/auth.dart';
import '../models/password_code_api_json.dart';
import '../services/api_client.dart';
import '../services/token_storage_service.dart';
import 'auth_repository.dart';
// Conditional import for web platform
import 'live_auth_repository_web_stub.dart'
    if (dart.library.html) 'live_auth_repository_web.dart' as web;

/// Live implementation of authentication repository that calls real API
class LiveAuthRepository implements AuthRepository {
  LiveAuthRepository([ApiClient? apiClient]) : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  @override
  Future<ApiResponse<AuthResponse>> login(AuthRequest request) async {
    try {
      Logger.info('Attempting login for user: ${request.username}');

      // Validate request
      final validation = _validateAuthRequest(request);
      if (!validation.isValid) {
        return ApiResponse.error(
          'Validation failed: ${validation.errors.join(', ')}',
        );
      }

      // Get browser information and IP address
      // Note: IP lookup may fail due to CORS - this is handled gracefully
      final deviceModel = await _detectBrowser();
      final deviceUUID = await _getUserIPAddress();
      Logger.info('Device Info - Model: $deviceModel, UUID: $deviceUUID', tag: 'Login');

      // Prepare request body according to API specification
      // API expects: { Username, Password, DeviceUUID, PlatformType, DeviceModel }
      final requestBody = {
        'Username': request.username,
        'Password': request.password,
        'DeviceUUID': deviceUUID,
        'PlatformType': 'Web',
        'DeviceModel': deviceModel,
      };

      // Make API call - login is NOT authenticated (no Bearer token needed)
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: requestBody,
        authenticated: false, // Login doesn't require authentication
      );

      // Check response status
      if (response.statusCode != 200) {
        Logger.warning('Login failed with status: ${response.statusCode}');
        final message = response.data?['message'] as String? ?? 'Login failed';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      // Parse API response using DTO
      final loginResponse = LoginResponseDto.fromJson(data);

      if (loginResponse.status != 200) {
        Logger.warning('Login failed: ${loginResponse.message}');
        return ApiResponse.error(loginResponse.message ?? 'Login failed');
      }

      final userDto = loginResponse.user;
      final token = userDto.token;
      final userId = userDto.id;
      final email = userDto.email;

      if (token.isEmpty || userId.isEmpty || email == null || email.isEmpty) {
        Logger.warning('Missing required fields in login response');
        return ApiResponse.error('Invalid response format');
      }

      // Parse JWT to extract expiration (if possible)
      DateTime? tokenExpiration;
      try {
        final parts = token.split('.');
        if (parts.length >= 2) {
          // Decode JWT payload (base64url)
          final payload = parts[1];
          // Add padding if needed for base64url decode
          String padded = payload;
          final remainder = payload.length % 4;
          if (remainder != 0) {
            padded += '=' * (4 - remainder);
          }
          // Replace URL-safe characters with standard base64 characters
          final base64 = padded.replaceAll('-', '+').replaceAll('_', '/');
          final decoded = utf8.decode(base64Decode(base64));
          final payloadJson = jsonDecode(decoded) as Map<String, dynamic>;
          final exp = payloadJson['exp'] as int?;
          if (exp != null) {
            // JWT exp is in seconds, DateTime.fromMillisecondsSinceEpoch expects milliseconds
            tokenExpiration = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
          }
        }
      } catch (e) {
        Logger.warning('Failed to parse JWT expiration, using default: $e');
      }

      // Use default expiration if couldn't parse from JWT (15 minutes from now)
      final now = DateTime.now();
      final accessTokenExpiry = tokenExpiration ?? now.add(const Duration(minutes: 15));
      // Refresh token expires in 7 days (default)
      final refreshTokenExpiry = now.add(const Duration(days: 7));

      // Extract user name (try firstName/lastName or use username)
      final String? customerName = userDto.customerName;
      final String? firstNameFromCustomer = customerName?.split(' ').first;
      final String? lastNameFromCustomer = customerName?.split(' ').skip(1).join(' ');
      final String firstNameFromUsername = userDto.username.split(' ').first;
      final String lastNameFromUsername = userDto.username.split(' ').skip(1).join(' ');
      
      // Prefer names from customerName when available, otherwise fall back to username parts.
      final String firstName = firstNameFromCustomer ?? firstNameFromUsername;
      final String lastName = lastNameFromCustomer ?? lastNameFromUsername;

      // Create user session
      final userSession = UserSession(
        userId: userId,
        email: email,
        firstName: firstName.isNotEmpty ? firstName : 'User',
        lastName: lastName.isNotEmpty ? lastName : '',
        loginTime: now,
        lastActivity: now,
        isActive: !userDto.sessionExpired,
        preferences: {
          'username': userDto.username,
          'loggedIn': userDto.loggedIn,
          'identified': userDto.identified,
          'connected': userDto.connected,
        },
      );

      // Create auth response
      // Note: API only returns one token, we use it as both access and refresh token
      // In a real implementation, the refresh token would come separately
      final authResponse = AuthResponse(
        accessToken: token,
        refreshToken: token, // API doesn't provide separate refresh token, using same token
        userId: userId,
        expiresAt: accessTokenExpiry,
        userSession: userSession,
      );

      // Store tokens and session
      await TokenStorageService.storeTokenPair(
        TokenPair(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          accessTokenExpiresAt: accessTokenExpiry,
          refreshTokenExpiresAt: refreshTokenExpiry,
        ),
      );
      await TokenStorageService.storeUserSession(userSession);
      await TokenStorageService.updateLastRefresh();

      Logger.info('Login successful for user: ${request.username}');
      return ApiResponse.success(authResponse);
    } on DioException catch (e, stackTrace) {
      Logger.error('Login API error', error: e, stackTrace: stackTrace);
      final errorMessage = _extractErrorMessage(e);
      return ApiResponse.error(
        errorMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (e, stackTrace) {
      Logger.error('Login error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> logout(LogoutRequest request) async {
    try {
      Logger.info('Logging out user: ${request.userId}');

      // Make API call - logout requires authentication
      await _apiClient.post<void>(
        ApiEndpoints.logout,
        data: {
          'userId': request.userId,
          'logoutAllDevices': request.logoutAllDevices,
        },
        authenticated: true, // Logout requires authentication
      );

      // Clear stored authentication data
      if (request.logoutAllDevices) {
        await TokenStorageService.clearAll();
      } else {
        await TokenStorageService.clearTokens();
      }

      Logger.info('Logout successful for user: ${request.userId}');
      return ApiResponse.success(null);
    } on DioException catch (e, stackTrace) {
      Logger.error('Logout API error', error: e, stackTrace: stackTrace);
      // Even if API call fails, clear local tokens
      await TokenStorageService.clearTokens();
      final errorMessage = _extractErrorMessage(e);
      return ApiResponse.error(
        errorMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (e, stackTrace) {
      Logger.error('Logout error', error: e, stackTrace: stackTrace);
      // Even if error occurs, clear local tokens
      await TokenStorageService.clearTokens();
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

      // Make API call
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        authenticated: false, // Token refresh doesn't require auth
        data: {
          'refreshToken': request.refreshToken,
          'userId': request.userId,
        },
      );

      final data = response.data;
      if (data == null || response.statusCode != 200) {
        return ApiResponse.error('Token refresh failed');
      }

      // Parse response (adjust based on actual API response format)
      final token = data['token'] as String? ?? data['accessToken'] as String?;
      final refreshToken = data['refreshToken'] as String? ?? token;
      
      if (token == null) {
        return ApiResponse.error('Invalid refresh response');
      }

      // Parse expiration from token if possible
      DateTime? tokenExpiration;
      try {
        final parts = token.split('.');
        if (parts.length >= 2) {
          final payload = parts[1];
          // Add padding if needed for base64url decode
          String padded = payload;
          final remainder = payload.length % 4;
          if (remainder != 0) {
            padded += '=' * (4 - remainder);
          }
          // Replace URL-safe characters with standard base64 characters
          final base64 = padded.replaceAll('-', '+').replaceAll('_', '/');
          final decoded = utf8.decode(base64Decode(base64));
          final payloadJson = jsonDecode(decoded) as Map<String, dynamic>;
          final exp = payloadJson['exp'] as int?;
          if (exp != null) {
            tokenExpiration = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
          }
        }
      } catch (e) {
        Logger.warning('Failed to parse JWT expiration: $e');
      }

      final expiresAt = tokenExpiration ?? DateTime.now().add(const Duration(minutes: 15));

      final tokenResponse = TokenRefreshResponse(
        accessToken: token,
        refreshToken: refreshToken ?? token,
        expiresAt: expiresAt,
      );

      // Store new tokens
      await TokenStorageService.storeTokenPair(TokenPair(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
        accessTokenExpiresAt: expiresAt,
        refreshTokenExpiresAt: DateTime.now().add(const Duration(days: 7)),
      ));
      await TokenStorageService.updateLastRefresh();

      Logger.info('Token refresh successful for user: ${request.userId}');
      return ApiResponse.success(tokenResponse);
    } on DioException catch (e, stackTrace) {
      Logger.error('Token refresh API error', error: e, stackTrace: stackTrace);
      final errorMessage = _extractErrorMessage(e);
      return ApiResponse.error(
        errorMessage,
        statusCode: e.response?.statusCode,
      );
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
    // TODO: Implement when API endpoint is available
    return ApiResponse.error('Not implemented yet');
  }

  @override
  Future<ApiResponse<void>> sendOtp(OtpSendRequest request) async {
    final isEmail = request.contact.contains('@');
    return requestPasswordCode(
      PasswordCodeRequest(
        mobileNumber: isEmail ? null : request.contact,
        email: isEmail ? request.contact : null,
      ),
      authenticated: false,
    );
  }

  @override
  Future<ApiResponse<void>> requestPasswordCode(
    PasswordCodeRequest request, {
    required bool authenticated,
  }) async {
    try {
      if (!isValidPasswordCodeRequest(request)) {
        return ApiResponse.error(
          'Provide exactly one of mobile number, email, or username',
        );
      }

      final mock = await _interceptPasswordCodeMock(authenticated);
      if (mock != null) {
        return mock;
      }

      final endpoint = authenticated
          ? ApiEndpoints.passwordCodeAuthenticated
          : ApiEndpoints.passwordCodePublic;

      Logger.info(
        'Requesting password code (authenticated=$authenticated)',
      );

      final response = await _apiClient.post<Map<String, dynamic>>(
        endpoint,
        data: passwordCodeRequestToApiJson(request),
        authenticated: authenticated,
      );

      if (response.statusCode != 200) {
        final message =
            response.data?['message'] as String? ?? 'Failed to send verification code';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      final dto = MessageResponseDto.fromJson(data);
      if (dto.status != 200) {
        return ApiResponse.error(
          dto.message ?? 'Failed to send verification code',
        );
      }

      Logger.info('Password code sent successfully');
      return ApiResponse.success(null);
    } on DioException catch (e, stackTrace) {
      Logger.error('Password code API error', error: e, stackTrace: stackTrace);
      return ApiResponse.error(_extractErrorMessage(e));
    } catch (e, stackTrace) {
      Logger.error('Password code error', error: e, stackTrace: stackTrace);
      return ApiResponse.error(
        'Failed to send verification code: ${ErrorHandler.getErrorMessage(e)}',
      );
    }
  }

  @override
  Future<ApiResponse<void>> verifyOtp(OtpVerifyRequest request) async {
    // TODO: Implement when API endpoint is available
    return ApiResponse.error('Not implemented yet');
  }

  @override
  Future<ApiResponse<void>> signUpStep1(SignUpStep1Request request) async {
    try {
      Logger.info('Sign up Step 1 - Delivering OTP');
      Logger.info('MobileNumber: ${request.mobileNumber ?? 'null'}, Email: ${request.email ?? 'null'}, Username: ${request.username ?? 'null'}');

      // Validate that at least one contact method is provided
      if (request.mobileNumber == null && request.email == null) {
        return ApiResponse.error('Either mobile number or email is required');
      }

      // Prepare request body
      final requestBody = <String, dynamic>{};
      if (request.mobileNumber != null) {
        requestBody['MobileNumber'] = request.mobileNumber;
      }
      if (request.email != null) {
        requestBody['Email'] = request.email;
      }
      if (request.username != null) {
        requestBody['Username'] = request.username;
      }

      // Make API call - not authenticated
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.signUpStep1,
        data: requestBody,
        authenticated: false,
      );

      // Check response status
      if (response.statusCode != 200) {
        Logger.warning('Sign up Step 1 failed with status: ${response.statusCode}');
        final message = response.data?['message'] as String? ?? 'Failed to send OTP';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      // Parse API response
      final step1Response = MessageResponseDto.fromJson(data);

      if (step1Response.status != 200) {
        Logger.warning('Sign up Step 1 failed: ${step1Response.message}');
        return ApiResponse.error(step1Response.message ?? 'Failed to send OTP');
      }

      Logger.info('Sign up Step 1 successful - OTP sent');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 1 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to send OTP: ${ErrorHandler.getErrorMessage(e)}');
    }
  }

  @override
  Future<ApiResponse<String>> signUpStep2(SignUpStep2Request request) async {
    try {
      Logger.info('Sign up Step 2 - Activating device with OTP');
      Logger.info('Code: ${request.code}, PhoneNumber: ${request.phoneNumber ?? 'null'}, Email: ${request.email ?? 'null'}');

      // Validate that at least one contact method is provided
      if (request.phoneNumber == null && request.email == null) {
        return ApiResponse.error('Either phone number or email is required');
      }

      if (request.code.isEmpty) {
        return ApiResponse.error('Verification code is required');
      }

      // Prepare request body
      final requestBody = <String, dynamic>{
        'Code': request.code,
      };
      if (request.phoneNumber != null) {
        requestBody['PhoneNumber'] = request.phoneNumber;
      }
      if (request.email != null) {
        requestBody['Email'] = request.email;
      }

      // Make API call - not authenticated
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.signUpStep2,
        data: requestBody,
        authenticated: false,
      );

      // Check response status
      if (response.statusCode != 200) {
        Logger.warning('Sign up Step 2 failed with status: ${response.statusCode}');
        final message = response.data?['message'] as String? ?? 'Failed to verify OTP';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      // Parse API response - Step 2 should return GuestUUID
      // The response structure may vary, but typically it's in a 'guestUUID' or 'id' field
      final step2Response = MessageResponseDto.fromJson(data);

      if (step2Response.status != 200) {
        Logger.warning('Sign up Step 2 failed: ${step2Response.message}');
        return ApiResponse.error(step2Response.message ?? 'Failed to verify OTP');
      }

      // Extract GuestUUID from response
      // The API might return it in different formats, so we check multiple possibilities
      String? guestUUID;
      if (data.containsKey('guestUUID')) {
        guestUUID = data['guestUUID'] as String?;
      } else if (data.containsKey('GuestUUID')) {
        guestUUID = data['GuestUUID'] as String?;
      } else if (data.containsKey('id')) {
        guestUUID = data['id'] as String?;
      } else if (data.containsKey('Id')) {
        guestUUID = data['Id'] as String?;
      }

      if (guestUUID == null || guestUUID.isEmpty) {
        Logger.warning('GuestUUID not found in Step 2 response');
        // Some APIs might not return GuestUUID in Step 2, we'll handle this gracefully
        // For now, we'll use a placeholder or check if it's returned in Step 3
        guestUUID = ''; // Will need to be handled based on actual API response
      }

      Logger.info('Sign up Step 2 successful - GuestUUID: $guestUUID');
      return ApiResponse.success(guestUUID);
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 2 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to verify OTP: ${ErrorHandler.getErrorMessage(e)}');
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> signUpStep3(SignUpStep3Request request) async {
    try {
      Logger.info('Sign up Step 3 - Registering user');
      Logger.info('Username: ${request.username}, Email: ${request.email ?? 'null'}, MobileNumber: ${request.mobileNumber ?? 'null'}, GuestUUID: ${request.guestUUID}');

      // Validate request
      if (request.username.isEmpty) {
        return ApiResponse.error('Username is required');
      }
      if (request.password.isEmpty) {
        return ApiResponse.error('Password is required');
      }

      // Get browser information and IP address
      final deviceModel = await _detectBrowser();
      final deviceUUID = await _getUserIPAddress();
      Logger.info('Device Info - Model: $deviceModel, UUID: $deviceUUID', tag: 'SignUpStep3');

      // Prepare request body
      // GuestUUID can be empty/blank - send empty string if not provided
      final requestBody = <String, dynamic>{
        'Username': request.username,
        'Password': request.password,
        'GuestUUID': request.guestUUID.isEmpty ? '' : request.guestUUID,
      };
      if (request.email != null) {
        requestBody['Email'] = request.email;
      }
      if (request.mobileNumber != null) {
        requestBody['MobileNumber'] = request.mobileNumber;
      }

      // Make API call - not authenticated
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.signUpStep3,
        data: requestBody,
        authenticated: false,
      );

      // Check response status
      if (response.statusCode != 200) {
        Logger.warning('Sign up Step 3 failed with status: ${response.statusCode}');
        final message = response.data?['message'] as String? ?? 'Registration failed';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      // Parse API response using DTO (same structure as login)
      final registerResponse = RegisterResponseDto.fromJson(data);

      if (registerResponse.status != 200) {
        Logger.warning('Sign up Step 3 failed: ${registerResponse.message}');
        return ApiResponse.error(registerResponse.message ?? 'Registration failed');
      }

      final userDto = registerResponse.user;
      final token = userDto.token;
      final userId = userDto.id;
      final email = userDto.email ?? request.email ?? '';

      if (token.isEmpty || userId.isEmpty) {
        Logger.warning('Missing required fields in registration response');
        return ApiResponse.error('Invalid response format');
      }

      // Parse JWT to extract expiration (same as login)
      DateTime? tokenExpiration;
      try {
        final parts = token.split('.');
        if (parts.length >= 2) {
          final payload = parts[1];
          String padded = payload;
          final remainder = payload.length % 4;
          if (remainder != 0) {
            padded += '=' * (4 - remainder);
          }
          final base64 = padded.replaceAll('-', '+').replaceAll('_', '/');
          final decoded = utf8.decode(base64Decode(base64));
          final payloadJson = jsonDecode(decoded) as Map<String, dynamic>;
          final exp = payloadJson['exp'] as int?;
          if (exp != null) {
            tokenExpiration = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
          }
        }
      } catch (e) {
        Logger.warning('Failed to parse JWT expiration, using default: $e');
      }

      final now = DateTime.now();
      final accessTokenExpiry = tokenExpiration ?? now.add(const Duration(minutes: 15));
      final refreshTokenExpiry = now.add(const Duration(days: 7));

      // Extract user name
      final String? customerName = userDto.customerName;
      final String? firstNameFromCustomer = customerName?.split(' ').first;
      final String? lastNameFromCustomer = customerName?.split(' ').skip(1).join(' ');
      final String firstNameFromUsername = userDto.username.split(' ').first;
      final String lastNameFromUsername = userDto.username.split(' ').skip(1).join(' ');
      
      final String firstName = firstNameFromCustomer ?? firstNameFromUsername;
      final String lastName = lastNameFromCustomer ?? lastNameFromUsername;

      // Create user session
      final userSession = UserSession(
        userId: userId,
        email: email.isNotEmpty ? email : (request.email ?? ''),
        firstName: firstName.isNotEmpty ? firstName : 'User',
        lastName: lastName.isNotEmpty ? lastName : '',
        loginTime: now,
        lastActivity: now,
        isActive: !userDto.sessionExpired,
        preferences: {
          'username': userDto.username,
          'loggedIn': userDto.loggedIn,
          'identified': userDto.identified,
          'connected': userDto.connected,
        },
      );

      // Create auth response
      final authResponse = AuthResponse(
        accessToken: token,
        refreshToken: token, // API doesn't provide separate refresh token
        userId: userId,
        expiresAt: accessTokenExpiry,
        userSession: userSession,
      );

      // Store tokens and session
      await TokenStorageService.storeTokenPair(
        TokenPair(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          accessTokenExpiresAt: accessTokenExpiry,
          refreshTokenExpiresAt: refreshTokenExpiry,
        ),
      );
      await TokenStorageService.storeUserSession(userSession);
      await TokenStorageService.updateLastRefresh();

      Logger.info('Sign up Step 3 successful - User registered: $email');
      return ApiResponse.success(authResponse);
    } catch (e, stackTrace) {
      Logger.error('Sign up Step 3 error', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Registration failed: ${ErrorHandler.getErrorMessage(e)}');
    }
  }

  @override
  Future<ApiResponse<AuthResponse>> signup(SignUpRequest request) async {
    // TODO: Implement when API endpoint is available
    return ApiResponse.error('Not implemented yet');
  }

  @override
  Future<ApiResponse<void>> resetPassword(PasswordResetRequest request) async {
    if (request.newPassword != request.confirmPassword) {
      return ApiResponse.error('Passwords do not match');
    }
    return resetDevicePassword(
      DevicePasswordResetRequest(
        username: request.phone,
        password: request.newPassword,
        passwordCode: request.otp,
      ),
      authenticated: false,
    );
  }

  @override
  Future<ApiResponse<void>> resetDevicePassword(
    DevicePasswordResetRequest request, {
    required bool authenticated,
  }) async {
    try {
      if (request.username.trim().isEmpty) {
        return ApiResponse.error('Username is required');
      }
      if (request.password.isEmpty) {
        return ApiResponse.error('Password is required');
      }
      if (request.passwordCode.trim().isEmpty) {
        return ApiResponse.error('Verification code is required');
      }

      final mock = await _interceptPasswordResetMock(authenticated);
      if (mock != null) {
        return mock;
      }

      final endpoint = authenticated
          ? ApiEndpoints.resetPasswordAuthenticated
          : ApiEndpoints.resetPasswordPublic;

      final response = await _apiClient.post<Map<String, dynamic>>(
        endpoint,
        data: <String, dynamic>{
          'Username': request.username,
          'Password': request.password,
          'PasswordCode': request.passwordCode,
        },
        authenticated: authenticated,
      );

      if (response.statusCode != 200) {
        final message =
            response.data?['message'] as String? ?? 'Password reset failed';
        return ApiResponse.error(message, statusCode: response.statusCode);
      }

      final data = response.data;
      if (data == null) {
        return ApiResponse.error('Invalid response from server');
      }

      final dto = MessageResponseDto.fromJson(data);
      if (dto.status != 200) {
        return ApiResponse.error(dto.message ?? 'Password reset failed');
      }

      Logger.info('Device password reset successful');
      return ApiResponse.success(null);
    } on DioException catch (e, stackTrace) {
      Logger.error('Password reset API error', error: e, stackTrace: stackTrace);
      return ApiResponse.error(_extractErrorMessage(e));
    } catch (e, stackTrace) {
      Logger.error('Password reset error', error: e, stackTrace: stackTrace);
      return ApiResponse.error(
        'Password reset failed: ${ErrorHandler.getErrorMessage(e)}',
      );
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

  @override
  Future<T> handleResponse<T>(
    Future<Response> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await apiCall();
      if (response.statusCode == 200) {
        return fromJson(response.data as Map<String, dynamic>);
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

  Future<ApiResponse<void>?> _interceptPasswordCodeMock(bool authenticated) async {
    if (!NewFeaturesDevMock.isActive) {
      return null;
    }
    await NewFeaturesDevMock.simulatedDelay();
    final label = authenticated
        ? 'DeviceSession/V5/Devices/PasswordCode'
        : 'General/V5/Devices/PasswordCode';
    return NewFeaturesDevMock.intercept<ApiResponse<void>>(
      operation: label,
      onSuccess: () => ApiResponse.success(null),
      onFailure: ApiResponse.error,
      failureMessage:
          '[Dev mock] Failed to send verification code. Invalid contact or user not found.',
    );
  }

  Future<ApiResponse<void>?> _interceptPasswordResetMock(bool authenticated) async {
    if (!NewFeaturesDevMock.isActive) {
      return null;
    }
    await NewFeaturesDevMock.simulatedDelay();
    final label = authenticated
        ? 'DeviceSession/V2/Devices/Password'
        : 'General/V2/Devices/Password';
    return NewFeaturesDevMock.intercept<ApiResponse<void>>(
      operation: label,
      onSuccess: () => ApiResponse.success(null),
      onFailure: ApiResponse.error,
      failureMessage:
          '[Dev mock] Password reset failed. Check username, code, or password rules.',
    );
  }

  /// Extract error message from DioException
  String _extractErrorMessage(DioException error) {
    if (error.response?.data is Map<String, dynamic>) {
      final data = error.response!.data as Map<String, dynamic>;
      return data['message'] as String? ??
          data['error'] as String? ??
          error.message ??
          'Request failed';
    }
    if (error.response?.data is String) {
      return error.response!.data as String;
    }
    return error.message ?? 'Request failed';
  }

  /// Detect browser name from user agent
  Future<String> _detectBrowser() async {
    if (!kIsWeb) {
      return 'Web';
    }

    try {
      // Use dynamic to handle conditional import for dart:html
      final userAgent = _getUserAgent();
      
      if (userAgent.contains('firefox')) {
        // Extract Firefox version if available
        final versionMatch = RegExp(r'firefox[\/\s](\d+)').firstMatch(userAgent);
        final version = versionMatch?.group(1) ?? '';
        return version.isNotEmpty ? 'Firefox $version' : 'Firefox';
      } else if (userAgent.contains('chrome') && !userAgent.contains('edg')) {
        // Chrome (but not Edge)
        final versionMatch = RegExp(r'chrome[\/\s](\d+)').firstMatch(userAgent);
        final version = versionMatch?.group(1) ?? '';
        return version.isNotEmpty ? 'Chrome $version' : 'Chrome';
      } else if (userAgent.contains('safari') && !userAgent.contains('chrome')) {
        // Safari (but not Chrome)
        final versionMatch = RegExp(r'version[\/\s](\d+)').firstMatch(userAgent);
        final version = versionMatch?.group(1) ?? '';
        return version.isNotEmpty ? 'Safari $version' : 'Safari';
      } else if (userAgent.contains('edg')) {
        // Edge
        final versionMatch = RegExp(r'edg[\/\s](\d+)').firstMatch(userAgent);
        final version = versionMatch?.group(1) ?? '';
        return version.isNotEmpty ? 'Edge $version' : 'Edge';
      } else if (userAgent.contains('opera') || userAgent.contains('opr')) {
        // Opera
        final versionMatch = RegExp(r'(?:opera|opr)[\/\s](\d+)').firstMatch(userAgent);
        final version = versionMatch?.group(1) ?? '';
        return version.isNotEmpty ? 'Opera $version' : 'Opera';
      } else {
        // Unknown browser
        return 'Web';
      }
    } catch (e) {
      Logger.warning('Failed to detect browser: $e');
      return 'Web';
    }
  }

  /// Get user agent string (web only)
  String _getUserAgent() {
    if (!kIsWeb) {
      return '';
    }
    
    try {
      // Use dart:html for web platform
      // This is safe because we check kIsWeb first
      // For non-web builds, this code won't be compiled
      return _getUserAgentWeb();
    } catch (e) {
      Logger.warning('Failed to get user agent: $e');
      return '';
    }
  }

  /// Get user agent on web platform
  String _getUserAgentWeb() {
    // Conditional import handles platform-specific code
    return web.getUserAgent();
  }

  /// Get user's IP address using external service
  /// Returns 'unknown' if all services fail (e.g., due to CORS)
  /// Note: Uses Dio directly for external URLs (not our API base URL)
  Future<String> _getUserIPAddress() async {
    try {
      // Try to get IP from ipify service (simple and reliable)
      // Note: This may fail due to CORS in web browsers - that's OK, we have fallback
      // Using Dio directly for external service (not our API)
      final dio = Dio();
      final response = await dio.get<String>(
        'https://api.ipify.org',
        options: Options(
          headers: {'Accept': 'text/plain'},
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200 && response.data != null && response.data!.isNotEmpty) {
        Logger.info('User IP address retrieved: ${response.data}', tag: 'IPLookup');
        return response.data!.trim();
      }

      Logger.warning('Failed to retrieve IP address from ipify - status: ${response.statusCode}', tag: 'IPLookup');
      return 'unknown';
    } catch (e) {
      // CORS errors or network failures are expected in web browsers
      final errorMsg = e.toString();
      final isCorsError = errorMsg.toLowerCase().contains('cors') || 
                          errorMsg.toLowerCase().contains('access-control');
      
      if (isCorsError) {
        Logger.warning(
          'IP lookup blocked by CORS (expected in web). Using fallback: unknown',
          tag: 'IPLookup',
        );
      } else {
        Logger.warning('Failed to get user IP address: $e. Using fallback.', tag: 'IPLookup');
      }
      
      // Fallback: try alternative service (also likely to fail due to CORS, but worth trying)
      try {
        final dio = Dio();
        final response = await dio.get<String>(
          'https://ipapi.co/ip/',
          options: Options(
            headers: {'Accept': 'text/plain'},
            responseType: ResponseType.plain,
          ),
        );

        if (response.statusCode == 200 && response.data != null && response.data!.isNotEmpty) {
          Logger.info('User IP address retrieved from fallback: ${response.data}', tag: 'IPLookup');
          return response.data!.trim();
        }
      } catch (e2) {
        Logger.warning('Fallback IP service also failed: $e2', tag: 'IPLookup');
      }

      // Last resort: return 'unknown' - this won't block login
      // The API should accept 'unknown' as a valid DeviceUUID
      Logger.info('Using default DeviceUUID: unknown (IP lookup unavailable)', tag: 'IPLookup');
      return 'unknown';
    }
  }
}
