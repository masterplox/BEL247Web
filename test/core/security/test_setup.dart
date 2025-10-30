import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Test setup for security tests
void setupTestEnvironment() {
  // Set up test environment variables
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Load test environment variables
  dotenv.testLoad(fileInput: '''
ENCRYPTION_KEY=test_encryption_key_32_chars_long_12345678901234567890123456789012
API_BASE_URL=https://test-api.example.com
DEBUG_MODE=true
''');
}

/// Clean up test environment
void cleanupTestEnvironment() {
  // Clean up any test-specific resources
}
