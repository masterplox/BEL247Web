import 'package:flutter/material.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class YearlyStats {
  YearlyStats({
    required this.currentYear,
    required this.lastYear,
    required this.totalLastYearConsumption,
    required this.totalLastYearCost,
    required this.totalCurrentYearConsumption,
    required this.totalCurrentYearCost,
    required this.consumptionSaved,
    required this.costSaved,
    this.peakMonthCurrentYearConsumption,
    this.peakMonthCurrentYear,
    required this.hasLastYearData,
    this.monthsWithDataThisYear = 0,
  });

  final int currentYear;
  final int lastYear;
  final double totalLastYearConsumption;
  final double totalLastYearCost;
  final double totalCurrentYearConsumption;
  final double totalCurrentYearCost;
  final double consumptionSaved;
  final double costSaved;
  final double? peakMonthCurrentYearConsumption;
  final String? peakMonthCurrentYear;
  /// True when there is at least one reading from the previous year to compare against.
  final bool hasLastYearData;
  /// Number of months with data in the current year. Used to hide year-over-year comparison for new accounts (e.g. first month only).
  final int monthsWithDataThisYear;
}

class UsageSummaryCards extends StatelessWidget {
  const UsageSummaryCards({
    super.key,
    required this.yearlyStats,
  });

  final YearlyStats yearlyStats;

  @override
  Widget build(BuildContext context) {
    final consumptionPercentChange = yearlyStats.totalLastYearConsumption > 0
        ? ((yearlyStats.consumptionSaved / yearlyStats.totalLastYearConsumption) * 100)
        : 0.0;
    final costPercentChange = yearlyStats.totalLastYearCost > 0
        ? ((yearlyStats.costSaved / yearlyStats.totalLastYearCost) * 100)
        : 0.0;

    final savedEnergy = yearlyStats.consumptionSaved > 0;
    final savedCost = yearlyStats.costSaved > 0;

    // Use LayoutBuilder to get responsive constraints
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppTheme.tabletBreakpoint;
        final isTablet = screenWidth >= AppTheme.tabletBreakpoint && screenWidth < AppTheme.desktopBreakpoint;

        // Build all cards
        final cards = [
          _buildCard(
            context,
            label: '${yearlyStats.currentYear} Total',
            value: yearlyStats.totalCurrentYearConsumption.toStringAsFixed(0),
            unit: 'kWh used',
            icon: Icons.bolt,
            iconColor: AppColors.primary,
            bgColor: AppColors.primary.withValues(alpha: 0.1),
            valueColor: AppColors.primary,
          ),
          if (yearlyStats.peakMonthCurrentYearConsumption != null && yearlyStats.peakMonthCurrentYear != null)
            _buildPeakMonthCard(
              context,
              yearlyStats.peakMonthCurrentYearConsumption!,
              yearlyStats.peakMonthCurrentYear!,
            ),
          // _buildCard(
          //   context,
          //   label: '${yearlyStats.currentYear} Cost',
          //   value: FormattingUtils.formatCurrency(yearlyStats.totalCurrentYearCost),
          //   unit: 'total spent',
          //   icon: Icons.attach_money,
          //   iconColor: AppColors.info,
          //   bgColor: AppColors.info.withValues(alpha: 0.1),
          // ),
          // Only show year-over-year comparison when we have enough data (avoid misleading "0%" for new accounts).
          if (yearlyStats.hasLastYearData &&
              yearlyStats.totalLastYearConsumption > 0 &&
              yearlyStats.monthsWithDataThisYear >= 2)
            _buildEnergyDiffCard(
              context,
              savedEnergy,
              yearlyStats.consumptionSaved,
              consumptionPercentChange,
              yearlyStats.lastYear,
            ),

          // _buildCostDiffCard(context, savedCost, yearlyStats.costSaved, costPercentChange, yearlyStats.lastYear),
        ];

        if (isMobile) {
          // Mobile: single column layout (one per row)
          return Column(
            children: cards
                .map((card) => Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                      child: card,
                    ))
                .toList(),
          );
        }

