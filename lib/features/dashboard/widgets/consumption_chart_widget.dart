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
  bool _showConsumption = true; // true for kWh, false for cost

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
                        'Usage Trend (kWh)',
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
              const SizedBox(height: AppTheme.spacing12),
              const Divider(height: 1),
              const SizedBox(height: AppTheme.spacing12),
              // Legend
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _showConsumption ? AppColors.success : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      _showConsumption ? 'Energy Usage (kWh)' : r'Monthly Cost ($)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                    ),
                  ],
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

  Widget _buildToggleButton(BuildContext context, String label, bool isSelected) => InkWell(
      onTap: () {
        setState(() {
          _showConsumption = label == 'kWh';
        });
      },
      borderRadius: BorderRadius.circular(AppTheme.radius8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
        ),
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
        'cost': double.tryParse(reading.amount) ?? 0.0,
      }).toList();
  }

  LineChartData _buildLineChartData(List<Map<String, dynamic>> chartData) {
    final spots = chartData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = _showConsumption
          ? (entry.value['consumption'] as double)
          : (entry.value['cost'] as double);
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
              if (_showConsumption) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                );
              } else {
                return Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                );
              }
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
          color: _showConsumption ? AppColors.success : AppColors.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: (_showConsumption ? AppColors.success : AppColors.primary)
                .withValues(alpha: 0.1),
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
                final cost = chartData[index]['cost'] as double;
                
                // Show both kWh and cost with a horizontal divider
                final tooltipText = '${consumption.toStringAsFixed(0)} kWh\n'
                    '───\n'
                    '\$${cost.toStringAsFixed(2)}';
                
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
