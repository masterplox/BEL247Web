import '../repositories/user_repository.dart';
import '../repositories/bill_repository.dart';
import '../repositories/consumption_repository.dart';
import 'api_service.dart';
import '../../core/utils/logger.dart';

/// Service factory for dependency injection and service management
class ServiceFactory {
  static final Map<Type, dynamic> _services = {};

  /// Register a service instance
  static void register<T>(T service) {
    Logger.info('ServiceFactory: Registering ${T.toString()}');
    _services[T] = service;
  }

  /// Get a service instance
  static T get<T>() {
    if (_services.containsKey(T)) {
      Logger.info('ServiceFactory: Getting cached ${T.toString()}');
      return _services[T] as T;
    }

    Logger.info('ServiceFactory: Creating new ${T.toString()}');
    return _createService<T>();
  }

  /// Create a service instance based on type
  static T _createService<T>() {
    if (T == UserRepository) {
      final service = ApiService.userRepository;
      _services[T] = service;
      return service as T;
    } else if (T == BillRepository) {
      final service = ApiService.billRepository;
      _services[T] = service;
      return service as T;
    } else if (T == ConsumptionRepository) {
      final service = ApiService.consumptionRepository;
      _services[T] = service;
      return service as T;
    }

    throw Exception('ServiceFactory: Unknown service type ${T.toString()}');
  }

  /// Clear all registered services
  static void clear() {
    Logger.info('ServiceFactory: Clearing all services');
    _services.clear();
  }

  /// Get all registered service types
  static List<Type> getRegisteredServices() => _services.keys.toList();

  /// Check if a service is registered
  static bool isRegistered<T>() => _services.containsKey(T);

  /// Unregister a specific service
  static void unregister<T>() {
    if (_services.containsKey(T)) {
      Logger.info('ServiceFactory: Unregistering ${T.toString()}');
      _services.remove(T);
    }
  }
}
