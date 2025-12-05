import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_data_table.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/api_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class EnergyPricesWidget extends StatelessWidget {
  const EnergyPricesWidget({
    super.key,
    this.prices,
    this.isLoading = false,
    this.onRefresh,
  });

  final List<EnergyPricePoint>? prices;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) => AppCard(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              'Energy Prices',
              style: AppTextStyle.title,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: AppTheme.spacing4),
            AppText(
              'Daily electricity rates (2 days future, today, 7 days past)',
              style: AppTextStyle.body,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  // Line graph
                  _buildPriceChart(context),
                  const SizedBox(height: AppTheme.spacing24),
                  // Data table
                  _buildPriceTable(context),
                ],
              ),
      );

  Widget _buildPriceChart(BuildContext context) {
    if (prices == null || prices!.isEmpty) {
      return const SizedBox(height: 250, child: Center(child: Text('No price data available.')));
    }

    final data = _getPriceData();
    final dates = _getDates();
    // Compute dynamic Y-axis bounds so line never goes out of bounds
    final combinedValues = <double>[
      ...data.priceSignal,
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
                      child: AppText(
                        formatter.format(date),
                        style: AppTextStyle.caption,
                        color: AppColors.textSecondary,
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
                getTitlesWidget: (value, meta) => AppText(
                  value.toStringAsFixed(2),
                  style: AppTextStyle.caption,
                  color: AppColors.textSecondary,
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
            // Price Signal (yellow line)
            LineChartBarData(
              spots: data.priceSignal.asMap().entries.map((entry) => 
                FlSpot(entry.key.toDouble(), entry.value)
              ).toList(),
              isCurved: false,
              color: Theme.of(context).colorScheme.secondary, // Yellow
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
    if (prices == null || prices!.isEmpty) {
      return const SizedBox(child: Center(child: Text('No price data available.')));
    }
    final data = _getTableData();
    final today = DateTime.now();
    
    final columns = [
      const DataColumn(label: AppText('Date', style: AppTextStyle.caption, fontWeight: FontWeight.w600)),
      const DataColumn(label: AppText('Price Signal', style: AppTextStyle.caption, fontWeight: FontWeight.w600)),
    ];

    final rows = data.map((row) {
      final isToday = row.date.day == today.day && 
                     row.date.month == today.month &&
                     row.date.year == today.year;
      final formatter = DateFormat('EEE, d MMM');
      
      return DataRow(
        color: isToday ? WidgetStateProperty.all(Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)) : null,
        cells: [
          DataCell(
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: AppColors.textTertiary),
                const SizedBox(width: AppTheme.spacing8),
                AppText(
                  formatter.format(row.date),
                  style: AppTextStyle.caption,
                  fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
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
                    child: AppText(
                      'Today',
                      style: AppTextStyle.caption,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          DataCell(
            AppText(
              row.priceSignal != null 
                  ? 'BZ\$${row.priceSignal!.toStringAsFixed(3)}'
                  : '-',
              style: AppTextStyle.caption,
            ),
          ),
        ],
      );
    }).toList();

    return SizedBox(
      width: double.infinity,
      child: AppDataTable(columns: columns, rows: rows),
    );
  }

  _PriceData _getPriceData() {
    if (prices == null) {
      return const _PriceData(actual: [], priceSignal: []);
    }
    return _PriceData(
      actual: prices!.map((p) => p.actual).toList(),
      priceSignal: prices!.map((p) => p.priceSignal).toList(),
    );
  }

  List<DateTime> _getDates() {
    if (prices == null) {
      return [];
    }
    return prices!.map((p) => p.date).toList();
  }

  List<_PriceTableRow> _getTableData() {
    if (prices == null) {
      return [];
    }
    final rows = prices!
        .map((p) => _PriceTableRow(
              date: p.date,
              priceSignal: p.priceSignal,
            ))
        .toList();

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
    this.priceSignal,
  });

  final DateTime date;
  final double? priceSignal;
}

