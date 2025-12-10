import '../../../core/utils/error_handler.dart';
import '../../../core/utils/logger.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import 'data_loader.dart';
import 'mock_asset_paths.dart';

/// Mock implementation of UserRepository using local JSON data
class MockUserRepository implements UserRepository {
  static const String _userDataPath = MockAssetPaths.user;

  @override
  Future<ApiResponse<User>> getUserById(String userId) async {
    try {
      Logger.info('MockUserRepository: Getting user by ID: $userId');
      
      final Map<String, dynamic> userData = await DataLoader.loadJsonFromAssets(_userDataPath);
      final User user = User.fromJson(userData);
      
      Logger.info('MockUserRepository: Successfully retrieved user: ${user.email}');
      return ApiResponse.success(user);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to get user by ID', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve user: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      Logger.info('MockUserRepository: Getting current user');
      
      final Map<String, dynamic> userData = await DataLoader.loadJsonFromAssets(_userDataPath);
      final User user = User.fromJson(userData);
      
      Logger.info('MockUserRepository: Successfully retrieved current user: ${user.email}');
      return ApiResponse.success(user);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to get current user', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve current user: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<User>> updateUser(User user) async {
    try {
      Logger.info('MockUserRepository: Updating user: ${user.email}');
      
      // In a real implementation, this would make an API call
      // For mock, we just return the updated user
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      Logger.info('MockUserRepository: Successfully updated user: ${user.email}');
      return ApiResponse.success(user);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to update user', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to update user: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<User>> updateUserPreferences(String userId, UserPreferences preferences) async {
    try {
      Logger.info('MockUserRepository: Updating preferences for user: $userId');
      
      final Map<String, dynamic> userData = await DataLoader.loadJsonFromAssets(_userDataPath);
      final User currentUser = User.fromJson(userData);
      
      // Create updated user with new preferences
      final User updatedUser = currentUser.copyWith(preferences: preferences);
      
      await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
      
      Logger.info('MockUserRepository: Successfully updated preferences for user: $userId');
      return ApiResponse.success(updatedUser);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to update preferences', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to update preferences: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<AccountBalance>> getAccountBalance(String userId) async {
    try {
      Logger.info('MockUserRepository: Getting account balance for user: $userId');
      
      final Map<String, dynamic> userData = await DataLoader.loadJsonFromAssets(_userDataPath);
      final User user = User.fromJson(userData);
      
      Logger.info('MockUserRepository: Successfully retrieved account balance: \$${user.accountBalance.currentBalance}');
      return ApiResponse.success(user.accountBalance);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to get account balance', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve account balance: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<UsageSummary>> getUsageSummary(String userId) async {
    try {
      Logger.info('MockUserRepository: Getting usage summary for user: $userId');
      
      final Map<String, dynamic> userData = await DataLoader.loadJsonFromAssets(_userDataPath);
      final User user = User.fromJson(userData);
      
      Logger.info('MockUserRepository: Successfully retrieved usage summary');
      return ApiResponse.success(user.usageSummary);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to get usage summary', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve usage summary: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> updatePassword(String userId, String currentPassword, String newPassword) async {
    try {
      Logger.info('MockUserRepository: Updating password for user: $userId');
      
      await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
      
      Logger.info('MockUserRepository: Successfully updated password for user: $userId');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to update password', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to update password: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<void>> deleteUser(String userId) async {
    try {
      Logger.info('MockUserRepository: Deleting user: $userId');
      
      await Future.delayed(const Duration(milliseconds: 1000)); // Simulate network delay
      
      Logger.info('MockUserRepository: Successfully deleted user: $userId');
      return ApiResponse.success(null);
    } catch (e, stackTrace) {
      Logger.error('MockUserRepository: Failed to delete user', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to delete user: ${e.toString()}');
    }
  }

  // Helper for API error handling
  ApiResponse<T> _handleApiError<T>(Object error) {
    Logger.error('MockUserRepository: API Error', error: error);
    return ApiResponse.error(error.toString());
  }

  @override
  Future<T> handleResponse<T>(
    Future<dynamic> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await apiCall();
      return fromJson(response as Map<String, dynamic>);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }

  @override
  void handleError(Exception error) {
    Logger.error('MockUserRepository: API Error', error: error);
  }
}