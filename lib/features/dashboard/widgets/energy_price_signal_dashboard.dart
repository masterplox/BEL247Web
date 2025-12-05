import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/api_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class EnergyPriceSignalDashboard extends StatefulWidget {
  const EnergyPriceSignalDashboard({
    super.key,
    required this.prices,
    this.isLoading = false,
    this.onRefresh,
  });

  final List<EnergyPricePoint>? prices;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  State<EnergyPriceSignalDashboard> createState() =>
      _EnergyPriceSignalDashboardState();
}

class _EnergyPriceSignalDashboardState extends State<EnergyPriceSignalDashboard> {
  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.prices == null || widget.prices!.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing32),
          child: AppText('No price data available.'),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < AppTheme.tabletBreakpoint;
        final isTablet = constraints.maxWidth >= AppTheme.tabletBreakpoint &&
            constraints.maxWidth < AppTheme.desktopBreakpoint;

        return SingleChildScrollView(
          padding: EdgeInsets.all(
            isMobile ? AppTheme.spacing16 : AppTheme.spacing24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tier 1: Today Hero Section
              _buildTodayHeroSection(context, isMobile),
              SizedBox(height: isMobile ? AppTheme.spacing16 : AppTheme.spacing24),
              
              // Tier 2: 10-Day Price Trend Chart
              if (isMobile)
                _buildMobileChartToggle()
              else
                const SizedBox.shrink(),
              if (!isMobile || _showChart)
                _buildTenDayChart(context, isMobile, isTablet),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodayHeroSection(BuildContext context, bool isMobile) {
    final todayData = _getTodayData();
    if (todayData == null) {
      return const SizedBox.shrink();
    }

    final currentPrice = todayData.price;
    final priceColor = _getPriceColor(currentPrice);
    final currentHour = DateTime.now().hour;
    final touPeriod = _getTouPeriodForHour(currentHour);
    final lastUpdated = DateTime.now();

    return AppCard(
      // color: priceColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      'Current Price',
                      style: AppTextStyle.body,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          r'BZ$',
                          style: AppTextStyle.title,
                          color: priceColor,
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        Text(
                          currentPrice.toStringAsFixed(3),
                          style: TextStyle(
                            fontSize: isMobile ? 48 : 64,
                            fontWeight: FontWeight.bold,
                            color: priceColor,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildPeakBadge(touPeriod),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppTheme.spacing8),
              AppText(
                'Updated at ${DateFormat('h:mm a').format(lastUpdated)}',
                style: AppTextStyle.caption,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeakBadge(_TouPeriod period) {
    final (label, color) = switch (period) {
      _TouPeriod.peak => ('PEAK', AppColors.peak),
      _TouPeriod.midPeak => ('MID-PEAK', AppColors.midPeak),
      _TouPeriod.offPeak => ('OFF-PEAK', AppColors.offPeak),
    };
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
      ),
      child: AppText(
        label,
        style: AppTextStyle.caption,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildMobileChartToggle() => AppCard(
      child: InkWell(
        onTap: () => setState(() => _showChart = !_showChart),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText(
              '10-Day Price Trend',
              style: AppTextStyle.title,
              fontWeight: FontWeight.bold,
            ),
            Icon(
              _showChart ? Icons.expand_less : Icons.expand_more,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );

  Widget _buildTenDayChart(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final chartData = _getChartData();
    if (chartData.isEmpty) {
      return const SizedBox.shrink();
    }

    final prices = chartData.map((d) => d.price).toList();
    final dates = chartData.map((d) => d.date).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final padding = (maxPrice - minPrice) * 0.1;
    final minY = (minPrice - padding).clamp(0.0, double.infinity);
    final maxY = maxPrice + padding;

    final todayIndex = _getTodayIndex();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            '10-Day Price Trend',
            style: AppTextStyle.title,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppTheme.spacing16),
          SizedBox(
            height: isMobile ? 250 : isTablet ? 300 : 350,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: (maxY - minY) / 4,
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
                      reservedSize: 50,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < dates.length) {
                          final date = dates[index];
                          final formatter = DateFormat('EEE\nd MMM');
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: AppText(
                                formatter.format(date),
                                style: AppTextStyle.caption,
                                color: index == todayIndex
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: index == todayIndex
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
                      interval: (maxY - minY) / 4,
                      getTitlesWidget: (value, meta) => AppText(
                        value.toStringAsFixed(2),
                        style: AppTextStyle.caption,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: AppColors.border),
                ),
                minX: 0,
                maxX: (prices.length - 1).toDouble(),
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: prices.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value)).toList(),
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        final isPeak = _isPeakPoint(prices, index);
                        final isMin = _isMinPoint(prices, index);
                        return FlDotCirclePainter(
                          radius: (isPeak || isMin) ? 5 : 3,
                          color: (isPeak || isMin)
                              ? AppColors.peak
                              : AppColors.primary,
                          strokeWidth: 2,
                          strokeColor: AppColors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _getPriceColor(prices.last).withOpacity(0.3),
                          _getPriceColor(prices.first).withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppColors.grey800,
                    tooltipRoundedRadius: AppTheme.radius8,
                    tooltipPadding: const EdgeInsets.all(AppTheme.spacing8),
                    tooltipMargin: 8,
                    getTooltipItems: (touchedSpots) => touchedSpots.map((touchedSpot) {
                        final index = touchedSpot.x.toInt();
                        if (index >= 0 && index < prices.length) {
                          return LineTooltipItem(
                            'BZ\$${prices[index].toStringAsFixed(3)}\n${DateFormat('MMM d').format(dates[index])}',
                            const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }
                        return null;
                      }).toList(),
                  ),
                  handleBuiltInTouches: true,
                  getTouchLineStart: (data, index) => 0,
                  getTouchLineEnd: (data, index) => double.infinity,
                ),
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    if (todayIndex != null)
                      VerticalLine(
                        x: todayIndex.toDouble(),
                        color: AppColors.primary.withOpacity(0.3),
                        strokeWidth: 2,
                        dashArray: [5, 5],
                        label: VerticalLineLabel(
                          show: true,
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(bottom: 4),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          labelResolver: (line) => 'Today',
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  _TodayData? _getTodayData() {
    if (widget.prices == null || widget.prices!.isEmpty) return null;
    final today = DateTime.now();
    final todayPrice = widget.prices!.firstWhere(
      (p) => p.date.year == today.year &&
          p.date.month == today.month &&
          p.date.day == today.day,
      orElse: () => widget.prices!.first,
    );
    return _TodayData(price: todayPrice.priceSignal);
  }

  List<_ChartData> _getChartData() {
    if (widget.prices == null || widget.prices!.isEmpty) return [];
    return widget.prices!.map((p) => _ChartData(
          date: p.date,
          price: p.priceSignal,
        )).toList();
  }

  int? _getTodayIndex() {
    final today = DateTime.now();
    final index = widget.prices?.indexWhere(
      (p) => p.date.year == today.year &&
          p.date.month == today.month &&
          p.date.day == today.day,
    );
    return index != null && index >= 0 ? index : null;
  }

  Color _getPriceColor(double price) {
    // Price ranges: Low < 0.35, Medium 0.35-0.40, High > 0.40
    if (price < 0.35) {
      return AppColors.offPeak; // Green
    } else if (price <= 0.40) {
      return AppColors.midPeak; // Yellow
    } else {
      return AppColors.peak; // Red
    }
  }

  _TouPeriod _getTouPeriodForHour(int hour) {
    // Matches logic from AMI meter readings card
    // Off Peak: midnight to 11am (0-10)
    // Peak: 11am to 9pm (11-20)
    // Mid Peak: 9pm to midnight (21-23)
    if (hour < 11) {
      return _TouPeriod.offPeak;
    } else if (hour < 21) {
      return _TouPeriod.peak;
    } else {
      return _TouPeriod.midPeak;
    }
  }

  bool _isPeakPoint(List<double> prices, int index) {
    if (index == 0 || index == prices.length - 1) return false;
    return prices[index] > prices[index - 1] && prices[index] > prices[index + 1];
  }

  bool _isMinPoint(List<double> prices, int index) {
    if (index == 0 || index == prices.length - 1) return false;
    return prices[index] < prices[index - 1] && prices[index] < prices[index + 1];
  }
}

// Enums
enum _TouPeriod {
  peak,
  midPeak,
  offPeak,
}

// Data classes
class _TodayData {
  const _TodayData({required this.price});
  final double price;
}

class _ChartData {
  const _ChartData({required this.date, required this.price});
  final DateTime date;
  final double price;
}


