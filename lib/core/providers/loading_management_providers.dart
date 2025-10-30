import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';

/// Loading operation types
enum LoadingOperation {
  authentication,
  dashboard,
  bills,
  usage,
  dailyBill,
  navigation,
  storage,
  network,
  unknown,
}

/// Loading state model
class LoadingState {
  const LoadingState({
    required this.operation,
    required this.isLoading,
    required this.timestamp,
    this.message,
    this.progress,
    this.estimatedDuration,
    this.canCancel,
  });

  final LoadingOperation operation;
  final bool isLoading;
  final DateTime timestamp;
  final String? message;
  final double? progress; // 0.0 to 1.0
  final Duration? estimatedDuration;
  final bool? canCancel;

  LoadingState copyWith({
    LoadingOperation? operation,
    bool? isLoading,
    DateTime? timestamp,
    String? message,
    double? progress,
    Duration? estimatedDuration,
    bool? canCancel,
  }) => LoadingState(
        operation: operation ?? this.operation,
        isLoading: isLoading ?? this.isLoading,
        timestamp: timestamp ?? this.timestamp,
        message: message ?? this.message,
        progress: progress ?? this.progress,
        estimatedDuration: estimatedDuration ?? this.estimatedDuration,
        canCancel: canCancel ?? this.canCancel,
      );

  @override
  String toString() => 'LoadingState(operation: $operation, isLoading: $isLoading, message: $message)';
}

/// Loading management state
class LoadingManagementState {
  const LoadingManagementState({
    required this.activeLoadings,
    required this.isAnyLoading,
    this.globalLoadingMessage,
    this.globalProgress,
  });

  final Map<LoadingOperation, LoadingState> activeLoadings;
  final bool isAnyLoading;
  final String? globalLoadingMessage;
  final double? globalProgress;

  LoadingManagementState copyWith({
    Map<LoadingOperation, LoadingState>? activeLoadings,
    bool? isAnyLoading,
    String? globalLoadingMessage,
    double? globalProgress,
  }) => LoadingManagementState(
        activeLoadings: activeLoadings ?? this.activeLoadings,
        isAnyLoading: isAnyLoading ?? this.isAnyLoading,
        globalLoadingMessage: globalLoadingMessage ?? this.globalLoadingMessage,
        globalProgress: globalProgress ?? this.globalProgress,
      );

  static const LoadingManagementState initial = LoadingManagementState(
    activeLoadings: {},
    isAnyLoading: false,
  );
}

/// Loading management notifier
class LoadingManagementNotifier extends StateNotifier<LoadingManagementState> {
  LoadingManagementNotifier() : super(LoadingManagementState.initial);

  /// Start loading for an operation
  void startLoading({
    required LoadingOperation operation,
    String? message,
    double? progress,
    Duration? estimatedDuration,
    bool? canCancel,
  }) {
    final loadingState = LoadingState(
      operation: operation,
      isLoading: true,
      timestamp: DateTime.now(),
      message: message ?? _getDefaultMessage(operation),
      progress: progress,
      estimatedDuration: estimatedDuration,
      canCancel: canCancel ?? _canCancelOperation(operation),
    );

    final updatedLoadings = Map<LoadingOperation, LoadingState>.from(state.activeLoadings);
    updatedLoadings[operation] = loadingState;

    state = state.copyWith(
      activeLoadings: updatedLoadings,
      isAnyLoading: true,
    );

    Logger.info('Loading started for operation: $operation');
  }

  /// Update loading progress
  void updateLoadingProgress({
    required LoadingOperation operation,
    double? progress,
    String? message,
  }) {
    final currentLoading = state.activeLoadings[operation];
    if (currentLoading == null) return;

    final updatedLoading = currentLoading.copyWith(
      progress: progress,
      message: message,
    );

    final updatedLoadings = Map<LoadingOperation, LoadingState>.from(state.activeLoadings);
    updatedLoadings[operation] = updatedLoading;

    state = state.copyWith(
      activeLoadings: updatedLoadings,
    );

    Logger.info('Loading progress updated for operation: $operation - ${(progress ?? 0) * 100}%');
  }

  /// Stop loading for an operation
  void stopLoading(LoadingOperation operation) {
    final updatedLoadings = Map<LoadingOperation, LoadingState>.from(state.activeLoadings);
    updatedLoadings.remove(operation);

    final isAnyLoading = updatedLoadings.isNotEmpty;

    state = state.copyWith(
      activeLoadings: updatedLoadings,
      isAnyLoading: isAnyLoading,
    );

    Logger.info('Loading stopped for operation: $operation');
  }

  /// Stop all loadings
  void stopAllLoadings() {
    state = state.copyWith(
      activeLoadings: {},
      isAnyLoading: false,
      globalLoadingMessage: null,
      globalProgress: null,
    );

    Logger.info('All loadings stopped');
  }

  /// Check if operation is loading
  bool isLoading(LoadingOperation operation) => state.activeLoadings.containsKey(operation);

  /// Get loading state for operation
  LoadingState? getLoadingState(LoadingOperation operation) => state.activeLoadings[operation];

