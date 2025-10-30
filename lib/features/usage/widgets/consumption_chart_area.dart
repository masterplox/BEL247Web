import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/consumption.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import 'daily_consumption_chart.dart';
import 'hourly_consumption_chart.dart';

class ConsumptionChartArea extends ConsumerStatefulWidget {
  const ConsumptionChartArea({
    super.key,
    this.consumptionData,
    this.dailyConsumptionData,
    this.isLoading = false,
    this.isHourlyChart = true,
    this.selectedHour,
    this.onChartTypeToggle,
    this.onDataPointTap,
    this.onDailyDataPointTap,
  });

  final DailyConsumption? consumptionData;
  final List<DailyConsumption>? dailyConsumptionData;
  final bool isLoading;
  final bool isHourlyChart;
  final int? selectedHour;
  final VoidCallback? onChartTypeToggle;
  final Function(int hour, double kwh)? onDataPointTap;
  final Function(DateTime date, double kwh)? onDailyDataPointTap;

  @override
  ConsumerState<ConsumptionChartArea> createState() => _ConsumptionChartAreaState();
}

class _ConsumptionChartAreaState extends ConsumerState<ConsumptionChartArea> {
  @override
  Widget build(BuildContext context) => Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart, color: AppColors.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Consumption Chart',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  _buildChartTypeToggle(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing16,
                  0,
                  AppTheme.spacing16,
                  AppTheme.spacing16,
                ),
                child: widget.isHourlyChart
                    ? HourlyConsumptionChart(
                        consumptionData: widget.consumptionData,
                        isLoading: widget.isLoading,
                        onDataPointTap: widget.onDataPointTap,
                      )
                    : DailyConsumptionChart(
                        consumptionData: widget.dailyConsumptionData,
                        isLoading: widget.isLoading,
                        onDataPointTap: widget.onDailyDataPointTap,
                      ),
              ),
            ),
          ],
        ),
      );

  Widget _buildChartTypeToggle() => Container(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButton('Hourly', widget.isHourlyChart),
            const SizedBox(width: AppTheme.spacing4),
            _buildToggleButton('Daily', !widget.isHourlyChart),
          ],
        ),
      );

  Widget _buildToggleButton(String label, bool isSelected) => GestureDetector(
        onTap: () {
          widget.onChartTypeToggle?.call();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing12,
            vertical: AppTheme.spacing8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      );
}
