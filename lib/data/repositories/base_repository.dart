import 'package:dio/dio.dart';

/// Base repository interface that defines common operations
abstract class BaseRepository {
  /// Generic method to handle API responses
  Future<T> handleResponse<T>(
    Future<Response> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  );

  /// Generic method to handle API errors
  void handleError(DioException error);
}

/// Result wrapper for repository operations
sealed class Result<T> {
  const Result();
}

/// Success result containing data
class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

/// Error result containing error information
class Error<T> extends Result<T> {
  const Error(this.message, [this.statusCode]);
  final String message;
  final int? statusCode;
}

/// Loading state for async operations
class Loading<T> extends Result<T> {
  const Loading();
}
