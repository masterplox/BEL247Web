import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';
import '../services/storage_service.dart';

/// State persistence notifier for managing state restoration
class StatePersistenceNotifier extends StateNotifier<StatePersistenceState> {
  StatePersistenceNotifier() : super(StatePersistenceState.initial);

  /// Restore all app state from storage
  Future<void> restoreAppState() async {
    state = state.copyWith(isRestoring: true, error: null);
    
    try {
      Logger.info('Starting app state restoration');
      
      // Restore global app state
      await _restoreGlobalState();
      
      // Restore user preferences
      await _restoreUserPreferences();
      
      // Restore app settings
      await _restoreAppSettings();
      
      state = state.copyWith(
        isRestoring: false,
        lastRestoreTime: DateTime.now(),
        isRestored: true,
      );
      
      Logger.info('App state restoration completed');
    } catch (e) {
      Logger.error('Failed to restore app state: $e');
      state = state.copyWith(
        isRestoring: false,
        error: e.toString(),
      );
    }
  }

  /// Save all app state to storage
  Future<void> saveAppState() async {
    state = state.copyWith(isSaving: true, error: null);
    
    try {
      Logger.info('Starting app state save');
      
      // Save global app state
      await _saveGlobalState();
      
      // Save user preferences
      await _saveUserPreferences();
      
      // Save app settings
      await _saveAppSettings();
      
      state = state.copyWith(
        isSaving: false,
        lastSaveTime: DateTime.now(),
      );
      
      Logger.info('App state save completed');
    } catch (e) {
      Logger.error('Failed to save app state: $e');
      state = state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
  }

  /// Restore global app state
  Future<void> _restoreGlobalState() async {
    try {
      final theme = await StorageService.getString(StorageKeys.themeMode);
      final language = await StorageService.getString(StorageKeys.language);
      final isOnline = await StorageService.getBool('is_online') ?? true;
      
      // Note: In a real app, you would inject the notifier here
      // For now, we'll just log the restoration
      Logger.info('Global state restored - Theme: $theme, Language: $language, Online: $isOnline');
    } catch (e) {
      Logger.error('Failed to restore global state: $e');
    }
  }

  /// Save global app state
  Future<void> _saveGlobalState() async {
    try {
      // Note: In a real app, you would access the current state from providers
      // For now, we'll just save default values
      await StorageService.storeString(StorageKeys.themeMode, 'light');
      await StorageService.storeString(StorageKeys.language, 'en');
      await StorageService.storeBool('is_online', true);
      
      Logger.info('Global state saved');
    } catch (e) {
      Logger.error('Failed to save global state: $e');
    }
  }

  /// Restore user preferences
  Future<void> _restoreUserPreferences() async {
    try {
      final preferencesJson = await StorageService.getJson(StorageKeys.userPreferences);
      if (preferencesJson != null) {
        Logger.info('User preferences restored: $preferencesJson');
      }
    } catch (e) {
      Logger.error('Failed to restore user preferences: $e');
    }
  }

  /// Save user preferences
  Future<void> _saveUserPreferences() async {
    try {
      final preferences = {
        'notificationsEnabled': true,
        'emailNotifications': true,
        'pushNotifications': true,
        'dataUsageTracking': true,
        'analyticsEnabled': false,
        'themeMode': 'system',
        'language': 'en',
        'dateFormat': 'MM/dd/yyyy',
        'timeFormat': '12h',
        'currency': 'USD',
        'timezone': 'UTC',
      };
      
      await StorageService.storeJson(StorageKeys.userPreferences, preferences);
      Logger.info('User preferences saved');
    } catch (e) {
      Logger.error('Failed to save user preferences: $e');
    }
  }

  /// Restore app settings
  Future<void> _restoreAppSettings() async {
    try {
      final settingsJson = await StorageService.getJson(StorageKeys.appSettings);
      if (settingsJson != null) {
        Logger.info('App settings restored: $settingsJson');
      }
    } catch (e) {
      Logger.error('Failed to restore app settings: $e');
    }
  }

  /// Save app settings
  Future<void> _saveAppSettings() async {
    try {
      final settings = {
        'apiBaseUrl': 'https://api.bel247.com',
        'apiTimeout': 30000,
        'maxRetries': 3,
        'cacheExpiration': 300000,
        'logLevel': 'info',
        'enableCrashReporting': true,
        'enablePerformanceMonitoring': true,
        'enableAnalytics': false,
      };
      
      await StorageService.storeJson(StorageKeys.appSettings, settings);
      Logger.info('App settings saved');
    } catch (e) {
      Logger.error('Failed to save app settings: $e');
    }
  }

  /// Clear all persisted state
  Future<void> clearPersistedState() async {
    state = state.copyWith(isClearing: true, error: null);
    
    try {
      await StorageService.clear();
      
      state = state.copyWith(
        isClearing: false,
        isRestored: false,
        lastRestoreTime: null,
        lastSaveTime: null,
      );
      
      Logger.info('All persisted state cleared');
    } catch (e) {
      Logger.error('Failed to clear persisted state: $e');
      state = state.copyWith(
        isClearing: false,
        error: e.toString(),
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// State persistence state
class StatePersistenceState {
  const StatePersistenceState({
    required this.isRestoring,
    required this.isSaving,
    required this.isClearing,
    required this.isRestored,
    this.error,
    this.lastRestoreTime,
    this.lastSaveTime,
  });

  final bool isRestoring;
  final bool isSaving;
  final bool isClearing;
  final bool isRestored;
  final String? error;
  final DateTime? lastRestoreTime;
  final DateTime? lastSaveTime;

  StatePersistenceState copyWith({
    bool? isRestoring,
    bool? isSaving,
    bool? isClearing,
    bool? isRestored,
    String? error,
    DateTime? lastRestoreTime,
    DateTime? lastSaveTime,
  }) => StatePersistenceState(
        isRestoring: isRestoring ?? this.isRestoring,
        isSaving: isSaving ?? this.isSaving,
        isClearing: isClearing ?? this.isClearing,
        isRestored: isRestored ?? this.isRestored,
        error: error ?? this.error,
        lastRestoreTime: lastRestoreTime ?? this.lastRestoreTime,
        lastSaveTime: lastSaveTime ?? this.lastSaveTime,
      );

  static const StatePersistenceState initial = StatePersistenceState(
    isRestoring: false,
    isSaving: false,
    isClearing: false,
    isRestored: false,
  );
}

/// State persistence provider
final statePersistenceProvider = StateNotifierProvider<StatePersistenceNotifier, StatePersistenceState>(
  (ref) => StatePersistenceNotifier(),
);

/// State persistence notifier provider
final statePersistenceNotifierProvider = Provider<StatePersistenceNotifier>((ref) => ref.watch(statePersistenceProvider.notifier));

/// Convenience providers
final isStateRestoringProvider = Provider<bool>((ref) => ref.watch(statePersistenceProvider).isRestoring);

final isStateSavingProvider = Provider<bool>((ref) => ref.watch(statePersistenceProvider).isSaving);

final isStateRestoredProvider = Provider<bool>((ref) => ref.watch(statePersistenceProvider).isRestored);

final statePersistenceErrorProvider = Provider<String?>((ref) => ref.watch(statePersistenceProvider).error);
