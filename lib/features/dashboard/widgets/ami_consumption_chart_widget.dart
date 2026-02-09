import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart' show ratePerKwh;
import '../../../data/models/api_response_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/ami_dashboard_usage_providers.dart';

/// Dashboard usage trend chart for AMI meters.
///
/// Mirrors `ConsumptionChartWidget` but uses `amiMonthlyTotals` for the current year.
class AmiConsumptionChartWidget extends ConsumerStatefulWidget {
  const AmiConsumptionChartWidget({super.key});

  @override
  ConsumerState<AmiConsumptionChartWidget> createState() => _AmiConsumptionChartWidgetState();
}

enum _AmiTrendRange { month, year }

class _AmiConsumptionChartWidgetState extends ConsumerState<AmiConsumptionChartWidget> {
  final bool _showConsumption = true; // true for kWh, false for cost
  _AmiTrendRange _range = _AmiTrendRange.month;

  static const _monthNames = <String>[
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final monthDailyAsync = ref.watch(amiDashboardCurrentMonthDailyUpToYesterdayProvider);
    final yearlyMonthlyAsync = ref.watch(amiDashboardMonthlyTotalsProvider);

    final AsyncValue<List<Map<String, dynamic>>> chartDataAsync =
        _range == _AmiTrendRange.month
            ? monthDailyAsync.whenData(_prepareMonthChartData)
            : yearlyMonthlyAsync.whenData(_prepareYearChartData);

    return chartDataAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (chartData) {
        if (chartData.isEmpty ||
            chartData.every((p) => (p['consumption'] as double) == 0)) {
          return const SizedBox.shrink();
        }

        final subtitle = _range == _AmiTrendRange.month
            ? 'Current month'
            : 'Current year';

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
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  _buildRangeToggle(context),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              SizedBox(
                height: 160,
                child: LineChart(_buildLineChartData(chartData)),
              ),
              const SizedBox(height: AppTheme.spacing12),
              const Divider(height: 1),
              const SizedBox(height: AppTheme.spacing12),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _showConsumption
                            ? AppColors.success
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      _showConsumption
                          ? 'Energy Usage (kWh)'
                          : r'Estimated Cost ($)',
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
        child: Center(child: CircularProgressIndicator()),
      );

  Widget _buildRangeToggle(BuildContext context) => Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRangeToggleButton(
              context,
              'Month',
              _range == _AmiTrendRange.month,
              () => setState(() => _range = _AmiTrendRange.month),
            ),
            _buildRangeToggleButton(
              context,
              'Year',
              _range == _AmiTrendRange.year,
              () => setState(() => _range = _AmiTrendRange.year),
            ),
          ],
        ),
      );

  Widget _buildRangeToggleButton(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) =>
      InkWell(
        onTap: onTap,
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
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
        ),
      );

  List<Map<String, dynamic>> _prepareYearChartData(
    List<MonthlyUsageEntryDto> monthlyTotals,
  ) {
    // Fill all 12 months so the chart is stable.
    final monthToKwh = <int, double>{};
    for (final m in monthlyTotals) {
      final int month = m.month;
      final double kwh = m.monthlyUsageKwh;
      if (month >= 1 && month <= 12) {
        monthToKwh[month] = kwh;
      }
    }

    return List.generate(12, (i) {
      final monthIndex = i + 1;
      final kwh = monthToKwh[monthIndex] ?? 0.0;
      final cost = kwh * ratePerKwh;
      return {
        'label': _monthNames[i],
        'consumption': kwh,
        'cost': cost,
      };
    });
  }

  List<Map<String, dynamic>> _prepareMonthChartData(
    List<DailyUsageEntryDto> dailyRows,
  ) {
    // De-dupe by date, keep the max for a day to avoid double counting.
    final byDay = <DateTime, double>{};
    for (final r in dailyRows) {
      final dateStr = r.usageDate.trim().split(RegExp('[T ]')).first;
      final d = DateTime.tryParse(dateStr);
      if (d == null) continue;
      final day = DateTime(d.year, d.month, d.day);
      final prev = byDay[day];
      if (prev == null || r.dailyUsageKwh > prev) {
        byDay[day] = r.dailyUsageKwh;
      }
    }

    final days = byDay.keys.toList()..sort((a, b) => a.compareTo(b));
    return days
        .map((d) {
          final kwh = byDay[d] ?? 0.0;
          final cost = kwh * ratePerKwh;
          return {
            'label': d.day.toString(),
            'consumption': kwh,
            'cost': cost,
          };
        })
        .toList();
  }

  LineChartData _buildLineChartData(List<Map<String, dynamic>> chartData) {
    final spots = chartData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = _showConsumption
          ? (entry.value['consumption'] as double)
          : (entry.value['cost'] as double);
      return FlSpot(index, value);
    }).toList();

    final minVal = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxVal = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final minY = minVal * 0.8;
    final maxY = maxVal * 1.2;

    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                    chartData[index]['label'] as String,
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
            getTitlesWidget: (value, meta) => Text(
              _showConsumption ? value.toInt().toString() : '\$${value.toInt()}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (chartData.length - 1).toDouble(),
      minY: minY.isFinite ? minY : 0,
      maxY: maxY.isFinite && maxY > 0 ? maxY : 1,
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
          getTooltipItems: (touchedBarSpots) => touchedBarSpots.map((barSpot) {
            final index = barSpot.x.toInt();
            if (index >= 0 && index < chartData.length) {
              final consumption = chartData[index]['consumption'] as double;
              final cost = chartData[index]['cost'] as double;
              final tooltipText = '${consumption.toStringAsFixed(1)} kWh\n'
                  '───\n'
                  '\$${cost.toStringAsFixed(2)}';
              return LineTooltipItem(
                tooltipText,
                const TextStyle(color: Colors.white, fontSize: 12),
              );
            }
            return null;
          }).toList(),
        ),
      ),
    );
  }
}

