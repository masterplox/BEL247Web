import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/account.dart';
import '../../data/services/token_storage_service.dart';
import '../services/user_preferences_storage.dart';
import '../../data/models/bill.dart';
import '../../data/models/consumption.dart';
import '../utils/logger.dart';

// Placeholder classes for missing models
class CostCalculationResult {
  const CostCalculationResult({
    required this.totalCost,
    required this.breakdown,
  });
  
  final double totalCost;
  final Map<String, double> breakdown;
}

class CostSavings {
  const CostSavings({
    required this.amount,
    required this.percentage,
  });
  
  final double amount;
  final double percentage;
}

class TimeRange {
  const TimeRange({
    required this.start,
    required this.end,
  });
  
  final DateTime start;
  final DateTime end;
}

class AccountBalance {
  const AccountBalance({
    required this.currentBalance,
    required this.lastPaymentDate,
    required this.nextDueDate,
    required this.lastPaymentAmount,
    required this.paymentMethod,
  });
  
  final double currentBalance;
  final DateTime lastPaymentDate;
  final DateTime nextDueDate;
  final double lastPaymentAmount;
  final String paymentMethod;
}

/// Dashboard state
class DashboardState {
  const DashboardState({
    required this.isLoading,
    required this.hasError,
    this.error,
    this.accountBalance,
    this.dailyConsumption,
    this.monthlyConsumption,
    this.costSummary,
    this.alerts,
  });

  final bool isLoading;
  final bool hasError;
  final String? error;
  final AccountBalance? accountBalance;
  final DailyConsumption? dailyConsumption;
  final MonthlyConsumption? monthlyConsumption;
  final CostCalculationResult? costSummary;
  final List<UsageAlert>? alerts;

  DashboardState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    AccountBalance? accountBalance,
    DailyConsumption? dailyConsumption,
    MonthlyConsumption? monthlyConsumption,
    CostCalculationResult? costSummary,
    List<UsageAlert>? alerts,
  }) => DashboardState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        error: error ?? this.error,
        accountBalance: accountBalance ?? this.accountBalance,
        dailyConsumption: dailyConsumption ?? this.dailyConsumption,
        monthlyConsumption: monthlyConsumption ?? this.monthlyConsumption,
        costSummary: costSummary ?? this.costSummary,
        alerts: alerts ?? this.alerts,
      );

  static const DashboardState initial = DashboardState(
    isLoading: false,
    hasError: false,
  );
}

/// Dashboard notifier
class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(DashboardState.initial);

  /// Load dashboard data
  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, hasError: false, error: null);
    
    try {
      Logger.info('Loading dashboard data');
      
      // Simulate API calls
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from API
      final accountBalance = AccountBalance(
        currentBalance: 125.50,
        lastPaymentDate: DateTime.now().subtract(const Duration(days: 5)),
        nextDueDate: DateTime.now().add(const Duration(days: 25)),
        lastPaymentAmount: 150,
        paymentMethod: 'Credit Card',
      );
      
      state = state.copyWith(
        isLoading: false,
        accountBalance: accountBalance,
      );
      
      Logger.info('Dashboard data loaded successfully');
    } catch (e) {
      Logger.error('Failed to load dashboard data: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  /// Refresh dashboard data
  Future<void> refreshDashboardData() async {
    await loadDashboardData();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(hasError: false, error: null);
  }
}

/// Bills state
class BillsState {
  const BillsState({
    required this.isLoading,
    required this.hasError,
    this.error,
    this.bills,
    this.summary,
    this.selectedBill,
  });

  final bool isLoading;
  final bool hasError;
  final String? error;
  final List<Bill>? bills;
  final BillsSummary? summary;
  final Bill? selectedBill;

  BillsState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    List<Bill>? bills,
    BillsSummary? summary,
    Bill? selectedBill,
  }) => BillsState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        error: error ?? this.error,
        bills: bills ?? this.bills,
        summary: summary ?? this.summary,
        selectedBill: selectedBill ?? this.selectedBill,
      );

  static const BillsState initial = BillsState(
    isLoading: false,
    hasError: false,
  );
}

