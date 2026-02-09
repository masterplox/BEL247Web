import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_text.dart';

class SidebarNavItem extends StatelessWidget {
  const SidebarNavItem({
    super.key,
    required this.label,
    required this.icon,
    this.activeIcon,
    this.isSelected = false,
    this.isExpanded = true,
    this.badge,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final bool isSelected;
  final bool isExpanded;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing8,
        vertical: AppTheme.spacing4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12,
              vertical: AppTheme.spacing12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryLight.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              border: isSelected ? Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)) : null,
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? (activeIcon ?? icon) : icon,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  size: 24,
                ),
                if (isExpanded) ...[
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: AppText(
                      label,
                      style: AppTextStyle.body,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: badge == 'AMI' ? AppColors.primary : AppColors.error,
                        borderRadius: BorderRadius.circular(AppTheme.radius12),
                      ),
                      child: AppText(
                        badge!,
                        style: AppTextStyle.caption,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
}
