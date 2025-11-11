import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

enum _UsageTab { day, week, month, year }

class _AmiMeterReadingsCardState extends ConsumerState<AmiMeterReadingsCard> {
  _UsageTab _selected = _UsageTab.day;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedWeekStart = _startOfWeek(DateTime.now());
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  int _selectedYear = DateTime.now().year;
  final DateFormat _dayFormat = DateFormat('EEE, MMM d, yyyy');
  final DateFormat _rangeFormat = DateFormat('MMM d, yyyy');
  final DateFormat _monthFormat = DateFormat('MMM yyyy');

  DateTime get _normalizedSelectedDate =>
      DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

  static DateTime _startOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final weekday = normalized.weekday % DateTime.daysPerWeek; // Sunday => 0
    return normalized.subtract(Duration(days: weekday));
  }

  static DateTime _endOfWeek(DateTime date) =>
      _startOfWeek(date).add(const Duration(days: 6));

  static DateTime _startOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  static DateTime _endOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);

  void _setSelectedTab(_UsageTab tab) {
    setState(() {
      _selected = tab;
      if (tab == _UsageTab.week) {
        _selectedWeekStart = _startOfWeek(_selectedDate);
      } else if (tab == _UsageTab.month) {
        _selectedMonth = _startOfMonth(_selectedDate);
      } else if (tab == _UsageTab.year) {
        _selectedYear = _selectedDate.year;
      }
    });
  }

  void _shiftPeriod(int delta) {
    setState(() {
      switch (_selected) {
        case _UsageTab.day:
          _selectedDate = _normalizedSelectedDate.add(Duration(days: delta));
          _selectedWeekStart = _startOfWeek(_selectedDate);
          _selectedMonth = _startOfMonth(_selectedDate);
          _selectedYear = _selectedDate.year;
          break;
        case _UsageTab.week:
          _selectedWeekStart =
              _selectedWeekStart.add(Duration(days: 7 * delta));
          _selectedDate = _selectedWeekStart;
          _selectedMonth = _startOfMonth(_selectedWeekStart);
          _selectedYear = _selectedWeekStart.year;
          break;
        case _UsageTab.month:
          _selectedMonth = DateTime(
            _selectedMonth.year,
            _selectedMonth.month + delta,
            1,
          );
          _selectedDate = _selectedMonth;
          _selectedWeekStart = _startOfWeek(_selectedMonth);
          _selectedYear = _selectedMonth.year;
          break;
        case _UsageTab.year:
          _selectedYear += delta;
          _selectedMonth = DateTime(_selectedYear, _selectedMonth.month, 1);
          _selectedDate = _selectedMonth;
          _selectedWeekStart = _startOfWeek(_selectedMonth);
          break;
      }
    });
  }

  String _formattedPeriodLabel() {
    switch (_selected) {
      case _UsageTab.day:
        return _dayFormat.format(_normalizedSelectedDate);
      case _UsageTab.week:
        final start = _selectedWeekStart;
        final end = _endOfWeek(_selectedWeekStart);
        return '${_rangeFormat.format(start)} - ${_rangeFormat.format(end)}';
      case _UsageTab.month:
        return _monthFormat.format(_selectedMonth);
      case _UsageTab.year:
        return '$_selectedYear';
    }
  }

  Future<void> _handlePeriodTap() async {
    switch (_selected) {
      case _UsageTab.day:
        final picked = await showDatePicker(
          context: context,
          initialDate: _normalizedSelectedDate,
          firstDate: DateTime(2020, 1, 1),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = DateTime(picked.year, picked.month, picked.day);
            _selectedWeekStart = _startOfWeek(_selectedDate);
            _selectedMonth = _startOfMonth(_selectedDate);
            _selectedYear = _selectedDate.year;
          });
        }
        break;
      case _UsageTab.week:
        final initialRange = DateTimeRange(
          start: _selectedWeekStart,
          end: _endOfWeek(_selectedWeekStart),
        );
        final pickedRange = await showDateRangePicker(
          context: context,
          initialDateRange: initialRange,
          firstDate: DateTime(2020, 1, 1),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedRange != null) {
          setState(() {
            _selectedWeekStart = _startOfWeek(pickedRange.start);
            _selectedDate = _selectedWeekStart;
            _selectedMonth = _startOfMonth(_selectedWeekStart);
            _selectedYear = _selectedWeekStart.year;
          });
        }
        break;
      case _UsageTab.month:
        final pickedMonth = await showDatePicker(
          context: context,
          initialDate: _selectedMonth,
          firstDate: DateTime(2020, 1, 1),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
          initialDatePickerMode: DatePickerMode.year,
        );
        if (pickedMonth != null) {
          setState(() {
            _selectedMonth = _startOfMonth(pickedMonth);
            _selectedDate = _selectedMonth;
            _selectedWeekStart = _startOfWeek(_selectedMonth);
            _selectedYear = _selectedMonth.year;
          });
        }
        break;
      case _UsageTab.year:
        final pickedYear = await showDatePicker(
          context: context,
          initialDate: DateTime(_selectedYear, 1, 1),
          firstDate: DateTime(2020, 1, 1),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
          initialDatePickerMode: DatePickerMode.year,
        );
        if (pickedYear != null) {
          setState(() {
            _selectedYear = pickedYear.year;
            _selectedMonth = DateTime(_selectedYear, _selectedMonth.month, 1);
            _selectedDate = _selectedMonth;
            _selectedWeekStart = _startOfWeek(_selectedMonth);
          });
        }
        break;
    }
  }

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
              const SizedBox(height: AppTheme.spacing12),
            _buildPeriodSelector(context),
              const SizedBox(height: AppTheme.spacing12),
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
          _tab('Day', _UsageTab.day),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Week', _UsageTab.week),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Month', _UsageTab.month),
          const SizedBox(width: AppTheme.spacing8),
          _tab('Year', _UsageTab.year),
        ],
      );

  Widget _buildPeriodSelector(BuildContext context) => Row(
        children: [
          IconButton(
            onPressed: () => _shiftPeriod(-1),
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: InkWell(
              onTap: _handlePeriodTap,
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                  vertical: AppTheme.spacing12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Text(
                    _formattedPeriodLabel(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _shiftPeriod(1),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      );

  Widget _tab(String label, _UsageTab tab) {
    final selected = _selected == tab;
    return GestureDetector(
      onTap: () => _setSelectedTab(tab),
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

  Widget _buildChart(BuildContext context) {
    switch (_selected) {
      case _UsageTab.day:
        final dailyAsync = ref.watch(dailyConsumptionProvider(_normalizedSelectedDate));
        return dailyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (daily) => _HourlyChart(daily: daily),
        );
      case _UsageTab.week:
        final start = _selectedWeekStart;
        final end = _endOfWeek(_selectedWeekStart);
        final rangeAsync = ref.watch(
          dailyConsumptionRangeProvider(
            (
              startDate: DateTime(start.year, start.month, start.day),
              endDate: DateTime(end.year, end.month, end.day),
            ),
          ),
        );
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _DailyChart(days: days),
        );
      case _UsageTab.month:
        final start = _startOfMonth(_selectedMonth);
        final end = _endOfMonth(_selectedMonth);
        final rangeAsync = ref.watch(
          dailyConsumptionRangeProvider(
            (
              startDate: DateTime(start.year, start.month, start.day),
              endDate: DateTime(end.year, end.month, end.day),
            ),
          ),
        );
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _DailyChart(days: days),
        );
      case _UsageTab.year:
        final start = DateTime(_selectedYear, 1, 1);
        final end = DateTime(_selectedYear, 12, 31);
        final rangeAsync = ref.watch(
          dailyConsumptionRangeProvider(
            (
              startDate: start,
              endDate: end,
            ),
          ),
        );
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _YearlyChart(days: days, year: _selectedYear),
        );
    }
  }

  Widget _buildSummary() {
    switch (_selected) {
      case _UsageTab.day:
        final dailyAsync = ref.watch(dailyConsumptionProvider(_normalizedSelectedDate));
        return dailyAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (daily) => _SummaryRow(daily: daily),
        );
      case _UsageTab.week:
      case _UsageTab.month:
      case _UsageTab.year:
        late final DateTime start;
        late final DateTime end;
        if (_selected == _UsageTab.week) {
          start = _selectedWeekStart;
          end = _endOfWeek(_selectedWeekStart);
        } else if (_selected == _UsageTab.month) {
          start = _startOfMonth(_selectedMonth);
          end = _endOfMonth(_selectedMonth);
        } else {
          start = DateTime(_selectedYear, 1, 1);
          end = DateTime(_selectedYear, 12, 31);
        }
        final rangeAsync = ref.watch(
          dailyConsumptionRangeProvider(
            (
              startDate: DateTime(start.year, start.month, start.day),
              endDate: DateTime(end.year, end.month, end.day),
            ),
          ),
        );
        return rangeAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
          data: (days) => _SummaryRowFromDays(days: days),
        );
    }
  }
}

