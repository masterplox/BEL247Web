import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
// COMMENTED OUT - Old content replaced with meter readings chart
// import '../../daily_bill/widgets/daily_consumption_breakdown_widget.dart';
// import 'ami_meter_readings_card.dart';
import 'meter_readings_chart.dart';

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
            // COMMENTED OUT - Old AMI Meter Readings Card
            // AmiMeterReadingsCard(),
            // SizedBox(height: AppTheme.spacing24),
            // DailyConsumptionBreakdownWidget(),
            
            // New meter readings chart with this year vs last year comparison
            MeterReadingsChart(),
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
            // COMMENTED OUT - Old content
            // AmiMeterReadingsCard(),
            // SizedBox(height: AppTheme.spacing16),
            // DailyConsumptionBreakdownWidget(),
            
            // New meter readings chart with this year vs last year comparison
            MeterReadingsChart(),
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
            // COMMENTED OUT - Old content
            // AmiMeterReadingsCard(),
            // SizedBox(height: AppTheme.spacing12),
            // DailyConsumptionBreakdownWidget(),
            
            // New meter readings chart with this year vs last year comparison
            MeterReadingsChart(),
          ],
        ),
      );
}
