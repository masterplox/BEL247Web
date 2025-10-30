import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/utils/logger.dart';
import '../models/auth.dart';

/// Service for secure storage of authentication tokens and user data
/// Falls back to regular storage on web if secure storage fails
class TokenStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    webOptions: WebOptions(
      dbName: 'bel247_secure_storage',
      publicKey: 'bel247_public_key',
    ),
  );

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userSessionKey = 'user_session';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _refreshTokenExpiryKey = 'refresh_token_expiry';
  static const String _lastRefreshKey = 'last_refresh';

  // Fallback storage for web
  static final Map<String, String> _fallbackStorage = <String, String>{};

  /// Store access token securely
  static Future<void> storeAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
      Logger.info('Access token stored securely');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, using fallback: $e');
      if (kIsWeb) {
        _fallbackStorage[_accessTokenKey] = token;
        Logger.info('Access token stored in fallback storage');
      } else {
        Logger.error('Failed to store access token', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Store refresh token securely
  static Future<void> storeRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
      Logger.info('Refresh token stored securely');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, using fallback: $e');
      if (kIsWeb) {
        _fallbackStorage[_refreshTokenKey] = token;
        Logger.info('Refresh token stored in fallback storage');
      } else {
        Logger.error('Failed to store refresh token', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Store user session securely
  static Future<void> storeUserSession(UserSession session) async {
    try {
      final sessionJson = json.encode(session.toJson());
      await _storage.write(key: _userSessionKey, value: sessionJson);
      Logger.info('User session stored securely');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, using fallback: $e');
      if (kIsWeb) {
        final sessionJson = json.encode(session.toJson());
        _fallbackStorage[_userSessionKey] = sessionJson;
        Logger.info('User session stored in fallback storage');
      } else {
        Logger.error('Failed to store user session', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Store token pair securely
  static Future<void> storeTokenPair(TokenPair tokenPair) async {
    try {
      await Future.wait([
        storeAccessToken(tokenPair.accessToken),
        storeRefreshToken(tokenPair.refreshToken),
        _storage.write(key: _tokenExpiryKey, value: tokenPair.accessTokenExpiresAt.toIso8601String()),
        _storage.write(key: _refreshTokenExpiryKey, value: tokenPair.refreshTokenExpiresAt.toIso8601String()),
      ]);
      Logger.info('Token pair stored securely');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, using fallback: $e');
      if (kIsWeb) {
        _fallbackStorage[_accessTokenKey] = tokenPair.accessToken;
        _fallbackStorage[_refreshTokenKey] = tokenPair.refreshToken;
        _fallbackStorage[_tokenExpiryKey] = tokenPair.accessTokenExpiresAt.toIso8601String();
        _fallbackStorage[_refreshTokenExpiryKey] = tokenPair.refreshTokenExpiresAt.toIso8601String();
        Logger.info('Token pair stored in fallback storage');
      } else {
        Logger.error('Failed to store token pair', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Retrieve token pair (access, refresh, and their expiries)
  static Future<TokenPair?> getTokenPair() async {
    try {
      String? accessToken;
      String? refreshToken;
      String? accessExpiryString;
      String? refreshExpiryString;

      try {
        accessToken = await _storage.read(key: _accessTokenKey);
        refreshToken = await _storage.read(key: _refreshTokenKey);
        accessExpiryString = await _storage.read(key: _tokenExpiryKey);
        refreshExpiryString = await _storage.read(key: _refreshTokenExpiryKey);
      } catch (e) {
        if (kIsWeb) {
          accessToken = _fallbackStorage[_accessTokenKey];
          refreshToken = _fallbackStorage[_refreshTokenKey];
          accessExpiryString = _fallbackStorage[_tokenExpiryKey];
          refreshExpiryString = _fallbackStorage[_refreshTokenExpiryKey];
        } else {
          Logger.warning('Failed to read token pair: $e');
          return null;
        }
      }

      if (accessToken == null || refreshToken == null || accessExpiryString == null || refreshExpiryString == null) {
        return null;
      }

      final accessExpiry = DateTime.tryParse(accessExpiryString);
      final refreshExpiry = DateTime.tryParse(refreshExpiryString);
      if (accessExpiry == null || refreshExpiry == null) {
        return null;
      }

      return TokenPair(
        accessToken: accessToken,
        refreshToken: refreshToken,
        accessTokenExpiresAt: accessExpiry,
        refreshTokenExpiresAt: refreshExpiry,
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to get token pair', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Retrieve last refresh timestamp
  static Future<DateTime?> getLastRefresh() async {
    try {
      String? ts;
      try {
        ts = await _storage.read(key: _lastRefreshKey);
      } catch (e) {
        if (kIsWeb) {
          ts = _fallbackStorage[_lastRefreshKey];
        } else {
          Logger.warning('Failed to read last refresh: $e');
          return null;
        }
      }
      if (ts == null) return null;
      return DateTime.tryParse(ts);
    } catch (e, stackTrace) {
      Logger.error('Failed to get last refresh', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Retrieve access token
  static Future<String?> getAccessToken() async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      if (token != null) {
        Logger.info('Access token retrieved from secure storage');
      }
      return token;
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, trying fallback: $e');
      if (kIsWeb) {
        final token = _fallbackStorage[_accessTokenKey];
        if (token != null) {
          Logger.info('Access token retrieved from fallback storage');
        }
        return token;
      } else {
        Logger.error('Failed to retrieve access token', error: e, stackTrace: stackTrace);
        return null;
      }
    }
  }

  /// Retrieve refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final token = await _storage.read(key: _refreshTokenKey);
      if (token != null) {
        Logger.info('Refresh token retrieved from secure storage');
      }
      return token;
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, trying fallback: $e');
      if (kIsWeb) {
        final token = _fallbackStorage[_refreshTokenKey];
        if (token != null) {
          Logger.info('Refresh token retrieved from fallback storage');
        }
        return token;
      } else {
        Logger.error('Failed to retrieve refresh token', error: e, stackTrace: stackTrace);
        return null;
      }
    }
  }

  /// Retrieve user session
  static Future<UserSession?> getUserSession() async {
    try {
      final sessionJson = await _storage.read(key: _userSessionKey);
      if (sessionJson == null) return null;

      final sessionData = json.decode(sessionJson) as Map<String, dynamic>;
      final session = UserSession.fromJson(sessionData);
      Logger.info('User session retrieved from secure storage');
      return session;
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, trying fallback: $e');
      if (kIsWeb) {
        final sessionJson = _fallbackStorage[_userSessionKey];
        if (sessionJson == null) return null;

        try {
          final sessionData = json.decode(sessionJson) as Map<String, dynamic>;
          final session = UserSession.fromJson(sessionData);
          Logger.info('User session retrieved from fallback storage');
          return session;
        } catch (jsonError) {
          Logger.error('Failed to parse session from fallback storage', error: jsonError);
          return null;
        }
      } else {
        Logger.error('Failed to retrieve user session', error: e, stackTrace: stackTrace);
        return null;
      }
    }
  }

  /// Check if user has valid stored credentials
  static Future<bool> hasValidCredentials() async {
    try {
      Logger.info('Checking for stored credentials...');
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final userSession = await getUserSession();
      
      Logger.info('Stored credentials check - accessToken: ${accessToken != null ? 'exists' : 'null'}, refreshToken: ${refreshToken != null ? 'exists' : 'null'}, userSession: ${userSession != null ? 'exists' : 'null'}');
      
      final hasCredentials = accessToken != null && 
                           refreshToken != null && 
                           userSession != null;
      
      if (hasCredentials) {
        Logger.info('Valid credentials found in secure storage');
      } else {
        Logger.info('No valid credentials found in secure storage');
      }
      return hasCredentials;
    } catch (e, stackTrace) {
      Logger.error('Failed to check credentials validity', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Clear all stored authentication data
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      Logger.info('All authentication data cleared from secure storage');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage clear failed, clearing fallback: $e');
      if (kIsWeb) {
        _fallbackStorage.clear();
        Logger.info('All authentication data cleared from fallback storage');
      } else {
        Logger.error('Failed to clear authentication tokens', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Clear only tokens (access and refresh) but keep user session
  static Future<void> clearTokens() async {
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _refreshTokenKey),
        _storage.delete(key: _tokenExpiryKey),
        _storage.delete(key: _refreshTokenExpiryKey),
        _storage.delete(key: _lastRefreshKey),
      ]);
      Logger.info('Tokens cleared from secure storage');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage clear failed, clearing fallback: $e');
      if (kIsWeb) {
        _fallbackStorage.remove(_accessTokenKey);
        _fallbackStorage.remove(_refreshTokenKey);
        _fallbackStorage.remove(_tokenExpiryKey);
        _fallbackStorage.remove(_refreshTokenExpiryKey);
        _fallbackStorage.remove(_lastRefreshKey);
        Logger.info('Tokens cleared from fallback storage');
      } else {
        Logger.error('Failed to clear tokens', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Check if access token is expired
  static Future<bool> isAccessTokenExpired() async {
    try {
      String? expiryString;
      try {
        expiryString = await _storage.read(key: _tokenExpiryKey);
      } catch (e) {
        if (kIsWeb) {
          expiryString = _fallbackStorage[_tokenExpiryKey];
        } else {
          Logger.warning('Failed to read access token expiry: $e');
          return true; // Assume expired if we can't read it
        }
      }

      if (expiryString == null) {
        Logger.info('No access token expiry found, assuming expired');
        return true;
      }

      final expiry = DateTime.parse(expiryString);
      final isExpired = DateTime.now().isAfter(expiry);
      Logger.info('Access token expiry check: $isExpired (expires at: $expiry)');
      return isExpired;
    } catch (e, stackTrace) {
      Logger.error('Failed to check access token expiry', error: e, stackTrace: stackTrace);
      return true; // Assume expired on error
    }
  }

  /// Check if refresh token is expired
  static Future<bool> isRefreshTokenExpired() async {
    try {
      String? expiryString;
      try {
        expiryString = await _storage.read(key: _refreshTokenExpiryKey);
      } catch (e) {
        if (kIsWeb) {
          expiryString = _fallbackStorage[_refreshTokenExpiryKey];
        } else {
          Logger.warning('Failed to read refresh token expiry: $e');
          return true; // Assume expired if we can't read it
        }
      }

      if (expiryString == null) {
        Logger.info('No refresh token expiry found, assuming expired');
        return true;
      }

      final expiry = DateTime.parse(expiryString);
      final isExpired = DateTime.now().isAfter(expiry);
      Logger.info('Refresh token expiry check: $isExpired (expires at: $expiry)');
      return isExpired;
    } catch (e, stackTrace) {
      Logger.error('Failed to check refresh token expiry', error: e, stackTrace: stackTrace);
      return true; // Assume expired on error
    }
  }

  /// Update last refresh timestamp
  static Future<void> updateLastRefresh() async {
    try {
      await _storage.write(
        key: _lastRefreshKey,
        value: DateTime.now().toIso8601String(),
      );
      Logger.info('Last refresh timestamp updated');
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, using fallback: $e');
      if (kIsWeb) {
        _fallbackStorage[_lastRefreshKey] = DateTime.now().toIso8601String();
        Logger.info('Last refresh timestamp updated in fallback storage');
      } else {
        Logger.error('Failed to update last refresh timestamp', error: e, stackTrace: stackTrace);
        rethrow;
      }
    }
  }

  /// Get all stored keys (for debugging)
  static Future<Map<String, String>> getAllKeys() async {
    try {
      return await _storage.readAll();
    } catch (e, stackTrace) {
      Logger.warning('Secure storage failed, returning fallback: $e');
      if (kIsWeb) {
        return Map.from(_fallbackStorage);
      } else {
        Logger.error('Failed to read all keys', error: e, stackTrace: stackTrace);
        return {};
      }
    }
  }
}