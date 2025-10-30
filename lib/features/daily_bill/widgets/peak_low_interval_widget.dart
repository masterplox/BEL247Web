import 'package:flutter/material.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class PeakLowIntervalWidget extends StatelessWidget {
  const PeakLowIntervalWidget({
    super.key,
    required this.dailyConsumption,
  });

  final DailyConsumption dailyConsumption;

  @override
  Widget build(BuildContext context) {
    final peakUsages = dailyConsumption.peakUsages;
    final lowUsages = dailyConsumption.lowUsages;

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
            Row(
              children: [
                const Icon(Icons.schedule, color: AppColors.primary),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  'Peak & Low Usage Intervals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            Row(
              children: [
                Expanded(
                  child: _buildPeakIntervals(context, peakUsages),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: _buildLowIntervals(context, lowUsages),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            _buildUsagePatterns(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPeakIntervals(BuildContext context, List<PeakUsage> peakUsages) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.error, size: 20),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                'Peak Usage',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          if (peakUsages.isEmpty)
            Text(
              'No peak usage data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          else
            ...peakUsages.take(3).map((peak) => _buildPeakIntervalItem(context, peak)),
        ],
      ),
    );

  Widget _buildLowIntervals(BuildContext context, List<LowUsage> lowUsages) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_down, color: AppColors.success, size: 20),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                'Lowest Usage',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          if (lowUsages.isEmpty)
            Text(
              'No low usage data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          else
            ...lowUsages.take(3).map((low) => _buildLowIntervalItem(context, low)),
        ],
      ),
    );

  Widget _buildPeakIntervalItem(BuildContext context, PeakUsage peak) => Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${peak.hour.toString().padLeft(2, '0')}:00',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
              ),
              if (peak.reason != null)
                Text(
                  peak.reason!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${peak.kwh.toStringAsFixed(1)} kWh',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '\$${peak.cost.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );

  Widget _buildLowIntervalItem(BuildContext context, LowUsage low) => Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${low.hour.toString().padLeft(2, '0')}:00',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
              ),
              if (low.reason != null)
                Text(
                  low.reason!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${low.kwh.toStringAsFixed(1)} kWh',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '\$${low.cost.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );

  Widget _buildUsagePatterns(BuildContext context) {
    final peakHours = dailyConsumption.peakUsageHours;
    final lowHours = dailyConsumption.lowUsageHours;

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
            'Usage Patterns',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              Expanded(
                child: _buildPatternSection(
                  context,
                  'Peak Hours',
                  peakHours,
                  AppColors.error,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: _buildPatternSection(
                  context,
                  'Low Hours',
                  lowHours,
                  AppColors.success,
                  Icons.trending_down,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatternSection(
    BuildContext context,
    String title,
    List<int> hours,
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
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          hours.isEmpty
              ? 'No data'
              : hours.map((h) => '${h.toString().padLeft(2, '0')}:00').join(', '),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
}
