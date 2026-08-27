import 'package:intl/intl.dart';

import '../../data/models/bill.dart';

/// Utility class for formatting dates, times, amounts, and other common data types.
class FormattingUtils {
  FormattingUtils._(); // Private constructor to prevent instantiation

  // Date formatting
  /// Formats a date as "DD MMM YYYY" (e.g., "15 Jan 2024")
  static String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Formats a date as "DD/MM/YYYY"
  static String formatDateShort(DateTime date) => '${date.day}/${date.month}/${date.year}';

  /// Formats a date with relative time (Today, Yesterday, X days ago, etc.)
  static String formatDateRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final difference = dateOnly.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 0) {
      return 'In $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }

  /// Formats a date for alert timestamps (Just now, Xm ago, Xh ago, Xd ago)
  static String formatAlertTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  /// Formats a billing period as "MMMM YYYY" (e.g., "January 2024")
  static String formatBillingPeriod(BillingPeriod period) {
    final monthName = DateFormat('MMMM').format(period.startDate);
    final year = period.startDate.year;
    return '$monthName $year';
  }

  /// Formats a billing period in detail as "D MMM YYYY - D MMM YYYY"
  static String formatBillingPeriodDetailed(BillingPeriod period) {
    final formatter = DateFormat('d MMM yyyy');
    return '${formatter.format(period.startDate)} - ${formatter.format(period.endDate)}';
  }

  /// Formats an hour as "HH:00" or "HH:45" for intervals
  static String formatHour(int hour, {bool isInterval = false}) {
    if (isInterval) {
      return '${hour.toString().padLeft(2, '0')}:45';
    }
    return '${hour.toString().padLeft(2, '0')}:00';
  }

  // Amount formatting
  /// Formats an amount as currency with BZ$ prefix
  static String formatAmount(double amount) {
    final absAmount = amount.abs();
    if (amount < 0) {
      return '-BZ\$${absAmount.toStringAsFixed(2)}';
    } else {
      return 'BZ\$${absAmount.toStringAsFixed(2)}';
    }
  }

  /// Formats an amount as currency without sign handling
  static String formatCurrency(double amount) => 'BZ\$${amount.toStringAsFixed(2)}';

  /// Formats kWh as a whole number with unit (e.g. "738 kWh").
  static String formatKwh(double kwh) => '${formatKwhNumber(kwh)} kWh';

  /// Formats kWh as a whole number with no unit.
  static String formatKwhNumber(double kwh) => kwh.round().toString();

  /// Formats kWh preserving the API's natural precision (e.g. 22.567 -> "22.567 kWh",
  /// 22.0 -> "22 kWh"). Trailing zeros are trimmed.
  static String formatKwhExact(double kwh) => '${formatKwhNumberExact(kwh)} kWh';

  /// Formats kWh preserving natural precision, no unit. Trailing zeros trimmed.
  static String formatKwhNumberExact(double kwh) {
    final s = kwh.toString();
    if (!s.contains('.')) return s;
    final trimmed = s.replaceFirst(RegExp(r'0+$'), '');
    return trimmed.endsWith('.') ? trimmed.substring(0, trimmed.length - 1) : trimmed;
  }

  /// Formats kWh with at most 3 decimal places (e.g. 5.308999... -> "5.309 kWh").
  static String formatKwhMax3(double kwh) => '${formatKwhNumberMax3(kwh)} kWh';

  /// Formats kWh with at most 3 decimal places, no unit. Trailing zeros trimmed.
  static String formatKwhNumberMax3(double kwh) {
    var s = kwh.toStringAsFixed(3);
    s = s.replaceFirst(RegExp(r'0+$'), '');
    if (s.endsWith('.')) s = s.substring(0, s.length - 1);
    return s;
  }

  // Time formatting
  /// Formats time as "HH:mm"
  static String formatTime(DateTime dateTime) => '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

  // Month name helpers
  /// Gets abbreviated month name (Jan, Feb, etc.)
  static String getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  /// Gets full month name (January, February, etc.)
  static String getMonthNameFull(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}

