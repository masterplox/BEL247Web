import '../../core/config/env.dart';
import '../repositories/user_repository.dart';
import '../repositories/bill_repository.dart';
import '../repositories/consumption_repository.dart';
import '../sources/mock/mock_user_repository.dart';
import '../sources/mock/mock_bill_repository.dart';
import '../sources/mock/mock_consumption_repository.dart';
import '../../core/utils/logger.dart';

/// Service factory that provides repository implementations based on environment configuration
class ApiService {
  static UserRepository? _userRepository;
  static BillRepository? _billRepository;
  static ConsumptionRepository? _consumptionRepository;

  /// Get user repository implementation based on environment
  static UserRepository get userRepository {
    _userRepository ??= _createUserRepository();
    return _userRepository!;
  }

  /// Get bill repository implementation based on environment
  static BillRepository get billRepository {
    _billRepository ??= _createBillRepository();
    return _billRepository!;
  }

  /// Get consumption repository implementation based on environment
  static ConsumptionRepository get consumptionRepository {
    _consumptionRepository ??= _createConsumptionRepository();
    return _consumptionRepository!;
  }

  /// Create user repository based on environment configuration
  static UserRepository _createUserRepository() {
    final useMockApi = EnvConfig.useMockApi;
    
    if (useMockApi) {
      Logger.info('ApiService: Using MockUserRepository');
      return MockUserRepository();
    } else {
      Logger.info('ApiService: Using LiveUserRepository (not implemented yet)');
      // TODO: Implement live user repository
      return MockUserRepository(); // Fallback to mock for now
    }
  }

  /// Create bill repository based on environment configuration
  static BillRepository _createBillRepository() {
    final useMockApi = EnvConfig.useMockApi;
    
    if (useMockApi) {
      Logger.info('ApiService: Using MockBillRepository');
      return MockBillRepository();
    } else {
      Logger.info('ApiService: Using LiveBillRepository (not implemented yet)');
      // TODO: Implement live bill repository
      return MockBillRepository(); // Fallback to mock for now
    }
  }

  /// Create consumption repository based on environment configuration
  static ConsumptionRepository _createConsumptionRepository() {
    final useMockApi = EnvConfig.useMockApi;
    
    if (useMockApi) {
      Logger.info('ApiService: Using MockConsumptionRepository');
      return MockConsumptionRepository();
    } else {
      Logger.info('ApiService: Using LiveConsumptionRepository (not implemented yet)');
      // TODO: Implement live consumption repository
      return MockConsumptionRepository(); // Fallback to mock for now
    }
  }

  /// Clear cached repositories (useful for testing or environment changes)
  static void clearCache() {
    Logger.info('ApiService: Clearing repository cache');
    _userRepository = null;
    _billRepository = null;
    _consumptionRepository = null;
  }

  /// Get current environment configuration
  static Map<String, dynamic> getEnvironmentInfo() => {
      'useMockApi': EnvConfig.useMockApi,
      'apiBaseUrl': EnvConfig.apiBaseUrl,
      'environment': EnvConfig.environment,
    };

  /// Switch to mock mode (for testing)
  static void switchToMockMode() {
    Logger.info('ApiService: Switching to mock mode');
    clearCache();
    // Note: This would require updating EnvConfig.useMockApi, which is read-only
    // In a real implementation, you might want to make this configurable
  }

  /// Switch to live mode (for production)
  static void switchToLiveMode() {
    Logger.info('ApiService: Switching to live mode');
    clearCache();
    // Note: This would require updating EnvConfig.useMockApi, which is read-only
    // In a real implementation, you might want to make this configurable
  }
}
