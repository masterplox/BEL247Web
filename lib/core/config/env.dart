class EnvConfig {
  // String values from --dart-define (compile-time). Defaults preserved for local/dev.
  static String get apiBaseUrl => const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://m.bel.com.bz/MobileApisTest',
      );

  static String get mockApiBaseUrl => const String.fromEnvironment(
        'MOCK_API_BASE_URL',
        defaultValue: 'mock://data',
      );

  static String get prodApiBaseUrl => const String.fromEnvironment(
        'PROD_API_BASE_URL',
        defaultValue: 'https://api.bel247.com/v1',
      );

  /// Global flag to determine if the app should use mock APIs
  ///
  /// Controlled via --dart-define=USE_MOCK=true/false
  static bool get useMockApi {
    const value = String.fromEnvironment('USE_MOCK', defaultValue: 'true');
    return value.toLowerCase() == 'true';
  }

  /// Feature-specific flag to control AMI (smart meter) usage mock data
  ///
  /// This allows you to keep the rest of the app pointing to live APIs
  /// while the AMI feature still uses local mock JSON data.
  ///
  /// Controlled via --dart-define=USE_AMI_MOCK=true/false
  /// Defaults to true so AMI stays mocked until explicitly disabled.
  static bool get useMockAmiUsage {
    const value = String.fromEnvironment('USE_AMI_MOCK', defaultValue: 'true');
    return value.toLowerCase() == 'true';
  }

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

  static String get currentApiUrl => useMockApi ? mockApiBaseUrl : apiBaseUrl;
}
