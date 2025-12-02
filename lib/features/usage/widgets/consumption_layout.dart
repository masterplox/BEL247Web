import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../daily_bill/widgets/daily_consumption_breakdown_widget.dart';
import 'ami_meter_readings_card.dart';

class ConsumptionLayout extends ConsumerWidget {
  const ConsumptionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1200) {
            return const DesktopConsumptionLayout();
          } else if (constraints.maxWidth >= 768) {
            return const TabletConsumptionLayout();
          } else {
            return const MobileConsumptionLayout();
          }
        },
      );
}

class DesktopConsumptionLayout extends ConsumerWidget {
  const DesktopConsumptionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmiMeterReadingsCard(),
            SizedBox(height: AppTheme.spacing24),
            // DailyConsumptionBreakdownWidget(),
          ],
        ),
      );
}

class TabletConsumptionLayout extends ConsumerWidget {
  const TabletConsumptionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmiMeterReadingsCard(),
            SizedBox(height: AppTheme.spacing16),
            DailyConsumptionBreakdownWidget(),
          ],
        ),
      );
}

class MobileConsumptionLayout extends ConsumerWidget {
  const MobileConsumptionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmiMeterReadingsCard(),
            SizedBox(height: AppTheme.spacing12),
            DailyConsumptionBreakdownWidget(),
          ],
        ),
      );
}
