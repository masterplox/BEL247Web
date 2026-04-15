import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class AmiDayChart extends StatelessWidget {
  const AmiDayChart({
    super.key,
    required this.data,
    this.selectedHour,
    required this.onSelectHour,
  });

  final List<HourlyData> data;
  final int? selectedHour;
  final Function(int?) onSelectHour;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const AppCard(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insights_outlined,
                size: 44,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: AppTheme.spacing8),
              Text(
                'No data available',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
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
      return FlSpot(hour.hour.toDouble(), hour.kWh);
    }).toList();

    final maxValue = chartData.fold<double>(0, (max, spot) => spot.y > max ? spot.y : max);
    // fl_chart asserts when maxY == minY (common when all values are 0)
    final safeMaxY = maxValue > 0 ? maxValue * 1.1 : 1.0;

    return AppCard(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: SizedBox(
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: safeMaxY,
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
                  final tooltipText = '${kWh.toStringAsFixed(2)} kWh\n${hour.time}';
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
                      '${value.toStringAsFixed(0)} kWh',
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
              horizontalInterval: safeMaxY / 5,
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
                barColor = AppColors.info;
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
