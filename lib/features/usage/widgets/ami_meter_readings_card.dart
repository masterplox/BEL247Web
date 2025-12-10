import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/utils/widget_builder_utils.dart';
import '../../../core/widgets/app_bar_chart.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_switch.dart';
import '../../../core/widgets/app_text.dart';
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
  bool _compareYear = false;
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
      // Reset compare when switching away from year
      if (tab != _UsageTab.year) {
        _compareYear = false;
      }
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
  Widget build(BuildContext context) => AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'AMI Meter Readings',
                  style: AppTextStyle.title,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: AppTheme.spacing4),
                AppText(
                  '1-hour interval energy consumption',
                  style: AppTextStyle.body,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildTabs(context),
          const SizedBox(height: AppTheme.spacing12),
          Row(
            children: [
              Expanded(child: _buildPeriodSelector(context)),
              if (_selected == _UsageTab.year) ...[
                const SizedBox(width: AppTheme.spacing12),
                _buildCompareToggle(),
              ],
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (_selected == _UsageTab.day) ...[
            _buildTouLegend(),
            const SizedBox(height: AppTheme.spacing12),
          ],
          // Chart area
          Container(
            height: 320,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
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
          if (_selected == _UsageTab.year && _compareYear) ...[
            const SizedBox(height: AppTheme.spacing16),
            _buildPreviousYearSummary(),
          ],
        ],
      ),
    );

  Widget _buildTabs(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _tab('Day', _UsageTab.day),
            const SizedBox(width:16),
            _tab('Week', _UsageTab.week),
            const SizedBox(width:16),
            _tab('Month', _UsageTab.month),
            const SizedBox(width:16),
            _tab('Year', _UsageTab.year),
          ],
        ),
      );

  Widget _buildPeriodSelector(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _shiftPeriod(-1),
            splashRadius: 20,
          ),
          GestureDetector(
            onTap: _handlePeriodTap,
            child: AppText(
              _formattedPeriodLabel(),
              style: AppTextStyle.subtitle,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _shiftPeriod(1),
            splashRadius: 20,
          ),
        ],
      );

  Widget _buildCompareToggle() => Column(
        children: [
          const AppText(
            'Compare',
            style: AppTextStyle.caption,
          ),
          AppSwitch(
            value: _compareYear,
            onChanged: (value) {
              setState(() {
                _compareYear = value;
              });
            },
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
          color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: selected ? Theme.of(context).colorScheme.primary : AppColors.border),
        ),
        child: AppText(
          label,
          style: AppTextStyle.body,
          color: selected ? Theme.of(context).colorScheme.onPrimary : AppColors.textSecondary,
          fontWeight: FontWeight.bold,
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
          data: (days) => _DailyChart(days: days, isWeekView: true),
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
          data: (days) => _DailyChart(days: days, isWeekView: false),
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
        final futureProvider = _compareYear
            ? ref.watch(
                dailyConsumptionRangeProvider(
                  (
                    startDate: DateTime(start.year - 1, start.month, start.day),
                    endDate: DateTime(end.year - 1, end.month, end.day),
                  ),
                ),
              )
            : null;
        return rangeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => const Center(child: Text('Failed to load data')),
          data: (days) => _YearlyChart(
            days: days,
            year: _selectedYear,
            previousYearDays: _compareYear ? futureProvider?.value : null,
            showComparison: _compareYear,
          ),
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
          data: (daily) => _SummaryRow(
            daily: daily,
            title: _compareYear ? 'This Year' : null,
          ),
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
          data: (days) => _SummaryRowFromDays(
            days: days,
            title: _compareYear ? 'This Year' : null,
          ),
        );
    }
  }

  Widget _buildPreviousYearSummary() {
    late final DateTime start;
    late final DateTime end;
    final now = DateTime.now();

    switch (_selected) {
      case _UsageTab.day:
        start = DateTime(now.year - 1, _selectedDate.month, _selectedDate.day);
        end = start;
        break;
      case _UsageTab.week:
        start = _selectedWeekStart.subtract(const Duration(days: 365));
        end = _endOfWeek(start);
        break;
      case _UsageTab.month:
        start = DateTime(_selectedMonth.year - 1, _selectedMonth.month, 1);
        end = _endOfMonth(start);
        break;
      case _UsageTab.year:
        start = DateTime(_selectedYear - 1, 1, 1);
        end = DateTime(_selectedYear - 1, 12, 31);
        break;
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Failed to load comparison data')),
      data: (days) => _SummaryRowFromDays(
        days: days,
        title: 'Last Year',
      ),
    );
  }

  Widget _buildTouLegend() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(AppColors.peak, 'Peak'),
            const SizedBox(width: AppTheme.spacing16),
            _legendItem(AppColors.midPeak, 'Mid Peak'),
            const SizedBox(width: AppTheme.spacing16),
            _legendItem(AppColors.offPeak, 'Off Peak'),
          ],
        ),
      );

  Widget _legendItem(Color color, String text) => Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          AppText(
            text,
            style: AppTextStyle.caption,
            color: AppColors.textSecondary,
          ),
        ],
      );
}

