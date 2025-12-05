import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

class AppLineChart extends StatelessWidget {
  const AppLineChart({
    super.key,
    required this.lineChartData,
  });

  final LineChartData lineChartData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      lineChartData.copyWith(
        // Apply common styling here
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
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
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}
