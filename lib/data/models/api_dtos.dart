import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_dtos.freezed.dart';
part 'api_dtos.g.dart';

/// Base API response wrapper
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
    @Default([]) List<String> errors,
    @Default(null) String? errorCode,
    @Default(null) Map<String, dynamic>? metadata,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

/// Pagination information
@freezed
class PaginationInfo with _$PaginationInfo {
  const factory PaginationInfo({
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int itemsPerPage,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _PaginationInfo;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => _$PaginationInfoFromJson(json);
}

/// Paginated API response
@Freezed(genericArgumentFactories: true)
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required PaginationInfo pagination,
  }) = _PaginatedResponse<T>;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);
}

/// Payment request DTO
@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String billId,
    required double amount,
    required String paymentMethodId,
    required PaymentMethodType paymentMethodType,
    @Default(false) bool isRecurring,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);

  const PaymentRequest._();

  /// Validate payment request
  ValidationResult validate() {
    final errors = <String>[];

    if (billId.trim().isEmpty) {
      errors.add('Bill ID is required');
    }
    if (amount <= 0) {
      errors.add('Payment amount must be positive');
    }
    if (paymentMethodId.trim().isEmpty) {
      errors.add('Payment method ID is required');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Payment response DTO
@freezed
class PaymentResponse with _$PaymentResponse {
  const factory PaymentResponse({
    required String transactionId,
    required PaymentStatus status,
    required double amount,
    required DateTime processedAt,
    String? referenceNumber,
    String? receiptUrl,
    Map<String, dynamic>? metadata,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
}

/// Usage request DTO
@freezed
class UsageRequest with _$UsageRequest {
  const factory UsageRequest({
    required String accountNumber,
    required DateTime startDate,
    required DateTime endDate,
    @Default(UsageGranularity.daily) UsageGranularity granularity,
    @Default(false) bool includeForecast,
    @Default(false) bool includeAnomalies,
    @Default(false) bool includeTips,
  }) = _UsageRequest;

  factory UsageRequest.fromJson(Map<String, dynamic> json) => _$UsageRequestFromJson(json);

  const UsageRequest._();

  /// Validate usage request
  ValidationResult validate() {
    final errors = <String>[];

    if (accountNumber.trim().isEmpty) {
      errors.add('Account number is required');
    }
    if (startDate.isAfter(endDate)) {
      errors.add('Start date cannot be after end date');
    }
    if (endDate.isAfter(DateTime.now())) {
      errors.add('End date cannot be in the future');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Bill request DTO
@freezed
class BillRequest with _$BillRequest {
  const factory BillRequest({
    required String accountNumber,
    @Default(10) int limit,
    @Default(0) int offset,
    @Default(BillStatus.pending) BillStatus status,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool includePaymentHistory,
    @Default(false) bool includeCalculations,
  }) = _BillRequest;

  factory BillRequest.fromJson(Map<String, dynamic> json) => _$BillRequestFromJson(json);

  const BillRequest._();

  /// Validate bill request
  ValidationResult validate() {
    final errors = <String>[];

    if (accountNumber.trim().isEmpty) {
      errors.add('Account number is required');
    }
    if (limit <= 0) {
      errors.add('Limit must be positive');
    }
    if (offset < 0) {
      errors.add('Offset cannot be negative');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// User profile update request DTO
@freezed
class UserProfileUpdateRequest with _$UserProfileUpdateRequest {
  const factory UserProfileUpdateRequest({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    Address? address,
    UserPreferences? preferences,
    UserSettings? settings,
    Map<String, dynamic>? metadata,
  }) = _UserProfileUpdateRequest;

  factory UserProfileUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserProfileUpdateRequestFromJson(json);

  const UserProfileUpdateRequest._();

  /// Validate profile update request
  ValidationResult validate() {
    final errors = <String>[];

    if (firstName != null && firstName!.trim().isEmpty) {
      errors.add('First name cannot be empty');
    }
    if (lastName != null && lastName!.trim().isEmpty) {
      errors.add('Last name cannot be empty');
    }
    if (email != null && !_isValidEmail(email!)) {
      errors.add('Invalid email format');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  bool _isValidEmail(String email) => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
}

/// Notification request DTO
@freezed
class NotificationRequest with _$NotificationRequest {
  const factory NotificationRequest({
    required String userId,
    required NotificationType type,
    required String title,
    required String message,
    @Default(false) bool isImportant,
    @Default(false) bool sendEmail,
    @Default(false) bool sendSms,
    @Default(false) bool sendPush,
    Map<String, dynamic>? metadata,
  }) = _NotificationRequest;

  factory NotificationRequest.fromJson(Map<String, dynamic> json) => _$NotificationRequestFromJson(json);

  const NotificationRequest._();

  /// Validate notification request
  ValidationResult validate() {
    final errors = <String>[];

    if (userId.trim().isEmpty) {
      errors.add('User ID is required');
    }
    if (title.trim().isEmpty) {
      errors.add('Title is required');
    }
    if (message.trim().isEmpty) {
      errors.add('Message is required');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Analytics request DTO
@freezed
class AnalyticsRequest with _$AnalyticsRequest {
  const factory AnalyticsRequest({
    required String accountNumber,
    required DateTime startDate,
    required DateTime endDate,
    @Default([]) List<AnalyticsMetric> metrics,
    @Default(AnalyticsGranularity.daily) AnalyticsGranularity granularity,
    @Default(false) bool includeComparisons,
    @Default(false) bool includeForecasts,
  }) = _AnalyticsRequest;

  factory AnalyticsRequest.fromJson(Map<String, dynamic> json) => _$AnalyticsRequestFromJson(json);

  const AnalyticsRequest._();

  /// Validate analytics request
  ValidationResult validate() {
    final errors = <String>[];

    if (accountNumber.trim().isEmpty) {
      errors.add('Account number is required');
    }
    if (startDate.isAfter(endDate)) {
      errors.add('Start date cannot be after end date');
    }
    if (metrics.isEmpty) {
      errors.add('At least one metric must be specified');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Analytics response DTO
@freezed
class AnalyticsResponse with _$AnalyticsResponse {
  const factory AnalyticsResponse({
    required List<AnalyticsDataPoint> dataPoints,
    required Map<String, double> summary,
    @Default([]) List<AnalyticsInsight> insights,
    @Default([]) List<AnalyticsRecommendation> recommendations,
  }) = _AnalyticsResponse;

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) => _$AnalyticsResponseFromJson(json);
}

/// Analytics data point
@freezed
class AnalyticsDataPoint with _$AnalyticsDataPoint {
  const factory AnalyticsDataPoint({
    required DateTime timestamp,
    required Map<String, double> values,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AnalyticsDataPoint;

  factory AnalyticsDataPoint.fromJson(Map<String, dynamic> json) => _$AnalyticsDataPointFromJson(json);
}

/// Analytics insight
@freezed
class AnalyticsInsight with _$AnalyticsInsight {
  const factory AnalyticsInsight({
    required String id,
    required String title,
    required String description,
    required InsightType type,
    required double confidence,
    @Default([]) List<String> tags,
  }) = _AnalyticsInsight;

  factory AnalyticsInsight.fromJson(Map<String, dynamic> json) => _$AnalyticsInsightFromJson(json);
}

/// Analytics recommendation
@freezed
class AnalyticsRecommendation with _$AnalyticsRecommendation {
  const factory AnalyticsRecommendation({
    required String id,
    required String title,
    required String description,
    required RecommendationType type,
    required double potentialSavings,
    required String difficulty,
    @Default([]) List<String> tags,
  }) = _AnalyticsRecommendation;

  factory AnalyticsRecommendation.fromJson(Map<String, dynamic> json) => _$AnalyticsRecommendationFromJson(json);
}

/// Error response DTO
@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required String error,
    required String message,
    @Default(null) String? errorCode,
    @Default(null) String? details,
    @Default(null) Map<String, dynamic>? metadata,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}

/// Success response DTO
@freezed
class SuccessResponse with _$SuccessResponse {
  const factory SuccessResponse({
    required String message,
    @Default(null) Map<String, dynamic>? data,
    @Default(null) Map<String, dynamic>? metadata,
  }) = _SuccessResponse;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => _$SuccessResponseFromJson(json);
}

// Enums
enum PaymentMethodType {
  creditCard,
  debitCard,
  bankAccount,
  paypal,
  applePay,
  googlePay,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
}

enum UsageGranularity {
  hourly,
  daily,
  weekly,
  monthly,
  yearly,
}

enum BillStatus {
  pending,
  paid,
  overdue,
  cancelled,
  disputed,
}

enum NotificationType {
  billReminder,
  paymentConfirmation,
  usageAlert,
  maintenanceNotice,
  securityAlert,
  systemUpdate,
}

enum AnalyticsMetric {
  usage,
  cost,
  efficiency,
  peakUsage,
  lowUsage,
  trends,
}

enum AnalyticsGranularity {
  hourly,
  daily,
  weekly,
  monthly,
  yearly,
}

enum InsightType {
  usagePattern,
  costOptimization,
  efficiency,
  anomaly,
  trend,
}

enum RecommendationType {
  energySaving,
  costReduction,
  efficiencyImprovement,
  behaviorChange,
  equipmentUpgrade,
}

/// Address class (reused from user model)
@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

/// User preferences class (reused from user model)
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required NotificationSettings notifications,
    required String currency,
    required String timezone,
    required String language,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);
}

/// Notification settings class (reused from user model)
@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    required bool email,
    required bool sms,
    required bool push,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}

/// User settings class (reused from user model)
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(true) bool darkMode,
    @Default(true) bool autoRefresh,
    @Default(30) int refreshIntervalMinutes,
    @Default(true) bool showNotifications,
    @Default(true) bool showUsageAlerts,
    @Default(true) bool showPaymentReminders,
    @Default('en') String language,
    @Default('USD') String currency,
    @Default('America/New_York') String timezone,
    @Default(12) int dateFormat,
    @Default(true) bool analyticsEnabled,
    @Default(true) bool crashReportingEnabled,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required DailyCostSummaryData dailyCostSummary,
    required EnergyPricesData energyPrices,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}

@freezed
class DailyCostSummaryData with _$DailyCostSummaryData {
  const factory DailyCostSummaryData({
    required String title,
    required String description,
    required String billingCycle,
    required String estimateDisclaimer,
  }) = _DailyCostSummaryData;

  factory DailyCostSummaryData.fromJson(Map<String, dynamic> json) =>
      _$DailyCostSummaryDataFromJson(json);
}

@freezed
class EnergyPricesData with _$EnergyPricesData {
  const factory EnergyPricesData({
    required String title,
    required String description,
  }) = _EnergyPricesData;

  factory EnergyPricesData.fromJson(Map<String, dynamic> json) =>
      _$EnergyPricesDataFromJson(json);
}

@freezed
class EnergyPricePoint with _$EnergyPricePoint {
  const factory EnergyPricePoint({
    required DateTime date,
    required double? actual,
    required double priceSignal,
  }) = _EnergyPricePoint;

  factory EnergyPricePoint.fromJson(Map<String, dynamic> json) =>
      _$EnergyPricePointFromJson(json);
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
