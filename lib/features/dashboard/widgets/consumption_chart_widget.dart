import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../features/usage/state/meter_readings_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Consumption chart widget matching the React version design
class ConsumptionChartWidget extends ConsumerStatefulWidget {
  const ConsumptionChartWidget({super.key});

  @override
  ConsumerState<ConsumptionChartWidget> createState() => _ConsumptionChartWidgetState();
}

class _ConsumptionChartWidgetState extends ConsumerState<ConsumptionChartWidget> {
  @override
  Widget build(BuildContext context) {
    final meterReadingsAsync = ref.watch(meterReadingsThisYearProvider);

    return meterReadingsAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (readings) {
        if (readings.isEmpty) {
          return const SizedBox.shrink();
        }

        final chartData = _prepareChartData(readings);

        return AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          showBorder: true,
          borderWidth: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usage Trend',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        'Trailing 12 months',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  // Toggle buttons
                  // Container(
                  //   padding: const EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                  //     borderRadius: BorderRadius.circular(AppTheme.radius8),
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       _buildToggleButton(context, 'kWh', _showConsumption),
                  //       _buildToggleButton(context, 'Cost', !_showConsumption),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              SizedBox(
                height: 160,
                child: LineChart(
                  _buildLineChartData(chartData),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingCard(BuildContext context) => const AppCard(
      padding: EdgeInsets.all(AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

  List<Map<String, dynamic>> _prepareChartData(List<MeterReadingDto> readings) {
    // Sort by year and month
    final sorted = List<MeterReadingDto>.from(readings);
    sorted.sort((a, b) {
      final yearA = int.tryParse(a.readYear) ?? 0;
      final yearB = int.tryParse(b.readYear) ?? 0;
      if (yearA != yearB) return yearA.compareTo(yearB);
      
      final monthA = _getMonthIndex(a.readMonth);
      final monthB = _getMonthIndex(b.readMonth);
      return monthA.compareTo(monthB);
    });

    return sorted.map((reading) => {
        'month': reading.readMonth,
        'consumption': double.tryParse(reading.consumption) ?? 0.0,
      }).toList();
  }

  LineChartData _buildLineChartData(List<Map<String, dynamic>> chartData) {
    final spots = chartData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = entry.value['consumption'] as double;
      return FlSpot(index, value);
    }).toList();

    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) * 0.8;
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.2;

    return LineChartData(
      gridData: const FlGridData(
        show: false,
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
            interval: chartData.length > 6 ? 2 : 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < chartData.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    chartData[index]['month'] as String,
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
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()} kWh',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: (chartData.length - 1).toDouble(),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.success,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.success.withValues(alpha: 0.1),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.black87,
          tooltipRoundedRadius: 8,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) => touchedBarSpots.map((barSpot) {
              final index = barSpot.x.toInt();
              if (index >= 0 && index < chartData.length) {
                final consumption = chartData[index]['consumption'] as double;
                final tooltipText = '${consumption.toStringAsFixed(0)} kWh';
                
                return LineTooltipItem(
                  tooltipText,
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                );
              }
              return null;
            }).toList(),
        ),
      ),
    );
  }

  int _getMonthIndex(String month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months.indexOf(month);
  }
}