/// Bills notifier
class BillsNotifier extends StateNotifier<BillsState> {
  BillsNotifier() : super(BillsState.initial);

  /// Load bills data
  Future<void> loadBillsData() async {
    state = state.copyWith(isLoading: true, hasError: false, error: null);
    
    try {
      Logger.info('Loading bills data');
      
      // Simulate API calls
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from API
      final bills = <Bill>[];
      
      state = state.copyWith(
        isLoading: false,
        bills: bills,
      );
      
      Logger.info('Bills data loaded successfully');
    } catch (e) {
      Logger.error('Failed to load bills data: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  /// Select bill
  void selectBill(Bill bill) {
    state = state.copyWith(selectedBill: bill);
    Logger.info('Bill selected: ${bill.id}');
  }

  /// Clear selection
  void clearSelection() {
    state = state.copyWith(selectedBill: null);
  }

  /// Refresh bills data
  Future<void> refreshBillsData() async {
    await loadBillsData();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(hasError: false, error: null);
  }
}

/// Usage state
class UsageState {
  const UsageState({
    required this.isLoading,
    required this.hasError,
    this.error,
    this.dailyConsumption,
    this.hourlyConsumption,
    this.consumptionData,
    this.selectedTimeRange,
    this.selectedDate,
  });

  final bool isLoading;
  final bool hasError;
  final String? error;
  final DailyConsumption? dailyConsumption;
  final List<HourlyConsumption>? hourlyConsumption;
  final List<DailyConsumption>? consumptionData;
  final TimeRange? selectedTimeRange;
  final DateTime? selectedDate;

  UsageState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    DailyConsumption? dailyConsumption,
    List<HourlyConsumption>? hourlyConsumption,
    List<DailyConsumption>? consumptionData,
    TimeRange? selectedTimeRange,
    DateTime? selectedDate,
  }) => UsageState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        error: error ?? this.error,
        dailyConsumption: dailyConsumption ?? this.dailyConsumption,
        hourlyConsumption: hourlyConsumption ?? this.hourlyConsumption,
        consumptionData: consumptionData ?? this.consumptionData,
        selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
        selectedDate: selectedDate ?? this.selectedDate,
      );

  static const UsageState initial = UsageState(
    isLoading: false,
    hasError: false,
  );
}

/// Usage notifier
class UsageNotifier extends StateNotifier<UsageState> {
  UsageNotifier() : super(UsageState.initial);

  /// Load usage data
  Future<void> loadUsageData({
    TimeRange? timeRange,
    DateTime? date,
  }) async {
    state = state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
      selectedTimeRange: timeRange,
      selectedDate: date,
    );
    
    try {
      Logger.info('Loading usage data for ${timeRange != null ? 'custom range' : 'default'}');
      
      // Simulate API calls
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from API
      final dailyConsumption = DailyConsumption(
        date: date ?? DateTime.now(),
        totalKwh: 45.2,
        cost: 5.42,
        hourlyBreakdown: List.generate(24, (hour) => HourlyConsumption(
          hour: hour,
          kwh: 1.5 + (hour % 3) * 0.5,
          cost: (1.5 + (hour % 3) * 0.5) * 0.12,
        )),
        peakUsages: [],
        lowUsages: [],
        averageHourlyUsage: 1.88,
        peakHourlyUsage: 2.5,
        lowestHourlyUsage: 1.5,
        standardDeviation: 0.3,
        alerts: [],
        pattern: const ConsumptionPattern(
          previousDayUsage: 42.1,
          previousWeekAverage: 48.5,
          previousMonthAverage: 45.8,
          typicalPeakHours: [18, 19, 20],
          typicalLowHours: [3, 4, 5],
          weekendAverage: 52,
          weekdayAverage: 44,
          holidayAverage: 60,
        ),
      );
      
      state = state.copyWith(
        isLoading: false,
        dailyConsumption: dailyConsumption,
      );
      
      Logger.info('Usage data loaded successfully');
    } catch (e) {
      Logger.error('Failed to load usage data: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  /// Update time range
  void updateTimeRange(TimeRange timeRange) {
    state = state.copyWith(selectedTimeRange: timeRange);
    loadUsageData(timeRange: timeRange);
  }

  /// Update selected date
  void updateSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
    loadUsageData(date: date);
  }

  /// Refresh usage data
  Future<void> refreshUsageData() async {
    await loadUsageData(
      timeRange: state.selectedTimeRange,
      date: state.selectedDate,
    );
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(hasError: false, error: null);
  }
}

/// Daily bill state
class DailyBillState {
  const DailyBillState({
    required this.isLoading,
    required this.hasError,
    this.error,
    this.dailyConsumption,
    this.costCalculation,
    this.costSavings,
    this.alerts,
  });

