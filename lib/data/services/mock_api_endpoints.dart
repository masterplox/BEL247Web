import 'dart:convert';
import '../../core/utils/logger.dart';
import '../../core/utils/error_handler.dart';
import '../sources/mock/data_loader.dart';

/// Mock API service that simulates REST endpoints
class MockApiEndpoints {
  static const String _userDataPath = 'assets/data/mock_user.json';
  static const String _billsDataPath = 'assets/data/mock_bills.json';
  static const String _consumptionDataPath = 'assets/data/mock_consumption.json';

  /// Simulate GET /api/user/:id endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getUserById(String userId) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/user/$userId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_userDataPath);
      
      if (jsonData['id'] == userId) {
        Logger.info('MockApiEndpoints: User found - ${jsonData['email']}');
        return ApiResponse.success(jsonData, statusCode: 200);
      } else {
        Logger.warning('MockApiEndpoints: User not found - $userId');
        return ApiResponse.error('User not found', statusCode: 404);
      }
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting user by ID', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/user/current endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getCurrentUser() async {
    try {
      Logger.info('MockApiEndpoints: GET /api/user/current');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_userDataPath);
      
      Logger.info('MockApiEndpoints: Current user retrieved - ${jsonData['email']}');
      return ApiResponse.success(jsonData, statusCode: 200);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting current user', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate PUT /api/user/:id endpoint
  static Future<ApiResponse<Map<String, dynamic>>> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      Logger.info('MockApiEndpoints: PUT /api/user/$userId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_userDataPath);
      
      if (jsonData['id'] == userId) {
        // Simulate update by merging data
        final updatedData = {...jsonData, ...userData};
        
        Logger.info('MockApiEndpoints: User updated - ${updatedData['email']}');
        return ApiResponse.success(updatedData, statusCode: 200);
      } else {
        Logger.warning('MockApiEndpoints: User not found for update - $userId');
        return ApiResponse.error('User not found', statusCode: 404);
      }
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error updating user', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/bills endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getBills(String userId) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/bills?userId=$userId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      
      Logger.info('MockApiEndpoints: Bills retrieved - ${jsonData['bills'].length} bills');
      return ApiResponse.success(jsonData, statusCode: 200);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting bills', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/bills/:id endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getBillById(String billId) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/bills/$billId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final bills = jsonData['bills'] as List<dynamic>;
      
      for (final bill in bills) {
        if (bill['id'] == billId) {
          Logger.info('MockApiEndpoints: Bill found - $billId');
          return ApiResponse.success(bill as Map<String, dynamic>, statusCode: 200);
        }
      }
      
      Logger.warning('MockApiEndpoints: Bill not found - $billId');
      return ApiResponse.error('Bill not found', statusCode: 404);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting bill by ID', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate POST /api/payment endpoint
  static Future<ApiResponse<Map<String, dynamic>>> processPayment(
    String userId,
    String billId,
    double amount,
    String paymentMethod,
  ) async {
    try {
      Logger.info('MockApiEndpoints: POST /api/payment - User: $userId, Bill: $billId, Amount: \$$amount, Method: $paymentMethod');
      
      // Simulate payment processing
      await Future.delayed(const Duration(milliseconds: 500));
      
      final paymentResponse = {
        'id': 'payment_${DateTime.now().millisecondsSinceEpoch}',
        'userId': userId,
        'billId': billId,
        'amount': amount,
        'paymentMethod': paymentMethod,
        'status': 'completed',
        'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}',
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      Logger.info('MockApiEndpoints: Payment processed successfully - ${paymentResponse['transactionId']}');
      return ApiResponse.success(paymentResponse, statusCode: 201);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error processing payment', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Payment processing failed', statusCode: 500);
    }
  }

  /// Simulate GET /api/consumption/daily endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getDailyConsumption(String userId, DateTime date) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/consumption/daily?userId=$userId&date=${date.toIso8601String()}');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final dailyData = jsonData['dailyConsumption'] as List<dynamic>;
      
      // Find consumption data for the specific date
      for (final consumption in dailyData) {
        final consumptionDate = DateTime.parse(consumption['date']);
        if (consumptionDate.year == date.year &&
            consumptionDate.month == date.month &&
            consumptionDate.day == date.day) {
          Logger.info('MockApiEndpoints: Daily consumption found for ${date.toIso8601String()}');
          return ApiResponse.success(consumption as Map<String, dynamic>, statusCode: 200);
        }
      }
      
      Logger.warning('MockApiEndpoints: Daily consumption not found for ${date.toIso8601String()}');
      return ApiResponse.error('Consumption data not found', statusCode: 404);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting daily consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/consumption/monthly endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getMonthlyConsumption(String userId, String month) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/consumption/monthly?userId=$userId&month=$month');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final monthlyData = jsonData['monthlyConsumption'] as List<dynamic>;
      
      // Find consumption data for the specific month
      for (final consumption in monthlyData) {
        if (consumption['month'] == month) {
          Logger.info('MockApiEndpoints: Monthly consumption found for $month');
          return ApiResponse.success(consumption as Map<String, dynamic>, statusCode: 200);
        }
      }
      
      Logger.warning('MockApiEndpoints: Monthly consumption not found for $month');
      return ApiResponse.error('Consumption data not found', statusCode: 404);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting monthly consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/consumption/statistics endpoint
  static Future<ApiResponse<Map<String, dynamic>>> getUsageStatistics(String userId) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/consumption/statistics?userId=$userId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final statistics = jsonData['usageStatistics'];
      
      Logger.info('MockApiEndpoints: Usage statistics retrieved');
      return ApiResponse.success(statistics as Map<String, dynamic>, statusCode: 200);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting usage statistics', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate GET /api/consumption/alerts endpoint
  static Future<ApiResponse<List<Map<String, dynamic>>>> getConsumptionAlerts(String userId) async {
    try {
      Logger.info('MockApiEndpoints: GET /api/consumption/alerts?userId=$userId');
      
      final jsonData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final alerts = jsonData['alerts'] as List<dynamic>;
      
      Logger.info('MockApiEndpoints: Consumption alerts retrieved - ${alerts.length} alerts');
      return ApiResponse.success(
        alerts.cast<Map<String, dynamic>>(),
        statusCode: 200,
      );
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error getting consumption alerts', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Internal server error', statusCode: 500);
    }
  }

