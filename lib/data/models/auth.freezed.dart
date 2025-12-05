// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) {
  return _AuthRequest.fromJson(json);
}

/// @nodoc
mixin _$AuthRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get rememberMe => throw _privateConstructorUsedError;

  /// Serializes this AuthRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthRequestCopyWith<AuthRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthRequestCopyWith<$Res> {
  factory $AuthRequestCopyWith(
    AuthRequest value,
    $Res Function(AuthRequest) then,
  ) = _$AuthRequestCopyWithImpl<$Res, AuthRequest>;
  @useResult
  $Res call({String email, String password, bool rememberMe});
}

/// @nodoc
class _$AuthRequestCopyWithImpl<$Res, $Val extends AuthRequest>
    implements $AuthRequestCopyWith<$Res> {
  _$AuthRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? rememberMe = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            rememberMe: null == rememberMe
                ? _value.rememberMe
                : rememberMe // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthRequestImplCopyWith<$Res>
    implements $AuthRequestCopyWith<$Res> {
  factory _$$AuthRequestImplCopyWith(
    _$AuthRequestImpl value,
    $Res Function(_$AuthRequestImpl) then,
  ) = __$$AuthRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, bool rememberMe});
}

/// @nodoc
class __$$AuthRequestImplCopyWithImpl<$Res>
    extends _$AuthRequestCopyWithImpl<$Res, _$AuthRequestImpl>
    implements _$$AuthRequestImplCopyWith<$Res> {
  __$$AuthRequestImplCopyWithImpl(
    _$AuthRequestImpl _value,
    $Res Function(_$AuthRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? rememberMe = null,
  }) {
    return _then(
      _$AuthRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        rememberMe: null == rememberMe
            ? _value.rememberMe
            : rememberMe // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthRequestImpl implements _AuthRequest {
  const _$AuthRequestImpl({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  factory _$AuthRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey()
  final bool rememberMe;

  @override
  String toString() {
    return 'AuthRequest(email: $email, password: $password, rememberMe: $rememberMe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.rememberMe, rememberMe) ||
                other.rememberMe == rememberMe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password, rememberMe);

  /// Create a copy of AuthRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRequestImplCopyWith<_$AuthRequestImpl> get copyWith =>
      __$$AuthRequestImplCopyWithImpl<_$AuthRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthRequestImplToJson(this);
  }
}

abstract class _AuthRequest implements AuthRequest {
  const factory _AuthRequest({
    required final String email,
    required final String password,
    final bool rememberMe,
  }) = _$AuthRequestImpl;

  factory _AuthRequest.fromJson(Map<String, dynamic> json) =
      _$AuthRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  bool get rememberMe;

  /// Create a copy of AuthRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRequestImplCopyWith<_$AuthRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return _AuthResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  UserSession get userSession => throw _privateConstructorUsedError;

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseCopyWith<AuthResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseCopyWith<$Res> {
  factory $AuthResponseCopyWith(
    AuthResponse value,
    $Res Function(AuthResponse) then,
  ) = _$AuthResponseCopyWithImpl<$Res, AuthResponse>;
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    String userId,
    DateTime expiresAt,
    UserSession userSession,
  });

  $UserSessionCopyWith<$Res> get userSession;
}

/// @nodoc
class _$AuthResponseCopyWithImpl<$Res, $Val extends AuthResponse>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = null,
    Object? expiresAt = null,
    Object? userSession = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userSession: null == userSession
                ? _value.userSession
                : userSession // ignore: cast_nullable_to_non_nullable
                      as UserSession,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSessionCopyWith<$Res> get userSession {
    return $UserSessionCopyWith<$Res>(_value.userSession, (value) {
      return _then(_value.copyWith(userSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthResponseImplCopyWith<$Res>
    implements $AuthResponseCopyWith<$Res> {
  factory _$$AuthResponseImplCopyWith(
    _$AuthResponseImpl value,
    $Res Function(_$AuthResponseImpl) then,
  ) = __$$AuthResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    String userId,
    DateTime expiresAt,
    UserSession userSession,
  });

  @override
  $UserSessionCopyWith<$Res> get userSession;
}

/// @nodoc
class __$$AuthResponseImplCopyWithImpl<$Res>
    extends _$AuthResponseCopyWithImpl<$Res, _$AuthResponseImpl>
    implements _$$AuthResponseImplCopyWith<$Res> {
  __$$AuthResponseImplCopyWithImpl(
    _$AuthResponseImpl _value,
    $Res Function(_$AuthResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? userId = null,
    Object? expiresAt = null,
    Object? userSession = null,
  }) {
    return _then(
      _$AuthResponseImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userSession: null == userSession
            ? _value.userSession
            : userSession // ignore: cast_nullable_to_non_nullable
                  as UserSession,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseImpl implements _AuthResponse {
  const _$AuthResponseImpl({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.expiresAt,
    required this.userSession,
  });

  factory _$AuthResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String userId;
  @override
  final DateTime expiresAt;
  @override
  final UserSession userSession;

  @override
  String toString() {
    return 'AuthResponse(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, expiresAt: $expiresAt, userSession: $userSession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.userSession, userSession) ||
                other.userSession == userSession));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    refreshToken,
    userId,
    expiresAt,
    userSession,
  );

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      __$$AuthResponseImplCopyWithImpl<_$AuthResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseImplToJson(this);
  }
}

abstract class _AuthResponse implements AuthResponse {
  const factory _AuthResponse({
    required final String accessToken,
    required final String refreshToken,
    required final String userId,
    required final DateTime expiresAt,
    required final UserSession userSession,
  }) = _$AuthResponseImpl;

  factory _AuthResponse.fromJson(Map<String, dynamic> json) =
      _$AuthResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  String get userId;
  @override
  DateTime get expiresAt;
  @override
  UserSession get userSession;

  /// Create a copy of AuthResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseImplCopyWith<_$AuthResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) {
  return _TokenPair.fromJson(json);
}

/// @nodoc
mixin _$TokenPair {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  DateTime get accessTokenExpiresAt => throw _privateConstructorUsedError;
  DateTime get refreshTokenExpiresAt => throw _privateConstructorUsedError;

  /// Serializes this TokenPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPairCopyWith<TokenPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPairCopyWith<$Res> {
  factory $TokenPairCopyWith(TokenPair value, $Res Function(TokenPair) then) =
      _$TokenPairCopyWithImpl<$Res, TokenPair>;
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    DateTime accessTokenExpiresAt,
    DateTime refreshTokenExpiresAt,
  });
}

/// @nodoc
class _$TokenPairCopyWithImpl<$Res, $Val extends TokenPair>
    implements $TokenPairCopyWith<$Res> {
  _$TokenPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? accessTokenExpiresAt = null,
    Object? refreshTokenExpiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            accessTokenExpiresAt: null == accessTokenExpiresAt
                ? _value.accessTokenExpiresAt
                : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            refreshTokenExpiresAt: null == refreshTokenExpiresAt
                ? _value.refreshTokenExpiresAt
                : refreshTokenExpiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenPairImplCopyWith<$Res>
    implements $TokenPairCopyWith<$Res> {
  factory _$$TokenPairImplCopyWith(
    _$TokenPairImpl value,
    $Res Function(_$TokenPairImpl) then,
  ) = __$$TokenPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    DateTime accessTokenExpiresAt,
    DateTime refreshTokenExpiresAt,
  });
}

/// @nodoc
class __$$TokenPairImplCopyWithImpl<$Res>
    extends _$TokenPairCopyWithImpl<$Res, _$TokenPairImpl>
    implements _$$TokenPairImplCopyWith<$Res> {
  __$$TokenPairImplCopyWithImpl(
    _$TokenPairImpl _value,
    $Res Function(_$TokenPairImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? accessTokenExpiresAt = null,
    Object? refreshTokenExpiresAt = null,
  }) {
    return _then(
      _$TokenPairImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        accessTokenExpiresAt: null == accessTokenExpiresAt
            ? _value.accessTokenExpiresAt
            : accessTokenExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        refreshTokenExpiresAt: null == refreshTokenExpiresAt
            ? _value.refreshTokenExpiresAt
            : refreshTokenExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenPairImpl implements _TokenPair {
  const _$TokenPairImpl({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });

  factory _$TokenPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenPairImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final DateTime accessTokenExpiresAt;
  @override
  final DateTime refreshTokenExpiresAt;

  @override
  String toString() {
    return 'TokenPair(accessToken: $accessToken, refreshToken: $refreshToken, accessTokenExpiresAt: $accessTokenExpiresAt, refreshTokenExpiresAt: $refreshTokenExpiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPairImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.accessTokenExpiresAt, accessTokenExpiresAt) ||
                other.accessTokenExpiresAt == accessTokenExpiresAt) &&
            (identical(other.refreshTokenExpiresAt, refreshTokenExpiresAt) ||
                other.refreshTokenExpiresAt == refreshTokenExpiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    refreshToken,
    accessTokenExpiresAt,
    refreshTokenExpiresAt,
  );

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      __$$TokenPairImplCopyWithImpl<_$TokenPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenPairImplToJson(this);
  }
}

abstract class _TokenPair implements TokenPair {
  const factory _TokenPair({
    required final String accessToken,
    required final String refreshToken,
    required final DateTime accessTokenExpiresAt,
    required final DateTime refreshTokenExpiresAt,
  }) = _$TokenPairImpl;

  factory _TokenPair.fromJson(Map<String, dynamic> json) =
      _$TokenPairImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  DateTime get accessTokenExpiresAt;
  @override
  DateTime get refreshTokenExpiresAt;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSession _$UserSessionFromJson(Map<String, dynamic> json) {
  return _UserSession.fromJson(json);
}

/// @nodoc
mixin _$UserSession {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get loginTime => throw _privateConstructorUsedError;
  DateTime get lastActivity => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// Serializes this UserSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSessionCopyWith<UserSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSessionCopyWith<$Res> {
  factory $UserSessionCopyWith(
    UserSession value,
    $Res Function(UserSession) then,
  ) = _$UserSessionCopyWithImpl<$Res, UserSession>;
  @useResult
  $Res call({
    String userId,
    String email,
    String firstName,
    String lastName,
    DateTime loginTime,
    DateTime lastActivity,
    bool isActive,
    Map<String, dynamic> preferences,
  });
}

/// @nodoc
class _$UserSessionCopyWithImpl<$Res, $Val extends UserSession>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? loginTime = null,
    Object? lastActivity = null,
    Object? isActive = null,
    Object? preferences = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            loginTime: null == loginTime
                ? _value.loginTime
                : loginTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastActivity: null == lastActivity
                ? _value.lastActivity
                : lastActivity // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSessionImplCopyWith<$Res>
    implements $UserSessionCopyWith<$Res> {
  factory _$$UserSessionImplCopyWith(
    _$UserSessionImpl value,
    $Res Function(_$UserSessionImpl) then,
  ) = __$$UserSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String email,
    String firstName,
    String lastName,
    DateTime loginTime,
    DateTime lastActivity,
    bool isActive,
    Map<String, dynamic> preferences,
  });
}

/// @nodoc
class __$$UserSessionImplCopyWithImpl<$Res>
    extends _$UserSessionCopyWithImpl<$Res, _$UserSessionImpl>
    implements _$$UserSessionImplCopyWith<$Res> {
  __$$UserSessionImplCopyWithImpl(
    _$UserSessionImpl _value,
    $Res Function(_$UserSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? loginTime = null,
    Object? lastActivity = null,
    Object? isActive = null,
    Object? preferences = null,
  }) {
    return _then(
      _$UserSessionImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        loginTime: null == loginTime
            ? _value.loginTime
            : loginTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastActivity: null == lastActivity
            ? _value.lastActivity
            : lastActivity // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        preferences: null == preferences
            ? _value._preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSessionImpl implements _UserSession {
  const _$UserSessionImpl({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.loginTime,
    required this.lastActivity,
    this.isActive = false,
    final Map<String, dynamic> preferences = const {},
  }) : _preferences = preferences;

  factory _$UserSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSessionImplFromJson(json);

  @override
  final String userId;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime loginTime;
  @override
  final DateTime lastActivity;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic> _preferences;
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  String toString() {
    return 'UserSession(userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, loginTime: $loginTime, lastActivity: $lastActivity, isActive: $isActive, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSessionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.loginTime, loginTime) ||
                other.loginTime == loginTime) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    email,
    firstName,
    lastName,
    loginTime,
    lastActivity,
    isActive,
    const DeepCollectionEquality().hash(_preferences),
  );

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSessionImplCopyWith<_$UserSessionImpl> get copyWith =>
      __$$UserSessionImplCopyWithImpl<_$UserSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSessionImplToJson(this);
  }
}

abstract class _UserSession implements UserSession {
  const factory _UserSession({
    required final String userId,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final DateTime loginTime,
    required final DateTime lastActivity,
    final bool isActive,
    final Map<String, dynamic> preferences,
  }) = _$UserSessionImpl;

  factory _UserSession.fromJson(Map<String, dynamic> json) =
      _$UserSessionImpl.fromJson;

  @override
  String get userId;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get loginTime;
  @override
  DateTime get lastActivity;
  @override
  bool get isActive;
  @override
  Map<String, dynamic> get preferences;

  /// Create a copy of UserSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSessionImplCopyWith<_$UserSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return _AuthState.fromJson(json);
}

/// @nodoc
mixin _$AuthState {
  bool get isAuthenticated => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isInitialized => throw _privateConstructorUsedError;
  UserSession? get userSession => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastRefresh => throw _privateConstructorUsedError;
  bool get otpSent => throw _privateConstructorUsedError;
  String? get otpContact => throw _privateConstructorUsedError;
  bool get otpVerified => throw _privateConstructorUsedError;
  bool get signupCompleted => throw _privateConstructorUsedError;

  /// Serializes this AuthState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    bool isAuthenticated,
    bool isLoading,
    bool isInitialized,
    UserSession? userSession,
    String? error,
    DateTime? lastRefresh,
    bool otpSent,
    String? otpContact,
    bool otpVerified,
    bool signupCompleted,
  });

  $UserSessionCopyWith<$Res>? get userSession;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? userSession = freezed,
    Object? error = freezed,
    Object? lastRefresh = freezed,
    Object? otpSent = null,
    Object? otpContact = freezed,
    Object? otpVerified = null,
    Object? signupCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            isAuthenticated: null == isAuthenticated
                ? _value.isAuthenticated
                : isAuthenticated // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            userSession: freezed == userSession
                ? _value.userSession
                : userSession // ignore: cast_nullable_to_non_nullable
                      as UserSession?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastRefresh: freezed == lastRefresh
                ? _value.lastRefresh
                : lastRefresh // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            otpSent: null == otpSent
                ? _value.otpSent
                : otpSent // ignore: cast_nullable_to_non_nullable
                      as bool,
            otpContact: freezed == otpContact
                ? _value.otpContact
                : otpContact // ignore: cast_nullable_to_non_nullable
                      as String?,
            otpVerified: null == otpVerified
                ? _value.otpVerified
                : otpVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            signupCompleted: null == signupCompleted
                ? _value.signupCompleted
                : signupCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSessionCopyWith<$Res>? get userSession {
    if (_value.userSession == null) {
      return null;
    }

    return $UserSessionCopyWith<$Res>(_value.userSession!, (value) {
      return _then(_value.copyWith(userSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isAuthenticated,
    bool isLoading,
    bool isInitialized,
    UserSession? userSession,
    String? error,
    DateTime? lastRefresh,
    bool otpSent,
    String? otpContact,
    bool otpVerified,
    bool signupCompleted,
  });

  @override
  $UserSessionCopyWith<$Res>? get userSession;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAuthenticated = null,
    Object? isLoading = null,
    Object? isInitialized = null,
    Object? userSession = freezed,
    Object? error = freezed,
    Object? lastRefresh = freezed,
    Object? otpSent = null,
    Object? otpContact = freezed,
    Object? otpVerified = null,
    Object? signupCompleted = null,
  }) {
    return _then(
      _$AuthStateImpl(
        isAuthenticated: null == isAuthenticated
            ? _value.isAuthenticated
            : isAuthenticated // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        userSession: freezed == userSession
            ? _value.userSession
            : userSession // ignore: cast_nullable_to_non_nullable
                  as UserSession?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastRefresh: freezed == lastRefresh
            ? _value.lastRefresh
            : lastRefresh // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        otpSent: null == otpSent
            ? _value.otpSent
            : otpSent // ignore: cast_nullable_to_non_nullable
                  as bool,
        otpContact: freezed == otpContact
            ? _value.otpContact
            : otpContact // ignore: cast_nullable_to_non_nullable
                  as String?,
        otpVerified: null == otpVerified
            ? _value.otpVerified
            : otpVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        signupCompleted: null == signupCompleted
            ? _value.signupCompleted
            : signupCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.isInitialized = false,
    this.userSession,
    this.error,
    this.lastRefresh,
    this.otpSent = false,
    this.otpContact,
    this.otpVerified = false,
    this.signupCompleted = false,
  });

  factory _$AuthStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isAuthenticated;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isInitialized;
  @override
  final UserSession? userSession;
  @override
  final String? error;
  @override
  final DateTime? lastRefresh;
  @override
  @JsonKey()
  final bool otpSent;
  @override
  final String? otpContact;
  @override
  @JsonKey()
  final bool otpVerified;
  @override
  @JsonKey()
  final bool signupCompleted;

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, isLoading: $isLoading, isInitialized: $isInitialized, userSession: $userSession, error: $error, lastRefresh: $lastRefresh, otpSent: $otpSent, otpContact: $otpContact, otpVerified: $otpVerified, signupCompleted: $signupCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.userSession, userSession) ||
                other.userSession == userSession) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastRefresh, lastRefresh) ||
                other.lastRefresh == lastRefresh) &&
            (identical(other.otpSent, otpSent) || other.otpSent == otpSent) &&
            (identical(other.otpContact, otpContact) ||
                other.otpContact == otpContact) &&
            (identical(other.otpVerified, otpVerified) ||
                other.otpVerified == otpVerified) &&
            (identical(other.signupCompleted, signupCompleted) ||
                other.signupCompleted == signupCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isAuthenticated,
    isLoading,
    isInitialized,
    userSession,
    error,
    lastRefresh,
    otpSent,
    otpContact,
    otpVerified,
    signupCompleted,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthStateImplToJson(this);
  }
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final bool isAuthenticated,
    final bool isLoading,
    final bool isInitialized,
    final UserSession? userSession,
    final String? error,
    final DateTime? lastRefresh,
    final bool otpSent,
    final String? otpContact,
    final bool otpVerified,
    final bool signupCompleted,
  }) = _$AuthStateImpl;

  factory _AuthState.fromJson(Map<String, dynamic> json) =
      _$AuthStateImpl.fromJson;

  @override
  bool get isAuthenticated;
  @override
  bool get isLoading;
  @override
  bool get isInitialized;
  @override
  UserSession? get userSession;
  @override
  String? get error;
  @override
  DateTime? get lastRefresh;
  @override
  bool get otpSent;
  @override
  String? get otpContact;
  @override
  bool get otpVerified;
  @override
  bool get signupCompleted;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenRefreshRequest _$TokenRefreshRequestFromJson(Map<String, dynamic> json) {
  return _TokenRefreshRequest.fromJson(json);
}

