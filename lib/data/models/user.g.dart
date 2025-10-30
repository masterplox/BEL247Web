// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phone: json['phone'] as String,
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  accountNumber: json['accountNumber'] as String,
  serviceAddress: Address.fromJson(
    json['serviceAddress'] as Map<String, dynamic>,
  ),
  meterNumber: json['meterNumber'] as String,
  tariffPlan: json['tariffPlan'] as String,
  connectionDate: DateTime.parse(json['connectionDate'] as String),
  lastLogin: DateTime.parse(json['lastLogin'] as String),
  preferences: UserPreferences.fromJson(
    json['preferences'] as Map<String, dynamic>,
  ),
  accountBalance: AccountBalance.fromJson(
    json['accountBalance'] as Map<String, dynamic>,
  ),
  usageSummary: UsageSummary.fromJson(
    json['usageSummary'] as Map<String, dynamic>,
  ),
  profile: json['profile'] == null
      ? const UserProfile()
      : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
  settings: json['settings'] == null
      ? const UserSettings()
      : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
  security: json['security'] == null
      ? const UserSecurity()
      : UserSecurity.fromJson(json['security'] as Map<String, dynamic>),
  paymentMethods:
      (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  notificationHistory:
      (json['notificationHistory'] as List<dynamic>?)
          ?.map((e) => NotificationHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  status:
      $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
      UserStatus.active,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'address': instance.address,
      'accountNumber': instance.accountNumber,
      'serviceAddress': instance.serviceAddress,
      'meterNumber': instance.meterNumber,
      'tariffPlan': instance.tariffPlan,
      'connectionDate': instance.connectionDate.toIso8601String(),
      'lastLogin': instance.lastLogin.toIso8601String(),
      'preferences': instance.preferences,
      'accountBalance': instance.accountBalance,
      'usageSummary': instance.usageSummary,
      'profile': instance.profile,
      'settings': instance.settings,
      'security': instance.security,
      'paymentMethods': instance.paymentMethods,
      'notificationHistory': instance.notificationHistory,
      'status': _$UserStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.inactive: 'inactive',
  UserStatus.suspended: 'suspended',
  UserStatus.pending: 'pending',
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

_$AccountBalanceImpl _$$AccountBalanceImplFromJson(Map<String, dynamic> json) =>
    _$AccountBalanceImpl(
      currentBalance: (json['currentBalance'] as num).toDouble(),
      lastPaymentDate: DateTime.parse(json['lastPaymentDate'] as String),
      lastPaymentAmount: (json['lastPaymentAmount'] as num).toDouble(),
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$$AccountBalanceImplToJson(
  _$AccountBalanceImpl instance,
) => <String, dynamic>{
  'currentBalance': instance.currentBalance,
  'lastPaymentDate': instance.lastPaymentDate.toIso8601String(),
  'lastPaymentAmount': instance.lastPaymentAmount,
  'nextDueDate': instance.nextDueDate.toIso8601String(),
  'paymentMethod': instance.paymentMethod,
};

_$UsageSummaryImpl _$$UsageSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$UsageSummaryImpl(
  currentMonth: UsagePeriod.fromJson(
    json['currentMonth'] as Map<String, dynamic>,
  ),
  lastMonth: UsagePeriod.fromJson(json['lastMonth'] as Map<String, dynamic>),
  yearToDate: UsagePeriod.fromJson(json['yearToDate'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$UsageSummaryImplToJson(_$UsageSummaryImpl instance) =>
    <String, dynamic>{
      'currentMonth': instance.currentMonth,
      'lastMonth': instance.lastMonth,
      'yearToDate': instance.yearToDate,
    };

_$UsagePeriodImpl _$$UsagePeriodImplFromJson(Map<String, dynamic> json) =>
    _$UsagePeriodImpl(
      kwh: (json['kwh'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      averageDaily: (json['averageDaily'] as num).toDouble(),
    );

Map<String, dynamic> _$$UsagePeriodImplToJson(_$UsagePeriodImpl instance) =>
    <String, dynamic>{
      'kwh': instance.kwh,
      'cost': instance.cost,
      'averageDaily': instance.averageDaily,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      occupation: json['occupation'] as String?,
      company: json['company'] as String?,
      website: json['website'] as String?,
      interests:
          (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      socialLinks:
          (json['socialLinks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'occupation': instance.occupation,
      'company': instance.company,
      'website': instance.website,
      'interests': instance.interests,
      'socialLinks': instance.socialLinks,
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

_$UserSecurityImpl _$$UserSecurityImplFromJson(Map<String, dynamic> json) =>
    _$UserSecurityImpl(
      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      trustedDevices:
          (json['trustedDevices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastPasswordChange: json['lastPasswordChange'] == null
          ? null
          : DateTime.parse(json['lastPasswordChange'] as String),
      failedLoginAttempts: (json['failedLoginAttempts'] as num?)?.toInt() ?? 0,
      lastFailedLogin: json['lastFailedLogin'] == null
          ? null
          : DateTime.parse(json['lastFailedLogin'] as String),
      accountLocked: json['accountLocked'] as bool? ?? false,
      accountLockedUntil: json['accountLockedUntil'] == null
          ? null
          : DateTime.parse(json['accountLockedUntil'] as String),
    );

Map<String, dynamic> _$$UserSecurityImplToJson(_$UserSecurityImpl instance) =>
    <String, dynamic>{
      'twoFactorEnabled': instance.twoFactorEnabled,
      'biometricEnabled': instance.biometricEnabled,
      'trustedDevices': instance.trustedDevices,
      'lastPasswordChange': instance.lastPasswordChange?.toIso8601String(),
      'failedLoginAttempts': instance.failedLoginAttempts,
      'lastFailedLogin': instance.lastFailedLogin?.toIso8601String(),
      'accountLocked': instance.accountLocked,
      'accountLockedUntil': instance.accountLockedUntil?.toIso8601String(),
    };

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      cardholderName: json['cardholderName'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      isPrimary: json['isPrimary'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'lastFourDigits': instance.lastFourDigits,
      'cardholderName': instance.cardholderName,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'isPrimary': instance.isPrimary,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$NotificationHistoryImpl _$$NotificationHistoryImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationHistoryImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  isRead: json['isRead'] as bool? ?? false,
  isImportant: json['isImportant'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$NotificationHistoryImplToJson(
  _$NotificationHistoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'timestamp': instance.timestamp.toIso8601String(),
  'isRead': instance.isRead,
  'isImportant': instance.isImportant,
  'metadata': instance.metadata,
};
