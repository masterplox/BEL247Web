import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/utils/widget_builder_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_line_chart.dart';
import '../../../core/widgets/app_text.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';

class AccountSummaryWidget extends ConsumerWidget {
  const AccountSummaryWidget({
    super.key,
    required this.accountBalance,
    required this.usageSummary,
    this.yearlyConsumption,
    this.isLoading = false,
    this.onRefresh,
  });

  final AccountBalance accountBalance;
  final UsageSummary usageSummary;
  final Map<int, List<MonthlyConsumption>>? yearlyConsumption;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AppCard(
        title: Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppTheme.spacing8),
            const AppText(
              'Account Summary',
              style: AppTextStyle.title,
              fontWeight: FontWeight.w600,
            ),
            // const Spacer(),
            // if (onRefresh != null)
            //   IconButton(
            //     icon: const Icon(Icons.refresh),
            //     onPressed: isLoading ? null : onRefresh,
            //   ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacing32),
                  child: CircularProgressIndicator(),
                ),
              )
            : _buildAccountContent(context),
      );

  Widget _buildAccountContent(BuildContext context) => Column(
        children: [
          _buildCurrentBalance(context),
          const SizedBox(height: AppTheme.spacing16),
          _buildPaymentInfo(context),
          const SizedBox(height: AppTheme.spacing16),
          _buildYTDSummary(context),
        ],
      );

  Widget _buildCurrentBalance(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(
            color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              WidgetBuilderUtils.getBalanceIcon(accountBalance.currentBalance),
              color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance),
              size: 32,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Current Balance',
                    style: AppTextStyle.body,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  AppText(
                    'BZ\$${accountBalance.currentBalance.toStringAsFixed(2)}',
                    style: AppTextStyle.title,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            _buildBalanceStatusChip(context),
          ],
        ),
      );

  Widget _buildPaymentInfo(BuildContext context) => Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              context,
              'Past due',
              'BZ\$${accountBalance.lastPaymentAmount.toStringAsFixed(2)}',
              FormattingUtils.formatDateRelative(accountBalance.lastPaymentDate),
              Icons.payment,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: _buildInfoItem(
              context,
              'Next Due',
              FormattingUtils.formatDateRelative(accountBalance.nextDueDate),
              _getDaysUntilDue(),
              Icons.schedule,
            ),
          ),
        ],
      );

  Widget _buildYTDSummary(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Year to Date',
              style: AppTextStyle.subtitle,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Usage',
                    '${usageSummary.yearToDate.kwh.toStringAsFixed(0)} kWh',
                  ),
                ),
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Avg Daily',
                    '${usageSummary.yearToDate.averageDaily.toStringAsFixed(1)} kWh',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            _buildYTDChart(context),
          ],
        ),
      );

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: AppTheme.spacing4),
                AppText(
                  title,
                  style: AppTextStyle.caption,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            AppText(
              value,
              style: AppTextStyle.subtitle,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: AppTheme.spacing4),
            AppText(
              subtitle,
              style: AppTextStyle.caption,
            ),
          ],
        ),
      );

  Widget _buildYTDItem(BuildContext context, String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label,
            style: AppTextStyle.caption,
          ),
          const SizedBox(height: AppTheme.spacing4),
          AppText(
            value,
            style: AppTextStyle.subtitle, // Was titleSmall, mapped to subtitle
            fontWeight: FontWeight.w600,
          ),
        ],
      );

  Widget _buildBalanceStatusChip(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing4,
        ),
        decoration: BoxDecoration(
          color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius4),
          border: Border.all(
            color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: AppText(
          WidgetBuilderUtils.getBalanceStatusText(accountBalance.currentBalance),
          style: AppTextStyle.caption, // Approximating fontSize: 12
          fontWeight: FontWeight.w500,
          color: WidgetBuilderUtils.getBalanceColor(context, accountBalance.currentBalance),
        ),
      );


  String _getDaysUntilDue() {
    final now = DateTime.now();
    final difference = accountBalance.nextDueDate.difference(now).inDays;
    
    if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else if (difference > 0) {
      return 'Due in $difference days';
    } else {
      return 'Overdue by ${difference.abs()} days';
    }
  }

  Widget _buildYTDChart(BuildContext context) {
    final currentYear = DateTime.now().year;
    final lastYear = currentYear - 1;

    final thisYearData = List<double>.filled(12, 0);
    if (yearlyConsumption?[currentYear] != null) {
      for (final monthly in yearlyConsumption![currentYear]!) {
        final monthIndex = int.tryParse(monthly.month.split('-')[1]) ?? 0;
        if (monthIndex > 0 && monthIndex <= 12) {
          thisYearData[monthIndex - 1] = monthly.totalKwh;
        }
      }
    }

    final lastYearData = List<double>.filled(12, 0);
    if (yearlyConsumption?[lastYear] != null) {
      for (final monthly in yearlyConsumption![lastYear]!) {
        final monthIndex = int.tryParse(monthly.month.split('-')[1]) ?? 0;
        if (monthIndex > 0 && monthIndex <= 12) {
          lastYearData[monthIndex - 1] = monthly.totalKwh;
        }
      }
    }

    // Create month abbreviations array
    final monthAbbreviations = List.generate(12, (index) => FormattingUtils.getMonthName(index + 1));

    final lineChartData = LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < monthAbbreviations.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AppText(
                      monthAbbreviations[index],
                      style: AppTextStyle.caption,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          axisNameWidget: const AppText('Months', style: AppTextStyle.caption),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
          axisNameWidget: AppText('Usage (kWh)', style: AppTextStyle.caption),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(thisYearData.length, (index) => FlSpot(index.toDouble(), thisYearData[index])),
          isCurved: true,
          color: Theme.of(context).colorScheme.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: List.generate(lastYearData.length, (index) => FlSpot(index.toDouble(), lastYearData[index])),
          isCurved: true,
          color: Theme.of(context).colorScheme.secondary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: WidgetBuilderUtils.buildLineTooltipData(
          context,
          getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
            final monthIndex = spot.x.toInt();
            final kwh = spot.y;
            String label;
            
            // Validate month index
            if (monthIndex >= 0 && monthIndex < monthAbbreviations.length) {
              // Determine which line this spot belongs to based on barIndex
              if (spot.barIndex == 0) {
                // This year (primary color)
                label = '$currentYear: ${monthAbbreviations[monthIndex]}\n${kwh.toStringAsFixed(1)} kWh';
              } else {
                // Last year (secondary color)
                label = '$lastYear: ${monthAbbreviations[monthIndex]}\n${kwh.toStringAsFixed(1)} kWh';
              }
            } else {
              // Fallback if index is invalid
              label = '${kwh.toStringAsFixed(1)} kWh';
            }
            
            return LineTooltipItem(
              label,
              const TextStyle(), // Will be styled by buildLineTooltipData
            );
          }).toList(),
        ),
      ),
    );

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final chartWidth = constraints.maxWidth;
              final maxX = 11.0; // 12 months (0-11)
              
              // Calculate responsive interval for x-axis labels
              final xAxisInterval = WidgetBuilderUtils.calculateResponsiveInterval(
                screenWidth: screenWidth,
                chartWidth: chartWidth,
                maxValue: maxX,
                minLabelSpacing: 50,
                defaultInterval: 2, // Show every 2 months by default
              );
              
              // Update the lineChartData with responsive interval
              final responsiveLineChartData = lineChartData.copyWith(
                titlesData: lineChartData.titlesData.copyWith(
                  bottomTitles: lineChartData.titlesData.bottomTitles.copyWith(
                    sideTitles: lineChartData.titlesData.bottomTitles.sideTitles.copyWith(
                      interval: xAxisInterval,
                    ),
                  ),
                ),
              );
              
              return AppLineChart(lineChartData: responsiveLineChartData);
            },
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(context, Theme.of(context).colorScheme.primary, currentYear.toString()),
            const SizedBox(width: AppTheme.spacing16),
            _buildLegendItem(context, Theme.of(context).colorScheme.secondary, lastYear.toString()),
          ],
        ),
        const SizedBox(height: AppTheme.spacing4),
        const AppText(
          'Comparison for last year and this year',
          style: AppTextStyle.caption,
        ),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String text) => Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: AppTheme.spacing4),
        AppText(text, style: AppTextStyle.caption),
      ],
    );
}
