import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable alert item widget for displaying individual alerts/notifications.
class AppAlertItem extends StatelessWidget {
  const AppAlertItem({
    super.key,
    required this.message,
    required this.timestamp,
    required this.severityColor,
    required this.icon,
    this.isRead = false,
    this.onMarkRead,
    this.onTap,
  });

  final String message;
  final String timestamp;
  final Color severityColor;
  final IconData icon;
  final bool isRead;
  final VoidCallback? onMarkRead;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: severityColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: severityColor.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        child: Row(
          children: [
            Icon(
              icon,
              color: severityColor,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacing8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    timestamp,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (!isRead && onMarkRead != null)
              IconButton(
                onPressed: onMarkRead,
                icon: const Icon(Icons.check, size: 16),
                color: Theme.of(context).textTheme.bodySmall?.color,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              ),
          ],
        ),
      ),
    );
}

