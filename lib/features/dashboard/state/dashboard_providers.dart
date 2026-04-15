import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' show accountSwitcherProvider;
import '../../../data/models/api_dtos.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import 'dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) => const DashboardRepository());

final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  final data = await repo.fetchDashboardData(activeAccountId);
  return data;
});

final sevenDayConsumptionProvider = FutureProvider<List<DailyConsumption>>((ref) async {
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  final data = await repo.fetch7DayConsumption(activeAccountId);
  return data;
});

final energyPricesProvider = FutureProvider<List<EnergyPricePoint>>((ref) async {
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  final data = await repo.fetchEnergyPrices(activeAccountId);
  return data;
});

final accountBalanceProvider = FutureProvider<AccountBalance>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  final balance = await repo.fetchAccountBalance(activeAccountId);
  return balance;
});

final dailyConsumptionProvider = FutureProvider<DailyConsumption>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  final consumption = await repo.fetchDailyConsumption(activeAccountId);
  return consumption;
});

class DashboardRefreshNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> refreshAll(WidgetRef ref) async {
    ref.invalidate(accountBalanceProvider);
    ref.invalidate(dailyConsumptionProvider);
    ref.invalidate(dashboardDataProvider);
    ref.invalidate(sevenDayConsumptionProvider);
    ref.invalidate(energyPricesProvider);
    await Future.wait([
      ref.read(accountBalanceProvider.future),
      ref.read(dailyConsumptionProvider.future),
      ref.read(dashboardDataProvider.future),
      ref.read(sevenDayConsumptionProvider.future),
      ref.read(energyPricesProvider.future),
    ]);
  }
}

final dashboardRefreshProvider = AsyncNotifierProvider<DashboardRefreshNotifier, void>(
  DashboardRefreshNotifier.new,
);
