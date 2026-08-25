import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class DailyBillWidget extends ConsumerWidget {
  const DailyBillWidget({
    super.key,
    required this.dailyConsumption,
    this.isLoading = false,
  });

  final DailyConsumption? dailyConsumption;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return const _DailyBillLoadingWidget();
    }

    if (dailyConsumption == null) {
      return const _DailyBillEmptyWidget();
    }

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
            _buildHeader(context),
            const SizedBox(height: AppTheme.spacing16),
            _buildHeroPanel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Row(
    children: [
      const Icon(Icons.receipt_long, color: AppColors.primary),
      const SizedBox(width: AppTheme.spacing8),
      Text(
        'Daily Bill Breakdown',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      Text(
        _formatDate(dailyConsumption!.date),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
      ),
    ],
  );

  Widget _buildHeroPanel(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppTheme.spacing20),
    decoration: BoxDecoration(
      color: AppColors.primaryLight.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(AppTheme.radius12),
      border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Usage',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    dailyConsumption!.totalKwh.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing4),
                  Text(
                    'kWh',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing12),
              // Dollar amounts are hidden in this version. They will be shown in a future release.
              // Text(
              //   'Estimated Cost',
              //   style: Theme.of(
              //     context,
              //   ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              // ),
              // Text(
              //   'BZ\$${dailyConsumption!.cost.toStringAsFixed(2)}',
              //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              //     color: AppColors.textPrimary,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
            ],
          ),
        ),
        const Icon(Icons.flash_on, color: AppColors.textTertiary),
      ],
    ),
  );

  /* Legacy sections kept for reference; now rendered at page-level as separate cards
  Widget _buildPeakLowSection(BuildContext context) {
    final peakUsage = dailyConsumption!.peakUsages.isNotEmpty
        ? dailyConsumption!.peakUsages.first
        : null;
    final lowUsage = dailyConsumption!.lowUsages.isNotEmpty
        ? dailyConsumption!.lowUsages.first
        : null;

    return Row(
      children: [
        Expanded(
          child: _buildPeakInterval(context, peakUsage),
        ),
        const SizedBox(width: AppTheme.spacing8),
        Expanded(
          child: _buildLowInterval(context, lowUsage),
        ),
      ],
    );
  }

  Widget _buildPeakInterval(BuildContext context, PeakUsage? peakUsage) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.error, size: 16),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                'Peak Usage',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            peakUsage != null
                ? '${peakUsage.hour.toString().padLeft(2, '0')}:00'
                : 'N/A',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
          ),
          Text(
            peakUsage != null
                ? '${peakUsage.kwh.toStringAsFixed(1)} kWh'
                : '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );

  Widget _buildLowInterval(BuildContext context, LowUsage? lowUsage) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_down, color: AppColors.success, size: 16),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                'Lowest Usage',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            lowUsage != null
                ? '${lowUsage.hour.toString().padLeft(2, '0')}:00'
                : 'N/A',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
          ),
          Text(
            lowUsage != null
                ? '${lowUsage.kwh.toStringAsFixed(1)} kWh'
                : '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );

  Widget _buildComparisonSection(BuildContext context) {
    final pattern = dailyConsumption!.pattern;

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
            'Usage Comparison',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          if (pattern.previousDayUsage != null) ...[
            _buildComparisonRow(
              context,
              'vs Yesterday',
              dailyConsumption!.totalKwh,
              pattern.previousDayUsage!,
            ),
            const SizedBox(height: AppTheme.spacing4),
          ],
          if (pattern.previousWeekAverage != null) ...[
            _buildComparisonRow(
              context,
              'vs 7-day Average',
              dailyConsumption!.totalKwh,
              pattern.previousWeekAverage!,
            ),
            const SizedBox(height: AppTheme.spacing4),
          ],
          if (pattern.previousMonthAverage != null) ...[
            _buildComparisonRow(
              context,
              'vs 30-day Average',
              dailyConsumption!.totalKwh,
              pattern.previousMonthAverage!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    BuildContext context,
    String label,
    double current,
    double previous,
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
          ],
        ),
      ],
    );
  }

  Widget _buildCostBreakdownSection(BuildContext context) {
    final costCalculation = CostCalculationService.calculateDailyCost(dailyConsumption!);
    final breakdown = costCalculation.costBreakdown;

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
            'Cost Calculation',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          _buildCostBreakdownRow(context, 'Energy Charge', breakdown.energyCharge, r'$'),
          const SizedBox(height: AppTheme.spacing4),
          _buildCostBreakdownRow(context, 'Peak Hours', breakdown.peakHourCost, r'$'),
          const SizedBox(height: AppTheme.spacing4),
          _buildCostBreakdownRow(context, 'Off-Peak Hours', breakdown.offPeakHourCost, r'$'),
          const SizedBox(height: AppTheme.spacing4),
          _buildCostBreakdownRow(context, 'Standard Hours', breakdown.standardHourCost, r'$'),
          const SizedBox(height: AppTheme.spacing4),
          _buildCostBreakdownRow(context, 'Service Fee', breakdown.serviceFee, r'$'),
          const Divider(),
          _buildCostBreakdownRow(
            context,
            'Total Cost',
            breakdown.totalCost,
            r'$',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownRow(
    BuildContext context,
    String label,
    double value,
    String unit, {
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
          '${value.toStringAsFixed(2)}$unit',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                color: isTotal ? AppColors.primary : AppColors.textPrimary,
              ),
        ),
      ],
    );

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
  */
  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}

class _DailyBillLoadingWidget extends StatelessWidget {
  const _DailyBillLoadingWidget();

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius12),
    ),
    child: const Padding(
      padding: EdgeInsets.all(AppTheme.spacing16),
      child: Center(child: CircularProgressIndicator()),
    ),
  );
}

class _DailyBillEmptyWidget extends StatelessWidget {
  const _DailyBillEmptyWidget();

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        children: [
          const Icon(
            Icons.receipt_long,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'No Daily Bill Data',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            'Daily consumption data is not available',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
          ),
        ],
      ),
    ),
  );
}
