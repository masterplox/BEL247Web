import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

enum AlertBannerType {
  info,
  warning,
  error,
  success,
}

enum AlertBannerPosition {
  top,
  bottom,
}

class AlertBannerWidget extends StatefulWidget {
  const AlertBannerWidget({
    super.key,
    required this.message,
    this.title,
    this.type = AlertBannerType.info,
    this.position = AlertBannerPosition.top,
    this.dismissible = true,
    this.onDismiss,
    this.action,
    this.duration,
    this.showIcon = true,
  });

  final String message;
  final String? title;
  final AlertBannerType type;
  final AlertBannerPosition position;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final Widget? action;
  final Duration? duration;
  final bool showIcon;

  @override
  State<AlertBannerWidget> createState() => _AlertBannerWidgetState();
}

class _AlertBannerWidgetState extends State<AlertBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: widget.position == AlertBannerPosition.top ? -1.0 : 1.0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    // Auto-dismiss after duration
    if (widget.duration != null) {
      Future.delayed(widget.duration!, () {
        if (mounted) {
          dismiss();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void dismiss() {
    _animationController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, widget.position == AlertBannerPosition.top ? -1 : 1),
            end: Offset.zero,
          ).animate(_slideAnimation),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildBanner(context),
          ),
        ),
    );

  Widget _buildBanner(BuildContext context) {
    final colors = _getColors();
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.dismissible ? dismiss : null,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            child: Row(
              children: [
                if (widget.showIcon) ...[
                  Icon(
                    _getIcon(),
                    color: colors.icon,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null) ...[
                        Text(
                          widget.title!,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: colors.text,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: AppTheme.spacing8),
                      ],
                      Text(
                        widget.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.text,
                            ),
                      ),
                    ],
                  ),
                ),
                if (widget.action != null) ...[
                  const SizedBox(width: AppTheme.spacing8),
                  widget.action!,
                ],
                if (widget.dismissible) ...[
                  const SizedBox(width: AppTheme.spacing8),
                  IconButton(
                    onPressed: dismiss,
                    icon: const Icon(Icons.close, size: 18),
                    color: colors.icon,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
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

  IconData _getIcon() {
    switch (widget.type) {
      case AlertBannerType.info:
        return Icons.info_outline;
      case AlertBannerType.warning:
        return Icons.warning_outlined;
      case AlertBannerType.error:
        return Icons.error_outline;
      case AlertBannerType.success:
        return Icons.check_circle_outline;
    }
  }

  _AlertBannerColors _getColors() {
    switch (widget.type) {
      case AlertBannerType.info:
        return _AlertBannerColors(
          background: AppColors.primaryLight.withValues(alpha: 0.1),
          border: AppColors.primaryLight,
          icon: AppColors.primary,
          text: AppColors.textPrimary,
          shadow: AppColors.primary.withValues(alpha: 0.1),
        );
      case AlertBannerType.warning:
        return _AlertBannerColors(
          background: AppColors.warning.withValues(alpha: 0.1),
          border: AppColors.warning,
          icon: AppColors.warning,
          text: AppColors.textPrimary,
          shadow: AppColors.warning.withValues(alpha: 0.1),
        );
      case AlertBannerType.error:
        return _AlertBannerColors(
          background: AppColors.error.withValues(alpha: 0.1),
          border: AppColors.error,
          icon: AppColors.error,
          text: AppColors.textPrimary,
          shadow: AppColors.error.withValues(alpha: 0.1),
        );
      case AlertBannerType.success:
        return _AlertBannerColors(
          background: AppColors.success.withValues(alpha: 0.1),
          border: AppColors.success,
          icon: AppColors.success,
          text: AppColors.textPrimary,
          shadow: AppColors.success.withValues(alpha: 0.1),
        );
    }
  }
}

class _AlertBannerColors {
  const _AlertBannerColors({
    required this.background,
    required this.border,
    required this.icon,
    required this.text,
    required this.shadow,
  });

  final Color background;
  final Color border;
  final Color icon;
  final Color text;
  final Color shadow;
}

/// Alert banner manager for showing multiple banners
class AlertBannerManager extends StatefulWidget {
  const AlertBannerManager({
    super.key,
    required this.child,
    this.position = AlertBannerPosition.top,
  });

  final Widget child;
  final AlertBannerPosition position;

  @override
  State<AlertBannerManager> createState() => _AlertBannerManagerState();
}

class _AlertBannerManagerState extends State<AlertBannerManager> {
  final List<AlertBannerWidget> _banners = [];

  void showBanner(AlertBannerWidget banner) {
    setState(() {
      _banners.add(banner);
    });
  }

  void dismissBanner(AlertBannerWidget banner) {
    setState(() {
      _banners.remove(banner);
    });
  }

  void dismissAllBanners() {
    setState(_banners.clear);
  }

  @override
  Widget build(BuildContext context) => Stack(
      children: [
        widget.child,
        if (_banners.isNotEmpty)
          Positioned(
            top: widget.position == AlertBannerPosition.top ? 0 : null,
            bottom: widget.position == AlertBannerPosition.bottom ? 0 : null,
            left: 0,
            right: 0,
            child: Column(
              children: _banners.map((banner) => Padding(
                  padding: const EdgeInsets.only(
                    top: AppTheme.spacing8,
                    bottom: AppTheme.spacing8,
                  ),
                  child: AlertBannerWidget(
                    message: banner.message,
                    title: banner.title,
                    type: banner.type,
                    position: banner.position,
                    dismissible: banner.dismissible,
                    onDismiss: () => dismissBanner(banner),
                    action: banner.action,
                    duration: banner.duration,
                    showIcon: banner.showIcon,
                  ),
                )).toList(),
            ),
          ),
      ],
    );
}

/// Predefined alert banners for common use cases
class SystemAlertBanners {
  static AlertBannerWidget highUsageAlert(double usage, double average) {
    final percentage = ((usage - average) / average * 100).toStringAsFixed(1);
    return AlertBannerWidget(
      message: 'Your usage is $percentage% above average. Consider reducing consumption during peak hours.',
      title: 'High Usage Alert',
      type: AlertBannerType.warning,
      duration: const Duration(seconds: 10),
    );
  }

  static AlertBannerWidget billDueAlert(DateTime dueDate) {
    final daysUntilDue = dueDate.difference(DateTime.now()).inDays;
    return AlertBannerWidget(
      message: 'Your bill is due in $daysUntilDue days. Consider setting up AutoPay for convenience.',
      title: 'Bill Due Soon',
      type: AlertBannerType.info,
      duration: const Duration(seconds: 8),
    );
  }

  static AlertBannerWidget maintenanceAlert(String message) => AlertBannerWidget(
      message: message,
      title: 'System Maintenance',
      type: AlertBannerType.info,
      duration: const Duration(seconds: 15),
    );

  static AlertBannerWidget outageAlert(String area, DateTime estimatedRestore) => AlertBannerWidget(
      message: 'Power outage reported in $area. Estimated restoration: ${estimatedRestore.toString()}',
      title: 'Power Outage',
      type: AlertBannerType.error,
      dismissible: false,
    );

  static AlertBannerWidget efficiencyTip(String tip) => AlertBannerWidget(
      message: tip,
      title: 'Energy Saving Tip',
      type: AlertBannerType.success,
      duration: const Duration(seconds: 12),
    );
}
