import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/formatting_utils.dart';
import '../../core/widgets/app_line_chart.dart';
import '../../core/widgets/app_text.dart';
import '../../data/models/api_response_dtos.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../../features/usage/state/meter_readings_providers.dart';

/// Configuration for meter readings chart display
class MeterReadingsChartConfig {
  const MeterReadingsChartConfig({
    this.showYAxis = true,
    this.showYAxisLabel = true,
    this.showTooltips = true,
    this.showClickableDataPoints = true,
    this.showLegend = true,
    this.height = 400.0,
    this.showNavigationButton = false,
    this.onDataPointClick,
  });

  /// Whether to show Y-axis values
  final bool showYAxis;
  
  /// Whether to show Y-axis label
  final bool showYAxisLabel;
  
  /// Whether to show tooltips on hover
  final bool showTooltips;
  
  /// Whether data points are clickable (for detail cards)
  final bool showClickableDataPoints;
  
  /// Whether to show legend
  final bool showLegend;
  
  /// Chart height
  final double height;
  
  /// Whether to show navigation button to usage page
  final bool showNavigationButton;
  
  /// Callback when a data point is clicked (monthIndex: 0-11, isThisYear: true/false)
  final void Function(int monthIndex, bool isThisYear)? onDataPointClick;
}

/// Reusable meter readings chart widget
class MeterReadingsChartWidget extends ConsumerWidget {
  const MeterReadingsChartWidget({
    super.key,
    required this.config,
  });

  final MeterReadingsChartConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
    final lastYearAsync = ref.watch(meterReadingsLastYearProvider);

