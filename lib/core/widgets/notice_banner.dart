import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../providers/feature_providers.dart';

/// Persistent notice banner that appears at the top of all pages
class NoticeBanner extends ConsumerWidget {
  const NoticeBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeState = ref.watch(noticeBannerProvider);

    if (!noticeState.isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF4E6), // Light orange/cream background
        border: Border(
          top: BorderSide(
            color: Color(0xFFFF8C42), // Darker orange border
            width: 1,
          ),
          bottom: BorderSide(
            color: Color(0xFFFF8C42), // Darker orange border
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing12,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD97706), // Dark orange
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: Color(0xFFD97706), // Dark orange
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              // Message
              Expanded(
                child: Text(
                  noticeState.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF9A3412), // Dark orange/brown text
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              // Close button
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: Color(0xFF9A3412), // Dark orange/brown
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                onPressed: () {
                  ref.read(noticeBannerProvider.notifier).hide();
                },
                tooltip: 'Dismiss',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

