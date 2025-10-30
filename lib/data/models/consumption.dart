import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumption.freezed.dart';
part 'consumption.g.dart';

@freezed
class ConsumptionResponse with _$ConsumptionResponse {
  const factory ConsumptionResponse({
    required List<DailyConsumption> dailyConsumption,
    required List<MonthlyConsumption> monthlyConsumption,
    required List<YearlyConsumption> yearlyConsumption,
    required UsageStatistics usageStatistics,
  }) = _ConsumptionResponse;

  factory ConsumptionResponse.fromJson(Map<String, dynamic> json) => _$ConsumptionResponseFromJson(json);
}

@freezed
class DailyConsumption with _$DailyConsumption {
  const factory DailyConsumption({
    required DateTime date,
    required double totalKwh,
    required double cost,
    required List<HourlyConsumption> hourlyBreakdown,
    @Default([]) List<PeakUsage> peakUsages,
    @Default([]) List<LowUsage> lowUsages,
    @Default(0.0) double averageHourlyUsage,
    @Default(0.0) double peakHourlyUsage,
    @Default(0.0) double lowestHourlyUsage,
    @Default(0.0) double standardDeviation,
    @Default([]) List<UsageAlert> alerts,
    @Default(ConsumptionPattern()) ConsumptionPattern pattern,
  }) = _DailyConsumption;

  factory DailyConsumption.fromJson(Map<String, dynamic> json) => _$DailyConsumptionFromJson(json);

  const DailyConsumption._();

