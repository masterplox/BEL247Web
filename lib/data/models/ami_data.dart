/// AMI (Advanced Metering Infrastructure) data models and utilities
/// Similar to energy-customer-dashboard/lib/ami-data.ts
library;

import 'dart:math';

/// Time of Use periods
class TimeOfUse {
  static const offPeak = TimeOfUsePeriod(
    start: 0,
    end: 10,
    label: 'Off-Peak',
  ); // 12am-10am
  static const peak = TimeOfUsePeriod(
    start: 11,
    end: 20,
    label: 'Peak',
  ); // 11am-8pm
  static const midPeak = TimeOfUsePeriod(
    start: 21,
    end: 23,
    label: 'Mid-Peak',
  ); // 9pm-11pm
}

class TimeOfUsePeriod {

  const TimeOfUsePeriod({
    required this.start,
    required this.end,
    required this.label,
  });
  final int start;
  final int end;
  final String label;
}

const double ratePerKwh = 0.32; // $0.32 per kWh

/// AMI Interval Data (15-minute intervals)
class IntervalReading {

  IntervalReading({
    required this.readDate,
    required this.meterId,
    required this.firstIntervalDateTime,
    required this.intervalDateTime,
    required this.intervalNumber,
    required this.value,
  });
  final String readDate;
  final String meterId;
  final String firstIntervalDateTime;
  final String intervalDateTime;
  final int intervalNumber;
  final String value;
}

/// Daily Reads Data
class DailyReading {

  DailyReading({
    required this.meter,
    required this.readDate,
    required this.kWhUsed,
    this.missing = false,
  });
  final String meter;
  final String readDate;
  final String kWhUsed;
  /// True when this entry was synthesized to fill a gap (meter read not yet received).
  final bool missing;
}

/// Hourly aggregated data
class HourlyData {

  HourlyData({
    required this.hour,
    required this.kWh,
    required this.time,
    this.missing = false,
  });
  final int hour;
  final double kWh;
  final String time;
  /// True when this entry was synthesized to fill a gap (no interval reads for this hour).
  final bool missing;
}

/// Formats hour (0–23) as a display string e.g. "12 AM", "3 PM".
String hourLabel(int h) {
  if (h == 0) return '12 AM';
  if (h < 12) return '$h AM';
  if (h == 12) return '12 PM';
  return '${h - 12} PM';
}

/// Statistics for hourly data
class HourlyStats {

  HourlyStats({
    required this.totalKWh,
    required this.estimatedCost,
    required this.avgKWh,
    required this.peakKWh,
    required this.peakTime,
    required this.peakHour,
  });
  final double totalKWh;
  final double estimatedCost;
  final double avgKWh;
  final double peakKWh;
  final String peakTime;
  final int peakHour;
}

/// Statistics for daily data
class DailyStats {

  DailyStats({
    required this.totalKWh,
    required this.estimatedCost,
    required this.avgKWh,
    required this.peakKWh,
    required this.peakDate,
  });
  final double totalKWh;
  final double estimatedCost;
  final double avgKWh;
  final double peakKWh;
  final String peakDate;
}

/// Date range helper
class DateRange {

