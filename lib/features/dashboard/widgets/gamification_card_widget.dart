import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../features/usage/state/meter_readings_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Gamification card widget matching the React version design
class GamificationCardWidget extends ConsumerWidget {
  const GamificationCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meterReadingsAsync = ref.watch(meterReadingsThisYearProvider);

    return meterReadingsAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (readings) {
        if (readings.isEmpty) {
          return const SizedBox.shrink();
        }

        final comparison = _getMonthComparison(readings);
        final savedMoney = comparison['savedMoney'] as bool;
        final amountDiff = comparison['amountDiff'] as double;
        final consumptionDiff = comparison['consumptionDiff'] as double;

        return AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          showBorder: true,
          borderWidth: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Achievement Banner
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: savedMoney
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(
                    color: savedMoney
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.warning.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: savedMoney
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.warning.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        savedMoney ? Icons.trending_down : Icons.trending_up,
                        color: savedMoney ? AppColors.primary : AppColors.warning,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            savedMoney
                                ? 'You saved ${FormattingUtils.formatCurrency(amountDiff.abs())} this month!'
                                : 'Usage up ${FormattingUtils.formatCurrency(amountDiff.abs())} this month',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Text(
                            '${consumptionDiff.abs().toStringAsFixed(0)} kWh ${savedMoney ? 'less' : 'more'} than last month',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Energy Saving Tips
              Text(
                'QUICK SAVINGS TIPS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              ..._buildTips(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1.0,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> _buildTips(BuildContext context) {
    final tips = [
      {'icon': Icons.bolt, 'text': 'Turn off AC when away', 'savings': '\$15/mo'},
      {'icon': Icons.lightbulb_outline, 'text': 'Use LED bulbs', 'savings': '\$8/mo'},
      {'icon': Icons.local_laundry_service, 'text': 'Wash clothes cold', 'savings': '\$5/mo'},
    ];

    return tips.map((tip) {
      return Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        padding: const EdgeInsets.all(AppTheme.spacing8),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  tip['icon'] as IconData,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  tip['text'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ],
            ),
            Text(
              tip['savings'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Map<String, dynamic> _getMonthComparison(List<MeterReadingDto> readings) {
    if (readings.length < 2) {
      return {
        'current': null,
        'previous': null,
        'consumptionDiff': 0.0,
        'amountDiff': 0.0,
        'savedMoney': false,
        'savedEnergy': false,
      };
    }

    // Sort by year and month
    final sorted = List<MeterReadingDto>.from(readings);
    sorted.sort((a, b) {
      final yearA = int.tryParse(a.readYear) ?? 0;
      final yearB = int.tryParse(b.readYear) ?? 0;
      if (yearA != yearB) return yearA.compareTo(yearB);
      
      final monthA = _getMonthIndex(a.readMonth);
      final monthB = _getMonthIndex(b.readMonth);
      return monthA.compareTo(monthB);
    });

    final current = sorted.last;
    final previous = sorted[sorted.length - 2];

    final currentConsumption = double.tryParse(current.consumption) ?? 0.0;
    final previousConsumption = double.tryParse(previous.consumption) ?? 0.0;
    final currentAmount = double.tryParse(current.amount) ?? 0.0;
    final previousAmount = double.tryParse(previous.amount) ?? 0.0;

    final consumptionDiff = previousConsumption - currentConsumption;
    final amountDiff = previousAmount - currentAmount;

    return {
      'current': current,
      'previous': previous,
      'consumptionDiff': consumptionDiff,
      'amountDiff': amountDiff,
      'savedMoney': amountDiff > 0,
      'savedEnergy': consumptionDiff > 0,
    };
  }

  int _getMonthIndex(String month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months.indexOf(month);
  }
}
