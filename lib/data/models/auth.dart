import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

/// Authentication request model for login
@freezed
class AuthRequest with _$AuthRequest {
  const factory AuthRequest({
    required String email,
    required String password,
    @Default(false) bool rememberMe,
  }) = _AuthRequest;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
}

/// Authentication response model containing tokens and user info
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required DateTime expiresAt,
    required UserSession userSession,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Token pair model for managing access and refresh tokens
@freezed
class TokenPair with _$TokenPair {
  const factory TokenPair({
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiresAt,
    required DateTime refreshTokenExpiresAt,
  }) = _TokenPair;

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);
}

/// User session model containing user information and preferences
@freezed
class UserSession with _$UserSession {
  const factory UserSession({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime loginTime,
    required DateTime lastActivity,
    @Default(false) bool isActive,
    @Default({}) Map<String, dynamic> preferences,
  }) = _UserSession;

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}

/// Authentication state model for managing auth status
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,
    UserSession? userSession,
    String? error,
    DateTime? lastRefresh,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}

/// Token refresh request model
@freezed
class TokenRefreshRequest with _$TokenRefreshRequest {
  const factory TokenRefreshRequest({
    required String refreshToken,
    required String userId,
  }) = _TokenRefreshRequest;

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);
}

/// Token refresh response model
@freezed
class TokenRefreshResponse with _$TokenRefreshResponse {
  const factory TokenRefreshResponse({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) = _TokenRefreshResponse;

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseFromJson(json);
}

/// Logout request model
@freezed
class LogoutRequest with _$LogoutRequest {
  const factory LogoutRequest({
    required String userId,
    @Default(false) bool logoutAllDevices,
  }) = _LogoutRequest;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);
}

/// Password change request model
@freezed
class PasswordChangeRequest with _$PasswordChangeRequest {
  const factory PasswordChangeRequest({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) = _PasswordChangeRequest;

  factory PasswordChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangeRequestFromJson(json);
}

/// Authentication validation result
@freezed
class AuthValidationResult with _$AuthValidationResult {
  const factory AuthValidationResult({
    @Default(true) bool isValid,
    @Default([]) List<String> errors,
    @Default({}) Map<String, String> fieldErrors,
  }) = _AuthValidationResult;

  factory AuthValidationResult.fromJson(Map<String, dynamic> json) =>
      _$AuthValidationResultFromJson(json);
}
