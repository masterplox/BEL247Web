import 'package:bel247_web/core/services/model_validation_service.dart';
import 'package:bel247_web/data/models/bill.dart';
import 'package:bel247_web/data/models/consumption.dart';
import 'package:bel247_web/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ModelValidationService Tests', () {
    late ModelValidationService validationService;

    setUp(() {
      validationService = ModelValidationService();
    });

    group('User Validation', () {
      test('should validate valid user successfully', () {
        final user = User(
          id: 'user123',
          email: 'test@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phone: '+1234567890',
          address: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          accountNumber: 'ACC123',
          serviceAddress: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          meterNumber: 'METER123',
          tariffPlan: 'residential',
          connectionDate: DateTime(2023, 1, 1),
          lastLogin: DateTime.now(),
          preferences: const UserPreferences(
            notifications: NotificationSettings(
              email: true,
              sms: false,
              push: true,
            ),
            currency: 'USD',
            timezone: 'UTC',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 100,
            lastPaymentDate: DateTime(2023, 12, 1),
            lastPaymentAmount: 150,
            nextDueDate: DateTime(2024, 1, 1),
            paymentMethod: 'credit_card',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(
              kwh: 450,
              cost: 54,
              averageDaily: 15,
            ),
            lastMonth: UsagePeriod(
              kwh: 400,
              cost: 48,
              averageDaily: 13.3,
            ),
            yearToDate: UsagePeriod(
              kwh: 5400,
              cost: 648,
              averageDaily: 15,
            ),
          ),
        );

        final result = user.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should fail validation for invalid email', () {
        final user = User(
          id: 'user123',
          email: 'invalid-email',
          firstName: 'John',
          lastName: 'Doe',
          phone: '+1234567890',
          address: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          accountNumber: 'ACC123',
          serviceAddress: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          meterNumber: 'METER123',
          tariffPlan: 'residential',
          connectionDate: DateTime(2023, 1, 1),
          lastLogin: DateTime.now(),
          preferences: const UserPreferences(
            notifications: NotificationSettings(email: true, sms: false, push: true),
            currency: 'USD',
            timezone: 'UTC',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 0,
            lastPaymentDate: DateTime(2023, 1, 1),
            lastPaymentAmount: 0,
            nextDueDate: DateTime(2024, 1, 1),
            paymentMethod: 'credit_card',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
        );

        final result = user.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Email: Please enter a valid email address'));
      });

      test('should fail validation for empty required fields', () {
        final user = User(
          id: '',
          email: 'test@example.com',
          firstName: '',
          lastName: 'Doe',
          phone: '+1234567890',
          address: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          accountNumber: '',
          serviceAddress: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          meterNumber: '',
          tariffPlan: 'residential',
          connectionDate: DateTime(2023, 1, 1),
          lastLogin: DateTime.now(),
          preferences: const UserPreferences(
            notifications: NotificationSettings(email: true, sms: false, push: true),
            currency: 'USD',
            timezone: 'UTC',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 0,
            lastPaymentDate: DateTime(2023, 1, 1),
            lastPaymentAmount: 0,
            nextDueDate: DateTime(2024, 1, 1),
            paymentMethod: 'credit_card',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
        );

        final result = user.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('First name is required'));
        expect(result.errors, contains('Account number is required'));
        expect(result.errors, contains('Meter number is required'));
      });

      test('should fail validation for invalid phone number', () {
        final user = User(
          id: 'user123',
          email: 'test@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phone: 'invalid-phone',
          address: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          accountNumber: 'ACC123',
          serviceAddress: const Address(
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zipCode: '12345',
            country: 'USA',
          ),
          meterNumber: 'METER123',
          tariffPlan: 'residential',
          connectionDate: DateTime(2023, 1, 1),
          lastLogin: DateTime.now(),
          preferences: const UserPreferences(
            notifications: NotificationSettings(email: true, sms: false, push: true),
            currency: 'USD',
            timezone: 'UTC',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 0,
            lastPaymentDate: DateTime(2023, 1, 1),
            lastPaymentAmount: 0,
            nextDueDate: DateTime(2024, 1, 1),
            paymentMethod: 'credit_card',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
        );

        final result = user.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Phone: Please enter a valid phone number'));
      });
    });

    group('Bill Validation', () {
      test('should validate valid bill successfully', () {
        final bill = Bill(
          id: 'bill123',
          accountNumber: 'ACC123',
          billNumber: 'BILL123',
          billingPeriod: BillingPeriod(
            startDate: DateTime(2023, 12, 1),
            endDate: DateTime(2023, 12, 31),
          ),
          dueDate: DateTime(2024, 1, 15),
          issueDate: DateTime(2023, 12, 31),
          status: BillStatus.pending.name,
          amounts: const BillAmounts(
            totalAmount: 150,
            currentCharges: 120,
            previousBalance: 30,
            taxes: 15,
            fees: 0,
            adjustments: 0,
          ),
          usage: const BillUsage(
            kwhUsed: 450,
            kwhRate: 0.12,
            baseCharge: 25,
            deliveryCharge: 15,
            generationCharge: 80,
          ),
          payment: BillPayment(
            paidDate: DateTime(2024, 1, 15),
            paidAmount: 150,
            paymentMethod: 'credit_card',
            transactionId: 'TXN123',
          ),
          pdfUrl: 'https://example.com/bill.pdf',
        );

        final result = bill.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should fail validation for negative amounts', () {
        final bill = Bill(
          id: 'bill123',
          accountNumber: 'ACC123',
          billNumber: 'BILL123',
          billingPeriod: BillingPeriod(
            startDate: DateTime(2023, 12, 1),
            endDate: DateTime(2023, 12, 31),
          ),
          dueDate: DateTime(2024, 1, 15),
          issueDate: DateTime(2023, 12, 31),
          status: BillStatus.pending.name,
          amounts: const BillAmounts(
            totalAmount: -100, // Invalid negative amount
            currentCharges: 120,
            previousBalance: 30,
            taxes: 15,
            fees: 0,
            adjustments: 0,
          ),
          usage: const BillUsage(
            kwhUsed: 450,
            kwhRate: 0.12,
            baseCharge: 25,
            deliveryCharge: 15,
            generationCharge: 80,
          ),
          payment: BillPayment(
            paidDate: DateTime(2024, 1, 15),
            paidAmount: 150,
            paymentMethod: 'credit_card',
            transactionId: 'TXN123',
          ),
          pdfUrl: 'https://example.com/bill.pdf',
        );

        final result = bill.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Total amount cannot be negative'));
      });

      test('should fail validation for invalid date ranges', () {
        final bill = Bill(
          id: 'bill123',
          accountNumber: 'ACC123',
          billNumber: 'BILL123',
          billingPeriod: BillingPeriod(
            startDate: DateTime(2023, 12, 31), // End before start
            endDate: DateTime(2023, 12, 1),
          ),
          dueDate: DateTime(2023, 12, 15), // Due before issue
          issueDate: DateTime(2023, 12, 31),
          status: BillStatus.pending.name,
          amounts: const BillAmounts(
            totalAmount: 150,
            currentCharges: 120,
            previousBalance: 30,
            taxes: 15,
            fees: 0,
            adjustments: 0,
          ),
          usage: const BillUsage(
            kwhUsed: 450,
            kwhRate: 0.12,
            baseCharge: 25,
            deliveryCharge: 15,
            generationCharge: 80,
          ),
          payment: BillPayment(
            paidDate: DateTime(2024, 1, 15),
            paidAmount: 150,
            paymentMethod: 'credit_card',
            transactionId: 'TXN123',
          ),
          pdfUrl: 'https://example.com/bill.pdf',
        );

        final result = bill.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Billing period end date cannot be before start date'));
        expect(result.errors, contains('Due date cannot be before issue date'));
      });

      test('should fail validation for empty required fields', () {
        final bill = Bill(
          id: '',
          accountNumber: '',
          billNumber: '',
          billingPeriod: BillingPeriod(
            startDate: DateTime(2023, 12, 1),
            endDate: DateTime(2023, 12, 31),
          ),
          dueDate: DateTime(2024, 1, 15),
          issueDate: DateTime(2023, 12, 31),
          status: BillStatus.pending.name,
          amounts: const BillAmounts(
            totalAmount: 150,
            currentCharges: 120,
            previousBalance: 30,
            taxes: 15,
            fees: 0,
            adjustments: 0,
          ),
          usage: const BillUsage(
            kwhUsed: 450,
            kwhRate: 0.12,
            baseCharge: 25,
            deliveryCharge: 15,
            generationCharge: 80,
          ),
          payment: BillPayment(
            paidDate: DateTime(2024, 1, 15),
            paidAmount: 150,
            paymentMethod: 'credit_card',
            transactionId: 'TXN123',
          ),
          pdfUrl: 'https://example.com/bill.pdf',
        );

        final result = bill.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Bill ID is required'));
        expect(result.errors, contains('Account number is required'));
        expect(result.errors, contains('Bill number is required'));
      });
    });

    group('Consumption Validation', () {
      test('should validate valid consumption successfully', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 450,
          cost: 54,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 15.0 + (index % 3) * 5.0,
            cost: (15.0 + (index % 3) * 5.0) * 0.12,
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should fail validation for negative consumption values', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: -100, // Invalid negative value
          cost: 54,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 15.0 + (index % 3) * 5.0,
            cost: (15.0 + (index % 3) * 5.0) * 0.12,
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Total kWh cannot be negative'));
      });

      test('should fail validation for incorrect hourly breakdown length', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 450,
          cost: 54,
          hourlyBreakdown: List.generate(12, (index) => HourlyConsumption( // Only 12 hours
            hour: index,
            kwh: 15.0 + (index % 3) * 5.0,
            cost: (15.0 + (index % 3) * 5.0) * 0.12,
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Hourly breakdown must have 24 entries'));
      });

      test('should fail validation for negative hourly values', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 450,
          cost: 54,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: -10, // Invalid negative value
            cost: -5, // Invalid negative value
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Hourly kWh cannot be negative'));
        expect(result.errors, contains('Hourly cost cannot be negative'));
      });
    });

    group('ModelValidationService Methods', () {
      test('should validate email format', () {
        final result = validationService.validateEmail('test@example.com');
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);

        final invalidResult = validationService.validateEmail('invalid-email');
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, isNotEmpty);
      });

      test('should validate phone number format', () {
        final result = validationService.validatePhoneNumber('+1234567890');
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);

        final invalidResult = validationService.validatePhoneNumber('invalid-phone');
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, isNotEmpty);
      });

      test('should validate required fields', () {
        final result = validationService.validateRequired('test', 'Test Field');
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);

        final invalidResult = validationService.validateRequired('', 'Test Field');
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, contains('Test Field is required'));
      });

      test('should validate positive numbers', () {
        final result = validationService.validatePositiveNumber(100, 'Amount');
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);

        final invalidResult = validationService.validatePositiveNumber(-50, 'Amount');
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, contains('Amount cannot be negative'));
      });

      test('should validate date ranges', () {
        final startDate = DateTime(2023, 1, 1);
        final endDate = DateTime(2023, 12, 31);
        
        final result = validationService.validateDateRange(startDate, endDate);
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);

        final invalidResult = validationService.validateDateRange(endDate, startDate);
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, contains('Start date cannot be after end date'));
      });

      test('should validate bill business rules', () {
        final result = validationService.validateBillBusinessRules(
          totalAmount: 150,
          currentCharges: 120,
          previousBalance: 30,
          dueDate: DateTime(2024, 1, 15),
          issueDate: DateTime(2023, 12, 31),
        );
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should validate consumption business rules', () {
        final hourlyBreakdown = List.generate(24, (index) => 15.0 + (index % 3) * 5.0);
        final totalKwh = hourlyBreakdown.fold<double>(0, (sum, kwh) => sum + kwh);
        
        final result = validationService.validateConsumptionBusinessRules(
          totalKwh: totalKwh,
          hourlyBreakdown: hourlyBreakdown,
          cost: totalKwh * 0.12, // Calculate cost based on total kWh
        );
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should validate payment business rules', () {
        final result = validationService.validatePaymentBusinessRules(
          amount: 150,
          billAmount: 150,
          paymentDate: DateTime.now(),
          billDueDate: DateTime(2024, 1, 15),
        );
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });
    });

    group('Edge Cases', () {
      test('should handle zero values correctly', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 0,
            cost: 0,
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should handle very large values', () {
        final consumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 999999.99,
          cost: 999999.99,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 999999.99,
            cost: 999999.99,
          )),
        );

        final result = consumption.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should handle special characters in strings', () {
        final user = User(
          id: 'user-123_test',
          email: 'test+tag@example.com',
          firstName: 'John-Paul',
          lastName: "O'Connor",
          phone: '+1-234-567-8900',
          address: const Address(
            street: '123 Main St. Apt #4',
            city: 'St. Louis',
            state: 'MO',
            zipCode: '63101-1234',
            country: 'USA',
          ),
          accountNumber: 'ACC-123_TEST',
          serviceAddress: const Address(
            street: '123 Main St. Apt #4',
            city: 'St. Louis',
            state: 'MO',
            zipCode: '63101-1234',
            country: 'USA',
          ),
          meterNumber: 'METER-123_TEST',
          tariffPlan: 'residential-tier-1',
          connectionDate: DateTime(2023, 1, 1),
          lastLogin: DateTime.now(),
          preferences: const UserPreferences(
            notifications: NotificationSettings(email: true, sms: false, push: true),
            currency: 'USD',
            timezone: 'UTC',
            language: 'en',
          ),
          accountBalance: AccountBalance(
            currentBalance: 0,
            lastPaymentDate: DateTime(2023, 1, 1),
            lastPaymentAmount: 0,
            nextDueDate: DateTime(2024, 1, 1),
            paymentMethod: 'credit_card',
          ),
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
        );

        final result = user.validate();

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });
    });
  });
}