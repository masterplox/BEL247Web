import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../features/usage/state/meter_readings_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Usage stats widget matching the React version design
class UsageStatsWidget extends ConsumerWidget {
  const UsageStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meterReadingsAsync = ref.watch(meterReadingsThisYearProvider);

    return meterReadingsAsync.when(
      loading: () => _buildLoadingGrid(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (readings) {
        if (readings.isEmpty) {
          return const SizedBox.shrink();
        }

        final stats = _calculateStats(readings);

        // Use LayoutBuilder to get responsive constraints
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isMobile = screenWidth < AppTheme.tabletBreakpoint;
            final isTablet = screenWidth >= AppTheme.tabletBreakpoint && screenWidth < AppTheme.desktopBreakpoint;
            final isDesktop = screenWidth >= AppTheme.desktopBreakpoint;
            
            // Determine current mode for debug display
            final currentMode = isMobile 
                ? 'Mobile (${screenWidth.toStringAsFixed(0)}px)' 
                : isTablet 
                    ? 'Tablet (${screenWidth.toStringAsFixed(0)}px)' 
                    : 'Desktop (${screenWidth.toStringAsFixed(0)}px)';
            
            if (isMobile) {
              // Mobile: single column layout
              return Column(
                children: [
                  // Debug indicator
                  // Container(
                  //   padding: const EdgeInsets.all(AppTheme.spacing8),
                  //   margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary.withValues(alpha: 0.1),
                  //     borderRadius: BorderRadius.circular(AppTheme.radius8),
                  //     border: Border.all(color: AppColors.primary, width: 1),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Icon(Icons.phone_android, size: 16, color: AppColors.primary),
                  //       const SizedBox(width: AppTheme.spacing8),
                  //       Text(
                  //         currentMode,
                  //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  //               color: AppColors.primary,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 12,
                  //             ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ...stats
                      .map((stat) => Padding(
                            padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                            child: _buildStatCard(context, stat),
                          ))
                      ,
                      const SizedBox(height: AppTheme.spacing16),
                ],
              );
            }
            
            // Tablet or Desktop: 2x2 grid layout with responsive height
            // Calculate available width for cards (accounting for spacing)
            final availableWidth = constraints.maxWidth;
            const crossAxisSpacing = AppTheme.spacing12;
            final cardWidth = (availableWidth - crossAxisSpacing) / 2;
            
            // Calculate aspect ratio dynamically based on available space
            // Use minimum card height, but allow it to grow based on content
            // For tablet: prefer taller cards, for desktop: prefer wider cards
            final minCardHeight = isTablet ? 120.0 : 140.0;
            final maxCardHeight = isTablet ? 180.0 : 200.0;
            
            // Calculate aspect ratio based on card width and preferred height
            // This ensures cards can grow but have a reasonable starting point
            final preferredAspectRatio = cardWidth / minCardHeight;
            
            // Use a flexible grid that allows cards to grow
            return Column(
              children: [
                // Debug indicator
                // Container(
                //   padding: const EdgeInsets.all(AppTheme.spacing8),
                //   margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                //   decoration: BoxDecoration(
                //     color: isTablet 
                //         ? AppColors.warning.withValues(alpha: 0.1)
                //         : AppColors.success.withValues(alpha: 0.1),
                //     borderRadius: BorderRadius.circular(AppTheme.radius8),
                //     border: Border.all(
                //       color: isTablet ? AppColors.warning : AppColors.success, 
                //       width: 1,
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         isTablet ? Icons.tablet : Icons.desktop_windows,
                //         size: 16,
                //         color: isTablet ? AppColors.warning : AppColors.success,
                //       ),
                //       const SizedBox(width: AppTheme.spacing8),
                //       Text(
                //         '$currentMode | Card: ${cardWidth.toStringAsFixed(0)}x${minCardHeight.toStringAsFixed(0)}',
                //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //               color: isTablet ? AppColors.warning : AppColors.success,
                //               fontWeight: FontWeight.w600,
                //               fontSize: 12,
                //             ),
                //       ),
                //     ],
                //   ),
                // ),
                // Use Wrap widget for flexible grid that allows natural height
                Wrap(
                  spacing: crossAxisSpacing,
                  runSpacing: AppTheme.spacing12,
                  children: stats.map((stat) => SizedBox(
                      width: cardWidth,
                      child: _buildStatCard(context, stat),
                    )).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingGrid(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppTheme.tabletBreakpoint;
        final isTablet = screenWidth >= AppTheme.tabletBreakpoint && screenWidth < AppTheme.desktopBreakpoint;
        
        if (isMobile) {
          // Mobile: single column layout
          return Column(
            children: List.generate(
              4,
              (index) => const Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacing12),
                child: AppCard(
                  padding: EdgeInsets.all(AppTheme.spacing16),
                  showBorder: true,
                  borderWidth: 1,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        }
        
        // Tablet or Desktop: 2x2 grid layout with responsive sizing
        final availableWidth = constraints.maxWidth;
        const crossAxisSpacing = AppTheme.spacing12;
        final cardWidth = (availableWidth - crossAxisSpacing) / 2;
        
        return Wrap(
          spacing: crossAxisSpacing,
          runSpacing: AppTheme.spacing12,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: cardWidth,
              child: const AppCard(
                padding: EdgeInsets.all(AppTheme.spacing16),
                showBorder: true,
                borderWidth: 1,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
    );

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat) => InkWell(
      onTap: () => _showDetailsDialog(context, stat),
      borderRadius: BorderRadius.circular(AppTheme.radius12),
      child: AppCard(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        showBorder: true,
        borderWidth: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing8),
                  decoration: BoxDecoration(
                    color: (stat['bgColor'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                  ),
                  child: Icon(
                    stat['icon'] as IconData,
                    size: 16,
                    color: stat['color'] as Color,
                  ),
                ),
                IgnorePointer(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'More',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(width: AppTheme.spacing4),
                      const Icon(
                        Icons.chevron_right,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              stat['label'] as String,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  stat['value'] as String,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: stat['color'] as Color,
                      ),
                ),
                const SizedBox(width: AppTheme.spacing4),
                Text(
                  stat['unit'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
            if (stat['subLabel'] != null) ...[
              const SizedBox(height: AppTheme.spacing4),
              Text(
                stat['subLabel'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
              ),
            ],
          ],
        ),
      ),
    );

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> stat) {
    AppDialog.showCenter(
      context: context,
      title: stat['detailTitle'] as String,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (stat['detailItems'] as List<Map<String, String>>)
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label']!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      Text(
                        item['value']!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _calculateStats(List<MeterReadingDto> readings) {
    if (readings.isEmpty) return [];

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
    final previous = sorted.length > 1 ? sorted[sorted.length - 2] : null;

    final currentConsumption = double.tryParse(current.consumption) ?? 0.0;
    // Dollar amounts are hidden in this version. They will be shown in a future release.
    // final currentAmount = double.tryParse(current.amount) ?? 0.0;
    final previousConsumption = previous != null ? (double.tryParse(previous.consumption) ?? 0.0) : 0.0;
    // Dollar amounts are hidden in this version. They will be shown in a future release.
    // final previousAmount = previous != null ? (double.tryParse(previous.amount) ?? 0.0) : 0.0;

    final consumptionDiff = previousConsumption - currentConsumption;
    final savedEnergy = consumptionDiff > 0;

    // Find highest consumption month
    final highestMonth = sorted.reduce((a, b) {
      final aConsumption = double.tryParse(a.consumption) ?? 0.0;
      final bConsumption = double.tryParse(b.consumption) ?? 0.0;
      return aConsumption > bConsumption ? a : b;
    });

    // Calculate average
    final totalConsumption = sorted.fold<double>(
      0,
      (sum, reading) => sum + (double.tryParse(reading.consumption) ?? 0.0),
    );
    final avgConsumption = (totalConsumption / sorted.length).round();

    // Dollar amounts are hidden in this version. They will be shown in a future release.
    // final yearlySpend = sorted.fold<double>(
    //   0,
    //   (sum, reading) => sum + (double.tryParse(reading.amount) ?? 0.0),
    // );

    return [
      {
        'label': 'This Billing Period',
        'value': currentConsumption.toStringAsFixed(0),
        'unit': 'kWh',
        'icon': Icons.bolt,
        'color': AppColors.primary,
        'bgColor': AppColors.primary,
        'detailTitle': 'Current Billing Period Usage',
        'detailItems': [
          {'label': 'Consumption', 'value': '${currentConsumption.toStringAsFixed(0)} kWh'},
          // Dollar amounts are hidden in this version. They will be shown in a future release.
          // {'label': 'Amount', 'value': '\$${currentAmount.toStringAsFixed(2)}'},
          {'label': 'Daily Average', 'value': '${(double.tryParse(current.averageUsage) ?? 0.0).toStringAsFixed(0)} kWh'},
          {'label': 'Billing Days', 'value': '${current.days} days'},
        ],
      },
      {
        'label': 'vs Last Billing Period',
        'value': savedEnergy ? '-${consumptionDiff.abs().toStringAsFixed(0)}' : '+${consumptionDiff.abs().toStringAsFixed(0)}',
        'unit': 'kWh',
        'icon': Icons.trending_up,
        'color': savedEnergy ? AppColors.success : AppColors.error,
        'bgColor': savedEnergy ? AppColors.success : AppColors.error,
        'detailTitle': 'Billing Period Comparison',
        'detailItems': previous != null
            ? [
                {'label': 'Last Billing Period', 'value': '${previousConsumption.toStringAsFixed(0)} kWh'},
                {'label': 'This Billing Period', 'value': '${currentConsumption.toStringAsFixed(0)} kWh'},
                {'label': 'Difference', 'value': '${consumptionDiff.toStringAsFixed(0)} kWh'},
                // Dollar amounts are hidden in this version. They will be shown in a future release.
                // {'label': 'Cost Difference', 'value': '\$${(previousAmount - currentAmount).abs().toStringAsFixed(2)}'},
              ]
            : [
                {'label': 'This Billing Period', 'value': '${currentConsumption.toStringAsFixed(0)} kWh'},
                {'label': 'No previous data', 'value': '-'},
              ],
      },
      {
        'label': 'Peak Billing Period (${highestMonth.readMonth})',
        'value': (double.tryParse(highestMonth.consumption) ?? 0.0).toStringAsFixed(0),
        'unit': 'kWh',
        //'subLabel': highestMonth.readMonth,
        'icon': Icons.local_fire_department,
        'color': AppColors.warning,
        'bgColor': AppColors.warning,
        'detailTitle': 'Peak Usage Billing Period',
        'detailItems': [
          {'label': 'Billing Period', 'value': '${highestMonth.readMonth} ${highestMonth.readYear}'},
          {'label': 'Consumption', 'value': '${highestMonth.consumption} kWh'},
          // Dollar amounts are hidden in this version. They will be shown in a future release.
          // {'label': 'Amount', 'value': '\$${(double.tryParse(highestMonth.amount) ?? 0.0).toStringAsFixed(2)}'},
          {'label': 'Daily Average', 'value': '${highestMonth.averageUsage} kWh'},
        ],
      },
      {
        'label': 'Avg Monthly',
        'value': avgConsumption.toString(),
        'unit': 'kWh',
        'icon': Icons.bar_chart,
        'color': const Color(0xFF8B5CF6),
        'bgColor': const Color(0xFF8B5CF6),
        'detailTitle': 'Average Statistics',
        'detailItems': [
          {'label': 'Avg. Monthly Usage', 'value': '$avgConsumption kWh'},
          // Dollar amounts are hidden in this version. They will be shown in a future release.
          // {'label': 'Yearly Total', 'value': '\$${yearlySpend.toStringAsFixed(2)}'},
          {'label': 'Months Analyzed', 'value': '${sorted.length}'},
          {'label': 'Total kWh', 'value': totalConsumption.toStringAsFixed(0)},
        ],
      },
    ];
  }

  int _getMonthIndex(String month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months.indexOf(month);
  }
}
