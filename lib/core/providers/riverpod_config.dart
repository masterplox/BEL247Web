import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod configuration and provider setup
class RiverpodConfig {
  /// Enable provider override for testing
  static const bool enableProviderOverride = false;

  /// Provider observer for debugging
  static ProviderObserver? get observer => null;

  /// Global provider overrides
  static List<Override> get globalOverrides => [];

  /// Feature-specific provider overrides
  static Map<String, List<Override>> get featureOverrides => {};

  /// Provider scope configuration
  static ProviderScope createScope({
    required Widget child,
    List<Override>? overrides,
  }) => ProviderScope(
      observers: observer != null ? [observer!] : null,
      overrides: [
        ...globalOverrides,
        ...?overrides,
      ],
      child: child,
    );

  /// Create feature-specific scope
  static ProviderScope createFeatureScope({
    required Widget child,
    required String featureName,
    List<Override>? overrides,
  }) {
    final featureOverridesList = featureOverrides[featureName] ?? [];
    
    return ProviderScope(
      observers: observer != null ? [observer!] : null,
      overrides: [
        ...globalOverrides,
        ...featureOverridesList,
        ...?overrides,
      ],
      child: child,
    );
  }
}

/// Provider observer for debugging and logging
class DebugProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // Log provider updates in debug mode
    if (provider.name != null) {
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    // Log provider disposal in debug mode
    if (provider.name != null) {
    }
  }
}

/// Provider utilities for common patterns
class ProviderUtils {
  /// Create a family provider with error handling
  static ProviderFamily<T, P> createFamilyProvider<T, P>({
    required String name,
    required T Function(P param) create,
    T? Function(P param)? onError,
  }) => Provider.family<T, P>(
      name: name,
      (ref, param) {
        try {
          return create(param);
        } catch (e) {
          if (onError != null) {
            final result = onError(param);
            if (result != null) {
              return result;
            }
          }
          rethrow;
        }
      },
    );

  /// Create an async provider with error handling
  static FutureProvider<T> createAsyncProvider<T>({
    required String name,
    required Future<T> Function() create,
    Future<T> Function()? onError,
  }) => FutureProvider<T>(
      name: name,
      (ref) async {
        try {
          return await create();
        } catch (e) {
          if (onError != null) {
            return onError();
          }
          rethrow;
        }
      },
    );

  /// Create a state notifier provider with error handling
  static StateNotifierProvider<T, U> createStateNotifierProvider<T extends StateNotifier<U>, U>({
    required String name,
    required T Function() create,
    T Function()? onError,
  }) => StateNotifierProvider<T, U>(
      name: name,
      (ref) {
        try {
          return create();
        } catch (e) {
          if (onError != null) {
            return onError();
          }
          rethrow;
        }
      },
    );
}

/// Provider container utilities
class ProviderContainerUtils {
  /// Create a test container with overrides
  static ProviderContainer createTestContainer({
    List<Override>? overrides,
    ProviderObserver? observer,
  }) => ProviderContainer(
      overrides: overrides ?? [],
      observers: observer != null ? [observer] : null,
    );

  /// Dispose container safely
  static void disposeContainer(ProviderContainer container) {
    try {
      container.dispose();
    } catch (e) {
      // Log error but don't throw
    }
  }
}
