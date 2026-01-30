import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/meter_readings_providers.dart';

class MonthDetailCardsWidget extends ConsumerWidget {
  const MonthDetailCardsWidget({
    super.key,
    required this.selectedMonth,
    required this.onClose,
  });

  final String selectedMonth;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
    final lastYearAsync = ref.watch(meterReadingsLastYearProvider);
    final isMobile = MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;

    return thisYearAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (thisYearReadings) => lastYearAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => _buildDetailCards(context, thisYearReadings, [], isMobile),
        data: (lastYearReadings) =>
            _buildDetailCards(context, thisYearReadings, lastYearReadings, isMobile),
      ),
    );
  }

  Widget _buildDetailCards(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
    bool isMobile,
  ) {
    // Find data for selected month
    final thisYearData = thisYearReadings.firstWhere(
      (r) => r.readMonth == selectedMonth,
      orElse: () => MeterReadingDto(
        readDate: '',
        readMonth: selectedMonth,
        readYear: '',
        days: '0',
        consumption: '0',
        averageUsage: '0',
        amount: '0',
      ),
    );

    final lastYearData = lastYearReadings.firstWhere(
      (r) => r.readMonth == selectedMonth,
      orElse: () => MeterReadingDto(
        readDate: '',
        readMonth: selectedMonth,
        readYear: '',
        days: '0',
        consumption: '0',
        averageUsage: '0',
        amount: '0',
      ),
    );

    // Calculate differences
    final consumption2024 = double.tryParse(lastYearData.consumption) ?? 0.0;
    final consumption2025 = double.tryParse(thisYearData.consumption) ?? 0.0;
    final cost2024 = double.tryParse(lastYearData.amount) ?? 0.0;
    final cost2025 = double.tryParse(thisYearData.amount) ?? 0.0;
    final avgUsage2024 = double.tryParse(lastYearData.averageUsage) ?? 0.0;
    final avgUsage2025 = double.tryParse(thisYearData.averageUsage) ?? 0.0;

    final consumptionDiff = consumption2024 - consumption2025;
    final costDiff = cost2024 - cost2025;
    final avgUsageDiff = avgUsage2024 - avgUsage2025;

    final savedEnergy = consumptionDiff > 0;
    final savedCost = costDiff > 0;
    final savedAvg = avgUsageDiff > 0;

    return AppCard(
      padding: EdgeInsets.all(isMobile ? AppTheme.spacing16 : AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$selectedMonth Breakdown',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Comparing ${lastYearData.readYear.isNotEmpty ? lastYearData.readYear : '2024'} vs ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: onClose,
                tooltip: 'Close',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Stats Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                return Column(
                  children: [
                    _buildComparisonCard(
                      context,
                      title: 'Consumption',
                      icon: Icons.bolt,
                      iconColor: AppColors.textSecondary,
                      value2024: consumption2024,
                      value2025: consumption2025,
                      diff: consumptionDiff,
                      saved: savedEnergy,
                      unit: 'kWh',
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildComparisonCard(
                      context,
                      title: 'Cost',
                      icon: Icons.attach_money,
                      iconColor: AppColors.textSecondary,
                      value2024: cost2024,
                      value2025: cost2025,
                      diff: costDiff,
                      saved: savedCost,
                      unit: r'$',
                      isCurrency: true,
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildComparisonCard(
                      context,
                      title: 'Daily Avg',
                      icon: Icons.access_time,
                      iconColor: AppColors.textSecondary,
                      value2024: avgUsage2024,
                      value2025: avgUsage2025,
                      diff: avgUsageDiff,
                      saved: savedAvg,
                      unit: 'kWh/day',
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Consumption',
                      icon: Icons.bolt,
                      iconColor: AppColors.textSecondary,
                      value2024: consumption2024,
                      value2025: consumption2025,
                      diff: consumptionDiff,
                      saved: savedEnergy,
                      unit: 'kWh',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Cost',
                      icon: Icons.attach_money,
                      iconColor: AppColors.textSecondary,
                      value2024: cost2024,
                      value2025: cost2025,
                      diff: costDiff,
                      saved: savedCost,
                      unit: r'$',
                      isCurrency: true,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildComparisonCard(
                      context,
                      title: 'Daily Avg',
                      icon: Icons.access_time,
                      iconColor: AppColors.textSecondary,
                      value2024: avgUsage2024,
                      value2025: avgUsage2025,
                      diff: avgUsageDiff,
                      saved: savedAvg,
                      unit: 'kWh/day',
                    ),
                  ),
                ],
              );
            },
          ),

          // Reading Details
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 400;
                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        'Billing Days',
                        '${lastYearData.readYear.isNotEmpty ? lastYearData.readYear : '2024'}: ${int.tryParse(lastYearData.days) ?? 0} / ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}: ${int.tryParse(thisYearData.days) ?? 0}',
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      _buildDetailRow(
                        context,
                        'Meter Reading Period',
                        '$selectedMonth ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}',
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow(
                        context,
                        'Billing Days',
                        '${lastYearData.readYear.isNotEmpty ? lastYearData.readYear : '2024'}: ${int.tryParse(lastYearData.days) ?? 0} / ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}: ${int.tryParse(thisYearData.days) ?? 0}',
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing16),
                    Expanded(
                      child: _buildDetailRow(
                        context,
                        'Meter Reading Period',
                        '$selectedMonth ${thisYearData.readYear.isNotEmpty ? thisYearData.readYear : '2025'}',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required double value2024,
    required double value2025,
    required double diff,
    required bool saved,
    required String unit,
    bool isCurrency = false,
  }) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          // 2024 value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '2024',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                value2024 > 0
                    ? (isCurrency
                        ? FormattingUtils.formatCurrency(value2024)
                        : '${value2024.toStringAsFixed(0)} $unit')
                    : '—',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          // 2025 value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '2025',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              Text(
                value2025 > 0
                    ? (isCurrency
                        ? FormattingUtils.formatCurrency(value2025)
                        : '${value2025.toStringAsFixed(0)} $unit')
                    : '—',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          // Difference
          Container(
            padding: const EdgeInsets.only(top: AppTheme.spacing12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      saved ? Icons.trending_down : Icons.trending_up,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Text(
                      '${saved ? '-' : '+'}${diff.abs().toStringAsFixed(0)}${isCurrency ? '' : ' $unit'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  '${saved ? 'saved' : isCurrency ? 'spent more' : 'more'} ${isCurrency ? '' : 'this month'}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  Widget _buildDetailRow(BuildContext context, String label, String value) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
        ),
      ],
    );
}
