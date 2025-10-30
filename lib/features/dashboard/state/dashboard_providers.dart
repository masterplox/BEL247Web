import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' show accountSwitcherProvider;
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import 'dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) => const DashboardRepository());

final accountBalanceProvider = FutureProvider<AccountBalance>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  return repo.fetchAccountBalance(activeAccountId);
});

final dailyConsumptionProvider = FutureProvider<DailyConsumption>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repo = ref.read(dashboardRepositoryProvider);
  return repo.fetchDailyConsumption(activeAccountId);
});

class DashboardRefreshNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> refreshAll(WidgetRef ref) async {
    ref.invalidate(accountBalanceProvider);
    ref.invalidate(dailyConsumptionProvider);
    await Future.wait([
      ref.read(accountBalanceProvider.future),
      ref.read(dailyConsumptionProvider.future),
    ]);
  }
}

final dashboardRefreshProvider = AsyncNotifierProvider<DashboardRefreshNotifier, void>(
  DashboardRefreshNotifier.new,
);
