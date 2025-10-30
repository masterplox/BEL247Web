import '../../../core/config/env.dart';
import '../../../data/models/bill.dart';
import '../../../data/models/user.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';

class BillsRepository {
  const BillsRepository();

  Future<List<Bill>> fetchBills(String accountId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    return [
      Bill(
        id: '1',
        accountNumber: '123456789',
        billNumber: 'BL-2024-001',
        billingPeriod: BillingPeriod(
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 1, 31),
        ),
        dueDate: DateTime(2024, 2, 15),
        issueDate: DateTime(2024, 2, 1),
        status: 'paid',
        amounts: const BillAmounts(
          totalAmount: 125.50,
          previousBalance: 0,
          currentCharges: 120,
          taxes: 5.50,
          fees: 0,
          adjustments: 0,
        ),
        usage: const BillUsage(
          kwhUsed: 850,
          kwhRate: 0.12,
          baseCharge: 25,
          deliveryCharge: 45,
          generationCharge: 50,
        ),
        payment: BillPayment(
          paidDate: DateTime(2024, 2, 10),
          paidAmount: 125.50,
          paymentMethod: 'Credit Card',
          transactionId: 'TXN-001',
        ),
        pdfUrl: 'https://example.com/bill-1.pdf',
      ),
      Bill(
        id: '2',
        accountNumber: '123456789',
        billNumber: 'BL-2024-002',
        billingPeriod: BillingPeriod(
          startDate: DateTime(2024, 2, 1),
          endDate: DateTime(2024, 2, 29),
        ),
        dueDate: DateTime(2024, 3, 15),
        issueDate: DateTime(2024, 3, 1),
        status: 'overdue',
        amounts: const BillAmounts(
          totalAmount: 142.75,
          previousBalance: 0,
          currentCharges: 135,
          taxes: 6.25,
          fees: 1.50,
          adjustments: 0,
        ),
        usage: const BillUsage(
          kwhUsed: 950,
          kwhRate: 0.12,
          baseCharge: 25,
          deliveryCharge: 50,
          generationCharge: 60,
        ),
        payment: BillPayment(
          paidDate: DateTime(2024, 1, 1), // Placeholder date for unpaid bills
          paidAmount: 0,
          paymentMethod: '',
          transactionId: '',
        ),
        pdfUrl: 'https://example.com/bill-2.pdf',
      ),
      Bill(
        id: '3',
        accountNumber: '123456789',
        billNumber: 'BL-2024-003',
        billingPeriod: BillingPeriod(
          startDate: DateTime(2024, 3, 1),
          endDate: DateTime(2024, 3, 31),
        ),
        dueDate: DateTime.now().add(const Duration(days: 5)),
        issueDate: DateTime(2024, 4, 1),
        status: 'due_soon',
        amounts: const BillAmounts(
          totalAmount: 98.25,
          previousBalance: 0,
          currentCharges: 90,
          taxes: 4.25,
          fees: 4,
          adjustments: 0,
        ),
        usage: const BillUsage(
          kwhUsed: 650,
          kwhRate: 0.12,
          baseCharge: 25,
          deliveryCharge: 35,
          generationCharge: 30,
        ),
        payment: BillPayment(
          paidDate: DateTime(2024, 1, 1), // Placeholder date for unpaid bills
          paidAmount: 0,
          paymentMethod: '',
          transactionId: '',
        ),
        pdfUrl: 'https://example.com/bill-3.pdf',
      ),
    ];
  }

  Future<AccountBalance> fetchAccountBalance(String accountId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    final bal = EnvConfig.useMockApi
        ? await MockAppDataService.getAccountBalance(accountId)
        : null; // Replace with live call when implemented
    return bal ?? AccountBalance(
      currentBalance: 0,
      lastPaymentDate: DateTime.now(),
      lastPaymentAmount: 0,
      nextDueDate: DateTime.now(),
      paymentMethod: 'Unknown',
    );
  }

  Future<UsageSummary> fetchUsageSummary(String accountId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    final usage = EnvConfig.useMockApi
        ? await MockAppDataService.getUsageSummary(accountId)
        : null; // Replace with live call when implemented
    return usage ?? const UsageSummary(
      currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
    );
  }

  Future<bool> processPayment({
    required double amount,
    required String paymentMethod,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String cardholderName,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing
    
    // Simulate success/failure (90% success rate)
    return DateTime.now().millisecond % 10 < 9;
  }

  Future<bool> downloadBill(String billId) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate download
    
    // Simulate success/failure (95% success rate)
    return DateTime.now().millisecond % 20 < 19;
  }
}
