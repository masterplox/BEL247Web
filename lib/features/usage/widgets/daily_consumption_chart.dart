import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/widget_builder_utils.dart';
import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../../../core/utils/formatting_utils.dart';

class DailyConsumptionChart extends ConsumerWidget {
  const DailyConsumptionChart({
    super.key,
    this.consumptionData,
    this.isLoading = false,
    this.onDataPointTap,
  });

  final List<DailyConsumption>? consumptionData;
  final bool isLoading;
  final Function(DateTime date, double kwh)? onDataPointTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (consumptionData == null || consumptionData!.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final chartWidth = constraints.maxWidth;
          final maxX = (consumptionData!.length - 1).toDouble();
          
          // Calculate responsive interval for x-axis labels
          final xAxisInterval = WidgetBuilderUtils.calculateResponsiveInterval(
            screenWidth: screenWidth,
            chartWidth: chartWidth,
            maxValue: maxX,
            minLabelSpacing: 60,
            defaultInterval: maxX > 30 ? 7 : 1, // Show weekly labels for long periods, daily for short
          );
          
          return LineChart(
            LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 5,
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
                interval: xAxisInterval,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < consumptionData!.length) {
                    final date = consumptionData![value.toInt()].date;
                    return Padding(
                      padding: const EdgeInsets.only(top: AppTheme.spacing8),
                      child: Text(
                        '${date.day}/${date.month}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),
          ),
          minX: 0,
          maxX: maxX,
          minY: 0,
          maxY: _getMaxYValue(),
          lineBarsData: [
            _buildConsumptionLine(),
            _buildAverageLine(),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: WidgetBuilderUtils.buildLineTooltipData(
              context,
              textColor: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                final index = spot.x.toInt();
                if (index < consumptionData!.length) {
                  final data = consumptionData![index];
                  return LineTooltipItem(
                    // Dollar amounts are hidden in this version. They will be shown in a future release.
                    // '${data.date.day}/${data.date.month}\n${FormattingUtils.formatKwh(data.totalKwh)}\n\$${data.cost.toStringAsFixed(2)}',
                    '${data.date.day}/${data.date.month}\n${FormattingUtils.formatKwh(data.totalKwh)}',
                    const TextStyle(), // Will be styled by buildLineTooltipData
                  );
                }
                return null;
              }).whereType<LineTooltipItem>().toList(),
            ),
            touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
              if (event is FlTapUpEvent && (touchResponse?.lineBarSpots?.isNotEmpty ?? false)) {
                final spot = touchResponse!.lineBarSpots!.first;
                final index = spot.x.toInt();
                if (index < consumptionData!.length) {
                  final data = consumptionData![index];
                  onDataPointTap?.call(data.date, data.totalKwh);
                }
              }
            },
          ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() => Container(
        height: 300,
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

  Widget _buildEmptyState() => Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_outlined,
                size: 48,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: AppTheme.spacing16),
              Text(
                'No consumption data available',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );

  double _getMaxYValue() {
    if (consumptionData == null || consumptionData!.isEmpty) return 50;
    
    final maxValue = consumptionData!
        .map((data) => data.totalKwh)
        .reduce((a, b) => a > b ? a : b);
    
    // Add 20% padding to the max value
    return (maxValue * 1.2).ceilToDouble();
  }

  LineChartBarData _buildConsumptionLine() {
    final spots = <FlSpot>[];
    
    for (int i = 0; i < consumptionData!.length; i++) {
      final data = consumptionData![i];
      spots.add(FlSpot(i.toDouble(), data.totalKwh));
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: AppColors.primary,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4,
            color: AppColors.primary,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
      ),
      belowBarData: BarAreaData(
        show: true,
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
    );
  }

  LineChartBarData _buildAverageLine() {
    if (consumptionData == null || consumptionData!.isEmpty) {
      return LineChartBarData(spots: []);
    }

    final averageValue = consumptionData!
        .map((data) => data.totalKwh)
        .reduce((a, b) => a + b) / consumptionData!.length;

    final spots = <FlSpot>[];
    for (int i = 0; i < consumptionData!.length; i++) {
      spots.add(FlSpot(i.toDouble(), averageValue));
    }

    return LineChartBarData(
      spots: spots,
      isCurved: false,
      color: AppColors.secondary,
      barWidth: 2,
      isStrokeCapRound: true,
      dashArray: [5, 5],
      dotData: const FlDotData(show: false),
    );
  }
}
