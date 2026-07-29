import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../data/models/ami_data.dart' show ratePerKwh;
import '../../../data/models/billing_period.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/billing_period_providers.dart';

/// Dashboard usage stats for AMI meters.
///
/// This mirrors the layout/interaction of `UsageStatsWidget`, but is scoped to
/// billing periods rather than calendar months. "This Billing Period" is the
/// cycle the account is currently inside, so its usage is partial and its
/// amount is not billed yet.
class AmiUsageStatsWidget extends ConsumerWidget {
  const AmiUsageStatsWidget({super.key});
  static final DateFormat _scopeDateFormat = DateFormat('MMM d, yyyy');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(billingPeriodsProvider);

    return statsAsync.when(
      loading: () => _buildLoadingGrid(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (stats) {
        // If nothing to show, behave like legacy widget (hide section).
        if (!stats.hasUsageData) {
          return const SizedBox.shrink();
        }

        final cards = _buildCards(stats);

        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isMobile = screenWidth < AppTheme.tabletBreakpoint;

            if (isMobile) {
              return Column(
                children: [
                  ...cards.map(
                    (stat) => Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                      child: _buildStatCard(context, stat),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                ],
              );
            }

            final availableWidth = constraints.maxWidth;
            const crossAxisSpacing = AppTheme.spacing12;
            final cardWidth = (availableWidth - crossAxisSpacing) / 2;

            return Column(
              children: [
                Wrap(
                  spacing: crossAxisSpacing,
                  runSpacing: AppTheme.spacing12,
                  children: cards
                      .map(
                        (stat) => SizedBox(
                          width: cardWidth,
                          child: _buildStatCard(context, stat),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingGrid(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isMobile = screenWidth < AppTheme.tabletBreakpoint;

          if (isMobile) {
            return Column(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(bottom: AppTheme.spacing12),
                  child: AppCard(
                    padding: EdgeInsets.all(AppTheme.spacing16),
                    showBorder: true,
                    borderWidth: 1,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            );
          }

          final availableWidth = constraints.maxWidth;
          const crossAxisSpacing = AppTheme.spacing12;
          final cardWidth = (availableWidth - crossAxisSpacing) / 2;

          return Wrap(
            spacing: crossAxisSpacing,
            runSpacing: AppTheme.spacing12,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: cardWidth,
                child: const AppCard(
                  padding: EdgeInsets.all(AppTheme.spacing16),
                  showBorder: true,
                  borderWidth: 1,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      );

  List<Map<String, dynamic>> _buildCards(BillingPeriodsResult stats) {
    final cards = <Map<String, dynamic>>[];

    final current = stats.current;
    final previous = stats.previous;
    final peak = stats.peak;

    if (current != null) {
      cards.add({
        'label': 'This Billing Period',
        'subLabel': current.label,
        'value': current.usageKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.bolt,
        'color': AppColors.primary,
        'bgColor': AppColors.primary,
        'detailTitle': 'Current Billing Period Usage',
        'detailSubtitle': 'The billing period you are currently in',
        'detailItems': [
          {'label': 'Billing Period', 'value': current.label},
          {
            'label': 'Consumption',
            'value': '${current.usageKwh.toStringAsFixed(2)} kWh',
          },
          {
            'label': 'Est. Amount',
            'value': '\$${(current.usageKwh * ratePerKwh).toStringAsFixed(2)}',
          },
          {
            'label': 'Daily Average',
            'value': '${current.avgDailyKwh.toStringAsFixed(1)} kWh',
          },
          {
            'label': 'Billing Days',
            'value': '${current.daysWithData} of ${current.days} days',
          },
        ],
      });
    }

    if (current != null && previous != null) {
      final diff = stats.diffVsPreviousKwh;
      final savedEnergy = stats.savedEnergy;

      cards.add({
        'label': 'vs Last Billing Period',
        'subLabel': '${current.label} vs ${previous.label}',
        'value': savedEnergy
            ? '-${diff.abs().toStringAsFixed(0)}'
            : '+${diff.abs().toStringAsFixed(0)}',
        'unit': 'kWh',
        'icon': Icons.trending_up,
        'color': savedEnergy ? AppColors.success : AppColors.error,
        'bgColor': savedEnergy ? AppColors.success : AppColors.error,
        'detailTitle': 'Billing Period Comparison',
        'detailSubtitle':
            'Compared over the same number of days so far, not against the full previous period',
        'detailItems': [
          {
            'label': 'Current Period',
            'value': '${current.label} • ${current.usageKwh.toStringAsFixed(2)} kWh',
          },
          {
            'label': 'Previous Period',
            'value':
                '${previous.label} • ${stats.previousPeriodToDateKwh.toStringAsFixed(2)} kWh',
          },
          {
            'label': 'Days Compared',
            'value': '${current.daysWithData} days',
          },
          {
            'label': 'Difference',
            'value': '${diff.toStringAsFixed(2)} kWh',
            'icon': diff < 0 ? Icons.arrow_upward : Icons.arrow_downward,
            'valueColor': diff < 0 ? AppColors.error : AppColors.success,
          },
        ],
      });
    }

    if (peak != null) {
      cards.add({
        'label': 'Peak Billing Period',
        'subLabel': peak.label,
        'value': peak.usageKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.local_fire_department,
        'color': AppColors.warning,
        'bgColor': AppColors.warning,
        'detailTitle': 'Peak Usage Billing Period',
        'detailSubtitle': 'Your highest billed period',
        'detailItems': [
          {'label': 'Billing Period', 'value': peak.label},
          {
            'label': 'Consumption',
            'value': '${peak.usageKwh.toStringAsFixed(2)} kWh',
          },
          if (peak.amount != null)
            {'label': 'Amount', 'value': '\$${peak.amount!.toStringAsFixed(2)}'},
          {
            'label': 'Daily Average',
            'value': '${peak.avgDailyKwh.toStringAsFixed(1)} kWh',
          },
        ],
      });
    }

    if (stats.periodsAnalyzed > 0) {
      final scope = _formatScope(stats.scopeStart, stats.scopeEnd);

      cards.add({
        'label': 'Avg per Billing Period',
        'subLabel': scope,
        'value': stats.avgPeriodKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.bar_chart,
        'color': const Color(0xFF8B5CF6),
        'bgColor': const Color(0xFF8B5CF6),
        'detailTitle': 'Average Statistics',
        'detailSubtitle': 'Averaged across your completed billing periods',
        'detailItems': [
          {'label': 'Date Scope', 'value': scope},
          {
            'label': 'Avg. per Billing Period',
            'value': '${stats.avgPeriodKwh.toStringAsFixed(2)} kWh',
          },
          if (stats.totalAmount > 0)
            {
              'label': 'Total Billed',
              'value': '\$${stats.totalAmount.toStringAsFixed(2)}',
            },
          {
            'label': 'Billing Periods Analyzed',
            'value': '${stats.periodsAnalyzed}',
          },
          {'label': 'Total kWh', 'value': stats.totalKwh.toStringAsFixed(0)},
        ],
      });
    }

    return cards;
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat) => InkWell(
        onTap: () => _showDetailsDialog(context, stat),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        child: AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          showBorder: true,
          borderWidth: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: (stat['bgColor'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      size: 16,
                      color: stat['color'] as Color,
                    ),
                  ),
                  IgnorePointer(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'More',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        const Icon(
                          Icons.chevron_right,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing12),
              Text(
                stat['label'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    stat['value'] as String,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: stat['color'] as Color,
                        ),
                  ),
                  const SizedBox(width: AppTheme.spacing4),
                  Text(
                    stat['unit'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
              if (stat['subLabel'] != null) ...[
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  stat['subLabel'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ],
          ),
        ),
      );

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> stat) {
    AppDialog.showCenter(
      context: context,
      title: stat['detailTitle'] as String,
      subtitle: stat['detailSubtitle'] as String?,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (stat['detailItems'] as List<Map<String, dynamic>>)
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item['icon'] != null) ...[
                          Icon(
                            item['icon'] as IconData,
                            size: 14,
                            color: item['valueColor'] as Color? ?? AppColors.textPrimary,
                          ),
                          const SizedBox(width: AppTheme.spacing4),
                        ],
                        Text(
                          item['value']!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: item['valueColor'] as Color?,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  String _formatScope(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '-';
    return '${_scopeDateFormat.format(start)} - ${_scopeDateFormat.format(end)}';
  }
}

