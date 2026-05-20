// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthRequestImpl _$$AuthRequestImplFromJson(Map<String, dynamic> json) =>
    _$AuthRequestImpl(
      username: json['username'] as String,
      password: json['password'] as String,
      rememberMe: json['rememberMe'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthRequestImplToJson(_$AuthRequestImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'rememberMe': instance.rememberMe,
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      userSession: UserSession.fromJson(
        json['userSession'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'userSession': instance.userSession,
    };

_$TokenPairImpl _$$TokenPairImplFromJson(Map<String, dynamic> json) =>
    _$TokenPairImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accessTokenExpiresAt: DateTime.parse(
        json['accessTokenExpiresAt'] as String,
      ),
      refreshTokenExpiresAt: DateTime.parse(
        json['refreshTokenExpiresAt'] as String,
      ),
    );

Map<String, dynamic> _$$TokenPairImplToJson(_$TokenPairImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiresAt': instance.accessTokenExpiresAt.toIso8601String(),
      'refreshTokenExpiresAt': instance.refreshTokenExpiresAt.toIso8601String(),
    };

_$UserSessionImpl _$$UserSessionImplFromJson(Map<String, dynamic> json) =>
    _$UserSessionImpl(
      userId: json['userId'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      loginTime: DateTime.parse(json['loginTime'] as String),
      lastActivity: DateTime.parse(json['lastActivity'] as String),
      isActive: json['isActive'] as bool? ?? false,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserSessionImplToJson(_$UserSessionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'loginTime': instance.loginTime.toIso8601String(),
      'lastActivity': instance.lastActivity.toIso8601String(),
      'isActive': instance.isActive,
      'preferences': instance.preferences,
    };

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      isInitialized: json['isInitialized'] as bool? ?? false,
      userSession: json['userSession'] == null
          ? null
          : UserSession.fromJson(json['userSession'] as Map<String, dynamic>),
      error: json['error'] as String?,
      lastRefresh: json['lastRefresh'] == null
          ? null
          : DateTime.parse(json['lastRefresh'] as String),
      otpSent: json['otpSent'] as bool? ?? false,
      otpContact: json['otpContact'] as String?,
      otpVerified: json['otpVerified'] as bool? ?? false,
      signupCompleted: json['signupCompleted'] as bool? ?? false,
      guestUUID: json['guestUUID'] as String?,
      signupContactType: json['signupContactType'] as String?,
      passwordResetContactType: json['passwordResetContactType'] as String?,
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'isLoading': instance.isLoading,
      'isInitialized': instance.isInitialized,
      'userSession': instance.userSession,
      'error': instance.error,
      'lastRefresh': instance.lastRefresh?.toIso8601String(),
      'otpSent': instance.otpSent,
      'otpContact': instance.otpContact,
      'otpVerified': instance.otpVerified,
      'signupCompleted': instance.signupCompleted,
      'guestUUID': instance.guestUUID,
      'signupContactType': instance.signupContactType,
      'passwordResetContactType': instance.passwordResetContactType,
    };

_$TokenRefreshRequestImpl _$$TokenRefreshRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TokenRefreshRequestImpl(
  refreshToken: json['refreshToken'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$$TokenRefreshRequestImplToJson(
  _$TokenRefreshRequestImpl instance,
) => <String, dynamic>{
  'refreshToken': instance.refreshToken,
  'userId': instance.userId,
};

_$TokenRefreshResponseImpl _$$TokenRefreshResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TokenRefreshResponseImpl(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$$TokenRefreshResponseImplToJson(
  _$TokenRefreshResponseImpl instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt.toIso8601String(),
};

_$LogoutRequestImpl _$$LogoutRequestImplFromJson(Map<String, dynamic> json) =>
    _$LogoutRequestImpl(
      userId: json['userId'] as String,
      logoutAllDevices: json['logoutAllDevices'] as bool? ?? false,
    );

Map<String, dynamic> _$$LogoutRequestImplToJson(_$LogoutRequestImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'logoutAllDevices': instance.logoutAllDevices,
    };

_$PasswordChangeRequestImpl _$$PasswordChangeRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PasswordChangeRequestImpl(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$$PasswordChangeRequestImplToJson(
  _$PasswordChangeRequestImpl instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};

_$AuthValidationResultImpl _$$AuthValidationResultImplFromJson(
  Map<String, dynamic> json,
) => _$AuthValidationResultImpl(
  isValid: json['isValid'] as bool? ?? true,
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  fieldErrors:
      (json['fieldErrors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
);

Map<String, dynamic> _$$AuthValidationResultImplToJson(
  _$AuthValidationResultImpl instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'errors': instance.errors,
  'fieldErrors': instance.fieldErrors,
};

_$OtpSendRequestImpl _$$OtpSendRequestImplFromJson(Map<String, dynamic> json) =>
    _$OtpSendRequestImpl(contact: json['contact'] as String);

Map<String, dynamic> _$$OtpSendRequestImplToJson(
  _$OtpSendRequestImpl instance,
) => <String, dynamic>{'contact': instance.contact};

_$OtpVerifyRequestImpl _$$OtpVerifyRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OtpVerifyRequestImpl(
  contact: json['contact'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$$OtpVerifyRequestImplToJson(
  _$OtpVerifyRequestImpl instance,
) => <String, dynamic>{'contact': instance.contact, 'otp': instance.otp};

_$SignUpRequestImpl _$$SignUpRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignUpRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      contact: json['contact'] as String,
    );

Map<String, dynamic> _$$SignUpRequestImplToJson(_$SignUpRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'contact': instance.contact,
    };

_$PasswordResetRequestImpl _$$PasswordResetRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PasswordResetRequestImpl(
  phone: json['phone'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$$PasswordResetRequestImplToJson(
  _$PasswordResetRequestImpl instance,
) => <String, dynamic>{
  'phone': instance.phone,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
  'otp': instance.otp,
};

_$PasswordCodeRequestImpl _$$PasswordCodeRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PasswordCodeRequestImpl(
  mobileNumber: json['mobileNumber'] as String?,
  email: json['email'] as String?,
  username: json['username'] as String?,
);

Map<String, dynamic> _$$PasswordCodeRequestImplToJson(
  _$PasswordCodeRequestImpl instance,
) => <String, dynamic>{
  'mobileNumber': instance.mobileNumber,
  'email': instance.email,
  'username': instance.username,
};

_$DevicePasswordResetRequestImpl _$$DevicePasswordResetRequestImplFromJson(
  Map<String, dynamic> json,
) => _$DevicePasswordResetRequestImpl(
  username: json['username'] as String,
  password: json['password'] as String,
  passwordCode: json['passwordCode'] as String,
);

Map<String, dynamic> _$$DevicePasswordResetRequestImplToJson(
  _$DevicePasswordResetRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'passwordCode': instance.passwordCode,
};

_$SignUpStep1RequestImpl _$$SignUpStep1RequestImplFromJson(
  Map<String, dynamic> json,
) => _$SignUpStep1RequestImpl(
  mobileNumber: json['mobileNumber'] as String?,
  email: json['email'] as String?,
  username: json['username'] as String?,
);

Map<String, dynamic> _$$SignUpStep1RequestImplToJson(
  _$SignUpStep1RequestImpl instance,
) => <String, dynamic>{
  'mobileNumber': instance.mobileNumber,
  'email': instance.email,
  'username': instance.username,
};

_$SignUpStep2RequestImpl _$$SignUpStep2RequestImplFromJson(
  Map<String, dynamic> json,
) => _$SignUpStep2RequestImpl(
  code: json['code'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$$SignUpStep2RequestImplToJson(
  _$SignUpStep2RequestImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
};

_$SignUpStep3RequestImpl _$$SignUpStep3RequestImplFromJson(
  Map<String, dynamic> json,
) => _$SignUpStep3RequestImpl(
  username: json['username'] as String,
  password: json['password'] as String,
  email: json['email'] as String?,
  mobileNumber: json['mobileNumber'] as String?,
  guestUUID: json['guestUUID'] as String? ?? '',
);

Map<String, dynamic> _$$SignUpStep3RequestImplToJson(
  _$SignUpStep3RequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'email': instance.email,
  'mobileNumber': instance.mobileNumber,
  'guestUUID': instance.guestUUID,
};
