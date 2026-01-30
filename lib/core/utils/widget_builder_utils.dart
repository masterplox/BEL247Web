import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/bill.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../widgets/app_detail_row.dart';

/// Utility class for building common widget patterns.
class WidgetBuilderUtils {
  WidgetBuilderUtils._(); // Private constructor to prevent instantiation

  /// Builds a date icon widget for bills (document icon) or payments (check icon)
  static Widget buildDateIcon(BuildContext context, bool isPayment) {
    if (isPayment) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.payment,
          size: 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    } else {
      return Icon(
        Icons.receipt_long,
        color: Theme.of(context).colorScheme.secondary,
        size: 24,
      );
    }
  }

  /// Builds a detail row for displaying key-value pairs
  static Widget buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) => AppDetailRow(
      label: label,
      value: value,
      isTotal: isTotal,
    );

  /// Builds a status chip widget
  static Widget buildStatusChip(
    BuildContext context,
    String text,
    Color color,
  ) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing8,
        vertical: AppTheme.spacing4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius4),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );

  /// Gets balance color based on balance amount
  /// Note: Positive balance means amount owed (error), negative means credit (success)
  static Color getBalanceColor(BuildContext context, double balance) {
    if (balance == 0) {
      return AppColors.success;
    } else if (balance > 0) {
      // Positive balance means we owe money
      return Theme.of(context).colorScheme.error;
    } else {
      // Negative balance means credit
      return Theme.of(context).colorScheme.primary;
    }
  }

  /// Gets balance icon based on balance amount
  static IconData getBalanceIcon(double balance) {
    if (balance == 0) {
      return Icons.check_circle;
    } else if (balance > 0) {
      return Icons.warning;
    } else {
      return Icons.check_circle;
    }
  }

  /// Gets balance status text
  static String getBalanceStatusText(double balance) {
    if (balance == 0) {
      return 'Current';
    } else if (balance > 0) {
      return 'Amount Due';
    } else {
      return 'Credit';
    }
  }

  /// Gets payment method icon (accepts both String and enum-like values)
  static IconData getPaymentMethodIcon(dynamic method) {
    final methodStr = method.toString().toLowerCase();
    if (methodStr.contains('credit') || methodStr.contains('card')) {
      return Icons.credit_card;
    } else if (methodStr.contains('transfer') || methodStr.contains('bank')) {
      return Icons.account_balance;
    } else if (methodStr.contains('cash')) {
      return Icons.money;
    } else if (methodStr.contains('check') || methodStr.contains('cheque')) {
      return Icons.description;
    } else {
      return Icons.payment;
    }
  }

  /// Gets payment method label (accepts both String and enum-like values)
  static String getPaymentMethodLabel(dynamic method) {
    final methodStr = method.toString().toLowerCase();
    if (methodStr.contains('credit') || methodStr.contains('card')) {
      return 'Credit Card';
    } else if (methodStr.contains('transfer') || methodStr.contains('bank')) {
      return 'Bank Transfer';
    } else if (methodStr.contains('cash')) {
      return 'Cash';
    } else if (methodStr.contains('check') || methodStr.contains('cheque')) {
      return 'Check';
    } else {
      return method.toString();
    }
  }

  /// Gets payment status color
  static Color getPaymentStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return AppColors.success;
      case PaymentStatus.overdue:
        return AppColors.error;
      case PaymentStatus.dueSoon:
        return AppColors.warning;
      case PaymentStatus.pending:
        return AppColors.info;
      default:
        return AppColors.textPrimary;
    }
  }

  /// Gets payment status text
  static String getPaymentStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return 'Paid';
      case PaymentStatus.overdue:
        return 'Overdue';
      case PaymentStatus.dueSoon:
        return 'Due Soon';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  /// Configuration class for chart tooltips
  static ChartTooltipConfig getDefaultTooltipConfig(BuildContext context) => const ChartTooltipConfig(
      backgroundColor: AppColors.grey800,
      textColor: AppColors.white,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      borderRadius: AppTheme.radius8,
      padding: EdgeInsets.all(AppTheme.spacing8),
      margin: 8,
    );

  /// Builds a LineTouchTooltipData with default styling and optional customization
  static LineTouchTooltipData buildLineTooltipData(
    BuildContext context, {
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderRadius,
    EdgeInsets? padding,
    double? margin,
    Color Function(LineBarSpot)? getTooltipColor,
    required List<LineTooltipItem?> Function(List<LineBarSpot>) getTooltipItems,
  }) {
    final config = getDefaultTooltipConfig(context);
    
    return LineTouchTooltipData(
      getTooltipColor: getTooltipColor ?? ((_) => backgroundColor ?? config.backgroundColor),
      tooltipRoundedRadius: borderRadius ?? config.borderRadius,
      tooltipPadding: padding ?? config.padding,
      tooltipMargin: margin ?? config.margin,
      getTooltipItems: (touchedSpots) {
        final items = getTooltipItems(touchedSpots);
        // Apply default text styling, merging with existing styles
        // Filter out null items and apply styling
        return items.whereType<LineTooltipItem>().map((item) {
          final existingStyle = item.textStyle;
          return LineTooltipItem(
            item.text,
            existingStyle.copyWith(
              color: textColor ?? existingStyle.color ?? config.textColor,
              fontSize: fontSize ?? existingStyle.fontSize ?? config.fontSize,
              fontWeight: fontWeight ?? existingStyle.fontWeight ?? config.fontWeight,
            ),
          );
        }).toList();
      },
    );
  }

  /// Builds a BarTouchTooltipData with default styling and optional customization
  static BarTouchTooltipData buildBarTooltipData(
    BuildContext context, {
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderRadius,
    EdgeInsets? padding,
    Color Function(BarChartGroupData)? getTooltipColor,
    required BarTooltipItem Function(
      BarChartGroupData,
      int,
      BarChartRodData,
      int,
    ) getTooltipItem,
  }) {
    final config = getDefaultTooltipConfig(context);
    
    return BarTouchTooltipData(
      getTooltipColor: getTooltipColor ?? ((_) => backgroundColor ?? config.backgroundColor),
      tooltipRoundedRadius: borderRadius ?? config.borderRadius,
      tooltipPadding: padding ?? config.padding,
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        final item = getTooltipItem(group, groupIndex, rod, rodIndex);
        // Apply default text styling, merging with existing styles
        final existingStyle = item.textStyle;
        return BarTooltipItem(
          item.text,
          existingStyle.copyWith(
            color: textColor ?? existingStyle.color ?? config.textColor,
            fontSize: fontSize ?? existingStyle.fontSize ?? config.fontSize,
            fontWeight: fontWeight ?? existingStyle.fontWeight ?? config.fontWeight,
          ),
        );
      },
    );
  }

  /// Calculates responsive interval for chart x-axis labels based on screen width
  /// Returns an interval that ensures labels don't overlap and look good on all screen sizes
  /// 
  /// [screenWidth] - Current screen width
  /// [chartWidth] - Width of the chart (can be null to use screen width)
  /// [maxValue] - Maximum x-axis value (e.g., 23 for hours, or data length)
  /// [minLabelSpacing] - Minimum spacing between labels in pixels (default: 60)
  /// [defaultInterval] - Default interval to use if calculation fails
  static double calculateResponsiveInterval({
    required double screenWidth,
    double? chartWidth,
    required double maxValue,
    double minLabelSpacing = 60,
    double? defaultInterval,
  }) {
    // Use chart width if provided, otherwise estimate based on screen width
    // Account for padding and margins (roughly 80% of screen width for chart area)
    final effectiveWidth = chartWidth ?? (screenWidth * 0.8);
    
    // Calculate how many labels can fit
    final maxLabels = (effectiveWidth / minLabelSpacing).floor();
    
    // Ensure at least 2 labels and at most maxValue labels
    final targetLabels = maxLabels.clamp(2, maxValue.ceil());
    
    // Calculate interval to show targetLabels
    // If we want N labels over maxValue range, interval = maxValue / (N - 1)
    final calculatedInterval = maxValue / (targetLabels - 1);
    
    // Round to nearest reasonable interval (1, 2, 3, 4, 5, 6, 12, etc.)
    double interval;
    if (calculatedInterval <= 1) {
      interval = 1;
    } else if (calculatedInterval <= 2) {
      interval = 2;
    } else if (calculatedInterval <= 3) {
      interval = 3;
    } else if (calculatedInterval <= 4) {
      interval = 4;
    } else if (calculatedInterval <= 6) {
      interval = 6;
    } else if (calculatedInterval <= 12) {
      interval = 12;
    } else {
      interval = calculatedInterval.ceil().toDouble();
    }
    
    // Ensure interval doesn't exceed maxValue
    interval = interval.clamp(1, maxValue);
    
    return defaultInterval ?? interval;
  }
}

/// Configuration class for chart tooltip styling
class ChartTooltipConfig {

  const ChartTooltipConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    required this.borderRadius,
    required this.padding,
    required this.margin,
  });
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final EdgeInsets padding;
  final double margin;
}

