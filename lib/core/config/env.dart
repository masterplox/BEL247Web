class EnvConfig {

  // String values from --dart-define (compile-time). Empty = use default (fixes deployed builds when env not passed).
  static String get apiBaseUrl {
    const value = String.fromEnvironment('API_BASE_URL', defaultValue: '');
    if (value.isEmpty) return 'https://m.bel.com.bz/MobileApisTest';
    return value;
  }

  static String get mockApiBaseUrl {
    const value = String.fromEnvironment('MOCK_API_BASE_URL', defaultValue: '');
    if (value.isEmpty) return 'mock://data';
    return value;
  }

  static String get prodApiBaseUrl {
    const value = String.fromEnvironment('PROD_API_BASE_URL', defaultValue: '');
    if (value.isEmpty) return 'https://api.bel247.com/v1';
    return value;
  }

  /// Mock flags are hard-disabled – app always uses real APIs now.
  static bool get useMockApi => false;

  /// AMI mock flag is also hard-disabled – AMI always uses live APIs.
  static bool get useMockAmiUsage => false;

  static String get encryptionKey {
    const key = String.fromEnvironment('ENCRYPTION_KEY');
    // If not provided via --dart-define, use default value
    return key.isEmpty ? 'bel247_encryption_key_32_chars' : key;
  }

  // Support both ENVIRONMENT and APP_ENV (Dockerfile passes APP_ENV)
  static String get environment {
    const env = String.fromEnvironment('ENVIRONMENT');
    if (env.isNotEmpty) return env;
    return const String.fromEnvironment('APP_ENV', defaultValue: 'development');
  }

  static int get jwtAccessTokenDuration {
    const raw = String.fromEnvironment('JWT_ACCESS_TOKEN_DURATION', defaultValue: '15');
    return int.tryParse(raw) ?? 15;
  }

  static int get jwtRefreshTokenDuration {
    const raw = String.fromEnvironment('JWT_REFRESH_TOKEN_DURATION', defaultValue: '10080');
    return int.tryParse(raw) ?? 10080;
  }

  static String get appName => const String.fromEnvironment(
        'APP_NAME',
        defaultValue: 'BEL247 WebApp',
      );

  static String get appVersion => const String.fromEnvironment(
        'APP_VERSION',
        defaultValue: '1.0.0',
      );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  /// Effective API base URL: runtime override (e.g. from Render env) if set, else compile-time config.
  static String get currentApiUrl => apiBaseUrl;
}