  /// Validate consumption data
  ValidationResult validate() {
    final errors = <String>[];

    if (totalKwh < 0) {
      errors.add('Total kWh cannot be negative');
    }
    if (cost < 0) {
      errors.add('Cost cannot be negative');
    }
    if (hourlyBreakdown.length != 24) {
      errors.add('Hourly breakdown must have 24 entries');
    }

    // Validate hourly data
    for (final hourly in hourlyBreakdown) {
      if (hourly.kwh < 0) {
        errors.add('Hourly kWh cannot be negative');
      }
      if (hourly.cost < 0) {
        errors.add('Hourly cost cannot be negative');
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Get peak usage hours
  List<int> get peakUsageHours {
    final sortedHours = hourlyBreakdown.toList()
      ..sort((a, b) => b.kwh.compareTo(a.kwh));
    return sortedHours.take(3).map((h) => h.hour).toList();
  }

  /// Get low usage hours
  List<int> get lowUsageHours {
    final sortedHours = hourlyBreakdown.toList()
      ..sort((a, b) => a.kwh.compareTo(b.kwh));
    return sortedHours.take(3).map((h) => h.hour).toList();
  }

  /// Get usage efficiency score (0-100)
  double get efficiencyScore {
    if (totalKwh == 0) return 0;
    final avgUsage = hourlyBreakdown.fold<double>(0, (sum, h) => sum + h.kwh) / 24;
    final variance = hourlyBreakdown.fold<double>(0, (sum, h) => sum + (h.kwh - avgUsage) * (h.kwh - avgUsage)) / 24;
    final efficiency = (1 - (variance / (avgUsage * avgUsage))) * 100;
    return efficiency.clamp(0, 100);
  }

  /// Check if usage is above average
  bool get isAboveAverage => totalKwh > averageHourlyUsage * 24;

  /// Get usage trend compared to previous day
  UsageTrend get usageTrend {
    if (pattern.previousDayUsage == null) return UsageTrend.unknown;
    final difference = totalKwh - pattern.previousDayUsage!;
    final percentage = (difference / pattern.previousDayUsage!) * 100;
    
    if (percentage > 10) return UsageTrend.increasing;
    if (percentage < -10) return UsageTrend.decreasing;
    return UsageTrend.stable;
  }
}

@freezed
class HourlyConsumption with _$HourlyConsumption {
  const factory HourlyConsumption({
    required int hour,
    required double kwh,
    required double cost,
  }) = _HourlyConsumption;

  factory HourlyConsumption.fromJson(Map<String, dynamic> json) => _$HourlyConsumptionFromJson(json);
}

@freezed
class MonthlyConsumption with _$MonthlyConsumption {
  const factory MonthlyConsumption({
    required String month,
    required double totalKwh,
    required double totalCost,
    required double averageDaily,
    required String peakDay,
    required double peakKwh,
    required String lowestDay,
    required double lowestKwh,
  }) = _MonthlyConsumption;

  factory MonthlyConsumption.fromJson(Map<String, dynamic> json) => _$MonthlyConsumptionFromJson(json);
}

@freezed
class YearlyConsumption with _$YearlyConsumption {
  const factory YearlyConsumption({
    required int year,
    required double totalKwh,
    required double totalCost,
    required double averageMonthly,
    required String peakMonth,
    required double peakKwh,
    required String lowestMonth,
    required double lowestKwh,
  }) = _YearlyConsumption;

  factory YearlyConsumption.fromJson(Map<String, dynamic> json) => _$YearlyConsumptionFromJson(json);
}

@freezed
class UsageStatistics with _$UsageStatistics {
  const factory UsageStatistics({
    required double averageDailyUsage,
    required double averageMonthlyUsage,
    required double averageYearlyUsage,
    required int peakUsageHour,
    required int lowestUsageHour,
    required SeasonalTrends seasonalTrends,
    @Default([]) List<UsagePattern> patterns,
    @Default([]) List<AnomalyDetection> anomalies,
    @Default(0.0) double efficiencyScore,
    @Default(0.0) double carbonFootprint,
    @Default([]) List<EnergySavingTip> savingTips,
    @Default(ConsumptionForecast()) ConsumptionForecast forecast,
  }) = _UsageStatistics;

  factory UsageStatistics.fromJson(Map<String, dynamic> json) => _$UsageStatisticsFromJson(json);

  const UsageStatistics._();

  /// Validate statistics data
  ValidationResult validate() {
    final errors = <String>[];

    if (averageDailyUsage < 0) {
      errors.add('Average daily usage cannot be negative');
    }
    if (averageMonthlyUsage < 0) {
      errors.add('Average monthly usage cannot be negative');
    }
    if (averageYearlyUsage < 0) {
      errors.add('Average yearly usage cannot be negative');
    }
    if (peakUsageHour < 0 || peakUsageHour > 23) {
      errors.add('Peak usage hour must be between 0 and 23');
    }
    if (lowestUsageHour < 0 || lowestUsageHour > 23) {
      errors.add('Lowest usage hour must be between 0 and 23');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Get usage efficiency rating
  EfficiencyRating get efficiencyRating {
    if (efficiencyScore >= 90) return EfficiencyRating.excellent;
    if (efficiencyScore >= 75) return EfficiencyRating.good;
    if (efficiencyScore >= 60) return EfficiencyRating.fair;
    return EfficiencyRating.poor;
  }

  /// Get peak usage period
  String get peakUsagePeriod {
    if (peakUsageHour >= 6 && peakUsageHour <= 9) return 'Morning Peak';
    if (peakUsageHour >= 17 && peakUsageHour <= 20) return 'Evening Peak';
    if (peakUsageHour >= 12 && peakUsageHour <= 14) return 'Midday Peak';
    return 'Off-Peak';
  }

  /// Get usage trend over time
  UsageTrend get overallTrend {
    if (patterns.isEmpty) return UsageTrend.unknown;
    
    final recentPatterns = patterns.take(7).toList();
    if (recentPatterns.length < 3) return UsageTrend.unknown;
    
    final trend = recentPatterns.last.averageUsage - recentPatterns.first.averageUsage;
    if (trend > 0.1) return UsageTrend.increasing;
    if (trend < -0.1) return UsageTrend.decreasing;
    return UsageTrend.stable;
  }
}

@freezed
class SeasonalTrends with _$SeasonalTrends {
  const factory SeasonalTrends({
    required SeasonalData summer,
    required SeasonalData fall,
    required SeasonalData winter,
    required SeasonalData spring,
  }) = _SeasonalTrends;

  factory SeasonalTrends.fromJson(Map<String, dynamic> json) => _$SeasonalTrendsFromJson(json);
}

@freezed
class SeasonalData with _$SeasonalData {
  const factory SeasonalData({
    required double average,
    required double peak,
    @Default(0.0) double lowest,
    @Default(0.0) double standardDeviation,
    @Default([]) List<String> peakDays,
  }) = _SeasonalData;

  factory SeasonalData.fromJson(Map<String, dynamic> json) => _$SeasonalDataFromJson(json);
}

@freezed
class PeakUsage with _$PeakUsage {
  const factory PeakUsage({
    required int hour,
    required double kwh,
    required double cost,
    required DateTime timestamp,
    String? reason,
  }) = _PeakUsage;

  factory PeakUsage.fromJson(Map<String, dynamic> json) => _$PeakUsageFromJson(json);
}

@freezed
class LowUsage with _$LowUsage {
  const factory LowUsage({
    required int hour,
    required double kwh,
    required double cost,
    required DateTime timestamp,
    String? reason,
  }) = _LowUsage;

  factory LowUsage.fromJson(Map<String, dynamic> json) => _$LowUsageFromJson(json);
}

@freezed
class UsageAlert with _$UsageAlert {
  const factory UsageAlert({
    required String id,
    required AlertType type,
    required String message,
    required DateTime timestamp,
    required AlertSeverity severity,
    @Default(false) bool isRead,
    Map<String, dynamic>? metadata,
  }) = _UsageAlert;

  factory UsageAlert.fromJson(Map<String, dynamic> json) => _$UsageAlertFromJson(json);
}

@freezed
class ConsumptionPattern with _$ConsumptionPattern {
  const factory ConsumptionPattern({
    double? previousDayUsage,
    double? previousWeekAverage,
    double? previousMonthAverage,
    @Default([]) List<int> typicalPeakHours,
    @Default([]) List<int> typicalLowHours,
    @Default(0.0) double weekendAverage,
    @Default(0.0) double weekdayAverage,
    @Default(0.0) double holidayAverage,
  }) = _ConsumptionPattern;

  factory ConsumptionPattern.fromJson(Map<String, dynamic> json) => _$ConsumptionPatternFromJson(json);
}

@freezed
class UsagePattern with _$UsagePattern {
  const factory UsagePattern({
    required String id,
    required DateTime date,
    required double averageUsage,
    required double peakUsage,
    required double lowUsage,
    required List<int> peakHours,
    required List<int> lowHours,
    @Default(0.0) double efficiencyScore,
  }) = _UsagePattern;

  factory UsagePattern.fromJson(Map<String, dynamic> json) => _$UsagePatternFromJson(json);
}

@freezed
class AnomalyDetection with _$AnomalyDetection {
  const factory AnomalyDetection({
    required String id,
    required DateTime timestamp,
    required AnomalyType type,
    required double expectedValue,
    required double actualValue,
    required double deviationPercentage,
    required String description,
    @Default(false) bool isResolved,
  }) = _AnomalyDetection;

  factory AnomalyDetection.fromJson(Map<String, dynamic> json) => _$AnomalyDetectionFromJson(json);
}

@freezed
class EnergySavingTip with _$EnergySavingTip {
  const factory EnergySavingTip({
    required String id,
    required String title,
    required String description,
    required TipCategory category,
    required double potentialSavings,
    required String difficulty,
    @Default([]) List<String> tags,
  }) = _EnergySavingTip;

  factory EnergySavingTip.fromJson(Map<String, dynamic> json) => _$EnergySavingTipFromJson(json);
}

@freezed
class ConsumptionForecast with _$ConsumptionForecast {
  const factory ConsumptionForecast({
    @Default([]) List<ForecastData> dailyForecast,
    @Default([]) List<ForecastData> weeklyForecast,
    @Default([]) List<ForecastData> monthlyForecast,
    @Default(0.0) double predictedNextMonthUsage,
    @Default(0.0) double predictedNextMonthCost,
    @Default(0.0) double confidenceScore,
  }) = _ConsumptionForecast;

  factory ConsumptionForecast.fromJson(Map<String, dynamic> json) => _$ConsumptionForecastFromJson(json);
}

@freezed
class ForecastData with _$ForecastData {
  const factory ForecastData({
    required DateTime date,
    required double predictedUsage,
    required double predictedCost,
    @Default(0.0) double confidence,
    @Default([]) List<double> confidenceInterval,
  }) = _ForecastData;

  factory ForecastData.fromJson(Map<String, dynamic> json) => _$ForecastDataFromJson(json);
}

enum UsageTrend {
  increasing,
  decreasing,
  stable,
  unknown,
}

enum EfficiencyRating {
  excellent,
  good,
  fair,
  poor,
}

enum AlertType {
  highUsage,
  lowUsage,
  unusualPattern,
  peakHourAlert,
  costAlert,
  efficiencyAlert,
}

enum AlertSeverity {
  low,
  medium,
  high,
  critical,
}

enum AnomalyType {
  spike,
  drop,
  patternChange,
  seasonalAnomaly,
}

enum TipCategory {
  heating,
  cooling,
  lighting,
  appliances,
  behavior,
  equipment,
}

/// Validation result class
class ValidationResult {

  const ValidationResult({
    required this.isValid,
    required this.errors,
  });
  final bool isValid;
  final List<String> errors;

  String get errorMessage => errors.join(', ');
}