    return thisYearAsync.when(
      loading: () => SizedBox(
        height: config.height,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => SizedBox(
        height: config.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppTheme.spacing8),
              AppText('Unable to load meter readings. Please try again.', style: AppTextStyle.body),
            ],
          ),
        ),
      ),
      data: (thisYearReadings) => lastYearAsync.when(
        loading: () => SizedBox(
          height: config.height,
          child: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, st) => _buildChart(context, thisYearReadings, []),
        data: (lastYearReadings) => _buildChart(context, thisYearReadings, lastYearReadings),
      ),
    );
  }

  Widget _buildChart(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
  ) {
    // Process readings - group by month and calculate consumption
    final thisYearData = _processReadingsByMonth(thisYearReadings);
    final lastYearData = _processReadingsByMonth(lastYearReadings);

    // Find max value for Y axis (use consumption for scaling)
    final maxValue = [
      ...thisYearData.map((e) => e.consumption),
      ...lastYearData.map((e) => e.consumption),
    ].fold<double>(0, (max, val) => val > max ? val : max);

    // Create month labels
    final monthAbbreviations = List.generate(12, (index) => FormattingUtils.getMonthName(index + 1));
    final currentYear = DateTime.now().year;
    final lastYear = currentYear - 1;

    // Prepare data points for chart
    final thisYearSpots = List.generate(12, (index) {
      final monthData = thisYearData.firstWhere(
        (d) => d.month == index + 1,
        orElse: () => _MonthData(month: index + 1, consumption: 0),
      );
      return FlSpot(index.toDouble(), monthData.consumption);
    });

    final lastYearSpots = List.generate(12, (index) {
      final monthData = lastYearData.firstWhere(
        (d) => d.month == index + 1,
        orElse: () => _MonthData(month: index + 1, consumption: 0),
      );
      return FlSpot(index.toDouble(), monthData.consumption);
    });

    final lineChartData = LineChartData(
      gridData: FlGridData(
        show: config.showYAxis, // Only show grid if Y-axis is shown
        drawVerticalLine: false,
        horizontalInterval: maxValue > 0 ? maxValue / 5 : 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: AppColors.border.withValues(alpha: 0.3),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < monthAbbreviations.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AppText(
                      monthAbbreviations[index],
                      style: AppTextStyle.caption,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          axisNameWidget: const AppText('Months', style: AppTextStyle.caption),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: config.showYAxis,
            reservedSize: config.showYAxis ? 50 : 0,
            interval: maxValue > 0 ? maxValue / 5 : 1,
            getTitlesWidget: (value, meta) => SideTitleWidget(
              axisSide: meta.axisSide,
              child: AppText(
                value.toInt().toString(),
                style: AppTextStyle.caption,
              ),
            ),
          ),
          axisNameWidget: config.showYAxisLabel
              ? const AppText('Consumption (kWh)', style: AppTextStyle.caption)
              : null,
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: const BorderSide(color: AppColors.border, width: 1),
          left: config.showYAxis
              ? const BorderSide(color: AppColors.border, width: 1)
              : BorderSide.none,
        ),
      ),
      lineBarsData: [
        // This year - Green line
        LineChartBarData(
          spots: thisYearSpots,
          isCurved: true,
          color: AppColors.success, // Green
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config.showClickableDataPoints, // Only show dots if clickable
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: AppColors.success,
              strokeWidth: 2,
              strokeColor: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(show: false),
        ),
        // Last year - Yellow line
        LineChartBarData(
          spots: lastYearSpots,
          isCurved: true,
          color: Colors.yellow.shade700, // Yellow
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: config.showClickableDataPoints, // Only show dots if clickable
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: Colors.yellow.shade700,
              strokeWidth: 2,
              strokeColor: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      minY: 0,
      maxY: maxValue > 0 ? maxValue * 1.1 : 100, // Add 10% padding
      lineTouchData: LineTouchData(
        enabled: config.showTooltips || (config.showClickableDataPoints && config.onDataPointClick != null),
        touchTooltipData: config.showTooltips
            ? LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedSpots) => touchedSpots.map((LineBarSpot touchedSpot) {
                  final monthIndex = touchedSpot.x.toInt();
                  final monthName = monthIndex >= 0 && monthIndex < monthAbbreviations.length
                      ? monthAbbreviations[monthIndex]
                      : 'Unknown';
                  final value = touchedSpot.y;
                  final label = touchedSpot.barIndex == 0 ? 'This Year' : 'Last Year';
                  
                  // Get detailed data for this month
                  final monthData = touchedSpot.barIndex == 0
                      ? thisYearData.firstWhere(
                          (d) => d.month == monthIndex + 1,
                          orElse: () => _MonthData(month: monthIndex + 1, consumption: 0),
                        )
                      : lastYearData.firstWhere(
                          (d) => d.month == monthIndex + 1,
                          orElse: () => _MonthData(month: monthIndex + 1, consumption: 0),
                        );
                  
                  // Build detailed tooltip text with all fields
                  final tooltipText = [
                    '$label - $monthName',
                    'Consumption: ${value.toStringAsFixed(2)} kWh',
                    // Dollar amounts are hidden in this version. They will be shown in a future release.
                    // 'Amount: BZ\$${monthData.amount.toStringAsFixed(2)}',
                    'Avg Usage: ${monthData.averageUsage.toStringAsFixed(2)} kWh/day',
                    'Days: ${monthData.days}',
                  ].join('\n');
                  
                  return LineTooltipItem(
                    tooltipText,
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              )
            : LineTouchTooltipData(
                getTooltipItems: (_) => [],
              ),
        touchCallback: config.showClickableDataPoints && config.onDataPointClick != null
            ? (FlTouchEvent event, LineTouchResponse? touchResponse) {
                if (event is FlTapUpEvent && touchResponse != null && touchResponse.lineBarSpots != null) {
                  final spots = touchResponse.lineBarSpots!;
                  if (spots.isNotEmpty) {
                    final spot = spots.first;
                    final monthIndex = spot.x.toInt();
                    final isThisYear = spot.barIndex == 0;
                    config.onDataPointClick?.call(monthIndex, isThisYear);
                  }
                }
              }
            : config.showClickableDataPoints && config.onDataPointClick == null
                ? (FlTouchEvent event, LineTouchResponse? touchResponse) {
                    // No-op if clickable but no callback provided
                  }
                : null,
      ),
    );

    return Column(
      children: [
        // Navigation button if configured
        if (config.showNavigationButton)
          Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.open_in_new, size: 18),
                  onPressed: () => context.go('/usage'),
                  tooltip: 'View detailed usage',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ],
            ),
          ),
        // Chart
        SizedBox(
          height: config.height,
          child: AppLineChart(lineChartData: lineChartData),
        ),
        // Legend if configured
        if (config.showLegend) ...[
          const SizedBox(height: AppTheme.spacing8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(context, AppColors.success, currentYear.toString()),
              const SizedBox(width: AppTheme.spacing16),
              _buildLegendItem(context, Colors.yellow.shade700, lastYear.toString()),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String text) => Row(
    children: [
      Container(
        width: 12,
        height: 12,
        color: color,
      ),
      const SizedBox(width: AppTheme.spacing4),
      AppText(text, style: AppTextStyle.caption),
    ],
  );

  /// Process readings and group by month, calculating total consumption per month
  List<_MonthData> _processReadingsByMonth(List<MeterReadingDto> readings) {
    final monthMap = <int, _MonthData>{};
    
    for (final reading in readings) {
      try {
        // Parse month name (e.g., "Jan", "Feb") to month number (1-12)
        final month = _parseMonthName(reading.readMonth);
        final consumption = double.tryParse(reading.consumption.replaceAll(',', '')) ?? 0.0;
        final amount = double.tryParse(reading.amount.replaceAll(',', '')) ?? 0.0;
        final averageUsage = double.tryParse(reading.averageUsage.replaceAll(',', '')) ?? 0.0;
        final days = int.tryParse(reading.days) ?? 0;
        
        if (month >= 1 && month <= 12) {
          // If month already exists, accumulate consumption and update other fields
          if (monthMap.containsKey(month)) {
            final existing = monthMap[month]!;
            monthMap[month] = _MonthData(
              month: month,
              consumption: existing.consumption + consumption,
              amount: existing.amount + amount,
              averageUsage: averageUsage, // Use latest averageUsage
              days: days, // Use latest days
              reading: reading, // Store latest reading for tooltip
            );
          } else {
            monthMap[month] = _MonthData(
              month: month,
              consumption: consumption,
              amount: amount,
              averageUsage: averageUsage,
              days: days,
              reading: reading,
            );
          }
        }
      } catch (e) {
        // Skip invalid readings
      }
    }
    
    return monthMap.values.toList();
  }

  int _parseMonthName(String monthStr) {
    if (monthStr.isEmpty) return 0;
    
    // Try parsing as number first
    final monthNum = int.tryParse(monthStr);
    if (monthNum != null && monthNum >= 1 && monthNum <= 12) {
      return monthNum;
    }
    
    // Parse month abbreviations and full names
    final monthLower = monthStr.toLowerCase().trim();
    final monthMap = {
      'jan': 1, 'january': 1,
      'feb': 2, 'february': 2,
      'mar': 3, 'march': 3,
      'apr': 4, 'april': 4,
      'may': 5,
      'jun': 6, 'june': 6,
      'jul': 7, 'july': 7,
      'aug': 8, 'august': 8,
      'sep': 9, 'september': 9, 'sept': 9,
      'oct': 10, 'october': 10,
      'nov': 11, 'november': 11,
      'dec': 12, 'december': 12,
    };
    
    return monthMap[monthLower] ?? 0;
  }
}

/// Internal data structure for month aggregation
class _MonthData {
  const _MonthData({
    required this.month,
    required this.consumption,
    this.amount = 0.0,
    this.averageUsage = 0.0,
    this.days = 0,
    this.reading,
  });

  final int month;
  final double consumption;
  final double amount;
  final double averageUsage;
  final int days;
  final MeterReadingDto? reading;
}
