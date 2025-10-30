import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../utils/logger.dart';

/// Global app state
class GlobalAppState {
  const GlobalAppState({
    required this.isInitialized,
    required this.isOnline,
    required this.currentTheme,
    required this.language,
    required this.isDebugMode,
    this.lastError,
  });

  final bool isInitialized;
  final bool isOnline;
  final String currentTheme;
  final String language;
  final bool isDebugMode;
  final String? lastError;

  GlobalAppState copyWith({
    bool? isInitialized,
    bool? isOnline,
    String? currentTheme,
    String? language,
    bool? isDebugMode,
    String? lastError,
  }) => GlobalAppState(
        isInitialized: isInitialized ?? this.isInitialized,
        isOnline: isOnline ?? this.isOnline,
        currentTheme: currentTheme ?? this.currentTheme,
        language: language ?? this.language,
        isDebugMode: isDebugMode ?? this.isDebugMode,
        lastError: lastError ?? this.lastError,
      );

  static const GlobalAppState initial = GlobalAppState(
    isInitialized: false,
    isOnline: true,
    currentTheme: 'light',
    language: 'en',
    isDebugMode: false,
  );
}

/// Global app state notifier
class GlobalAppNotifier extends StateNotifier<GlobalAppState> {
  GlobalAppNotifier() : super(GlobalAppState.initial);

  /// Initialize the app
  Future<void> initialize() async {
    try {
      Logger.info('Initializing global app state');
      
      // Set debug mode based on environment
      final isDebugMode = EnvConfig.isDevelopment;
      
      state = state.copyWith(
        isDebugMode: isDebugMode,
        isInitialized: true,
      );
      
      Logger.info('Global app state initialized');
    } catch (e) {
      Logger.error('Failed to initialize global app state: $e');
      state = state.copyWith(lastError: e.toString());
    }
  }

  /// Update online status
  void updateOnlineStatus(bool isOnline) {
    state = state.copyWith(isOnline: isOnline);
    Logger.info('Online status updated: $isOnline');
  }

  /// Update theme
  void updateTheme(String theme) {
    state = state.copyWith(currentTheme: theme);
    Logger.info('Theme updated: $theme');
  }

  /// Update language
  void updateLanguage(String language) {
    state = state.copyWith(language: language);
    Logger.info('Language updated: $language');
  }

  /// Clear last error
  void clearError() {
    state = state.copyWith(lastError: null);
  }

  /// Set error
  void setError(String error) {
    state = state.copyWith(lastError: error);
    Logger.error('Global error set: $error');
  }
}

/// User preferences state
class UserPreferencesState {
  const UserPreferencesState({
    required this.notificationsEnabled,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.dataUsageTracking,
    required this.analyticsEnabled,
    required this.themeMode,
    required this.language,
    required this.dateFormat,
    required this.timeFormat,
    required this.currency,
    required this.timezone,
  });

  final bool notificationsEnabled;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool dataUsageTracking;
  final bool analyticsEnabled;
  final String themeMode;
  final String language;
  final String dateFormat;
  final String timeFormat;
  final String currency;
  final String timezone;

  UserPreferencesState copyWith({
    bool? notificationsEnabled,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? dataUsageTracking,
    bool? analyticsEnabled,
    String? themeMode,
    String? language,
    String? dateFormat,
    String? timeFormat,
    String? currency,
    String? timezone,
  }) => UserPreferencesState(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        emailNotifications: emailNotifications ?? this.emailNotifications,
        pushNotifications: pushNotifications ?? this.pushNotifications,
        dataUsageTracking: dataUsageTracking ?? this.dataUsageTracking,
        analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
        dateFormat: dateFormat ?? this.dateFormat,
        timeFormat: timeFormat ?? this.timeFormat,
        currency: currency ?? this.currency,
        timezone: timezone ?? this.timezone,
      );

  static const UserPreferencesState initial = UserPreferencesState(
    notificationsEnabled: true,
    emailNotifications: true,
    pushNotifications: true,
    dataUsageTracking: true,
    analyticsEnabled: false,
    themeMode: 'system',
    language: 'en',
    dateFormat: 'MM/dd/yyyy',
    timeFormat: '12h',
    currency: 'USD',
    timezone: 'UTC',
  );
}

/// User preferences notifier
class UserPreferencesNotifier extends StateNotifier<UserPreferencesState> {
  UserPreferencesNotifier() : super(UserPreferencesState.initial);

  /// Update notification preferences
  void updateNotificationPreferences({
    bool? notificationsEnabled,
    bool? emailNotifications,
    bool? pushNotifications,
  }) {
    state = state.copyWith(
      notificationsEnabled: notificationsEnabled,
      emailNotifications: emailNotifications,
      pushNotifications: pushNotifications,
    );
    Logger.info('Notification preferences updated');
  }

  /// Update privacy preferences
  void updatePrivacyPreferences({
    bool? dataUsageTracking,
    bool? analyticsEnabled,
  }) {
    state = state.copyWith(
      dataUsageTracking: dataUsageTracking,
      analyticsEnabled: analyticsEnabled,
    );
    Logger.info('Privacy preferences updated');
  }