class _HourlyChart extends StatelessWidget {
  const _HourlyChart({required this.daily});
  final DailyConsumption daily;

  Color _getTouColorForHour(int hour) {
    if (hour < 11) {
      // Off Peak: midnight to 11am (0-10)
      return AppColors.offPeak.withValues(alpha: 0.25);
    } else if (hour < 21) {
      // Peak: 11am to 9pm (11-20)
      return AppColors.peak.withValues(alpha: 0.25);
    } else {
      // Mid Peak: 9pm to midnight (21-23)
      return AppColors.midPeak.withValues(alpha: 0.25);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hourly = daily.hourlyBreakdown;
    final maxKwh = hourly.isNotEmpty
        ? hourly.map((e) => e.kwh).reduce((a, b) => a > b ? a : b)
        : 8.0;
    final maxY = (maxKwh * 1.2).clamp(6.0, 12.0);
    final groups = List.generate(24, (hour) {
      final value = hourly
          .firstWhere(
            (h) => h.hour == hour,
            orElse: () => HourlyConsumption(hour: hour, kwh: 0, cost: 0),
          )
          .kwh;
      return BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 10,
            borderRadius: BorderRadius.zero,
            color: Theme.of(context).colorScheme.secondary,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: _getTouColorForHour(hour),
            ),
          ),
        ],
      );
    });

    return AppBarChart(
      barChartData: BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceBetween,
        barGroups: groups,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1, // Show all hours
              getTitlesWidget: (value, meta) {
                final hour = value.toInt();
                if (hour >= 0 && hour < 24) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: AppText(
                        _formatHourLabel(hour),
                        style: AppTextStyle.caption,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: WidgetBuilderUtils.buildBarTooltipData(
            context,
            // textColor: AppColors.textPrimary,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final hour = group.x;
              final kwh = rod.toY;
              final cost = kwh * 0.35;
              return BarTooltipItem(
                '${_formatHour(hour)}\nUsage: ${kwh.toStringAsFixed(2)} kWh\nCost: BZ\$${cost.toStringAsFixed(2)}',
                const TextStyle(), // Will be styled by buildBarTooltipData
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

  String _formatHourLabel(int h) {
    final period = h >= 12 ? 'pm' : 'am';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
    return '$hour12$period';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.daily, this.title});
  final DailyConsumption daily;
  final String? title;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppText(
            title!,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing12),
        ],
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isMobile = screenWidth < 768;
            
            if (isMobile) {
              // On mobile, use a 2x2 grid
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _statTile(context, 'Total kWh', total.toStringAsFixed(1), highlighted: true),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: _statTile(context, 'Est. Cost', 'BZ\$${estCost.toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Row(
                    children: [
                      Expanded(
                        child: _statTile(context, 'Peak Usage', '${peak.toStringAsFixed(2)} kWh'),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: _statTile(context, 'Average usage', '${avg.toStringAsFixed(2)} kWh'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // On tablet/desktop, use a single row
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
          },
        ),
      ],
    );
  }

  Widget _statTile(BuildContext context, String label, String value, {bool highlighted = false}) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: highlighted ? AppColors.primaryLight.withValues(alpha: 0.2) : AppColors.grey50,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              label,
              style: AppTextStyle.caption,
            ),
            const SizedBox(height: AppTheme.spacing8),
            AppText(
              value,
              style: AppTextStyle.title,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );

  static Widget _statTileStatic(String label, String value, {bool highlighted = false}) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: highlighted ? AppColors.primaryLight.withValues(alpha: 0.2) : AppColors.grey50,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              label,
              style: AppTextStyle.caption,
            ),
            const SizedBox(height: AppTheme.spacing8),
            AppText(
              value,
              style: AppTextStyle.title,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
}

class _DailyChart extends StatelessWidget {
  const _DailyChart({required this.days, required this.isWeekView});
  final List<DailyConsumption> days;
  final bool isWeekView;

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
            borderRadius: BorderRadius.zero,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      );
    });

    return AppBarChart(
      barChartData: BarChartData(
        maxY: maxY,
        minY: 0,
        alignment: BarChartAlignment.spaceBetween,
        barGroups: groups,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: isWeekView ? 1 : (days.length > 15 ? 2 : 1), // Show every day for week, every 2 days for month if many days
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < days.length) {
                  final date = days[index].date;
                  String label;
                  if (isWeekView) {
                    // Week view: Show day abbreviations (Sun, Mon, Tue, etc.)
                    label = DateFormat('EEE').format(date);
                  } else {
                    // Month view: Show day number (1, 2, 3, etc.)
                    label = date.day.toString();
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: AppText(
                        label,
                        style: AppTextStyle.caption,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: WidgetBuilderUtils.buildBarTooltipData(
            context,
            // textColor: AppColors.textPrimary,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = group.x.toInt();
              final kwh = rod.toY;
              final date = days[idx].date;
              return BarTooltipItem(
                '${date.month}/${date.day}\n${kwh.toStringAsFixed(1)} kWh',
                const TextStyle(), // Will be styled by buildBarTooltipData
              );
            },
          ),
        ),
      ),
    );
  }
}

