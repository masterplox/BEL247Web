import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/meter_readings_providers.dart';

class MonthDetailCardsWidget extends ConsumerWidget {
  const MonthDetailCardsWidget({
    super.key,
    required this.selectedMonth,
    required this.onClose,
  });

  final String selectedMonth;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
    final lastYearAsync = ref.watch(meterReadingsLastYearProvider);
    final yearTwoAsync = ref.watch(meterReadingsYearTwoProvider);
    final isMobile = MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;

    return thisYearAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (thisYearReadings) => lastYearAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => _buildDetailCards(context, thisYearReadings, [], [], isMobile),
        data: (lastYearReadings) => yearTwoAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) =>
              _buildDetailCards(context, thisYearReadings, lastYearReadings, [], isMobile),
          data: (yearTwoReadings) =>
              _buildDetailCards(context, thisYearReadings, lastYearReadings, yearTwoReadings, isMobile),
        ),
      ),
    );
  }

  Widget _buildDetailCards(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
  List<MeterReadingDto> yearTwoReadings,
    bool isMobile,
  ) {
    // Find data for selected month
    final thisYearData = thisYearReadings.firstWhere(
      (r) => r.readMonth == selectedMonth,
      orElse: () => MeterReadingDto(
        readDate: '',
        readMonth: selectedMonth,
        readYear: '',
        days: '0',
        consumption: '0',
        averageUsage: '0',
        amount: '0',
      ),
    );

    final lastYearData = lastYearReadings.firstWhere(
      (r) => r.readMonth == selectedMonth,
      orElse: () => MeterReadingDto(
        readDate: '',
        readMonth: selectedMonth,
        readYear: '',
        days: '0',
        consumption: '0',
        averageUsage: '0',
        amount: '0',
      ),
    );

    final yearTwoData = yearTwoReadings.firstWhere(
      (r) => r.readMonth == selectedMonth,
      orElse: () => MeterReadingDto(
        readDate: '',
        readMonth: selectedMonth,
        readYear: '',
        days: '0',
        consumption: '0',
        averageUsage: '0',
        amount: '0',
      ),
    );

    // Calculate values for all three years
    final consumptionYearTwo = double.tryParse(yearTwoData.consumption) ?? 0.0;
    final consumptionLast = double.tryParse(lastYearData.consumption) ?? 0.0;
    final consumptionCurrent = double.tryParse(thisYearData.consumption) ?? 0.0;
    final costYearTwo = double.tryParse(yearTwoData.amount) ?? 0.0;
    final costLast = double.tryParse(lastYearData.amount) ?? 0.0;
    final costCurrent = double.tryParse(thisYearData.amount) ?? 0.0;
    final avgUsageYearTwo = double.tryParse(yearTwoData.averageUsage) ?? 0.0;
    final avgUsageLast = double.tryParse(lastYearData.averageUsage) ?? 0.0;
    final avgUsageCurrent = double.tryParse(thisYearData.averageUsage) ?? 0.0;

    // Differences focus on last year vs this year for "saved/more" messaging
    final consumptionDiff = consumptionLast - consumptionCurrent;
    final costDiff = costLast - costCurrent;
    final avgUsageDiff = avgUsageLast - avgUsageCurrent;

    final savedEnergy = consumptionDiff > 0;
    final savedCost = costDiff > 0;
    final savedAvg = avgUsageDiff > 0;

    final thisYearLabel = thisYearData.readYear.isNotEmpty
        ? thisYearData.readYear
        : DateTime.now().year.toString();
    final lastYearLabel = lastYearData.readYear.isNotEmpty
        ? lastYearData.readYear
        : (int.tryParse(thisYearLabel) ?? DateTime.now().year - 1).toString();
    final yearTwoLabel = yearTwoData.readYear.isNotEmpty
        ? yearTwoData.readYear
        : (int.tryParse(lastYearLabel) ?? DateTime.now().year - 2).toString();

    return AppCard(
      padding: EdgeInsets.all(isMobile ? AppTheme.spacing16 : AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$selectedMonth Breakdown',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Comparing $yearTwoLabel, $lastYearLabel and $thisYearLabel',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: onClose,
                tooltip: 'Close',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Stats Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                return Column(
                  children: [
                    _buildComparisonCard(
                      context,
                      title: 'Consumption',
                      icon: Icons.bolt,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: consumptionYearTwo,
                      valueLast: consumptionLast,
                      valueCurrent: consumptionCurrent,
                      diff: consumptionDiff,
                      saved: savedEnergy,
                      unit: 'kWh',
                      comparisonNote: savedEnergy
                          ? 'Compared to $lastYearLabel — you used less in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — you used more in $thisYearLabel (same month).',
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildComparisonCard(
                      context,
                      title: 'Cost',
                      icon: Icons.attach_money,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: costYearTwo,
                      valueLast: costLast,
                      valueCurrent: costCurrent,
                      diff: costDiff,
                      saved: savedCost,
                      unit: r'$',
                      isCurrency: true,
                      comparisonNote: savedCost
                          ? 'Compared to $lastYearLabel — you spent less in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — you spent more in $thisYearLabel (same month).',
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildComparisonCard(
                      context,
                      title: 'Daily Avg',
                      icon: Icons.access_time,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: avgUsageYearTwo,
                      valueLast: avgUsageLast,
                      valueCurrent: avgUsageCurrent,
                      diff: avgUsageDiff,
                      saved: savedAvg,
                      unit: 'kWh/day',
                      comparisonNote: savedAvg
                          ? 'Compared to $lastYearLabel — lower daily average in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — higher daily average in $thisYearLabel (same month).',
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Consumption',
                      icon: Icons.bolt,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: consumptionYearTwo,
                      valueLast: consumptionLast,
                      valueCurrent: consumptionCurrent,
                      diff: consumptionDiff,
                      saved: savedEnergy,
                      unit: 'kWh',
                      comparisonNote: savedEnergy
                          ? 'Compared to $lastYearLabel — you used less in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — you used more in $thisYearLabel (same month).',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Cost',
                      icon: Icons.attach_money,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: costYearTwo,
                      valueLast: costLast,
                      valueCurrent: costCurrent,
                      diff: costDiff,
                      saved: savedCost,
                      unit: r'$',
                      isCurrency: true,
                      comparisonNote: savedCost
                          ? 'Compared to $lastYearLabel — you spent less in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — you spent more in $thisYearLabel (same month).',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Daily Avg',
                      icon: Icons.access_time,
                      iconColor: AppColors.textSecondary,
                      yearTwoLabel: yearTwoLabel,
                      lastYearLabel: lastYearLabel,
                      thisYearLabel: thisYearLabel,
                      valueYearTwo: avgUsageYearTwo,
                      valueLast: avgUsageLast,
                      valueCurrent: avgUsageCurrent,
                      diff: avgUsageDiff,
                      saved: savedAvg,
                      unit: 'kWh/day',
                      comparisonNote: savedAvg
                          ? 'Compared to $lastYearLabel — lower daily average in $thisYearLabel (same month).'
                          : 'Compared to $lastYearLabel — higher daily average in $thisYearLabel (same month).',
                    ),
                  ),
                ],
              );
            },
          ),

          // Reading Details
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 400;
                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        'Billing Days',
                        '$yearTwoLabel: ${int.tryParse(yearTwoData.days) ?? 0} / '
                        '$lastYearLabel: ${int.tryParse(lastYearData.days) ?? 0} / '
                        '$thisYearLabel: ${int.tryParse(thisYearData.days) ?? 0}',
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      _buildDetailRow(
                        context,
                        'Meter Reading Period',
                        '$selectedMonth ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}',
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow(
                        context,
                        'Billing Days',
                        '$yearTwoLabel: ${int.tryParse(yearTwoData.days) ?? 0} / '
                        '$lastYearLabel: ${int.tryParse(lastYearData.days) ?? 0} / '
                        '$thisYearLabel: ${int.tryParse(thisYearData.days) ?? 0}',
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing16),
                    Expanded(
                      child: _buildDetailRow(
                        context,
                        'Meter Reading Period',
                        '$selectedMonth ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
    BuildContext context, {
      required String title,
      required IconData icon,
      required Color iconColor,
      required String yearTwoLabel,
      required String lastYearLabel,
      required String thisYearLabel,
      required double valueYearTwo,
      required double valueLast,
      required double valueCurrent,
      required double diff,
      required bool saved,
      required String unit,
      required String comparisonNote,
      bool isCurrency = false,
  }) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          // Year -2 value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                yearTwoLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                valueYearTwo > 0
                    ? (isCurrency
                        ? FormattingUtils.formatCurrency(valueYearTwo)
                        : '${valueYearTwo.toStringAsFixed(0)} $unit')
                    : '—',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          // Last year value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                lastYearLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                valueLast > 0
                    ? (isCurrency
                        ? FormattingUtils.formatCurrency(valueLast)
                        : '${valueLast.toStringAsFixed(0)} $unit')
                    : '—',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          // This year value (highlighted)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                thisYearLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                valueCurrent > 0
                    ? (isCurrency
                        ? FormattingUtils.formatCurrency(valueCurrent)
                        : '${valueCurrent.toStringAsFixed(0)} $unit')
                    : '—',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          // Difference
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      saved ? Icons.trending_down : Icons.trending_up,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Text(
                      '${saved ? '-' : '+'}${diff.abs().toStringAsFixed(0)}${isCurrency ? '' : ' $unit'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  comparisonNote,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  Widget _buildDetailRow(BuildContext context, String label, String value) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
        ),
      ],
    );
}
