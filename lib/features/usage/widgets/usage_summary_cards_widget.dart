import 'package:flutter/material.dart';

// Dollar amounts are hidden in this version. They will be shown in a future release.
// import '../../../core/utils/formatting_utils.dart';
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
    final avgUsage = yearlyStats.monthsWithDataThisYear > 0
        ? yearlyStats.totalCurrentYearConsumption / yearlyStats.monthsWithDataThisYear
        : yearlyStats.totalCurrentYearConsumption;

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
            label: 'Total Usage',
            value: yearlyStats.totalCurrentYearConsumption.toStringAsFixed(0),
            unit: 'kWh used',
            icon: Icons.bolt,
            iconColor: AppColors.primary,
            bgColor: AppColors.primary.withValues(alpha: 0.1),
            valueColor: AppColors.primary,
            subLabel:
                '${yearlyStats.currentYear} billing periods with data: ${yearlyStats.monthsWithDataThisYear}',
          ),
          if (yearlyStats.peakMonthCurrentYearConsumption != null && yearlyStats.peakMonthCurrentYear != null)
            _buildPeakMonthCard(
              context,
              yearlyStats.peakMonthCurrentYearConsumption!,
              yearlyStats.peakMonthCurrentYear!,
            ),
          _buildCard(
            context,
            label: 'Avg. Usage',
            value: avgUsage.toStringAsFixed(1),
            unit: 'kWh',
            icon: Icons.show_chart,
            iconColor: const Color(0xFF8B5CF6),
            bgColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
            valueColor: const Color(0xFF8B5CF6),
            subLabel: yearlyStats.monthsWithDataThisYear > 0 ? 'per billing period' : null,
          ),
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
    String? subLabel,
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
                    if (subLabel != null) ...[
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        subLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                      ),
                    ],
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

  // Kept for possible future re-enable of year-over-year comparison card.
  // ignore: unused_element
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
                      'Peak Usage',
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
                      'kWh ($peakMonth)',
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

  // Kept for possible future re-enable of cost comparison card.
  // ignore: unused_element
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
                      // Dollar amounts are hidden in this version. They will be shown in a future release.
                      // FormattingUtils.formatCurrency(costSaved.abs()),
                      '',
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
