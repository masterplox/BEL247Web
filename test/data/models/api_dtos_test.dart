import 'package:bel247_web/data/models/api_dtos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('API DTOs Tests', () {
    // Note: Many tests are commented out because the corresponding classes
    // don't exist in api_dtos.dart yet. These tests should be uncommented
    // when the corresponding DTOs are implemented.
    
    test('ApiResponse serialization', () {
      const response = ApiResponse<String>(
        success: true,
        message: 'Success',
        data: 'test data',
      );

      final json = response.toJson((data) => data);
      final fromJson = ApiResponse.fromJson(json, (json) => json as String);

      expect(fromJson.success, equals(true));
      expect(fromJson.message, equals('Success'));
      expect(fromJson.data, equals('test data'));
    });

    test('PaginationInfo serialization', () {
      const pagination = PaginationInfo(
        currentPage: 1,
        totalPages: 10,
        totalItems: 100,
        itemsPerPage: 10,
        hasNextPage: true,
        hasPreviousPage: false,
      );

      final json = pagination.toJson();
      final fromJson = PaginationInfo.fromJson(json);

      expect(fromJson.currentPage, equals(1));
      expect(fromJson.totalPages, equals(10));
      expect(fromJson.totalItems, equals(100));
      expect(fromJson.itemsPerPage, equals(10));
      expect(fromJson.hasNextPage, equals(true));
      expect(fromJson.hasPreviousPage, equals(false));
    });

    test('PaginatedResponse serialization', () {
      const pagination = PaginationInfo(
        currentPage: 1,
        totalPages: 5,
        totalItems: 50,
        itemsPerPage: 10,
        hasNextPage: true,
        hasPreviousPage: false,
      );

      const response = PaginatedResponse<String>(
        data: ['item1', 'item2', 'item3'],
        pagination: pagination,
      );

      final json = response.toJson((data) => data);
      final fromJson = PaginatedResponse.fromJson(json, (json) => json as String);

      expect(fromJson.data, equals(['item1', 'item2', 'item3']));
      expect(fromJson.pagination.currentPage, equals(1));
    });
  });
}