import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
  
  /// Capitalizes the first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
  
  /// Checks if the string is a valid email
  bool isValidEmail() => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  
  /// Checks if the string is a valid phone number
  bool isValidPhone() => RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(this);
  
  /// Removes all whitespace from the string
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');
  
  /// Truncates the string to the specified length and adds ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension BuildContextExtensions on BuildContext {
  /// Gets the current theme
  ThemeData get theme => Theme.of(this);
  
  /// Gets the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;
  
  /// Gets the current text theme
  TextTheme get textTheme => theme.textTheme;
  
  /// Gets the screen size
  Size get screenSize => MediaQuery.of(this).size;
  
  /// Gets the screen width
  double get screenWidth => screenSize.width;
  
  /// Gets the screen height
  double get screenHeight => screenSize.height;
  
  /// Checks if the screen is mobile
  bool get isMobile => screenWidth < 480;
  
  /// Checks if the screen is tablet
  bool get isTablet => screenWidth >= 480 && screenWidth < 1200;
  
  /// Checks if the screen is desktop
  bool get isDesktop => screenWidth >= 1200;
  
  /// Shows a snackbar with the given message
  void showSnackBar(String message, {Color? backgroundColor, Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
  
  /// Shows an error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: colorScheme.error);
  }
  
  /// Shows a success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }
}

extension DateTimeExtensions on DateTime {
  /// Formats the date as a string
  String formatDate([String pattern = 'MMM dd, yyyy']) {
    // This would typically use intl package, but for now return a simple format
    return '$day/${month.toString().padLeft(2, '0')}/$year';
  }
  
  /// Formats the time as a string
  String formatTime([String pattern = 'HH:mm']) => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  
  /// Checks if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Checks if the date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
  
  /// Gets the start of the day
  DateTime get startOfDay => DateTime(year, month, day);
  
  /// Gets the end of the day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}

extension ListExtensions<T> on List<T> {
  /// Safely gets an element at the specified index
  T? safeGet(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }
  
  /// Checks if the list is not empty
  bool get isNotEmpty => length > 0;
  
  /// Gets the first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;
  
  /// Gets the last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;
}
