import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/providers/riverpod_config.dart';
import 'core/utils/logger.dart';

void main() {
  // Catch synchronous Flutter framework errors (e.g. widget build errors)
  // and log them without showing a red error screen to users.
  FlutterError.onError = (FlutterErrorDetails details) {
    // Still send to Flutter's default handler in debug mode for stack traces
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
    Logger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
      tag: 'GlobalErrorHandler',
    );
  };

  // Catch all uncaught async errors (Futures, Streams, isolate errors)
  // that escape the widget tree.
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      // Replace the default red-screen error widget with a silent placeholder.
      // Individual [ErrorBoundary] widgets provide localised recovery UI.
      if (!kDebugMode) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          Logger.error(
            'Widget build error caught by global handler',
            error: details.exception,
            stackTrace: details.stack,
            tag: 'ErrorWidget',
          );
          // Return an invisible placeholder — the parent ErrorBoundary will
          // detect this and show its friendly fallback.
          return const SizedBox.shrink();
        };
      }

      runApp(
        RiverpodConfig.createScope(
          child: const BEL247App(),
        ),
      );
    },
    (error, stackTrace) {
      // Uncaught async error — log it, but don't crash the app.
      Logger.error(
        'Uncaught async error',
        error: error,
        stackTrace: stackTrace,
        tag: 'GlobalErrorHandler',
      );
    },
  );
}
