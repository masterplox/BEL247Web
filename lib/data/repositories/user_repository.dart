import '../models/user.dart';
import 'base_repository.dart';
import '../../core/utils/error_handler.dart';

/// Abstract interface for user data operations
abstract class UserRepository extends BaseRepository {
  /// Get user profile by ID
  Future<ApiResponse<User>> getUserById(String userId);

  /// Get current authenticated user
  Future<ApiResponse<User>> getCurrentUser();

  /// Update user profile
  Future<ApiResponse<User>> updateUser(User user);

  /// Update user preferences
  Future<ApiResponse<User>> updateUserPreferences(String userId, UserPreferences preferences);

  /// Get user account balance
  Future<ApiResponse<AccountBalance>> getAccountBalance(String userId);

  /// Get user usage summary
  Future<ApiResponse<UsageSummary>> getUsageSummary(String userId);

  /// Update user password
  Future<ApiResponse<void>> updatePassword(String userId, String currentPassword, String newPassword);

  /// Delete user account
  Future<ApiResponse<void>> deleteUser(String userId);
}