  final bool isLoading;
  final bool hasError;
  final String? error;
  final DailyConsumption? dailyConsumption;
  final CostCalculationResult? costCalculation;
  final CostSavings? costSavings;
  final List<UsageAlert>? alerts;

  DailyBillState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    DailyConsumption? dailyConsumption,
    CostCalculationResult? costCalculation,
    CostSavings? costSavings,
    List<UsageAlert>? alerts,
  }) => DailyBillState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        error: error ?? this.error,
        dailyConsumption: dailyConsumption ?? this.dailyConsumption,
        costCalculation: costCalculation ?? this.costCalculation,
        costSavings: costSavings ?? this.costSavings,
        alerts: alerts ?? this.alerts,
      );

  static const DailyBillState initial = DailyBillState(
    isLoading: false,
    hasError: false,
  );
}

/// Daily bill notifier
class DailyBillNotifier extends StateNotifier<DailyBillState> {
  DailyBillNotifier() : super(DailyBillState.initial);

  /// Load daily bill data
  Future<void> loadDailyBillData({DateTime? date}) async {
    state = state.copyWith(isLoading: true, hasError: false, error: null);
    
    try {
      Logger.info('Loading daily bill data for ${date ?? DateTime.now()}');
      
      // Simulate API calls
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from API
      final dailyConsumption = DailyConsumption(
        date: date ?? DateTime.now(),
        totalKwh: 38.5,
        cost: 4.62,
        hourlyBreakdown: List.generate(24, (hour) => HourlyConsumption(
          hour: hour,
          kwh: 1.2 + (hour % 4) * 0.3,
          cost: (1.2 + (hour % 4) * 0.3) * 0.12,
        )),
        peakUsages: [],
        lowUsages: [],
        averageHourlyUsage: 1.6,
        peakHourlyUsage: 2.1,
        lowestHourlyUsage: 1.2,
        standardDeviation: 0.25,
        alerts: [],
        pattern: const ConsumptionPattern(
          previousDayUsage: 42.1,
          previousWeekAverage: 48.5,
          previousMonthAverage: 45.8,
          typicalPeakHours: [18, 19, 20],
          typicalLowHours: [3, 4, 5],
          weekendAverage: 52,
          weekdayAverage: 44,
          holidayAverage: 60,
        ),
      );
      
      state = state.copyWith(
        isLoading: false,
        dailyConsumption: dailyConsumption,
      );
      
      Logger.info('Daily bill data loaded successfully');
    } catch (e) {
      Logger.error('Failed to load daily bill data: $e');
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  /// Refresh daily bill data
  Future<void> refreshDailyBillData() async {
    await loadDailyBillData();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(hasError: false, error: null);
  }
}

/// Feature state providers
final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(),
);

final billsProvider = StateNotifierProvider<BillsNotifier, BillsState>(
  (ref) => BillsNotifier(),
);

final usageProvider = StateNotifierProvider<UsageNotifier, UsageState>(
  (ref) => UsageNotifier(),
);

final dailyBillProvider = StateNotifierProvider<DailyBillNotifier, DailyBillState>(
  (ref) => DailyBillNotifier(),
);

/// Convenience providers
final dashboardNotifierProvider = Provider<DashboardNotifier>((ref) => ref.watch(dashboardProvider.notifier));

final billsNotifierProvider = Provider<BillsNotifier>((ref) => ref.watch(billsProvider.notifier));

final usageNotifierProvider = Provider<UsageNotifier>((ref) => ref.watch(usageProvider.notifier));

final dailyBillNotifierProvider = Provider<DailyBillNotifier>((ref) => ref.watch(dailyBillProvider.notifier));

/// Loading state providers
final isDashboardLoadingProvider = Provider<bool>((ref) => ref.watch(dashboardProvider).isLoading);

final isBillsLoadingProvider = Provider<bool>((ref) => ref.watch(billsProvider).isLoading);

final isUsageLoadingProvider = Provider<bool>((ref) => ref.watch(usageProvider).isLoading);

final isDailyBillLoadingProvider = Provider<bool>((ref) => ref.watch(dailyBillProvider).isLoading);

/// Error state providers
final dashboardErrorProvider = Provider<String?>((ref) => ref.watch(dashboardProvider).error);

final billsErrorProvider = Provider<String?>((ref) => ref.watch(billsProvider).error);

final usageErrorProvider = Provider<String?>((ref) => ref.watch(usageProvider).error);

final dailyBillErrorProvider = Provider<String?>((ref) => ref.watch(dailyBillProvider).error);

/// Notice Banner State
class NoticeBannerState {
  const NoticeBannerState({
    required this.isVisible,
    required this.message,
  });

