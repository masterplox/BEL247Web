import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' show accountSwitcherProvider;
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../services/cost_calculation_service.dart';
import '../state/daily_bill_providers.dart';
import '../widgets/alert_banner_widget.dart';
import '../widgets/daily_bill_widget.dart';

class DailyBillPage extends ConsumerStatefulWidget {
  const DailyBillPage({
    super.key,
    this.date,
  });

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
    ref.listen(accountSwitcherProvider, (_, __) {
      _loadData();
    });

    final dailyBillState = ref.watch(dailyBillProvider);
    final isLoading = ref.watch(dailyBillLoadingProvider);
    final error = ref.watch(dailyBillErrorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Bill Breakdown'),
        actions: [
          IconButton(
            onPressed: () async {
              final currentDate = ref.read(dailyBillProvider).currentConsumption?.date ?? DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: DateTime(currentDate.year - 2, 1, 1),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                ref.read(dailyBillProvider.notifier).loadDailyConsumption(picked);
              }
            },
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Choose date',
          ),
          IconButton(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
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
      return const Center(
        child: CircularProgressIndicator(),
      );
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

          // Peak & Lowest tiles
          Row(
            children: [
              Expanded(child: _buildPeakTile(dailyBillState.currentConsumption)),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(child: _buildLowTile(dailyBillState.currentConsumption)),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Average/Interval and vs Recent Average tiles
          Row(
            children: [
              Expanded(child: _buildAverageTile(dailyBillState.currentConsumption)),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(child: _buildRecentAverageTile(dailyBillState.currentConsumption)),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Cost breakdown card
          _buildCostBreakdown(context, dailyBillState.currentConsumption),
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

  Widget _buildErrorState(BuildContext context, String error) => Center(
      child: Card(
        margin: const EdgeInsets.all(AppTheme.spacing16),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: AppTheme.spacing16),
              Text(
                'Error Loading Data',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                error,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing16),
              ElevatedButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );

  Widget _buildEmptyState(BuildContext context) => Center(
      child: Card(
        margin: const EdgeInsets.all(AppTheme.spacing16),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.receipt_long,
                size: 64,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppTheme.spacing16),
              Text(
                'No Daily Bill Data',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Daily consumption data is not available for the selected date.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacing16),
              ElevatedButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                label: const Text('Load Data'),
              ),
            ],
          ),
        ),
      ),
    );

  Widget _buildAlertsSection(BuildContext context, List<dynamic> alerts) => Card(
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
                const Icon(Icons.notifications, color: AppColors.primary),
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
                    ref.read(dailyBillProvider.notifier).markAllAlertsAsRead();
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

  Widget _buildAlertItem(BuildContext context, dynamic alert) => Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: _getAlertColor(alert.severity).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: _getAlertColor(alert.severity).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getAlertIcon(alert.type),
            color: _getAlertColor(alert.severity),
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.message,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  _formatAlertTime(alert.timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          if (!alert.isRead)
            IconButton(
              onPressed: () {
                ref.read(dailyBillProvider.notifier).markAlertAsRead(alert.id);
              },
              icon: const Icon(Icons.check, size: 16),
              color: AppColors.textSecondary,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
            ),
        ],
      ),
    );

  Widget _buildActionButtons(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement export functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Export functionality coming soon')),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Export Report'),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement share functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share functionality coming soon')),
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  Widget _buildStatCard({
    required String title,
    required String value,
    String? subtitle,
    Color? color,
    IconData? icon,
  }) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(icon, color: color ?? AppColors.textSecondary, size: 18),
                const SizedBox(height: AppTheme.spacing8),
              ],
              Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: AppTheme.spacing8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w700)),
                  if (subtitle != null) ...[
                    const SizedBox(width: AppTheme.spacing4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
                  ],
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildPeakTile(current) {
    final peak = current.peakUsages.isNotEmpty ? current.peakUsages.first : null;
    final timeStr = peak != null ? '${peak.hour.toString().padLeft(2, '0')}:45' : '';
    return _buildStatCard(
      title: 'Peak Interval',
      value: peak != null ? peak.kwh.toStringAsFixed(2) : '0.0',
      subtitle: 'kWh\nat $timeStr',
      color: AppColors.textPrimary,
      icon: Icons.trending_up,
    );
  }

  Widget _buildLowTile(current) {
    final low = current.lowUsages.isNotEmpty ? current.lowUsages.first : null;
    final timeStr = low != null ? '${low.hour.toString().padLeft(2, '0')}:00' : '';
    return _buildStatCard(
      title: 'Lowest Interval',
      value: low != null ? low.kwh.toStringAsFixed(2) : '0.0',
      subtitle: 'kWh\nat $timeStr',
      color: AppColors.textPrimary,
      icon: Icons.trending_down,
    );
  }

  Widget _buildAverageTile(current) {
    final avg = current.averageHourlyUsage == 0 ? (current.totalKwh / 24) : current.averageHourlyUsage;
    return _buildStatCard(
      title: 'Average/Interval',
      value: avg.toStringAsFixed(2),
      subtitle: 'kWh',
      color: AppColors.textPrimary,
      icon: Icons.timeline,
    );
  }

  Widget _buildRecentAverageTile(current) {
    final recentAvg = current.pattern.previousWeekAverage ?? current.totalKwh;
    final diff = recentAvg == 0 ? 0 : ((current.totalKwh - recentAvg) / recentAvg) * 100;
    final isAbove = diff > 0;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius12)),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(isAbove ? Icons.trending_up : Icons.trending_down, color: isAbove ? AppColors.error : AppColors.success, size: 18),
                const SizedBox(width: AppTheme.spacing8),
                Text('vs Recent Average', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Text('${diff.abs().toStringAsFixed(1)}%', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: isAbove ? AppColors.error : AppColors.success, fontWeight: FontWeight.w700)),
                const SizedBox(width: AppTheme.spacing8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8, vertical: AppTheme.spacing4),
                  decoration: BoxDecoration(
                    color: isAbove ? AppColors.error.withOpacity(0.1) : AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius20),
                    border: Border.all(color: isAbove ? AppColors.error.withOpacity(0.3) : AppColors.success.withOpacity(0.3)),
                  ),
                  child: Text(isAbove ? 'Above average' : 'Below average', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: isAbove ? AppColors.error : AppColors.success, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostBreakdown(BuildContext context, current) {
    final costCalculation = CostCalculationService.calculateDailyCost(current);
    final b = costCalculation.costBreakdown;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primaryLight.withOpacity(0.06), Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Daily Consumption Breakdown', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppTheme.spacing12),
          _breakdownRow(context, 'Energy Charge (${current.totalKwh.toStringAsFixed(1)} kWh × BZ\$0.35)', b.energyCharge),
          _breakdownRow(context, 'Service Fee', b.serviceFee),
          const Divider(),
          _breakdownRow(context, 'Total Estimated Cost', b.totalCost, isTotal: true),
        ]),
      ),
    );
  }

  Widget _breakdownRow(BuildContext context, String label, double amount, {bool isTotal = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal)),
          Text('BZ\$${amount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal)),
        ],
      );

  Color _getAlertColor(dynamic severity) {
    switch (severity.toString()) {
      case 'AlertSeverity.critical':
        return AppColors.error;
      case 'AlertSeverity.high':
        return AppColors.error;
      case 'AlertSeverity.medium':
        return AppColors.warning;
      case 'AlertSeverity.low':
        return AppColors.primary;
      default:
        return AppColors.textSecondary;
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

  String _formatAlertTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
