import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.bel247.com/v1';
  static String get mockApiBaseUrl => dotenv.env['MOCK_API_BASE_URL'] ?? 'mock://data';
  static String get prodApiBaseUrl => dotenv.env['PROD_API_BASE_URL'] ?? 'https://api.bel247.com/v1';
  
  static bool get useMockApi => dotenv.env['USE_MOCK']?.toLowerCase() == 'true';
  
  static String get encryptionKey => dotenv.env['ENCRYPTION_KEY'] ?? 'bel247_encryption_key_32_chars';
  
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  
  static int get jwtAccessTokenDuration => int.tryParse(dotenv.env['JWT_ACCESS_TOKEN_DURATION'] ?? '15') ?? 15;
  static int get jwtRefreshTokenDuration => int.tryParse(dotenv.env['JWT_REFRESH_TOKEN_DURATION'] ?? '10080') ?? 10080;
  
  static String get appName => dotenv.env['APP_NAME'] ?? 'BEL247 WebApp';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  
  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';
  
  static String get currentApiUrl => useMockApi ? mockApiBaseUrl : apiBaseUrl;
  
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}