  final bool isVisible;
  final String message;

  NoticeBannerState copyWith({
    bool? isVisible,
    String? message,
  }) => NoticeBannerState(
        isVisible: isVisible ?? this.isVisible,
        message: message ?? this.message,
      );

  static const NoticeBannerState hidden = NoticeBannerState(
    isVisible: false,
    message: '',
  );
}

/// TOU Period Enum
enum TouPeriod { peak, midPeak, offPeak }

/// Notice Banner Notifier
class NoticeBannerNotifier extends StateNotifier<NoticeBannerState> {
  NoticeBannerNotifier() : super(const NoticeBannerState(isVisible: false, message: '')) {
    _initializeTouBanner();
  }

  Timer? _timer;

  TouPeriod _getCurrentTouPeriod() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 21) { // 9pm to midnight
      return TouPeriod.midPeak;
    } else if (hour < 11) { // midnight to 11am
      return TouPeriod.offPeak;
    } else { // 11am to 9pm
      return TouPeriod.peak;
    }
  }

  String _getMessageForTouPeriod(TouPeriod period) {
    switch (period) {
      case TouPeriod.peak:
        return 'You are currently in PEAK hours (11am - 9pm).';
      case TouPeriod.midPeak:
        return 'You are currently in MID PEAK hours (9pm - 12am).';
      case TouPeriod.offPeak:
        return 'You are currently in OFF PEAK hours (12am - 11am).';
    }
  }

  void _initializeTouBanner() {
    final currentPeriod = _getCurrentTouPeriod();
    final message = _getMessageForTouPeriod(currentPeriod);
    state = NoticeBannerState(isVisible: true, message: message);

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final newPeriod = _getCurrentTouPeriod();
      final newMessage = _getMessageForTouPeriod(newPeriod);
      if (state.message != newMessage) {
        updateMessage(newMessage);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Show notice banner with message
  void show(String message) {
    state = NoticeBannerState(
      isVisible: true,
      message: message,
    );
  }

  /// Hide notice banner
  void hide() {
    state = const NoticeBannerState(
      isVisible: false,
      message: '',
    );
  }

  /// Update message
  void updateMessage(String message) {
    if (state.isVisible) {
      state = state.copyWith(message: message);
    }
  }
}

/// Notice Banner Provider
final noticeBannerProvider = StateNotifierProvider<NoticeBannerNotifier, NoticeBannerState>(
  (ref) => NoticeBannerNotifier(),
);

/// Account id for which the non-AMI notice was dismissed this session.
final nonAmiNoticeDismissedAccountIdProvider = StateProvider<String?>((ref) => null);

/// Account Switcher State
class AccountSwitcherState {
  const AccountSwitcherState({
    required this.accounts,
    required this.activeAccountId,
    this.isInitialized = false,
  });

  final List<Account> accounts;
  final String activeAccountId;
  final bool isInitialized;

  AccountSwitcherState copyWith({
    List<Account>? accounts,
    String? activeAccountId,
    bool? isInitialized,
  }) => AccountSwitcherState(
        accounts: accounts ?? this.accounts,
        activeAccountId: activeAccountId ?? this.activeAccountId,
        isInitialized: isInitialized ?? this.isInitialized,
      );

  Account? get activeAccount {
    try {
      return accounts.firstWhere((account) => account.id == activeAccountId);
    } catch (e) {
      return accounts.isNotEmpty ? accounts.first : null;
    }
  }
}

/// Account Switcher Notifier
class AccountSwitcherNotifier extends StateNotifier<AccountSwitcherState> {
  AccountSwitcherNotifier() : super(
    // Start with empty accounts - will be populated after login
    const AccountSwitcherState(
      accounts: [],
      activeAccountId: '',
      isInitialized: false,
    ),
  );

  /// Initialize with real accounts after login
  void initializeAccounts(List<Account> accounts, {String? activeAccountId}) {
    // Always mark as initialized, even if accounts list is empty
    // This allows us to distinguish between "still loading" and "no accounts found"
    if (accounts.isEmpty) {
      state = state.copyWith(isInitialized: true);
      return;
    }
    
    final initialId = activeAccountId ?? accounts.first.id;
    state = AccountSwitcherState(
      accounts: accounts,
      activeAccountId: initialId,
      isInitialized: true,
    );
  }

  /// Switch to a different account
  void switchAccount(String accountId) {
    if (state.accounts.any((account) => account.id == accountId)) {
      state = state.copyWith(activeAccountId: accountId);
      Logger.info('Switched to account: $accountId');
      _persistLastActiveAccount(accountId);
    }
  }

  Future<void> _persistLastActiveAccount(String accountId) async {
    try {
      final session = await TokenStorageService.getUserSession();
      if (session == null) return;
      await UserPreferencesStorage.saveLastActiveAccountId(
        userId: session.userId,
        accountId: accountId,
      );
    } catch (e) {
      Logger.warning('Failed to persist last active account', tag: 'AccountSwitcher');
    }
  }

  /// Refresh accounts list from API
  Future<void> refreshAccounts() async {
    try {
      // Note: This requires access to AccountsRepository
      // For now, this is a placeholder - actual implementation would need ref
      // TODO: Implement repository access pattern or pass repository as dependency
    } catch (e) {
      Logger.error('Failed to refresh accounts', error: e, tag: 'AccountSwitcher');
    }
  }

  /// Reset account switcher state (used on logout)
  void reset() {
    state = const AccountSwitcherState(
      accounts: [],
      activeAccountId: '',
      isInitialized: false,
    );
  }

  // Mock accounts - no longer used, accounts are fetched from API after login
  // Kept for reference only
  @Deprecated('Accounts are now fetched from API after login')
  static final List<Account> _mockAccounts = [
    Account(
      id: 'account_1',
      accountNumber: '20241234',
      customerNumber: '00083630', // Added customerNumber
      accountType: 'residential',
      address: '42 Marine Parade, Belize City',
      balance: 245.50,
      status: AccountStatus.due,
      lastPaymentDate: DateTime(2025, 9, 15),
      nextDueDate: DateTime(2025, 10, 15),
      meterNumber: 'MTR-001234',
    ),
    Account(
      id: 'account_2',
      accountNumber: '20245678',
      customerNumber: '00083630', // Added customerNumber
      accountType: 'commercial',
      address: '15 Queen Street, Belmopan',
      balance: 1450,
      status: AccountStatus.due,
      lastPaymentDate: DateTime(2025, 9, 10),
      nextDueDate: DateTime(2025, 10, 10),
      meterNumber: 'MTR-005678',
    ),
    Account(
      id: 'account_3',
      accountNumber: '20249012',
      customerNumber: '00083630', // Added customerNumber
      accountType: 'residential',
      address: '8 Coconut Drive, San Pedro',
      balance: 0,
      status: AccountStatus.paid,
      lastPaymentDate: DateTime(2025, 9, 28),
      nextDueDate: DateTime(2025, 10, 28),
      meterNumber: 'MTR-009012',
    ),
  ];
}

/// Account Switcher Provider
final accountSwitcherProvider = StateNotifierProvider<AccountSwitcherNotifier, AccountSwitcherState>(
  (ref) => AccountSwitcherNotifier(),
);