  DateRange({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
}

/// Generate mock interval data for a specific date (96 intervals = 24 hours * 4 per hour)
List<IntervalReading> generateIntervalData(DateTime date, {String meterId = '22500345'}) {
  final intervals = <IntervalReading>[];
  final dateStr = date.toIso8601String().split('T')[0];
  final random = Random();

  for (int i = 0; i < 96; i++) {
    final hour = i ~/ 4;
    final minute = (i % 4) * 15;
    final intervalTime = DateTime(date.year, date.month, date.day, hour, minute);

    // Simulate usage patterns - higher during peak hours
    double baseValue = 0.1;
    if (hour >= 6 && hour <= 9) baseValue = 0.4; // Morning peak
    if (hour >= 11 && hour <= 14) baseValue = 0.5; // Midday peak
    if (hour >= 17 && hour <= 21) baseValue = 0.6; // Evening peak
    if (hour >= 0 && hour <= 5) baseValue = 0.05; // Night low

    // Add some randomness
    final value = baseValue + (random.nextDouble() * 0.2 - 0.1);

    intervals.add(IntervalReading(
      readDate: '$dateStr 13:04:00.000',
      meterId: meterId,
      firstIntervalDateTime: '$dateStr 00:00:00.000',
      intervalDateTime: intervalTime.toIso8601String().replaceAll('T', ' ').replaceAll('Z', '.000'),
      intervalNumber: i + 1,
      value: (value < 0 ? 0 : value).toStringAsFixed(4),
    ));
  }

  return intervals;
}

/// Aggregate 15-min intervals to hourly data
List<HourlyData> aggregateToHourly(List<IntervalReading> intervals) {
  final hourlyData = <HourlyData>[];

  for (int hour = 0; hour < 24; hour++) {
    final hourIntervals = intervals.where((interval) {
      try {
        final intervalDateTime = interval.intervalDateTime.replaceAll(' ', 'T');
        final dateTime = DateTime.parse(intervalDateTime);
        return dateTime.hour == hour;
      } catch (e) {
        return false;
      }
    }).toList();

    final totalKWh = hourIntervals.fold<double>(
      0,
      (sum, i) => sum + (double.tryParse(i.value) ?? 0),
    );

    String timeLabel;
    if (hour == 0) {
      timeLabel = '12 AM';
    } else if (hour < 12) {
      timeLabel = '$hour AM';
    } else if (hour == 12) {
      timeLabel = '12 PM';
    } else {
      timeLabel = '${hour - 12} PM';
    }

    hourlyData.add(HourlyData(
      hour: hour,
      kWh: double.parse(totalKWh.toStringAsFixed(3)),
      time: timeLabel,
      missing: hourIntervals.isEmpty,
    ));
  }

  return hourlyData;
}

/// Generate daily readings for a date range
List<DailyReading> generateDailyReadings(DateTime startDate, int days, {String meterId = '22500345'}) {
  final readings = <DailyReading>[];
  final random = Random();

  for (int i = 0; i < days; i++) {
    final date = DateTime(startDate.year, startDate.month, startDate.day + i);

    // Simulate daily usage (15-35 kWh typical residential)
    final dayOfWeek = date.weekday;
    double baseUsage = 22;
    if (dayOfWeek == DateTime.sunday || dayOfWeek == DateTime.saturday) {
      baseUsage = 28; // Weekends higher
    }

    final usage = baseUsage + (random.nextDouble() * 10 - 5);

    readings.add(DailyReading(
      meter: meterId,
      readDate: '${date.toIso8601String().split('T')[0]} 00:00:00.000',
      kWhUsed: usage.toStringAsFixed(3),
    ));
  }

  return readings;
}

/// Get time of use period for an hour
TimeOfUsePeriod getTimeOfUsePeriod(int hour) {
  if (hour >= 0 && hour <= 10) return TimeOfUse.offPeak;
  if (hour >= 11 && hour <= 20) return TimeOfUse.peak;
  return TimeOfUse.midPeak;
}

/// Result of TOU aggregation (kWh per period)
class TouConsumption {
  const TouConsumption({
    required this.offPeakKwh,
    required this.peakKwh,
    required this.midPeakKwh,
  });
  final double offPeakKwh;
  final double peakKwh;
  final double midPeakKwh;
}

/// Compute cumulative TOU consumption from hourly data
TouConsumption computeTouFromHourly(List<HourlyData> hourlyData) {
  double off = 0, peak = 0, mid = 0;
  for (final h in hourlyData) {
    final period = getTimeOfUsePeriod(h.hour);
    if (period == TimeOfUse.offPeak) off += h.kWh;
    else if (period == TimeOfUse.peak) peak += h.kWh;
    else mid += h.kWh;
  }
  return TouConsumption(
    offPeakKwh: off,
    peakKwh: peak,
    midPeakKwh: mid,
  );
}

/// Compute cumulative TOU from (hour, kWh) pairs (e.g. from interval data)
TouConsumption computeTouFromHourKwh(List<(int hour, double kwh)> pairs) {
  double off = 0, peak = 0, mid = 0;
  for (final p in pairs) {
    final period = getTimeOfUsePeriod(p.$1);
    if (period == TimeOfUse.offPeak) off += p.$2;
    else if (period == TimeOfUse.peak) peak += p.$2;
    else mid += p.$2;
  }
  return TouConsumption(
    offPeakKwh: off,
    peakKwh: peak,
    midPeakKwh: mid,
  );
}

/// Calculate statistics for hourly data
HourlyStats calculateHourlyStats(List<HourlyData> hourlyData) {
  // Exclude placeholder (missing) entries so stats only reflect real reads.
  final actual = hourlyData.where((h) => !h.missing).toList();
  if (actual.isEmpty) {
    return HourlyStats(
      totalKWh: 0,
      estimatedCost: 0,
      avgKWh: 0,
      peakKWh: 0,
      peakTime: '-',
      peakHour: 0,
    );
  }
  final totalKWh = actual.fold<double>(0, (sum, d) => sum + d.kWh);
  final estimatedCost = totalKWh * ratePerKwh;
  final avgKWh = totalKWh / actual.length;
  final peak = actual.reduce((max, d) => d.kWh > max.kWh ? d : max);

  return HourlyStats(
    totalKWh: double.parse(totalKWh.toStringAsFixed(2)),
    estimatedCost: double.parse(estimatedCost.toStringAsFixed(2)),
    avgKWh: double.parse(avgKWh.toStringAsFixed(2)),
    peakKWh: double.parse(peak.kWh.toStringAsFixed(2)),
    peakTime: peak.time,
    peakHour: peak.hour,
  );
}

/// Calculate statistics for daily data
DailyStats calculateDailyStats(List<DailyReading> dailyReadings) {
  final actual = dailyReadings.where((d) => !d.missing).toList();
  if (actual.isEmpty) {
    return DailyStats(
      totalKWh: 0,
      estimatedCost: 0,
      avgKWh: 0,
      peakKWh: 0,
      peakDate: '-',
    );
  }
  final values = actual.map((d) => double.tryParse(d.kWhUsed) ?? 0.0).toList();
  final totalKWh = values.fold<double>(0, (sum, v) => sum + v);
  final estimatedCost = totalKWh * ratePerKwh;
  final avgKWh = totalKWh / actual.length;
  final maxIndex = values.indexOf(values.reduce((a, b) => a > b ? a : b));
  final peakReading = actual[maxIndex];
  final peakDate = DateTime.tryParse(
        peakReading.readDate.trim().split(RegExp('[T ]')).first,
      ) ??
      DateTime.now();

  return DailyStats(
    totalKWh: double.parse(totalKWh.toStringAsFixed(2)),
    estimatedCost: double.parse(estimatedCost.toStringAsFixed(2)),
    avgKWh: double.parse(avgKWh.toStringAsFixed(2)),
    peakKWh: double.parse((double.tryParse(peakReading.kWhUsed) ?? 0.0).toStringAsFixed(2)),
    peakDate: _formatDate(peakDate),
  );
}

/// Get week range (Sunday to Saturday)
DateRange getWeekRange(DateTime date) {
  final start = DateTime(date.year, date.month, date.day - date.weekday % 7);
  final end = DateTime(start.year, start.month, start.day + 6, 23, 59, 59, 999);

  return DateRange(start: start, end: end);
}

/// Get month range
({DateTime start, DateTime end, int daysInMonth}) getMonthRange(DateTime date) {
  final start = DateTime(date.year, date.month, 1);
  final end = DateTime(date.year, date.month + 1, 0);

  return (
    start: start,
    end: end,
    daysInMonth: end.day,
  );
}

/// Format date for display
String formatDateRange(DateTime start, DateTime end) {
  final startStr = _formatShortDate(start);
  final endStr = _formatShortDate(end);
  return '$startStr - $endStr, ${end.year}';
}

String formatAmiPeakDate(DateTime date) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
}

String _formatDate(DateTime date) => formatAmiPeakDate(date);

String _formatShortDate(DateTime date) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[date.month - 1]} ${date.day}';
}
