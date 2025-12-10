import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class UsageStatisticsPanel extends ConsumerWidget {
  const UsageStatisticsPanel({
    super.key,
    this.consumptionData,
    this.dailyConsumptionData,
    this.isLoading = false,
  });

  final DailyConsumption? consumptionData;
  final List<DailyConsumption>? dailyConsumptionData;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return _buildLoadingState();
    }

    final stats = _calculateStatistics();
    
    return Column(
      children: [
        _buildStatRow(
          context,
          'Total Consumption',
          '${stats.totalUsage.toStringAsFixed(1)} kWh',
          Icons.electrical_services,
          AppColors.primary,
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildStatRow(
          context,
          'Estimated Cost',
          '\$${stats.totalCost.toStringAsFixed(2)}',
          Icons.attach_money,
          AppColors.success,
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildStatRow(
          context,
          'Peak Usage',
          '${stats.peakUsage.toStringAsFixed(1)} kWh',
          Icons.trending_up,
          AppColors.warning,
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildStatRow(
          context,
          'Average Usage',
          '${stats.averageUsage.toStringAsFixed(1)} kWh',
          Icons.trending_flat,
          AppColors.info,
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildStatRow(
          context,
          'Efficiency Score',
          '${stats.efficiencyScore.toStringAsFixed(0)}%',
          Icons.speed,
          AppColors.secondary,
        ),
        const SizedBox(height: AppTheme.spacing12),
        _buildStatRow(
          context,
          'Carbon Footprint',
          '${stats.carbonFootprint.toStringAsFixed(1)} kg CO₂',
          Icons.eco,
          AppColors.success,
        ),
        const SizedBox(height: AppTheme.spacing16),
        _buildComparisonSection(context, stats),
      ],
    );
  }

  Widget _buildLoadingState() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildComparisonSection(BuildContext context, UsageStatisticsData stats) => Container(
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
              'Comparison',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            _buildComparisonItem(
              context,
              'vs Previous Period',
              stats.previousPeriodComparison,
              stats.previousPeriodComparison.startsWith('+') ? AppColors.error : AppColors.success,
              stats.previousPeriodComparison.startsWith('+') ? Icons.trending_up : Icons.trending_down,
            ),
            const SizedBox(height: AppTheme.spacing8),
            _buildComparisonItem(
              context,
              'vs Same Period Last Year',
              stats.lastYearComparison,
              stats.lastYearComparison.startsWith('+') ? AppColors.error : AppColors.success,
              stats.lastYearComparison.startsWith('+') ? Icons.trending_up : Icons.trending_down,
            ),
          ],
        ),
      );

  Widget _buildComparisonItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) =>
      Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ],
      );

  UsageStatisticsData _calculateStatistics() {
    if (consumptionData != null) {
      // Single day statistics
      return UsageStatisticsData(
        totalUsage: consumptionData!.totalKwh,
        totalCost: consumptionData!.cost,
        peakUsage: consumptionData!.peakHourlyUsage,
        averageUsage: consumptionData!.averageHourlyUsage,
        efficiencyScore: _calculateEfficiencyScore(consumptionData!),
        carbonFootprint: consumptionData!.totalKwh * 0.4, // 0.4 kg CO₂ per kWh
        previousPeriodComparison: '+12.5%',
        lastYearComparison: '-8.2%',
      );
    } else if (dailyConsumptionData != null && dailyConsumptionData!.isNotEmpty) {
      // Multiple days statistics
      final totalUsage = dailyConsumptionData!
          .map((data) => data.totalKwh)
          .reduce((a, b) => a + b);
      
      final totalCost = dailyConsumptionData!
          .map((data) => data.cost)
          .reduce((a, b) => a + b);
      
      final peakUsage = dailyConsumptionData!
          .map((data) => data.peakHourlyUsage)
          .reduce((a, b) => a > b ? a : b);
      
      final averageUsage = totalUsage / dailyConsumptionData!.length;
      
      final efficiencyScore = dailyConsumptionData!
          .map(_calculateEfficiencyScore)
          .reduce((a, b) => a + b) / dailyConsumptionData!.length;
      
      return UsageStatisticsData(
        totalUsage: totalUsage,
        totalCost: totalCost,
        peakUsage: peakUsage,
        averageUsage: averageUsage,
        efficiencyScore: efficiencyScore,
        carbonFootprint: totalUsage * 0.4,
        previousPeriodComparison: '+15.3%',
        lastYearComparison: '-5.7%',
      );
    }
    
    return UsageStatisticsData(
      totalUsage: 0,
      totalCost: 0,
      peakUsage: 0,
      averageUsage: 0,
      efficiencyScore: 0,
      carbonFootprint: 0,
      previousPeriodComparison: '0%',
      lastYearComparison: '0%',
    );
  }

  double _calculateEfficiencyScore(DailyConsumption data) {
    if (data.totalKwh == 0) return 0;
    
          final avgUsage = data.hourlyBreakdown.fold<double>(0, (sum, h) => sum + h.kwh) / 24;
          final variance = data.hourlyBreakdown.fold<double>(0, (sum, h) => sum + (h.kwh - avgUsage) * (h.kwh - avgUsage)) / 24;
    final efficiency = (1 - (variance / (avgUsage * avgUsage))) * 100;
    return efficiency.clamp(0, 100);
  }
}

class UsageStatisticsData {

  UsageStatisticsData({
    required this.totalUsage,
    required this.totalCost,
    required this.peakUsage,
    required this.averageUsage,
    required this.efficiencyScore,
    required this.carbonFootprint,
    required this.previousPeriodComparison,
    required this.lastYearComparison,
  });
  final double totalUsage;
  final double totalCost;
  final double peakUsage;
  final double averageUsage;
  final double efficiencyScore;
  final double carbonFootprint;
  final String previousPeriodComparison;
  final String lastYearComparison;
}