        // Tablet or Desktop: Use Wrap widget for flexible grid that allows natural height
        // Calculate available width for cards (accounting for spacing)
        final availableWidth = constraints.maxWidth;
        const crossAxisSpacing = AppTheme.spacing12;
        
        // Determine number of cards and adjust columns accordingly
        final cardCount = cards.length;
        // Tablet: 2 columns, Desktop: 3 columns (if we have 3 cards) or 2 columns (if we have 2 cards)
        final crossAxisCount = isTablet ? 2 : (cardCount >= 3 ? 3 : 2);
        final cardWidth = (availableWidth - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: crossAxisSpacing,
          runSpacing: AppTheme.spacing12,
          children: cards.map((card) => SizedBox(
            width: cardWidth,
            child: card,
          )).toList(),
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    Color? valueColor,
  }) => AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      showBorder: true,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: valueColor ?? AppColors.textPrimary,
                          ),
                    ),
                    Text(
                      unit,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
        ],
      ),
    );

  Widget _buildEnergyDiffCard(
    BuildContext context,
    bool savedEnergy,
    double consumptionSaved,
    double percentChange,
    int lastYear,
  ) {
    // Use neutral styling when change is zero or negligible (e.g. 0% or first-month edge cases).
    const minPercentForColor = 1.0;
    final hasMeaningfulChange = percentChange.abs() >= minPercentForColor && consumptionSaved.abs() >= 1;
    final valueColor = hasMeaningfulChange
        ? (savedEnergy ? AppColors.success : AppColors.error)
        : AppColors.textSecondary;
    final percentColor = hasMeaningfulChange
        ? (savedEnergy ? AppColors.success : AppColors.error)
        : AppColors.textSecondary;

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      showBorder: true,
      borderWidth: 1,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Energy Diff',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      '${savedEnergy ? '-' : '+'}${consumptionSaved.abs().toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: valueColor,
                          ),
                    ),
                    Text(
                      '${savedEnergy ? 'saved kWh' : 'more kWh'} vs $lastYear',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: valueColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(
                  savedEnergy ? Icons.trending_down : Icons.trending_up,
                  size: 16,
                  color: valueColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing8),
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
                Text(
                  '${savedEnergy ? '-' : '+'}${percentChange.abs().toStringAsFixed(1)}% kWh',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: percentColor,
                      ),
                ),
                if (savedEnergy && hasMeaningfulChange) ...[
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'Excellent work! Your energy choices helped to conserve energy, keep it up!',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
                if (!savedEnergy && hasMeaningfulChange) ...[
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'This reflects increased home activity this year, was this expected?',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeakMonthCard(
    BuildContext context,
    double peakConsumption,
    String peakMonth,
  ) => AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      showBorder: true,
      borderWidth: 1,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Peak Month',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      peakConsumption.toStringAsFixed(0),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.warning,
                          ),
                    ),
                    Text(
                      'kWh in $peakMonth',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: const Icon(
                  Icons.show_chart,
                  size: 16,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );

  Widget _buildCostDiffCard(
    BuildContext context,
    bool savedCost,
    double costSaved,
    double percentChange,
    int lastYear,
  ) => AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      showBorder: true,
      borderWidth: 1,
      color: savedCost
          ? AppColors.primary.withValues(alpha: 0.05)
          : AppColors.error.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost Diff',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      FormattingUtils.formatCurrency(costSaved.abs()),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: savedCost ? AppColors.primary : AppColors.error,
                          ),
                    ),
                    Text(
                      '${savedCost ? 'saved' : 'more'} vs ${yearlyStats.lastYear}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: savedCost
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(
                  savedCost ? Icons.trending_down : Icons.trending_up,
                  size: 16,
                  color: savedCost ? AppColors.primary : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '${savedCost ? '-' : '+'}${percentChange.abs().toStringAsFixed(1)}% cost',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: savedCost ? AppColors.primary : AppColors.error,
                  ),
            ),
          ),
        ],
      ),
    );
}
