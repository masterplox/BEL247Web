import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

/// A reusable page header widget that displays a title and optional subtitle.
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 640;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: isNarrow ? 20 : 28,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (actions != null)
                    Flexible(
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: AppTheme.spacing8,
                        runSpacing: AppTheme.spacing8,
                        children: actions!,
                      ),
                    ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppTheme.spacing8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          );
        },
      );
}

