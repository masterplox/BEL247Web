import 'package:flutter/material.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../services/cost_calculation_service.dart';

class AverageComparisonWidget extends StatelessWidget {
  const AverageComparisonWidget({
    super.key,
    required this.currentConsumption,
    this.previousConsumption,
    this.showCostComparison = true,
  });

  final DailyConsumption currentConsumption;
  final DailyConsumption? previousConsumption;
  final bool showCostComparison;

  @override
  Widget build(BuildContext context) => Card(
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
                const Icon(Icons.compare_arrows, color: AppColors.primary),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  'Usage Comparison',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildComparisonSection(context),
            if (showCostComparison) ...[
              const SizedBox(height: AppTheme.spacing16),
              _buildCostComparisonSection(context),
            ],
            const SizedBox(height: AppTheme.spacing16),
            _buildTrendAnalysis(context),
          ],
        ),
      ),
    );

  Widget _buildComparisonSection(BuildContext context) {
    final pattern = currentConsumption.pattern;
    final trend = currentConsumption.usageTrend;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consumption Comparison',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          if (pattern.previousDayUsage != null)
            _buildComparisonRow(
              context,
              'vs Yesterday',
              currentConsumption.totalKwh,
              pattern.previousDayUsage!,
              'kWh',
            ),
          if (pattern.previousWeekAverage != null) ...[
            const SizedBox(height: AppTheme.spacing4),
            _buildComparisonRow(
              context,
              'vs 7-day Average',
              currentConsumption.totalKwh,
              pattern.previousWeekAverage!,
              'kWh',
            ),
          ],
          if (pattern.previousMonthAverage != null) ...[
            const SizedBox(height: AppTheme.spacing4),
            _buildComparisonRow(
              context,
              'vs 30-day Average',
              currentConsumption.totalKwh,
              pattern.previousMonthAverage!,
              'kWh',
            ),
          ],
          const SizedBox(height: AppTheme.spacing8),
          _buildTrendIndicator(context, trend),
        ],
      ),
    );
  }

  Widget _buildCostComparisonSection(BuildContext context) {
    if (previousConsumption == null) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cost Comparison',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'No previous consumption data available for cost comparison',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    final costSavings = CostCalculationService.calculateCostSavings(
      currentConsumption,
      previousConsumption,
    );

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: costSavings.isSavings
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: costSavings.isSavings
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                costSavings.isSavings ? Icons.savings : Icons.trending_up,
                color: costSavings.isSavings ? AppColors.success : AppColors.error,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                'Cost Comparison',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            costSavings.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: costSavings.isSavings ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis(BuildContext context) {
    final efficiency = currentConsumption.efficiencyScore;
    final isAboveAverage = currentConsumption.isAboveAverage;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Efficiency Analysis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              Expanded(
                child: _buildEfficiencyMetric(
                  context,
                  'Efficiency Score',
                  '${efficiency.toStringAsFixed(1)}%',
                  _getEfficiencyColor(efficiency),
                  Icons.speed,
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: _buildEfficiencyMetric(
                  context,
                  'Usage Level',
                  isAboveAverage ? 'Above Average' : 'Below Average',
                  isAboveAverage ? AppColors.error : AppColors.success,
                  isAboveAverage ? Icons.trending_up : Icons.trending_down,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    BuildContext context,
    String label,
    double current,
    double previous,
    String unit,
  ) {
    final difference = current - previous;
    final percentage = previous != 0 ? (difference / previous) * 100 : 0;
    final isIncrease = difference > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          children: [
            Icon(
              isIncrease ? Icons.trending_up : Icons.trending_down,
              color: isIncrease ? AppColors.error : AppColors.success,
              size: 16,
            ),
            const SizedBox(width: AppTheme.spacing4),
            Text(
              '${percentage.abs().toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isIncrease ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: AppTheme.spacing4),
            Text(
              '(${difference.abs().toStringAsFixed(1)}$unit)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendIndicator(BuildContext context, UsageTrend trend) {
    Color color;
    IconData icon;
    String description;

    switch (trend) {
      case UsageTrend.increasing:
        color = AppColors.error;
        icon = Icons.trending_up;
        description = 'Usage is increasing';
        break;
      case UsageTrend.decreasing:
        color = AppColors.success;
        icon = Icons.trending_down;
        description = 'Usage is decreasing';
        break;
      case UsageTrend.stable:
        color = AppColors.textSecondary;
        icon = Icons.trending_flat;
        description = 'Usage is stable';
        break;
      case UsageTrend.unknown:
        color = AppColors.textTertiary;
        icon = Icons.help_outline;
        description = 'Trend unknown';
        break;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: AppTheme.spacing4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildEfficiencyMetric(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: AppTheme.spacing4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency >= 80) return AppColors.success;
    if (efficiency >= 60) return AppColors.warning;
    return AppColors.error;
  }
}
