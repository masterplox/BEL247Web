
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
// Dollar amounts are hidden in this version. They will be shown in a future release.
// import '../services/cost_calculation_service.dart';
import '../state/daily_bill_providers.dart';

class DailyConsumptionBreakdownWidget extends ConsumerWidget {
  const DailyConsumptionBreakdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyBillState = ref.watch(dailyBillProvider);
    final currentConsumption = dailyBillState.currentConsumption;

    if (currentConsumption == null) {
      return const SizedBox.shrink();
    }

    // Dollar amounts are hidden in this version. They will be shown in a future release.
    // final costCalculation =
    //     CostCalculationService.calculateDailyCost(currentConsumption);
    // final b = costCalculation.costBreakdown;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight.withValues(alpha: 0.06), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Consumption Breakdown',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppTheme.spacing12),
            // Dollar amounts are hidden in this version. They will be shown in a future release.
            // _breakdownRow(
            //   context,
            //   'Energy Charge (${currentConsumption.totalKwh.toStringAsFixed(1)} kWh × BZ\$0.35)',
            //   b.energyCharge,
            // ),
            // _breakdownRow(context, 'Service Fee', b.serviceFee),
            // const Divider(),
            // _breakdownRow(
            //   context,
            //   'Total Estimated Cost',
            //   b.totalCost,
            //   isTotal: true,
            // ),
          ],
        ),
      ),
    );
  }

  // Dollar amounts are hidden in this version. They will be shown in a future release.
  // ignore: unused_element
  Widget _breakdownRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
          Text(
            // Dollar amounts are hidden in this version. They will be shown in a future release.
            // 'BZ\$${amount.toStringAsFixed(2)}',
            '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
                ),
          ),
        ],
      );
}
