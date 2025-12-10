import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_button.dart';

/// A reusable error state widget that displays an error message with an optional retry action.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.icon,
    this.padding,
  });

  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Center(
      child: Card(
        margin: const EdgeInsets.all(AppTheme.spacing16),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTheme.spacing24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon ?? Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: AppTheme.spacing16),
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
              ],
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppTheme.spacing16),
                AppButton(
                  onPressed: onRetry,
                  text: 'Retry',
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ],
          ),
        ),
      ),
    );
}