  /// Update display preferences
  void updateDisplayPreferences({
    String? themeMode,
    String? language,
    String? dateFormat,
    String? timeFormat,
  }) {
    state = state.copyWith(
      themeMode: themeMode,
      language: language,
      dateFormat: dateFormat,
      timeFormat: timeFormat,
    );
    Logger.info('Display preferences updated');
  }

  /// Update regional preferences
  void updateRegionalPreferences({
    String? currency,
    String? timezone,
  }) {
    state = state.copyWith(
      currency: currency,
      timezone: timezone,
    );
    Logger.info('Regional preferences updated');
  }

  /// Reset to defaults
  void resetToDefaults() {
    state = UserPreferencesState.initial;
    Logger.info('Preferences reset to defaults');
  }
}

/// App settings state
class AppSettingsState {
  const AppSettingsState({
    required this.apiBaseUrl,
    required this.apiTimeout,
    required this.maxRetries,
    required this.cacheExpiration,
    required this.logLevel,
    required this.enableCrashReporting,
    required this.enablePerformanceMonitoring,
    required this.enableAnalytics,
  });

  final String apiBaseUrl;
  final int apiTimeout;
  final int maxRetries;
  final int cacheExpiration;
  final String logLevel;
  final bool enableCrashReporting;
  final bool enablePerformanceMonitoring;
  final bool enableAnalytics;

  AppSettingsState copyWith({
    String? apiBaseUrl,
    int? apiTimeout,
    int? maxRetries,
    int? cacheExpiration,
    String? logLevel,
    bool? enableCrashReporting,
    bool? enablePerformanceMonitoring,
    bool? enableAnalytics,
  }) => AppSettingsState(
        apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
        apiTimeout: apiTimeout ?? this.apiTimeout,
        maxRetries: maxRetries ?? this.maxRetries,
        cacheExpiration: cacheExpiration ?? this.cacheExpiration,
        logLevel: logLevel ?? this.logLevel,
        enableCrashReporting: enableCrashReporting ?? this.enableCrashReporting,
        enablePerformanceMonitoring: enablePerformanceMonitoring ?? this.enablePerformanceMonitoring,
        enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      );

  static AppSettingsState initial = AppSettingsState(
    apiBaseUrl: EnvConfig.apiBaseUrl,
    apiTimeout: 30000,
    maxRetries: 3,
    cacheExpiration: 300000, // 5 minutes
    logLevel: 'info',
    enableCrashReporting: true,
    enablePerformanceMonitoring: true,
    enableAnalytics: false,
  );
}

/// App settings notifier
class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  AppSettingsNotifier() : super(AppSettingsState.initial);

  /// Update API settings
  void updateApiSettings({
    String? apiBaseUrl,
    int? apiTimeout,
    int? maxRetries,
  }) {
    state = state.copyWith(
      apiBaseUrl: apiBaseUrl,
      apiTimeout: apiTimeout,
      maxRetries: maxRetries,
    );
    Logger.info('API settings updated');
  }

  /// Update cache settings
  void updateCacheSettings({
    int? cacheExpiration,
  }) {
    state = state.copyWith(
      cacheExpiration: cacheExpiration,
    );
    Logger.info('Cache settings updated');
  }

  /// Update logging settings
  void updateLoggingSettings({
    String? logLevel,
  }) {
    state = state.copyWith(
      logLevel: logLevel,
    );
    Logger.info('Logging settings updated');
  }

  /// Update monitoring settings
  void updateMonitoringSettings({
    bool? enableCrashReporting,
    bool? enablePerformanceMonitoring,
    bool? enableAnalytics,
  }) {
    state = state.copyWith(
      enableCrashReporting: enableCrashReporting,
      enablePerformanceMonitoring: enablePerformanceMonitoring,
      enableAnalytics: enableAnalytics,
    );
    Logger.info('Monitoring settings updated');
  }
}

/// Global state providers
final globalAppProvider = StateNotifierProvider<GlobalAppNotifier, GlobalAppState>(
  (ref) => GlobalAppNotifier(),
);

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferencesState>(
  (ref) => UserPreferencesNotifier(),
);

final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettingsState>(
  (ref) => AppSettingsNotifier(),
);

/// Convenience providers
final isAppInitializedProvider = Provider<bool>((ref) => ref.watch(globalAppProvider).isInitialized);

final isOnlineProvider = Provider<bool>((ref) => ref.watch(globalAppProvider).isOnline);

final currentThemeProvider = Provider<String>((ref) => ref.watch(globalAppProvider).currentTheme);

final currentLanguageProvider = Provider<String>((ref) => ref.watch(globalAppProvider).language);

final isDebugModeProvider = Provider<bool>((ref) => ref.watch(globalAppProvider).isDebugMode);

final lastErrorProvider = Provider<String?>((ref) => ref.watch(globalAppProvider).lastError);

/// Notifier providers for external access
final globalAppNotifierProvider = Provider<GlobalAppNotifier>((ref) => ref.watch(globalAppProvider.notifier));

final userPreferencesNotifierProvider = Provider<UserPreferencesNotifier>((ref) => ref.watch(userPreferencesProvider.notifier));

final appSettingsNotifierProvider = Provider<AppSettingsNotifier>((ref) => ref.watch(appSettingsProvider.notifier));
