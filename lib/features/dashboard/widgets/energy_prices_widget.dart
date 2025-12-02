import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class EnergyPricesWidget extends StatelessWidget {
  const EnergyPricesWidget({
    super.key,
    this.isLoading = false,
    this.onRefresh,
  });

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
                  'Energy Prices',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  'Daily electricity rates (2 days future, today, 7 days past)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing24),
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
                  // Line graph
                  _buildPriceChart(context),
                  const SizedBox(height: AppTheme.spacing24),
                  // Data table
                  _buildPriceTable(context),
                ],
              ),
          ],
        ),
      ),
    );

  Widget _buildPriceChart(BuildContext context) {
    final data = _getPriceData();
    final dates = _getDates();
    // Compute dynamic Y-axis bounds so lines never go out of bounds
    final combinedValues = <double>[
      ...data.priceSignal,
      ...data.actual.whereType<double>(),
    ];
    // Fallbacks in case of empty data
    final minValue = (combinedValues.isEmpty ? 0.0 : combinedValues.reduce((a, b) => a < b ? a : b));
    final maxValue = (combinedValues.isEmpty ? 1.0 : combinedValues.reduce((a, b) => a > b ? a : b));
    // Add small padding top/bottom
    final padding = (maxValue - minValue).clamp(0.01, 0.05);
    final minY = (minValue - padding).clamp(0.0, double.infinity);
    final maxY = maxValue + padding;
    final yInterval = ((maxY - minY) / 4).clamp(0.005, 0.05);
    
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 0.025,
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
                reservedSize: 50,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < dates.length) {
                    final date = dates[value.toInt()];
                    final formatter = DateFormat('EEE, d MMM');
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        formatter.format(date),
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
                interval: yInterval,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: AppColors.border)),
          minX: 0,
          maxX: 9,
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            // Actual prices (blue solid line)
            LineChartBarData(
              spots: data.actual.asMap().entries
                .where((entry) => entry.value != null)
                .map((entry) => 
                  FlSpot(entry.key.toDouble(), entry.value!)
                ).toList(),
              isCurved: false,
              color: AppColors.primary,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: AppColors.primary,
                  strokeWidth: 1,
                  strokeColor: AppColors.white,
                ),
              ),
            ),
            // Price Signal (purple line - note: fl_chart doesn't support dashed lines,
            // so using a thinner line with different color to differentiate)
            LineChartBarData(
              spots: data.priceSignal.asMap().entries.map((entry) => 
                FlSpot(entry.key.toDouble(), entry.value)
              ).toList(),
              isCurved: false,
              color: Theme.of(context).colorScheme.secondary, // Purple
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Theme.of(context).colorScheme.secondary,
                  strokeWidth: 1,
                  strokeColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTable(BuildContext context) {
    final data = _getTableData();
    final today = DateTime.now();
    
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radius8),
                topRight: Radius.circular(AppTheme.radius8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Price Signal',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          // Data rows
          ...data.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            final isToday = row.date.day == today.day && 
                           row.date.month == today.month &&
                           row.date.year == today.year;
            final formatter = DateFormat('EEE, d MMM');
            
            return Container(
              decoration: BoxDecoration(
                color: isToday ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1) : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.border,
                    width: index < data.length - 1 ? 1 : 0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(AppTheme.spacing12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        Text(
                          formatter.format(row.date),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                              ),
                        ),
                        if (isToday) ...[
                          const SizedBox(width: AppTheme.spacing8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing8,
                              vertical: AppTheme.spacing4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(AppTheme.radius4),
                            ),
                            child: Text(
                              'Today',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.priceSignal != null 
                          ? 'BZ\$${row.priceSignal!.toStringAsFixed(3)}'
                          : '-',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  _PriceData _getPriceData() {
    // Mock data matching the image
    return const _PriceData(
      actual: [0.401, 0.361, 0.417, 0.308, 0.383, 0.307, 0.329, null, null, null],
      priceSignal: [0.364, 0.353, 0.333, 0.327, 0.328, 0.332, 0.353, 0.333, 0.349, 0.364],
    );
  }

  List<DateTime> _getDates() {
    // Dynamic window: 7 days past to 2 days future relative to today
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 7));
    return List.generate(10, (index) => start.add(Duration(days: index)));
  }

  List<_PriceTableRow> _getTableData() {
    final dates = _getDates();
    final priceData = _getPriceData();
    final rows = List.generate(10, (index) => _PriceTableRow(
      date: dates[index],
      priceSignal: priceData.priceSignal[index],
    ));

    // Desired order:
    // +1 day, +2 days, today, then 7 days in the past
    final today = DateTime.now();
    int rank(DateTime d) {
      final diff = d.difference(DateTime(today.year, today.month, today.day)).inDays;
      if (diff == 1) return 0; // tomorrow
      if (diff == 2) return 1; // day after tomorrow
      if (diff == 0) return 2; // today
      if (diff < 0) return 3 + (-diff - 1); // yesterday first, then back 7
      // Any other future days (not expected) push to end preserving order
      return 100 + diff;
    }

    rows.sort((a, b) => rank(a.date).compareTo(rank(b.date)));
    return rows;
  }
}

class _PriceData {
  const _PriceData({
    required this.actual,
    required this.priceSignal,
  });

  final List<double?> actual;
  final List<double> priceSignal;
}

class _PriceTableRow {
  const _PriceTableRow({
    required this.date,
    required this.priceSignal,
  });

  final DateTime date;
  final double? priceSignal;
}

