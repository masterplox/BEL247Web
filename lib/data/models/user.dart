import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/services/input_validator_service.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required Address address,
    required String accountNumber,
    required Address serviceAddress,
    required String meterNumber,
    required String tariffPlan,
    required DateTime connectionDate,
    required DateTime lastLogin,
    required UserPreferences preferences,
    required AccountBalance accountBalance,
    required UsageSummary usageSummary,
    @Default(UserProfile()) UserProfile profile,
    @Default(UserSettings()) UserSettings settings,
    @Default(UserSecurity()) UserSecurity security,
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default([]) List<NotificationHistory> notificationHistory,
    @Default(UserStatus.active) UserStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User._();

  /// Validate user data
  ValidationResult validate() {
    final validator = InputValidatorService();
    final errors = <String>[];

    // Validate email
    final emailResult = validator.validateEmail(email);
    if (!emailResult.isValid) {
      errors.add('Email: ${emailResult.errorMessage}');
    }

    // Validate phone
    final phoneResult = validator.validatePhoneNumber(phone);
    if (!phoneResult.isValid) {
      errors.add('Phone: ${phoneResult.errorMessage}');
    }

    // Validate names
    if (firstName.trim().isEmpty) {
      errors.add('First name is required');
    }
    if (lastName.trim().isEmpty) {
      errors.add('Last name is required');
    }

    // Validate account number
    if (accountNumber.trim().isEmpty) {
      errors.add('Account number is required');
    }

    // Validate meter number
    if (meterNumber.trim().isEmpty) {
      errors.add('Meter number is required');
    }

    // Validate addresses
    final addressErrors = address.validate();
    if (addressErrors.isNotEmpty) {
      errors.addAll(addressErrors.map((e) => 'Address: $e'));
    }

    final serviceAddressErrors = serviceAddress.validate();
    if (serviceAddressErrors.isNotEmpty) {
      errors.addAll(serviceAddressErrors.map((e) => 'Service Address: $e'));
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Get user display name
  String get displayName => '$firstName $lastName';

  /// Get user initials
  String get initials => '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'.toUpperCase();

  /// Check if user is active
  bool get isActive => status == UserStatus.active;

  /// Check if user has payment methods
  bool get hasPaymentMethods => paymentMethods.isNotEmpty;

  /// Get primary payment method
  PaymentMethod? get primaryPaymentMethod => paymentMethods.where((p) => p.isPrimary).firstOrNull;

  /// Get user's full address
  String get fullAddress => address.toString();

  /// Get user's service address
  String get fullServiceAddress => serviceAddress.toString();
}

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

  const Address._();

  /// Validate address data
  List<String> validate() {
    final errors = <String>[];

    if (street.trim().isEmpty) {
      errors.add('Street is required');
    }
    if (city.trim().isEmpty) {
      errors.add('City is required');
    }
    if (state.trim().isEmpty) {
      errors.add('State is required');
    }
    if (zipCode.trim().isEmpty) {
      errors.add('ZIP code is required');
    }
    if (country.trim().isEmpty) {
      errors.add('Country is required');
    }

    return errors;
  }

  @override
  String toString() => '$street, $city, $state $zipCode, $country';
}

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

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    required bool email,
    required bool sms,
    required bool push,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}

@freezed
class AccountBalance with _$AccountBalance {
  const factory AccountBalance({
    required double currentBalance,
    required DateTime lastPaymentDate,
    required double lastPaymentAmount,
    required DateTime nextDueDate,
    required String paymentMethod,
  }) = _AccountBalance;

  factory AccountBalance.fromJson(Map<String, dynamic> json) => _$AccountBalanceFromJson(json);
}

@freezed
class UsageSummary with _$UsageSummary {
  const factory UsageSummary({
    required UsagePeriod currentMonth,
    required UsagePeriod lastMonth,
    required UsagePeriod yearToDate,
  }) = _UsageSummary;

  factory UsageSummary.fromJson(Map<String, dynamic> json) => _$UsageSummaryFromJson(json);
}

@freezed
class UsagePeriod with _$UsagePeriod {
  const factory UsagePeriod({
    required double kwh,
    required double cost,
    required double averageDaily,
  }) = _UsagePeriod;

  factory UsagePeriod.fromJson(Map<String, dynamic> json) => _$UsagePeriodFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? profilePicture,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? occupation,
    String? company,
    String? website,
    @Default([]) List<String> interests,
    @Default([]) List<String> socialLinks,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

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
class UserSecurity with _$UserSecurity {
  const factory UserSecurity({
    @Default(false) bool twoFactorEnabled,
    @Default(false) bool biometricEnabled,
    @Default([]) List<String> trustedDevices,
    DateTime? lastPasswordChange,
    @Default(0) int failedLoginAttempts,
    DateTime? lastFailedLogin,
    @Default(false) bool accountLocked,
    DateTime? accountLockedUntil,
  }) = _UserSecurity;

  factory UserSecurity.fromJson(Map<String, dynamic> json) => _$UserSecurityFromJson(json);
}

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String type,
    required String lastFourDigits,
    required String cardholderName,
    required DateTime expiryDate,
    @Default(false) bool isPrimary,
    @Default(false) bool isActive,
    DateTime? createdAt,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  const PaymentMethod._();

  /// Check if payment method is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  /// Get masked card number
  String get maskedNumber => '**** **** **** $lastFourDigits';

  /// Get expiry month/year
  String get expiryString => '${expiryDate.month.toString().padLeft(2, '0')}/${expiryDate.year.toString().substring(2)}';
}

@freezed
class NotificationHistory with _$NotificationHistory {
  const factory NotificationHistory({
    required String id,
    required String type,
    required String title,
    required String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(false) bool isImportant,
    Map<String, dynamic>? metadata,
  }) = _NotificationHistory;

  factory NotificationHistory.fromJson(Map<String, dynamic> json) => _$NotificationHistoryFromJson(json);
}

enum UserStatus {
  active,
  inactive,
  suspended,
  pending,
}

enum PaymentMethodType {
  creditCard,
  debitCard,
  bankAccount,
  paypal,
  applePay,
  googlePay,
}

enum NotificationType {
  billReminder,
  paymentConfirmation,
  usageAlert,
  maintenanceNotice,
  securityAlert,
  systemUpdate,
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
