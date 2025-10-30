import 'package:bel247_web/data/repositories/base_repository.dart';
import 'package:bel247_web/data/sources/mock/mock_bill_repository.dart';
import 'package:bel247_web/data/sources/mock/mock_consumption_repository.dart';
import 'package:bel247_web/data/sources/mock/mock_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mock Repository Tests', () {
    late MockUserRepository userRepository;
    late MockBillRepository billRepository;
    late MockConsumptionRepository consumptionRepository;

    setUp(() {
      userRepository = MockUserRepository();
      billRepository = MockBillRepository();
      consumptionRepository = MockConsumptionRepository();
    });

    group('MockUserRepository', () {
      test('should get current user successfully', () async {
        final result = await userRepository.getCurrentUser();
        
        expect(result, isA<Success>());
        final user = (result as Success).data;
        expect(user.id, 'user_001');
        expect(user.email, 'john.doe@example.com');
        expect(user.firstName, 'John');
        expect(user.lastName, 'Doe');
      });

      test('should get user by ID successfully', () async {
        final result = await userRepository.getUserById('user_001');
        
        expect(result, isA<Success>());
        final user = (result as Success).data;
        expect(user.id, 'user_001');
        expect(user.email, 'john.doe@example.com');
      });

      test('should get account balance successfully', () async {
        final result = await userRepository.getAccountBalance('user_001');
        
        expect(result, isA<Success>());
        final balance = (result as Success).data;
        expect(balance.currentBalance, 125.50);
        expect(balance.lastPaymentAmount, 89.75);
      });

      test('should get usage summary successfully', () async {
        final result = await userRepository.getUsageSummary('user_001');
        
        expect(result, isA<Success>());
        final summary = (result as Success).data;
        expect(summary.currentMonth.kwh, 456.7);
        expect(summary.currentMonth.cost, 89.75);
      });
    });

    group('MockBillRepository', () {
      test('should get bills successfully', () async {
        final result = await billRepository.getBills('user_001');
        
        expect(result, isA<Success>());
        final billsResponse = (result as Success).data;
        expect(billsResponse.bills.length, 5);
        expect(billsResponse.summary.totalBills, 5);
      });

      test('should get latest bill successfully', () async {
        final result = await billRepository.getLatestBill('user_001');
        
        expect(result, isA<Success>());
        final bill = (result as Success).data;
        expect(bill.id, 'bill_001');
        expect(bill.billNumber, 'INV-2024-001');
        expect(bill.status, 'paid');
      });

      test('should get bills summary successfully', () async {
        final result = await billRepository.getBillsSummary('user_001');
        
        expect(result, isA<Success>());
        final summary = (result as Success).data;
        expect(summary.totalBills, 5);
        expect(summary.totalPaid, 511.75);
        expect(summary.averageMonthlyBill, 102.35);
      });

      test('should process payment successfully', () async {
        final result = await billRepository.processPayment('bill_001', 89.75, 'Credit Card');
        
        expect(result, isA<Success>());
        final payment = (result as Success).data;
        expect(payment.paidAmount, 89.75);
        expect(payment.paymentMethod, 'Credit Card');
        expect(payment.transactionId, isNotEmpty);
      });
    });

    group('MockConsumptionRepository', () {
      test('should get daily consumption successfully', () async {
        final date = DateTime.parse('2024-01-27T00:00:00Z');
        final result = await consumptionRepository.getDailyConsumption('user_001', date);
        
        expect(result, isA<Success>());
        final consumption = (result as Success).data;
        expect(consumption.totalKwh, 15.2);
        expect(consumption.cost, 1.82);
        expect(consumption.hourlyBreakdown.length, 24);
      });

      test('should get hourly consumption successfully', () async {
        final date = DateTime.parse('2024-01-27T00:00:00Z');
        final result = await consumptionRepository.getHourlyConsumption('user_001', date);
        
        expect(result, isA<Success>());
        final hourlyData = (result as Success).data;
        expect(hourlyData.length, 24);
        expect(hourlyData[0].hour, 0);
        expect(hourlyData[0].kwh, 0.4);
      });

      test('should get monthly consumption successfully', () async {
        final result = await consumptionRepository.getMonthlyConsumption('user_001', '2024-01');
        
        expect(result, isA<Success>());
        final consumption = (result as Success).data;
        expect(consumption.month, '2024-01');
        expect(consumption.totalKwh, 456.7);
        expect(consumption.totalCost, 89.75);
      });

      test('should get usage statistics successfully', () async {
        final result = await consumptionRepository.getUsageStatistics('user_001');
        
        expect(result, isA<Success>());
        final statistics = (result as Success).data;
        expect(statistics.averageDailyUsage, 15.8);
        expect(statistics.averageMonthlyUsage, 474.6);
        expect(statistics.peakUsageHour, 18);
        expect(statistics.lowestUsageHour, 2);
      });

      test('should get consumption alerts successfully', () async {
        final result = await consumptionRepository.getConsumptionAlerts('user_001');
        
        expect(result, isA<Success>());
        final alerts = (result as Success).data;
        expect(alerts.length, 2);
        expect(alerts[0]['type'], 'high_usage');
        expect(alerts[1]['type'], 'peak_hour');
      });
    });
  });
}
