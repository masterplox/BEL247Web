/// Reusable date limits for AMI (Smart Meter) usage filters.
///
/// Change [amiUsageFirstBlockedDate] in one place to control which days are
/// blocked across all pickers (day, week range, month, year). Every day on or
/// after [amiUsageFirstBlockedDate] is not selectable; [lastSelectableDate] is
/// the latest day the user can pick.
class AmiUsageDateLimits {
  AmiUsageDateLimits._();

  /// First day that is blocked (user cannot select this day or any day after).
  /// Change this to control cutoff for all AMI date pickers.
  /// Default: today (so today and future are blocked).
  static DateTime get amiUsageFirstBlockedDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Latest date the user is allowed to select (day before [amiUsageFirstBlockedDate]).
  static DateTime get lastSelectableDate => amiUsageFirstBlockedDate.subtract(const Duration(days: 1));
}
