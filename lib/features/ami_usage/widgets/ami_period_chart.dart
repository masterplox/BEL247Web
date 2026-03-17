import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../ami_usage_page.dart';
import '../state/ami_usage_providers.dart' show DayTou;

class AmiPeriodChart extends StatelessWidget {
  const AmiPeriodChart({
    super.key,
    required this.data,
    required this.filterType,
    this.selectedIndex,
    required this.onSelectIndex,
    required this.viewMode,
    this.touPerDay,
    this.showLoading = false,
  });

  final List<DailyReading> data;
  final FilterType filterType;
  final int? selectedIndex;
  final Function(int?) onSelectIndex;
  final ViewMode viewMode;
  /// When set (week/month), bars are stacked by TOU: off-peak, peak, mid-peak.
  final List<DayTou>? touPerDay;
  /// When true, show a loading spinner instead of the chart (used while TOU data loads).
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    if (showLoading) {
      return const AppCard(
        child: SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    // Derive effective data for the chart. If we have no daily readings but we
    // do have per-day TOU data (from intervals), synthesize daily totals from
    // TOU so we can still render bars instead of showing "No data available".
    final List<DailyReading> effectiveData;
    if (data.isEmpty && touPerDay != null && touPerDay!.isNotEmpty) {
      effectiveData = touPerDay!
          .map(
            (d) => DailyReading(
              meter: '',
              readDate: '${d.date.toIso8601String().split('T')[0]} 00:00:00.000',
              kWhUsed: (d.offKwh + d.peakKwh + d.midPeakKwh).toStringAsFixed(3),
            ),
          )
          .toList();
    } else {
      effectiveData = data;
    }

    if (effectiveData.isEmpty) {
      return const AppCard(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.query_stats_outlined,
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

    // Map date (yyyy-MM-dd) -> DayTou so we can show stacked bar only for days with TOU data
    final touByDate = <String, DayTou>{};
    if (touPerDay != null) {
      for (final day in touPerDay!) {
        final k = '${day.date.year}-${day.date.month.toString().padLeft(2, '0')}-${day.date.day.toString().padLeft(2, '0')}';
        touByDate[k] = day;
      }
    }

    double maxValue = 0;
    for (var i = 0; i < effectiveData.length; i++) {
      final reading = effectiveData[i];
      final dateKey = _dateKeyFromReading(reading);
      final dayTou = dateKey != null ? touByDate[dateKey] : null;
      if (dayTou != null) {
        final sum = dayTou.offKwh + dayTou.peakKwh + dayTou.midPeakKwh;
        if (sum > maxValue) maxValue = sum;
      } else {
        final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
        final value = viewMode == ViewMode.cost ? kWh * 0.32 : kWh;
        if (value > maxValue) maxValue = value;
      }
    }
    // fl_chart asserts when maxY == minY (common when all values are 0)
    final safeMaxY = maxValue > 0 ? maxValue * 1.1 : 1.0;

    final barColor = viewMode == ViewMode.cost ? AppColors.chart2 : AppColors.primary;

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
                getTooltipColor: (group) => barColor,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final index = group.x.toInt();
                  if (index >= 0 && index < effectiveData.length) {
                    final reading = effectiveData[index];
                    try {
                      final date = DateTime.parse(reading.readDate.split(' ')[0]);
                      final dateStr = _formatDate(date);
                      final dateKey = _dateKeyFromReading(reading);
                      final dayTou = dateKey != null ? touByDate[dateKey] : null;
                      if (dayTou != null) {
                        final tooltipText = 'Off-Peak: ${dayTou.offKwh.toStringAsFixed(1)} kWh\n'
                            'Peak: ${dayTou.peakKwh.toStringAsFixed(1)} kWh\n'
                            'Mid-Peak: ${dayTou.midPeakKwh.toStringAsFixed(1)} kWh\n'
                            '───\n$dateStr';
                        return BarTooltipItem(
                          tooltipText,
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }
                      final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
                      final cost = kWh * 0.32;
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
                      final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
                      final tooltipText = '${kWh.toStringAsFixed(1)} kWh';
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
                    if (index >= 0 && index < effectiveData.length && index % intervalForModulo == 0) {
                      try {
                        final reading = effectiveData[index];
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
            barGroups: effectiveData.asMap().entries.map((entry) {
              final index = entry.key;
              final reading = entry.value;
              final isSelected = selectedIndex == index;
              final dateKey = _dateKeyFromReading(reading);
              final dayTou = dateKey != null ? touByDate[dateKey] : null;
              if (dayTou != null) {
                final off = dayTou.offKwh;
                final peak = dayTou.peakKwh;
                final mid = dayTou.midPeakKwh;
                final total = off + peak + mid;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: total,
                      width: 12,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      rodStackItems: [
                        BarChartRodStackItem(
                          0,
                          off,
                          AppColors.primary,
                        ),
                        BarChartRodStackItem(
                          off,
                          off + peak,
                          AppColors.chart4,
                        ),
                        BarChartRodStackItem(
                          off + peak,
                          off + peak + mid,
                          AppColors.chart3,
                        ),
                      ],
                    ),
                  ],
                );
              }
              final kWh = double.tryParse(reading.kWhUsed) ?? 0.0;
              final value = viewMode == ViewMode.cost ? kWh * 0.32 : kWh;
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

  /// Parses reading.readDate and returns "yyyy-MM-dd" for TOU lookup, or null.
  static String? _dateKeyFromReading(DailyReading reading) {
    try {
      final part = reading.readDate.trim().split(RegExp(r'[\sT]')).first;
      final d = DateTime.tryParse(part);
      if (d == null) return null;
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return null;
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