  /// Get loading message for operation
  String? getLoadingMessage(LoadingOperation operation) => state.activeLoadings[operation]?.message;

  /// Get loading progress for operation
  double? getLoadingProgress(LoadingOperation operation) => state.activeLoadings[operation]?.progress;

  /// Set global loading message
  void setGlobalLoadingMessage(String? message) {
    state = state.copyWith(globalLoadingMessage: message);
  }

  /// Set global loading progress
  void setGlobalLoadingProgress(double? progress) {
    state = state.copyWith(globalProgress: progress);
  }

  /// Get default message for operation
  String _getDefaultMessage(LoadingOperation operation) {
    switch (operation) {
      case LoadingOperation.authentication:
        return 'Authenticating...';
      case LoadingOperation.dashboard:
        return 'Loading dashboard...';
      case LoadingOperation.bills:
        return 'Loading bills...';
      case LoadingOperation.usage:
        return 'Loading usage data...';
      case LoadingOperation.dailyBill:
        return 'Loading daily bill...';
      case LoadingOperation.navigation:
        return 'Navigating...';
      case LoadingOperation.storage:
        return 'Saving data...';
      case LoadingOperation.network:
        return 'Connecting...';
      case LoadingOperation.unknown:
        return 'Loading...';
    }
  }

  /// Check if operation can be cancelled
  bool _canCancelOperation(LoadingOperation operation) {
    switch (operation) {
      case LoadingOperation.authentication:
        return false;
      case LoadingOperation.dashboard:
        return true;
      case LoadingOperation.bills:
        return true;
      case LoadingOperation.usage:
        return true;
      case LoadingOperation.dailyBill:
        return true;
      case LoadingOperation.navigation:
        return false;
      case LoadingOperation.storage:
        return false;
      case LoadingOperation.network:
        return true;
      case LoadingOperation.unknown:
        return true;
    }
  }
}

/// Loading state utilities
class LoadingUtils {
  /// Create loading state with progress
  static LoadingState createLoadingWithProgress({
    required LoadingOperation operation,
    required double progress,
    String? message,
    Duration? estimatedDuration,
    bool? canCancel,
  }) => LoadingState(
      operation: operation,
      isLoading: true,
      timestamp: DateTime.now(),
      message: message,
      progress: progress,
      estimatedDuration: estimatedDuration,
      canCancel: canCancel,
    );

  /// Create loading state without progress
  static LoadingState createIndeterminateLoading({
    required LoadingOperation operation,
    String? message,
    Duration? estimatedDuration,
    bool? canCancel,
  }) => LoadingState(
      operation: operation,
      isLoading: true,
      timestamp: DateTime.now(),
      message: message,
      progress: null,
      estimatedDuration: estimatedDuration,
      canCancel: canCancel,
    );

  /// Calculate estimated duration based on progress
  static Duration? calculateEstimatedDuration({
    required double progress,
    required DateTime startTime,
  }) {
    if (progress <= 0) return null;
    
    final elapsed = DateTime.now().difference(startTime);
    final estimatedTotal = Duration(
      milliseconds: (elapsed.inMilliseconds / progress).round(),
    );
    
    return estimatedTotal - elapsed;
  }

  /// Format progress as percentage
  static String formatProgress(double progress) => '${(progress * 100).toStringAsFixed(1)}%';

  /// Format duration for display
  static String formatDuration(Duration duration) {
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }
}

/// Loading management provider
final loadingManagementProvider = StateNotifierProvider<LoadingManagementNotifier, LoadingManagementState>(
  (ref) => LoadingManagementNotifier(),
);

/// Loading management notifier provider
final loadingManagementNotifierProvider = Provider<LoadingManagementNotifier>((ref) => ref.watch(loadingManagementProvider.notifier));

/// Convenience providers
final isAnyLoadingProvider = Provider<bool>((ref) => ref.watch(loadingManagementProvider).isAnyLoading);

final isLoadingCountProvider = Provider<int>((ref) => ref.watch(loadingManagementProvider).activeLoadings.length);

final globalLoadingMessageProvider = Provider<String?>((ref) => ref.watch(loadingManagementProvider).globalLoadingMessage);

final globalLoadingProgressProvider = Provider<double?>((ref) => ref.watch(loadingManagementProvider).globalProgress);

/// Operation-specific loading providers
final isAuthenticationLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.authentication);
});

final isDashboardLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.dashboard);
});

final isBillsLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.bills);
});

final isUsageLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.usage);
});

final isDailyBillLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.dailyBill);
});

final isNavigationLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.navigation);
});

final isStorageLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.storage);
});

final isNetworkLoadingProvider = Provider<bool>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.isLoading(LoadingOperation.network);
});

/// Operation-specific loading state providers
final authenticationLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.authentication);
});

final dashboardLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.dashboard);
});

final billsLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.bills);
});

final usageLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.usage);
});

final dailyBillLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.dailyBill);
});

final navigationLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.navigation);
});

final storageLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.storage);
});

final networkLoadingStateProvider = Provider<LoadingState?>((ref) {
  final notifier = ref.watch(loadingManagementNotifierProvider);
  return notifier.getLoadingState(LoadingOperation.network);
});
