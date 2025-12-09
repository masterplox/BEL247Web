import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AppLineChart extends StatelessWidget {
  const AppLineChart({
    super.key,
    required this.lineChartData,
  });

  final LineChartData lineChartData;

  @override
  Widget build(BuildContext context) {
    // Check if custom titlesData is provided by looking for non-default reservedSize or interval
    final bottomSideTitles = lineChartData.titlesData.bottomTitles.sideTitles;
    final leftSideTitles = lineChartData.titlesData.leftTitles.sideTitles;
    // If reservedSize is not the default (22) or interval is set, it's customized
    final hasCustomBottomTitles = bottomSideTitles.reservedSize != 22 || 
                                   bottomSideTitles.interval != null;
    final hasCustomLeftTitles = leftSideTitles.showTitles;
    
    // Check if custom gridData or borderData is provided
    final hasCustomGrid = lineChartData.gridData.show;
    final hasCustomBorder = lineChartData.borderData.show;
    
    return LineChart(
      lineChartData.copyWith(
        // Preserve custom gridData if provided, otherwise use default (no grid)
        gridData: hasCustomGrid
            ? lineChartData.gridData
            : const FlGridData(show: false),
        // Preserve custom borderData if provided, otherwise use default (no border)
        borderData: hasCustomBorder
            ? lineChartData.borderData
            : FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: hasCustomBottomTitles
              ? lineChartData.titlesData.bottomTitles
              : AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      // Default bottom title behavior
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      );
                    },
                  ),
                ),
          leftTitles: hasCustomLeftTitles
              ? lineChartData.titlesData.leftTitles
              : const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}
