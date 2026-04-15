import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/error_messages.dart';
import 'logger.dart';

/// Utility for translating raw exceptions into user-friendly strings and
/// for showing standard error UI components.
///
/// All messages exposed to users come from [ErrorMessages] — no raw error
/// strings or technical details are ever surfaced.
class ErrorHandler {
  ErrorHandler._();

  /// Log the error for diagnostic purposes without exposing details to the user.
  static void handleError(
    Object error,
    StackTrace stackTrace, {
    String? context,
  }) {
    Logger.error(
      'Error occurred${context != null ? ' in $context' : ''}',
      error: error,
      stackTrace: stackTrace,
      tag: 'ErrorHandler',
    );
  }

  /// Translate any exception into a short, plain-language message.
  ///
  /// Priority order:
  /// 1. [DioException] status codes / types (network, auth, server)
  /// 2. String keyword matching for legacy error types
  /// 3. Generic fallback
  static String getErrorMessage(Object error) {
    // ── DioException (API layer) ──────────────────────────────────────────
    if (error is DioException) {
      return _dioMessage(error);
    }

    if (error is String) {
      return error;
    }

    // ── String-based fallbacks for non-Dio errors ────────────────────────
    final s = error.toString();

    if (s.contains('SocketException') ||
        s.contains('NetworkException') ||
        s.contains('Failed host lookup')) {
      return ErrorMessages.noInternet;
    }

    if (s.contains('TimeoutException')) {
      return ErrorMessages.timeout;
    }

    if (s.contains('FormatException')) {
      return ErrorMessages.parseFailed;
    }

    if (s.contains('Unauthorized') || s.contains('401')) {
      return ErrorMessages.sessionExpired;
    }

    if (s.contains('Forbidden') || s.contains('403')) {
      return ErrorMessages.forbidden;
    }

    if (s.contains('NotFound') || s.contains('404')) {
      return ErrorMessages.pageNotFound;
    }

    if (s.contains('ServerException') ||
        s.contains('500') ||
        s.contains('503')) {
      return ErrorMessages.serverError;
    }

    return ErrorMessages.unexpected;
  }

  // ── Private helpers ──────────────────────────────────────────────────────

  static String _dioMessage(DioException e) {
    final status = e.response?.statusCode;

    // HTTP status-based messages
    if (status != null) {
      if (status == 401) return ErrorMessages.sessionExpired;
      if (status == 403) return ErrorMessages.forbidden;
      if (status == 404) return ErrorMessages.pageNotFound;
      if (status == 408 || status == 504) return ErrorMessages.timeout;
      if (status == 429) {
        return "We're getting a lot of requests right now. Try again in a moment.";
      }
      if (status >= 500) return ErrorMessages.serverError;
      if (status >= 400) return ErrorMessages.tryAgain;
    }

    // Connection / timeout type errors
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.timeout;
      case DioExceptionType.connectionError:
        return ErrorMessages.noInternet;
      case DioExceptionType.cancel:
        return ErrorMessages.tryAgain;
      case DioExceptionType.badResponse:
        return ErrorMessages.serverError;
      case DioExceptionType.unknown:
        // Attempt to detect offline scenarios buried in the inner error
        final inner = e.error?.toString() ?? '';
        if (inner.contains('SocketException') ||
            inner.contains('Failed host lookup')) {
          return ErrorMessages.noInternet;
        }
        return ErrorMessages.unexpected;
      default:
        return ErrorMessages.unexpected;
    }
  }

  // ── UI helpers ────────────────────────────────────────────────────────────

  /// Show a modal dialog for errors that require user acknowledgement.
  static void showErrorDialog(BuildContext context, Object error) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('Something went wrong'),
        content: Text(getErrorMessage(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show a brief snackbar for recoverable, non-blocking errors.
  static void showErrorSnackBar(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(getErrorMessage(error)),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ── Shared state helpers ────────────────────────────────────────────────────

class LoadingState {
  const LoadingState({
    this.isLoading = false,
    this.message,
  });

  final bool isLoading;
  final String? message;

  LoadingState copyWith({bool? isLoading, String? message}) => LoadingState(
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
      );
}

class ApiResponse<T> {
  const ApiResponse({
    this.data,
    this.error,
    this.success = false,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {int? statusCode}) => ApiResponse(
        data: data,
        success: true,
        statusCode: statusCode,
      );

  factory ApiResponse.error(String error, {int? statusCode}) => ApiResponse(
        error: error,
        success: false,
        statusCode: statusCode,
      );

  final T? data;
  final String? error;
  final bool success;
  final int? statusCode;
}
