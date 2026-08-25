import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
// Dollar amounts are hidden in this version. They will be shown in a future release.
// import '../../../data/models/ami_data.dart' show ratePerKwh;
import '../../../data/models/usage_dashboard_cards.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/ami_dashboard_usage_providers.dart';

/// Dashboard usage stats for AMI meters.
///
/// Card values come from `/AMI/UsageDashboardCards`. Tapping More opens a
/// details dialog with card-specific stats and the billed-period rows.
class AmiUsageStatsWidget extends ConsumerWidget {
  const AmiUsageStatsWidget({super.key});
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(usageDashboardCardsProvider);

    return statsAsync.when(
      loading: () => _buildLoadingGrid(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (stats) {
        if (!stats.hasUsageData) {
          return const SizedBox.shrink();
        }

        final cards = _buildCards(stats);

        return LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final isMobile = availableWidth < AppTheme.tabletBreakpoint;

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
          final availableWidth = constraints.maxWidth;
          final isMobile = availableWidth < AppTheme.tabletBreakpoint;

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

  List<_StatCardData> _buildCards(UsageDashboardCardsResult stats) {
    final cards = <_StatCardData>[];

    if (stats.hasCurrentPeriod) {
      final progress = stats.daysInPeriod > 0
          ? 'Day ${stats.daysElapsed} of ${stats.daysInPeriod}'
          : null;
      final subLabel = [
        if (stats.currentPeriodLabel.isNotEmpty) stats.currentPeriodLabel,
        if (progress != null) progress,
      ].join(' · ');

      cards.add(
        _StatCardData(
          label: 'This Billing Period',
          subLabel: subLabel.isEmpty ? null : subLabel,
          value: stats.currentPeriodKWh.toStringAsFixed(0),
          unit: 'kWh',
          icon: Icons.bolt,
          color: AppColors.primary,
          detailTitle: 'Current Billing Period Usage',
          detailSubtitle: 'The billing period you are currently in',
          detailItems: [
            if (stats.currentPeriodLabel.isNotEmpty)
              _DetailItem(label: 'Billing Period', value: stats.currentPeriodLabel),
            _DetailItem(
              label: 'Consumption',
              value: '${stats.currentPeriodKWh.toStringAsFixed(2)} kWh',
            ),
            // Dollar amounts are hidden in this version. They will be shown in a future release.
            // _DetailItem(
            //   label: 'Est. Amount',
            //   value:
            //       '\$${(stats.currentPeriodKWh * ratePerKwh).toStringAsFixed(2)}',
            // ),
            if (stats.daysElapsed > 0)
              _DetailItem(
                label: 'Daily Average',
                value:
                    '${stats.currentDailyAverageKWh.toStringAsFixed(1)} kWh',
              ),
            if (stats.daysInPeriod > 0)
              _DetailItem(
                label: 'Billing Days',
                value: '${stats.daysElapsed} of ${stats.daysInPeriod} days',
              ),
            if (stats.currentStartDate != null && stats.currentEndDate != null)
              _DetailItem(
                label: 'Period Dates',
                value:
                    '${_dateFormat.format(stats.currentStartDate!)} - ${_dateFormat.format(stats.currentEndDate!)}',
              ),
          ],
          billedPeriods: stats.billedPeriods,
        ),
      );
    }

    if (stats.hasPreviousComparison) {
      final variance = stats.varianceKWh;
      final usedMore = stats.usedMoreThanPrevious;
      final usedLess = stats.usedLessThanPrevious;
      final varianceColor = usedLess
          ? AppColors.success
          : usedMore
              ? AppColors.error
              : AppColors.textSecondary;

      cards.add(
        _StatCardData(
          label: 'vs Previous Billing Period',
          subLabel:
              stats.comparisonLabel.isEmpty ? null : stats.comparisonLabel,
          value: usedLess
              ? '-${variance.abs().toStringAsFixed(0)}'
              : usedMore
                  ? '+${variance.abs().toStringAsFixed(0)}'
                  : '0',
          unit: 'kWh',
          icon: Icons.trending_up,
          color: varianceColor,
          detailTitle: 'Billing Period Comparison',
          detailSubtitle:
              'Compared over the same number of days so far, not against the full previous period',
          detailItems: [
            _DetailItem(
              label: 'Current Period',
              value: [
                if (stats.currentPeriodLabel.isNotEmpty)
                  stats.currentPeriodLabel,
                '${stats.currentPeriodKWh.toStringAsFixed(2)} kWh',
              ].join(' • '),
            ),
            _DetailItem(
              label: 'Previous Period to Date',
              value: '${stats.previousPeriodToDateKWh.toStringAsFixed(2)} kWh',
            ),
            if (stats.daysElapsed > 0)
              _DetailItem(
                label: 'Days Compared',
                value: '${stats.daysElapsed} days',
              ),
            _DetailItem(
              label: 'Difference',
              value: '${variance.toStringAsFixed(2)} kWh',
              icon: usedMore
                  ? Icons.arrow_upward
                  : usedLess
                      ? Icons.arrow_downward
                      : null,
              valueColor: usedMore || usedLess ? varianceColor : null,
            ),
          ],
          billedPeriods: stats.billedPeriods,
        ),
      );
    }

    if (stats.hasPeakPeriod) {
      cards.add(
        _StatCardData(
          label: 'Peak Billing Period',
          subLabel:
              stats.peakPeriodLabel.isEmpty ? null : stats.peakPeriodLabel,
          value: stats.peakBilledKWh.toStringAsFixed(0),
          unit: 'kWh',
          icon: Icons.local_fire_department,
          color: AppColors.warning,
          detailTitle: 'Peak Usage Billing Period',
          detailSubtitle: 'Your highest billed period',
          detailItems: [
            if (stats.peakPeriodLabel.isNotEmpty)
              _DetailItem(label: 'Billing Period', value: stats.peakPeriodLabel),
            _DetailItem(
              label: 'Consumption',
              value: '${stats.peakBilledKWh.toStringAsFixed(2)} kWh',
            ),
          ],
          billedPeriods: stats.billedPeriods,
          highlightPeak: true,
        ),
      );
    }

    if (stats.hasAverageUsage) {
      cards.add(
        _StatCardData(
          label: 'Average Usage',
          subLabel: stats.avgRangeLabel.isEmpty ? null : stats.avgRangeLabel,
          value: stats.avgBilledKWh.toStringAsFixed(0),
          unit: 'kWh',
          icon: Icons.bar_chart,
          color: const Color(0xFF8B5CF6),
          detailTitle: 'Average Statistics',
          detailSubtitle: 'Averaged across your completed billing periods',
          detailItems: [
            if (stats.avgRangeLabel.isNotEmpty)
              _DetailItem(label: 'Date Scope', value: stats.avgRangeLabel),
            _DetailItem(
              label: 'Avg. per Billing Period',
              value: '${stats.avgBilledKWh.toStringAsFixed(2)} kWh',
            ),
            if (stats.periodsAnalyzed > 0)
              _DetailItem(
                label: 'Billing Periods Analyzed',
                value: '${stats.periodsAnalyzed}',
              ),
          ],
          billedPeriods: stats.billedPeriods,
        ),
      );
    }

    return cards;
  }

  Widget _buildStatCard(BuildContext context, _StatCardData stat) => InkWell(
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
                      color: stat.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: Icon(
                      stat.icon,
                      size: 16,
                      color: stat.color,
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
                stat.label,
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
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        stat.value,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: stat.color,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing4),
                  Text(
                    stat.unit,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
              if (stat.subLabel != null) ...[
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  stat.subLabel!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      );

  void _showDetailsDialog(BuildContext context, _StatCardData stat) {
    AppDialog.showCenter(
      context: context,
      title: stat.detailTitle,
      subtitle: stat.detailSubtitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...stat.detailItems.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.icon != null) ...[
                        Icon(
                          item.icon,
                          size: 14,
                          color: item.valueColor ?? AppColors.textPrimary,
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                      ],
                      Text(
                        item.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: item.valueColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (stat.billedPeriods.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Billed Periods',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            ...stat.billedPeriods.map(
              (period) => _buildBilledPeriodRow(
                context,
                period,
                highlightPeak: stat.highlightPeak,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildBilledPeriodRow(
    BuildContext context,
    BilledPeriodSummary period, {
    required bool highlightPeak,
  }) {
    final isPeak = highlightPeak && period.isPeak;
    final title = period.label.isNotEmpty
        ? period.label
        : period.rangeLabel.isNotEmpty
            ? period.rangeLabel
            : period.periodId;
    final subtitle = period.rangeLabel.isNotEmpty && period.rangeLabel != title
        ? period.rangeLabel
        : (period.days > 0 ? '${period.days} days' : null);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title.isEmpty ? 'Billing period' : title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isPeak ? AppColors.warning : null,
                            ),
                      ),
                    ),
                    if (isPeak) ...[
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        'Peak',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
              ],
            ),
          ),
          Text(
            '${period.billedKWh.toStringAsFixed(2)} kWh',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPeak ? AppColors.warning : null,
                ),
          ),
        ],
      ),
    );
  }
}

class _StatCardData {
  const _StatCardData({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.detailTitle,
    required this.detailItems,
    this.subLabel,
    this.detailSubtitle,
    this.billedPeriods = const [],
    this.highlightPeak = false,
  });

  final String label;
  final String? subLabel;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final String detailTitle;
  final String? detailSubtitle;
  final List<_DetailItem> detailItems;
  final List<BilledPeriodSummary> billedPeriods;
  final bool highlightPeak;
}

class _DetailItem {
  const _DetailItem({
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;
}
