import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../data/models/ami_data.dart' show ratePerKwh;
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/ami_dashboard_usage_providers.dart';

/// Dashboard usage stats for AMI meters.
///
/// This mirrors the layout/interaction of `UsageStatsWidget`, but uses AMI data
/// (amiDailyRange + amiMonthlyTotals) instead of legacy monthly meter readings.
class AmiUsageStatsWidget extends ConsumerWidget {
  const AmiUsageStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(amiDashboardUsageStatsProvider);

    return statsAsync.when(
      loading: () => _buildLoadingGrid(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (stats) {
        // If nothing to show, behave like legacy widget (hide section).
        if (stats.thisMonthDaysWithData == 0 && stats.monthsAnalyzed == 0) {
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

  List<Map<String, dynamic>> _buildCards(
    ({
      double thisMonthKwh,
      double thisMonthEstimatedCost,
      int thisMonthDaysWithData,
      double lastMonthKwh,
      double diffVsLastMonthKwh,
      bool savedEnergy,
      String peakMonthLabel,
      double peakMonthKwh,
      double avgMonthlyKwh,
      double yearlyTotalKwh,
      double yearlyEstimatedCost,
      int monthsAnalyzed,
    }) stats,
  ) {
    final thisMonthKwh = stats.thisMonthKwh;
    final lastMonthKwh = stats.lastMonthKwh;
    final diff = stats.diffVsLastMonthKwh;
    final savedEnergy = stats.savedEnergy;
    print('ami stats: $stats');
    return [
      {
        'label': 'This Month',
        'value': thisMonthKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.bolt,
        'color': AppColors.primary,
        'bgColor': AppColors.primary,
        'detailTitle': 'Current Month Usage (AMI)',
        'detailItems': [
          {'label': 'Consumption', 'value': '${thisMonthKwh.toStringAsFixed(2)} kWh'},
          {'label': 'Est. Cost', 'value': r'BZ$' + stats.thisMonthEstimatedCost.toStringAsFixed(2)},
          {'label': 'Rate', 'value': r'BZ$' + ratePerKwh.toStringAsFixed(2) + '/kWh'},
          {'label': 'Days with data', 'value': '${stats.thisMonthDaysWithData} days'},
        ],
      },
      {
        'label': 'vs Last Month',
        'value': savedEnergy
            ? '-${diff.abs().toStringAsFixed(0)}'
            : '+${diff.abs().toStringAsFixed(0)}',
        'unit': 'kWh',
        'icon': Icons.trending_up,
        'color': savedEnergy ? AppColors.success : AppColors.error,
        'bgColor': savedEnergy ? AppColors.success : AppColors.error,
        'detailTitle': 'Month Comparison (AMI)',
        'detailItems': [
          {'label': 'Last Month', 'value': '${lastMonthKwh.toStringAsFixed(2)} kWh'},
          {'label': 'This Month', 'value': '${thisMonthKwh.toStringAsFixed(2)} kWh'},
          {'label': 'Difference', 'value': '${diff.toStringAsFixed(2)} kWh'},
        ],
      },
      {
        'label': 'Peak Month (${stats.peakMonthLabel})',
        'value': stats.peakMonthKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.local_fire_department,
        'color': AppColors.warning,
        'bgColor': AppColors.warning,
        'detailTitle': 'Peak Usage Month (AMI)',
        'detailItems': [
          {'label': 'Month', 'value': stats.peakMonthLabel},
          {'label': 'Consumption', 'value': '${stats.peakMonthKwh.toStringAsFixed(2)} kWh'},
          {'label': 'Est. Cost', 'value': r'BZ$' + (stats.peakMonthKwh * ratePerKwh).toStringAsFixed(2)},
        ],
      },
      {
        'label': 'Avg Monthly',
        'value': stats.avgMonthlyKwh.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.bar_chart,
        'color': const Color(0xFF8B5CF6),
        'bgColor': const Color(0xFF8B5CF6),
        'detailTitle': 'Average Statistics (AMI)',
        'detailItems': [
          {'label': 'Avg. Monthly Usage', 'value': '${stats.avgMonthlyKwh.toStringAsFixed(2)} kWh'},
          {'label': 'Yearly Total', 'value': r'BZ$' + stats.yearlyEstimatedCost.toStringAsFixed(2)},
          {'label': 'Months Analyzed', 'value': '${stats.monthsAnalyzed}'},
          {'label': 'Total kWh', 'value': stats.yearlyTotalKwh.toStringAsFixed(0)},
        ],
      },
    ];
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (stat['detailItems'] as List<Map<String, String>>)
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
                    Text(
                      item['value']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
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
}

