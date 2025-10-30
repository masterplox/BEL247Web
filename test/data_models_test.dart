import 'package:bel247_web/data/models/bill.dart';
import 'package:bel247_web/data/models/consumption.dart';
import 'package:bel247_web/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data Models Serialization Tests', () {
    test('User model serialization/deserialization', () {
      // Test data matching our mock_user.json structure
      final userJson = {
        'id': 'user_001',
        'email': 'john.doe@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'phone': '+1-555-0123',
        'address': {
          'street': '123 Main Street',
          'city': 'Springfield',
          'state': 'IL',
          'zipCode': '62701',
          'country': 'USA'
        },
        'accountNumber': 'BEL247-001234',
        'serviceAddress': {
          'street': '123 Main Street',
          'city': 'Springfield',
          'state': 'IL',
          'zipCode': '62701',
          'country': 'USA'
        },
        'meterNumber': 'MTR-789456',
        'tariffPlan': 'Residential Standard',
        'connectionDate': '2020-03-15T00:00:00Z',
        'lastLogin': '2024-01-27T10:30:00Z',
        'preferences': {
          'notifications': {
            'email': true,
            'sms': false,
            'push': true
          },
          'currency': 'USD',
          'timezone': 'America/Chicago',
          'language': 'en'
        },
        'accountBalance': {
          'currentBalance': 125.50,
          'lastPaymentDate': '2024-01-15T00:00:00Z',
          'lastPaymentAmount': 89.75,
          'nextDueDate': '2024-02-15T00:00:00Z',
          'paymentMethod': 'Credit Card ending in 1234'
        },
        'usageSummary': {
          'currentMonth': {
            'kwh': 456.7,
            'cost': 89.75,
            'averageDaily': 15.2
          },
          'lastMonth': {
            'kwh': 523.4,
            'cost': 98.50,
            'averageDaily': 16.9
          },
          'yearToDate': {
            'kwh': 5234.5,
            'cost': 987.25,
            'averageDaily': 15.8
          }
        }
      };

      // Test deserialization
      final user = User.fromJson(userJson);
      expect(user.id, 'user_001');
      expect(user.email, 'john.doe@example.com');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.address.city, 'Springfield');
      expect(user.accountBalance.currentBalance, 125.50);
      expect(user.usageSummary.currentMonth.kwh, 456.7);

      // Test serialization
      final userJsonFromModel = user.toJson();
      expect(userJsonFromModel['id'], 'user_001');
      expect(userJsonFromModel['email'], 'john.doe@example.com');
      expect(userJsonFromModel['firstName'], 'John');
    });

    test('Bill model serialization/deserialization', () {
      final billJson = {
        'id': 'bill_001',
        'accountNumber': 'BEL247-001234',
        'billNumber': 'INV-2024-001',
        'billingPeriod': {
          'startDate': '2024-01-01T00:00:00Z',
          'endDate': '2024-01-31T23:59:59Z'
        },
        'dueDate': '2024-02-15T00:00:00Z',
        'issueDate': '2024-02-01T00:00:00Z',
        'status': 'paid',
        'amounts': {
          'totalAmount': 89.75,
          'previousBalance': 0.00,
          'currentCharges': 89.75,
          'taxes': 7.18,
          'fees': 2.50,
          'adjustments': 0.00
        },
        'usage': {
          'kwhUsed': 456.7,
          'kwhRate': 0.12,
          'baseCharge': 15.00,
          'deliveryCharge': 25.50,
          'generationCharge': 54.75
        },
        'payment': {
          'paidDate': '2024-01-15T00:00:00Z',
          'paidAmount': 89.75,
          'paymentMethod': 'Credit Card ending in 1234',
          'transactionId': 'TXN-789456123'
        },
        'pdfUrl': '/api/bills/bill_001/pdf'
      };

      // Test deserialization
      final bill = Bill.fromJson(billJson);
      expect(bill.id, 'bill_001');
      expect(bill.billNumber, 'INV-2024-001');
      expect(bill.status, 'paid');
      expect(bill.amounts.totalAmount, 89.75);
      expect(bill.usage.kwhUsed, 456.7);

      // Test serialization
      final billJsonFromModel = bill.toJson();
      expect(billJsonFromModel['id'], 'bill_001');
      expect(billJsonFromModel['status'], 'paid');
    });

    test('Consumption model serialization/deserialization', () {
      final consumptionJson = {
        'date': '2024-01-27T00:00:00Z',
        'totalKwh': 15.2,
        'cost': 1.82,
        'hourlyBreakdown': [
          {'hour': 0, 'kwh': 0.4, 'cost': 0.05},
          {'hour': 1, 'kwh': 0.3, 'cost': 0.04},
          {'hour': 2, 'kwh': 0.3, 'cost': 0.04}
        ]
      };

      // Test deserialization
      final dailyConsumption = DailyConsumption.fromJson(consumptionJson);
      expect(dailyConsumption.totalKwh, 15.2);
      expect(dailyConsumption.cost, 1.82);
      expect(dailyConsumption.hourlyBreakdown.length, 3);
      expect(dailyConsumption.hourlyBreakdown[0].hour, 0);
      expect(dailyConsumption.hourlyBreakdown[0].kwh, 0.4);

      // Test serialization
      final consumptionJsonFromModel = dailyConsumption.toJson();
      expect(consumptionJsonFromModel['totalKwh'], 15.2);
      expect(consumptionJsonFromModel['cost'], 1.82);
    });
  });
}
