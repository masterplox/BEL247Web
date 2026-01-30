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
        error: (_, __) => _buildChart(context, thisYearReadings, [], isMobile),
        data: (lastYearReadings) =>
            _buildChart(context, thisYearReadings, lastYearReadings, isMobile),
      ),
    );
  }

  Widget _buildChart(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
    bool isMobile,
  ) {
    // Get year labels
    final thisYearLabel = thisYearReadings.isNotEmpty
        ? thisYearReadings.first.readYear
        : DateTime.now().year.toString();
    final lastYearLabel = lastYearReadings.isNotEmpty
        ? lastYearReadings.first.readYear
        : (int.tryParse(thisYearLabel) ?? DateTime.now().year - 1).toString();

    // Process data for comparison
    final comparisonData = _buildComparisonData(thisYearReadings, lastYearReadings);

    // Prepare chart data based on current view
    final chartData = comparisonData.map((data) {
      final value = _view == 'cost'
          ? (data['costValue2025'] as double)
          : (data['value2025'] as double);
      return FlSpot(
        data['index'] as double,
        value,
      );
    }).toList();

    final lastYearChartData = comparisonData.map((data) {
      final value = _view == 'cost'
          ? (data['costValue2024'] as double)
          : (data['value2024'] as double);
      return FlSpot(
        data['index'] as double,
        value,
      );
    }).toList();

    // Find max value for Y axis
    final maxValue = [
      ...chartData.map((e) => e.y),
      ...lastYearChartData.map((e) => e.y),
    ].fold<double>(0, (max, val) => val > max ? val : max);

    final hasNoData = maxValue == 0;

    if (hasNoData) {
      return _buildEmptyChartCard(context, thisYearLabel, lastYearLabel, isMobile);
    }

    const color2024 = AppColors.chart3; // Gray for previous year
    final color2025 = _view == 'cost' ? AppColors.info : AppColors.success; // Blue for cost, Green for consumption

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
                          '$lastYearLabel vs $thisYearLabel ${_view == 'cost' ? 'costs' : 'consumption'}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildViewToggle(context),
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
                              '$lastYearLabel vs $thisYearLabel ${_view == 'cost' ? 'costs' : 'consumption'}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                        _buildViewToggle(context),
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
                      interval: 2, // Show every other month for cleaner axis (like dashboard)
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < 12) {
                          final monthNames = [
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
                            'Dec'
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              monthNames[index],
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
                        _view == 'cost'
                            ? '\$${value.toStringAsFixed(0)}'
                            : value.toStringAsFixed(0),
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
                maxX: 11,
                minY: 0,
                maxY: maxValue > 0 ? maxValue * 1.1 : 100,
                lineBarsData: [
                  // Last year line
                  LineChartBarData(
                    spots: lastYearChartData,
                    isCurved: true,
                    color: color2024,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 4,
                          color: color2024,
                          strokeWidth: 0,
                        ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // This year line
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    color: color2025,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final isSelected = widget.selectedMonth != null &&
                            comparisonData[index]['month'] == widget.selectedMonth;
                        return FlDotCirclePainter(
                          radius: isSelected ? 6 : 4,
                          color: color2025,
                          strokeWidth: isSelected ? 2 : 0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(context, lastYearLabel, color2024),
              const SizedBox(width: AppTheme.spacing16),
              _buildLegendItem(context, thisYearLabel, color2025),
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
                        _buildViewToggle(context),
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
                        _buildViewToggle(context),
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
          _buildToggleButton(
            context,
            label: r'Cost ($)',
            isSelected: _view == 'cost',
            onTap: () => setState(() => _view = 'cost'),
          ),
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
  ) {
    final monthNames = [
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
      'Dec'
    ];

    return monthNames.asMap().entries.map((entry) {
      final index = entry.key;
      final month = entry.value;

      // Find data for this month in each year
      final thisYearData = thisYearReadings.firstWhere(
        (r) => r.readMonth == month,
        orElse: () => MeterReadingDto(
          readDate: '',
          readMonth: month,
          readYear: '',
          days: '0',
          consumption: '0',
          averageUsage: '0',
          amount: '0',
        ),
      );

      final lastYearData = lastYearReadings.firstWhere(
        (r) => r.readMonth == month,
        orElse: () => MeterReadingDto(
          readDate: '',
          readMonth: month,
          readYear: '',
          days: '0',
          consumption: '0',
          averageUsage: '0',
          amount: '0',
        ),
      );

      return {
        'index': index.toDouble(),
        'month': month,
        'consumption2024': double.tryParse(lastYearData.consumption) ?? 0.0,
        'consumption2025': double.tryParse(thisYearData.consumption) ?? 0.0,
        'cost2024': double.tryParse(lastYearData.amount) ?? 0.0,
        'cost2025': double.tryParse(thisYearData.amount) ?? 0.0,
        'days2024': int.tryParse(lastYearData.days) ?? 0,
        'days2025': int.tryParse(thisYearData.days) ?? 0,
        'avgUsage2024': double.tryParse(lastYearData.averageUsage) ?? 0.0,
        'avgUsage2025': double.tryParse(thisYearData.averageUsage) ?? 0.0,
        'value2024': double.tryParse(lastYearData.consumption) ?? 0.0,
        'value2025': double.tryParse(thisYearData.consumption) ?? 0.0,
        'costValue2024': double.tryParse(lastYearData.amount) ?? 0.0,
        'costValue2025': double.tryParse(thisYearData.amount) ?? 0.0,
      };
    }).toList();
  }
}
