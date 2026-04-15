import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' show accountSwitcherProvider;
import '../../../data/models/account.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/bill.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/accounts_repository.dart';
import 'bills_repository.dart';

// Repository provider
final billsRepositoryProvider = Provider<BillsRepository>((ref) => const BillsRepository());

// Bills data providers
final billsProvider = FutureProvider<List<Bill>>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repository = ref.watch(billsRepositoryProvider);
  final bills = await repository.fetchBills(activeAccountId);
  return bills;
});

// Account balance provider - uses data from active account
final accountBalanceProvider = Provider.autoDispose<AccountBalance>((ref) {
  // Get balance from the active account model instead of separate API call
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;
  
  if (activeAccount == null) {
    return AccountBalance(
      currentBalance: 0,
      lastPaymentDate: DateTime.now(),
      lastPaymentAmount: 0,
      nextDueDate: DateTime.now(),
      paymentMethod: 'Unknown',
    );
  }

  // Calculate past due - balance if account is overdue or due
  final pastDue = (activeAccount.status == AccountStatus.overdue || 
                   activeAccount.status == AccountStatus.due) 
      ? activeAccount.balance 
      : 0.0;

  return AccountBalance(
    currentBalance: activeAccount.balance,
    lastPaymentDate: activeAccount.lastPaymentDate ?? DateTime.now(),
    lastPaymentAmount: pastDue, // Past due amount (balance if overdue/due)
    nextDueDate: activeAccount.nextDueDate ?? DateTime.now(),
    paymentMethod: 'Unknown', // Not available in Account model
  );
});

final usageSummaryProvider = FutureProvider<UsageSummary>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repository = ref.watch(billsRepositoryProvider);
  final usage = await repository.fetchUsageSummary(activeAccountId);
  return usage;
});

// Payment state management
class PaymentNotifier extends StateNotifier<AsyncValue<bool>> {
  PaymentNotifier(this._repository) : super(const AsyncValue.data(false));

  final BillsRepository _repository;

