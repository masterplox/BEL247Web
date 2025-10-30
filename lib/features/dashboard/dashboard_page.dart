import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/notice_banner_helper.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import 'state/dashboard_providers.dart';
import 'widgets/account_balance_widget.dart';
import 'widgets/daily_cost_summary_widget.dart';
import 'widgets/energy_prices_widget.dart';
import 'widgets/energy_usage_overview_widget.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
          backgroundColor: AppColors.surface,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => ref.read(dashboardRefreshProvider.notifier).refreshAll(ref),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            // Test button for notice banner - Remove this after testing
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                if (NoticeBannerHelper.isVisible(ref)) {
                  NoticeBannerHelper.hide(ref);
                } else {
                  NoticeBannerHelper.showMaintenanceNotice(
                    ref,
                    location: 'Belize City area',
                    date: DateTime(2025, 10, 5),
                    startTime: const TimeOfDay(hour: 6, minute: 0),
                    endTime: const TimeOfDay(hour: 10, minute: 0),
                  );
                }
              },
              tooltip: 'Toggle Notice Banner',
            ),
          ],
        ),
        body: Container(
          color: AppColors.background,
          child: const DashboardLayout(),
        ),
      );
}

class DashboardLayout extends ConsumerWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= AppTheme.desktopBreakpoint) {
            return const DesktopDashboardLayout();
          } else if (constraints.maxWidth >= AppTheme.tabletBreakpoint) {
            return const TabletDashboardLayout();
          } else {
            return const MobileDashboardLayout();
          }
        },
      );
}

class DesktopDashboardLayout extends ConsumerWidget {
  const DesktopDashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountBalanceCard(),
            SizedBox(height: AppTheme.spacing24),
            DailyCostSummaryCard(),
            SizedBox(height: AppTheme.spacing24),
            EnergyUsageOverviewCard(),
            SizedBox(height: AppTheme.spacing24),
            EnergyPricesCard(),
          ],
        ),
      );
}

class TabletDashboardLayout extends ConsumerWidget {
  const TabletDashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountBalanceCard(),
            SizedBox(height: AppTheme.spacing20),
            DailyCostSummaryCard(),
            SizedBox(height: AppTheme.spacing20),
            EnergyUsageOverviewCard(),
            SizedBox(height: AppTheme.spacing20),
            EnergyPricesCard(),
          ],
        ),
      );
}

class MobileDashboardLayout extends ConsumerWidget {
  const MobileDashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountBalanceCard(),
            SizedBox(height: AppTheme.spacing16),
            DailyCostSummaryCard(),
            SizedBox(height: AppTheme.spacing16),
            EnergyUsageOverviewCard(),
            SizedBox(height: AppTheme.spacing16),
            EnergyPricesCard(),
          ],
        ),
      );
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Here\'s your energy usage overview',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      );
}

// Cards now consume providers
class AccountBalanceCard extends ConsumerWidget {
  const AccountBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(accountBalanceProvider);
    return data.when(
      loading: () => AccountBalanceWidget(
        accountBalance: AccountBalance(
          currentBalance: 0,
          lastPaymentDate: DateTime(2000, 1, 1),
          lastPaymentAmount: 0,
          nextDueDate: DateTime(2000, 1, 2),
          paymentMethod: 'Loading...',
        ),
        isLoading: true,
      ),
      error: (e, st) => AccountBalanceWidget(
        accountBalance: AccountBalance(
          currentBalance: 0,
          lastPaymentDate: DateTime(2000, 1, 1),
          lastPaymentAmount: 0,
          nextDueDate: DateTime(2000, 1, 2),
          paymentMethod: 'Error',
        ),
      ),
      data: (balance) => AccountBalanceWidget(
        accountBalance: balance,
        onRefresh: () => ref.read(dashboardRefreshProvider.notifier).refreshAll(ref),
      ),
    );
  }
}

class DailyCostSummaryCard extends ConsumerWidget {
  const DailyCostSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dailyConsumptionProvider);
    return data.when(
      loading: () => DailyCostSummaryWidget(
        consumption: DailyConsumption(
          date: DateTime.now(),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: [],
        ),
        isLoading: true,
      ),
      error: (e, st) => DailyCostSummaryWidget(
        consumption: DailyConsumption(
          date: DateTime.now(),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: [],
        ),
      ),
      data: (consumption) => DailyCostSummaryWidget(
        consumption: consumption,
        onRefresh: () => ref.read(dashboardRefreshProvider.notifier).refreshAll(ref),
      ),
    );
  }
}

class EnergyUsageOverviewCard extends ConsumerWidget {
  const EnergyUsageOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dailyConsumptionProvider);
    return data.when(
      loading: () => EnergyUsageOverviewWidget(
        consumption: DailyConsumption(
          date: DateTime.now(),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: [],
        ),
        isLoading: true,
      ),
      error: (e, st) => EnergyUsageOverviewWidget(
        consumption: DailyConsumption(
          date: DateTime.now(),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: [],
        ),
      ),
      data: (consumption) => EnergyUsageOverviewWidget(
        consumption: consumption,
        onRefresh: () => ref.read(dashboardRefreshProvider.notifier).refreshAll(ref),
      ),
    );
  }
}

class EnergyPricesCard extends ConsumerWidget {
  const EnergyPricesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dailyConsumptionProvider);
    return data.when(
      loading: () => const EnergyPricesWidget(
        isLoading: true,
      ),
      error: (e, st) => const EnergyPricesWidget(),
      data: (consumption) => EnergyPricesWidget(
        onRefresh: () => ref.read(dashboardRefreshProvider.notifier).refreshAll(ref),
      ),
    );
  }
}