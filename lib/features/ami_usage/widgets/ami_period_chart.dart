import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../ami_usage_page.dart';

class AmiPeriodChart extends StatelessWidget {
  const AmiPeriodChart({
    super.key,
    required this.data,
    required this.filterType,
    this.selectedIndex,
    required this.onSelectIndex,
    required this.viewMode,
  });

  final List<DailyReading> data;
  final FilterType filterType;
  final int? selectedIndex;
  final Function(int?) onSelectIndex;
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

    // Week / month charts: responsive x-axis interval (mobile / tablet / desktop) like day chart
    final double intervalForAxis;
    final int intervalForModulo;
    if (filterType == FilterType.week) {
      final width = MediaQuery.of(context).size.width;
      final int weekInterval;
      if (width < AppTheme.mobileBreakpoint) {
        weekInterval = 3; // Mobile: 3 labels (e.g. Sun, Wed, Sat)
      } else if (width < AppTheme.tabletBreakpoint) {
        weekInterval = 2; // Tablet: 4 labels (e.g. Sun, Tue, Thu, Sat)
      } else {
        weekInterval = 1; // Desktop: all 7 days
      }
      intervalForAxis = weekInterval.toDouble();
      intervalForModulo = weekInterval;
    } else if (filterType == FilterType.month) {
      final width = MediaQuery.of(context).size.width;
      final int monthInterval;
      if (width < AppTheme.mobileBreakpoint) {
        monthInterval = 6; // Mobile: ~3 labels (e.g. 1, 11, 21)
      } else if (width < AppTheme.tabletBreakpoint) {
        monthInterval = 5; // Tablet: ~6 labels (e.g. 1, 6, 11, 16, 21, 26)
      } else {
        monthInterval = 3; // Desktop: ~10 labels (e.g. 1, 4, 7, 10, 13, 16, 19, 22, 25, 28)
      }
      intervalForAxis = monthInterval.toDouble();
      intervalForModulo = monthInterval;
    } else {
      // Year chart
      intervalForAxis = _getBottomInterval();
      intervalForModulo = intervalForAxis.toInt();
    }

    final maxValue = data.fold<double>(
      0,
      (max, reading) {
        final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
        final value = viewMode == ViewMode.cost ? kWh * 0.32 : kWh;
        return value > max ? value : max;
      },
    );

    final barColor = viewMode == ViewMode.cost ? AppColors.chart2 : AppColors.primary;

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
                getTooltipColor: (group) => barColor,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final index = group.x.toInt();
                  if (index >= 0 && index < data.length) {
                    final reading = data[index];
                    final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
                    final cost = kWh * 0.32;
                    try {
                      final date = DateTime.parse(reading.readDate.split(' ')[0]);
                      final dateStr = _formatDate(date);
                      // Show both kWh and cost with horizontal divider (like dashboard usage trend)
                      final tooltipText = '${kWh.toStringAsFixed(1)} kWh\n'
                          '───\n'
                          '\$${cost.toStringAsFixed(2)}\n'
                          '$dateStr';
                      return BarTooltipItem(
                        tooltipText,
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    } catch (e) {
                      final tooltipText = '${kWh.toStringAsFixed(1)} kWh\n───\n\$${cost.toStringAsFixed(2)}';
                      return BarTooltipItem(
                        tooltipText,
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }
                  }
                  return BarTooltipItem(
                    '',
                    const TextStyle(fontSize: 12),
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (event is FlTapUpEvent && barTouchResponse?.spot != null) {
                  final index = barTouchResponse!.spot!.touchedBarGroupIndex;
                  if (index >= 0 && index < data.length) {
                    onSelectIndex(selectedIndex == index ? null : index);
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
                  interval: intervalForAxis,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < data.length && index % intervalForModulo == 0) {
                      try {
                        final reading = data[index];
                        final date = DateTime.parse(reading.readDate.split(' ')[0]);
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _formatBottomLabel(date),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        );
                      } catch (e) {
                        return const Text('');
                      }
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
            barGroups: data.asMap().entries.map((entry) {
              final index = entry.key;
              final reading = entry.value;
              final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
              final value = viewMode == ViewMode.cost ? kWh * 0.32 : kWh;
              final isSelected = selectedIndex == index;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
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

  /// Skip some x-axis labels for a cleaner axis (like dashboard charts).
  double _getBottomInterval() {
    switch (filterType) {
      case FilterType.week:
        return 2; // Show ~4 labels (e.g. Sun, Tue, Thu, Sat)
      case FilterType.month:
        return 5; // Show ~6 labels across the month
      case FilterType.year:
        return 2; // Show every other month (6 labels)
      default:
        return 1;
    }
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatBottomLabel(DateTime date) {
    switch (filterType) {
      case FilterType.week:
        return '${date.day}${_ordinal(date.day)}';
      case FilterType.month:
        return '${date.day}${_ordinal(date.day)}';
      case FilterType.year:
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return months[date.month - 1];
      default:
        return date.day.toString();
    }
  }

  static String _ordinal(int n) {
    if (n >= 11 && n <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
