import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';

/// Error types for different categories
enum ErrorType {
  network,
  authentication,
  validation,
  server,
  storage,
  unknown,
}

/// Error severity levels
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// Error state model
class ErrorState {
  const ErrorState({
    required this.id,
    required this.type,
    required this.severity,
    required this.message,
    required this.timestamp,
    this.details,
    this.stackTrace,
    this.isRecoverable,
    this.recoveryAction,
    this.context,
  });

  final String id;
  final ErrorType type;
  final ErrorSeverity severity;
  final String message;
  final DateTime timestamp;
  final String? details;
  final String? stackTrace;
  final bool? isRecoverable;
  final String? recoveryAction;
  final Map<String, dynamic>? context;

  ErrorState copyWith({
    String? id,
    ErrorType? type,
    ErrorSeverity? severity,
    String? message,
    DateTime? timestamp,
    String? details,
    String? stackTrace,
    bool? isRecoverable,
    String? recoveryAction,
    Map<String, dynamic>? context,
  }) => ErrorState(
        id: id ?? this.id,
        type: type ?? this.type,
        severity: severity ?? this.severity,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
        details: details ?? this.details,
        stackTrace: stackTrace ?? this.stackTrace,
        isRecoverable: isRecoverable ?? this.isRecoverable,
        recoveryAction: recoveryAction ?? this.recoveryAction,
        context: context ?? this.context,
      );

  @override
  String toString() => 'ErrorState(id: $id, type: $type, severity: $severity, message: $message)';
}

/// Error management state
class ErrorManagementState {
  const ErrorManagementState({
    required this.errors,
    required this.isHandlingError,
    this.lastError,
    this.errorCount = 0,
  });

  final List<ErrorState> errors;
  final bool isHandlingError;
  final ErrorState? lastError;
  final int errorCount;

  ErrorManagementState copyWith({
    List<ErrorState>? errors,
    bool? isHandlingError,
    ErrorState? lastError,
    int? errorCount,
  }) => ErrorManagementState(
        errors: errors ?? this.errors,
        isHandlingError: isHandlingError ?? this.isHandlingError,
        lastError: lastError ?? this.lastError,
        errorCount: errorCount ?? this.errorCount,
      );

  static const ErrorManagementState initial = ErrorManagementState(
    errors: [],
    isHandlingError: false,
    errorCount: 0,
  );
}

/// Error management notifier
class ErrorManagementNotifier extends StateNotifier<ErrorManagementState> {
  ErrorManagementNotifier() : super(ErrorManagementState.initial);

  /// Add a new error
  void addError({
    required ErrorType type,
    required ErrorSeverity severity,
    required String message,
    String? details,
    String? stackTrace,
    bool? isRecoverable,
    String? recoveryAction,
    Map<String, dynamic>? context,
  }) {
    final error = ErrorState(
      id: _generateErrorId(),
      type: type,
      severity: severity,
      message: message,
      timestamp: DateTime.now(),
      details: details,
      stackTrace: stackTrace,
      isRecoverable: isRecoverable ?? _isRecoverable(type),
      recoveryAction: recoveryAction ?? _getRecoveryAction(type),
      context: context,
    );

    final updatedErrors = [...state.errors, error];
    
    state = state.copyWith(
      errors: updatedErrors,
      lastError: error,
      errorCount: updatedErrors.length,
    );

    Logger.error('Error added: ${error.toString()}');
  }

  /// Remove error by ID
  void removeError(String errorId) {
    final updatedErrors = state.errors.where((error) => error.id != errorId).toList();
    
    state = state.copyWith(
      errors: updatedErrors,
      errorCount: updatedErrors.length,
      lastError: updatedErrors.isNotEmpty ? updatedErrors.last : null,
    );

    Logger.info('Error removed: $errorId');
  }

  /// Clear all errors
  void clearAllErrors() {
    state = state.copyWith(
      errors: [],
      lastError: null,
      errorCount: 0,
    );

    Logger.info('All errors cleared');
  }

  /// Clear errors by type
  void clearErrorsByType(ErrorType type) {
    final updatedErrors = state.errors.where((error) => error.type != type).toList();
    
    state = state.copyWith(
      errors: updatedErrors,
      errorCount: updatedErrors.length,
      lastError: updatedErrors.isNotEmpty ? updatedErrors.last : null,
    );

    Logger.info('Errors cleared for type: $type');
  }

  /// Clear errors by severity
  void clearErrorsBySeverity(ErrorSeverity severity) {
    final updatedErrors = state.errors.where((error) => error.severity != severity).toList();
    
    state = state.copyWith(
      errors: updatedErrors,
      errorCount: updatedErrors.length,
      lastError: updatedErrors.isNotEmpty ? updatedErrors.last : null,
    );

    Logger.info('Errors cleared for severity: $severity');
  }

