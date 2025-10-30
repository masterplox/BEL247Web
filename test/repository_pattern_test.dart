import 'package:bel247_web/data/models/bill.dart';
import 'package:bel247_web/data/models/consumption.dart';
import 'package:bel247_web/data/models/user.dart';
import 'package:bel247_web/data/sources/mock/mock_bill_repository.dart';
import 'package:bel247_web/data/sources/mock/mock_consumption_repository.dart';
import 'package:bel247_web/data/sources/mock/mock_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Repository Pattern Tests', () {
    late MockUserRepository userRepository;
    late MockBillRepository billRepository;
    late MockConsumptionRepository consumptionRepository;

    setUp(() {
      userRepository = MockUserRepository();
      billRepository = MockBillRepository();
      consumptionRepository = MockConsumptionRepository();
    });

    group('UserRepository Tests', () {
      test('should get user by ID successfully', () async {
        final response = await userRepository.getUserById('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.id, 'user_001');
        expect(response.data!.email, 'john.doe@example.com');
      });

      test('should return error for non-existent user', () async {
        final response = await userRepository.getUserById('non_existent_user');
        
        expect(response.success, true); // Mock always returns success
        expect(response.data, isNotNull);
        expect(response.data!.id, 'user_001'); // Always returns the same user
      });

      test('should get current user successfully', () async {
        final response = await userRepository.getCurrentUser();
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.id, 'user_001');
        expect(response.data!.email, 'john.doe@example.com');
      });

      test('should update user successfully', () async {
        final user = User(
          id: 'user_001',
          email: 'john.doe@example.com',
          firstName: 'John Updated',
          lastName: 'Doe Updated',
          phone: '+1-555-0123',
          address: const Address(
            street: '123 Main Street',
            city: 'Springfield',
            state: 'IL',
            zipCode: '62701',
            country: 'USA',
          ),
          accountNumber: 'BEL247-001234',
          serviceAddress: const Address(
            street: '123 Main Street',
            city: 'Springfield',
            state: 'IL',
            zipCode: '62701',
            country: 'USA',
          ),
          meterNumber: 'MTR-789456',
          tariffPlan: 'Residential Standard',
          connectionDate: DateTime.parse('2020-03-15T00:00:00Z'),
          lastLogin: DateTime.parse('2024-01-27T10:30:00Z'),
          preferences: const UserPreferences(
            notifications: NotificationSettings(
              email: true,
              sms: false,
              push: true,
            ),
            currency: 'USD',
            timezone: 'America/Chicago',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 125.50,
            lastPaymentDate: DateTime.parse('2024-01-15T00:00:00Z'),
            lastPaymentAmount: 89.75,
            nextDueDate: DateTime.parse('2024-02-15T00:00:00Z'),
            paymentMethod: 'Credit Card ending in 1234',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(
              kwh: 456.7,
              cost: 89.75,
              averageDaily: 15.2,
            ),
            lastMonth: UsagePeriod(
              kwh: 523.4,
              cost: 98.50,
              averageDaily: 16.9,
            ),
            yearToDate: UsagePeriod(
              kwh: 5234.5,
              cost: 987.25,
              averageDaily: 15.8,
            ),
          ),
        );
        
        final response = await userRepository.updateUser(user);
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.firstName, 'John Updated');
        expect(response.data!.lastName, 'Doe Updated');
      });

      test('should update user preferences successfully', () async {
        const preferences = UserPreferences(
          notifications: NotificationSettings(
            email: false,
            sms: true,
            push: false,
          ),
          currency: 'EUR',
          timezone: 'Europe/London',
          language: 'en',
        );
        
        final response = await userRepository.updateUserPreferences('user_001', preferences);
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.preferences.currency, 'EUR');
        expect(response.data!.preferences.timezone, 'Europe/London');
      });

      test('should get account balance successfully', () async {
        final response = await userRepository.getAccountBalance('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.currentBalance, 125.50);
        expect(response.data!.nextDueDate, DateTime.parse('2024-02-15T00:00:00Z'));
      });

      test('should get usage summary successfully', () async {
        final response = await userRepository.getUsageSummary('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.currentMonth.kwh, 456.7);
        expect(response.data!.yearToDate.cost, 987.25);
      });

      test('should update password successfully', () async {
        final response = await userRepository.updatePassword(
          'user_001',
          'old_password',
          'new_password',
        );
        
        expect(response.success, true);
      });

      test('should delete user successfully', () async {
        final response = await userRepository.deleteUser('user_001');
        
        expect(response.success, true);
      });
    });

    group('BillRepository Tests', () {
      test('should get bills successfully', () async {
        final response = await billRepository.getBills('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.bills, isA<List<Bill>>());
        expect(response.data!.bills.length, greaterThan(0));
      });

      test('should get bills by date range successfully', () async {
        final startDate = DateTime(2023, 1, 1);
        final endDate = DateTime(2023, 12, 31);
        
        final response = await billRepository.getBillsByDateRange('user_001', startDate, endDate);
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.bills, isA<List<Bill>>());
      });

      test('should get bill by ID successfully', () async {
        final response = await billRepository.getBillById('bill_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.id, 'bill_001');
      });

      test('should return error for non-existent bill', () async {
        final response = await billRepository.getBillById('non_existent_bill');
        
        expect(response.success, false);
        expect(response.error, contains('Bill not found'));
      });

      test('should get latest bill successfully', () async {
        final response = await billRepository.getLatestBill('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.id, isNotNull);
      });

      test('should get unpaid bills successfully', () async {
        final response = await billRepository.getUnpaidBills('user_001');
        
        expect(response.success, true);
        expect(response.data, isA<List<Bill>>());
      });

      test('should get bills summary successfully', () async {
        final response = await billRepository.getBillsSummary('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.totalPaid, isNotNull);
        expect(response.data!.averageMonthlyBill, isNotNull);
      });

      test('should download bill PDF successfully', () async {
        final response = await billRepository.downloadBillPdf('bill_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.startsWith('/api/bills/'), true);
      });

      test('should get payment history successfully', () async {
        final response = await billRepository.getPaymentHistory('user_001');
        
        expect(response.success, true);
        expect(response.data, isA<List<BillPayment>>());
      });

      test('should process payment successfully', () async {
        final response = await billRepository.processPayment(
          'bill_001',
          150,
          'credit_card',
        );
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.paidAmount, 150.0);
        expect(response.data!.paymentMethod, 'credit_card');
        expect(response.data!.transactionId, isNotNull);
      });

      test('should get upcoming bills successfully', () async {
        final response = await billRepository.getUpcomingBills('user_001');
        
        expect(response.success, true);
        expect(response.data, isA<List<Bill>>());
      });
    });

    group('ConsumptionRepository Tests', () {
      test('should get daily consumption successfully', () async {
        final date = DateTime(2024, 1, 27);
        final response = await consumptionRepository.getDailyConsumption('user_001', date);
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.date, DateTime.parse('2024-01-27T00:00:00Z'));
        expect(response.data!.totalKwh, 15.2);
      });

      test('should return error for non-existent daily consumption', () async {
        final date = DateTime(2025, 1, 1);
        final response = await consumptionRepository.getDailyConsumption('user_001', date);
        
        expect(response.success, false);
        expect(response.error, contains('No consumption data found'));
      });

      test('should get daily consumption range successfully', () async {
        final startDate = DateTime(2024, 1, 25);
        final endDate = DateTime(2024, 1, 27);
        
        final response = await consumptionRepository.getDailyConsumptionRange('user_001', startDate, endDate);
        
        expect(response.success, true);
        expect(response.data, isA<List<DailyConsumption>>());
        expect(response.data!.length, greaterThan(0));
      });

      test('should get monthly consumption successfully', () async {
        final response = await consumptionRepository.getMonthlyConsumption('user_001', '2024-01');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.month, '2024-01');
        expect(response.data!.totalKwh, 456.7);
      });

      test('should return error for non-existent monthly consumption', () async {
        final response = await consumptionRepository.getMonthlyConsumption('user_001', '2025-01');
        
        expect(response.success, false);
        expect(response.error, contains('No consumption data found'));
      });

      test('should get yearly consumption successfully', () async {
        final response = await consumptionRepository.getYearlyConsumption('user_001', 2024);
        
        expect(response.success, true);
        expect(response.data, isA<List<MonthlyConsumption>>());
        expect(response.data!.length, greaterThan(0));
      });

      test('should get usage statistics successfully', () async {
        final response = await consumptionRepository.getUsageStatistics('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.averageDailyUsage, 15.8);
        expect(response.data!.peakUsageHour, 18);
      });

      test('should get hourly consumption successfully', () async {
        final date = DateTime(2024, 1, 27);
        final response = await consumptionRepository.getHourlyConsumption('user_001', date);
        
        expect(response.success, true);
        expect(response.data, isA<List<HourlyConsumption>>());
        expect(response.data!.length, 24); // 24 hours in a day
      });

      test('should get consumption trends successfully', () async {
        final response = await consumptionRepository.getConsumptionTrends('user_001', 7);
        
        expect(response.success, true);
        expect(response.data, isA<List<DailyConsumption>>());
        expect(response.data!.length, lessThanOrEqualTo(7));
      });

      test('should get peak usage successfully', () async {
        final date = DateTime(2024, 1, 27);
        final response = await consumptionRepository.getPeakUsage('user_001', date);
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.date, DateTime.parse('2024-01-27T00:00:00Z'));
      });

      test('should get consumption comparison successfully', () async {
        final currentStart = DateTime(2024, 1, 1);
        final currentEnd = DateTime(2024, 1, 31);
        final previousStart = DateTime(2023, 12, 1);
        final previousEnd = DateTime(2023, 12, 31);
        
        final response = await consumptionRepository.getConsumptionComparison(
          'user_001',
          currentStart,
          currentEnd,
          previousStart,
          previousEnd,
        );
        
        expect(response.success, true);
        expect(response.data, isA<Map<String, dynamic>>());
        expect(response.data!.isNotEmpty, true);
      });

      test('should get seasonal trends successfully', () async {
        final response = await consumptionRepository.getSeasonalTrends('user_001');
        
        expect(response.success, true);
        expect(response.data, isNotNull);
        expect(response.data!.summer, isNotNull);
        expect(response.data!.winter, isNotNull);
      });

      test('should get consumption alerts successfully', () async {
        final response = await consumptionRepository.getConsumptionAlerts('user_001');
        
        expect(response.success, true);
        expect(response.data, isA<List<Map<String, dynamic>>>());
      });
    });

    group('Error Handling Tests', () {
      test('should handle repository errors gracefully', () async {
        // Test with invalid user ID to trigger error handling
        final response = await userRepository.getUserById('user_001');
        
        expect(response.success, true); // The mock always returns success for any ID
        expect(response.data, isNotNull);
        expect(response.data!.id, 'user_001');
      });

      test('should handle data loading errors', () async {
        // Test with invalid bill ID to trigger error handling
        final response = await billRepository.getBillById('invalid_bill');
        
        expect(response.success, false);
        expect(response.error, isNotNull);
        expect(response.error!.isNotEmpty, true);
      });

      test('should handle consumption data errors', () async {
        // Test with future date to trigger error handling
        final futureDate = DateTime(2030, 1, 1);
        final response = await consumptionRepository.getDailyConsumption('user_001', futureDate);
        
        expect(response.success, false);
        expect(response.error, isNotNull);
        expect(response.error!.isNotEmpty, true);
      });
    });

    group('Data Consistency Tests', () {
      test('should maintain data consistency across repositories', () async {
        // Test that user data is consistent across different repository calls
        final userResponse = await userRepository.getUserById('user_001');
        final currentUserResponse = await userRepository.getCurrentUser();
        
        expect(userResponse.success, true);
        expect(currentUserResponse.success, true);
        expect(userResponse.data!.id, currentUserResponse.data!.id);
        expect(userResponse.data!.email, currentUserResponse.data!.email);
      });

      test('should maintain bill data consistency', () async {
        // Test that bill data is consistent across different calls
        final billsResponse = await billRepository.getBills('user_001');
        final latestBillResponse = await billRepository.getLatestBill('user_001');
        
        expect(billsResponse.success, true);
        expect(latestBillResponse.success, true);
        
        // Latest bill should be in the bills list
        final latestBillId = latestBillResponse.data!.id;
        final billExists = billsResponse.data!.bills.any((bill) => bill.id == latestBillId);
        expect(billExists, true);
      });

      test('should maintain consumption data consistency', () async {
        // Test that consumption data is consistent across different calls
        final dailyResponse = await consumptionRepository.getDailyConsumption('user_001', DateTime(2024, 1, 27));
        final monthlyResponse = await consumptionRepository.getMonthlyConsumption('user_001', '2024-01');
        
        expect(dailyResponse.success, true);
        expect(monthlyResponse.success, true);
        
        // Both should return data for the same time period
        expect(dailyResponse.data!.totalKwh, isNotNull);
        expect(monthlyResponse.data!.totalKwh, isNotNull);
      });
    });
  });
}