  /// Simulate POST /api/auth/login endpoint
  static Future<ApiResponse<Map<String, dynamic>>> login(String email, String password) async {
    try {
      Logger.info('MockApiEndpoints: POST /api/auth/login - Email: $email');
      
      // Simulate authentication delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      final jsonData = await DataLoader.loadJsonFromAssets(_userDataPath);
      
      if (jsonData['email'] == email) {
        // Simulate successful login
        final authResponse = {
          'accessToken': 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
          'refreshToken': 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
          'expiresIn': 900, // 15 minutes
          'tokenType': 'Bearer',
          'user': jsonData,
        };
        
        Logger.info('MockApiEndpoints: Login successful for $email');
        return ApiResponse.success(authResponse, statusCode: 200);
      } else {
        Logger.warning('MockApiEndpoints: Login failed - invalid credentials for $email');
        return ApiResponse.error('Invalid credentials', statusCode: 401);
      }
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error during login', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Authentication failed', statusCode: 500);
    }
  }

  /// Simulate POST /api/auth/logout endpoint
  static Future<ApiResponse<void>> logout(String userId) async {
    try {
      Logger.info('MockApiEndpoints: POST /api/auth/logout - User: $userId');
      
      // Simulate logout delay
      await Future.delayed(const Duration(milliseconds: 200));
      
      Logger.info('MockApiEndpoints: Logout successful for $userId');
      return ApiResponse.success(null, statusCode: 200);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error during logout', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Logout failed', statusCode: 500);
    }
  }

  /// Simulate POST /api/auth/refresh endpoint
  static Future<ApiResponse<Map<String, dynamic>>> refreshToken(String refreshToken) async {
    try {
      Logger.info('MockApiEndpoints: POST /api/auth/refresh');
      
      // Simulate token refresh delay
      await Future.delayed(const Duration(milliseconds: 250));
      
      final authResponse = {
        'accessToken': 'mock_refreshed_access_token_${DateTime.now().millisecondsSinceEpoch}',
        'refreshToken': 'mock_new_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        'expiresIn': 900, // 15 minutes
        'tokenType': 'Bearer',
      };
      
      Logger.info('MockApiEndpoints: Token refresh successful');
      return ApiResponse.success(authResponse, statusCode: 200);
    } catch (e, stackTrace) {
      Logger.error('MockApiEndpoints: Error refreshing token', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Token refresh failed', statusCode: 401);
    }
  }

  /// Get API endpoint information
  static Map<String, dynamic> getApiInfo() => {
      'name': 'BEL247 Mock API',
      'version': '1.0.0',
      'baseUrl': 'mock://api.bel247.com',
      'endpoints': [
        'GET /api/user/:id',
        'GET /api/user/current',
        'PUT /api/user/:id',
        'GET /api/bills',
        'GET /api/bills/:id',
        'POST /api/payment',
        'GET /api/consumption/daily',
        'GET /api/consumption/monthly',
        'GET /api/consumption/statistics',
        'GET /api/consumption/alerts',
        'POST /api/auth/login',
        'POST /api/auth/logout',
        'POST /api/auth/refresh',
      ],
      'status': 'active',
      'lastUpdated': DateTime.now().toIso8601String(),
    };
}