  /// Get errors by type
  List<ErrorState> getErrorsByType(ErrorType type) => state.errors.where((error) => error.type == type).toList();

  /// Get errors by severity
  List<ErrorState> getErrorsBySeverity(ErrorSeverity severity) => state.errors.where((error) => error.severity == severity).toList();

  /// Get recoverable errors
  List<ErrorState> getRecoverableErrors() => state.errors.where((error) => error.isRecoverable ?? false).toList();

  /// Check if there are critical errors
  bool hasCriticalErrors() => state.errors.any((error) => error.severity == ErrorSeverity.critical);

  /// Check if there are network errors
  bool hasNetworkErrors() => state.errors.any((error) => error.type == ErrorType.network);

  /// Check if there are authentication errors
  bool hasAuthenticationErrors() => state.errors.any((error) => error.type == ErrorType.authentication);

  /// Handle error recovery
  Future<void> handleErrorRecovery(String errorId) async {
    final error = state.errors.firstWhere((e) => e.id == errorId);
    
    if (error.isRecoverable != true) {
      Logger.warning('Cannot recover from error: $errorId');
      return;
    }

    state = state.copyWith(isHandlingError: true);

    try {
      Logger.info('Handling error recovery for: $errorId');
      
      // Simulate recovery action
      await Future.delayed(const Duration(seconds: 1));
      
      // Remove the error after successful recovery
      removeError(errorId);
      
      Logger.info('Error recovery completed for: $errorId');
    } catch (e) {
      Logger.error('Error recovery failed for $errorId: $e');
    } finally {
      state = state.copyWith(isHandlingError: false);
    }
  }

  /// Generate unique error ID
  String _generateErrorId() => 'error_${DateTime.now().millisecondsSinceEpoch}_${state.errorCount}';

  /// Determine if error type is recoverable
  bool _isRecoverable(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return true;
      case ErrorType.authentication:
        return true;
      case ErrorType.validation:
        return false;
      case ErrorType.server:
        return true;
      case ErrorType.storage:
        return true;
      case ErrorType.unknown:
        return false;
    }
  }

  /// Get recovery action for error type
  String _getRecoveryAction(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return 'Check internet connection and retry';
      case ErrorType.authentication:
        return 'Re-authenticate user';
      case ErrorType.validation:
        return 'Fix input data';
      case ErrorType.server:
        return 'Retry request';
      case ErrorType.storage:
        return 'Clear cache and retry';
      case ErrorType.unknown:
        return 'Contact support';
    }
  }
}

/// Error handling utilities
class ErrorHandler {
  /// Handle network errors
  static void handleNetworkError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.network,
      severity: ErrorSeverity.medium,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Handle authentication errors
  static void handleAuthenticationError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.authentication,
      severity: ErrorSeverity.high,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Handle validation errors
  static void handleValidationError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.validation,
      severity: ErrorSeverity.low,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Handle server errors
  static void handleServerError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.server,
      severity: ErrorSeverity.high,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Handle storage errors
  static void handleStorageError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.storage,
      severity: ErrorSeverity.medium,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }

  /// Handle unknown errors
  static void handleUnknownError(
    ErrorManagementNotifier notifier,
    String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    notifier.addError(
      type: ErrorType.unknown,
      severity: ErrorSeverity.critical,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }
}

/// Error management provider
final errorManagementProvider = StateNotifierProvider<ErrorManagementNotifier, ErrorManagementState>(
  (ref) => ErrorManagementNotifier(),
);

/// Error management notifier provider
final errorManagementNotifierProvider = Provider<ErrorManagementNotifier>((ref) => ref.watch(errorManagementProvider.notifier));

/// Convenience providers
final hasErrorsProvider = Provider<bool>((ref) => ref.watch(errorManagementProvider).errorCount > 0);

final hasCriticalErrorsProvider = Provider<bool>((ref) {
  final notifier = ref.watch(errorManagementNotifierProvider);
  return notifier.hasCriticalErrors();
});

final hasNetworkErrorsProvider = Provider<bool>((ref) {
  final notifier = ref.watch(errorManagementNotifierProvider);
  return notifier.hasNetworkErrors();
});

final hasAuthenticationErrorsProvider = Provider<bool>((ref) {
  final notifier = ref.watch(errorManagementNotifierProvider);
  return notifier.hasAuthenticationErrors();
});

final lastErrorProvider = Provider<ErrorState?>((ref) => ref.watch(errorManagementProvider).lastError);

final errorCountProvider = Provider<int>((ref) => ref.watch(errorManagementProvider).errorCount);

final isHandlingErrorProvider = Provider<bool>((ref) => ref.watch(errorManagementProvider).isHandlingError);
