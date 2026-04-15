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
      {
        'icon': Icons.kitchen_outlined,
        'text': 'Regular Refrigerator Maintenance Helps',
        'assetPath': 'assets/save_energy_1.jpg',
      },
      {
        'icon': Icons.lightbulb_outline,
        'text': 'Save Energy - Turn off Lights, Fans and TV',
        'assetPath': 'assets/save_energy_2.jpg',
      },
      {
        'icon': Icons.power_off_outlined,
        'text': 'Save Energy - Unplug all Appliances and Electronics',
        'assetPath': 'assets/save_energy_3.jpg',
      },
    ];

    return tips.map((tip) {
      return InkWell(
        onTap: () => _showTipImageDialog(
          context,
          tip['assetPath'] as String,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        child: Container(
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
              Expanded(
                child: Text(
                  tip['text'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Icon(
                Icons.open_in_new,
                size: 16,
                color: AppColors.textSecondary.withValues(alpha: 0.8),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Future<void> _showTipImageDialog(BuildContext context, String imagePath) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(AppTheme.spacing24),
        child: InteractiveViewer(
          minScale: 0.7,
          maxScale: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

}
