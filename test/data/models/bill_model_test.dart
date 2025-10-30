import 'package:bel247_web/data/models/bill.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bill Model Tests', () {
    late Bill testBill;
    late BillingPeriod testPeriod;
    late BillAmounts testAmounts;
    late BillUsage testUsage;
    late BillPayment testPayment;

    setUp(() {
      testPeriod = BillingPeriod(
        startDate: DateTime(2023, 12, 1),
        endDate: DateTime(2023, 12, 31),
      );

      testAmounts = const BillAmounts(
        totalAmount: 150,
        previousBalance: 25,
        currentCharges: 100,
        taxes: 15,
        fees: 10,
        adjustments: 0,
        discounts: 0,
        lateFees: 0,
        paymentFees: 0,
        serviceCharges: 0,
      );

      testUsage = const BillUsage(
        kwhUsed: 450,
        kwhRate: 0.12,
        baseCharge: 15,
        deliveryCharge: 25,
        generationCharge: 60,
      );

      testPayment = BillPayment(
        paidDate: DateTime(2023, 12, 15),
        paidAmount: 150,
        paymentMethod: 'Credit Card',
        transactionId: 'txn-123456',
      );

      testBill = Bill(
        id: 'bill-123',
        accountNumber: 'ACC-123456',
        billNumber: 'INV-2023-12-001',
        billingPeriod: testPeriod,
        dueDate: DateTime(2024, 1, 15),
        issueDate: DateTime(2023, 12, 1),
        status: BillStatus.pending.name,
        amounts: testAmounts,
        usage: testUsage,
        payment: testPayment,
        pdfUrl: 'https://example.com/bill-123.pdf',
      );
    });

    group('Serialization/Deserialization', () {
      test('should serialize to JSON correctly', () {
        final json = testBill.toJson();
        
        expect(json['id'], equals('bill-123'));
        expect(json['accountNumber'], equals('ACC-123456'));
        expect(json['billNumber'], equals('INV-2023-12-001'));
        expect(json['status'], equals(BillStatus.pending.name));
        expect(json['pdfUrl'], equals('https://example.com/bill-123.pdf'));
      });

      test('should deserialize from JSON correctly', () {
        final json = testBill.toJson();
        final billFromJson = Bill.fromJson(json);
        
        expect(billFromJson.id, equals(testBill.id));
        expect(billFromJson.accountNumber, equals(testBill.accountNumber));
        expect(billFromJson.billNumber, equals(testBill.billNumber));
        expect(billFromJson.status, equals(testBill.status));
        expect(billFromJson.pdfUrl, equals(testBill.pdfUrl));
      });

      test('should handle optional fields with defaults', () {
        final json = testBill.toJson();
        final billFromJson = Bill.fromJson(json);
        
        expect(billFromJson.paymentHistory, isEmpty);
        expect(billFromJson.adjustments, isEmpty);
        expect(billFromJson.fees, isEmpty);
        expect(billFromJson.taxes, isEmpty);
        expect(billFromJson.discounts, isEmpty);
        expect(billFromJson.calculations, equals(const BillCalculations()));
        expect(billFromJson.notes, isEmpty);
        expect(billFromJson.createdAt, isNull);
        expect(billFromJson.updatedAt, isNull);
      });
    });

    group('Validation', () {
      test('should validate successfully with valid data', () {
        final result = testBill.validate();
        
        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('should fail validation with empty required fields', () {
        final invalidBill = testBill.copyWith(
          id: '',
          accountNumber: '',
          billNumber: '',
        );
        final result = invalidBill.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Bill ID is required'));
        expect(result.errors, contains('Account number is required'));
        expect(result.errors, contains('Bill number is required'));
      });

      test('should fail validation with invalid dates', () {
        final invalidBill = testBill.copyWith(
          dueDate: DateTime(2023, 11, 30), // Before issue date
        );
        final result = invalidBill.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Due date cannot be before issue date'));
      });

      test('should fail validation with invalid billing period', () {
        final invalidPeriod = BillingPeriod(
          startDate: DateTime(2023, 12, 31),
          endDate: DateTime(2023, 12, 1), // End before start
        );
        final invalidBill = testBill.copyWith(billingPeriod: invalidPeriod);
        final result = invalidBill.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Billing period end date cannot be before start date'));
      });

      test('should fail validation with negative amounts', () {
        final invalidAmounts = testAmounts.copyWith(
          totalAmount: -50,
          currentCharges: -25,
        );
        final invalidBill = testBill.copyWith(amounts: invalidAmounts);
        final result = invalidBill.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Total amount cannot be negative'));
        expect(result.errors, contains('Current charges cannot be negative'));
      });

      test('should fail validation with negative usage', () {
        final invalidUsage = testUsage.copyWith(
          kwhUsed: -100,
          kwhRate: -0.05,
        );
        final invalidBill = testBill.copyWith(usage: invalidUsage);
        final result = invalidBill.validate();
        
        expect(result.isValid, isFalse);
        expect(result.errors, contains('Usage cannot be negative'));
        expect(result.errors, contains('Rate cannot be negative'));
      });
    });

    group('Computed Properties', () {
      test('should check if bill is overdue', () {
        expect(testBill.isOverdue, isFalse);
        
        final overdueBill = testBill.copyWith(
          dueDate: DateTime(2023, 11, 1), // Past due date
          status: BillStatus.pending.name,
        );
        expect(overdueBill.isOverdue, isTrue);
        
        final paidBill = testBill.copyWith(
          dueDate: DateTime(2023, 11, 1),
          status: BillStatus.paid.name,
        );
        expect(paidBill.isOverdue, isFalse);
      });

      test('should check if bill is paid', () {
        expect(testBill.isPaid, isFalse);
        
        final paidBill = testBill.copyWith(status: BillStatus.paid.name);
        expect(paidBill.isPaid, isTrue);
      });

      test('should calculate days until due', () {
        final futureDueDate = DateTime.now().add(const Duration(days: 10));
        final billWithFutureDue = testBill.copyWith(dueDate: futureDueDate);
        
        expect(billWithFutureDue.daysUntilDue, equals(10));
      });

      test('should calculate total paid amount', () {
        final paymentHistory = [
          PaymentHistory(
            id: 'pay-1',
            amount: 75,
            paymentDate: DateTime(2023, 12, 10),
            paymentMethod: 'Credit Card',
            transactionId: 'txn-1',
            status: PaymentStatus.completed,
          ),
          PaymentHistory(
            id: 'pay-2',
            amount: 50,
            paymentDate: DateTime(2023, 12, 20),
            paymentMethod: 'Bank Transfer',
            transactionId: 'txn-2',
            status: PaymentStatus.completed,
          ),
        ];
        
        final billWithPayments = testBill.copyWith(paymentHistory: paymentHistory);
        expect(billWithPayments.totalPaidAmount, equals(125.0));
      });

      test('should calculate remaining balance', () {
        final paymentHistory = [
          PaymentHistory(
            id: 'pay-1',
            amount: 50,
            paymentDate: DateTime(2023, 12, 10),
            paymentMethod: 'Credit Card',
            transactionId: 'txn-1',
            status: PaymentStatus.completed,
          ),
        ];
        
        final billWithPayments = testBill.copyWith(paymentHistory: paymentHistory);
        expect(billWithPayments.remainingBalance, equals(100.0)); // 150 - 50
      });

      test('should determine payment status correctly', () {
        // Paid bill
        final paidBill = testBill.copyWith(status: BillStatus.paid.name);
        expect(paidBill.paymentStatus, equals(PaymentStatus.completed));
        
        // Overdue bill
        final overdueBill = testBill.copyWith(
          dueDate: DateTime(2023, 11, 1),
          status: BillStatus.pending.name,
        );
        expect(overdueBill.paymentStatus, equals(PaymentStatus.overdue));
        
        // Due soon bill
        final dueSoonBill = testBill.copyWith(
          dueDate: DateTime.now().add(const Duration(days: 5)),
          status: BillStatus.pending.name,
        );
        expect(dueSoonBill.paymentStatus, equals(PaymentStatus.dueSoon));
        
        // Regular pending bill
        final pendingBill = testBill.copyWith(
          dueDate: DateTime.now().add(const Duration(days: 20)),
          status: BillStatus.pending.name,
        );
        expect(pendingBill.paymentStatus, equals(PaymentStatus.pending));
      });

      test('should calculate billing period duration', () {
        expect(testBill.billingPeriodDays, equals(30)); // Dec 1 to Dec 31
      });

      test('should calculate average daily cost', () {
        expect(testBill.averageDailyCost, equals(5.0)); // 150 / 30
      });

      test('should return usage cost breakdown', () {
        final breakdown = testBill.usageCostBreakdown;
        
        expect(breakdown['Base Charge'], equals(15.0));
        expect(breakdown['Delivery Charge'], equals(25.0));
        expect(breakdown['Generation Charge'], equals(60.0));
        expect(breakdown['Total Usage Cost'], equals(100.0));
      });
    });

    group('BillAmounts Tests', () {
      test('should calculate subtotal correctly', () {
        const amounts = BillAmounts(
          totalAmount: 150,
          previousBalance: 25,
          currentCharges: 100,
          taxes: 15,
          fees: 10,
          adjustments: 5,
          discounts: 10,
        );
        
        expect(amounts.subtotal, equals(120.0)); // 25 + 100 + 5 - 10
      });

      test('should calculate grand total correctly', () {
        const amounts = BillAmounts(
          totalAmount: 150,
          previousBalance: 25,
          currentCharges: 100,
          taxes: 15,
          fees: 10,
          adjustments: 0,
          discounts: 0,
          lateFees: 5,
          paymentFees: 2,
          serviceCharges: 3,
        );
        
        expect(amounts.grandTotal, equals(160.0)); // 125 + 15 + 10 + 5 + 2 + 3
      });

      test('should validate amounts correctly', () {
        const validAmounts = BillAmounts(
          totalAmount: 150,
          previousBalance: 25,
          currentCharges: 100,
          taxes: 15,
          fees: 10,
          adjustments: 0,
        );
        
        final result = validAmounts.validate();
        expect(result.isValid, isTrue);
        
        const invalidAmounts = BillAmounts(
          totalAmount: -50,
          previousBalance: 25,
          currentCharges: -100,
          taxes: -15,
          fees: -10,
          adjustments: 0,
        );
        
        final invalidResult = invalidAmounts.validate();
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, contains('Total amount cannot be negative'));
        expect(invalidResult.errors, contains('Current charges cannot be negative'));
        expect(invalidResult.errors, contains('Taxes cannot be negative'));
        expect(invalidResult.errors, contains('Fees cannot be negative'));
      });
    });

    group('PaymentHistory Tests', () {
      test('should validate payment data correctly', () {
        final validPayment = PaymentHistory(
          id: 'pay-1',
          amount: 100,
          paymentDate: DateTime(2023, 12, 15),
          paymentMethod: 'Credit Card',
          transactionId: 'txn-123',
          status: PaymentStatus.completed,
        );
        
        final result = validPayment.validate();
        expect(result.isValid, isTrue);
        
        final invalidPayment = PaymentHistory(
          id: 'pay-1',
          amount: -50, // Negative amount
          paymentDate: DateTime(2023, 12, 15),
          paymentMethod: '', // Empty method
          transactionId: '', // Empty transaction ID
          status: PaymentStatus.completed,
        );
        
        final invalidResult = invalidPayment.validate();
        expect(invalidResult.isValid, isFalse);
        expect(invalidResult.errors, contains('Payment amount must be positive'));
        expect(invalidResult.errors, contains('Payment method is required'));
        expect(invalidResult.errors, contains('Transaction ID is required'));
      });

      test('should check if payment is successful', () {
        final successfulPayment = PaymentHistory(
          id: 'pay-1',
          amount: 100,
          paymentDate: DateTime(2023, 12, 15),
          paymentMethod: 'Credit Card',
          transactionId: 'txn-123',
          status: PaymentStatus.completed,
        );
        
        expect(successfulPayment.isSuccessful, isTrue);
        
        final failedPayment = PaymentHistory(
          id: 'pay-1',
          amount: 100,
          paymentDate: DateTime(2023, 12, 15),
          paymentMethod: 'Credit Card',
          transactionId: 'txn-123',
          status: PaymentStatus.failed,
        );
        
        expect(failedPayment.isSuccessful, isFalse);
      });

      test('should format payment date correctly', () {
        final payment = PaymentHistory(
          id: 'pay-1',
          amount: 100,
          paymentDate: DateTime(2023, 12, 15),
          paymentMethod: 'Credit Card',
          transactionId: 'txn-123',
          status: PaymentStatus.completed,
        );
        
        expect(payment.formattedPaymentDate, equals('15/12/2023'));
      });
    });

    group('BillCalculations Tests', () {
      test('should calculate total rate correctly', () {
        const calculations = BillCalculations(
          baseRate: 0.05,
          deliveryRate: 0.03,
          generationRate: 0.08,
          transmissionRate: 0.02,
          distributionRate: 0.01,
          regulatoryRate: 0.01,
          renewableEnergyRate: 0.005,
          energyEfficiencyRate: 0.005,
        );
        
        expect(calculations.totalRate, equals(0.20)); // Sum of all rates
      });

      test('should return rate breakdown', () {
        const calculations = BillCalculations(
          baseRate: 0.05,
          deliveryRate: 0.03,
          generationRate: 0.08,
        );
        
        final breakdown = calculations.rateBreakdown;
        
        expect(breakdown['Base Rate'], equals(0.05));
        expect(breakdown['Delivery Rate'], equals(0.03));
        expect(breakdown['Generation Rate'], equals(0.08));
      });
    });

    group('Edge Cases', () {
      test('should handle zero amounts', () {
        const zeroAmounts = BillAmounts(
          totalAmount: 0,
          previousBalance: 0,
          currentCharges: 0,
          taxes: 0,
          fees: 0,
          adjustments: 0,
        );
        
        final billWithZeroAmounts = testBill.copyWith(amounts: zeroAmounts);
        final result = billWithZeroAmounts.validate();
        
        expect(result.isValid, isTrue);
        expect(billWithZeroAmounts.averageDailyCost, equals(0.0));
      });

      test('should handle very large amounts', () {
        const largeAmounts = BillAmounts(
          totalAmount: 999999.99,
          previousBalance: 100000,
          currentCharges: 800000,
          taxes: 50000,
          fees: 49999.99,
          adjustments: 0,
        );
        
        final billWithLargeAmounts = testBill.copyWith(amounts: largeAmounts);
        final result = billWithLargeAmounts.validate();
        
        expect(result.isValid, isTrue);
        expect(billWithLargeAmounts.averageDailyCost, equals(33333.33)); // 999999.99 / 30
      });

      test('should handle empty payment history', () {
        expect(testBill.totalPaidAmount, equals(0.0));
        expect(testBill.remainingBalance, equals(150.0));
      });
    });
  });
}
