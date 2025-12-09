import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AppBarChart extends StatelessWidget {
  const AppBarChart({
    super.key,
    required this.barChartData,
  });

  final BarChartData barChartData;

  @override
  Widget build(BuildContext context) {
    // Check if custom titlesData is provided by looking for non-default reservedSize or interval
    final bottomSideTitles = barChartData.titlesData.bottomTitles.sideTitles;
    final leftSideTitles = barChartData.titlesData.leftTitles.sideTitles;
    // If reservedSize is not the default (30) or interval is set, it's customized
    final hasCustomBottomTitles = bottomSideTitles.reservedSize != 30 || 
                                   bottomSideTitles.interval != null;
    final hasCustomLeftTitles = leftSideTitles.reservedSize != 32;
    
    return BarChart(
      barChartData.copyWith(
        // Apply common styling here
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => const FlLine(
            color: AppColors.border,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: hasCustomBottomTitles
              ? barChartData.titlesData.bottomTitles
              : AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      // Default bottom title behavior
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                        ),
                      );
                    },
                  ),
                ),
          leftTitles: hasCustomLeftTitles
              ? barChartData.titlesData.leftTitles
              : AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
