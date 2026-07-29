import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/meter_data_config.dart';
import '../../../core/providers/meter_data_providers.dart';
import '../../../core/services/user_preferences_storage.dart';
import '../../../core/widgets/bel_mobile_app_qr_card.dart';
import '../auth/providers/auth_provider.dart';
import 'providers/dashboard_greeting_provider.dart';
import '../../../core/widgets/account_aware_scaffold.dart';
import '../../../core/widgets/account_switcher.dart';
import '../../../core/widgets/app_page_scaffold.dart';
import '../../../features/usage/state/meter_readings_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import 'state/billing_period_providers.dart';
import 'widgets/account_details_widget.dart';
import 'widgets/account_verification_banner.dart';
import 'widgets/ami_insights_disclaimer_banner.dart';
import 'widgets/ami_consumption_chart_widget.dart';
import 'widgets/ami_usage_stats_widget.dart';
import 'widgets/balance_card_widget.dart';
import 'widgets/consumption_chart_widget.dart';
// import 'widgets/dashboard_account_switcher.dart';
import 'widgets/gamification_card_widget.dart';
import 'widgets/usage_stats_widget.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AccountAwareScaffold(
      emptyMessage:
          'You don\'t have any accounts connected yet. Connect an account to view your energy dashboard, bills, and usage history.',
      emptyIcon: Icons.account_circle_outlined,
      belowEmptyState: const AmiInsightsDisclaimerBanner(),
      builder: (context, ref, accountState) {
        final meterDataSource = ref.watch(meterDataSourceProvider);
        final hasAmiConnectedAccount = accountState.accounts.any(
          (account) => MeterDataResolver.isAmiMeter(account.meterNumber),
        );

        final session = ref.watch(authNotifierProvider).userSession;
        final usernameFromSession =
            (session?.preferences['username'] as String?)?.trim() ?? '';
        final username =
            usernameFromSession.isNotEmpty ? usernameFromSession : session?.email.trim() ?? '';

        final welcomeBackAsync = ref.watch(showWelcomeBackGreetingProvider);
        final showWelcomeBack = welcomeBackAsync.valueOrNull ?? true;
        final greetingTitle = showWelcomeBack && username.isNotEmpty
            ? 'Welcome back, $username'
            : 'Welcome';

        ref.listen(showWelcomeBackGreetingProvider, (previous, next) {
          next.whenData((hasShownBefore) {
            if (!hasShownBefore) {
              final userId =
                  ref.read(authNotifierProvider).userSession?.userId;
              if (userId != null) {
                UserPreferencesStorage.markWelcomeBackShown(userId);
              }
            }
          });
        });

        final header = LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 640;
            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greetingTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'Track usage, view balances, and manage your account all in one place.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  
                  const AccountSwitcherCard(
                    isExpanded: true,
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetingTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      'Track usage, view balances, and manage your account all in one place.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                    ),
                  ],
                ),
                // Room for a future compact account switcher on larger screens
              ],
            );
          },
        );

        final showReadingsSection = meterDataSource == MeterDataSource.ami
            ? ref.watch(hasBillingPeriodUsageProvider).maybeWhen(
                data: (hasData) => hasData,
                loading: () => true,
                orElse: () => false,
              )
            : ref.watch(meterReadingsThisYearProvider).maybeWhen(
                data: (readings) => readings.isNotEmpty,
                loading: () => true,
                orElse: () => false,
              );

        final grid = LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1024;

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        BalanceCardWidget(),
                        SizedBox(height: AppTheme.spacing16),
                        GamificationCardWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing16),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        if (showReadingsSection) ...[
                          if (meterDataSource == MeterDataSource.ami) ...[
                            const AmiUsageStatsWidget(),
                            const SizedBox(height: AppTheme.spacing16),
                            const AmiConsumptionChartWidget(),
                          ] else ...[
                            const UsageStatsWidget(),
                            const SizedBox(height: AppTheme.spacing16),
                            const ConsumptionChartWidget(),
                          ],
                          const SizedBox(height: AppTheme.spacing16),
                        ],
                        const AccountDetailsWidget(),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                const BalanceCardWidget(),
                const SizedBox(height: AppTheme.spacing16),
                const GamificationCardWidget(),
                const SizedBox(height: AppTheme.spacing16),
                if (showReadingsSection) ...[
                  if (meterDataSource == MeterDataSource.ami) ...[
                    const AmiUsageStatsWidget(),
                    const SizedBox(height: AppTheme.spacing16),
                    const AmiConsumptionChartWidget(),
                  ] else ...[
                    const UsageStatsWidget(),
                    const SizedBox(height: AppTheme.spacing16),
                    const ConsumptionChartWidget(),
                  ],
                  const SizedBox(height: AppTheme.spacing16),
                ],
                const AccountDetailsWidget(),
              ],
            );
          },
        );

        return AppPageScaffold(
          title: 'Dashboard',
          subtitle: 'Here\'s your energy overview',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Keep the richer, responsive header instead of the simple title
              header,
              const SizedBox(height: AppTheme.spacing12),
              if (!hasAmiConnectedAccount) ...[
                const AmiInsightsDisclaimerBanner(),
                const SizedBox(height: AppTheme.spacing8),
              ],
              const AccountVerificationBanner(),
              const SizedBox(height: AppTheme.spacing8),
              grid,
              const SizedBox(height: AppTheme.spacing24),
              const BelMobileAppQrCard(),
            ],
          ),
        );
      },
    );
}