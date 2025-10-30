import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/feature_providers.dart';

/// Helper class for managing the notice banner
class NoticeBannerHelper {
  /// Show a notice banner with a message
  /// 
  /// Example:
  /// ```dart
  /// NoticeBannerHelper.show(
  ///   ref,
  ///   'Scheduled maintenance in Belize City area on Oct 5, 2025, 6:00 AM - 10:00 AM',
  /// );
  /// ```
  static void show(WidgetRef ref, String message) {
    ref.read(noticeBannerProvider.notifier).show(message);
  }

  /// Hide the notice banner
  /// 
  /// Example:
  /// ```dart
  /// NoticeBannerHelper.hide(ref);
  /// ```
  static void hide(WidgetRef ref) {
    ref.read(noticeBannerProvider.notifier).hide();
  }

  /// Update the message in the currently visible banner
  /// 
  /// Example:
  /// ```dart
  /// NoticeBannerHelper.updateMessage(
  ///   ref,
  ///   'Maintenance extended until 11:00 AM',
  /// );
  /// ```
  static void updateMessage(WidgetRef ref, String message) {
    ref.read(noticeBannerProvider.notifier).updateMessage(message);
  }

  /// Check if the banner is currently visible
  /// 
  /// Example:
  /// ```dart
  /// final isVisible = NoticeBannerHelper.isVisible(ref);
  /// ```
  static bool isVisible(WidgetRef ref) => ref.read(noticeBannerProvider).isVisible;

  /// Get the current message
  /// 
  /// Example:
  /// ```dart
  /// final message = NoticeBannerHelper.getMessage(ref);
  /// ```
  static String getMessage(WidgetRef ref) => ref.read(noticeBannerProvider).message;

  /// Show a maintenance notice
  /// 
  /// Example:
  /// ```dart
  /// NoticeBannerHelper.showMaintenanceNotice(
  ///   ref,
  ///   location: 'Belize City area',
  ///   date: DateTime(2025, 10, 5),
  ///   startTime: TimeOfDay(hour: 6, minute: 0),
  ///   endTime: TimeOfDay(hour: 10, minute: 0),
  /// );
  /// ```
  static void showMaintenanceNotice(
    WidgetRef ref, {
    required String location,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    final formattedDate = '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    final startHour12 = startTime.hourOfPeriod;
    final startMinute = startTime.minute.toString().padLeft(2, '0');
    final startPeriod = startTime.period == DayPeriod.am ? 'AM' : 'PM';
    final startTimeStr = '$startHour12:$startMinute $startPeriod';
    
    final endHour12 = endTime.hourOfPeriod;
    final endMinute = endTime.minute.toString().padLeft(2, '0');
    final endPeriod = endTime.period == DayPeriod.am ? 'AM' : 'PM';
    final endTimeStr = '$endHour12:$endMinute $endPeriod';
    
    final message = 'Scheduled maintenance in $location on $formattedDate, $startTimeStr - $endTimeStr';
    show(ref, message);
  }

  /// Show a power outage notice
  /// 
  /// Example:
  /// ```dart
  /// NoticeBannerHelper.showOutageNotice(
  ///   ref,
  ///   location: 'Orange Walk District',
  ///   estimatedRestore: DateTime.now().add(Duration(hours: 2)),
  /// );
  /// ```
  static void showOutageNotice(
    WidgetRef ref, {
    required String location,
    required DateTime estimatedRestore,
  }) {
    final formattedTime = '${estimatedRestore.hour.toString().padLeft(2, '0')}:${estimatedRestore.minute.toString().padLeft(2, '0')}';
    final message = 'Power outage reported in $location. Estimated restoration: $formattedTime';
    show(ref, message);
  }

  static String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}

