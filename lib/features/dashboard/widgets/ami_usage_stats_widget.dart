import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/formatting_utils.dart';
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
          value: FormattingUtils.formatKwhNumber(stats.currentPeriodKWh),
          unit: 'kWh',
          icon: Icons.bolt,
          color: AppColors.primary,
          detailTitle: 'Current Billing Period Usage',
          detailSubtitle: 'The billing period you are currently in',
          detailItems: [
            if (stats.currentStartDate != null && stats.currentEndDate != null)
              _DetailItem(
                label: 'Billing Period',
                value: _formatPeriodRange(
                  stats.currentStartDate,
                  stats.currentEndDate,
                ),
              )
            else if (stats.currentPeriodLabel.isNotEmpty)
              _DetailItem(
                label: 'Billing Period',
                value: stats.currentPeriodLabel,
              ),
            _DetailItem(
              label: 'Consumption',
              value: FormattingUtils.formatKwh(stats.currentPeriodKWh),
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
                value: FormattingUtils.formatKwh(stats.currentDailyAverageKWh),
              ),
            if (stats.daysInPeriod > 0)
              _DetailItem(
                label: 'Billing Days',
                value: '${stats.daysElapsed} of ${stats.daysInPeriod} days',
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
              ? '-${FormattingUtils.formatKwhNumber(variance.abs())}'
              : usedMore
                  ? '+${FormattingUtils.formatKwhNumber(variance.abs())}'
                  : '0',
          unit: 'kWh',
          icon: Icons.trending_up,
          color: varianceColor,
          detailTitle: 'Billing Period Comparison',
          detailSubtitle:
              'Compared over the same number of days so far, not against the full previous period',
          detailItems: const [],
          billedPeriods: stats.billedPeriods,
          comparisonVisual: _buildComparisonVisualData(stats),
        ),
      );
    }

    if (stats.hasPeakPeriod) {
      cards.add(
        _StatCardData(
          label: 'Peak Billing Period',
          subLabel:
              stats.peakPeriodLabel.isEmpty ? null : stats.peakPeriodLabel,
          value: FormattingUtils.formatKwhNumber(stats.peakBilledKWh),
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
              value: FormattingUtils.formatKwh(stats.peakBilledKWh),
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
          value: FormattingUtils.formatKwhNumber(stats.avgBilledKWh),
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
              value: FormattingUtils.formatKwh(stats.avgBilledKWh),
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
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (stat.comparisonVisual != null) ...[
            const SizedBox(height: AppTheme.spacing8),
            _buildComparisonVisual(context, stat.comparisonVisual!),
          ],
          if (stat.billedPeriods.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing8),
            const Divider(),
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
            FormattingUtils.formatKwh(period.billedKWh),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPeak ? AppColors.warning : null,
                ),
          ),
        ],
      ),
    );
  }

  String _formatPeriodRange(
    DateTime? start,
    DateTime? end, {
    String fallback = '',
  }) {
    if (start != null && end != null) {
      return '${_dateFormat.format(start)} - ${_dateFormat.format(end)}';
    }
    return fallback;
  }

  _ComparisonVisualData _buildComparisonVisualData(
    UsageDashboardCardsResult stats,
  ) {
    final previous = _previousBilledPeriod(stats);
    final daysCompared = stats.daysElapsed;
    final currentTotalDays = stats.daysInPeriod > 0
        ? stats.daysInPeriod
        : (stats.currentStartDate != null && stats.currentEndDate != null
            ? stats.currentEndDate!.difference(stats.currentStartDate!).inDays + 1
            : (daysCompared > 0 ? daysCompared : 1));
    final previousTotalDays = previous != null && previous.days > 0
        ? previous.days
        : (previous?.startDate != null && previous?.endDate != null
            ? previous!.endDate!.difference(previous.startDate!).inDays + 1
            : currentTotalDays);

    return _ComparisonVisualData(
      currentStart: stats.currentStartDate,
      currentEnd: stats.currentEndDate,
      currentKwh: stats.currentPeriodKWh,
      currentTotalDays: currentTotalDays,
      previousStart: previous?.startDate,
      previousEnd: previous?.endDate,
      previousKwh: stats.previousPeriodToDateKWh,
      previousTotalDays: previousTotalDays,
      daysCompared: daysCompared,
      varianceKwh: stats.varianceKWh,
      usedMore: stats.usedMoreThanPrevious,
      usedLess: stats.usedLessThanPrevious,
    );
  }

  BilledPeriodSummary? _previousBilledPeriod(UsageDashboardCardsResult stats) {
    for (final period in stats.billedPeriods) {
      final sameAsCurrent = stats.currentStartDate != null &&
          period.startDate != null &&
          DateUtils.isSameDay(period.startDate, stats.currentStartDate);
      if (sameAsCurrent) continue;
      return period;
    }
    return null;
  }

  Widget _buildComparisonVisual(
    BuildContext context,
    _ComparisonVisualData visual,
  ) {
    final differenceColor = visual.usedMore
        ? AppColors.error
        : visual.usedLess
            ? AppColors.success
            : AppColors.textSecondary;

    final differenceValue = visual.usedLess
        ? '-${FormattingUtils.formatKwh(visual.varianceKwh.abs())}'
        : visual.usedMore
            ? '+${FormattingUtils.formatKwh(visual.varianceKwh.abs())}'
            : FormattingUtils.formatKwh(0);

    final daysLabel = visual.daysCompared == 1 ? 'day' : 'days';
    String summary;
    if (visual.usedMore) {
      summary =
          'You used ${FormattingUtils.formatKwh(visual.varianceKwh.abs())} more than the same ${visual.daysCompared} $daysLabel in the previous period.';
    } else if (visual.usedLess) {
      summary =
          'You used ${FormattingUtils.formatKwh(visual.varianceKwh.abs())} less than the same ${visual.daysCompared} $daysLabel in the previous period.';
    } else {
      summary =
          'Usage matches the same ${visual.daysCompared} $daysLabel in the previous period.';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            border: Border.all(color: AppColors.border),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stats = <Widget>[
                _buildStatColumn(
                  context,
                  label: 'Days Compared',
                  value: '${visual.daysCompared} $daysLabel',
                ),
                _buildStatColumn(
                  context,
                  label: 'Current Period Usage',
                  value: FormattingUtils.formatKwh(visual.currentKwh),
                ),
                _buildStatColumn(
                  context,
                  label: 'Previous Period Usage',
                  value: FormattingUtils.formatKwh(visual.previousKwh),
                ),
                _buildStatColumn(
                  context,
                  label: 'Difference',
                  value: differenceValue,
                  valueColor: differenceColor,
                  valueIcon: visual.usedMore
                      ? Icons.arrow_upward
                      : visual.usedLess
                          ? Icons.arrow_downward
                          : null,
                ),
              ];
              if (constraints.maxWidth < 520) {
                return Wrap(
                  spacing: AppTheme.spacing12,
                  runSpacing: AppTheme.spacing12,
                  children: stats
                      .map(
                        (child) => SizedBox(
                          width: (constraints.maxWidth - AppTheme.spacing12) / 2,
                          child: child,
                        ),
                      )
                      .toList(),
                );
              }
              return Row(
                children: [
                  for (var i = 0; i < stats.length; i++) ...[
                    Expanded(child: stats[i]),
                    if (i < stats.length - 1) const SizedBox(width: AppTheme.spacing8),
                  ],
                ],
              );
            },
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildPeriodSubCard(
          context,
          title: 'Current Period',
          startDate: visual.currentStart,
          endDate: visual.currentEnd,
          daysCompared: visual.daysCompared,
          totalDays: visual.currentTotalDays,
          kwh: visual.currentKwh,
          fillColor: AppColors.success,
          markerLabel: 'Today',
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildPeriodSubCard(
          context,
          title: 'Previous Period (Same Number of Days)',
          startDate: visual.previousStart,
          endDate: visual.previousEnd,
          daysCompared: visual.daysCompared,
          totalDays: visual.previousTotalDays,
          kwh: visual.previousKwh,
          fillColor: AppColors.grey500,
          markerLabel: 'Day ${visual.daysCompared}',
        ),
        const SizedBox(height: AppTheme.spacing12),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            color: differenceColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            border: Border.all(color: differenceColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                visual.usedLess
                    ? Icons.check_circle_outline
                    : visual.usedMore
                        ? Icons.info_outline
                        : Icons.remove_circle_outline,
                color: differenceColor,
                size: 18,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Text(
                  summary,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: differenceColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    IconData? valueIcon,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (valueIcon != null) ...[
                Icon(valueIcon, size: 14, color: valueColor ?? AppColors.textPrimary),
                const SizedBox(width: 2),
              ],
              Flexible(
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: valueColor ?? AppColors.textPrimary,
                      ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildPeriodSubCard(
    BuildContext context, {
    required String title,
    required DateTime? startDate,
    required DateTime? endDate,
    required int daysCompared,
    required int totalDays,
    required double kwh,
    required Color fillColor,
    required String markerLabel,
  }) {
    final safeTotal = totalDays > 0 ? totalDays : 1;
    final rawFraction = daysCompared / safeTotal;
    final fillFraction = rawFraction.clamp(0.0, 1.0).toDouble();
    final barText =
        '$daysCompared ${daysCompared == 1 ? 'day' : 'days'} · ${FormattingUtils.formatKwh(kwh)}';
    final startLabel = startDate != null ? _dateFormat.format(startDate) : '';
    final endLabel = endDate != null ? _dateFormat.format(endDate) : '';

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              final markerLeft = (barWidth * fillFraction).clamp(0.0, barWidth);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 26,
                      width: barWidth,
                      child: Stack(
                        children: [
                          Container(color: AppColors.grey200),
                          FractionallySizedBox(
                            widthFactor: fillFraction,
                            child: Container(
                              color: fillColor,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
                              child: Text(
                                barText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: barWidth,
                    height: 14,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: (markerLeft - 24).clamp(0.0, (barWidth - 48).clamp(0.0, barWidth)),
                          top: 0,
                          child: Text(
                            markerLabel,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppTheme.spacing4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                endLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComparisonVisualData {
  const _ComparisonVisualData({
    required this.currentStart,
    required this.currentEnd,
    required this.currentKwh,
    required this.currentTotalDays,
    required this.previousStart,
    required this.previousEnd,
    required this.previousKwh,
    required this.previousTotalDays,
    required this.daysCompared,
    required this.varianceKwh,
    required this.usedMore,
    required this.usedLess,
  });

  final DateTime? currentStart;
  final DateTime? currentEnd;
  final double currentKwh;
  final int currentTotalDays;
  final DateTime? previousStart;
  final DateTime? previousEnd;
  final double previousKwh;
  final int previousTotalDays;
  final int daysCompared;
  final double varianceKwh;
  final bool usedMore;
  final bool usedLess;
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
    this.comparisonVisual,
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
  final _ComparisonVisualData? comparisonVisual;
}

class _DetailItem {
  const _DetailItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}
