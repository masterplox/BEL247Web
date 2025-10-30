// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  errorCode: json['errorCode'] as String? ?? null,
  metadata: json['metadata'] as Map<String, dynamic>? ?? null,
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'errors': instance.errors,
  'errorCode': instance.errorCode,
  'metadata': instance.metadata,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$PaginationInfoImpl _$$PaginationInfoImplFromJson(Map<String, dynamic> json) =>
    _$PaginationInfoImpl(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      itemsPerPage: (json['itemsPerPage'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );

Map<String, dynamic> _$$PaginationInfoImplToJson(
  _$PaginationInfoImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'totalItems': instance.totalItems,
  'itemsPerPage': instance.itemsPerPage,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};

_$PaginatedResponseImpl<T> _$$PaginatedResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$PaginatedResponseImpl<T>(
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
  pagination: PaginationInfo.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$PaginatedResponseImplToJson<T>(
  _$PaginatedResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': instance.data.map(toJsonT).toList(),
  'pagination': instance.pagination,
};

_$PaymentRequestImpl _$$PaymentRequestImplFromJson(Map<String, dynamic> json) =>
    _$PaymentRequestImpl(
      billId: json['billId'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentMethodId: json['paymentMethodId'] as String,
      paymentMethodType: $enumDecode(
        _$PaymentMethodTypeEnumMap,
        json['paymentMethodType'],
      ),
      isRecurring: json['isRecurring'] as bool? ?? false,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PaymentRequestImplToJson(
  _$PaymentRequestImpl instance,
) => <String, dynamic>{
  'billId': instance.billId,
  'amount': instance.amount,
  'paymentMethodId': instance.paymentMethodId,
  'paymentMethodType': _$PaymentMethodTypeEnumMap[instance.paymentMethodType]!,
  'isRecurring': instance.isRecurring,
  'notes': instance.notes,
  'metadata': instance.metadata,
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.creditCard: 'creditCard',
  PaymentMethodType.debitCard: 'debitCard',
  PaymentMethodType.bankAccount: 'bankAccount',
  PaymentMethodType.paypal: 'paypal',
  PaymentMethodType.applePay: 'applePay',
  PaymentMethodType.googlePay: 'googlePay',
};

_$PaymentResponseImpl _$$PaymentResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentResponseImpl(
  transactionId: json['transactionId'] as String,
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  amount: (json['amount'] as num).toDouble(),
  processedAt: DateTime.parse(json['processedAt'] as String),
  referenceNumber: json['referenceNumber'] as String?,
  receiptUrl: json['receiptUrl'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$PaymentResponseImplToJson(
  _$PaymentResponseImpl instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'amount': instance.amount,
  'processedAt': instance.processedAt.toIso8601String(),
  'referenceNumber': instance.referenceNumber,
  'receiptUrl': instance.receiptUrl,
  'metadata': instance.metadata,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.refunded: 'refunded',
};

_$UsageRequestImpl _$$UsageRequestImplFromJson(Map<String, dynamic> json) =>
    _$UsageRequestImpl(
      accountNumber: json['accountNumber'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      granularity:
          $enumDecodeNullable(_$UsageGranularityEnumMap, json['granularity']) ??
          UsageGranularity.daily,
      includeForecast: json['includeForecast'] as bool? ?? false,
      includeAnomalies: json['includeAnomalies'] as bool? ?? false,
      includeTips: json['includeTips'] as bool? ?? false,
    );

Map<String, dynamic> _$$UsageRequestImplToJson(_$UsageRequestImpl instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'granularity': _$UsageGranularityEnumMap[instance.granularity]!,
      'includeForecast': instance.includeForecast,
      'includeAnomalies': instance.includeAnomalies,
      'includeTips': instance.includeTips,
    };

const _$UsageGranularityEnumMap = {
  UsageGranularity.hourly: 'hourly',
  UsageGranularity.daily: 'daily',
  UsageGranularity.weekly: 'weekly',
  UsageGranularity.monthly: 'monthly',
  UsageGranularity.yearly: 'yearly',
};

_$BillRequestImpl _$$BillRequestImplFromJson(Map<String, dynamic> json) =>
    _$BillRequestImpl(
      accountNumber: json['accountNumber'] as String,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      status:
          $enumDecodeNullable(_$BillStatusEnumMap, json['status']) ??
          BillStatus.pending,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      includePaymentHistory: json['includePaymentHistory'] as bool? ?? false,
      includeCalculations: json['includeCalculations'] as bool? ?? false,
    );

Map<String, dynamic> _$$BillRequestImplToJson(_$BillRequestImpl instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'limit': instance.limit,
      'offset': instance.offset,
      'status': _$BillStatusEnumMap[instance.status]!,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'includePaymentHistory': instance.includePaymentHistory,
      'includeCalculations': instance.includeCalculations,
    };

const _$BillStatusEnumMap = {
  BillStatus.pending: 'pending',
  BillStatus.paid: 'paid',
  BillStatus.overdue: 'overdue',
  BillStatus.cancelled: 'cancelled',
  BillStatus.disputed: 'disputed',
};

_$UserProfileUpdateRequestImpl _$$UserProfileUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileUpdateRequestImpl(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  address: json['address'] == null
      ? null
      : Address.fromJson(json['address'] as Map<String, dynamic>),
  preferences: json['preferences'] == null
      ? null
      : UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
  settings: json['settings'] == null
      ? null
      : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$UserProfileUpdateRequestImplToJson(
  _$UserProfileUpdateRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  'preferences': instance.preferences,
  'settings': instance.settings,
  'metadata': instance.metadata,
};

_$NotificationRequestImpl _$$NotificationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationRequestImpl(
  userId: json['userId'] as String,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  title: json['title'] as String,
  message: json['message'] as String,
  isImportant: json['isImportant'] as bool? ?? false,
  sendEmail: json['sendEmail'] as bool? ?? false,
  sendSms: json['sendSms'] as bool? ?? false,
  sendPush: json['sendPush'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$NotificationRequestImplToJson(
  _$NotificationRequestImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'title': instance.title,
  'message': instance.message,
  'isImportant': instance.isImportant,
  'sendEmail': instance.sendEmail,
  'sendSms': instance.sendSms,
  'sendPush': instance.sendPush,
  'metadata': instance.metadata,
};

const _$NotificationTypeEnumMap = {
  NotificationType.billReminder: 'billReminder',
  NotificationType.paymentConfirmation: 'paymentConfirmation',
  NotificationType.usageAlert: 'usageAlert',
  NotificationType.maintenanceNotice: 'maintenanceNotice',
  NotificationType.securityAlert: 'securityAlert',
  NotificationType.systemUpdate: 'systemUpdate',
};

_$AnalyticsRequestImpl _$$AnalyticsRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsRequestImpl(
  accountNumber: json['accountNumber'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  metrics:
      (json['metrics'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AnalyticsMetricEnumMap, e))
          .toList() ??
      const [],
  granularity:
      $enumDecodeNullable(_$AnalyticsGranularityEnumMap, json['granularity']) ??
      AnalyticsGranularity.daily,
  includeComparisons: json['includeComparisons'] as bool? ?? false,
  includeForecasts: json['includeForecasts'] as bool? ?? false,
);

Map<String, dynamic> _$$AnalyticsRequestImplToJson(
  _$AnalyticsRequestImpl instance,
) => <String, dynamic>{
  'accountNumber': instance.accountNumber,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'metrics': instance.metrics.map((e) => _$AnalyticsMetricEnumMap[e]!).toList(),
  'granularity': _$AnalyticsGranularityEnumMap[instance.granularity]!,
  'includeComparisons': instance.includeComparisons,
  'includeForecasts': instance.includeForecasts,
};

const _$AnalyticsMetricEnumMap = {
  AnalyticsMetric.usage: 'usage',
  AnalyticsMetric.cost: 'cost',
  AnalyticsMetric.efficiency: 'efficiency',
  AnalyticsMetric.peakUsage: 'peakUsage',
  AnalyticsMetric.lowUsage: 'lowUsage',
  AnalyticsMetric.trends: 'trends',
};

const _$AnalyticsGranularityEnumMap = {
  AnalyticsGranularity.hourly: 'hourly',
  AnalyticsGranularity.daily: 'daily',
  AnalyticsGranularity.weekly: 'weekly',
  AnalyticsGranularity.monthly: 'monthly',
  AnalyticsGranularity.yearly: 'yearly',
};

_$AnalyticsResponseImpl _$$AnalyticsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsResponseImpl(
  dataPoints: (json['dataPoints'] as List<dynamic>)
      .map((e) => AnalyticsDataPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  summary: (json['summary'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  insights:
      (json['insights'] as List<dynamic>?)
          ?.map((e) => AnalyticsInsight.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  recommendations:
      (json['recommendations'] as List<dynamic>?)
          ?.map(
            (e) => AnalyticsRecommendation.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AnalyticsResponseImplToJson(
  _$AnalyticsResponseImpl instance,
) => <String, dynamic>{
  'dataPoints': instance.dataPoints,
  'summary': instance.summary,
  'insights': instance.insights,
  'recommendations': instance.recommendations,
};

_$AnalyticsDataPointImpl _$$AnalyticsDataPointImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsDataPointImpl(
  timestamp: DateTime.parse(json['timestamp'] as String),
  values: (json['values'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$AnalyticsDataPointImplToJson(
  _$AnalyticsDataPointImpl instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'values': instance.values,
  'metadata': instance.metadata,
};

_$AnalyticsInsightImpl _$$AnalyticsInsightImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsInsightImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$InsightTypeEnumMap, json['type']),
  confidence: (json['confidence'] as num).toDouble(),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$AnalyticsInsightImplToJson(
  _$AnalyticsInsightImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$InsightTypeEnumMap[instance.type]!,
  'confidence': instance.confidence,
  'tags': instance.tags,
};

const _$InsightTypeEnumMap = {
  InsightType.usagePattern: 'usagePattern',
  InsightType.costOptimization: 'costOptimization',
  InsightType.efficiency: 'efficiency',
  InsightType.anomaly: 'anomaly',
  InsightType.trend: 'trend',
};

_$AnalyticsRecommendationImpl _$$AnalyticsRecommendationImplFromJson(
  Map<String, dynamic> json,
) => _$AnalyticsRecommendationImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
  potentialSavings: (json['potentialSavings'] as num).toDouble(),
  difficulty: json['difficulty'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$AnalyticsRecommendationImplToJson(
  _$AnalyticsRecommendationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$RecommendationTypeEnumMap[instance.type]!,
  'potentialSavings': instance.potentialSavings,
  'difficulty': instance.difficulty,
  'tags': instance.tags,
};

const _$RecommendationTypeEnumMap = {
  RecommendationType.energySaving: 'energySaving',
  RecommendationType.costReduction: 'costReduction',
  RecommendationType.efficiencyImprovement: 'efficiencyImprovement',
  RecommendationType.behaviorChange: 'behaviorChange',
  RecommendationType.equipmentUpgrade: 'equipmentUpgrade',
};

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      error: json['error'] as String,
      message: json['message'] as String,
      errorCode: json['errorCode'] as String? ?? null,
      details: json['details'] as String? ?? null,
      metadata: json['metadata'] as Map<String, dynamic>? ?? null,
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'errorCode': instance.errorCode,
      'details': instance.details,
      'metadata': instance.metadata,
    };

_$SuccessResponseImpl _$$SuccessResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SuccessResponseImpl(
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>? ?? null,
  metadata: json['metadata'] as Map<String, dynamic>? ?? null,
);

Map<String, dynamic> _$$SuccessResponseImplToJson(
  _$SuccessResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'metadata': instance.metadata,
};

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
  Map<String, dynamic> json,
) => _$UserPreferencesImpl(
  notifications: NotificationSettings.fromJson(
    json['notifications'] as Map<String, dynamic>,
  ),
  currency: json['currency'] as String,
  timezone: json['timezone'] as String,
  language: json['language'] as String,
);

Map<String, dynamic> _$$UserPreferencesImplToJson(
  _$UserPreferencesImpl instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'currency': instance.currency,
  'timezone': instance.timezone,
  'language': instance.language,
};

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationSettingsImpl(
  email: json['email'] as bool,
  sms: json['sms'] as bool,
  push: json['push'] as bool,
);

Map<String, dynamic> _$$NotificationSettingsImplToJson(
  _$NotificationSettingsImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'sms': instance.sms,
  'push': instance.push,
};

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      darkMode: json['darkMode'] as bool? ?? true,
      autoRefresh: json['autoRefresh'] as bool? ?? true,
      refreshIntervalMinutes:
          (json['refreshIntervalMinutes'] as num?)?.toInt() ?? 30,
      showNotifications: json['showNotifications'] as bool? ?? true,
      showUsageAlerts: json['showUsageAlerts'] as bool? ?? true,
      showPaymentReminders: json['showPaymentReminders'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
      currency: json['currency'] as String? ?? 'USD',
      timezone: json['timezone'] as String? ?? 'America/New_York',
      dateFormat: (json['dateFormat'] as num?)?.toInt() ?? 12,
      analyticsEnabled: json['analyticsEnabled'] as bool? ?? true,
      crashReportingEnabled: json['crashReportingEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'autoRefresh': instance.autoRefresh,
      'refreshIntervalMinutes': instance.refreshIntervalMinutes,
      'showNotifications': instance.showNotifications,
      'showUsageAlerts': instance.showUsageAlerts,
      'showPaymentReminders': instance.showPaymentReminders,
      'language': instance.language,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'dateFormat': instance.dateFormat,
      'analyticsEnabled': instance.analyticsEnabled,
      'crashReportingEnabled': instance.crashReportingEnabled,
    };
