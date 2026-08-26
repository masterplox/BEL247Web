import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../data/models/ami_data.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../../../core/utils/formatting_utils.dart';

class AmiDayChart extends StatelessWidget {
  const AmiDayChart({
    super.key,
    required this.data,
    this.selectedHour,
    required this.onSelectHour,
  });

  final List<HourlyData> data;
  final int? selectedHour;
  final Function(int?) onSelectHour;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const AppCard(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insights_outlined,
                size: 44,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: AppTheme.spacing8),
              Text(
                'No data available',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final int xAxisInterval;
    if (width < AppTheme.mobileBreakpoint) {
      xAxisInterval = 6;
    } else if (width < AppTheme.tabletBreakpoint) {
      xAxisInterval = 4;
    } else {
      xAxisInterval = 2;
    }

    // Only real (non-missing) entries contribute to the y-axis scale.
    final maxValue = data
        .where((h) => !h.missing)
        .fold<double>(0, (max, h) => h.kWh > max ? h.kWh : max);
    final safeMaxY = maxValue > 0 ? maxValue * 1.1 : 1.0;

    // Indices of hours with no interval data yet.
    final pendingIndices = data.asMap().entries
        .where((e) => e.value.missing)
        .map((e) => e.key)
        .toList();
    final hasPending = pendingIndices.isNotEmpty;

    return AppCard(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                if (hasPending)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _PendingReadingHatchPainter(
                          pendingIndices: pendingIndices,
                          barCount: data.length,
                        ),
                      ),
                    ),
                  ),
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: safeMaxY,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => AppColors.primary,
                        tooltipRoundedRadius: 8,
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final hour = data[group.x.toInt()];
                          if (hour.missing) return null;
                          final tooltipText = '${FormattingUtils.formatKwh(hour.kWh)}\n${hour.time}';
                          return BarTooltipItem(
                            tooltipText,
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        if (event is FlTapUpEvent && barTouchResponse?.spot != null) {
                          final hourIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
                          if (hourIndex >= 0 && hourIndex < data.length) {
                            if (data[hourIndex].missing) return;
                            onSelectHour(selectedHour == hourIndex ? null : hourIndex);
                          }
                        }
                      },
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
                          interval: xAxisInterval.toDouble(),
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < data.length && index % xAxisInterval == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  data[index].time,
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
                          getTitlesWidget: (value, meta) => Text(
                            '${value.toStringAsFixed(0)} kWh',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: safeMaxY / 5,
                      getDrawingHorizontalLine: (value) => const FlLine(
                        color: AppColors.border,
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: AppColors.border),
                        left: BorderSide(color: AppColors.border),
                      ),
                    ),
                    barGroups: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final hour = entry.value;

                      // Pending (missing) bar — transparent; CustomPainter draws the grey fill.
                      if (hour.missing) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: 0,
                              width: 12,
                              color: AppColors.transparent,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }

                      final isSelected = selectedHour == index;
                      final period = getTimeOfUsePeriod(hour.hour);
                      Color barColor;
                      if (period == TimeOfUse.peak) {
                        barColor = AppColors.info;
                      } else if (period == TimeOfUse.midPeak) {
                        barColor = AppColors.chart3;
                      } else {
                        barColor = AppColors.primary;
                      }

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: hour.kWh,
                            color: isSelected ? barColor : barColor.withValues(alpha: 0.7),
                            width: 12,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          if (hasPending) ...[
            const SizedBox(height: 8),
            _buildPendingDisclaimer(),
          ],
        ],
      ),
    );
  }

  static Widget _buildPendingDisclaimer() => const Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        Icons.schedule_outlined,
        size: 13,
        color: AppColors.textTertiary,
      ),
      SizedBox(width: 5),
      Expanded(
        child: Text(
          'Some usage readings are not ready yet. Your meter data for these times is still being collected and should appear within 1 to 2 days — please check back soon.',
          style: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
}

class _PendingReadingHatchPainter extends CustomPainter {
  const _PendingReadingHatchPainter({
    required this.pendingIndices,
    required this.barCount,
  });

  final List<int> pendingIndices;
  final int barCount;

  static const double _leftReserved = 50.0;
  static const double _bottomReserved = 30.0;
  static const double _barWidth = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (pendingIndices.isEmpty || barCount == 0) return;

    final chartWidth = size.width - _leftReserved;
    final chartHeight = size.height - _bottomReserved;
    final sectionWidth = chartWidth / barCount;

    final fillPaint = Paint()
      ..color = AppColors.grey200
      ..style = PaintingStyle.fill;

    final hatchPaint = Paint()
      ..color = AppColors.grey400.withValues(alpha: 0.55)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (final index in pendingIndices) {
      final centerX = _leftReserved + (index + 0.5) * sectionWidth;
      final left = centerX - _barWidth / 2;
      final right = centerX + _barWidth / 2;

      // Grey fill with rounded top corners
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(left, 0, right, chartHeight),
          topLeft: const Radius.circular(4),
          topRight: const Radius.circular(4),
        ),
        fillPaint,
      );

      // Diagonal hatching lines (45°)
      canvas.save();
      canvas.clipRect(Rect.fromLTRB(left, 0, right, chartHeight));
      const spacing = 4.0;
      for (double d = -chartHeight; d < _barWidth + chartHeight; d += spacing) {
        canvas.drawLine(
          Offset(left + d, 0),
          Offset(left + d + chartHeight, chartHeight),
          hatchPaint,
        );
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PendingReadingHatchPainter old) =>
      old.pendingIndices != pendingIndices || old.barCount != barCount;
}
