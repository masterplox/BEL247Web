import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/models/api_dtos.dart';
import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class DailyCostSummaryWidget extends StatelessWidget {
  const DailyCostSummaryWidget({
    super.key,
    required this.consumption,
    this.dashboardData,
    this.sevenDayConsumption,
    this.isLoading = false,
    this.onRefresh,
  });

  final DailyConsumption consumption;
  final DashboardData? dashboardData;
  final List<DailyConsumption>? sevenDayConsumption;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dashboardData?.dailyCostSummary.title ?? 'Daily Cost',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  dashboardData?.dailyCostSummary.description ??
                      'The information below is an estimate of your current billing cycle.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  dashboardData?.dailyCostSummary.billingCycle ??
                      'Billing Cycle: Nov 1, 2025 - Nov 30, 2025',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing20),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Column(
                children: [
                  // Today and Yesterday cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 600;
                      final cards = [
                        _buildCostCard(
                          context,
                          label: 'Today',
                          amount: consumption.cost,
                          isHighlighted: true,
                        ),
                        _buildCostCard(
                          context,
                          label: 'Yesterday',
                          amount: _getYesterdayCost(),
                        ),
                        _buildCostCard(
                          context,
                          label: 'This Month',
                          amount: _getMonthToDateCost(),
                        ),
                      ];

                      if (isNarrow) {
                        return Column(
                          children: [
                            for (int i = 0; i < cards.length; i++) ...[
                              cards[i],
                              if (i != cards.length - 1)
                                const SizedBox(height: AppTheme.spacing12),
                            ],
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: cards[0]),
                          const SizedBox(width: AppTheme.spacing16),
                          Expanded(child: cards[1]),
                          const SizedBox(width: AppTheme.spacing16),
                          Expanded(child: cards[2]),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  // 7-day line graph
                  _build7DayChart(context),
                  const SizedBox(height: AppTheme.spacing12),
                  Text(
                    dashboardData?.dailyCostSummary.estimateDisclaimer ??
                        '* All dollar values are estimates.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );

  Widget _buildCostCard(
    BuildContext context, {
    required String label,
    required double amount,
    bool isHighlighted = false,
  }) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isHighlighted
              ? Theme.of((context)).colorScheme.primaryContainer.withOpacity(0.1)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'BZ\$${amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: isHighlighted
                            ? Theme.of(context).colorScheme.primary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _build7DayChart(BuildContext context) {
    final data = _get7DayCostData();
    final now = DateTime.now();
    
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 4,
            getDrawingHorizontalLine: (value) => const FlLine(
              color: AppColors.border,
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => const FlLine(
              color: AppColors.border,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final day = now.subtract(Duration(days: 6 - value.toInt()));
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 4,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 16,
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((entry) => 
                FlSpot(entry.key.toDouble(), entry.value)
              ).toList(),
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 2,
                  strokeColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  List<double> _get7DayCostData() {
    if (sevenDayConsumption == null || sevenDayConsumption!.isEmpty) {
      return [10.5, 9.5, 8.0, 12.5, 10.0, 8.5, consumption.cost];
    }
    // ensure we have 7 days, padding if necessary
    final costs = sevenDayConsumption!.map((c) => c.cost).toList();
    while (costs.length < 7) {
      costs.insert(0, 0.0);
    }
    return costs.sublist(costs.length - 7);
  }

  double _getYesterdayCost() {
    if (sevenDayConsumption == null || sevenDayConsumption!.length < 2) {
      return 8.68;
    }
    return sevenDayConsumption![sevenDayConsumption!.length - 2].cost;
  }

  double _getMonthToDateCost() {
    final daysInMonth = DateUtils.getDaysInMonth(
      consumption.date.year,
      consumption.date.month,
    );
    return consumption.cost * daysInMonth;
  }

}
