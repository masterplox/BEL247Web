import 'package:flutter/material.dart';
import 'logger.dart';

class ErrorHandler {
  static void handleError(Object error, StackTrace stackTrace, {String? context}) {
    Logger.error(
      'Error occurred${context != null ? ' in $context' : ''}',
      error: error,
      stackTrace: stackTrace,
      tag: 'ErrorHandler',
    );
  }
  
  static String getErrorMessage(Object error) {
    if (error is String) {
      return error;
    }
    
    // Handle common error types
    final errorString = error.toString();
    
    if (errorString.contains('SocketException') || errorString.contains('NetworkException')) {
      return 'Network connection error. Please check your internet connection.';
    }
    
    if (errorString.contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }
    
    if (errorString.contains('FormatException')) {
      return 'Invalid data format received.';
    }
    
    if (errorString.contains('Unauthorized') || errorString.contains('401')) {
      return 'Authentication failed. Please login again.';
    }
    
    if (errorString.contains('Forbidden') || errorString.contains('403')) {
      return 'Access denied. You do not have permission to perform this action.';
    }
    
    if (errorString.contains('NotFound') || errorString.contains('404')) {
      return 'The requested resource was not found.';
    }
    
    if (errorString.contains('ServerException') || errorString.contains('500')) {
      return 'Server error. Please try again later.';
    }
    
    return 'An unexpected error occurred. Please try again.';
  }
  
  static void showErrorDialog(BuildContext context, Object error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(getErrorMessage(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  static void showErrorSnackBar(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(getErrorMessage(error)),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

class LoadingState {
  
  const LoadingState({
    this.isLoading = false,
    this.message,
  });
  final bool isLoading;
  final String? message;
  
  LoadingState copyWith({
    bool? isLoading,
    String? message,
  }) => LoadingState(
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