/// @nodoc
mixin _$TokenRefreshRequest {
  String get refreshToken => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Serializes this TokenRefreshRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenRefreshRequestCopyWith<TokenRefreshRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenRefreshRequestCopyWith<$Res> {
  factory $TokenRefreshRequestCopyWith(
    TokenRefreshRequest value,
    $Res Function(TokenRefreshRequest) then,
  ) = _$TokenRefreshRequestCopyWithImpl<$Res, TokenRefreshRequest>;
  @useResult
  $Res call({String refreshToken, String userId});
}

/// @nodoc
class _$TokenRefreshRequestCopyWithImpl<$Res, $Val extends TokenRefreshRequest>
    implements $TokenRefreshRequestCopyWith<$Res> {
  _$TokenRefreshRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null, Object? userId = null}) {
    return _then(
      _value.copyWith(
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenRefreshRequestImplCopyWith<$Res>
    implements $TokenRefreshRequestCopyWith<$Res> {
  factory _$$TokenRefreshRequestImplCopyWith(
    _$TokenRefreshRequestImpl value,
    $Res Function(_$TokenRefreshRequestImpl) then,
  ) = __$$TokenRefreshRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refreshToken, String userId});
}

/// @nodoc
class __$$TokenRefreshRequestImplCopyWithImpl<$Res>
    extends _$TokenRefreshRequestCopyWithImpl<$Res, _$TokenRefreshRequestImpl>
    implements _$$TokenRefreshRequestImplCopyWith<$Res> {
  __$$TokenRefreshRequestImplCopyWithImpl(
    _$TokenRefreshRequestImpl _value,
    $Res Function(_$TokenRefreshRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null, Object? userId = null}) {
    return _then(
      _$TokenRefreshRequestImpl(
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenRefreshRequestImpl implements _TokenRefreshRequest {
  const _$TokenRefreshRequestImpl({
    required this.refreshToken,
    required this.userId,
  });

  factory _$TokenRefreshRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenRefreshRequestImplFromJson(json);

  @override
  final String refreshToken;
  @override
  final String userId;

  @override
  String toString() {
    return 'TokenRefreshRequest(refreshToken: $refreshToken, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenRefreshRequestImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshToken, userId);

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenRefreshRequestImplCopyWith<_$TokenRefreshRequestImpl> get copyWith =>
      __$$TokenRefreshRequestImplCopyWithImpl<_$TokenRefreshRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenRefreshRequestImplToJson(this);
  }
}

abstract class _TokenRefreshRequest implements TokenRefreshRequest {
  const factory _TokenRefreshRequest({
    required final String refreshToken,
    required final String userId,
  }) = _$TokenRefreshRequestImpl;

  factory _TokenRefreshRequest.fromJson(Map<String, dynamic> json) =
      _$TokenRefreshRequestImpl.fromJson;

  @override
  String get refreshToken;
  @override
  String get userId;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenRefreshRequestImplCopyWith<_$TokenRefreshRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenRefreshResponse _$TokenRefreshResponseFromJson(Map<String, dynamic> json) {
  return _TokenRefreshResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenRefreshResponse {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this TokenRefreshResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenRefreshResponseCopyWith<TokenRefreshResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenRefreshResponseCopyWith<$Res> {
  factory $TokenRefreshResponseCopyWith(
    TokenRefreshResponse value,
    $Res Function(TokenRefreshResponse) then,
  ) = _$TokenRefreshResponseCopyWithImpl<$Res, TokenRefreshResponse>;
  @useResult
  $Res call({String accessToken, String refreshToken, DateTime expiresAt});
}

/// @nodoc
class _$TokenRefreshResponseCopyWithImpl<
  $Res,
  $Val extends TokenRefreshResponse
>
    implements $TokenRefreshResponseCopyWith<$Res> {
  _$TokenRefreshResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenRefreshResponseImplCopyWith<$Res>
    implements $TokenRefreshResponseCopyWith<$Res> {
  factory _$$TokenRefreshResponseImplCopyWith(
    _$TokenRefreshResponseImpl value,
    $Res Function(_$TokenRefreshResponseImpl) then,
  ) = __$$TokenRefreshResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken, DateTime expiresAt});
}

/// @nodoc
class __$$TokenRefreshResponseImplCopyWithImpl<$Res>
    extends _$TokenRefreshResponseCopyWithImpl<$Res, _$TokenRefreshResponseImpl>
    implements _$$TokenRefreshResponseImplCopyWith<$Res> {
  __$$TokenRefreshResponseImplCopyWithImpl(
    _$TokenRefreshResponseImpl _value,
    $Res Function(_$TokenRefreshResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(
      _$TokenRefreshResponseImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenRefreshResponseImpl implements _TokenRefreshResponse {
  const _$TokenRefreshResponseImpl({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory _$TokenRefreshResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenRefreshResponseImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final DateTime expiresAt;

  @override
  String toString() {
    return 'TokenRefreshResponse(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenRefreshResponseImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresAt);

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenRefreshResponseImplCopyWith<_$TokenRefreshResponseImpl>
  get copyWith =>
      __$$TokenRefreshResponseImplCopyWithImpl<_$TokenRefreshResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenRefreshResponseImplToJson(this);
  }
}

abstract class _TokenRefreshResponse implements TokenRefreshResponse {
  const factory _TokenRefreshResponse({
    required final String accessToken,
    required final String refreshToken,
    required final DateTime expiresAt,
  }) = _$TokenRefreshResponseImpl;

  factory _TokenRefreshResponse.fromJson(Map<String, dynamic> json) =
      _$TokenRefreshResponseImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  DateTime get expiresAt;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenRefreshResponseImplCopyWith<_$TokenRefreshResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) {
  return _LogoutRequest.fromJson(json);
}

/// @nodoc
mixin _$LogoutRequest {
  String get userId => throw _privateConstructorUsedError;
  bool get logoutAllDevices => throw _privateConstructorUsedError;

  /// Serializes this LogoutRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogoutRequestCopyWith<LogoutRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogoutRequestCopyWith<$Res> {
  factory $LogoutRequestCopyWith(
    LogoutRequest value,
    $Res Function(LogoutRequest) then,
  ) = _$LogoutRequestCopyWithImpl<$Res, LogoutRequest>;
  @useResult
  $Res call({String userId, bool logoutAllDevices});
}

/// @nodoc
class _$LogoutRequestCopyWithImpl<$Res, $Val extends LogoutRequest>
    implements $LogoutRequestCopyWith<$Res> {
  _$LogoutRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? logoutAllDevices = null}) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            logoutAllDevices: null == logoutAllDevices
                ? _value.logoutAllDevices
                : logoutAllDevices // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LogoutRequestImplCopyWith<$Res>
    implements $LogoutRequestCopyWith<$Res> {
  factory _$$LogoutRequestImplCopyWith(
    _$LogoutRequestImpl value,
    $Res Function(_$LogoutRequestImpl) then,
  ) = __$$LogoutRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, bool logoutAllDevices});
}

/// @nodoc
class __$$LogoutRequestImplCopyWithImpl<$Res>
    extends _$LogoutRequestCopyWithImpl<$Res, _$LogoutRequestImpl>
    implements _$$LogoutRequestImplCopyWith<$Res> {
  __$$LogoutRequestImplCopyWithImpl(
    _$LogoutRequestImpl _value,
    $Res Function(_$LogoutRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LogoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? logoutAllDevices = null}) {
    return _then(
      _$LogoutRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        logoutAllDevices: null == logoutAllDevices
            ? _value.logoutAllDevices
            : logoutAllDevices // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LogoutRequestImpl implements _LogoutRequest {
  const _$LogoutRequestImpl({
    required this.userId,
    this.logoutAllDevices = false,
  });

  factory _$LogoutRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogoutRequestImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final bool logoutAllDevices;

  @override
  String toString() {
    return 'LogoutRequest(userId: $userId, logoutAllDevices: $logoutAllDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.logoutAllDevices, logoutAllDevices) ||
                other.logoutAllDevices == logoutAllDevices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, logoutAllDevices);

  /// Create a copy of LogoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutRequestImplCopyWith<_$LogoutRequestImpl> get copyWith =>
      __$$LogoutRequestImplCopyWithImpl<_$LogoutRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogoutRequestImplToJson(this);
  }
}

abstract class _LogoutRequest implements LogoutRequest {
  const factory _LogoutRequest({
    required final String userId,
    final bool logoutAllDevices,
  }) = _$LogoutRequestImpl;

  factory _LogoutRequest.fromJson(Map<String, dynamic> json) =
      _$LogoutRequestImpl.fromJson;

  @override
  String get userId;
  @override
  bool get logoutAllDevices;

  /// Create a copy of LogoutRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogoutRequestImplCopyWith<_$LogoutRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PasswordChangeRequest _$PasswordChangeRequestFromJson(
  Map<String, dynamic> json,
) {
  return _PasswordChangeRequest.fromJson(json);
}

/// @nodoc
mixin _$PasswordChangeRequest {
  String get currentPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;

  /// Serializes this PasswordChangeRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PasswordChangeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PasswordChangeRequestCopyWith<PasswordChangeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordChangeRequestCopyWith<$Res> {
  factory $PasswordChangeRequestCopyWith(
    PasswordChangeRequest value,
    $Res Function(PasswordChangeRequest) then,
  ) = _$PasswordChangeRequestCopyWithImpl<$Res, PasswordChangeRequest>;
  @useResult
  $Res call({
    String currentPassword,
    String newPassword,
    String confirmPassword,
  });
}

/// @nodoc
class _$PasswordChangeRequestCopyWithImpl<
  $Res,
  $Val extends PasswordChangeRequest
>
    implements $PasswordChangeRequestCopyWith<$Res> {
  _$PasswordChangeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PasswordChangeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
  }) {
    return _then(
      _value.copyWith(
            currentPassword: null == currentPassword
                ? _value.currentPassword
                : currentPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            confirmPassword: null == confirmPassword
                ? _value.confirmPassword
                : confirmPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PasswordChangeRequestImplCopyWith<$Res>
    implements $PasswordChangeRequestCopyWith<$Res> {
  factory _$$PasswordChangeRequestImplCopyWith(
    _$PasswordChangeRequestImpl value,
    $Res Function(_$PasswordChangeRequestImpl) then,
  ) = __$$PasswordChangeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String currentPassword,
    String newPassword,
    String confirmPassword,
  });
}

/// @nodoc
class __$$PasswordChangeRequestImplCopyWithImpl<$Res>
    extends
        _$PasswordChangeRequestCopyWithImpl<$Res, _$PasswordChangeRequestImpl>
    implements _$$PasswordChangeRequestImplCopyWith<$Res> {
  __$$PasswordChangeRequestImplCopyWithImpl(
    _$PasswordChangeRequestImpl _value,
    $Res Function(_$PasswordChangeRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PasswordChangeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
  }) {
    return _then(
      _$PasswordChangeRequestImpl(
        currentPassword: null == currentPassword
            ? _value.currentPassword
            : currentPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmPassword: null == confirmPassword
            ? _value.confirmPassword
            : confirmPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PasswordChangeRequestImpl implements _PasswordChangeRequest {
  const _$PasswordChangeRequestImpl({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory _$PasswordChangeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasswordChangeRequestImplFromJson(json);

  @override
  final String currentPassword;
  @override
  final String newPassword;
  @override
  final String confirmPassword;

  @override
  String toString() {
    return 'PasswordChangeRequest(currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordChangeRequestImpl &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPassword, newPassword, confirmPassword);

  /// Create a copy of PasswordChangeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordChangeRequestImplCopyWith<_$PasswordChangeRequestImpl>
  get copyWith =>
      __$$PasswordChangeRequestImplCopyWithImpl<_$PasswordChangeRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PasswordChangeRequestImplToJson(this);
  }
}

abstract class _PasswordChangeRequest implements PasswordChangeRequest {
  const factory _PasswordChangeRequest({
    required final String currentPassword,
    required final String newPassword,
    required final String confirmPassword,
  }) = _$PasswordChangeRequestImpl;

  factory _PasswordChangeRequest.fromJson(Map<String, dynamic> json) =
      _$PasswordChangeRequestImpl.fromJson;

  @override
  String get currentPassword;
  @override
  String get newPassword;
  @override
  String get confirmPassword;

  /// Create a copy of PasswordChangeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordChangeRequestImplCopyWith<_$PasswordChangeRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AuthValidationResult _$AuthValidationResultFromJson(Map<String, dynamic> json) {
  return _AuthValidationResult.fromJson(json);
}

/// @nodoc
mixin _$AuthValidationResult {
  bool get isValid => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  Map<String, String> get fieldErrors => throw _privateConstructorUsedError;

  /// Serializes this AuthValidationResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthValidationResultCopyWith<AuthValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthValidationResultCopyWith<$Res> {
  factory $AuthValidationResultCopyWith(
    AuthValidationResult value,
    $Res Function(AuthValidationResult) then,
  ) = _$AuthValidationResultCopyWithImpl<$Res, AuthValidationResult>;
  @useResult
  $Res call({
    bool isValid,
    List<String> errors,
    Map<String, String> fieldErrors,
  });
}

/// @nodoc
class _$AuthValidationResultCopyWithImpl<
  $Res,
  $Val extends AuthValidationResult
>
    implements $AuthValidationResultCopyWith<$Res> {
  _$AuthValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? errors = null,
    Object? fieldErrors = null,
  }) {
    return _then(
      _value.copyWith(
            isValid: null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            fieldErrors: null == fieldErrors
                ? _value.fieldErrors
                : fieldErrors // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthValidationResultImplCopyWith<$Res>
    implements $AuthValidationResultCopyWith<$Res> {
  factory _$$AuthValidationResultImplCopyWith(
    _$AuthValidationResultImpl value,
    $Res Function(_$AuthValidationResultImpl) then,
  ) = __$$AuthValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isValid,
    List<String> errors,
    Map<String, String> fieldErrors,
  });
}

/// @nodoc
class __$$AuthValidationResultImplCopyWithImpl<$Res>
    extends _$AuthValidationResultCopyWithImpl<$Res, _$AuthValidationResultImpl>
    implements _$$AuthValidationResultImplCopyWith<$Res> {
  __$$AuthValidationResultImplCopyWithImpl(
    _$AuthValidationResultImpl _value,
    $Res Function(_$AuthValidationResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? errors = null,
    Object? fieldErrors = null,
  }) {
    return _then(
      _$AuthValidationResultImpl(
        isValid: null == isValid
            ? _value.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        fieldErrors: null == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthValidationResultImpl implements _AuthValidationResult {
  const _$AuthValidationResultImpl({
    this.isValid = true,
    final List<String> errors = const [],
    final Map<String, String> fieldErrors = const {},
  }) : _errors = errors,
       _fieldErrors = fieldErrors;

  factory _$AuthValidationResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthValidationResultImplFromJson(json);

  @override
  @JsonKey()
  final bool isValid;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  final Map<String, String> _fieldErrors;
  @override
  @JsonKey()
  Map<String, String> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldErrors);
  }

  @override
  String toString() {
    return 'AuthValidationResult(isValid: $isValid, errors: $errors, fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthValidationResultImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isValid,
    const DeepCollectionEquality().hash(_errors),
    const DeepCollectionEquality().hash(_fieldErrors),
  );

  /// Create a copy of AuthValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthValidationResultImplCopyWith<_$AuthValidationResultImpl>
  get copyWith =>
      __$$AuthValidationResultImplCopyWithImpl<_$AuthValidationResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthValidationResultImplToJson(this);
  }
}

abstract class _AuthValidationResult implements AuthValidationResult {
  const factory _AuthValidationResult({
    final bool isValid,
    final List<String> errors,
    final Map<String, String> fieldErrors,
  }) = _$AuthValidationResultImpl;

  factory _AuthValidationResult.fromJson(Map<String, dynamic> json) =
      _$AuthValidationResultImpl.fromJson;

  @override
  bool get isValid;
  @override
  List<String> get errors;
  @override
  Map<String, String> get fieldErrors;

  /// Create a copy of AuthValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthValidationResultImplCopyWith<_$AuthValidationResultImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OtpSendRequest _$OtpSendRequestFromJson(Map<String, dynamic> json) {
  return _OtpSendRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpSendRequest {
  String get contact => throw _privateConstructorUsedError;

  /// Serializes this OtpSendRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpSendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpSendRequestCopyWith<OtpSendRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpSendRequestCopyWith<$Res> {
  factory $OtpSendRequestCopyWith(
    OtpSendRequest value,
    $Res Function(OtpSendRequest) then,
  ) = _$OtpSendRequestCopyWithImpl<$Res, OtpSendRequest>;
  @useResult
  $Res call({String contact});
}

/// @nodoc
class _$OtpSendRequestCopyWithImpl<$Res, $Val extends OtpSendRequest>
    implements $OtpSendRequestCopyWith<$Res> {
  _$OtpSendRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpSendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null}) {
    return _then(
      _value.copyWith(
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpSendRequestImplCopyWith<$Res>
    implements $OtpSendRequestCopyWith<$Res> {
  factory _$$OtpSendRequestImplCopyWith(
    _$OtpSendRequestImpl value,
    $Res Function(_$OtpSendRequestImpl) then,
  ) = __$$OtpSendRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contact});
}

/// @nodoc
class __$$OtpSendRequestImplCopyWithImpl<$Res>
    extends _$OtpSendRequestCopyWithImpl<$Res, _$OtpSendRequestImpl>
    implements _$$OtpSendRequestImplCopyWith<$Res> {
  __$$OtpSendRequestImplCopyWithImpl(
    _$OtpSendRequestImpl _value,
    $Res Function(_$OtpSendRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpSendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null}) {
    return _then(
      _$OtpSendRequestImpl(
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpSendRequestImpl implements _OtpSendRequest {
  const _$OtpSendRequestImpl({required this.contact});

  factory _$OtpSendRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpSendRequestImplFromJson(json);

  @override
  final String contact;

  @override
  String toString() {
    return 'OtpSendRequest(contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpSendRequestImpl &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact);

  /// Create a copy of OtpSendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpSendRequestImplCopyWith<_$OtpSendRequestImpl> get copyWith =>
      __$$OtpSendRequestImplCopyWithImpl<_$OtpSendRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpSendRequestImplToJson(this);
  }
}

abstract class _OtpSendRequest implements OtpSendRequest {
  const factory _OtpSendRequest({required final String contact}) =
      _$OtpSendRequestImpl;

  factory _OtpSendRequest.fromJson(Map<String, dynamic> json) =
      _$OtpSendRequestImpl.fromJson;

  @override
  String get contact;

  /// Create a copy of OtpSendRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpSendRequestImplCopyWith<_$OtpSendRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpVerifyRequest _$OtpVerifyRequestFromJson(Map<String, dynamic> json) {
  return _OtpVerifyRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpVerifyRequest {
  String get contact => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  /// Serializes this OtpVerifyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerifyRequestCopyWith<OtpVerifyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerifyRequestCopyWith<$Res> {
  factory $OtpVerifyRequestCopyWith(
    OtpVerifyRequest value,
    $Res Function(OtpVerifyRequest) then,
  ) = _$OtpVerifyRequestCopyWithImpl<$Res, OtpVerifyRequest>;
  @useResult
  $Res call({String contact, String otp});
}

/// @nodoc
class _$OtpVerifyRequestCopyWithImpl<$Res, $Val extends OtpVerifyRequest>
    implements $OtpVerifyRequestCopyWith<$Res> {
  _$OtpVerifyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null, Object? otp = null}) {
    return _then(
      _value.copyWith(
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
            otp: null == otp
                ? _value.otp
                : otp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpVerifyRequestImplCopyWith<$Res>
    implements $OtpVerifyRequestCopyWith<$Res> {
  factory _$$OtpVerifyRequestImplCopyWith(
    _$OtpVerifyRequestImpl value,
    $Res Function(_$OtpVerifyRequestImpl) then,
  ) = __$$OtpVerifyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contact, String otp});
}

/// @nodoc
class __$$OtpVerifyRequestImplCopyWithImpl<$Res>
    extends _$OtpVerifyRequestCopyWithImpl<$Res, _$OtpVerifyRequestImpl>
    implements _$$OtpVerifyRequestImplCopyWith<$Res> {
  __$$OtpVerifyRequestImplCopyWithImpl(
    _$OtpVerifyRequestImpl _value,
    $Res Function(_$OtpVerifyRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? contact = null, Object? otp = null}) {
    return _then(
      _$OtpVerifyRequestImpl(
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerifyRequestImpl implements _OtpVerifyRequest {
  const _$OtpVerifyRequestImpl({required this.contact, required this.otp});

  factory _$OtpVerifyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerifyRequestImplFromJson(json);

  @override
  final String contact;
  @override
  final String otp;

  @override
  String toString() {
    return 'OtpVerifyRequest(contact: $contact, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerifyRequestImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact, otp);

  /// Create a copy of OtpVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerifyRequestImplCopyWith<_$OtpVerifyRequestImpl> get copyWith =>
      __$$OtpVerifyRequestImplCopyWithImpl<_$OtpVerifyRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerifyRequestImplToJson(this);
  }
}

abstract class _OtpVerifyRequest implements OtpVerifyRequest {
  const factory _OtpVerifyRequest({
    required final String contact,
    required final String otp,
  }) = _$OtpVerifyRequestImpl;

  factory _OtpVerifyRequest.fromJson(Map<String, dynamic> json) =
      _$OtpVerifyRequestImpl.fromJson;

  @override
  String get contact;
  @override
  String get otp;

  /// Create a copy of OtpVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerifyRequestImplCopyWith<_$OtpVerifyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return _SignUpRequest.fromJson(json);
}

/// @nodoc
mixin _$SignUpRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get contact => throw _privateConstructorUsedError;

  /// Serializes this SignUpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpRequestCopyWith<SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpRequestCopyWith<$Res> {
  factory $SignUpRequestCopyWith(
    SignUpRequest value,
    $Res Function(SignUpRequest) then,
  ) = _$SignUpRequestCopyWithImpl<$Res, SignUpRequest>;
  @useResult
  $Res call({String email, String password, String contact});
}

/// @nodoc
class _$SignUpRequestCopyWithImpl<$Res, $Val extends SignUpRequest>
    implements $SignUpRequestCopyWith<$Res> {
  _$SignUpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? contact = null,
  }) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            contact: null == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignUpRequestImplCopyWith<$Res>
    implements $SignUpRequestCopyWith<$Res> {
  factory _$$SignUpRequestImplCopyWith(
    _$SignUpRequestImpl value,
    $Res Function(_$SignUpRequestImpl) then,
  ) = __$$SignUpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, String contact});
}

/// @nodoc
class __$$SignUpRequestImplCopyWithImpl<$Res>
    extends _$SignUpRequestCopyWithImpl<$Res, _$SignUpRequestImpl>
    implements _$$SignUpRequestImplCopyWith<$Res> {
  __$$SignUpRequestImplCopyWithImpl(
    _$SignUpRequestImpl _value,
    $Res Function(_$SignUpRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? contact = null,
  }) {
    return _then(
      _$SignUpRequestImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        contact: null == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpRequestImpl implements _SignUpRequest {
  const _$SignUpRequestImpl({
    required this.email,
    required this.password,
    required this.contact,
  });

  factory _$SignUpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String contact;

  @override
  String toString() {
    return 'SignUpRequest(email: $email, password: $password, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password, contact);

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpRequestImplCopyWith<_$SignUpRequestImpl> get copyWith =>
      __$$SignUpRequestImplCopyWithImpl<_$SignUpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpRequestImplToJson(this);
  }
}

abstract class _SignUpRequest implements SignUpRequest {
  const factory _SignUpRequest({
    required final String email,
    required final String password,
    required final String contact,
  }) = _$SignUpRequestImpl;

  factory _SignUpRequest.fromJson(Map<String, dynamic> json) =
      _$SignUpRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get contact;

  /// Create a copy of SignUpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpRequestImplCopyWith<_$SignUpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