  Future<void> processPayment({
    required double amount,
    required String paymentMethod,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String cardholderName,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final success = await _repository.processPayment(
        amount: amount,
        paymentMethod: paymentMethod,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
        cardholderName: cardholderName,
      );
      
      if (success) {
        state = const AsyncValue.data(true);
        // Invalidate related providers to refresh data
        // This would be done through a ref in the actual implementation
      } else {
        state = AsyncValue.error('Payment processing failed', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void reset() {
    state = const AsyncValue.data(false);
  }
}

final paymentProvider = StateNotifierProvider<PaymentNotifier, AsyncValue<bool>>((ref) {
  final repository = ref.watch(billsRepositoryProvider);
  return PaymentNotifier(repository);
});

// Download state management
class DownloadNotifier extends StateNotifier<Map<String, AsyncValue<bool>>> {
  DownloadNotifier(this._repository) : super({});

  final BillsRepository _repository;

  Future<void> downloadBill(String billId) async {
    state = {...state, billId: const AsyncValue.loading()};
    
    try {
      final success = await _repository.downloadBill(billId);
      
      if (success) {
        state = {...state, billId: const AsyncValue.data(true)};
      } else {
        state = {
          ...state, 
          billId: AsyncValue.error('Download failed', StackTrace.current)
        };
      }
    } catch (e, st) {
      state = {...state, billId: AsyncValue.error(e, st)};
    }
  }

  void resetDownload(String billId) {
    state = {...state, billId: const AsyncValue.data(false)};
  }
}

final downloadProvider = StateNotifierProvider<DownloadNotifier, Map<String, AsyncValue<bool>>>((ref) {
  final repository = ref.watch(billsRepositoryProvider);
  return DownloadNotifier(repository);
});

// Bills refresh provider
class BillsRefreshNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> refreshAll(WidgetRef ref) async {
    state = const AsyncLoading();
    try {
      ref.invalidate(billsProvider);
      ref.invalidate(accountBalanceProvider); // This is now a Provider, not FutureProvider
      ref.invalidate(usageSummaryProvider);
      await Future.wait([
        ref.read(usageSummaryProvider.future),
        ref.read(billsProvider.future),
      ]);
      
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final billsRefreshProvider = AsyncNotifierProvider<BillsRefreshNotifier, void>(
  BillsRefreshNotifier.new,
);

// Bills summary provider
final billsSummaryProvider = FutureProvider<BillsSummary>((ref) async {
  final billsAsync = ref.watch(billsProvider);
  
  return billsAsync.when(
    data: (bills) {
          final totalPaid = bills
              .where((bill) => bill.paymentStatus == PaymentStatus.completed)
              .fold<double>(0, (sum, bill) => sum + bill.payment.paidAmount);
          
          final totalOutstanding = bills
              .where((bill) => bill.paymentStatus != PaymentStatus.completed)
              .fold<double>(0, (sum, bill) => sum + bill.amounts.totalAmount);
        
        final overdueBills = bills
            .where((bill) => bill.paymentStatus == PaymentStatus.overdue)
            .length;
        
          final averageMonthlyBill = bills.isNotEmpty 
              ? bills.fold<double>(0, (sum, bill) => sum + bill.amounts.totalAmount) / bills.length
              : 0.0;
      
      final highestBill = bills.isNotEmpty
          ? bills.map((bill) => bill.amounts.totalAmount).reduce((a, b) => a > b ? a : b)
          : 0.0;
      
      final lowestBill = bills.isNotEmpty
          ? bills.map((bill) => bill.amounts.totalAmount).reduce((a, b) => a < b ? a : b)
          : 0.0;
      
      final lastPaymentDate = bills
          .where((bill) => bill.paymentStatus == PaymentStatus.completed)
          .isNotEmpty
          ? bills
              .where((bill) => bill.paymentStatus == PaymentStatus.completed)
              .map((bill) => bill.payment.paidDate)
              .reduce((a, b) => a.isAfter(b) ? a : b)
          : DateTime.now();
      
      final nextDueDate = bills
          .where((bill) => bill.paymentStatus != PaymentStatus.completed)
          .isNotEmpty
          ? bills
              .where((bill) => bill.paymentStatus != PaymentStatus.completed)
              .map((bill) => bill.dueDate)
              .reduce((a, b) => a.isBefore(b) ? a : b)
          : DateTime.now().add(const Duration(days: 30));
      
      return BillsSummary(
        totalBills: bills.length,
        totalPaid: totalPaid,
        averageMonthlyBill: averageMonthlyBill,
        highestBill: highestBill,
        lowestBill: lowestBill,
        lastPaymentDate: lastPaymentDate,
        nextDueDate: nextDueDate,
        totalOutstanding: totalOutstanding,
        overdueBills: overdueBills,
        averagePaymentTime: 0, // This would be calculated from payment history
      );
    },
    loading: () => BillsSummary(
      totalBills: 0,
      totalPaid: 0,
      averageMonthlyBill: 0,
      highestBill: 0,
      lowestBill: 0,
      lastPaymentDate: DateTime.now(),
      nextDueDate: DateTime.now(),
      totalOutstanding: 0,
      overdueBills: 0,
      averagePaymentTime: 0,
    ),
    error: (_, __) => BillsSummary(
      totalBills: 0,
      totalPaid: 0,
      averageMonthlyBill: 0,
      highestBill: 0,
      lowestBill: 0,
      lastPaymentDate: DateTime.now(),
      nextDueDate: DateTime.now(),
      totalOutstanding: 0,
      overdueBills: 0,
      averagePaymentTime: 0,
    ),
  );
});

final yearlyConsumptionProvider = FutureProvider<Map<int, List<MonthlyConsumption>>>((ref) async {
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(billsRepositoryProvider);
  final currentYear = DateTime.now().year;
  final lastYear = currentYear - 1;

  final currentYearData = await repo.fetchYearlyConsumption(activeAccountId, currentYear);
  final lastYearData = await repo.fetchYearlyConsumption(activeAccountId, lastYear);

  return {
    currentYear: currentYearData,
    lastYear: lastYearData,
  };
});

// Transaction history provider - fetches from API endpoint
final transactionHistoryProvider = FutureProvider<List<PaymentHistory>>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;
  
  if (activeAccount == null) {
    return [];
  }

  final repository = ref.watch(billsRepositoryProvider);
  final transactions = await repository.fetchTransactionHistory(
    customerNumber: activeAccount.customerNumber,
    accountNumber: activeAccount.accountNumber,
  );
  return transactions;
});

// Full account details provider - fetches complete account DTO with all fields
final accountDetailsProvider = FutureProvider<EditableCustomerAccountDto?>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccountId = accountState.activeAccountId;
  
  if (activeAccountId.isEmpty) {
    return null;
  }

  final repository = ref.watch(accountsRepositoryProvider);
  final accountDetails = await repository.fetchAccountDetails(activeAccountId);
  return accountDetails;
});

/// Bill detail provider - caches bill details by bill number
/// Uses FutureProvider.family to cache by bill number
final billDetailProvider = FutureProvider.family<BillDetailDataDto?, String>((ref, billNumber) async {
  final repository = ref.watch(billsRepositoryProvider);
  final billDetail = await repository.fetchBillDetail(billNumber);
  return billDetail;
});
