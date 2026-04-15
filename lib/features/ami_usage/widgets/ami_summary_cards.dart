import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../ami_usage_page.dart';

class AmiSummaryCards extends StatelessWidget {
  const AmiSummaryCards({
    super.key,
    required this.totalKWh,
    required this.peakKWh,
    required this.peakTime,
    required this.avgKWh,
    required this.filterType,
  });

  final double totalKWh;
  final double peakKWh;
  final String peakTime;
  final double avgKWh;
  final FilterType filterType;

  @override
  Widget build(BuildContext context) {
    final cards = [
      {
        'label': 'Total Usage',
        'value': totalKWh.toStringAsFixed(1),
        'unit': 'kWh',
        'icon': Icons.bolt_outlined,
        'color': AppColors.primary,
        'bgColor': AppColors.primary,
      },
      {
        'label': 'Peak Usage',
        'value': peakKWh.toStringAsFixed(1),
        'unit': 'kWh',
        'subLabel': _getPeakLabel(),
        'icon': Icons.trending_up_outlined,
        'color': AppColors.warning,
        'bgColor': AppColors.warning,
      },
      {
        'label': 'Avg. Usage',
        'value': avgKWh.toStringAsFixed(1),
        'unit': 'kWh',
        'subLabel': _getAvgLabel(),
        'icon': Icons.show_chart_outlined,
        'color': const Color(0xFF8B5CF6),
        'bgColor': const Color(0xFF8B5CF6),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < AppTheme.tabletBreakpoint;
        final isDesktop = screenWidth >= AppTheme.desktopBreakpoint;

        if (isMobile) {
          // Mobile: single column layout
          return Column(
            children: cards
                .map((card) => Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                      child: _buildCard(context, card),
                    ))
                .toList(),
          );
        }

        // Calculate columns based on screen size
        final columns = isDesktop ? 4 : 2;
        final availableWidth = constraints.maxWidth;
        const crossAxisSpacing = AppTheme.spacing12;
        final cardWidth = (availableWidth - (crossAxisSpacing * (columns - 1))) / columns;

        // Use Wrap widget for flexible grid that allows natural height
        return Wrap(
          spacing: crossAxisSpacing,
          runSpacing: AppTheme.spacing12,
          children: cards
              .map((card) => SizedBox(
                    width: cardWidth,
                    child: _buildCard(context, card),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> card) {
    final color = card['color'] as Color;
    final bgColor = card['bgColor'] as Color;
    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                ),
                child: Icon(
                  card['icon'] as IconData,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                card['label'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (card['prefix'] == true)
                    Text(
                      card['unit'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  Text(
                    card['value'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (card['prefix'] != true)
                    Text(
                      ' ${card['unit'] as String}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                ],
              ),
              if (card['subLabel'] != null) ...[
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  card['subLabel'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getPeakLabel() {
    switch (filterType) {
      case FilterType.day:
        return 'at $peakTime';
      case FilterType.week:
      case FilterType.month:
        return 'on $peakTime';
      case FilterType.year:
        return 'in $peakTime';
    }
  }

  String _getAvgLabel() {
    switch (filterType) {
      case FilterType.day:
        return 'per hour';
      case FilterType.week:
      case FilterType.month:
        return 'per day';
      case FilterType.year:
        return 'per month';
    }
  }
}