class _HourlyChart extends StatelessWidget {
  const _HourlyChart({required this.daily});
  final DailyConsumption daily;

  @override
  Widget build(BuildContext context) {
    final hourly = daily.hourlyBreakdown;
    final maxKwh = hourly.isNotEmpty ? hourly.map((e) => e.kwh).reduce((a, b) => a > b ? a : b) : 8.0;
    final maxY = (maxKwh * 1.2).clamp(6.0, 12.0);
    final groups = List.generate(24, (hour) {
      final value = hourly.firstWhere(
        (h) => h.hour == hour,
        orElse: () => HourlyConsumption(hour: hour, kwh: 0, cost: 0),
      ).kwh;
      return BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 10,
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF06B6D4),
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceBetween,
        barGroups: groups,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: (maxY / 4).clamp(1.0, 4.0),
          getDrawingHorizontalLine: (value) => const FlLine(
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
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: (maxY / 4).clamp(1.0, 4.0),
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: AppTheme.radius8,
            tooltipPadding: const EdgeInsets.all(AppTheme.spacing8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final hour = group.x;
              final kwh = rod.toY;
              final cost = kwh * 0.35;
              return BarTooltipItem(
                '${_formatHour(hour)}\nUsage: ${kwh.toStringAsFixed(2)} kWh\nCost: BZ\$${cost.toStringAsFixed(2)}',
                const TextStyle(color: AppColors.textPrimary),
              );
            },
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
    final maxKwh = days.map((d) => d.totalKwh).reduce((a, b) => a > b ? a : b);
    final maxY = (maxKwh * 1.2).clamp(20.0, 120.0);
    final groups = List.generate(days.length, (index) {
      final value = days[index].totalKwh;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 10,
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF06B6D4),
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceBetween,
        barGroups: groups,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: (maxY / 5).clamp(5.0, 25.0),
          getDrawingHorizontalLine: (value) => const FlLine(
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
              reservedSize: 28,
              interval: (days.length / 6).clamp(1, 6).toDouble(),
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) {
                  return const SizedBox.shrink();
                }
                final d = days[idx].date;
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    '${d.day}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              interval: (maxY / 5).clamp(5.0, 25.0),
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: AppTheme.radius8,
            tooltipPadding: const EdgeInsets.all(AppTheme.spacing8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = group.x.toInt();
              final kwh = rod.toY;
              final date = days[idx].date;
              return BarTooltipItem(
                '${date.month}/${date.day}\n${kwh.toStringAsFixed(1)} kWh',
                const TextStyle(color: AppColors.textPrimary),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _YearlyChart extends StatelessWidget {
  const _YearlyChart({required this.days, required this.year});
  final List<DailyConsumption> days;
  final int year;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final monthlyTotals = List<double>.filled(12, 0);
    for (final day in days) {
      if (day.date.year == year) {
        monthlyTotals[day.date.month - 1] += day.totalKwh;
      }
    }

    double maxKwh = 0;
    for (final value in monthlyTotals) {
      if (value > maxKwh) {
        maxKwh = value;
      }
    }
    double maxY = maxKwh * 1.2;
    if (maxY <= 0) {
      maxY = 1;
    } else if (maxY < 20) {
      maxY = 20;
    }

    final groups = List.generate(12, (index) {
      final value = monthlyTotals[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 16,
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF06B6D4),
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceBetween,
        barGroups: groups,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: (maxY / 5).clamp(10.0, maxY),
          getDrawingHorizontalLine: (value) => const FlLine(
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
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                const monthLabels = [
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
                final index = value.toInt();
                if (index < 0 || index >= monthLabels.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    monthLabels[index],
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              interval: (maxY / 5).clamp(10.0, maxY),
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.border),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: AppTheme.radius8,
            tooltipPadding: const EdgeInsets.all(AppTheme.spacing8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final monthIndex = group.x.toInt();
              final value = rod.toY;
              final monthName = DateFormat('MMMM').format(DateTime(year, monthIndex + 1, 1));
              return BarTooltipItem(
                '$monthName\n${value.toStringAsFixed(1)} kWh',
                const TextStyle(color: AppColors.textPrimary),
              );
            },
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


