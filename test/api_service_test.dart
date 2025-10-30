import 'package:flutter_test/flutter_test.dart';
import 'package:bel247_web/data/services/api_service.dart';
import 'package:bel247_web/data/services/service_factory.dart';
import 'package:bel247_web/data/repositories/user_repository.dart';
import 'package:bel247_web/data/repositories/bill_repository.dart';
import 'package:bel247_web/data/repositories/consumption_repository.dart';
import 'package:bel247_web/core/config/env.dart';

void main() {
  group('API Service Layer Tests', () {
    setUpAll(() async {
      // Initialize environment configuration for tests
      await EnvConfig.load();
    });

    setUp(() {
      // Clear any cached services before each test
      ApiService.clearCache();
      ServiceFactory.clear();
    });

    test('ApiService should provide user repository', () {
      final userRepo = ApiService.userRepository;
      expect(userRepo, isA<UserRepository>());
    });

    test('ApiService should provide bill repository', () {
      final billRepo = ApiService.billRepository;
      expect(billRepo, isA<BillRepository>());
    });

    test('ApiService should provide consumption repository', () {
      final consumptionRepo = ApiService.consumptionRepository;
      expect(consumptionRepo, isA<ConsumptionRepository>());
    });

    test('ApiService should cache repository instances', () {
      final userRepo1 = ApiService.userRepository;
      final userRepo2 = ApiService.userRepository;
      
      expect(identical(userRepo1, userRepo2), true);
    });

    test('ApiService should clear cache when requested', () {
      final userRepo1 = ApiService.userRepository;
      ApiService.clearCache();
      final userRepo2 = ApiService.userRepository;
      
      expect(identical(userRepo1, userRepo2), false);
    });

    test('ApiService should provide environment info', () {
      final envInfo = ApiService.getEnvironmentInfo();
      
      expect(envInfo, isA<Map<String, dynamic>>());
      expect(envInfo.containsKey('useMockApi'), true);
      expect(envInfo.containsKey('apiBaseUrl'), true);
      expect(envInfo.containsKey('environment'), true);
    });

    test('ServiceFactory should register and retrieve services', () {
      final userRepo = ApiService.userRepository;
      ServiceFactory.register<UserRepository>(userRepo);
      
      final retrievedRepo = ServiceFactory.get<UserRepository>();
      expect(identical(userRepo, retrievedRepo), true);
    });

    test('ServiceFactory should create services automatically', () {
      final userRepo = ServiceFactory.get<UserRepository>();
      expect(userRepo, isA<UserRepository>());
    });

    test('ServiceFactory should track registered services', () {
      ServiceFactory.get<UserRepository>();
      ServiceFactory.get<BillRepository>();
      
      final registeredServices = ServiceFactory.getRegisteredServices();
      expect(registeredServices.length, 2);
      expect(registeredServices.contains(UserRepository), true);
      expect(registeredServices.contains(BillRepository), true);
    });

    test('ServiceFactory should check if service is registered', () {
      expect(ServiceFactory.isRegistered<UserRepository>(), false);
      
      ServiceFactory.get<UserRepository>();
      expect(ServiceFactory.isRegistered<UserRepository>(), true);
    });

    test('ServiceFactory should unregister services', () {
      ServiceFactory.get<UserRepository>();
      expect(ServiceFactory.isRegistered<UserRepository>(), true);
      
      ServiceFactory.unregister<UserRepository>();
      expect(ServiceFactory.isRegistered<UserRepository>(), false);
    });

    test('ServiceFactory should clear all services', () {
      ServiceFactory.get<UserRepository>();
      ServiceFactory.get<BillRepository>();
      ServiceFactory.get<ConsumptionRepository>();
      
      expect(ServiceFactory.getRegisteredServices().length, 3);
      
      ServiceFactory.clear();
      expect(ServiceFactory.getRegisteredServices().length, 0);
    });
  });
}
