import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/account_aware_scaffold.dart';
import '../../core/widgets/app_page_scaffold.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'state/meter_readings_providers.dart';
import 'widgets/month_detail_cards_widget.dart';
import 'widgets/usage_comparison_chart_widget.dart';
import 'widgets/usage_summary_cards_widget.dart';

class UsagePage extends ConsumerStatefulWidget {
  const UsagePage({super.key});

  @override
  ConsumerState<UsagePage> createState() => _UsagePageState();
}

class _UsagePageState extends ConsumerState<UsagePage> {
  String? _selectedMonth;
  bool _didAutoSelectInitial = false;

  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  int? _indexOfMonth(String? month) {
    if (month == null) return null;
    final i = _monthNames.indexOf(month);
    return i >= 0 ? i : null;
  }

  Widget _buildMonthNavigation(BuildContext context) {
    final index = _indexOfMonth(_selectedMonth);
    if (index == null) return const SizedBox.shrink();
    final prevIndex = (index - 1 + _monthNames.length) % _monthNames.length;
    final nextIndex = (index + 1) % _monthNames.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => setState(() => _selectedMonth = _monthNames[prevIndex]),
          tooltip: 'Previous month (${_monthNames[prevIndex]})',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          child: Text(
            _selectedMonth!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => setState(() => _selectedMonth = _monthNames[nextIndex]),
          tooltip: 'Next month (${_monthNames[nextIndex]})',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => AccountAwareScaffold(
      emptyMessage:
          'You don\'t have any accounts connected yet. Connect an account to view your usage history and energy consumption data.',
      emptyIcon: Icons.show_chart_outlined,
      builder: (context, ref, accountState) {
        final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
        final lastYearAsync = ref.watch(meterReadingsLastYearProvider);
        final isMobile = MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;

        // Calculate yearly stats
        final yearlyStats = thisYearAsync.maybeWhen(
          data: (thisYearReadings) => lastYearAsync.maybeWhen(
            data: (lastYearReadings) {
              // Extract years from readings (use first reading's year as representative)
              final currentYear = thisYearReadings.isNotEmpty
                  ? int.tryParse(thisYearReadings.first.readYear) ?? DateTime.now().year
                  : DateTime.now().year;
              final lastYear = lastYearReadings.isNotEmpty
                  ? int.tryParse(lastYearReadings.first.readYear) ?? (currentYear - 1)
                  : (currentYear - 1);

              final totalLastYearConsumption = lastYearReadings.fold<double>(
                0,
                (sum, r) => sum + (double.tryParse(r.consumption.replaceAll(',', '')) ?? 0),
              );
              final totalLastYearCost = lastYearReadings.fold<double>(
                0,
                (sum, r) => sum + (double.tryParse(r.amount.replaceAll(',', '')) ?? 0),
              );
              final totalCurrentYearConsumption = thisYearReadings.fold<double>(
                0,
                (sum, r) => sum + (double.tryParse(r.consumption.replaceAll(',', '')) ?? 0),
              );
              final totalCurrentYearCost = thisYearReadings.fold<double>(
                0,
                (sum, r) => sum + (double.tryParse(r.amount.replaceAll(',', '')) ?? 0),
              );

              // Calculate peak month for current year
              // Group readings by month and sum consumption per month
              final monthConsumptionMap = <String, double>{};
              for (final reading in thisYearReadings) {
                final month = reading.readMonth;
                final consumption = double.tryParse(reading.consumption.replaceAll(',', '')) ?? 0.0;
                monthConsumptionMap[month] = (monthConsumptionMap[month] ?? 0.0) + consumption;
              }

              // Find peak month
              double? peakMonthCurrentYearConsumption;
              String? peakMonthCurrentYear;
              if (monthConsumptionMap.isNotEmpty) {
                final peakEntry = monthConsumptionMap.entries.reduce(
                  (a, b) => a.value > b.value ? a : b,
                );
                peakMonthCurrentYearConsumption = peakEntry.value;
                peakMonthCurrentYear = peakEntry.key;
              }

              return YearlyStats(
                currentYear: currentYear,
                lastYear: lastYear,
                totalLastYearConsumption: totalLastYearConsumption,
                totalLastYearCost: totalLastYearCost,
                totalCurrentYearConsumption: totalCurrentYearConsumption,
                totalCurrentYearCost: totalCurrentYearCost,
                consumptionSaved: totalLastYearConsumption - totalCurrentYearConsumption,
                costSaved: totalLastYearCost - totalCurrentYearCost,
                peakMonthCurrentYearConsumption: peakMonthCurrentYearConsumption,
                peakMonthCurrentYear: peakMonthCurrentYear,
                hasLastYearData: lastYearReadings.isNotEmpty,
                monthsWithDataThisYear: monthConsumptionMap.length,
              );
            },
            orElse: () => null,
          ),
          orElse: () => null,
        );

        // Get account number for footer
        final accountNumber = accountState.activeAccount?.accountNumber ?? '';

        // Auto-select the last record (current month) when data first loads (null-safe for bool?)
        if (yearlyStats != null && (_didAutoSelectInitial != true)) {
          _didAutoSelectInitial = true;
          final currentMonthName = _monthNames[DateTime.now().month - 1];
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _selectedMonth == null) {
              setState(() => _selectedMonth = currentMonthName);
            }
          });
        }

        return AppPageScaffold(
          title: 'Usage History',
          subtitle: 'Compare your energy consumption year over year',
          body: Container(
            // padding: EdgeInsets.all(isMobile ? AppTheme.spacing16 : AppTheme.spacing24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards
                if (yearlyStats != null) ...[
                  UsageSummaryCards(yearlyStats: yearlyStats),
                  const SizedBox(height: AppTheme.spacing16),
                ],

                // Comparison Chart
                UsageComparisonChartWidget(
                  selectedMonth: _selectedMonth,
                  onMonthSelect: (month) {
                    setState(() {
                      _selectedMonth = month;
                    });
                  },
                ),

                // Navigation arrows when a month is selected (loop through data points)
                if (_selectedMonth != null) ...[
                  const SizedBox(height: AppTheme.spacing12),
                  _buildMonthNavigation(context),
                  const SizedBox(height: AppTheme.spacing4),
                ],

                // Month Detail Cards
                if (_selectedMonth != null) ...[
                  const SizedBox(height: AppTheme.spacing16),
                  MonthDetailCardsWidget(
                    selectedMonth: _selectedMonth!,
                    onClose: () {
                      setState(() {
                        _selectedMonth = null;
                      });
                    },
                  ),
                ],

                // Hint Text
                if (_selectedMonth == null) ...[
                  const SizedBox(height: AppTheme.spacing16),
                  Center(
                    child: Text(
                      'Click on any data point in the chart to see detailed breakdown',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                    ),
                  ),
                ],

                // Footer Note
                const SizedBox(height: AppTheme.spacing24),
                Center(
                  child: Text(
                    'Data reflects meter readings for account $accountNumber',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
}
