import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class ConsumptionComparisonChartWidget extends StatelessWidget {
  const ConsumptionComparisonChartWidget({
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
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppTheme.spacing16),
              if (isLoading)
                _buildLoadingState(context)
              else
                _buildChart(context),
              const SizedBox(height: AppTheme.spacing16),
              _buildLegend(context),
            ],
          ),
        ),
      );

  Widget _buildHeader(BuildContext context) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: const Icon(
              Icons.bar_chart,
              color: AppColors.info,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usage Comparison Chart',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Yesterday vs 7-day average',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          if (onRefresh != null)
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(
                Icons.refresh,
                color: AppColors.textTertiary,
              ),
            ),
        ],
      );

  Widget _buildLoadingState(BuildContext context) => Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildChart(BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.all(AppTheme.spacing8),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) => const FlLine(
                  color: AppColors.border,
                  strokeWidth: 1,
                ),
              getDrawingVerticalLine: (value) => const FlLine(
                  color: AppColors.border,
                  strokeWidth: 1,
                ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    Widget text;
                    switch (value.toInt()) {
                      case 0:
                        text = const Text('6AM', style: style);
                        break;
                      case 6:
                        text = const Text('12PM', style: style);
                        break;
                      case 12:
                        text = const Text('6PM', style: style);
                        break;
                      case 18:
                        text = const Text('12AM', style: style);
                        break;
                      default:
                        text = const Text('', style: style);
                        break;
                    }
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: text,
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    return Text('${value.toInt()}kWh', style: style);
                  },
                  reservedSize: 42,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: AppColors.border),
            ),
            minX: 0,
            maxX: 23,
            minY: 0,
            maxY: 4,
            lineBarsData: [
              // Yesterday's consumption line
              LineChartBarData(
                spots: _getYesterdaySpots(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withOpacity(0.3)],
                ),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.3),
                      AppColors.primary.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // 7-day average line
              LineChartBarData(
                spots: _getAverageSpots(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.3)],
                ),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondary.withOpacity(0.3),
                      AppColors.secondary.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildLegend(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(
            context,
            'Yesterday',
            AppColors.primary,
          ),
          const SizedBox(width: AppTheme.spacing24),
          _buildLegendItem(
            context,
            '7-day Average',
            AppColors.secondary,
          ),
        ],
      );

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    Color color,
  ) =>
      Row(
        children: [
          Container(
            width: 16,
            height: 3,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppTheme.radius4),
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      );

  List<FlSpot> _getYesterdaySpots() {
    // Generate mock data for yesterday's consumption
    return List.generate(24, (index) {
      // Simulate realistic hourly consumption pattern
      double baseUsage = 1;
      if (index >= 6 && index <= 8) {
        // Morning peak
        baseUsage = 2.0 + (index - 6) * 0.5;
      } else if (index >= 18 && index <= 22) {
        // Evening peak
        baseUsage = 2.5 - (index - 18) * 0.3;
      } else if (index >= 0 && index <= 5) {
        // Night low usage
        baseUsage = 0.5;
      } else if (index >= 9 && index <= 17) {
        // Daytime moderate usage
        baseUsage = 1.2;
      }
      
      // Add some variation
      final variation = (index % 3 - 1) * 0.2;
      return FlSpot(index.toDouble(), (baseUsage + variation).clamp(0.1, 3.0));
    });
  }

  List<FlSpot> _getAverageSpots() {
    // Generate mock data for 7-day average consumption
    return List.generate(24, (index) {
      // Similar pattern but slightly lower overall
      double baseUsage = 0.9;
      if (index >= 6 && index <= 8) {
        baseUsage = 1.8 + (index - 6) * 0.4;
      } else if (index >= 18 && index <= 22) {
        baseUsage = 2.2 - (index - 18) * 0.25;
      } else if (index >= 0 && index <= 5) {
        baseUsage = 0.4;
      } else if (index >= 9 && index <= 17) {
        baseUsage = 1.1;
      }
      
      // Add some variation
      final variation = (index % 4 - 2) * 0.15;
      return FlSpot(index.toDouble(), (baseUsage + variation).clamp(0.1, 2.8));
    });
  }
}

// Compact version for smaller spaces
class CompactConsumptionComparisonChartWidget extends StatelessWidget {
  const CompactConsumptionComparisonChartWidget({
    super.key,
    required this.consumption,
    this.isLoading = false,
  });

  final DailyConsumption consumption;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.bar_chart,
                    color: AppColors.info,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Usage Chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing12),
              if (isLoading)
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(AppTheme.spacing4),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 23,
                      minY: 0,
                      maxY: 3,
                      lineBarsData: [
                        LineChartBarData(
                          spots: _getYesterdaySpots(),
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                        ),
                        LineChartBarData(
                          spots: _getAverageSpots(),
                          isCurved: true,
                          color: AppColors.secondary,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  List<FlSpot> _getYesterdaySpots() => List.generate(24, (index) {
      double baseUsage = 1;
      if (index >= 6 && index <= 8) {
        baseUsage = 2.0 + (index - 6) * 0.5;
      } else if (index >= 18 && index <= 22) {
        baseUsage = 2.5 - (index - 18) * 0.3;
      } else if (index >= 0 && index <= 5) {
        baseUsage = 0.5;
      } else if (index >= 9 && index <= 17) {
        baseUsage = 1.2;
      }
      
      final variation = (index % 3 - 1) * 0.2;
      return FlSpot(index.toDouble(), (baseUsage + variation).clamp(0.1, 3.0));
    });

  List<FlSpot> _getAverageSpots() => List.generate(24, (index) {
      double baseUsage = 0.9;
      if (index >= 6 && index <= 8) {
        baseUsage = 1.8 + (index - 6) * 0.4;
      } else if (index >= 18 && index <= 22) {
        baseUsage = 2.2 - (index - 18) * 0.25;
      } else if (index >= 0 && index <= 5) {
        baseUsage = 0.4;
      } else if (index >= 9 && index <= 17) {
        baseUsage = 1.1;
      }
      
      final variation = (index % 4 - 2) * 0.15;
      return FlSpot(index.toDouble(), (baseUsage + variation).clamp(0.1, 2.8));
    });
}
