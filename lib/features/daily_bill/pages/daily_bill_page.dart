import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart'
    show accountSwitcherProvider;
import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_alert_item.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_error_state.dart';
import '../../../core/widgets/app_stat_card.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/daily_bill_providers.dart';
import '../widgets/alert_banner_widget.dart';
import '../widgets/daily_bill_widget.dart';

class DailyBillPage extends ConsumerStatefulWidget {
  const DailyBillPage({super.key, this.date});

  final DateTime? date;

  @override
  ConsumerState<DailyBillPage> createState() => _DailyBillPageState();
}

class _DailyBillPageState extends ConsumerState<DailyBillPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final date = widget.date ?? DateTime.now();
    ref.read(dailyBillProvider.notifier).loadDailyConsumption(date);
  }

  @override
  Widget build(BuildContext context) {
    // Recompute when active account changes and reload
    ref.watch(accountSwitcherProvider);
    ref.listen(accountSwitcherProvider, (previous, next) {
      // Only reload if account actually changed
      if (previous?.activeAccountId != next.activeAccountId) {
        // Defer execution to prevent rebuild loops
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _loadData();
          }
        });
      }
    });

    final dailyBillState = ref.watch(dailyBillProvider);
    final isLoading = ref.watch(dailyBillLoadingProvider);
    final error = ref.watch(dailyBillErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Bill Breakdown'),
        actions: const [
          // IconButton(
          //   onPressed: () async {
          //     final currentDate =
          //         ref.read(dailyBillProvider).currentConsumption?.date ??
          //         DateTime.now();
          //     final picked = await showDatePicker(
          //       context: context,
          //       initialDate: currentDate,
          //       firstDate: DateTime(currentDate.year - 2, 1, 1),
          //       lastDate: DateTime.now().add(const Duration(days: 365)),
          //     );
          //     if (picked != null) {
          //       ref
          //           .read(dailyBillProvider.notifier)
          //           .loadDailyConsumption(picked);
          //     }
          //   },
          //   icon: const Icon(Icons.calendar_today),
          //   tooltip: 'Choose date',
          // ),
          // IconButton(
          //   onPressed: _loadData,
          //   icon: const Icon(Icons.refresh),
          //   tooltip: 'Refresh',
          // ),
        ],
      ),
      body: AlertBannerManager(
        child: _buildBody(context, dailyBillState, isLoading, error),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    dynamic dailyBillState,
    bool isLoading,
    String? error,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return _buildErrorState(context, error);
    }

    if (dailyBillState.currentConsumption == null) {
      return _buildEmptyState(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Bill Widget
          DailyBillWidget(
            dailyConsumption: dailyBillState.currentConsumption,
            isLoading: isLoading,
          ),
          const SizedBox(height: AppTheme.spacing16),

          LayoutBuilder(
            builder: (context, constraints) {
              final stack = constraints.maxWidth < 480;
              final peakLow = [
                _buildPeakTile(dailyBillState.currentConsumption),
                _buildLowTile(dailyBillState.currentConsumption),
              ];
              final avgProjected = [
                _buildAverageTile(dailyBillState.currentConsumption),
                _buildProjectedMonthlyTile(dailyBillState.currentConsumption),
              ];
              if (stack) {
                return Column(
                  children: [
                    peakLow[0],
                    const SizedBox(height: AppTheme.spacing16),
                    peakLow[1],
                    const SizedBox(height: AppTheme.spacing16),
                    avgProjected[0],
                    const SizedBox(height: AppTheme.spacing16),
                    avgProjected[1],
                  ],
                );
              }
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: peakLow[0]),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(child: peakLow[1]),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Row(
                    children: [
                      Expanded(child: avgProjected[0]),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(child: avgProjected[1]),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Cost breakdown card
          // _buildCostBreakdown(context, dailyBillState.currentConsumption),
          const SizedBox(height: AppTheme.spacing16),

          // Alerts Section
          if (dailyBillState.hasAlerts) ...[
            _buildAlertsSection(context, dailyBillState.alerts),
            const SizedBox(height: AppTheme.spacing16),
          ],

          // Action Buttons
          // _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) => AppErrorState(
        title: 'Error Loading Data',
        message: error,
        onRetry: _loadData,
      );

  Widget _buildEmptyState(BuildContext context) => AppEmptyState(
        title: 'No Daily Bill Data',
        message: 'Daily consumption data is not available for the selected date.',
        icon: Icons.receipt_long,
        actionLabel: 'Load Data',
        onAction: _loadData,
      );

  Widget _buildAlertsSection(BuildContext context, List<dynamic> alerts) =>
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Alerts & Notifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(dailyBillProvider.notifier)
                          .markAllAlertsAsRead();
                    },
                    child: const Text('Mark All Read'),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing12),
              ...alerts.map((alert) => _buildAlertItem(context, alert)),
            ],
          ),
        ),
      );

  Widget _buildAlertItem(BuildContext context, dynamic alert) => AppAlertItem(
        message: alert.message,
        timestamp: FormattingUtils.formatAlertTime(alert.timestamp),
        severityColor: _getAlertColor(alert.severity),
        icon: _getAlertIcon(alert.type),
        isRead: alert.isRead,
        onMarkRead: () {
          ref.read(dailyBillProvider.notifier).markAlertAsRead(alert.id);
        },
      );

  Widget _buildStatCard({
    required String title,
    required String value,
    String? subtitle,
    Color? color,
    IconData? icon,
  }) => AppStatCard(
        title: title,
        value: value,
        subtitle: subtitle,
        color: color,
        icon: icon,
      );

  Widget _buildPeakTile(current) {
    final peak = current.peakUsages.isNotEmpty
        ? current.peakUsages.first
        : null;
    final timeStr = peak != null
        ? '${peak.hour.toString().padLeft(2, '0')}:45'
        : '';
    return _buildStatCard(
      title: 'Peak Interval',
      value: peak != null ? peak.kwh.toStringAsFixed(2) : '0.0',
      subtitle: 'kWh\nat $timeStr',
      color: Theme.of(context).textTheme.bodyLarge?.color,
      icon: Icons.trending_up,
    );
  }

  Widget _buildLowTile(current) {
    final low = current.lowUsages.isNotEmpty ? current.lowUsages.first : null;
    final timeStr = low != null
        ? '${low.hour.toString().padLeft(2, '0')}:00'
        : '';
    return _buildStatCard(
      title: 'Lowest Interval',
      value: low != null ? low.kwh.toStringAsFixed(2) : '0.0',
      subtitle: 'kWh\nat $timeStr',
      color: Theme.of(context).textTheme.bodyLarge?.color,
      icon: Icons.trending_down,
    );
  }

  Widget _buildAverageTile(current) {
    final avg = current.averageHourlyUsage == 0
        ? (current.totalKwh / 24)
        : current.averageHourlyUsage;
    return _buildStatCard(
      title: 'Average/Interval',
      value: avg.toStringAsFixed(2),
      subtitle: 'kWh',
      color: Theme.of(context).textTheme.bodyLarge?.color,
      icon: Icons.timeline,
    );
  }

  Widget _buildProjectedMonthlyTile(current) {
    final projectedUsage = current.totalKwh * 30;
    final projectedCost = current.cost * 30;
    final dailyCost = current.cost;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary, size: 18),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  'Projected Monthly Outlook',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              'BZ\$${projectedCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '${projectedUsage.toStringAsFixed(1)} kWh expected over 30 days',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              'Daily estimate: BZ\$${dailyCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  /*
  Widget _buildCostBreakdown(BuildContext context, current) {
    final costCalculation = CostCalculationService.calculateDailyCost(current);
    final b = costCalculation.costBreakdown;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight.withValues(alpha: 0.06), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Consumption Breakdown',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _breakdownRow(
              context,
              'Energy Charge (${current.totalKwh.toStringAsFixed(1)} kWh × BZ\$0.35)',
              b.energyCharge,
            ),
            _breakdownRow(context, 'Service Fee', b.serviceFee),
            const Divider(),
            _breakdownRow(
              context,
              'Total Estimated Cost',
              b.totalCost,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _breakdownRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      Text(
        'BZ\$${amount.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    ],
  );
  */
  Color _getAlertColor(dynamic severity) {
    switch (severity.toString()) {
      case 'AlertSeverity.critical':
        return Theme.of(context).colorScheme.error;
      case 'AlertSeverity.high':
        return Theme.of(context).colorScheme.error;
      case 'AlertSeverity.medium':
        return Theme.of(context).colorScheme.secondary;
      case 'AlertSeverity.low':
        return Theme.of(context).colorScheme.primary;
      default:
        return Theme.of(context).textTheme.bodySmall?.color ?? AppColors.textSecondary;
    }
  }

  IconData _getAlertIcon(dynamic type) {
    switch (type.toString()) {
      case 'AlertType.highUsage':
        return Icons.trending_up;
      case 'AlertType.lowUsage':
        return Icons.trending_down;
      case 'AlertType.costAlert':
        return Icons.attach_money;
      case 'AlertType.efficiencyAlert':
        return Icons.speed;
      case 'AlertType.peakHourAlert':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

}
