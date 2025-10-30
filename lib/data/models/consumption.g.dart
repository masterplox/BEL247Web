// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumptionResponseImpl _$$ConsumptionResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ConsumptionResponseImpl(
  dailyConsumption: (json['dailyConsumption'] as List<dynamic>)
      .map((e) => DailyConsumption.fromJson(e as Map<String, dynamic>))
      .toList(),
  monthlyConsumption: (json['monthlyConsumption'] as List<dynamic>)
      .map((e) => MonthlyConsumption.fromJson(e as Map<String, dynamic>))
      .toList(),
  yearlyConsumption: (json['yearlyConsumption'] as List<dynamic>)
      .map((e) => YearlyConsumption.fromJson(e as Map<String, dynamic>))
      .toList(),
  usageStatistics: UsageStatistics.fromJson(
    json['usageStatistics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$ConsumptionResponseImplToJson(
  _$ConsumptionResponseImpl instance,
) => <String, dynamic>{
  'dailyConsumption': instance.dailyConsumption,
  'monthlyConsumption': instance.monthlyConsumption,
  'yearlyConsumption': instance.yearlyConsumption,
  'usageStatistics': instance.usageStatistics,
};

_$DailyConsumptionImpl _$$DailyConsumptionImplFromJson(
  Map<String, dynamic> json,
) => _$DailyConsumptionImpl(
  date: DateTime.parse(json['date'] as String),
  totalKwh: (json['totalKwh'] as num).toDouble(),
  cost: (json['cost'] as num).toDouble(),
  hourlyBreakdown: (json['hourlyBreakdown'] as List<dynamic>)
      .map((e) => HourlyConsumption.fromJson(e as Map<String, dynamic>))
      .toList(),
  peakUsages:
      (json['peakUsages'] as List<dynamic>?)
          ?.map((e) => PeakUsage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  lowUsages:
      (json['lowUsages'] as List<dynamic>?)
          ?.map((e) => LowUsage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  averageHourlyUsage: (json['averageHourlyUsage'] as num?)?.toDouble() ?? 0.0,
  peakHourlyUsage: (json['peakHourlyUsage'] as num?)?.toDouble() ?? 0.0,
  lowestHourlyUsage: (json['lowestHourlyUsage'] as num?)?.toDouble() ?? 0.0,
  standardDeviation: (json['standardDeviation'] as num?)?.toDouble() ?? 0.0,
  alerts:
      (json['alerts'] as List<dynamic>?)
          ?.map((e) => UsageAlert.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pattern: json['pattern'] == null
      ? const ConsumptionPattern()
      : ConsumptionPattern.fromJson(json['pattern'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DailyConsumptionImplToJson(
  _$DailyConsumptionImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'totalKwh': instance.totalKwh,
  'cost': instance.cost,
  'hourlyBreakdown': instance.hourlyBreakdown,
  'peakUsages': instance.peakUsages,
  'lowUsages': instance.lowUsages,
  'averageHourlyUsage': instance.averageHourlyUsage,
  'peakHourlyUsage': instance.peakHourlyUsage,
  'lowestHourlyUsage': instance.lowestHourlyUsage,
  'standardDeviation': instance.standardDeviation,
  'alerts': instance.alerts,
  'pattern': instance.pattern,
};

_$HourlyConsumptionImpl _$$HourlyConsumptionImplFromJson(
  Map<String, dynamic> json,
) => _$HourlyConsumptionImpl(
  hour: (json['hour'] as num).toInt(),
  kwh: (json['kwh'] as num).toDouble(),
  cost: (json['cost'] as num).toDouble(),
);

Map<String, dynamic> _$$HourlyConsumptionImplToJson(
  _$HourlyConsumptionImpl instance,
) => <String, dynamic>{
  'hour': instance.hour,
  'kwh': instance.kwh,
  'cost': instance.cost,
};

_$MonthlyConsumptionImpl _$$MonthlyConsumptionImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyConsumptionImpl(
  month: json['month'] as String,
  totalKwh: (json['totalKwh'] as num).toDouble(),
  totalCost: (json['totalCost'] as num).toDouble(),
  averageDaily: (json['averageDaily'] as num).toDouble(),
  peakDay: json['peakDay'] as String,
  peakKwh: (json['peakKwh'] as num).toDouble(),
  lowestDay: json['lowestDay'] as String,
  lowestKwh: (json['lowestKwh'] as num).toDouble(),
);

Map<String, dynamic> _$$MonthlyConsumptionImplToJson(
  _$MonthlyConsumptionImpl instance,
) => <String, dynamic>{
  'month': instance.month,
  'totalKwh': instance.totalKwh,
  'totalCost': instance.totalCost,
  'averageDaily': instance.averageDaily,
  'peakDay': instance.peakDay,
  'peakKwh': instance.peakKwh,
  'lowestDay': instance.lowestDay,
  'lowestKwh': instance.lowestKwh,
};

_$YearlyConsumptionImpl _$$YearlyConsumptionImplFromJson(
  Map<String, dynamic> json,
) => _$YearlyConsumptionImpl(
  year: (json['year'] as num).toInt(),
  totalKwh: (json['totalKwh'] as num).toDouble(),
  totalCost: (json['totalCost'] as num).toDouble(),
  averageMonthly: (json['averageMonthly'] as num).toDouble(),
  peakMonth: json['peakMonth'] as String,
  peakKwh: (json['peakKwh'] as num).toDouble(),
  lowestMonth: json['lowestMonth'] as String,
  lowestKwh: (json['lowestKwh'] as num).toDouble(),
);

Map<String, dynamic> _$$YearlyConsumptionImplToJson(
  _$YearlyConsumptionImpl instance,
) => <String, dynamic>{
  'year': instance.year,
  'totalKwh': instance.totalKwh,
  'totalCost': instance.totalCost,
  'averageMonthly': instance.averageMonthly,
  'peakMonth': instance.peakMonth,
  'peakKwh': instance.peakKwh,
  'lowestMonth': instance.lowestMonth,
  'lowestKwh': instance.lowestKwh,
};

_$UsageStatisticsImpl _$$UsageStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$UsageStatisticsImpl(
  averageDailyUsage: (json['averageDailyUsage'] as num).toDouble(),
  averageMonthlyUsage: (json['averageMonthlyUsage'] as num).toDouble(),
  averageYearlyUsage: (json['averageYearlyUsage'] as num).toDouble(),
  peakUsageHour: (json['peakUsageHour'] as num).toInt(),
  lowestUsageHour: (json['lowestUsageHour'] as num).toInt(),
  seasonalTrends: SeasonalTrends.fromJson(
    json['seasonalTrends'] as Map<String, dynamic>,
  ),
  patterns:
      (json['patterns'] as List<dynamic>?)
          ?.map((e) => UsagePattern.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  anomalies:
      (json['anomalies'] as List<dynamic>?)
          ?.map((e) => AnomalyDetection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  efficiencyScore: (json['efficiencyScore'] as num?)?.toDouble() ?? 0.0,
  carbonFootprint: (json['carbonFootprint'] as num?)?.toDouble() ?? 0.0,
  savingTips:
      (json['savingTips'] as List<dynamic>?)
          ?.map((e) => EnergySavingTip.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  forecast: json['forecast'] == null
      ? const ConsumptionForecast()
      : ConsumptionForecast.fromJson(json['forecast'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$UsageStatisticsImplToJson(
  _$UsageStatisticsImpl instance,
) => <String, dynamic>{
  'averageDailyUsage': instance.averageDailyUsage,
  'averageMonthlyUsage': instance.averageMonthlyUsage,
  'averageYearlyUsage': instance.averageYearlyUsage,
  'peakUsageHour': instance.peakUsageHour,
  'lowestUsageHour': instance.lowestUsageHour,
  'seasonalTrends': instance.seasonalTrends,
  'patterns': instance.patterns,
  'anomalies': instance.anomalies,
  'efficiencyScore': instance.efficiencyScore,
  'carbonFootprint': instance.carbonFootprint,
  'savingTips': instance.savingTips,
  'forecast': instance.forecast,
};

_$SeasonalTrendsImpl _$$SeasonalTrendsImplFromJson(Map<String, dynamic> json) =>
    _$SeasonalTrendsImpl(
      summer: SeasonalData.fromJson(json['summer'] as Map<String, dynamic>),
      fall: SeasonalData.fromJson(json['fall'] as Map<String, dynamic>),
      winter: SeasonalData.fromJson(json['winter'] as Map<String, dynamic>),
      spring: SeasonalData.fromJson(json['spring'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SeasonalTrendsImplToJson(
  _$SeasonalTrendsImpl instance,
) => <String, dynamic>{
  'summer': instance.summer,
  'fall': instance.fall,
  'winter': instance.winter,
  'spring': instance.spring,
};

_$SeasonalDataImpl _$$SeasonalDataImplFromJson(Map<String, dynamic> json) =>
    _$SeasonalDataImpl(
      average: (json['average'] as num).toDouble(),
      peak: (json['peak'] as num).toDouble(),
      lowest: (json['lowest'] as num?)?.toDouble() ?? 0.0,
      standardDeviation: (json['standardDeviation'] as num?)?.toDouble() ?? 0.0,
      peakDays:
          (json['peakDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SeasonalDataImplToJson(_$SeasonalDataImpl instance) =>
    <String, dynamic>{
      'average': instance.average,
      'peak': instance.peak,
      'lowest': instance.lowest,
      'standardDeviation': instance.standardDeviation,
      'peakDays': instance.peakDays,
    };

_$PeakUsageImpl _$$PeakUsageImplFromJson(Map<String, dynamic> json) =>
    _$PeakUsageImpl(
      hour: (json['hour'] as num).toInt(),
      kwh: (json['kwh'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$PeakUsageImplToJson(_$PeakUsageImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'kwh': instance.kwh,
      'cost': instance.cost,
      'timestamp': instance.timestamp.toIso8601String(),
      'reason': instance.reason,
    };

_$LowUsageImpl _$$LowUsageImplFromJson(Map<String, dynamic> json) =>
    _$LowUsageImpl(
      hour: (json['hour'] as num).toInt(),
      kwh: (json['kwh'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$LowUsageImplToJson(_$LowUsageImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'kwh': instance.kwh,
      'cost': instance.cost,
      'timestamp': instance.timestamp.toIso8601String(),
      'reason': instance.reason,
    };

_$UsageAlertImpl _$$UsageAlertImplFromJson(Map<String, dynamic> json) =>
    _$UsageAlertImpl(
      id: json['id'] as String,
      type: $enumDecode(_$AlertTypeEnumMap, json['type']),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      severity: $enumDecode(_$AlertSeverityEnumMap, json['severity']),
      isRead: json['isRead'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UsageAlertImplToJson(_$UsageAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AlertTypeEnumMap[instance.type]!,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'severity': _$AlertSeverityEnumMap[instance.severity]!,
      'isRead': instance.isRead,
      'metadata': instance.metadata,
    };

const _$AlertTypeEnumMap = {
  AlertType.highUsage: 'highUsage',
  AlertType.lowUsage: 'lowUsage',
  AlertType.unusualPattern: 'unusualPattern',
  AlertType.peakHourAlert: 'peakHourAlert',
  AlertType.costAlert: 'costAlert',
  AlertType.efficiencyAlert: 'efficiencyAlert',
};

const _$AlertSeverityEnumMap = {
  AlertSeverity.low: 'low',
  AlertSeverity.medium: 'medium',
  AlertSeverity.high: 'high',
  AlertSeverity.critical: 'critical',
};

_$ConsumptionPatternImpl _$$ConsumptionPatternImplFromJson(
  Map<String, dynamic> json,
) => _$ConsumptionPatternImpl(
  previousDayUsage: (json['previousDayUsage'] as num?)?.toDouble(),
  previousWeekAverage: (json['previousWeekAverage'] as num?)?.toDouble(),
  previousMonthAverage: (json['previousMonthAverage'] as num?)?.toDouble(),
  typicalPeakHours:
      (json['typicalPeakHours'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  typicalLowHours:
      (json['typicalLowHours'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  weekendAverage: (json['weekendAverage'] as num?)?.toDouble() ?? 0.0,
  weekdayAverage: (json['weekdayAverage'] as num?)?.toDouble() ?? 0.0,
  holidayAverage: (json['holidayAverage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$ConsumptionPatternImplToJson(
  _$ConsumptionPatternImpl instance,
) => <String, dynamic>{
  'previousDayUsage': instance.previousDayUsage,
  'previousWeekAverage': instance.previousWeekAverage,
  'previousMonthAverage': instance.previousMonthAverage,
  'typicalPeakHours': instance.typicalPeakHours,
  'typicalLowHours': instance.typicalLowHours,
  'weekendAverage': instance.weekendAverage,
  'weekdayAverage': instance.weekdayAverage,
  'holidayAverage': instance.holidayAverage,
};

_$UsagePatternImpl _$$UsagePatternImplFromJson(Map<String, dynamic> json) =>
    _$UsagePatternImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      averageUsage: (json['averageUsage'] as num).toDouble(),
      peakUsage: (json['peakUsage'] as num).toDouble(),
      lowUsage: (json['lowUsage'] as num).toDouble(),
      peakHours: (json['peakHours'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      lowHours: (json['lowHours'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      efficiencyScore: (json['efficiencyScore'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$UsagePatternImplToJson(_$UsagePatternImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'averageUsage': instance.averageUsage,
      'peakUsage': instance.peakUsage,
      'lowUsage': instance.lowUsage,
      'peakHours': instance.peakHours,
      'lowHours': instance.lowHours,
      'efficiencyScore': instance.efficiencyScore,
    };

_$AnomalyDetectionImpl _$$AnomalyDetectionImplFromJson(
  Map<String, dynamic> json,
) => _$AnomalyDetectionImpl(
  id: json['id'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  type: $enumDecode(_$AnomalyTypeEnumMap, json['type']),
  expectedValue: (json['expectedValue'] as num).toDouble(),
  actualValue: (json['actualValue'] as num).toDouble(),
  deviationPercentage: (json['deviationPercentage'] as num).toDouble(),
  description: json['description'] as String,
  isResolved: json['isResolved'] as bool? ?? false,
);

Map<String, dynamic> _$$AnomalyDetectionImplToJson(
  _$AnomalyDetectionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'timestamp': instance.timestamp.toIso8601String(),
  'type': _$AnomalyTypeEnumMap[instance.type]!,
  'expectedValue': instance.expectedValue,
  'actualValue': instance.actualValue,
  'deviationPercentage': instance.deviationPercentage,
  'description': instance.description,
  'isResolved': instance.isResolved,
};

const _$AnomalyTypeEnumMap = {
  AnomalyType.spike: 'spike',
  AnomalyType.drop: 'drop',
  AnomalyType.patternChange: 'patternChange',
  AnomalyType.seasonalAnomaly: 'seasonalAnomaly',
};

_$EnergySavingTipImpl _$$EnergySavingTipImplFromJson(
  Map<String, dynamic> json,
) => _$EnergySavingTipImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$TipCategoryEnumMap, json['category']),
  potentialSavings: (json['potentialSavings'] as num).toDouble(),
  difficulty: json['difficulty'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$EnergySavingTipImplToJson(
  _$EnergySavingTipImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': _$TipCategoryEnumMap[instance.category]!,
  'potentialSavings': instance.potentialSavings,
  'difficulty': instance.difficulty,
  'tags': instance.tags,
};

const _$TipCategoryEnumMap = {
  TipCategory.heating: 'heating',
  TipCategory.cooling: 'cooling',
  TipCategory.lighting: 'lighting',
  TipCategory.appliances: 'appliances',
  TipCategory.behavior: 'behavior',
  TipCategory.equipment: 'equipment',
};

_$ConsumptionForecastImpl _$$ConsumptionForecastImplFromJson(
  Map<String, dynamic> json,
) => _$ConsumptionForecastImpl(
  dailyForecast:
      (json['dailyForecast'] as List<dynamic>?)
          ?.map((e) => ForecastData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  weeklyForecast:
      (json['weeklyForecast'] as List<dynamic>?)
          ?.map((e) => ForecastData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  monthlyForecast:
      (json['monthlyForecast'] as List<dynamic>?)
          ?.map((e) => ForecastData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  predictedNextMonthUsage:
      (json['predictedNextMonthUsage'] as num?)?.toDouble() ?? 0.0,
  predictedNextMonthCost:
      (json['predictedNextMonthCost'] as num?)?.toDouble() ?? 0.0,
  confidenceScore: (json['confidenceScore'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$ConsumptionForecastImplToJson(
  _$ConsumptionForecastImpl instance,
) => <String, dynamic>{
  'dailyForecast': instance.dailyForecast,
  'weeklyForecast': instance.weeklyForecast,
  'monthlyForecast': instance.monthlyForecast,
  'predictedNextMonthUsage': instance.predictedNextMonthUsage,
  'predictedNextMonthCost': instance.predictedNextMonthCost,
  'confidenceScore': instance.confidenceScore,
};

_$ForecastDataImpl _$$ForecastDataImplFromJson(Map<String, dynamic> json) =>
    _$ForecastDataImpl(
      date: DateTime.parse(json['date'] as String),
      predictedUsage: (json['predictedUsage'] as num).toDouble(),
      predictedCost: (json['predictedCost'] as num).toDouble(),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      confidenceInterval:
          (json['confidenceInterval'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ForecastDataImplToJson(_$ForecastDataImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'predictedUsage': instance.predictedUsage,
      'predictedCost': instance.predictedCost,
      'confidence': instance.confidence,
      'confidenceInterval': instance.confidenceInterval,
    };
