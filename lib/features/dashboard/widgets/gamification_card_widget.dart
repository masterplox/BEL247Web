import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
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

        return AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          showBorder: true,
          borderWidth: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      {'icon': Icons.bolt, 'text': 'Turn off AC when away'},
      {'icon': Icons.lightbulb_outline, 'text': 'Use LED bulbs'},
      {'icon': Icons.local_laundry_service, 'text': 'Wash clothes cold'},
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
      );
    }).toList();
  }

}
