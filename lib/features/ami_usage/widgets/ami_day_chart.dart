import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../ami_usage_page.dart';

class AmiDayChart extends StatelessWidget {
  const AmiDayChart({
    super.key,
    required this.data,
    this.selectedHour,
    required this.onSelectHour,
    required this.viewMode,
  });

  final List<HourlyData> data;
  final int? selectedHour;
  final Function(int?) onSelectHour;
  final ViewMode viewMode;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const AppCard(
        child: Center(
          child: Text('No data available'),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    // Mobile / tablet / desktop: different x-axis label density so labels don't squish
    final int xAxisInterval;
    if (width < AppTheme.mobileBreakpoint) {
      xAxisInterval = 6; // Mobile: 4 labels (0, 6, 12, 18)
    } else if (width < AppTheme.tabletBreakpoint) {
      xAxisInterval = 4; // Tablet: 6 labels (0, 4, 8, 12, 16, 20)
    } else {
      xAxisInterval = 2; // Desktop: 12 labels (every 2 hours)
    }

    final chartData = data.map((hour) {
      final value = viewMode == ViewMode.cost ? hour.kWh * 0.32 : hour.kWh;
      return FlSpot(hour.hour.toDouble(), value);
    }).toList();

    final maxValue = chartData.fold<double>(0, (max, spot) => spot.y > max ? spot.y : max);

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: SizedBox(
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxValue * 1.1,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) => AppColors.primary,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final hour = data[group.x.toInt()];
                  final kWh = hour.kWh;
                  final cost = kWh * 0.32;
                  // Show both kWh and cost with horizontal divider (like dashboard usage trend)
                  final tooltipText = '${kWh.toStringAsFixed(2)} kWh\n'
                      '───\n'
                      '\$${cost.toStringAsFixed(2)}\n'
                      '${hour.time}';
                  return BarTooltipItem(
                    tooltipText,
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (event is FlTapUpEvent && barTouchResponse?.spot != null) {
                  final hourIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
                  if (hourIndex >= 0 && hourIndex < data.length) {
                    onSelectHour(selectedHour == hourIndex ? null : hourIndex);
                  }
                }
              },
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
                  interval: xAxisInterval.toDouble(),
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < data.length && index % xAxisInterval == 0) {
                      final hour = data[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          hour.time,
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
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) => Text(
                      value.toStringAsFixed(viewMode == ViewMode.cost ? 1 : 0),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxValue / 5,
              getDrawingHorizontalLine: (value) => const FlLine(
                  color: AppColors.border,
                  strokeWidth: 1,
                ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: AppColors.border),
                left: BorderSide(color: AppColors.border),
              ),
            ),
            barGroups: chartData.asMap().entries.map((entry) {
              final index = entry.key;
              final spot = entry.value;
              final hour = data[index];
              final isSelected = selectedHour == index;
              final period = getTimeOfUsePeriod(hour.hour);
              Color barColor;
              if (period == TimeOfUse.peak) {
                barColor = AppColors.chart4;
              } else if (period == TimeOfUse.midPeak) {
                barColor = AppColors.chart3;
              } else {
                barColor = AppColors.primary;
              }

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: spot.y,
                    color: isSelected ? barColor : barColor.withOpacity(0.7),
                    width: 12,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
