import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/usage_dashboard_cards.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/ami_dashboard_usage_providers.dart'
    show amiDashboardMonthlyTotalsProvider, usageDashboardCardsProvider;
import '../state/billing_period_providers.dart';
import '../../../core/utils/formatting_utils.dart';

/// Dashboard usage trend chart for AMI meters.
///
/// Period plots DailyRangeBucket days in the current billed window. History
/// plots MonthlyTotalsBucket months for the current year.
class AmiConsumptionChartWidget extends ConsumerStatefulWidget {
  const AmiConsumptionChartWidget({super.key});

  @override
  ConsumerState<AmiConsumptionChartWidget> createState() => _AmiConsumptionChartWidgetState();
}

enum _AmiTrendRange { period, history }

class _AmiConsumptionChartWidgetState extends ConsumerState<AmiConsumptionChartWidget> {
  _AmiTrendRange _range = _AmiTrendRange.period;

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(usageDashboardCardsProvider);

    if (_range == _AmiTrendRange.period) {
      final trendAsync = ref.watch(amiBillingPeriodTrendProvider);
      return trendAsync.when(
        loading: () => _buildChartCard(
          context,
          _rangeLabel(cards: cardsAsync.valueOrNull),
          const [],
          chartLoading: true,
        ),
        error: (_, __) => _buildChartCard(
          context,
          _rangeLabel(cards: cardsAsync.valueOrNull),
          const [],
        ),
        data: (rows) => _buildChartCard(
          context,
          _rangeLabel(cards: cardsAsync.valueOrNull),
          _preparePeriodChartDataFromDaily(rows),
        ),
      );
    }

    final historyAsync = ref.watch(amiDashboardMonthlyTotalsProvider);
    return historyAsync.when(
      loading: () => _buildChartCard(
        context,
        _rangeLabel(),
        const [],
        chartLoading: true,
      ),
      error: (_, __) => _buildChartCard(context, _rangeLabel(), const []),
      data: (rows) => _buildChartCard(
        context,
        _rangeLabel(historyRows: rows),
        _prepareHistoryChartDataFromMonthly(rows),
      ),
    );
  }

  Widget _buildChartCard(
    BuildContext context,
    String rangeLabel,
    List<Map<String, dynamic>> chartData, {
    bool chartLoading = false,
  }) {
    final hasData = !_isChartDataEffectivelyEmpty(chartData);
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
                    rangeLabel,
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
            child: chartLoading
                ? const Center(child: CircularProgressIndicator())
                : hasData
                    ? LineChart(_buildLineChartData(chartData))
                    : _buildEmptyChartArea(context),
          ),
          const SizedBox(height: AppTheme.spacing16),
        ],
      ),
    );
  }

  String _rangeLabel({
    UsageDashboardCardsResult? cards,
    List<MonthlyUsageEntryDto>? historyRows,
  }) {
    if (_range == _AmiTrendRange.period) {
      return cards?.currentPeriodLabel.trim() ?? '';
    }

    final year = DateTime.now().year;
    if (historyRows == null) return '$year';
    final months = historyRows
        .where((row) => row.month >= 1 && row.month <= 12 && row.monthlyUsageKwh > 0)
        .length;
    if (months == 0) return '$year';
    return months == 1 ? '1 month in $year' : '$months months in $year';
  }

  bool _isChartDataEffectivelyEmpty(List<Map<String, dynamic>> chartData) =>
      chartData.isEmpty ||
      chartData.every((p) => (p['consumption'] as double) == 0);

  /// Replaces only the line-chart area when there is nothing to plot.
  Widget _buildEmptyChartArea(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insights_outlined,
                size: 44,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Text(
                _range == _AmiTrendRange.history
                    ? 'No monthly usage history yet'
                    : 'No usage data for this period yet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Your usage trend will show here when data is available.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.85),
                      fontSize: 11,
                    ),
              ),
            ],
          ),
        ),
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
              'Period',
              _range == _AmiTrendRange.period,
              () => setState(() => _range = _AmiTrendRange.period),
            ),
            _buildRangeToggleButton(
              context,
              'History',
              _range == _AmiTrendRange.history,
              () => setState(() => _range = _AmiTrendRange.history),
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

  /// One point per month from MonthlyTotalsBucket for the current year.
  List<Map<String, dynamic>> _prepareHistoryChartDataFromMonthly(
    List<MonthlyUsageEntryDto> rows,
  ) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final byMonth = <int, double>{};
    for (final row in rows) {
      if (row.month < 1 || row.month > 12) continue;
      if (row.monthlyUsageKwh <= 0) continue;
      final previous = byMonth[row.month];
      if (previous == null || row.monthlyUsageKwh > previous) {
        byMonth[row.month] = row.monthlyUsageKwh;
      }
    }
    final months = byMonth.keys.toList()..sort();
    return [
      for (final month in months)
        {
          'label': monthNames[month - 1],
          'consumption': byMonth[month] ?? 0.0,
        },
    ];
  }

  /// One point per day from DailyRangeBucket totals.
  List<Map<String, dynamic>> _preparePeriodChartDataFromDaily(
    List<DailyUsageEntryDto> rows,
  ) {
    final byDay = <DateTime, double>{};
    for (final row in rows) {
      final dateStr = row.usageDate.trim().split(RegExp('[T ]')).first;
      final d = DateTime.tryParse(dateStr);
      if (d == null || d.year < 1900) continue;
      final day = DateTime(d.year, d.month, d.day);
      final prev = byDay[day];
      if (prev == null || row.dailyUsageKwh > prev) {
        byDay[day] = row.dailyUsageKwh;
      }
    }

    final days = byDay.keys.toList()..sort();
    return [
      for (final d in days)
        {
          'label': '${d.month}/${d.day}',
          'consumption': byDay[d] ?? 0.0,
        },
    ];
  }

  LineChartData _buildLineChartData(List<Map<String, dynamic>> chartData) {
    final spots = chartData.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final value = entry.value['consumption'] as double;
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
            reservedSize: 54,
            getTitlesWidget: (value, meta) => SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(
                '${value.toInt()}\u00A0kWh',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.right,
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
          getTooltipItems: (touchedBarSpots) => touchedBarSpots.map((barSpot) {
            final index = barSpot.x.toInt();
            if (index >= 0 && index < chartData.length) {
              final consumption = chartData[index]['consumption'] as double;
              final tooltipText = '${FormattingUtils.formatKwh(consumption)}';
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

