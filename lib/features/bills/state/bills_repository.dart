import '../../../core/config/env.dart';
import '../../../data/models/bill.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';
import '../../../data/sources/mock/mock_bill_repository.dart';

class BillsRepository {
  const BillsRepository();

  Future<List<Bill>> fetchBills(String accountId) async {
    print('[Bills] Repository.fetchBills start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Always use mock repository to load from JSON file
    // TODO: Add live API call when implemented
    final repo = MockBillRepository();
    final result = await repo.getBills(accountId);
    
    if (result.success && result.data != null) {
      print('[Bills] Repository.fetchBills success ${result.data!.bills.length} bills accountId=$accountId');
      return result.data!.bills;
    } else {
      print('[Bills] Repository.fetchBills [ERROR] No bills found for accountId=$accountId, returning empty list');
      print('[Bills] Repository.fetchBills error: ${result.error}');
      return [];
    }
  }

  Future<AccountBalance> fetchAccountBalance(String accountId) async {
    print('[Bills] Repository.fetchAccountBalance start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // Always use mock service for now (similar to fetchBills)
    // TODO: Add live API call when implemented
    final bal = await MockAppDataService.getAccountBalance(accountId);
    final result = bal ?? AccountBalance(
      currentBalance: 0,
      lastPaymentDate: DateTime.now(),
      lastPaymentAmount: 0,
      nextDueDate: DateTime.now(),
      paymentMethod: 'Unknown',
    );
    if (bal == null) {
      print('[Bills] Repository.fetchAccountBalance [ERROR] No balance found for accountId=$accountId, returning default');
    } else {
      print('[Bills] Repository.fetchAccountBalance success balance=\$${result.currentBalance.toStringAsFixed(2)} accountId=$accountId');
    }
    return result;
  }

  Future<List<MonthlyConsumption>> fetchYearlyConsumption(String accountId, int year) async {
    print('[Bills] Repository.fetchYearlyConsumption useMockApi=${EnvConfig.useMockApi}');
    print('[Bills] Repository.fetchYearlyConsumption start accountId=$accountId year=$year');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final repo = MockBillRepository(); // In a real app, this would be determined by EnvConfig
    final result = await repo.getYearlyConsumption(accountId, year);
    if (result.success && result.data != null) {
      print('[Bills] Repository.fetchYearlyConsumption success count=${result.data!.length} accountId=$accountId');
      return result.data!;
    } else {
      print('[Bills] Repository.fetchYearlyConsumption [ERROR] No data found for accountId=$accountId, returning empty list');
      return [];
    }
  }

  Future<UsageSummary> fetchUsageSummary(String accountId) async {
    print('[Bills] Repository.fetchUsageSummary start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // Always use mock service for now (similar to fetchBills)
    // TODO: Add live API call when implemented
    final usage = await MockAppDataService.getUsageSummary(accountId);
    final result = usage ?? const UsageSummary(
      currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
    );
    if (usage == null) {
      print('[Bills] Repository.fetchUsageSummary [ERROR] No usage summary found for accountId=$accountId, returning default');
    } else {
      print('[Bills] Repository.fetchUsageSummary success currentMonth=${usage.currentMonth.kwh.toStringAsFixed(2)}kwh cost=\$${usage.currentMonth.cost.toStringAsFixed(2)} accountId=$accountId');
    }
    return result;
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
