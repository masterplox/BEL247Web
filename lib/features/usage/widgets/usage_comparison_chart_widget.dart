import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/meter_readings_providers.dart';

class UsageComparisonChartWidget extends ConsumerStatefulWidget {
  const UsageComparisonChartWidget({
    super.key,
    required this.selectedMonth,
    required this.onMonthSelect,
  });

  final String? selectedMonth;
  final Function(String?) onMonthSelect;

  @override
  ConsumerState<UsageComparisonChartWidget> createState() =>
      _UsageComparisonChartWidgetState();
}

class _UsageComparisonChartWidgetState
    extends ConsumerState<UsageComparisonChartWidget> {
  String _view = 'consumption'; // 'consumption' or 'cost'

  @override
  Widget build(BuildContext context) {
    final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
    final lastYearAsync = ref.watch(meterReadingsLastYearProvider);
    final yearTwoAsync = ref.watch(meterReadingsYearTwoProvider);
    final isMobile = MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;

    return thisYearAsync.when(
      loading: () => const AppCard(
        padding: EdgeInsets.all(AppTheme.spacing24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (thisYearReadings) => lastYearAsync.when(
        loading: () => const AppCard(
          padding: EdgeInsets.all(AppTheme.spacing24),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => _buildChart(context, thisYearReadings, [], [], isMobile),
        data: (lastYearReadings) => yearTwoAsync.when(
          loading: () => const AppCard(
            padding: EdgeInsets.all(AppTheme.spacing24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => _buildChart(context, thisYearReadings, lastYearReadings, [], isMobile),
          data: (yearTwoReadings) =>
              _buildChart(context, thisYearReadings, lastYearReadings, yearTwoReadings, isMobile),
        ),
      ),
    );
  }

  Widget _buildChart(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
  List<MeterReadingDto> yearTwoReadings,
    bool isMobile,
  ) {
    // Get year labels
    final thisYearLabel = thisYearReadings.isNotEmpty
        ? thisYearReadings.first.readYear
        : DateTime.now().year.toString();
    final lastYearLabel = lastYearReadings.isNotEmpty
        ? lastYearReadings.first.readYear
        : (int.tryParse(thisYearLabel) ?? DateTime.now().year - 1).toString();
    final yearTwoLabel = yearTwoReadings.isNotEmpty
        ? yearTwoReadings.first.readYear
        : (int.tryParse(lastYearLabel) ?? DateTime.now().year - 2).toString();

    // Process data for comparison
    final comparisonData = _buildComparisonData(thisYearReadings, lastYearReadings, yearTwoReadings);

    // Prepare chart data based on current view
    final chartData = comparisonData.map((data) {
      final value = _view == 'cost'
          ? (data['costValueCurrent'] as double)
          : (data['valueCurrent'] as double);
      return FlSpot(
        data['index'] as double,
        value,
      );
    }).toList();

    final lastYearChartData = comparisonData.map((data) {
      final value = _view == 'cost'
          ? (data['costValueLast'] as double)
          : (data['valueLast'] as double);
      return FlSpot(
        data['index'] as double,
        value,
      );
    }).toList();

    final yearTwoChartData = comparisonData.map((data) {
      final value = _view == 'cost'
          ? (data['costValueYearTwo'] as double)
          : (data['valueYearTwo'] as double);
      return FlSpot(
        data['index'] as double,
        value,
      );
    }).toList();

    // Find max value for Y axis
    final maxValue = [
      ...chartData.map((e) => e.y),
      ...lastYearChartData.map((e) => e.y),
      ...yearTwoChartData.map((e) => e.y),
    ].fold<double>(0, (max, val) => val > max ? val : max);

    final hasNoData = maxValue == 0;

    if (hasNoData) {
      return _buildEmptyChartCard(context, thisYearLabel, lastYearLabel, isMobile);
    }

    const colorYearTwo = AppColors.chartYearOlder; // Oldest year — subdued vs amber/green
    const colorLastYear = AppColors.chart3; // Previous year
    final colorThisYear = _view == 'cost'
        ? const Color(0xFF1D4ED8) // Slightly deeper blue for cost
        : AppColors.chartThisYearConsumption;

    return AppCard(
      padding: EdgeInsets.all(isMobile ? AppTheme.spacing16 : AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          LayoutBuilder(
            builder: (context, constraints) {
              final headerIsMobile = constraints.maxWidth < 640;
              return headerIsMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Year Comparison',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing4),
                        Text(
                          '$yearTwoLabel · $lastYearLabel · $thisYearLabel on chart. ',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // _buildViewToggle(context),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Year Comparison',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            Text(
                              '$yearTwoLabel · $lastYearLabel · $thisYearLabel on chart. ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // _buildViewToggle(context),
                      ],
                    );
            },
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Chart
          SizedBox(
            height: isMobile ? 240 : 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxValue > 0 ? maxValue / 4 : 1,
                  getDrawingHorizontalLine: (value) => const FlLine(
                    color: AppColors.border,
                    strokeWidth: 1,
                    dashArray: [4, 4],
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
                      // Render ticks at every index, then hide every other label manually.
                      // This avoids fl_chart sometimes starting the "interval" ticks at x=1,
                      // which causes the visible labels to look shifted (e.g. Apr..Mar).
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < comparisonData.length) {
                          if (index.isOdd) return const Text('');
                          final month = comparisonData[index]['month'] as String?;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              month ?? '',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
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
                      interval: maxValue > 0 ? maxValue / 4 : 1,
                      getTitlesWidget: (value, meta) => Text(
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // _view == 'cost'
                        //     ? '\$${value.toStringAsFixed(0)}'
                        //     : value.toStringAsFixed(0),
                        value.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: AppColors.border),
                ),
                minX: 0,
                maxX: (comparisonData.length - 1).toDouble(),
                minY: 0,
                maxY: maxValue > 0 ? maxValue * 1.1 : 100,
                lineBarsData: [
                  // Two years ago line
                  LineChartBarData(
                    spots: yearTwoChartData,
                    isCurved: true,
                    color: colorYearTwo,
                    barWidth: 1.75,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // Last year line
                  LineChartBarData(
                    spots: lastYearChartData,
                    isCurved: true,
                    color: colorLastYear,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 4,
                          color: colorLastYear,
                          strokeWidth: 0,
                        ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // This year line (emphasized)
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    color: colorThisYear,
                    barWidth: 3.25,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final isSelected = widget.selectedMonth != null &&
                            comparisonData[index]['month'] == widget.selectedMonth;
                        return FlDotCirclePainter(
                          radius: isSelected ? 6.5 : 4.5,
                          color: colorThisYear,
                          strokeWidth: isSelected ? 2.5 : 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false, // Disable hover effects
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (_) => [], // No tooltips on hover
                  ),
                  touchCallback: (event, response) {
                    // Only respond to click events, not hover
                    if (event is FlTapUpEvent && response?.lineBarSpots != null) {
                      final spots = response!.lineBarSpots!;
                      if (spots.isNotEmpty) {
                        final spot = spots.first;
                        final index = spot.x.toInt();
                        if (index >= 0 && index < comparisonData.length) {
                          final month = comparisonData[index]['month'] as String;
                          widget.onMonthSelect(month);
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ),

          // Legend
          const SizedBox(height: AppTheme.spacing16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppTheme.spacing16,
            runSpacing: AppTheme.spacing8,
            children: [
              _buildLegendItem(context, yearTwoLabel, colorYearTwo),
              _buildLegendItem(context, lastYearLabel, colorLastYear),
              _buildLegendItem(context, thisYearLabel, colorThisYear),
            ],
          ),

          // Selected Month Indicator
          if (widget.selectedMonth != null) ...[
            const SizedBox(height: AppTheme.spacing16),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.border.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected: ${widget.selectedMonth}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
                  TextButton(
                    onPressed: () => widget.onMonthSelect(null),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
                      minimumSize: const Size(0, 28),
                    ),
                    child: Text(
                      'Clear selection',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyChartCard(
    BuildContext context,
    String thisYearLabel,
    String lastYearLabel,
    bool isMobile,
  ) => AppCard(
      padding: EdgeInsets.all(isMobile ? AppTheme.spacing16 : AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final headerIsMobile = constraints.maxWidth < 640;
              return headerIsMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Year Comparison',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing4),
                        Text(
                          '$lastYearLabel vs $thisYearLabel consumption',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // _buildViewToggle(context),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Year Comparison',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            Text(
                              '$lastYearLabel vs $thisYearLabel consumption',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // _buildViewToggle(context),
                      ],
                    );
            },
          ),
          const SizedBox(height: AppTheme.spacing16),
          SizedBox(
            height: isMobile ? 240 : 300,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.show_chart_outlined,
                      size: 48,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    Text(
                      'No usage data yet',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      'Once you have meter readings for this period, your year comparison will appear here.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  // Dollar amounts are hidden in this version. They will be shown in a future release.
  // ignore: unused_element
  Widget _buildViewToggle(BuildContext context) => Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            context,
            label: 'kWh',
            isSelected: _view == 'consumption',
            onTap: () => setState(() => _view = 'consumption'),
          ),
          // Dollar amounts are hidden in this version. They will be shown in a future release.
          // _buildToggleButton(
          //   context,
          //   label: r'Cost ($)',
          //   isSelected: _view == 'cost',
          //   onTap: () => setState(() => _view = 'cost'),
          // ),
        ],
      ),
    );

  Widget _buildToggleButton(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
                color: isSelected ? AppColors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
        ),
      ),
    );

  Widget _buildLegendItem(BuildContext context, String label, Color color) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppTheme.spacing8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
        ),
      ],
    );

  List<Map<String, dynamic>> _buildComparisonData(
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
  List<MeterReadingDto> yearTwoReadings,
  ) {
    const defaultMonthNames = [
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

    const monthAbbrevs = defaultMonthNames;

    String monthLabelForReading(MeterReadingDto r) {
      final monthFromField = r.readMonth.trim();
      if (monthFromField.isNotEmpty) return monthFromField;

      // Infer month from `readDate` if `readMonth` is missing/empty.
      // Example API format: "3/1/2024 12:00:00 AM" (M/D/YYYY ...).
      final raw = r.readDate.trim();
      if (raw.isEmpty) return '';

      final match = RegExp(r'^\s*(\d{1,2})\s*\/\s*(\d{1,2})\s*\/\s*(\d{4})').firstMatch(raw);
      if (match == null) return '';

      final monthNumber = int.tryParse(match.group(1) ?? '');
      if (monthNumber == null || monthNumber < 1 || monthNumber > 12) return '';
      return monthAbbrevs[monthNumber - 1];
    }

    MeterReadingDto emptyForMonth(String month) => MeterReadingDto(
          readDate: '',
          readMonth: month,
          readYear: '',
          days: '0',
          consumption: '0',
          averageUsage: '0',
          amount: '0.00',
        );

    // Preserve incoming ordering from "this year" readings (e.g. Mar -> ... -> Feb),
    // then align last-year and year-two values to the same index sequence.
    final seen = <String>{};
    final monthNamesInOrder = <String>[];
    for (final r in thisYearReadings) {
      final month = monthLabelForReading(r);
      if (month.isEmpty) continue;
      if (seen.add(month)) monthNamesInOrder.add(month);
    }
    if (monthNamesInOrder.isEmpty) {
      // Extremely defensive fallback: if we can't infer any month labels from the API,
      // use the standard Jan..Dec order.
      monthNamesInOrder.addAll(defaultMonthNames);
    }

    // Build lookup maps using the same month-labeling logic.
    final thisYearByMonth = <String, MeterReadingDto>{};
    for (final r in thisYearReadings) {
      final month = monthLabelForReading(r);
      if (month.isEmpty) continue;
      thisYearByMonth.putIfAbsent(month, () => r);
    }

    final lastYearByMonth = <String, MeterReadingDto>{};
    for (final r in lastYearReadings) {
      final month = monthLabelForReading(r);
      if (month.isEmpty) continue;
      lastYearByMonth.putIfAbsent(month, () => r);
    }

    final yearTwoByMonth = <String, MeterReadingDto>{};
    for (final r in yearTwoReadings) {
      final month = monthLabelForReading(r);
      if (month.isEmpty) continue;
      yearTwoByMonth.putIfAbsent(month, () => r);
    }

    return monthNamesInOrder.asMap().entries.map((entry) {
      final index = entry.key;
      final month = entry.value;

      final thisYearData = thisYearByMonth[month] ?? emptyForMonth(month);
      final lastYearData = lastYearByMonth[month] ?? emptyForMonth(month);
      final yearTwoData = yearTwoByMonth[month] ?? emptyForMonth(month);

      return {
        'index': index.toDouble(),
        'month': month,
        'consumptionYearTwo': double.tryParse(yearTwoData.consumption) ?? 0.0,
        'consumptionLast': double.tryParse(lastYearData.consumption) ?? 0.0,
        'consumptionCurrent': double.tryParse(thisYearData.consumption) ?? 0.0,
        'costYearTwo': double.tryParse(yearTwoData.amount) ?? 0.0,
        'costLast': double.tryParse(lastYearData.amount) ?? 0.0,
        'costCurrent': double.tryParse(thisYearData.amount) ?? 0.0,
        'daysYearTwo': int.tryParse(yearTwoData.days) ?? 0,
        'daysLast': int.tryParse(lastYearData.days) ?? 0,
        'daysCurrent': int.tryParse(thisYearData.days) ?? 0,
        'avgUsageYearTwo': double.tryParse(yearTwoData.averageUsage) ?? 0.0,
        'avgUsageLast': double.tryParse(lastYearData.averageUsage) ?? 0.0,
        'avgUsageCurrent': double.tryParse(thisYearData.averageUsage) ?? 0.0,
        'valueYearTwo': double.tryParse(yearTwoData.consumption) ?? 0.0,
        'valueLast': double.tryParse(lastYearData.consumption) ?? 0.0,
        'valueCurrent': double.tryParse(thisYearData.consumption) ?? 0.0,
        'costValueYearTwo': double.tryParse(yearTwoData.amount) ?? 0.0,
        'costValueLast': double.tryParse(lastYearData.amount) ?? 0.0,
        'costValueCurrent': double.tryParse(thisYearData.amount) ?? 0.0,
      };
    }).toList();
  }
}
