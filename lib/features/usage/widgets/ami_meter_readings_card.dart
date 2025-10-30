import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/consumption_providers.dart';

/// AMI Meter Readings card matching the provided design
class AmiMeterReadingsCard extends ConsumerStatefulWidget {
  const AmiMeterReadingsCard({super.key});

  @override
  ConsumerState<AmiMeterReadingsCard> createState() => _AmiMeterReadingsCardState();
}

enum _UsageTab { today, hourly, last7Days, month, custom }

class _AmiMeterReadingsCardState extends ConsumerState<AmiMeterReadingsCard> {
  _UsageTab _selected = _UsageTab.today;
  DateTimeRange? _customRange;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AMI Meter Readings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    '1-hour interval energy consumption',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            _buildTabs(context),
            if (_selected == _UsageTab.custom) ...[
              const SizedBox(height: AppTheme.spacing12),
              _buildCustomRangeControls(context),
              const SizedBox(height: AppTheme.spacing12),
            ] else ...[
              const SizedBox(height: AppTheme.spacing12),
            ],
            // Chart area
            Container(
              height: 320,
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: _buildChart(context),
            ),
            const SizedBox(height: AppTheme.spacing16),
            // Summary row
            _buildSummary(),
          ],
        ),
      ),
    );

  Widget _buildTabs(BuildContext context) => Row(
        children: [
          _tab('Today', _UsageTab.today),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Hourly', _UsageTab.hourly),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Last 7 Days', _UsageTab.last7Days),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Month', _UsageTab.month),
          const SizedBox(width: AppTheme.spacing8),
          _tabWithIcon('Custom Range', _UsageTab.custom, Icons.calendar_today),
        ],
      );

  Widget _tab(String label, _UsageTab tab) {
    final selected = _selected == tab;
    return GestureDetector(
      onTap: () async {
        if (tab == _UsageTab.custom) {
          setState(() => _selected = tab);
        } else {
          setState(() => _selected = tab);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected ? AppColors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildCustomRangeControls(BuildContext context) => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _openRangePicker,
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Start date',
                    prefixIcon: Icon(Icons.calendar_today, size: 18),
                    hintText: 'Select start',
                  ),
                  controller: TextEditingController(
                    text: _customRange == null
                        ? ''
                        : '${_customRange!.start.year}-${_two(_customRange!.start.month)}-${_two(_customRange!.start.day)}',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          Expanded(
            child: GestureDetector(
              onTap: _openRangePicker,
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'End date',
                    prefixIcon: Icon(Icons.calendar_today, size: 18),
                    hintText: 'Select end',
                  ),
                  controller: TextEditingController(
                    text: _customRange == null
                        ? ''
                        : '${_customRange!.end.year}-${_two(_customRange!.end.month)}-${_two(_customRange!.end.day)}',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          OutlinedButton.icon(
            onPressed: _openRangePicker,
            icon: const Icon(Icons.date_range, size: 18),
            label: const Text('Pick dates'),
          ),
        ],
      );

  Future<void> _openRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _customRange,
    );
    if (picked != null) {
      setState(() => _customRange = picked);
    }
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  Widget _buildChart(BuildContext context) {
    switch (_selected) {
      case _UsageTab.today:
      case _UsageTab.hourly:
        final dailyAsync = ref.watch(currentConsumptionProvider);
        return dailyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (daily) => _HourlyChart(daily: daily),
        );
      case _UsageTab.last7Days:
        final end = DateTime.now();
        final start = end.subtract(const Duration(days: 6));
        final rangeAsync = ref.watch(dailyConsumptionRangeProvider((startDate: DateTime(start.year, start.month, start.day), endDate: DateTime(end.year, end.month, end.day))));
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _DailyChart(days: days),
        );
      case _UsageTab.month:
        final end = DateTime.now();
        final start = end.subtract(const Duration(days: 29));
        final rangeAsync = ref.watch(dailyConsumptionRangeProvider((startDate: DateTime(start.year, start.month, start.day), endDate: DateTime(end.year, end.month, end.day))));
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _DailyChart(days: days),
        );
      case _UsageTab.custom:
        if (_customRange == null) {
          return const Center(child: Text('Choose a date range'));
        }
        final rangeAsync = ref.watch(dailyConsumptionRangeProvider((startDate: DateTime(_customRange!.start.year, _customRange!.start.month, _customRange!.start.day), endDate: DateTime(_customRange!.end.year, _customRange!.end.month, _customRange!.end.day))));
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _DailyChart(days: days),
        );
    }
  }

  Widget _buildSummary() {
    switch (_selected) {
      case _UsageTab.today:
      case _UsageTab.hourly:
        final dailyAsync = ref.watch(currentConsumptionProvider);
        return dailyAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (daily) => _SummaryRow(daily: daily),
        );
      case _UsageTab.last7Days:
      case _UsageTab.month:
      case _UsageTab.custom:
        DateTimeRange range;
        if (_selected == _UsageTab.last7Days) {
          final end = DateTime.now();
          final start = end.subtract(const Duration(days: 6));
          range = DateTimeRange(start: start, end: end);
        } else if (_selected == _UsageTab.month) {
          final end = DateTime.now();
          final start = end.subtract(const Duration(days: 29));
          range = DateTimeRange(start: start, end: end);
        } else {
          if (_customRange == null) return const SizedBox.shrink();
          range = _customRange!;
        }
        final rangeAsync = ref.watch(dailyConsumptionRangeProvider((startDate: DateTime(range.start.year, range.start.month, range.start.day), endDate: DateTime(range.end.year, range.end.month, range.end.day))));
        return rangeAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (days) => _SummaryRowFromDays(days: days),
        );
    }
  }

  Widget _tabWithIcon(String label, _UsageTab tab, IconData icon) {
    final selected = _selected == tab;
    return GestureDetector(
      onTap: () => setState(() => _selected = tab),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: selected ? AppColors.white : AppColors.textSecondary),
            const SizedBox(width: AppTheme.spacing8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected ? AppColors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourlyChart extends StatelessWidget {
  const _HourlyChart({required this.daily});
  final DailyConsumption daily;

  @override
  Widget build(BuildContext context) {
    final hourly = daily.hourlyBreakdown;
    final maxKwh = hourly.isNotEmpty ? hourly.map((e) => e.kwh).reduce((a, b) => a > b ? a : b) : 8.0;
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: 1.6,
          getDrawingHorizontalLine: (v) => const FlLine(color: AppColors.border, strokeWidth: 1),
          getDrawingVerticalLine: (v) => const FlLine(color: AppColors.border, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: 3,
              getTitlesWidget: (value, meta) {
                final hour = value.toInt();
                final label = hour == 0
                    ? '12:00 am'
                    : hour == 3
                        ? '03:00 am'
                        : hour == 6
                            ? '06:00 am'
                            : hour == 9
                                ? '09:00 am'
                                : hour == 12
                                    ? '12:00 pm'
                                    : hour == 15
                                        ? '03:00 pm'
                                        : hour == 18
                                            ? '06:00 pm'
                                            : hour == 21
                                                ? '09:00 pm'
                                                : '';
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (maxKwh / 4).clamp(1, 4),
              reservedSize: 28,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border),
        ),
        minX: 0,
        maxX: 23,
        minY: 0,
        maxY: (maxKwh * 1.2).clamp(8, 10),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(24, (i) => FlSpot(i.toDouble(),
                hourly.firstWhere((h) => h.hour == i, orElse: () => HourlyConsumption(hour: i, kwh: 0, cost: 0)).kwh)),
            isCurved: true,
            color: const Color(0xFF06B6D4),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 3,
                color: const Color(0xFF06B6D4),
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touched) => touched.map((s) {
              final h = s.x.toInt();
              final kwh = s.y;
              final cost = kwh * 0.35; // for display only
              return LineTooltipItem(
                '${_formatHour(h)}\nUsage: ${kwh.toStringAsFixed(2)} kWh\nCost: BZ\$${cost.toStringAsFixed(2)}',
                const TextStyle(color: AppColors.textPrimary),
              );
            }).toList(),
            tooltipRoundedRadius: AppTheme.radius8,
            tooltipPadding: const EdgeInsets.all(AppTheme.spacing8),
          ),
        ),
      ),
    );
  }

  String _formatHour(int h) {
    final period = h >= 12 ? 'pm' : 'am';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
    return '${hour12.toString().padLeft(2, '0')}:00 $period';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.daily});
  final DailyConsumption daily;

  @override
  Widget build(BuildContext context) {
    final total = daily.totalKwh;
    final estCost = total * 0.35; // to match screenshot scale
    final peak = daily.peakHourlyUsage == 0
        ? daily.hourlyBreakdown.map((h) => h.kwh).reduce((a, b) => a > b ? a : b)
        : daily.peakHourlyUsage;
    final avg = daily.averageHourlyUsage == 0
        ? daily.totalKwh / 24
        : daily.averageHourlyUsage;

    return Row(
      children: [
        Expanded(child: _statTile(context, 'Total kWh', total.toStringAsFixed(1), highlighted: true)),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _statTile(context, 'Est. Cost', 'BZ\$${estCost.toStringAsFixed(2)}')),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _statTile(context, 'Peak Usage', '${peak.toStringAsFixed(2)} kWh')),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _statTile(context, 'Average usage', '${avg.toStringAsFixed(2)} kWh')),
      ],
    );
  }

  Widget _statTile(BuildContext context, String label, String value, {bool highlighted = false}) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: highlighted ? AppColors.primaryLight.withOpacity(0.2) : AppColors.grey50,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
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
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      );

  static Widget _statTileStatic(String label, String value, {bool highlighted = false}) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: highlighted ? AppColors.primaryLight.withOpacity(0.2) : AppColors.grey50,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
}

