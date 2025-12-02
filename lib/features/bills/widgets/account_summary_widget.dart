import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class AccountSummaryWidget extends ConsumerWidget {
  const AccountSummaryWidget({
    super.key,
    required this.accountBalance,
    required this.usageSummary,
    this.isLoading = false,
    this.onRefresh,
  });

  final AccountBalance accountBalance;
  final UsageSummary usageSummary;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Account Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // const Spacer(),
                  // if (onRefresh != null)
                  //   IconButton(
                  //     icon: const Icon(Icons.refresh),
                  //     onPressed: isLoading ? null : onRefresh,
                  //   ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.spacing32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                _buildAccountContent(context),
            ],
          ),
        ),
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
          color: _getBalanceColor(context).withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(
            color: _getBalanceColor(context).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getBalanceIcon(),
              color: _getBalanceColor(context),
              size: 32,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Balance',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'BZ\$${accountBalance.currentBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
              _formatDate(accountBalance.lastPaymentDate),
              Icons.payment,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: _buildInfoItem(
              context,
              'Next Due',
              _formatDate(accountBalance.nextDueDate),
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
            Text(
              'Year to Date',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                    'Cost',
                    'BZ\$${usageSummary.yearToDate.cost.toStringAsFixed(2)}',
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
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );

  Widget _buildYTDItem(BuildContext context, String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      );

  Widget _buildBalanceStatusChip(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing4,
        ),
        decoration: BoxDecoration(
          color: _getBalanceColor(context).withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius4),
          border: Border.all(
            color: _getBalanceColor(context).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          _getBalanceStatusText(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getBalanceColor(context),
          ),
        ),
      );

  Color _getBalanceColor(BuildContext context) {
    if (accountBalance.currentBalance > 0) {
      return Theme.of(context).colorScheme.error; // Positive balance means we owe money
    } else if (accountBalance.currentBalance < 0) {
      return Theme.of(context).colorScheme.primary; // Negative balance means credit
    } else {
      return Theme.of(context).textTheme.bodySmall?.color ?? AppColors.textSecondary; // Zero balance
    }
  }

  IconData _getBalanceIcon() {
    if (accountBalance.currentBalance > 0) {
      return Icons.warning;
    } else if (accountBalance.currentBalance < 0) {
      return Icons.check_circle;
    } else {
      return Icons.account_balance_wallet;
    }
  }

  String _getBalanceStatusText() {
    if (accountBalance.currentBalance > 0) {
      return 'Amount Due';
    } else if (accountBalance.currentBalance < 0) {
      return 'Credit';
    } else {
      return 'Current';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 0) {
      return 'In $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }

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
    // Mock monthly data for chart
    final thisYearData = [350.0, 320.0, 380.0, 400.0, 370.0, 410.0, 430.0, 420.0, 390.0, 380.0, 360.0, 370.0];
    final lastYearData = [330.0, 310.0, 360.0, 380.0, 350.0, 390.0, 410.0, 400.0, 370.0, 360.0, 340.0, 350.0];
    final currentYear = DateTime.now().year;
    final lastYear = currentYear - 1;

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(fontSize: 10);
                      String text;
                      switch (value.toInt()) {
                        case 0:
                          text = 'Jan';
                          break;
                        case 5:
                          text = 'Jun';
                          break;
                        case 11:
                          text = 'Dec';
                          break;
                        default:
                          return Container();
                      }
                      return Text(text, style: style);
                    },
                  ),
                  axisNameWidget: const Text('Months'),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                  axisNameWidget: Text('Usage (kWh)'),
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
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(context, Theme.of(context).colorScheme.primary, lastYear.toString()),
            const SizedBox(width: AppTheme.spacing16),
            _buildLegendItem(context, Theme.of(context).colorScheme.secondary, currentYear.toString()),
          ],
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          'Comparison for last year and this year',
          style: Theme.of(context).textTheme.bodySmall,
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
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
}
