import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:bel247_web/data/sources/mock/data_loader.dart';
import 'package:bel247_web/data/utils/json_validator.dart';
import 'package:bel247_web/data/utils/json_transformer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Data Loading Utilities Tests', () {
    setUp(DataLoader.clearAllCache);

    group('DataLoader Tests', () {
      test('should load JSON from assets', () async {
        final result = await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        
        expect(result, isA<Map<String, dynamic>>());
        expect(result.isNotEmpty, true);
        expect(result.containsKey('id'), true);
        expect(result.containsKey('email'), true);
      });

      test('should cache loaded data', () async {
        expect(DataLoader.isCached('assets/data/mock_user.json'), false);
        
        await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        
        expect(DataLoader.isCached('assets/data/mock_user.json'), true);
        expect(DataLoader.getCacheSize(), 1);
      });

      test('should load from cache on second call', () async {
        // First load
        await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        
        // Second load should use cache
        final result = await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        
        expect(result, isA<Map<String, dynamic>>());
        expect(result.isNotEmpty, true);
      });

      test('should load list from assets', () async {
        final result = await DataLoader.loadListFromAssets('assets/data/mock_bills.json', 'bills');
        
        expect(result, isA<List<dynamic>>());
        expect(result.isNotEmpty, true);
      });

      test('should clear specific cache', () async {
        await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        await DataLoader.loadJsonFromAssets('assets/data/mock_bills.json');
        
        expect(DataLoader.getCacheSize(), 2);
        
        DataLoader.clearCache('assets/data/mock_user.json');
        
        expect(DataLoader.isCached('assets/data/mock_user.json'), false);
        expect(DataLoader.isCached('assets/data/mock_bills.json'), true);
        expect(DataLoader.getCacheSize(), 1);
      });

      test('should clear all cache', () async {
        await DataLoader.loadJsonFromAssets('assets/data/mock_user.json');
        await DataLoader.loadJsonFromAssets('assets/data/mock_bills.json');
        
        expect(DataLoader.getCacheSize(), 2);
        
        DataLoader.clearAllCache();
        
        expect(DataLoader.getCacheSize(), 0);
        expect(DataLoader.isCached('assets/data/mock_user.json'), false);
        expect(DataLoader.isCached('assets/data/mock_bills.json'), false);
      });

      test('should handle invalid asset path', () async {
        expect(
          () => DataLoader.loadJsonFromAssets('invalid/path.json'),
          throwsA(isA<FlutterError>()),
        );
      });
    });

    group('JsonValidator Tests', () {
      test('should validate required fields', () {
        final json = {
          'id': '123',
          'email': 'test@example.com',
          'name': 'Test User',
        };
        
        expect(
          JsonValidator.validateRequiredFields(json, ['id', 'email']),
          true,
        );
        
        expect(
          JsonValidator.validateRequiredFields(json, ['id', 'missing']),
          false,
        );
      });

      test('should validate field types', () {
        final json = {
          'id': '123',
          'age': 25,
          'active': true,
        };
        
        expect(
          JsonValidator.validateFieldTypes(json, {
            'id': String,
            'age': int,
            'active': bool,
          }),
          true,
        );
        
        expect(
          JsonValidator.validateFieldTypes(json, {
            'id': int, // Wrong type
          }),
          false,
        );
      });

      test('should validate list structure', () {
        final list = [
          {'id': '1', 'name': 'Item 1'},
          {'id': '2', 'name': 'Item 2'},
        ];
        
        expect(
          JsonValidator.validateListStructure(list, ['id', 'name']),
          true,
        );
        
        expect(
          JsonValidator.validateListStructure(list, ['id', 'missing']),
          false,
        );
      });

      test('should validate date format', () {
        expect(JsonValidator.validateDateFormat('2023-12-01'), true);
        expect(JsonValidator.validateDateFormat('2023-12-01T10:30:00Z'), true);
        expect(JsonValidator.validateDateFormat('invalid-date'), false);
      });

      test('should validate email format', () {
        expect(JsonValidator.validateEmailFormat('test@example.com'), true);
        expect(JsonValidator.validateEmailFormat('user.name+tag@domain.co.uk'), true);
        expect(JsonValidator.validateEmailFormat('invalid-email'), false);
        expect(JsonValidator.validateEmailFormat('test@'), false);
      });

      test('should validate numeric range', () {
        expect(JsonValidator.validateNumericRange(5, 1, 10), true);
        expect(JsonValidator.validateNumericRange(0, 1, 10), false);
        expect(JsonValidator.validateNumericRange(15, 1, 10), false);
      });
    });

    group('JsonTransformer Tests', () {
      test('should transform list of JSON objects', () {
        final jsonList = [
          {'id': '1', 'name': 'Item 1'},
          {'id': '2', 'name': 'Item 2'},
        ];
        
        final result = JsonTransformer.transformList(
          jsonList,
          (json) => {'id': json['id'], 'name': json['name']},
        );
        
        expect(result.length, 2);
        expect(result[0]['id'], '1');
        expect(result[1]['name'], 'Item 2');
      });

      test('should transform single JSON object', () {
        final json = {'id': '1', 'name': 'Item 1'};
        
        final result = JsonTransformer.transformSingle(
          json,
          (json) => {'id': json['id'], 'name': json['name']},
        );
        
        expect(result, isNotNull);
        expect(result!['id'], '1');
        expect(result['name'], 'Item 1');
      });

      test('should filter JSON list', () {
        final jsonList = [
          {'id': '1', 'active': true},
          {'id': '2', 'active': false},
          {'id': '3', 'active': true},
        ];
        
        final result = JsonTransformer.filterJsonList(
          jsonList,
          (item) => item['active'] == true,
        );
        
        expect(result.length, 2);
        expect(result[0]['id'], '1');
        expect(result[1]['id'], '3');
      });

      test('should sort JSON list', () {
        final jsonList = [
          {'id': '3', 'name': 'Charlie'},
          {'id': '1', 'name': 'Alice'},
          {'id': '2', 'name': 'Bob'},
        ];
        
        final result = JsonTransformer.sortJsonList(jsonList, 'name');
        
        expect(result.length, 3);
        expect(result[0]['name'], 'Alice');
        expect(result[1]['name'], 'Bob');
        expect(result[2]['name'], 'Charlie');
      });

      test('should group JSON list', () {
        final jsonList = [
          {'category': 'A', 'value': 1},
          {'category': 'B', 'value': 2},
          {'category': 'A', 'value': 3},
        ];
        
        final result = JsonTransformer.groupJsonList(jsonList, 'category');
        
        expect(result.keys.length, 2);
        expect(result['A']!.length, 2);
        expect(result['B']!.length, 1);
      });

      test('should calculate statistics', () {
        final jsonList = [
          {'value': 10},
          {'value': 20},
          {'value': 30},
          {'value': 40},
        ];
        
        final result = JsonTransformer.calculateStatistics(jsonList, 'value');
        
        expect(result['count'], 4);
        expect(result['sum'], 100);
        expect(result['average'], 25);
        expect(result['min'], 10);
        expect(result['max'], 40);
        expect(result['median'], 25);
      });

      test('should pretty print JSON', () {
        final json = {'id': '1', 'name': 'Test'};
        
        final result = JsonTransformer.prettyPrint(json);
        
        expect(result, contains('"id"'));
        expect(result, contains('"name"'));
        expect(result, contains('"Test"'));
      });

      test('should deep merge JSON objects', () {
        final base = {
          'id': '1',
          'user': {'name': 'John', 'age': 30},
        };
        
        final override = {
          'user': {'age': 31, 'city': 'New York'},
          'active': true,
        };
        
        final result = JsonTransformer.deepMerge(base, override);
        
        expect(result['id'], '1');
        expect(result['user']['name'], 'John');
        expect(result['user']['age'], 31);
        expect(result['user']['city'], 'New York');
        expect(result['active'], true);
      });
    });
  });
}
