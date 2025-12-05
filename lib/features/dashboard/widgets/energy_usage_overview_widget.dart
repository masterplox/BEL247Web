import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_bar_chart.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_switch.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class EnergyUsageOverviewWidget extends StatefulWidget {
  const EnergyUsageOverviewWidget({
    super.key,
    required this.consumption,
    this.isLoading = false,
    this.onRefresh,
  });

  final DailyConsumption consumption;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  State<EnergyUsageOverviewWidget> createState() =>
      _EnergyUsageOverviewWidgetState();
}

class _EnergyUsageOverviewWidgetState extends State<EnergyUsageOverviewWidget> {
  bool _showPreviousYear = false;

  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Usage',
                        style: AppTextStyle.title,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: AppTheme.spacing4),
                      AppText(
                        'Yesterday\'s consumption vs 7-day average',
                        style: AppTextStyle.body,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const AppText('Compare Last Year', style: AppTextStyle.caption),
                    const SizedBox(width: AppTheme.spacing8),
                    AppSwitch(
                      value: _showPreviousYear,
                      onChanged: (value) {
                        setState(() {
                          _showPreviousYear = value;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: AppTheme.spacing20),
            if (widget.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Column(
                children: [
                  _buildYearlyComparisonCards(context),
                  const SizedBox(height: AppTheme.spacing20),
                  SizedBox(
                    height: 250,
                    child: _buildBarChart(context),
                  ),
                ],
              ),
          ],
        ),
      );

  Widget _buildBarChart(BuildContext context) {
    // Mock data for the last 7 days from the second image
    final dailyConsumption = [33.0, 32.0, 50.0, 36.0, 40.0, 39.0, 43.0];
    final days = ['Mon 17', 'Tue 18', 'Wed 19', 'Thu 20', 'Fri 21', 'Sat 22', 'Sun 23'];
    const maxY = 60.0;

    final barGroups = List.generate(
      dailyConsumption.length,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: dailyConsumption[i],
            color: Theme.of(context).colorScheme.primary,
            width: 30,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    );

    return AppBarChart(
      barChartData: BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Theme.of(context).colorScheme.secondary,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final kwh = rod.toY;
              return BarTooltipItem(
                '${kwh.toStringAsFixed(1)} kWh',
                TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index < 0 || index >= days.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: AppText(days[index], style: AppTextStyle.caption),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 25 != 0) return const SizedBox.shrink();
                return AppText(value.toInt().toString(), style: AppTextStyle.caption);
              },
              reservedSize: 30,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
      ),
    );
  }

  Widget _buildYearlyComparisonCards(BuildContext context) {
    // Current year data widgets
    final currentYearTotalKwh = _buildUsageCard(
      context,
      label: 'Total Kwh',
      value: widget.consumption.totalKwh,
      isHighlighted: false,
    );
    final currentYearEstCost = _buildUsageCard(
      context,
      label: 'Est. Cost',
      value: widget.consumption.cost,
      isHighlighted: false,
    );
    final currentYearPeakUsage = _buildUsageCard(
      context,
      label: 'Peak Usage',
      value: _getYesterdayUsage(),
      isHighlighted: false,
    );
    final currentYearAverageUsage = _buildUsageCard(
      context,
      label: 'Average Usage',
      value: _get7DayAverage(),
      isHighlighted: false,
    );

    // Last year data widgets
    final lastYearTotalKwh = _buildUsageCard(
      context,
      label: 'Total Kwh (Last Year)',
      value: widget.consumption.totalKwh * 0.9,
      isHighlighted: false,
    );
    final lastYearEstCost = _buildUsageCard(
      context,
      label: 'Est. Cost (Last Year)',
      value: widget.consumption.cost * 0.85,
      isHighlighted: false,
    );
    final lastYearPeakUsage = _buildUsageCard(
      context,
      label: 'Peak Usage (Last Year)',
      value: _getYesterdayUsage() * 0.95,
      isHighlighted: false,
    );
    final lastYearAverageUsage = _buildUsageCard(
      context,
      label: 'Average Usage (Last Year)',
      value: _get7DayAverage() * 0.92,
      isHighlighted: false,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'This Year',
          style: AppTextStyle.subtitle,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: AppTheme.spacing8),
        Row(
          children: [
            Expanded(child: currentYearTotalKwh),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(child: currentYearEstCost),
          ],
        ),
        const SizedBox(height: AppTheme.spacing16),
        Row(
          children: [
            Expanded(child: currentYearPeakUsage),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(child: currentYearAverageUsage),
          ],
        ),
        if (_showPreviousYear) ...[
          const SizedBox(height: AppTheme.spacing20),
          const AppText(
            'Last Year',
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              Expanded(child: lastYearTotalKwh),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(child: lastYearEstCost),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              Expanded(child: lastYearPeakUsage),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(child: lastYearAverageUsage),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildUsageCard(
    BuildContext context, {
    required String label,
    required double value,
    required bool isHighlighted,
  }) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              label,
              style: AppTextStyle.caption,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppTheme.spacing8),
            AppText(
              '${value.toStringAsFixed(1)} kWh',
              style: AppTextStyle.title,
              color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      );

  double _getYesterdayUsage() {
    // Mock data from image: 33.4 kWh
    return 33.4;
  }

  double _get7DayAverage() {
    // Mock data from image: 32.1 kWh
    return 32.1;
  }
}
