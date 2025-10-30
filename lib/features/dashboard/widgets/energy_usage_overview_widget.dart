import 'package:flutter/material.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class EnergyUsageOverviewWidget extends StatelessWidget {
  const EnergyUsageOverviewWidget({
    super.key,
    required this.consumption,
    this.isLoading = false,
    this.onRefresh,
  });

  final DailyConsumption consumption;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Energy Usage',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  'Yesterday\'s consumption vs 7-day average',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing20),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _buildUsageCard(
                      context,
                      label: 'Yesterday',
                      value: _getYesterdayUsage(),
                      isHighlighted: true,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing16),
                  Expanded(
                    child: _buildUsageCard(
                      context,
                      label: '7-Day Average',
                      value: _get7DayAverage(),
                      isHighlighted: false,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );

  Widget _buildUsageCard(
    BuildContext context, {
    required String label,
    required double value,
    required bool isHighlighted,
  }) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? const Color(0xFFE9D5FF).withOpacity(0.5) // Light purple
              : AppColors.grey100,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '${value.toStringAsFixed(1)} kWh',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: isHighlighted
                        ? const Color(0xFF8B5CF6) // Dark purple
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
          ],
        ),
      );

  double _getYesterdayUsage() {
    // Mock data from image: 33.4 kWh
    return 33.4;
  }

  double _get7DayAverage() {
    // Mock data from image: 32.1 kWh
    return 32.1;
  }
}
