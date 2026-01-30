import 'package:bel247_web/data/models/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Authentication Models Tests', () {
    test('AuthRequest should serialize and deserialize correctly', () {
      const request = AuthRequest(
        username: 'test@example.com',
        password: 'password123',
        rememberMe: true,
      );

      final json = request.toJson();
      final fromJson = AuthRequest.fromJson(json);

      expect(fromJson.username, equals(request.username));
      expect(fromJson.password, equals(request.password));
      expect(fromJson.rememberMe, equals(request.rememberMe));
    });

    test('UserSession should serialize and deserialize correctly', () {
      final now = DateTime.now();
      final session = UserSession(
        userId: 'user_001',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        loginTime: now,
        lastActivity: now,
        isActive: true,
        preferences: {'theme': 'light', 'notifications': true},
      );

      final json = session.toJson();
      final fromJson = UserSession.fromJson(json);

      expect(fromJson.userId, equals(session.userId));
      expect(fromJson.email, equals(session.email));
      expect(fromJson.firstName, equals(session.firstName));
      expect(fromJson.lastName, equals(session.lastName));
      expect(fromJson.isActive, equals(session.isActive));
      expect(fromJson.preferences, equals(session.preferences));
    });

    test('TokenPair should serialize and deserialize correctly', () {
      final now = DateTime.now();
      final tokenPair = TokenPair(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
        accessTokenExpiresAt: now.add(const Duration(minutes: 15)),
        refreshTokenExpiresAt: now.add(const Duration(days: 7)),
      );

      final json = tokenPair.toJson();
      final fromJson = TokenPair.fromJson(json);

      expect(fromJson.accessToken, equals(tokenPair.accessToken));
      expect(fromJson.refreshToken, equals(tokenPair.refreshToken));
      expect(fromJson.accessTokenExpiresAt, equals(tokenPair.accessTokenExpiresAt));
      expect(fromJson.refreshTokenExpiresAt, equals(tokenPair.refreshTokenExpiresAt));
    });

    test('TokenRefreshRequest should serialize and deserialize correctly', () {
      const request = TokenRefreshRequest(
        refreshToken: 'refresh_token',
        userId: 'user_001',
      );

      final json = request.toJson();
      final fromJson = TokenRefreshRequest.fromJson(json);

      expect(fromJson.refreshToken, equals(request.refreshToken));
      expect(fromJson.userId, equals(request.userId));
    });

    test('TokenRefreshResponse should serialize and deserialize correctly', () {
      final now = DateTime.now();
      final response = TokenRefreshResponse(
        accessToken: 'new_access_token',
        refreshToken: 'new_refresh_token',
        expiresAt: now.add(const Duration(minutes: 15)),
      );

      final json = response.toJson();
      final fromJson = TokenRefreshResponse.fromJson(json);

      expect(fromJson.accessToken, equals(response.accessToken));
      expect(fromJson.refreshToken, equals(response.refreshToken));
      expect(fromJson.expiresAt, equals(response.expiresAt));
    });

    test('LogoutRequest should serialize and deserialize correctly', () {
      const request = LogoutRequest(
        userId: 'user_001',
        logoutAllDevices: true,
      );

      final json = request.toJson();
      final fromJson = LogoutRequest.fromJson(json);

      expect(fromJson.userId, equals(request.userId));
      expect(fromJson.logoutAllDevices, equals(request.logoutAllDevices));
    });

    test('PasswordChangeRequest should serialize and deserialize correctly', () {
      const request = PasswordChangeRequest(
        currentPassword: 'old_password',
        newPassword: 'new_password',
        confirmPassword: 'new_password',
      );

      final json = request.toJson();
      final fromJson = PasswordChangeRequest.fromJson(json);

      expect(fromJson.currentPassword, equals(request.currentPassword));
      expect(fromJson.newPassword, equals(request.newPassword));
      expect(fromJson.confirmPassword, equals(request.confirmPassword));
    });

    test('AuthValidationResult should serialize and deserialize correctly', () {
      const result = AuthValidationResult(
        isValid: false,
        errors: ['Email is required', 'Password is too short'],
        fieldErrors: {'email': 'Email is required', 'password': 'Password is too short'},
      );

      final json = result.toJson();
      final fromJson = AuthValidationResult.fromJson(json);

      expect(fromJson.isValid, equals(result.isValid));
      expect(fromJson.errors, equals(result.errors));
      expect(fromJson.fieldErrors, equals(result.fieldErrors));
    });

    test('AuthState should create correctly without nested objects', () {
      final authState = AuthState(
        isAuthenticated: true,
        isLoading: false,
        isInitialized: true,
        userSession: null, // Test without nested object
        error: null,
        lastRefresh: DateTime.now(),
      );

      expect(authState.isAuthenticated, isTrue);
      expect(authState.isLoading, isFalse);
      expect(authState.isInitialized, isTrue);
      expect(authState.userSession, isNull);
      expect(authState.error, isNull);
      expect(authState.lastRefresh, isNotNull);
    });
  });
}
