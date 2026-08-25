import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/meter_readings_chart_widget.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/meter_readings_providers.dart';

/// Meter readings chart widget showing this year vs last year comparison
class MeterReadingsChart extends ConsumerStatefulWidget {
  const MeterReadingsChart({super.key});

  @override
  ConsumerState<MeterReadingsChart> createState() => _MeterReadingsChartState();
}

class _MeterReadingsChartState extends ConsumerState<MeterReadingsChart> {
  int? _selectedMonthIndex; // 0-11 for months
  bool _hasInitializedDefault = false; // Track if we've set the default selection
  bool _isInitializing = false; // Prevent concurrent initialization

  void _initializeDefaultSelection(List<MeterReadingDto> thisYearReadings) {
    // Prevent multiple concurrent initializations
    if (_hasInitializedDefault || _isInitializing || thisYearReadings.isEmpty) return;
    
    _isInitializing = true;
    
    // Find the last month with data
    final monthData = _processReadingsByMonth(thisYearReadings);
    if (monthData.isEmpty) {
      _isInitializing = false;
      return;
    }
    
    // Sort by month and get the last one
    monthData.sort((a, b) => b.month.compareTo(a.month));
    final lastMonth = monthData.first.month;
    
    // Set state to show the last month from this year
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasInitializedDefault) {
        setState(() {
          _selectedMonthIndex = lastMonth - 1; // Convert to 0-based index
          _hasInitializedDefault = true;
          _isInitializing = false;
        });
      } else {
        _isInitializing = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final thisYearAsync = ref.watch(meterReadingsThisYearProvider);
    final lastYearAsync = ref.watch(meterReadingsLastYearProvider);
    
    // Extract year labels from the first record in each list
    final String thisYearLabel = thisYearAsync.maybeWhen(
      data: (readings) {
        if (readings.isNotEmpty && readings.first.readYear.isNotEmpty) {
          return readings.first.readYear;
        }
        return DateTime.now().year.toString();
      },
      orElse: () => DateTime.now().year.toString(),
    );
    
    final String lastYearLabel = lastYearAsync.maybeWhen(
      data: (readings) {
        if (readings.isNotEmpty && readings.first.readYear.isNotEmpty) {
          return readings.first.readYear;
        }
        // Fallback: calculate from this year label
        final currentYear = int.tryParse(thisYearLabel) ?? DateTime.now().year;
        return (currentYear - 1).toString();
      },
      orElse: () {
        // Fallback: calculate from this year label
        final currentYear = int.tryParse(thisYearLabel) ?? DateTime.now().year;
        return (currentYear - 1).toString();
      },
    );

    // Listen for data changes - ref.listen only fires when value actually changes
    // Always defer execution to prevent rebuild loops
    ref.listen(meterReadingsThisYearProvider, (previous, next) {
      // Only process if we haven't initialized yet
      if (!_hasInitializedDefault) {
        next.whenData((data) {
          // Always defer to post-frame to avoid executing during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_hasInitializedDefault) {
              _initializeDefaultSelection(data);
            }
          });
        });
      }
    });

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Meter Readings Comparison',
                  style: AppTextStyle.title,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: AppTheme.spacing4),
                AppText(
                  'This year vs last year consumption',
                  style: AppTextStyle.body,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          // Selected reading details cards (shown when a data point is clicked)
          if (_selectedMonthIndex != null)
            thisYearAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (thisYearReadings) => lastYearAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => _buildSelectedReadingCards(context, thisYearReadings, []),
                data: (lastYearReadings) => Column(
                  children: [
                    _buildSelectedReadingCards(context, thisYearReadings, lastYearReadings),
                    const SizedBox(height: AppTheme.spacing16),
                  ],
                ),
              ),
            ),
          // Chart - use reusable widget with full features
          MeterReadingsChartWidget(
            config: MeterReadingsChartConfig(
              showYAxis: true,
              showYAxisLabel: true,
              showTooltips: true,
              showClickableDataPoints: true,
              showLegend: false, // We have our own legend below
              height: 400,
              showNavigationButton: false,
              onDataPointClick: (monthIndex, isThisYear) {
                setState(() {
                  _selectedMonthIndex = monthIndex;
                });
              },
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(context, thisYearLabel, AppColors.success),
                const SizedBox(width: AppTheme.spacing24),
                _buildLegendItem(context, lastYearLabel, Colors.yellow.shade700),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
        ],
      ),
    );
  }

  /// Build grid cards showing selected reading details for both years
  Widget _buildSelectedReadingCards(
    BuildContext context,
    List<MeterReadingDto> thisYearReadings,
    List<MeterReadingDto> lastYearReadings,
  ) {
    if (_selectedMonthIndex == null) {
      return const SizedBox.shrink();
    }

    final monthIndex = _selectedMonthIndex!;
    final monthAbbreviations = List.generate(12, (index) => FormattingUtils.getMonthName(index + 1));
    final monthName = monthIndex >= 0 && monthIndex < monthAbbreviations.length
        ? monthAbbreviations[monthIndex]
        : 'Unknown';

    // Get data for both years for the selected month
    final thisYearMonthData = _processReadingsByMonth(thisYearReadings);
    final lastYearMonthData = _processReadingsByMonth(lastYearReadings);
    
    final thisYearReadingData = thisYearMonthData.firstWhere(
      (d) => d.month == monthIndex + 1,
      orElse: () => _MonthData(month: monthIndex + 1, consumption: 0),
    );
    
    final lastYearReadingData = lastYearMonthData.firstWhere(
      (d) => d.month == monthIndex + 1,
      orElse: () => _MonthData(month: monthIndex + 1, consumption: 0),
    );

    // Check if data exists for each year
    final hasThisYearData = thisYearMonthData.any((d) => d.month == monthIndex + 1 && d.consumption > 0);
    final hasLastYearData = lastYearMonthData.any((d) => d.month == monthIndex + 1 && d.consumption > 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                '$monthName - Comparison',
                style: AppTextStyle.subtitle,
                fontWeight: FontWeight.w600,
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  setState(() {
                    _selectedMonthIndex = null;
                  });
                },
                tooltip: 'Clear selection',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;
              
              if (isMobile) {
                // Mobile: Stack years vertically, each with 2x2 grid
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // This Year section
                    if (hasThisYearData) ...[
                      _buildYearSection(
                        context,
                        'This Year',
                        thisYearReadingData,
                        AppColors.success,
                        isMobile: true,
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                    ],
                    // Last Year section
                    if (hasLastYearData) ...[
                      _buildYearSection(
                        context,
                        'Last Year',
                        lastYearReadingData,
                        Colors.yellow.shade700,
                        isMobile: true,
                      ),
                    ],
                    // Show message if no data for either year
                    if (!hasThisYearData && !hasLastYearData)
                      Padding(
                        padding: const EdgeInsets.all(AppTheme.spacing16),
                        child: Center(
                          child: AppText(
                            'No data available for $monthName',
                            style: AppTextStyle.body,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                // Desktop/Tablet: Show years side by side
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // This Year section
                    if (hasThisYearData)
                      Expanded(
                        child: _buildYearSection(
                          context,
                          'This Year',
                          thisYearReadingData,
                          AppColors.success,
                          isMobile: false,
                        ),
                      ),
                    if (hasThisYearData && hasLastYearData)
                      const SizedBox(width: AppTheme.spacing16),
                    // Last Year section
                    if (hasLastYearData)
                      Expanded(
                        child: _buildYearSection(
                          context,
                          'Last Year',
                          lastYearReadingData,
                          Colors.yellow.shade700,
                          isMobile: false,
                        ),
                      ),
                    // Show message if no data for either year
                    if (!hasThisYearData && !hasLastYearData)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.spacing16),
                          child: Center(
                            child: AppText(
                              'No data available for $monthName',
                              style: AppTextStyle.body,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  /// Build a year section with all detail cards
  Widget _buildYearSection(
    BuildContext context,
    String yearLabel,
    _MonthData readingData,
    Color accentColor, {
    required bool isMobile,
  }) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            yearLabel,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (isMobile) ...[
            // Mobile: 2x2 grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Consumption',
                    '${readingData.consumption.toStringAsFixed(2)} kWh',
                    Icons.electrical_services,
                    AppColors.primary,
                  ),
                ),
                // Dollar amounts are hidden in this version. They will be shown in a future release.
                // const SizedBox(width: AppTheme.spacing12),
                // Expanded(
                //   child: _buildDetailCard(
                //     context,
                //     'Amount',
                //     'BZ\$${readingData.amount.toStringAsFixed(2)}',
                //     Icons.attach_money,
                //     AppColors.success,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Avg Usage',
                    '${readingData.averageUsage.toStringAsFixed(2)} kWh/day',
                    Icons.trending_up,
                    AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Days',
                    '${readingData.days}',
                    Icons.calendar_today,
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ] else ...[
            // Desktop/Tablet: Single row
            Row(
              children: [
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Consumption',
                    '${readingData.consumption.toStringAsFixed(2)} kWh',
                    Icons.electrical_services,
                    AppColors.primary,
                  ),
                ),
                // Dollar amounts are hidden in this version. They will be shown in a future release.
                // const SizedBox(width: AppTheme.spacing12),
                // Expanded(
                //   child: _buildDetailCard(
                //     context,
                //     'Amount',
                //     'BZ\$${readingData.amount.toStringAsFixed(2)}',
                //     Icons.attach_money,
                //     AppColors.success,
                //   ),
                // ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Avg Usage',
                    '${readingData.averageUsage.toStringAsFixed(2)} kWh/day',
                    Icons.trending_up,
                    AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _buildDetailCard(
                    context,
                    'Days',
                    '${readingData.days}',
                    Icons.calendar_today,
                    AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

  /// Build a single detail card
  Widget _buildDetailCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: AppText(
                  label,
                  style: AppTextStyle.caption,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          AppText(
            value,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );


  /// Process readings and group by month, calculating total consumption per month
  /// Also stores full reading data for tooltip display
  List<_MonthData> _processReadingsByMonth(List<MeterReadingDto> readings) {
    final monthMap = <int, _MonthData>{};
    
    for (final reading in readings) {
      try {
        // Parse month name (e.g., "Jan", "Feb") to month number (1-12)
        final month = _parseMonthName(reading.readMonth);
        final consumption = double.tryParse(reading.consumption.replaceAll(',', '')) ?? 0.0;
        final amount = double.tryParse(reading.amount.replaceAll(',', '')) ?? 0.0;
        final averageUsage = double.tryParse(reading.averageUsage.replaceAll(',', '')) ?? 0.0;
        final days = int.tryParse(reading.days) ?? 0;
        
        if (month >= 1 && month <= 12) {
          // If month already exists, accumulate consumption and update other fields
          if (monthMap.containsKey(month)) {
            final existing = monthMap[month]!;
            monthMap[month] = _MonthData(
              month: month,
              consumption: existing.consumption + consumption,
              amount: existing.amount + amount,
              averageUsage: averageUsage, // Use latest averageUsage
              days: days, // Use latest days
              reading: reading, // Store latest reading for tooltip
            );
          } else {
            monthMap[month] = _MonthData(
              month: month,
              consumption: consumption,
              amount: amount,
              averageUsage: averageUsage,
              days: days,
              reading: reading,
            );
          }
        }
      } catch (e) {
        // Skip invalid readings
        continue;
      }
    }

    return monthMap.values.toList()
      ..sort((a, b) => a.month.compareTo(b.month));
  }

  /// Parse month name string to month number (1-12)
  /// Handles formats like "Jan", "January", "1", etc.
  int _parseMonthName(String monthStr) {
    if (monthStr.isEmpty) return 0;
    
    // Try parsing as number first
    final monthNum = int.tryParse(monthStr);
    if (monthNum != null && monthNum >= 1 && monthNum <= 12) {
      return monthNum;
    }
    
    // Parse month abbreviations and full names
    final monthLower = monthStr.toLowerCase().trim();
    final monthMap = {
      'jan': 1, 'january': 1,
      'feb': 2, 'february': 2,
      'mar': 3, 'march': 3,
      'apr': 4, 'april': 4,
      'may': 5,
      'jun': 6, 'june': 6,
      'jul': 7, 'july': 7,
      'aug': 8, 'august': 8,
      'sep': 9, 'september': 9, 'sept': 9,
      'oct': 10, 'october': 10,
      'nov': 11, 'november': 11,
      'dec': 12, 'december': 12,
    };
    
    return monthMap[monthLower] ?? 0;
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) => Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppTheme.spacing8),
        AppText(label, style: AppTextStyle.body),
      ],
    );
}

/// Helper class to hold month consumption data
class _MonthData {
  _MonthData({
    required this.month,
    required this.consumption,
    this.amount = 0.0,
    this.averageUsage = 0.0,
    this.days = 0,
    this.reading,
  });
  
  final int month;
  final double consumption;
  final double amount;
  final double averageUsage;
  final int days;
  final MeterReadingDto? reading; // Store original reading for detailed tooltip
}