class _DailyChart extends StatelessWidget {
  const _DailyChart({required this.days});
  final List<DailyConsumption> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return const Center(child: Text('No data'));
    }
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (v) => const FlLine(color: AppColors.border, strokeWidth: 1),
          getDrawingVerticalLine: (v) => const FlLine(color: AppColors.border, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: (days.length / 6).clamp(1, 6).toDouble(),
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox.shrink();
                final d = days[idx].date;
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text('${d.day}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: 10,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: true, border: Border.all(color: AppColors.border)),
        minX: 0,
        maxX: (days.length - 1).toDouble(),
        minY: 0,
        maxY: (days.map((d) => d.totalKwh).reduce((a, b) => a > b ? a : b) * 1.2).clamp(20, 100),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(days.length, (i) => FlSpot(i.toDouble(), days[i].totalKwh)),
            isCurved: true,
            color: const Color(0xFF06B6D4),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: const Color(0xFF06B6D4).withOpacity(0.08)),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touched) => touched.map((s) {
              final idx = s.x.toInt();
              final kwh = s.y;
              return LineTooltipItem(
                '${days[idx].date.month}/${days[idx].date.day}: ${kwh.toStringAsFixed(1)} kWh',
                const TextStyle(color: AppColors.textPrimary),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _SummaryRowFromDays extends StatelessWidget {
  const _SummaryRowFromDays({required this.days});
  final List<DailyConsumption> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) return const SizedBox.shrink();
    final total = days.fold<double>(0, (sum, d) => sum + d.totalKwh);
    final estCost = total * 0.35;
    final peak = days.map((d) => d.totalKwh).reduce((a, b) => a > b ? a : b);
    final avg = total / days.length;
    return Row(
      children: [
        Expanded(child: _SummaryRow._statTileStatic('Total kWh', total.toStringAsFixed(1), highlighted: true)),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _SummaryRow._statTileStatic('Est. Cost', 'BZ\$${estCost.toStringAsFixed(2)}')),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _SummaryRow._statTileStatic('Peak Usage', '${peak.toStringAsFixed(2)} kWh')),
        const SizedBox(width: AppTheme.spacing16),
        Expanded(child: _SummaryRow._statTileStatic('Average usage', '${avg.toStringAsFixed(2)} kWh')),
      ],
    );
  }
}


