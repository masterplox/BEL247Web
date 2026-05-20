import 'storage_service.dart';

/// Per-user preferences that survive logout (not cleared with auth tokens).
class UserPreferencesStorage {
  UserPreferencesStorage._();

  static String _lastActiveAccountKey(String userId) =>
      'last_active_account_id_$userId';

  static String _welcomeBackShownKey(String userId) =>
      'dashboard_welcome_back_shown_$userId';

  static Future<void> saveLastActiveAccountId({
    required String userId,
    required String accountId,
  }) async {
    if (userId.isEmpty || accountId.isEmpty) return;
    await StorageService.storeString(_lastActiveAccountKey(userId), accountId);
  }

  static Future<String?> getLastActiveAccountId(String userId) async {
    if (userId.isEmpty) return null;
    return StorageService.getString(_lastActiveAccountKey(userId));
  }

  /// True after the user has seen the dashboard at least once (show "Welcome back" next time).
  static Future<bool> hasShownWelcomeBack(String userId) async {
    if (userId.isEmpty) return false;
    return await StorageService.getBool(_welcomeBackShownKey(userId)) ?? false;
  }

  static Future<void> markWelcomeBackShown(String userId) async {
    if (userId.isEmpty) return;
    await StorageService.storeBool(_welcomeBackShownKey(userId), true);
  }
}