class _YearlyChart extends StatelessWidget {
  const _YearlyChart({
    required this.days,
    required this.year,
    this.previousYearDays,
    this.showComparison = false,
  });
  final List<DailyConsumption> days;
  final int year;
  final List<DailyConsumption>? previousYearDays;
  final bool showComparison;

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

    final previousMonthlyTotals = List<double>.filled(12, 0);
    if (showComparison && previousYearDays != null) {
      for (final day in previousYearDays!) {
        if (day.date.year == year - 1) {
          previousMonthlyTotals[day.date.month - 1] += day.totalKwh;
        }
      }
    }

    double maxKwh = 0;
    for (final value in monthlyTotals) {
      if (value > maxKwh) {
        maxKwh = value;
      }
    }
    if (showComparison) {
      for (final value in previousMonthlyTotals) {
        if (value > maxKwh) {
          maxKwh = value;
        }
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
      final previousValue =
          showComparison ? previousMonthlyTotals[index] : 0.0;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            width: showComparison ? 8 : 16,
            borderRadius: BorderRadius.zero,
            color: Theme.of(context).colorScheme.secondary,
          ),
          if (showComparison)
            BarChartRodData(
              toY: previousValue,
              width: 8,
              borderRadius: BorderRadius.zero,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
        ],
      );
    });

    return Column(
      children: [
        if (showComparison) ...[
          _buildLegend(context),
          const SizedBox(height: AppTheme.spacing16),
        ],
        Expanded(
          child: AppBarChart(
            barChartData: BarChartData(
              maxY: maxY,
              minY: 0,
              alignment: BarChartAlignment.spaceBetween,
              barGroups: groups,
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final monthIndex = value.toInt();
                      if (monthIndex >= 0 && monthIndex < 12) {
                        // Show month abbreviations (Jan, Feb, Mar, etc.)
                        final monthName = FormattingUtils.getMonthName(monthIndex + 1);
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: AppText(
                              monthName,
                              style: AppTextStyle.caption,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: WidgetBuilderUtils.buildBarTooltipData(
                  context,
                  // textColor: AppColors.textPrimary,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final monthIndex = group.x.toInt();
                    final value = rod.toY;
                    final monthName = DateFormat('MMMM').format(DateTime(year, monthIndex + 1, 1));
                    return BarTooltipItem(
                      '$monthName\n${value.toStringAsFixed(1)} kWh',
                      const TextStyle(), // Will be styled by buildBarTooltipData
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(Theme.of(context).colorScheme.secondary, 'This Year'),
          const SizedBox(width: AppTheme.spacing16),
          _legendItem(Theme.of(context).colorScheme.surfaceContainerHighest, 'Last Year'),
        ],
      );

  Widget _legendItem(Color color, String text) => Row(
        children: [
          Container(
            width: 12,
            height: 12,
            color: color,
          ),
          const SizedBox(width: AppTheme.spacing8),
          AppText(
            text,
            style: AppTextStyle.caption,
            color: AppColors.textSecondary,
          ),
        ],
      );
}

class _SummaryRowFromDays extends StatelessWidget {
  const _SummaryRowFromDays({required this.days, this.title});
  final List<DailyConsumption> days;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      if (title != null) {
        // Show empty state for last year
        return Column(
          children: [
            AppText(
              title!,
              style: AppTextStyle.subtitle,
            ),
            const SizedBox(height: AppTheme.spacing8),
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final isMobile = screenWidth < 768;
                
                if (isMobile) {
                  // On mobile, use a 2x2 grid
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryRow._statTileStatic('Total kWh', 'N/A', highlighted: true),
                          ),
                          const SizedBox(width: AppTheme.spacing12),
                          Expanded(
                            child: _SummaryRow._statTileStatic('Est. Cost', 'N/A'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing12),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryRow._statTileStatic('Peak Usage', 'N/A'),
                          ),
                          const SizedBox(width: AppTheme.spacing12),
                          Expanded(
                            child: _SummaryRow._statTileStatic('Average usage', 'N/A'),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // On tablet/desktop, use a single row
                  return Row(
                    children: [
                      Expanded(child: _SummaryRow._statTileStatic('Total kWh', 'N/A', highlighted: true)),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(child: _SummaryRow._statTileStatic('Est. Cost', 'N/A')),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(child: _SummaryRow._statTileStatic('Peak Usage', 'N/A')),
                      const SizedBox(width: AppTheme.spacing16),
                      Expanded(child: _SummaryRow._statTileStatic('Average usage', 'N/A')),
                    ],
                  );
                }
              },
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    }
    final total = days.fold<double>(0, (sum, d) => sum + d.totalKwh);
    final estCost = total * 0.35;
    final peak = days.map((d) => d.totalKwh).reduce((a, b) => a > b ? a : b);
    final avg = total / days.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppText(
            title!,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing12),
        ],
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isMobile = screenWidth < 768;
            
            if (isMobile) {
              // On mobile, use a 2x2 grid
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryRow._statTileStatic('Total kWh', total.toStringAsFixed(1), highlighted: true),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: _SummaryRow._statTileStatic('Est. Cost', 'BZ\$${estCost.toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryRow._statTileStatic('Peak Usage', '${peak.toStringAsFixed(2)} kWh'),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: _SummaryRow._statTileStatic('Average usage', '${avg.toStringAsFixed(2)} kWh'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // On tablet/desktop, use a single row
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
          },
        ),
      ],
    );
  }
}


