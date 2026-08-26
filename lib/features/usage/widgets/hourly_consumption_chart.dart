import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/widget_builder_utils.dart';
import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../../../core/utils/formatting_utils.dart';

class HourlyConsumptionChart extends ConsumerStatefulWidget {
  const HourlyConsumptionChart({
    super.key,
    this.consumptionData,
    this.isLoading = false,
    this.onDataPointTap,
  });

  final DailyConsumption? consumptionData;
  final bool isLoading;
  final Function(int hour, double kwh)? onDataPointTap;

  @override
  ConsumerState<HourlyConsumptionChart> createState() => _HourlyConsumptionChartState();
}

class _HourlyConsumptionChartState extends ConsumerState<HourlyConsumptionChart> {
  int? _selectedHour;
  bool _showZoomControls = false;
  final double _zoomLevel = 1;
  final double _panOffset = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    if (widget.consumptionData == null) {
      return _buildEmptyState();
    }

    return Stack(
      children: [
        _buildChart(context),
        // Chart controls
        Positioned(
          top: AppTheme.spacing8,
          right: AppTheme.spacing8,
          child: _buildChartControls(),
        ),
      ],
    );
  }

  Widget _buildLoadingState() => Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildEmptyState() => Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart,
                size: 48,
                color: AppColors.textTertiary,
              ),
              SizedBox(height: AppTheme.spacing16),
              Text(
                'No consumption data available',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildChart(BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChartHeader(context),
            const SizedBox(height: AppTheme.spacing16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => LineChart(
                  _buildChartData(context, constraints.maxWidth),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildChartHeader(BuildContext context) => Row(
        children: [
          const Icon(Icons.electrical_services, color: AppColors.primary),
          const SizedBox(width: AppTheme.spacing8),
          Text(
            'Hourly Consumption',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          _buildLegend(),
        ],
      );

  Widget _buildLegend() => Row(
        children: [
          _buildLegendItem('Usage', AppColors.primary),
          const SizedBox(width: AppTheme.spacing16),
          _buildLegendItem('Average', AppColors.textSecondary),
        ],
      );

  Widget _buildLegendItem(String label, Color color) => Row(
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
          const SizedBox(width: AppTheme.spacing4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );

  LineChartData _buildChartData(BuildContext context, double chartWidth) {
    final hourlyData = widget.consumptionData?.hourlyBreakdown ?? [];
    final maxValue = hourlyData.isNotEmpty 
        ? hourlyData.map((h) => h.kwh).reduce((a, b) => a > b ? a : b)
        : 100.0;

    // Calculate responsive interval for x-axis labels based on chart width
    final screenWidth = MediaQuery.of(context).size.width;
    final xAxisInterval = WidgetBuilderUtils.calculateResponsiveInterval(
      screenWidth: screenWidth,
      chartWidth: chartWidth,
      maxValue: 23, // 24 hours (0-23)
      minLabelSpacing: 50,
      defaultInterval: 4,
    );

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: maxValue / 5,
        verticalInterval: 2,
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
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: xAxisInterval,
            getTitlesWidget: (value, meta) {
              final hour = value.toInt();
              return Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: TextStyle(
                  color: _selectedHour == hour ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: _selectedHour == hour ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: maxValue / 5,
            reservedSize: 40,
            getTitlesWidget: (value, meta) => Text(
              '${value.toInt()}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
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
      maxX: 23,
      minY: 0,
      maxY: maxValue * 1.1,
      lineBarsData: [
        _buildUsageLine(hourlyData),
        _buildAverageLine(hourlyData),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: WidgetBuilderUtils.buildLineTooltipData(
          context,
          textColor: AppColors.textPrimary,
          getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
            final hour = spot.x.toInt();
            final kwh = spot.y;
            return LineTooltipItem(
              '$hour:00\n${FormattingUtils.formatKwh(kwh)}',
              const TextStyle(), // Will be styled by buildLineTooltipData
            );
          }).toList(),
        ),
        touchCallback: (event, response) {
          if (response?.lineBarSpots?.isNotEmpty ?? false) {
            final spot = response!.lineBarSpots!.first;
            final hour = spot.x.toInt();
            final kwh = spot.y;
            
            setState(() {
              _selectedHour = hour;
            });
            
            widget.onDataPointTap?.call(hour, kwh);
          }
        },
      ),
    );
  }

  LineChartBarData _buildUsageLine(List<HourlyConsumption> hourlyData) {
    final spots = <FlSpot>[];
    
    for (int i = 0; i < 24; i++) {
      final hourData = hourlyData.firstWhere(
        (h) => h.hour == i,
        orElse: () => HourlyConsumption(hour: i, kwh: 0, cost: 0),
      );
      spots.add(FlSpot(i.toDouble(), hourData.kwh));
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: AppColors.primary,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4,
            color: AppColors.primary,
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
      ),
      belowBarData: BarAreaData(
        show: true,
        color: AppColors.primary.withValues(alpha: 0.1),
      ),
    );
  }

  LineChartBarData _buildAverageLine(List<HourlyConsumption> hourlyData) {
    if (hourlyData.isEmpty) return LineChartBarData(spots: []);

    final average = hourlyData.fold<double>(0, (sum, h) => sum + h.kwh) / hourlyData.length;
    final spots = List.generate(24, (index) => FlSpot(index.toDouble(), average));

    return LineChartBarData(
      spots: spots,
      isCurved: false,
      color: AppColors.textSecondary,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      dashArray: [5, 5],
    );
  }

  Widget _buildChartControls() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                _showZoomControls ? Icons.zoom_out : Icons.zoom_in,
                size: 16,
                color: AppColors.primary,
              ),
              onPressed: () {
                setState(() {
                  _showZoomControls = !_showZoomControls;
                });
              },
              tooltip: _showZoomControls ? 'Hide zoom controls' : 'Show zoom controls',
            ),
            if (_selectedHour != null) ...[
              const SizedBox(width: AppTheme.spacing8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8,
                  vertical: AppTheme.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius4),
                ),
                child: Text(
                  'Selected: ${_selectedHour.toString().padLeft(2, '0')}:00',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
}
