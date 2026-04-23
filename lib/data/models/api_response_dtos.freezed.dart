// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BaseApiResponseDto _$BaseApiResponseDtoFromJson(Map<String, dynamic> json) {
  return _BaseApiResponseDto.fromJson(json);
}

/// @nodoc
mixin _$BaseApiResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BaseApiResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaseApiResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseApiResponseDtoCopyWith<BaseApiResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseApiResponseDtoCopyWith<$Res> {
  factory $BaseApiResponseDtoCopyWith(
    BaseApiResponseDto value,
    $Res Function(BaseApiResponseDto) then,
  ) = _$BaseApiResponseDtoCopyWithImpl<$Res, BaseApiResponseDto>;
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class _$BaseApiResponseDtoCopyWithImpl<$Res, $Val extends BaseApiResponseDto>
    implements $BaseApiResponseDtoCopyWith<$Res> {
  _$BaseApiResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseApiResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BaseApiResponseDtoImplCopyWith<$Res>
    implements $BaseApiResponseDtoCopyWith<$Res> {
  factory _$$BaseApiResponseDtoImplCopyWith(
    _$BaseApiResponseDtoImpl value,
    $Res Function(_$BaseApiResponseDtoImpl) then,
  ) = __$$BaseApiResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class __$$BaseApiResponseDtoImplCopyWithImpl<$Res>
    extends _$BaseApiResponseDtoCopyWithImpl<$Res, _$BaseApiResponseDtoImpl>
    implements _$$BaseApiResponseDtoImplCopyWith<$Res> {
  __$$BaseApiResponseDtoImplCopyWithImpl(
    _$BaseApiResponseDtoImpl _value,
    $Res Function(_$BaseApiResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BaseApiResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _$BaseApiResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseApiResponseDtoImpl implements _BaseApiResponseDto {
  const _$BaseApiResponseDtoImpl({required this.status, this.message});

  factory _$BaseApiResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseApiResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;

  @override
  String toString() {
    return 'BaseApiResponseDto(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseApiResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of BaseApiResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseApiResponseDtoImplCopyWith<_$BaseApiResponseDtoImpl> get copyWith =>
      __$$BaseApiResponseDtoImplCopyWithImpl<_$BaseApiResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseApiResponseDtoImplToJson(this);
  }
}

abstract class _BaseApiResponseDto implements BaseApiResponseDto {
  const factory _BaseApiResponseDto({
    required final int status,
    final String? message,
  }) = _$BaseApiResponseDtoImpl;

  factory _BaseApiResponseDto.fromJson(Map<String, dynamic> json) =
      _$BaseApiResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;

  /// Create a copy of BaseApiResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseApiResponseDtoImplCopyWith<_$BaseApiResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return _UserDto.fromJson(json);
}

/// @nodoc
mixin _$UserDto {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  bool get sessionExpired => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  bool get guest => throw _privateConstructorUsedError;
  bool get identified => throw _privateConstructorUsedError;
  bool get connected => throw _privateConstructorUsedError;
  bool get secured => throw _privateConstructorUsedError;
  int get maxPinnedAccounts => throw _privateConstructorUsedError;
  bool get loggedIn => throw _privateConstructorUsedError;
  bool get requiresUpdate => throw _privateConstructorUsedError;
  String? get preferredAccounts => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;
  int get announcements => throw _privateConstructorUsedError;
  int get bills => throw _privateConstructorUsedError;
  int get powerUpdates => throw _privateConstructorUsedError;
  int get payments => throw _privateConstructorUsedError;
  int get paymentOffers => throw _privateConstructorUsedError;
  int get affectedAccounts => throw _privateConstructorUsedError;
  String? get updateRequiredMessage => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool get tester => throw _privateConstructorUsedError;

  /// Serializes this UserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDtoCopyWith<UserDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDtoCopyWith<$Res> {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) then) =
      _$UserDtoCopyWithImpl<$Res, UserDto>;
  @useResult
  $Res call({
    String id,
    String username,
    bool sessionExpired,
    String token,
    bool guest,
    bool identified,
    bool connected,
    bool secured,
    int maxPinnedAccounts,
    bool loggedIn,
    bool requiresUpdate,
    String? preferredAccounts,
    String? customerName,
    int announcements,
    int bills,
    int powerUpdates,
    int payments,
    int paymentOffers,
    int affectedAccounts,
    String? updateRequiredMessage,
    String? email,
    bool tester,
  });
}

/// @nodoc
class _$UserDtoCopyWithImpl<$Res, $Val extends UserDto>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? sessionExpired = null,
    Object? token = null,
    Object? guest = null,
    Object? identified = null,
    Object? connected = null,
    Object? secured = null,
    Object? maxPinnedAccounts = null,
    Object? loggedIn = null,
    Object? requiresUpdate = null,
    Object? preferredAccounts = freezed,
    Object? customerName = freezed,
    Object? announcements = null,
    Object? bills = null,
    Object? powerUpdates = null,
    Object? payments = null,
    Object? paymentOffers = null,
    Object? affectedAccounts = null,
    Object? updateRequiredMessage = freezed,
    Object? email = freezed,
    Object? tester = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionExpired: null == sessionExpired
                ? _value.sessionExpired
                : sessionExpired // ignore: cast_nullable_to_non_nullable
                      as bool,
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            guest: null == guest
                ? _value.guest
                : guest // ignore: cast_nullable_to_non_nullable
                      as bool,
            identified: null == identified
                ? _value.identified
                : identified // ignore: cast_nullable_to_non_nullable
                      as bool,
            connected: null == connected
                ? _value.connected
                : connected // ignore: cast_nullable_to_non_nullable
                      as bool,
            secured: null == secured
                ? _value.secured
                : secured // ignore: cast_nullable_to_non_nullable
                      as bool,
            maxPinnedAccounts: null == maxPinnedAccounts
                ? _value.maxPinnedAccounts
                : maxPinnedAccounts // ignore: cast_nullable_to_non_nullable
                      as int,
            loggedIn: null == loggedIn
                ? _value.loggedIn
                : loggedIn // ignore: cast_nullable_to_non_nullable
                      as bool,
            requiresUpdate: null == requiresUpdate
                ? _value.requiresUpdate
                : requiresUpdate // ignore: cast_nullable_to_non_nullable
                      as bool,
            preferredAccounts: freezed == preferredAccounts
                ? _value.preferredAccounts
                : preferredAccounts // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerName: freezed == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            announcements: null == announcements
                ? _value.announcements
                : announcements // ignore: cast_nullable_to_non_nullable
                      as int,
            bills: null == bills
                ? _value.bills
                : bills // ignore: cast_nullable_to_non_nullable
                      as int,
            powerUpdates: null == powerUpdates
                ? _value.powerUpdates
                : powerUpdates // ignore: cast_nullable_to_non_nullable
                      as int,
            payments: null == payments
                ? _value.payments
                : payments // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentOffers: null == paymentOffers
                ? _value.paymentOffers
                : paymentOffers // ignore: cast_nullable_to_non_nullable
                      as int,
            affectedAccounts: null == affectedAccounts
                ? _value.affectedAccounts
                : affectedAccounts // ignore: cast_nullable_to_non_nullable
                      as int,
            updateRequiredMessage: freezed == updateRequiredMessage
                ? _value.updateRequiredMessage
                : updateRequiredMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            tester: null == tester
                ? _value.tester
                : tester // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserDtoImplCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$$UserDtoImplCopyWith(
    _$UserDtoImpl value,
    $Res Function(_$UserDtoImpl) then,
  ) = __$$UserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String username,
    bool sessionExpired,
    String token,
    bool guest,
    bool identified,
    bool connected,
    bool secured,
    int maxPinnedAccounts,
    bool loggedIn,
    bool requiresUpdate,
    String? preferredAccounts,
    String? customerName,
    int announcements,
    int bills,
    int powerUpdates,
    int payments,
    int paymentOffers,
    int affectedAccounts,
    String? updateRequiredMessage,
    String? email,
    bool tester,
  });
}

/// @nodoc
class __$$UserDtoImplCopyWithImpl<$Res>
    extends _$UserDtoCopyWithImpl<$Res, _$UserDtoImpl>
    implements _$$UserDtoImplCopyWith<$Res> {
  __$$UserDtoImplCopyWithImpl(
    _$UserDtoImpl _value,
    $Res Function(_$UserDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? sessionExpired = null,
    Object? token = null,
    Object? guest = null,
    Object? identified = null,
    Object? connected = null,
    Object? secured = null,
    Object? maxPinnedAccounts = null,
    Object? loggedIn = null,
    Object? requiresUpdate = null,
    Object? preferredAccounts = freezed,
    Object? customerName = freezed,
    Object? announcements = null,
    Object? bills = null,
    Object? powerUpdates = null,
    Object? payments = null,
    Object? paymentOffers = null,
    Object? affectedAccounts = null,
    Object? updateRequiredMessage = freezed,
    Object? email = freezed,
    Object? tester = null,
  }) {
    return _then(
      _$UserDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionExpired: null == sessionExpired
            ? _value.sessionExpired
            : sessionExpired // ignore: cast_nullable_to_non_nullable
                  as bool,
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        guest: null == guest
            ? _value.guest
            : guest // ignore: cast_nullable_to_non_nullable
                  as bool,
        identified: null == identified
            ? _value.identified
            : identified // ignore: cast_nullable_to_non_nullable
                  as bool,
        connected: null == connected
            ? _value.connected
            : connected // ignore: cast_nullable_to_non_nullable
                  as bool,
        secured: null == secured
            ? _value.secured
            : secured // ignore: cast_nullable_to_non_nullable
                  as bool,
        maxPinnedAccounts: null == maxPinnedAccounts
            ? _value.maxPinnedAccounts
            : maxPinnedAccounts // ignore: cast_nullable_to_non_nullable
                  as int,
        loggedIn: null == loggedIn
            ? _value.loggedIn
            : loggedIn // ignore: cast_nullable_to_non_nullable
                  as bool,
        requiresUpdate: null == requiresUpdate
            ? _value.requiresUpdate
            : requiresUpdate // ignore: cast_nullable_to_non_nullable
                  as bool,
        preferredAccounts: freezed == preferredAccounts
            ? _value.preferredAccounts
            : preferredAccounts // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerName: freezed == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        announcements: null == announcements
            ? _value.announcements
            : announcements // ignore: cast_nullable_to_non_nullable
                  as int,
        bills: null == bills
            ? _value.bills
            : bills // ignore: cast_nullable_to_non_nullable
                  as int,
        powerUpdates: null == powerUpdates
            ? _value.powerUpdates
            : powerUpdates // ignore: cast_nullable_to_non_nullable
                  as int,
        payments: null == payments
            ? _value.payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentOffers: null == paymentOffers
            ? _value.paymentOffers
            : paymentOffers // ignore: cast_nullable_to_non_nullable
                  as int,
        affectedAccounts: null == affectedAccounts
            ? _value.affectedAccounts
            : affectedAccounts // ignore: cast_nullable_to_non_nullable
                  as int,
        updateRequiredMessage: freezed == updateRequiredMessage
            ? _value.updateRequiredMessage
            : updateRequiredMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        tester: null == tester
            ? _value.tester
            : tester // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDtoImpl implements _UserDto {
  const _$UserDtoImpl({
    required this.id,
    required this.username,
    this.sessionExpired = false,
    required this.token,
    this.guest = false,
    this.identified = false,
    this.connected = false,
    this.secured = false,
    this.maxPinnedAccounts = 0,
    this.loggedIn = false,
    this.requiresUpdate = false,
    this.preferredAccounts,
    this.customerName,
    this.announcements = 0,
    this.bills = 0,
    this.powerUpdates = 0,
    this.payments = 0,
    this.paymentOffers = 0,
    this.affectedAccounts = 0,
    this.updateRequiredMessage,
    this.email,
    this.tester = false,
  });

  factory _$UserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  @JsonKey()
  final bool sessionExpired;
  @override
  final String token;
  @override
  @JsonKey()
  final bool guest;
  @override
  @JsonKey()
  final bool identified;
  @override
  @JsonKey()
  final bool connected;
  @override
  @JsonKey()
  final bool secured;
  @override
  @JsonKey()
  final int maxPinnedAccounts;
  @override
  @JsonKey()
  final bool loggedIn;
  @override
  @JsonKey()
  final bool requiresUpdate;
  @override
  final String? preferredAccounts;
  @override
  final String? customerName;
  @override
  @JsonKey()
  final int announcements;
  @override
  @JsonKey()
  final int bills;
  @override
  @JsonKey()
  final int powerUpdates;
  @override
  @JsonKey()
  final int payments;
  @override
  @JsonKey()
  final int paymentOffers;
  @override
  @JsonKey()
  final int affectedAccounts;
  @override
  final String? updateRequiredMessage;
  @override
  final String? email;
  @override
  @JsonKey()
  final bool tester;

  @override
  String toString() {
    return 'UserDto(id: $id, username: $username, sessionExpired: $sessionExpired, token: $token, guest: $guest, identified: $identified, connected: $connected, secured: $secured, maxPinnedAccounts: $maxPinnedAccounts, loggedIn: $loggedIn, requiresUpdate: $requiresUpdate, preferredAccounts: $preferredAccounts, customerName: $customerName, announcements: $announcements, bills: $bills, powerUpdates: $powerUpdates, payments: $payments, paymentOffers: $paymentOffers, affectedAccounts: $affectedAccounts, updateRequiredMessage: $updateRequiredMessage, email: $email, tester: $tester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.sessionExpired, sessionExpired) ||
                other.sessionExpired == sessionExpired) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.guest, guest) || other.guest == guest) &&
            (identical(other.identified, identified) ||
                other.identified == identified) &&
            (identical(other.connected, connected) ||
                other.connected == connected) &&
            (identical(other.secured, secured) || other.secured == secured) &&
            (identical(other.maxPinnedAccounts, maxPinnedAccounts) ||
                other.maxPinnedAccounts == maxPinnedAccounts) &&
            (identical(other.loggedIn, loggedIn) ||
                other.loggedIn == loggedIn) &&
            (identical(other.requiresUpdate, requiresUpdate) ||
                other.requiresUpdate == requiresUpdate) &&
            (identical(other.preferredAccounts, preferredAccounts) ||
                other.preferredAccounts == preferredAccounts) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.announcements, announcements) ||
                other.announcements == announcements) &&
            (identical(other.bills, bills) || other.bills == bills) &&
            (identical(other.powerUpdates, powerUpdates) ||
                other.powerUpdates == powerUpdates) &&
            (identical(other.payments, payments) ||
                other.payments == payments) &&
            (identical(other.paymentOffers, paymentOffers) ||
                other.paymentOffers == paymentOffers) &&
            (identical(other.affectedAccounts, affectedAccounts) ||
                other.affectedAccounts == affectedAccounts) &&
            (identical(other.updateRequiredMessage, updateRequiredMessage) ||
                other.updateRequiredMessage == updateRequiredMessage) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.tester, tester) || other.tester == tester));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    username,
    sessionExpired,
    token,
    guest,
    identified,
    connected,
    secured,
    maxPinnedAccounts,
    loggedIn,
    requiresUpdate,
    preferredAccounts,
    customerName,
    announcements,
    bills,
    powerUpdates,
    payments,
    paymentOffers,
    affectedAccounts,
    updateRequiredMessage,
    email,
    tester,
  ]);

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDtoImplCopyWith<_$UserDtoImpl> get copyWith =>
      __$$UserDtoImplCopyWithImpl<_$UserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDtoImplToJson(this);
  }
}

abstract class _UserDto implements UserDto {
  const factory _UserDto({
    required final String id,
    required final String username,
    final bool sessionExpired,
    required final String token,
    final bool guest,
    final bool identified,
    final bool connected,
    final bool secured,
    final int maxPinnedAccounts,
    final bool loggedIn,
    final bool requiresUpdate,
    final String? preferredAccounts,
    final String? customerName,
    final int announcements,
    final int bills,
    final int powerUpdates,
    final int payments,
    final int paymentOffers,
    final int affectedAccounts,
    final String? updateRequiredMessage,
    final String? email,
    final bool tester,
  }) = _$UserDtoImpl;

  factory _UserDto.fromJson(Map<String, dynamic> json) = _$UserDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  bool get sessionExpired;
  @override
  String get token;
  @override
  bool get guest;
  @override
  bool get identified;
  @override
  bool get connected;
  @override
  bool get secured;
  @override
  int get maxPinnedAccounts;
  @override
  bool get loggedIn;
  @override
  bool get requiresUpdate;
  @override
  String? get preferredAccounts;
  @override
  String? get customerName;
  @override
  int get announcements;
  @override
  int get bills;
  @override
  int get powerUpdates;
  @override
  int get payments;
  @override
  int get paymentOffers;
  @override
  int get affectedAccounts;
  @override
  String? get updateRequiredMessage;
  @override
  String? get email;
  @override
  bool get tester;

  /// Create a copy of UserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDtoImplCopyWith<_$UserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) {
  return _LoginResponseDto.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  UserDto get user => throw _privateConstructorUsedError;

  /// Serializes this LoginResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseDtoCopyWith<LoginResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseDtoCopyWith<$Res> {
  factory $LoginResponseDtoCopyWith(
    LoginResponseDto value,
    $Res Function(LoginResponseDto) then,
  ) = _$LoginResponseDtoCopyWithImpl<$Res, LoginResponseDto>;
  @useResult
  $Res call({int status, String? message, UserDto user});

  $UserDtoCopyWith<$Res> get user;
}

/// @nodoc
class _$LoginResponseDtoCopyWithImpl<$Res, $Val extends LoginResponseDto>
    implements $LoginResponseDtoCopyWith<$Res> {
  _$LoginResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? user = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserDto,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res> get user {
    return $UserDtoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseDtoImplCopyWith<$Res>
    implements $LoginResponseDtoCopyWith<$Res> {
  factory _$$LoginResponseDtoImplCopyWith(
    _$LoginResponseDtoImpl value,
    $Res Function(_$LoginResponseDtoImpl) then,
  ) = __$$LoginResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, UserDto user});

  @override
  $UserDtoCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoginResponseDtoImplCopyWithImpl<$Res>
    extends _$LoginResponseDtoCopyWithImpl<$Res, _$LoginResponseDtoImpl>
    implements _$$LoginResponseDtoImplCopyWith<$Res> {
  __$$LoginResponseDtoImplCopyWithImpl(
    _$LoginResponseDtoImpl _value,
    $Res Function(_$LoginResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? user = null,
  }) {
    return _then(
      _$LoginResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseDtoImpl implements _LoginResponseDto {
  const _$LoginResponseDtoImpl({
    required this.status,
    this.message,
    required this.user,
  });

  factory _$LoginResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  @override
  final UserDto user;

  @override
  String toString() {
    return 'LoginResponseDto(status: $status, message: $message, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, user);

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseDtoImplCopyWith<_$LoginResponseDtoImpl> get copyWith =>
      __$$LoginResponseDtoImplCopyWithImpl<_$LoginResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseDtoImplToJson(this);
  }
}

abstract class _LoginResponseDto implements LoginResponseDto {
  const factory _LoginResponseDto({
    required final int status,
    final String? message,
    required final UserDto user,
  }) = _$LoginResponseDtoImpl;

  factory _LoginResponseDto.fromJson(Map<String, dynamic> json) =
      _$LoginResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  UserDto get user;

  /// Create a copy of LoginResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseDtoImplCopyWith<_$LoginResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterResponseDto _$RegisterResponseDtoFromJson(Map<String, dynamic> json) {
  return _RegisterResponseDto.fromJson(json);
}

/// @nodoc
mixin _$RegisterResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  UserDto get user => throw _privateConstructorUsedError;

  /// Serializes this RegisterResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterResponseDtoCopyWith<RegisterResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterResponseDtoCopyWith<$Res> {
  factory $RegisterResponseDtoCopyWith(
    RegisterResponseDto value,
    $Res Function(RegisterResponseDto) then,
  ) = _$RegisterResponseDtoCopyWithImpl<$Res, RegisterResponseDto>;
  @useResult
  $Res call({int status, String? message, UserDto user});

  $UserDtoCopyWith<$Res> get user;
}

/// @nodoc
class _$RegisterResponseDtoCopyWithImpl<$Res, $Val extends RegisterResponseDto>
    implements $RegisterResponseDtoCopyWith<$Res> {
  _$RegisterResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? user = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserDto,
          )
          as $Val,
    );
  }

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res> get user {
    return $UserDtoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegisterResponseDtoImplCopyWith<$Res>
    implements $RegisterResponseDtoCopyWith<$Res> {
  factory _$$RegisterResponseDtoImplCopyWith(
    _$RegisterResponseDtoImpl value,
    $Res Function(_$RegisterResponseDtoImpl) then,
  ) = __$$RegisterResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, UserDto user});

  @override
  $UserDtoCopyWith<$Res> get user;
}

/// @nodoc
class __$$RegisterResponseDtoImplCopyWithImpl<$Res>
    extends _$RegisterResponseDtoCopyWithImpl<$Res, _$RegisterResponseDtoImpl>
    implements _$$RegisterResponseDtoImplCopyWith<$Res> {
  __$$RegisterResponseDtoImplCopyWithImpl(
    _$RegisterResponseDtoImpl _value,
    $Res Function(_$RegisterResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? user = null,
  }) {
    return _then(
      _$RegisterResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterResponseDtoImpl implements _RegisterResponseDto {
  const _$RegisterResponseDtoImpl({
    required this.status,
    this.message,
    required this.user,
  });

  factory _$RegisterResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  @override
  final UserDto user;

  @override
  String toString() {
    return 'RegisterResponseDto(status: $status, message: $message, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, user);

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterResponseDtoImplCopyWith<_$RegisterResponseDtoImpl> get copyWith =>
      __$$RegisterResponseDtoImplCopyWithImpl<_$RegisterResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterResponseDtoImplToJson(this);
  }
}

abstract class _RegisterResponseDto implements RegisterResponseDto {
  const factory _RegisterResponseDto({
    required final int status,
    final String? message,
    required final UserDto user,
  }) = _$RegisterResponseDtoImpl;

  factory _RegisterResponseDto.fromJson(Map<String, dynamic> json) =
      _$RegisterResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  UserDto get user;

  /// Create a copy of RegisterResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterResponseDtoImplCopyWith<_$RegisterResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageResponseDto _$MessageResponseDtoFromJson(Map<String, dynamic> json) {
  return _MessageResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MessageResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MessageResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageResponseDtoCopyWith<MessageResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageResponseDtoCopyWith<$Res> {
  factory $MessageResponseDtoCopyWith(
    MessageResponseDto value,
    $Res Function(MessageResponseDto) then,
  ) = _$MessageResponseDtoCopyWithImpl<$Res, MessageResponseDto>;
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class _$MessageResponseDtoCopyWithImpl<$Res, $Val extends MessageResponseDto>
    implements $MessageResponseDtoCopyWith<$Res> {
  _$MessageResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageResponseDtoImplCopyWith<$Res>
    implements $MessageResponseDtoCopyWith<$Res> {
  factory _$$MessageResponseDtoImplCopyWith(
    _$MessageResponseDtoImpl value,
    $Res Function(_$MessageResponseDtoImpl) then,
  ) = __$$MessageResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class __$$MessageResponseDtoImplCopyWithImpl<$Res>
    extends _$MessageResponseDtoCopyWithImpl<$Res, _$MessageResponseDtoImpl>
    implements _$$MessageResponseDtoImplCopyWith<$Res> {
  __$$MessageResponseDtoImplCopyWithImpl(
    _$MessageResponseDtoImpl _value,
    $Res Function(_$MessageResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _$MessageResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageResponseDtoImpl implements _MessageResponseDto {
  const _$MessageResponseDtoImpl({required this.status, this.message});

  factory _$MessageResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;

  @override
  String toString() {
    return 'MessageResponseDto(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of MessageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageResponseDtoImplCopyWith<_$MessageResponseDtoImpl> get copyWith =>
      __$$MessageResponseDtoImplCopyWithImpl<_$MessageResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageResponseDtoImplToJson(this);
  }
}

abstract class _MessageResponseDto implements MessageResponseDto {
  const factory _MessageResponseDto({
    required final int status,
    final String? message,
  }) = _$MessageResponseDtoImpl;

  factory _MessageResponseDto.fromJson(Map<String, dynamic> json) =
      _$MessageResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;

  /// Create a copy of MessageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageResponseDtoImplCopyWith<_$MessageResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceAddressDto _$ServiceAddressDtoFromJson(Map<String, dynamic> json) {
  return _ServiceAddressDto.fromJson(json);
}

/// @nodoc
mixin _$ServiceAddressDto {
  String? get apartmentNumber => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get district => throw _privateConstructorUsedError;
  String get latitude => throw _privateConstructorUsedError;
  String get longitude => throw _privateConstructorUsedError;
  bool get hasExistingPowerLine => throw _privateConstructorUsedError;

  /// Serializes this ServiceAddressDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceAddressDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceAddressDtoCopyWith<ServiceAddressDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceAddressDtoCopyWith<$Res> {
  factory $ServiceAddressDtoCopyWith(
    ServiceAddressDto value,
    $Res Function(ServiceAddressDto) then,
  ) = _$ServiceAddressDtoCopyWithImpl<$Res, ServiceAddressDto>;
  @useResult
  $Res call({
    String? apartmentNumber,
    String street,
    String city,
    String district,
    String latitude,
    String longitude,
    bool hasExistingPowerLine,
  });
}

/// @nodoc
class _$ServiceAddressDtoCopyWithImpl<$Res, $Val extends ServiceAddressDto>
    implements $ServiceAddressDtoCopyWith<$Res> {
  _$ServiceAddressDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceAddressDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apartmentNumber = freezed,
    Object? street = null,
    Object? city = null,
    Object? district = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? hasExistingPowerLine = null,
  }) {
    return _then(
      _value.copyWith(
            apartmentNumber: freezed == apartmentNumber
                ? _value.apartmentNumber
                : apartmentNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            street: null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            district: null == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as String,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as String,
            hasExistingPowerLine: null == hasExistingPowerLine
                ? _value.hasExistingPowerLine
                : hasExistingPowerLine // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceAddressDtoImplCopyWith<$Res>
    implements $ServiceAddressDtoCopyWith<$Res> {
  factory _$$ServiceAddressDtoImplCopyWith(
    _$ServiceAddressDtoImpl value,
    $Res Function(_$ServiceAddressDtoImpl) then,
  ) = __$$ServiceAddressDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? apartmentNumber,
    String street,
    String city,
    String district,
    String latitude,
    String longitude,
    bool hasExistingPowerLine,
  });
}

/// @nodoc
class __$$ServiceAddressDtoImplCopyWithImpl<$Res>
    extends _$ServiceAddressDtoCopyWithImpl<$Res, _$ServiceAddressDtoImpl>
    implements _$$ServiceAddressDtoImplCopyWith<$Res> {
  __$$ServiceAddressDtoImplCopyWithImpl(
    _$ServiceAddressDtoImpl _value,
    $Res Function(_$ServiceAddressDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceAddressDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apartmentNumber = freezed,
    Object? street = null,
    Object? city = null,
    Object? district = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? hasExistingPowerLine = null,
  }) {
    return _then(
      _$ServiceAddressDtoImpl(
        apartmentNumber: freezed == apartmentNumber
            ? _value.apartmentNumber
            : apartmentNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        street: null == street
            ? _value.street
            : street // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        district: null == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as String,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as String,
        hasExistingPowerLine: null == hasExistingPowerLine
            ? _value.hasExistingPowerLine
            : hasExistingPowerLine // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceAddressDtoImpl implements _ServiceAddressDto {
  const _$ServiceAddressDtoImpl({
    this.apartmentNumber,
    required this.street,
    required this.city,
    required this.district,
    required this.latitude,
    required this.longitude,
    this.hasExistingPowerLine = false,
  });

  factory _$ServiceAddressDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceAddressDtoImplFromJson(json);

  @override
  final String? apartmentNumber;
  @override
  final String street;
  @override
  final String city;
  @override
  final String district;
  @override
  final String latitude;
  @override
  final String longitude;
  @override
  @JsonKey()
  final bool hasExistingPowerLine;

  @override
  String toString() {
    return 'ServiceAddressDto(apartmentNumber: $apartmentNumber, street: $street, city: $city, district: $district, latitude: $latitude, longitude: $longitude, hasExistingPowerLine: $hasExistingPowerLine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceAddressDtoImpl &&
            (identical(other.apartmentNumber, apartmentNumber) ||
                other.apartmentNumber == apartmentNumber) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.hasExistingPowerLine, hasExistingPowerLine) ||
                other.hasExistingPowerLine == hasExistingPowerLine));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    apartmentNumber,
    street,
    city,
    district,
    latitude,
    longitude,
    hasExistingPowerLine,
  );

  /// Create a copy of ServiceAddressDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceAddressDtoImplCopyWith<_$ServiceAddressDtoImpl> get copyWith =>
      __$$ServiceAddressDtoImplCopyWithImpl<_$ServiceAddressDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceAddressDtoImplToJson(this);
  }
}

abstract class _ServiceAddressDto implements ServiceAddressDto {
  const factory _ServiceAddressDto({
    final String? apartmentNumber,
    required final String street,
    required final String city,
    required final String district,
    required final String latitude,
    required final String longitude,
    final bool hasExistingPowerLine,
  }) = _$ServiceAddressDtoImpl;

  factory _ServiceAddressDto.fromJson(Map<String, dynamic> json) =
      _$ServiceAddressDtoImpl.fromJson;

  @override
  String? get apartmentNumber;
  @override
  String get street;
  @override
  String get city;
  @override
  String get district;
  @override
  String get latitude;
  @override
  String get longitude;
  @override
  bool get hasExistingPowerLine;

  /// Create a copy of ServiceAddressDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceAddressDtoImplCopyWith<_$ServiceAddressDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccountBalanceDto _$AccountBalanceDtoFromJson(Map<String, dynamic> json) {
  return _AccountBalanceDto.fromJson(json);
}

/// @nodoc
mixin _$AccountBalanceDto {
  String? get balance => throw _privateConstructorUsedError;
  String? get deposit => throw _privateConstructorUsedError;
  String? get lastBillNumber => throw _privateConstructorUsedError;
  String? get lastBillAmount => throw _privateConstructorUsedError;
  String? get lastBillDate => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String? get dueIn => throw _privateConstructorUsedError;
  String? get currentBill => throw _privateConstructorUsedError;
  String? get pastDue => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get collectionStatus => throw _privateConstructorUsedError;
  String? get lastPaymentDate => throw _privateConstructorUsedError;
  String? get lastPaymentAmount => throw _privateConstructorUsedError;
  String? get lastPaymentBillNumber => throw _privateConstructorUsedError;
  bool get paid => throw _privateConstructorUsedError;

  /// Serializes this AccountBalanceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountBalanceDtoCopyWith<AccountBalanceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountBalanceDtoCopyWith<$Res> {
  factory $AccountBalanceDtoCopyWith(
    AccountBalanceDto value,
    $Res Function(AccountBalanceDto) then,
  ) = _$AccountBalanceDtoCopyWithImpl<$Res, AccountBalanceDto>;
  @useResult
  $Res call({
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    String color,
    String? collectionStatus,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    bool paid,
  });
}

/// @nodoc
class _$AccountBalanceDtoCopyWithImpl<$Res, $Val extends AccountBalanceDto>
    implements $AccountBalanceDtoCopyWith<$Res> {
  _$AccountBalanceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = freezed,
    Object? deposit = freezed,
    Object? lastBillNumber = freezed,
    Object? lastBillAmount = freezed,
    Object? lastBillDate = freezed,
    Object? dueDate = freezed,
    Object? dueIn = freezed,
    Object? currentBill = freezed,
    Object? pastDue = freezed,
    Object? color = null,
    Object? collectionStatus = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? lastPaymentBillNumber = freezed,
    Object? paid = null,
  }) {
    return _then(
      _value.copyWith(
            balance: freezed == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as String?,
            deposit: freezed == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillNumber: freezed == lastBillNumber
                ? _value.lastBillNumber
                : lastBillNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillAmount: freezed == lastBillAmount
                ? _value.lastBillAmount
                : lastBillAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillDate: freezed == lastBillDate
                ? _value.lastBillDate
                : lastBillDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueIn: freezed == dueIn
                ? _value.dueIn
                : dueIn // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentBill: freezed == currentBill
                ? _value.currentBill
                : currentBill // ignore: cast_nullable_to_non_nullable
                      as String?,
            pastDue: freezed == pastDue
                ? _value.pastDue
                : pastDue // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            collectionStatus: freezed == collectionStatus
                ? _value.collectionStatus
                : collectionStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentDate: freezed == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentAmount: freezed == lastPaymentAmount
                ? _value.lastPaymentAmount
                : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentBillNumber: freezed == lastPaymentBillNumber
                ? _value.lastPaymentBillNumber
                : lastPaymentBillNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountBalanceDtoImplCopyWith<$Res>
    implements $AccountBalanceDtoCopyWith<$Res> {
  factory _$$AccountBalanceDtoImplCopyWith(
    _$AccountBalanceDtoImpl value,
    $Res Function(_$AccountBalanceDtoImpl) then,
  ) = __$$AccountBalanceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    String color,
    String? collectionStatus,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    bool paid,
  });
}

/// @nodoc
class __$$AccountBalanceDtoImplCopyWithImpl<$Res>
    extends _$AccountBalanceDtoCopyWithImpl<$Res, _$AccountBalanceDtoImpl>
    implements _$$AccountBalanceDtoImplCopyWith<$Res> {
  __$$AccountBalanceDtoImplCopyWithImpl(
    _$AccountBalanceDtoImpl _value,
    $Res Function(_$AccountBalanceDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = freezed,
    Object? deposit = freezed,
    Object? lastBillNumber = freezed,
    Object? lastBillAmount = freezed,
    Object? lastBillDate = freezed,
    Object? dueDate = freezed,
    Object? dueIn = freezed,
    Object? currentBill = freezed,
    Object? pastDue = freezed,
    Object? color = null,
    Object? collectionStatus = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? lastPaymentBillNumber = freezed,
    Object? paid = null,
  }) {
    return _then(
      _$AccountBalanceDtoImpl(
        balance: freezed == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as String?,
        deposit: freezed == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillNumber: freezed == lastBillNumber
            ? _value.lastBillNumber
            : lastBillNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillAmount: freezed == lastBillAmount
            ? _value.lastBillAmount
            : lastBillAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillDate: freezed == lastBillDate
            ? _value.lastBillDate
            : lastBillDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueIn: freezed == dueIn
            ? _value.dueIn
            : dueIn // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBill: freezed == currentBill
            ? _value.currentBill
            : currentBill // ignore: cast_nullable_to_non_nullable
                  as String?,
        pastDue: freezed == pastDue
            ? _value.pastDue
            : pastDue // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        collectionStatus: freezed == collectionStatus
            ? _value.collectionStatus
            : collectionStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentDate: freezed == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentAmount: freezed == lastPaymentAmount
            ? _value.lastPaymentAmount
            : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentBillNumber: freezed == lastPaymentBillNumber
            ? _value.lastPaymentBillNumber
            : lastPaymentBillNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountBalanceDtoImpl implements _AccountBalanceDto {
  const _$AccountBalanceDtoImpl({
    this.balance,
    this.deposit,
    this.lastBillNumber,
    this.lastBillAmount,
    this.lastBillDate,
    this.dueDate,
    this.dueIn,
    this.currentBill,
    this.pastDue,
    required this.color,
    this.collectionStatus,
    this.lastPaymentDate,
    this.lastPaymentAmount,
    this.lastPaymentBillNumber,
    this.paid = false,
  });

  factory _$AccountBalanceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountBalanceDtoImplFromJson(json);

  @override
  final String? balance;
  @override
  final String? deposit;
  @override
  final String? lastBillNumber;
  @override
  final String? lastBillAmount;
  @override
  final String? lastBillDate;
  @override
  final String? dueDate;
  @override
  final String? dueIn;
  @override
  final String? currentBill;
  @override
  final String? pastDue;
  @override
  final String color;
  @override
  final String? collectionStatus;
  @override
  final String? lastPaymentDate;
  @override
  final String? lastPaymentAmount;
  @override
  final String? lastPaymentBillNumber;
  @override
  @JsonKey()
  final bool paid;

  @override
  String toString() {
    return 'AccountBalanceDto(balance: $balance, deposit: $deposit, lastBillNumber: $lastBillNumber, lastBillAmount: $lastBillAmount, lastBillDate: $lastBillDate, dueDate: $dueDate, dueIn: $dueIn, currentBill: $currentBill, pastDue: $pastDue, color: $color, collectionStatus: $collectionStatus, lastPaymentDate: $lastPaymentDate, lastPaymentAmount: $lastPaymentAmount, lastPaymentBillNumber: $lastPaymentBillNumber, paid: $paid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountBalanceDtoImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.lastBillNumber, lastBillNumber) ||
                other.lastBillNumber == lastBillNumber) &&
            (identical(other.lastBillAmount, lastBillAmount) ||
                other.lastBillAmount == lastBillAmount) &&
            (identical(other.lastBillDate, lastBillDate) ||
                other.lastBillDate == lastBillDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.dueIn, dueIn) || other.dueIn == dueIn) &&
            (identical(other.currentBill, currentBill) ||
                other.currentBill == currentBill) &&
            (identical(other.pastDue, pastDue) || other.pastDue == pastDue) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.collectionStatus, collectionStatus) ||
                other.collectionStatus == collectionStatus) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.lastPaymentAmount, lastPaymentAmount) ||
                other.lastPaymentAmount == lastPaymentAmount) &&
            (identical(other.lastPaymentBillNumber, lastPaymentBillNumber) ||
                other.lastPaymentBillNumber == lastPaymentBillNumber) &&
            (identical(other.paid, paid) || other.paid == paid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    balance,
    deposit,
    lastBillNumber,
    lastBillAmount,
    lastBillDate,
    dueDate,
    dueIn,
    currentBill,
    pastDue,
    color,
    collectionStatus,
    lastPaymentDate,
    lastPaymentAmount,
    lastPaymentBillNumber,
    paid,
  );

  /// Create a copy of AccountBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountBalanceDtoImplCopyWith<_$AccountBalanceDtoImpl> get copyWith =>
      __$$AccountBalanceDtoImplCopyWithImpl<_$AccountBalanceDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountBalanceDtoImplToJson(this);
  }
}

abstract class _AccountBalanceDto implements AccountBalanceDto {
  const factory _AccountBalanceDto({
    final String? balance,
    final String? deposit,
    final String? lastBillNumber,
    final String? lastBillAmount,
    final String? lastBillDate,
    final String? dueDate,
    final String? dueIn,
    final String? currentBill,
    final String? pastDue,
    required final String color,
    final String? collectionStatus,
    final String? lastPaymentDate,
    final String? lastPaymentAmount,
    final String? lastPaymentBillNumber,
    final bool paid,
  }) = _$AccountBalanceDtoImpl;

  factory _AccountBalanceDto.fromJson(Map<String, dynamic> json) =
      _$AccountBalanceDtoImpl.fromJson;

  @override
  String? get balance;
  @override
  String? get deposit;
  @override
  String? get lastBillNumber;
  @override
  String? get lastBillAmount;
  @override
  String? get lastBillDate;
  @override
  String? get dueDate;
  @override
  String? get dueIn;
  @override
  String? get currentBill;
  @override
  String? get pastDue;
  @override
  String get color;
  @override
  String? get collectionStatus;
  @override
  String? get lastPaymentDate;
  @override
  String? get lastPaymentAmount;
  @override
  String? get lastPaymentBillNumber;
  @override
  bool get paid;

  /// Create a copy of AccountBalanceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountBalanceDtoImplCopyWith<_$AccountBalanceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EditableCustomerAccountDto _$EditableCustomerAccountDtoFromJson(
  Map<String, dynamic> json,
) {
  return _EditableCustomerAccountDto.fromJson(json);
}

/// @nodoc
mixin _$EditableCustomerAccountDto {
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get meter => throw _privateConstructorUsedError;
  String? get balance => throw _privateConstructorUsedError;
  String? get deposit => throw _privateConstructorUsedError;
  String? get lastBillNumber => throw _privateConstructorUsedError;
  String? get lastBillAmount => throw _privateConstructorUsedError;
  String? get lastBillDate => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String? get dueIn => throw _privateConstructorUsedError;
  String? get currentBill => throw _privateConstructorUsedError;
  String? get pastDue => throw _privateConstructorUsedError;
  String? get lastPaymentDate => throw _privateConstructorUsedError;
  String? get lastPaymentAmount => throw _privateConstructorUsedError;
  String? get lastPaymentBillNumber => throw _privateConstructorUsedError;
  bool get paid => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String? get customerNumber => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get nickName => throw _privateConstructorUsedError;
  String? get billCode => throw _privateConstructorUsedError;
  String? get cell => throw _privateConstructorUsedError;
  String? get emailAddress => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  bool get pinned => throw _privateConstructorUsedError;
  String? get apartmentNumber => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get collectionStatus => throw _privateConstructorUsedError;
  bool get fullAccess => throw _privateConstructorUsedError;
  bool get billDownloadAccess => throw _privateConstructorUsedError;

  /// Serializes this EditableCustomerAccountDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditableCustomerAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditableCustomerAccountDtoCopyWith<EditableCustomerAccountDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditableCustomerAccountDtoCopyWith<$Res> {
  factory $EditableCustomerAccountDtoCopyWith(
    EditableCustomerAccountDto value,
    $Res Function(EditableCustomerAccountDto) then,
  ) =
      _$EditableCustomerAccountDtoCopyWithImpl<
        $Res,
        EditableCustomerAccountDto
      >;
  @useResult
  $Res call({
    String? accountNumber,
    String? meter,
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    bool paid,
    String? color,
    bool active,
    String? customerNumber,
    String? name,
    String? nickName,
    String? billCode,
    String? cell,
    String? emailAddress,
    int orderIndex,
    bool pinned,
    String? apartmentNumber,
    String? street,
    String? city,
    String? district,
    String? latitude,
    String? longitude,
    String? collectionStatus,
    bool fullAccess,
    bool billDownloadAccess,
  });
}

/// @nodoc
class _$EditableCustomerAccountDtoCopyWithImpl<
  $Res,
  $Val extends EditableCustomerAccountDto
>
    implements $EditableCustomerAccountDtoCopyWith<$Res> {
  _$EditableCustomerAccountDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditableCustomerAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = freezed,
    Object? meter = freezed,
    Object? balance = freezed,
    Object? deposit = freezed,
    Object? lastBillNumber = freezed,
    Object? lastBillAmount = freezed,
    Object? lastBillDate = freezed,
    Object? dueDate = freezed,
    Object? dueIn = freezed,
    Object? currentBill = freezed,
    Object? pastDue = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? lastPaymentBillNumber = freezed,
    Object? paid = null,
    Object? color = freezed,
    Object? active = null,
    Object? customerNumber = freezed,
    Object? name = freezed,
    Object? nickName = freezed,
    Object? billCode = freezed,
    Object? cell = freezed,
    Object? emailAddress = freezed,
    Object? orderIndex = null,
    Object? pinned = null,
    Object? apartmentNumber = freezed,
    Object? street = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? collectionStatus = freezed,
    Object? fullAccess = null,
    Object? billDownloadAccess = null,
  }) {
    return _then(
      _value.copyWith(
            accountNumber: freezed == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            meter: freezed == meter
                ? _value.meter
                : meter // ignore: cast_nullable_to_non_nullable
                      as String?,
            balance: freezed == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as String?,
            deposit: freezed == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillNumber: freezed == lastBillNumber
                ? _value.lastBillNumber
                : lastBillNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillAmount: freezed == lastBillAmount
                ? _value.lastBillAmount
                : lastBillAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastBillDate: freezed == lastBillDate
                ? _value.lastBillDate
                : lastBillDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueIn: freezed == dueIn
                ? _value.dueIn
                : dueIn // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentBill: freezed == currentBill
                ? _value.currentBill
                : currentBill // ignore: cast_nullable_to_non_nullable
                      as String?,
            pastDue: freezed == pastDue
                ? _value.pastDue
                : pastDue // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentDate: freezed == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentAmount: freezed == lastPaymentAmount
                ? _value.lastPaymentAmount
                : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPaymentBillNumber: freezed == lastPaymentBillNumber
                ? _value.lastPaymentBillNumber
                : lastPaymentBillNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as bool,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            customerNumber: freezed == customerNumber
                ? _value.customerNumber
                : customerNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            nickName: freezed == nickName
                ? _value.nickName
                : nickName // ignore: cast_nullable_to_non_nullable
                      as String?,
            billCode: freezed == billCode
                ? _value.billCode
                : billCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            cell: freezed == cell
                ? _value.cell
                : cell // ignore: cast_nullable_to_non_nullable
                      as String?,
            emailAddress: freezed == emailAddress
                ? _value.emailAddress
                : emailAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            pinned: null == pinned
                ? _value.pinned
                : pinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            apartmentNumber: freezed == apartmentNumber
                ? _value.apartmentNumber
                : apartmentNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            street: freezed == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            district: freezed == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as String?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as String?,
            collectionStatus: freezed == collectionStatus
                ? _value.collectionStatus
                : collectionStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullAccess: null == fullAccess
                ? _value.fullAccess
                : fullAccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            billDownloadAccess: null == billDownloadAccess
                ? _value.billDownloadAccess
                : billDownloadAccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EditableCustomerAccountDtoImplCopyWith<$Res>
    implements $EditableCustomerAccountDtoCopyWith<$Res> {
  factory _$$EditableCustomerAccountDtoImplCopyWith(
    _$EditableCustomerAccountDtoImpl value,
    $Res Function(_$EditableCustomerAccountDtoImpl) then,
  ) = __$$EditableCustomerAccountDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? accountNumber,
    String? meter,
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    bool paid,
    String? color,
    bool active,
    String? customerNumber,
    String? name,
    String? nickName,
    String? billCode,
    String? cell,
    String? emailAddress,
    int orderIndex,
    bool pinned,
    String? apartmentNumber,
    String? street,
    String? city,
    String? district,
    String? latitude,
    String? longitude,
    String? collectionStatus,
    bool fullAccess,
    bool billDownloadAccess,
  });
}

/// @nodoc
class __$$EditableCustomerAccountDtoImplCopyWithImpl<$Res>
    extends
        _$EditableCustomerAccountDtoCopyWithImpl<
          $Res,
          _$EditableCustomerAccountDtoImpl
        >
    implements _$$EditableCustomerAccountDtoImplCopyWith<$Res> {
  __$$EditableCustomerAccountDtoImplCopyWithImpl(
    _$EditableCustomerAccountDtoImpl _value,
    $Res Function(_$EditableCustomerAccountDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditableCustomerAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = freezed,
    Object? meter = freezed,
    Object? balance = freezed,
    Object? deposit = freezed,
    Object? lastBillNumber = freezed,
    Object? lastBillAmount = freezed,
    Object? lastBillDate = freezed,
    Object? dueDate = freezed,
    Object? dueIn = freezed,
    Object? currentBill = freezed,
    Object? pastDue = freezed,
    Object? lastPaymentDate = freezed,
    Object? lastPaymentAmount = freezed,
    Object? lastPaymentBillNumber = freezed,
    Object? paid = null,
    Object? color = freezed,
    Object? active = null,
    Object? customerNumber = freezed,
    Object? name = freezed,
    Object? nickName = freezed,
    Object? billCode = freezed,
    Object? cell = freezed,
    Object? emailAddress = freezed,
    Object? orderIndex = null,
    Object? pinned = null,
    Object? apartmentNumber = freezed,
    Object? street = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? collectionStatus = freezed,
    Object? fullAccess = null,
    Object? billDownloadAccess = null,
  }) {
    return _then(
      _$EditableCustomerAccountDtoImpl(
        accountNumber: freezed == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        meter: freezed == meter
            ? _value.meter
            : meter // ignore: cast_nullable_to_non_nullable
                  as String?,
        balance: freezed == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as String?,
        deposit: freezed == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillNumber: freezed == lastBillNumber
            ? _value.lastBillNumber
            : lastBillNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillAmount: freezed == lastBillAmount
            ? _value.lastBillAmount
            : lastBillAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastBillDate: freezed == lastBillDate
            ? _value.lastBillDate
            : lastBillDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueIn: freezed == dueIn
            ? _value.dueIn
            : dueIn // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentBill: freezed == currentBill
            ? _value.currentBill
            : currentBill // ignore: cast_nullable_to_non_nullable
                  as String?,
        pastDue: freezed == pastDue
            ? _value.pastDue
            : pastDue // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentDate: freezed == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentAmount: freezed == lastPaymentAmount
            ? _value.lastPaymentAmount
            : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPaymentBillNumber: freezed == lastPaymentBillNumber
            ? _value.lastPaymentBillNumber
            : lastPaymentBillNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as bool,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        customerNumber: freezed == customerNumber
            ? _value.customerNumber
            : customerNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        nickName: freezed == nickName
            ? _value.nickName
            : nickName // ignore: cast_nullable_to_non_nullable
                  as String?,
        billCode: freezed == billCode
            ? _value.billCode
            : billCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        cell: freezed == cell
            ? _value.cell
            : cell // ignore: cast_nullable_to_non_nullable
                  as String?,
        emailAddress: freezed == emailAddress
            ? _value.emailAddress
            : emailAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        pinned: null == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        apartmentNumber: freezed == apartmentNumber
            ? _value.apartmentNumber
            : apartmentNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        street: freezed == street
            ? _value.street
            : street // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        district: freezed == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as String?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as String?,
        collectionStatus: freezed == collectionStatus
            ? _value.collectionStatus
            : collectionStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullAccess: null == fullAccess
            ? _value.fullAccess
            : fullAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        billDownloadAccess: null == billDownloadAccess
            ? _value.billDownloadAccess
            : billDownloadAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EditableCustomerAccountDtoImpl implements _EditableCustomerAccountDto {
  const _$EditableCustomerAccountDtoImpl({
    this.accountNumber,
    this.meter,
    this.balance,
    this.deposit,
    this.lastBillNumber,
    this.lastBillAmount,
    this.lastBillDate,
    this.dueDate,
    this.dueIn,
    this.currentBill,
    this.pastDue,
    this.lastPaymentDate,
    this.lastPaymentAmount,
    this.lastPaymentBillNumber,
    this.paid = false,
    this.color,
    this.active = true,
    this.customerNumber,
    this.name,
    this.nickName,
    this.billCode,
    this.cell,
    this.emailAddress,
    this.orderIndex = 0,
    this.pinned = false,
    this.apartmentNumber,
    this.street,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.collectionStatus,
    this.fullAccess = false,
    this.billDownloadAccess = false,
  });

  factory _$EditableCustomerAccountDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EditableCustomerAccountDtoImplFromJson(json);

  @override
  final String? accountNumber;
  @override
  final String? meter;
  @override
  final String? balance;
  @override
  final String? deposit;
  @override
  final String? lastBillNumber;
  @override
  final String? lastBillAmount;
  @override
  final String? lastBillDate;
  @override
  final String? dueDate;
  @override
  final String? dueIn;
  @override
  final String? currentBill;
  @override
  final String? pastDue;
  @override
  final String? lastPaymentDate;
  @override
  final String? lastPaymentAmount;
  @override
  final String? lastPaymentBillNumber;
  @override
  @JsonKey()
  final bool paid;
  @override
  final String? color;
  @override
  @JsonKey()
  final bool active;
  @override
  final String? customerNumber;
  @override
  final String? name;
  @override
  final String? nickName;
  @override
  final String? billCode;
  @override
  final String? cell;
  @override
  final String? emailAddress;
  @override
  @JsonKey()
  final int orderIndex;
  @override
  @JsonKey()
  final bool pinned;
  @override
  final String? apartmentNumber;
  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  final String? collectionStatus;
  @override
  @JsonKey()
  final bool fullAccess;
  @override
  @JsonKey()
  final bool billDownloadAccess;

  @override
  String toString() {
    return 'EditableCustomerAccountDto(accountNumber: $accountNumber, meter: $meter, balance: $balance, deposit: $deposit, lastBillNumber: $lastBillNumber, lastBillAmount: $lastBillAmount, lastBillDate: $lastBillDate, dueDate: $dueDate, dueIn: $dueIn, currentBill: $currentBill, pastDue: $pastDue, lastPaymentDate: $lastPaymentDate, lastPaymentAmount: $lastPaymentAmount, lastPaymentBillNumber: $lastPaymentBillNumber, paid: $paid, color: $color, active: $active, customerNumber: $customerNumber, name: $name, nickName: $nickName, billCode: $billCode, cell: $cell, emailAddress: $emailAddress, orderIndex: $orderIndex, pinned: $pinned, apartmentNumber: $apartmentNumber, street: $street, city: $city, district: $district, latitude: $latitude, longitude: $longitude, collectionStatus: $collectionStatus, fullAccess: $fullAccess, billDownloadAccess: $billDownloadAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditableCustomerAccountDtoImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.meter, meter) || other.meter == meter) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.lastBillNumber, lastBillNumber) ||
                other.lastBillNumber == lastBillNumber) &&
            (identical(other.lastBillAmount, lastBillAmount) ||
                other.lastBillAmount == lastBillAmount) &&
            (identical(other.lastBillDate, lastBillDate) ||
                other.lastBillDate == lastBillDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.dueIn, dueIn) || other.dueIn == dueIn) &&
            (identical(other.currentBill, currentBill) ||
                other.currentBill == currentBill) &&
            (identical(other.pastDue, pastDue) || other.pastDue == pastDue) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.lastPaymentAmount, lastPaymentAmount) ||
                other.lastPaymentAmount == lastPaymentAmount) &&
            (identical(other.lastPaymentBillNumber, lastPaymentBillNumber) ||
                other.lastPaymentBillNumber == lastPaymentBillNumber) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.billCode, billCode) ||
                other.billCode == billCode) &&
            (identical(other.cell, cell) || other.cell == cell) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.pinned, pinned) || other.pinned == pinned) &&
            (identical(other.apartmentNumber, apartmentNumber) ||
                other.apartmentNumber == apartmentNumber) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.collectionStatus, collectionStatus) ||
                other.collectionStatus == collectionStatus) &&
            (identical(other.fullAccess, fullAccess) ||
                other.fullAccess == fullAccess) &&
            (identical(other.billDownloadAccess, billDownloadAccess) ||
                other.billDownloadAccess == billDownloadAccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    accountNumber,
    meter,
    balance,
    deposit,
    lastBillNumber,
    lastBillAmount,
    lastBillDate,
    dueDate,
    dueIn,
    currentBill,
    pastDue,
    lastPaymentDate,
    lastPaymentAmount,
    lastPaymentBillNumber,
    paid,
    color,
    active,
    customerNumber,
    name,
    nickName,
    billCode,
    cell,
    emailAddress,
    orderIndex,
    pinned,
    apartmentNumber,
    street,
    city,
    district,
    latitude,
    longitude,
    collectionStatus,
    fullAccess,
    billDownloadAccess,
  ]);

  /// Create a copy of EditableCustomerAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditableCustomerAccountDtoImplCopyWith<_$EditableCustomerAccountDtoImpl>
  get copyWith =>
      __$$EditableCustomerAccountDtoImplCopyWithImpl<
        _$EditableCustomerAccountDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditableCustomerAccountDtoImplToJson(this);
  }
}

abstract class _EditableCustomerAccountDto
    implements EditableCustomerAccountDto {
  const factory _EditableCustomerAccountDto({
    final String? accountNumber,
    final String? meter,
    final String? balance,
    final String? deposit,
    final String? lastBillNumber,
    final String? lastBillAmount,
    final String? lastBillDate,
    final String? dueDate,
    final String? dueIn,
    final String? currentBill,
    final String? pastDue,
    final String? lastPaymentDate,
    final String? lastPaymentAmount,
    final String? lastPaymentBillNumber,
    final bool paid,
    final String? color,
    final bool active,
    final String? customerNumber,
    final String? name,
    final String? nickName,
    final String? billCode,
    final String? cell,
    final String? emailAddress,
    final int orderIndex,
    final bool pinned,
    final String? apartmentNumber,
    final String? street,
    final String? city,
    final String? district,
    final String? latitude,
    final String? longitude,
    final String? collectionStatus,
    final bool fullAccess,
    final bool billDownloadAccess,
  }) = _$EditableCustomerAccountDtoImpl;

  factory _EditableCustomerAccountDto.fromJson(Map<String, dynamic> json) =
      _$EditableCustomerAccountDtoImpl.fromJson;

  @override
  String? get accountNumber;
  @override
  String? get meter;
  @override
  String? get balance;
  @override
  String? get deposit;
  @override
  String? get lastBillNumber;
  @override
  String? get lastBillAmount;
  @override
  String? get lastBillDate;
  @override
  String? get dueDate;
  @override
  String? get dueIn;
  @override
  String? get currentBill;
  @override
  String? get pastDue;
  @override
  String? get lastPaymentDate;
  @override
  String? get lastPaymentAmount;
  @override
  String? get lastPaymentBillNumber;
  @override
  bool get paid;
  @override
  String? get color;
  @override
  bool get active;
  @override
  String? get customerNumber;
  @override
  String? get name;
  @override
  String? get nickName;
  @override
  String? get billCode;
  @override
  String? get cell;
  @override
  String? get emailAddress;
  @override
  int get orderIndex;
  @override
  bool get pinned;
  @override
  String? get apartmentNumber;
  @override
  String? get street;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  String? get collectionStatus;
  @override
  bool get fullAccess;
  @override
  bool get billDownloadAccess;

  /// Create a copy of EditableCustomerAccountDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditableCustomerAccountDtoImplCopyWith<_$EditableCustomerAccountDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ConnectedAccountsResponseDto _$ConnectedAccountsResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ConnectedAccountsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ConnectedAccountsResponseDto {
  int get status => throw _privateConstructorUsedError;
  List<EditableCustomerAccountDto> get editableCustomerAccounts =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectedAccountsResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectedAccountsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectedAccountsResponseDtoCopyWith<ConnectedAccountsResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectedAccountsResponseDtoCopyWith<$Res> {
  factory $ConnectedAccountsResponseDtoCopyWith(
    ConnectedAccountsResponseDto value,
    $Res Function(ConnectedAccountsResponseDto) then,
  ) =
      _$ConnectedAccountsResponseDtoCopyWithImpl<
        $Res,
        ConnectedAccountsResponseDto
      >;
  @useResult
  $Res call({
    int status,
    List<EditableCustomerAccountDto> editableCustomerAccounts,
  });
}

/// @nodoc
class _$ConnectedAccountsResponseDtoCopyWithImpl<
  $Res,
  $Val extends ConnectedAccountsResponseDto
>
    implements $ConnectedAccountsResponseDtoCopyWith<$Res> {
  _$ConnectedAccountsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectedAccountsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? editableCustomerAccounts = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            editableCustomerAccounts: null == editableCustomerAccounts
                ? _value.editableCustomerAccounts
                : editableCustomerAccounts // ignore: cast_nullable_to_non_nullable
                      as List<EditableCustomerAccountDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectedAccountsResponseDtoImplCopyWith<$Res>
    implements $ConnectedAccountsResponseDtoCopyWith<$Res> {
  factory _$$ConnectedAccountsResponseDtoImplCopyWith(
    _$ConnectedAccountsResponseDtoImpl value,
    $Res Function(_$ConnectedAccountsResponseDtoImpl) then,
  ) = __$$ConnectedAccountsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int status,
    List<EditableCustomerAccountDto> editableCustomerAccounts,
  });
}

/// @nodoc
class __$$ConnectedAccountsResponseDtoImplCopyWithImpl<$Res>
    extends
        _$ConnectedAccountsResponseDtoCopyWithImpl<
          $Res,
          _$ConnectedAccountsResponseDtoImpl
        >
    implements _$$ConnectedAccountsResponseDtoImplCopyWith<$Res> {
  __$$ConnectedAccountsResponseDtoImplCopyWithImpl(
    _$ConnectedAccountsResponseDtoImpl _value,
    $Res Function(_$ConnectedAccountsResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectedAccountsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? editableCustomerAccounts = null}) {
    return _then(
      _$ConnectedAccountsResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        editableCustomerAccounts: null == editableCustomerAccounts
            ? _value._editableCustomerAccounts
            : editableCustomerAccounts // ignore: cast_nullable_to_non_nullable
                  as List<EditableCustomerAccountDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectedAccountsResponseDtoImpl
    implements _ConnectedAccountsResponseDto {
  const _$ConnectedAccountsResponseDtoImpl({
    required this.status,
    final List<EditableCustomerAccountDto> editableCustomerAccounts = const [],
  }) : _editableCustomerAccounts = editableCustomerAccounts;

  factory _$ConnectedAccountsResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ConnectedAccountsResponseDtoImplFromJson(json);

  @override
  final int status;
  final List<EditableCustomerAccountDto> _editableCustomerAccounts;
  @override
  @JsonKey()
  List<EditableCustomerAccountDto> get editableCustomerAccounts {
    if (_editableCustomerAccounts is EqualUnmodifiableListView)
      return _editableCustomerAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_editableCustomerAccounts);
  }

  @override
  String toString() {
    return 'ConnectedAccountsResponseDto(status: $status, editableCustomerAccounts: $editableCustomerAccounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectedAccountsResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._editableCustomerAccounts,
              _editableCustomerAccounts,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_editableCustomerAccounts),
  );

  /// Create a copy of ConnectedAccountsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectedAccountsResponseDtoImplCopyWith<
    _$ConnectedAccountsResponseDtoImpl
  >
  get copyWith =>
      __$$ConnectedAccountsResponseDtoImplCopyWithImpl<
        _$ConnectedAccountsResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectedAccountsResponseDtoImplToJson(this);
  }
}

abstract class _ConnectedAccountsResponseDto
    implements ConnectedAccountsResponseDto {
  const factory _ConnectedAccountsResponseDto({
    required final int status,
    final List<EditableCustomerAccountDto> editableCustomerAccounts,
  }) = _$ConnectedAccountsResponseDtoImpl;

  factory _ConnectedAccountsResponseDto.fromJson(Map<String, dynamic> json) =
      _$ConnectedAccountsResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  List<EditableCustomerAccountDto> get editableCustomerAccounts;

  /// Create a copy of ConnectedAccountsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectedAccountsResponseDtoImplCopyWith<
    _$ConnectedAccountsResponseDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

CustomerAccountDetailResponseDto _$CustomerAccountDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CustomerAccountDetailResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CustomerAccountDetailResponseDto {
  int get status => throw _privateConstructorUsedError;
  CustomerAccountDetailDataDto get customerAccountDetail =>
      throw _privateConstructorUsedError;

  /// Serializes this CustomerAccountDetailResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerAccountDetailResponseDtoCopyWith<CustomerAccountDetailResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerAccountDetailResponseDtoCopyWith<$Res> {
  factory $CustomerAccountDetailResponseDtoCopyWith(
    CustomerAccountDetailResponseDto value,
    $Res Function(CustomerAccountDetailResponseDto) then,
  ) =
      _$CustomerAccountDetailResponseDtoCopyWithImpl<
        $Res,
        CustomerAccountDetailResponseDto
      >;
  @useResult
  $Res call({int status, CustomerAccountDetailDataDto customerAccountDetail});

  $CustomerAccountDetailDataDtoCopyWith<$Res> get customerAccountDetail;
}

/// @nodoc
class _$CustomerAccountDetailResponseDtoCopyWithImpl<
  $Res,
  $Val extends CustomerAccountDetailResponseDto
>
    implements $CustomerAccountDetailResponseDtoCopyWith<$Res> {
  _$CustomerAccountDetailResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? customerAccountDetail = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            customerAccountDetail: null == customerAccountDetail
                ? _value.customerAccountDetail
                : customerAccountDetail // ignore: cast_nullable_to_non_nullable
                      as CustomerAccountDetailDataDto,
          )
          as $Val,
    );
  }

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerAccountDetailDataDtoCopyWith<$Res> get customerAccountDetail {
    return $CustomerAccountDetailDataDtoCopyWith<$Res>(
      _value.customerAccountDetail,
      (value) {
        return _then(_value.copyWith(customerAccountDetail: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$CustomerAccountDetailResponseDtoImplCopyWith<$Res>
    implements $CustomerAccountDetailResponseDtoCopyWith<$Res> {
  factory _$$CustomerAccountDetailResponseDtoImplCopyWith(
    _$CustomerAccountDetailResponseDtoImpl value,
    $Res Function(_$CustomerAccountDetailResponseDtoImpl) then,
  ) = __$$CustomerAccountDetailResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, CustomerAccountDetailDataDto customerAccountDetail});

  @override
  $CustomerAccountDetailDataDtoCopyWith<$Res> get customerAccountDetail;
}

/// @nodoc
class __$$CustomerAccountDetailResponseDtoImplCopyWithImpl<$Res>
    extends
        _$CustomerAccountDetailResponseDtoCopyWithImpl<
          $Res,
          _$CustomerAccountDetailResponseDtoImpl
        >
    implements _$$CustomerAccountDetailResponseDtoImplCopyWith<$Res> {
  __$$CustomerAccountDetailResponseDtoImplCopyWithImpl(
    _$CustomerAccountDetailResponseDtoImpl _value,
    $Res Function(_$CustomerAccountDetailResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? customerAccountDetail = null}) {
    return _then(
      _$CustomerAccountDetailResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        customerAccountDetail: null == customerAccountDetail
            ? _value.customerAccountDetail
            : customerAccountDetail // ignore: cast_nullable_to_non_nullable
                  as CustomerAccountDetailDataDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerAccountDetailResponseDtoImpl
    implements _CustomerAccountDetailResponseDto {
  const _$CustomerAccountDetailResponseDtoImpl({
    required this.status,
    required this.customerAccountDetail,
  });

  factory _$CustomerAccountDetailResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CustomerAccountDetailResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final CustomerAccountDetailDataDto customerAccountDetail;

  @override
  String toString() {
    return 'CustomerAccountDetailResponseDto(status: $status, customerAccountDetail: $customerAccountDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerAccountDetailResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.customerAccountDetail, customerAccountDetail) ||
                other.customerAccountDetail == customerAccountDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, customerAccountDetail);

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerAccountDetailResponseDtoImplCopyWith<
    _$CustomerAccountDetailResponseDtoImpl
  >
  get copyWith =>
      __$$CustomerAccountDetailResponseDtoImplCopyWithImpl<
        _$CustomerAccountDetailResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerAccountDetailResponseDtoImplToJson(this);
  }
}

abstract class _CustomerAccountDetailResponseDto
    implements CustomerAccountDetailResponseDto {
  const factory _CustomerAccountDetailResponseDto({
    required final int status,
    required final CustomerAccountDetailDataDto customerAccountDetail,
  }) = _$CustomerAccountDetailResponseDtoImpl;

  factory _CustomerAccountDetailResponseDto.fromJson(
    Map<String, dynamic> json,
  ) = _$CustomerAccountDetailResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  CustomerAccountDetailDataDto get customerAccountDetail;

  /// Create a copy of CustomerAccountDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerAccountDetailResponseDtoImplCopyWith<
    _$CustomerAccountDetailResponseDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

CustomerAccountDetailDataDto _$CustomerAccountDetailDataDtoFromJson(
  Map<String, dynamic> json,
) {
  return _CustomerAccountDetailDataDto.fromJson(json);
}

/// @nodoc
mixin _$CustomerAccountDetailDataDto {
  String get accountNumber => throw _privateConstructorUsedError;
  String get customerNumber => throw _privateConstructorUsedError;
  ServiceAddressDto get serviceAddress => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get town => throw _privateConstructorUsedError;
  String get accountStatus => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  String get billCode => throw _privateConstructorUsedError;
  String get meter => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String get cell => throw _privateConstructorUsedError;
  String? get rating => throw _privateConstructorUsedError;
  AccountBalanceDto get accountBalance => throw _privateConstructorUsedError;

  /// Serializes this CustomerAccountDetailDataDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerAccountDetailDataDtoCopyWith<CustomerAccountDetailDataDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerAccountDetailDataDtoCopyWith<$Res> {
  factory $CustomerAccountDetailDataDtoCopyWith(
    CustomerAccountDetailDataDto value,
    $Res Function(CustomerAccountDetailDataDto) then,
  ) =
      _$CustomerAccountDetailDataDtoCopyWithImpl<
        $Res,
        CustomerAccountDetailDataDto
      >;
  @useResult
  $Res call({
    String accountNumber,
    String customerNumber,
    ServiceAddressDto serviceAddress,
    String name,
    String town,
    String accountStatus,
    String owner,
    String billCode,
    String meter,
    String emailAddress,
    String cell,
    String? rating,
    AccountBalanceDto accountBalance,
  });

  $ServiceAddressDtoCopyWith<$Res> get serviceAddress;
  $AccountBalanceDtoCopyWith<$Res> get accountBalance;
}

/// @nodoc
class _$CustomerAccountDetailDataDtoCopyWithImpl<
  $Res,
  $Val extends CustomerAccountDetailDataDto
>
    implements $CustomerAccountDetailDataDtoCopyWith<$Res> {
  _$CustomerAccountDetailDataDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? customerNumber = null,
    Object? serviceAddress = null,
    Object? name = null,
    Object? town = null,
    Object? accountStatus = null,
    Object? owner = null,
    Object? billCode = null,
    Object? meter = null,
    Object? emailAddress = null,
    Object? cell = null,
    Object? rating = freezed,
    Object? accountBalance = null,
  }) {
    return _then(
      _value.copyWith(
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            customerNumber: null == customerNumber
                ? _value.customerNumber
                : customerNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceAddress: null == serviceAddress
                ? _value.serviceAddress
                : serviceAddress // ignore: cast_nullable_to_non_nullable
                      as ServiceAddressDto,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            town: null == town
                ? _value.town
                : town // ignore: cast_nullable_to_non_nullable
                      as String,
            accountStatus: null == accountStatus
                ? _value.accountStatus
                : accountStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            owner: null == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                      as String,
            billCode: null == billCode
                ? _value.billCode
                : billCode // ignore: cast_nullable_to_non_nullable
                      as String,
            meter: null == meter
                ? _value.meter
                : meter // ignore: cast_nullable_to_non_nullable
                      as String,
            emailAddress: null == emailAddress
                ? _value.emailAddress
                : emailAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            cell: null == cell
                ? _value.cell
                : cell // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as String?,
            accountBalance: null == accountBalance
                ? _value.accountBalance
                : accountBalance // ignore: cast_nullable_to_non_nullable
                      as AccountBalanceDto,
          )
          as $Val,
    );
  }

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceAddressDtoCopyWith<$Res> get serviceAddress {
    return $ServiceAddressDtoCopyWith<$Res>(_value.serviceAddress, (value) {
      return _then(_value.copyWith(serviceAddress: value) as $Val);
    });
  }

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountBalanceDtoCopyWith<$Res> get accountBalance {
    return $AccountBalanceDtoCopyWith<$Res>(_value.accountBalance, (value) {
      return _then(_value.copyWith(accountBalance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerAccountDetailDataDtoImplCopyWith<$Res>
    implements $CustomerAccountDetailDataDtoCopyWith<$Res> {
  factory _$$CustomerAccountDetailDataDtoImplCopyWith(
    _$CustomerAccountDetailDataDtoImpl value,
    $Res Function(_$CustomerAccountDetailDataDtoImpl) then,
  ) = __$$CustomerAccountDetailDataDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accountNumber,
    String customerNumber,
    ServiceAddressDto serviceAddress,
    String name,
    String town,
    String accountStatus,
    String owner,
    String billCode,
    String meter,
    String emailAddress,
    String cell,
    String? rating,
    AccountBalanceDto accountBalance,
  });

  @override
  $ServiceAddressDtoCopyWith<$Res> get serviceAddress;
  @override
  $AccountBalanceDtoCopyWith<$Res> get accountBalance;
}

/// @nodoc
class __$$CustomerAccountDetailDataDtoImplCopyWithImpl<$Res>
    extends
        _$CustomerAccountDetailDataDtoCopyWithImpl<
          $Res,
          _$CustomerAccountDetailDataDtoImpl
        >
    implements _$$CustomerAccountDetailDataDtoImplCopyWith<$Res> {
  __$$CustomerAccountDetailDataDtoImplCopyWithImpl(
    _$CustomerAccountDetailDataDtoImpl _value,
    $Res Function(_$CustomerAccountDetailDataDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? customerNumber = null,
    Object? serviceAddress = null,
    Object? name = null,
    Object? town = null,
    Object? accountStatus = null,
    Object? owner = null,
    Object? billCode = null,
    Object? meter = null,
    Object? emailAddress = null,
    Object? cell = null,
    Object? rating = freezed,
    Object? accountBalance = null,
  }) {
    return _then(
      _$CustomerAccountDetailDataDtoImpl(
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        customerNumber: null == customerNumber
            ? _value.customerNumber
            : customerNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceAddress: null == serviceAddress
            ? _value.serviceAddress
            : serviceAddress // ignore: cast_nullable_to_non_nullable
                  as ServiceAddressDto,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        town: null == town
            ? _value.town
            : town // ignore: cast_nullable_to_non_nullable
                  as String,
        accountStatus: null == accountStatus
            ? _value.accountStatus
            : accountStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        owner: null == owner
            ? _value.owner
            : owner // ignore: cast_nullable_to_non_nullable
                  as String,
        billCode: null == billCode
            ? _value.billCode
            : billCode // ignore: cast_nullable_to_non_nullable
                  as String,
        meter: null == meter
            ? _value.meter
            : meter // ignore: cast_nullable_to_non_nullable
                  as String,
        emailAddress: null == emailAddress
            ? _value.emailAddress
            : emailAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        cell: null == cell
            ? _value.cell
            : cell // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountBalance: null == accountBalance
            ? _value.accountBalance
            : accountBalance // ignore: cast_nullable_to_non_nullable
                  as AccountBalanceDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerAccountDetailDataDtoImpl
    implements _CustomerAccountDetailDataDto {
  const _$CustomerAccountDetailDataDtoImpl({
    required this.accountNumber,
    required this.customerNumber,
    required this.serviceAddress,
    required this.name,
    required this.town,
    required this.accountStatus,
    required this.owner,
    required this.billCode,
    required this.meter,
    required this.emailAddress,
    required this.cell,
    this.rating,
    required this.accountBalance,
  });

  factory _$CustomerAccountDetailDataDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CustomerAccountDetailDataDtoImplFromJson(json);

  @override
  final String accountNumber;
  @override
  final String customerNumber;
  @override
  final ServiceAddressDto serviceAddress;
  @override
  final String name;
  @override
  final String town;
  @override
  final String accountStatus;
  @override
  final String owner;
  @override
  final String billCode;
  @override
  final String meter;
  @override
  final String emailAddress;
  @override
  final String cell;
  @override
  final String? rating;
  @override
  final AccountBalanceDto accountBalance;

  @override
  String toString() {
    return 'CustomerAccountDetailDataDto(accountNumber: $accountNumber, customerNumber: $customerNumber, serviceAddress: $serviceAddress, name: $name, town: $town, accountStatus: $accountStatus, owner: $owner, billCode: $billCode, meter: $meter, emailAddress: $emailAddress, cell: $cell, rating: $rating, accountBalance: $accountBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerAccountDetailDataDtoImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber) &&
            (identical(other.serviceAddress, serviceAddress) ||
                other.serviceAddress == serviceAddress) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.accountStatus, accountStatus) ||
                other.accountStatus == accountStatus) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.billCode, billCode) ||
                other.billCode == billCode) &&
            (identical(other.meter, meter) || other.meter == meter) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.cell, cell) || other.cell == cell) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountNumber,
    customerNumber,
    serviceAddress,
    name,
    town,
    accountStatus,
    owner,
    billCode,
    meter,
    emailAddress,
    cell,
    rating,
    accountBalance,
  );

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerAccountDetailDataDtoImplCopyWith<
    _$CustomerAccountDetailDataDtoImpl
  >
  get copyWith =>
      __$$CustomerAccountDetailDataDtoImplCopyWithImpl<
        _$CustomerAccountDetailDataDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerAccountDetailDataDtoImplToJson(this);
  }
}

abstract class _CustomerAccountDetailDataDto
    implements CustomerAccountDetailDataDto {
  const factory _CustomerAccountDetailDataDto({
    required final String accountNumber,
    required final String customerNumber,
    required final ServiceAddressDto serviceAddress,
    required final String name,
    required final String town,
    required final String accountStatus,
    required final String owner,
    required final String billCode,
    required final String meter,
    required final String emailAddress,
    required final String cell,
    final String? rating,
    required final AccountBalanceDto accountBalance,
  }) = _$CustomerAccountDetailDataDtoImpl;

  factory _CustomerAccountDetailDataDto.fromJson(Map<String, dynamic> json) =
      _$CustomerAccountDetailDataDtoImpl.fromJson;

  @override
  String get accountNumber;
  @override
  String get customerNumber;
  @override
  ServiceAddressDto get serviceAddress;
  @override
  String get name;
  @override
  String get town;
  @override
  String get accountStatus;
  @override
  String get owner;
  @override
  String get billCode;
  @override
  String get meter;
  @override
  String get emailAddress;
  @override
  String get cell;
  @override
  String? get rating;
  @override
  AccountBalanceDto get accountBalance;

  /// Create a copy of CustomerAccountDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerAccountDetailDataDtoImplCopyWith<
    _$CustomerAccountDetailDataDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

ConnectCustomerAccountResponseDto _$ConnectCustomerAccountResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ConnectCustomerAccountResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ConnectCustomerAccountResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  EditableCustomerAccountDto get editableCustomerAccount =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectCustomerAccountResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectCustomerAccountResponseDtoCopyWith<ConnectCustomerAccountResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectCustomerAccountResponseDtoCopyWith<$Res> {
  factory $ConnectCustomerAccountResponseDtoCopyWith(
    ConnectCustomerAccountResponseDto value,
    $Res Function(ConnectCustomerAccountResponseDto) then,
  ) =
      _$ConnectCustomerAccountResponseDtoCopyWithImpl<
        $Res,
        ConnectCustomerAccountResponseDto
      >;
  @useResult
  $Res call({
    int status,
    String? message,
    EditableCustomerAccountDto editableCustomerAccount,
  });

  $EditableCustomerAccountDtoCopyWith<$Res> get editableCustomerAccount;
}

/// @nodoc
class _$ConnectCustomerAccountResponseDtoCopyWithImpl<
  $Res,
  $Val extends ConnectCustomerAccountResponseDto
>
    implements $ConnectCustomerAccountResponseDtoCopyWith<$Res> {
  _$ConnectCustomerAccountResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? editableCustomerAccount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            editableCustomerAccount: null == editableCustomerAccount
                ? _value.editableCustomerAccount
                : editableCustomerAccount // ignore: cast_nullable_to_non_nullable
                      as EditableCustomerAccountDto,
          )
          as $Val,
    );
  }

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EditableCustomerAccountDtoCopyWith<$Res> get editableCustomerAccount {
    return $EditableCustomerAccountDtoCopyWith<$Res>(
      _value.editableCustomerAccount,
      (value) {
        return _then(_value.copyWith(editableCustomerAccount: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$ConnectCustomerAccountResponseDtoImplCopyWith<$Res>
    implements $ConnectCustomerAccountResponseDtoCopyWith<$Res> {
  factory _$$ConnectCustomerAccountResponseDtoImplCopyWith(
    _$ConnectCustomerAccountResponseDtoImpl value,
    $Res Function(_$ConnectCustomerAccountResponseDtoImpl) then,
  ) = __$$ConnectCustomerAccountResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int status,
    String? message,
    EditableCustomerAccountDto editableCustomerAccount,
  });

  @override
  $EditableCustomerAccountDtoCopyWith<$Res> get editableCustomerAccount;
}

/// @nodoc
class __$$ConnectCustomerAccountResponseDtoImplCopyWithImpl<$Res>
    extends
        _$ConnectCustomerAccountResponseDtoCopyWithImpl<
          $Res,
          _$ConnectCustomerAccountResponseDtoImpl
        >
    implements _$$ConnectCustomerAccountResponseDtoImplCopyWith<$Res> {
  __$$ConnectCustomerAccountResponseDtoImplCopyWithImpl(
    _$ConnectCustomerAccountResponseDtoImpl _value,
    $Res Function(_$ConnectCustomerAccountResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? editableCustomerAccount = null,
  }) {
    return _then(
      _$ConnectCustomerAccountResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        editableCustomerAccount: null == editableCustomerAccount
            ? _value.editableCustomerAccount
            : editableCustomerAccount // ignore: cast_nullable_to_non_nullable
                  as EditableCustomerAccountDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectCustomerAccountResponseDtoImpl
    extends _ConnectCustomerAccountResponseDto {
  const _$ConnectCustomerAccountResponseDtoImpl({
    required this.status,
    this.message,
    required this.editableCustomerAccount,
  }) : super._();

  factory _$ConnectCustomerAccountResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ConnectCustomerAccountResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  @override
  final EditableCustomerAccountDto editableCustomerAccount;

  @override
  String toString() {
    return 'ConnectCustomerAccountResponseDto(status: $status, message: $message, editableCustomerAccount: $editableCustomerAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectCustomerAccountResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(
                  other.editableCustomerAccount,
                  editableCustomerAccount,
                ) ||
                other.editableCustomerAccount == editableCustomerAccount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, message, editableCustomerAccount);

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectCustomerAccountResponseDtoImplCopyWith<
    _$ConnectCustomerAccountResponseDtoImpl
  >
  get copyWith =>
      __$$ConnectCustomerAccountResponseDtoImplCopyWithImpl<
        _$ConnectCustomerAccountResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectCustomerAccountResponseDtoImplToJson(this);
  }
}

abstract class _ConnectCustomerAccountResponseDto
    extends ConnectCustomerAccountResponseDto {
  const factory _ConnectCustomerAccountResponseDto({
    required final int status,
    final String? message,
    required final EditableCustomerAccountDto editableCustomerAccount,
  }) = _$ConnectCustomerAccountResponseDtoImpl;
  const _ConnectCustomerAccountResponseDto._() : super._();

  factory _ConnectCustomerAccountResponseDto.fromJson(
    Map<String, dynamic> json,
  ) = _$ConnectCustomerAccountResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  EditableCustomerAccountDto get editableCustomerAccount;

  /// Create a copy of ConnectCustomerAccountResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectCustomerAccountResponseDtoImplCopyWith<
    _$ConnectCustomerAccountResponseDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

BillDetailResponseDto _$BillDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _BillDetailResponseDto.fromJson(json);
}

/// @nodoc
mixin _$BillDetailResponseDto {
  int get status => throw _privateConstructorUsedError;
  BillDetailDataDto get bill => throw _privateConstructorUsedError;

  /// Serializes this BillDetailResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillDetailResponseDtoCopyWith<BillDetailResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillDetailResponseDtoCopyWith<$Res> {
  factory $BillDetailResponseDtoCopyWith(
    BillDetailResponseDto value,
    $Res Function(BillDetailResponseDto) then,
  ) = _$BillDetailResponseDtoCopyWithImpl<$Res, BillDetailResponseDto>;
  @useResult
  $Res call({int status, BillDetailDataDto bill});

  $BillDetailDataDtoCopyWith<$Res> get bill;
}

/// @nodoc
class _$BillDetailResponseDtoCopyWithImpl<
  $Res,
  $Val extends BillDetailResponseDto
>
    implements $BillDetailResponseDtoCopyWith<$Res> {
  _$BillDetailResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? bill = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            bill: null == bill
                ? _value.bill
                : bill // ignore: cast_nullable_to_non_nullable
                      as BillDetailDataDto,
          )
          as $Val,
    );
  }

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillDetailDataDtoCopyWith<$Res> get bill {
    return $BillDetailDataDtoCopyWith<$Res>(_value.bill, (value) {
      return _then(_value.copyWith(bill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BillDetailResponseDtoImplCopyWith<$Res>
    implements $BillDetailResponseDtoCopyWith<$Res> {
  factory _$$BillDetailResponseDtoImplCopyWith(
    _$BillDetailResponseDtoImpl value,
    $Res Function(_$BillDetailResponseDtoImpl) then,
  ) = __$$BillDetailResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, BillDetailDataDto bill});

  @override
  $BillDetailDataDtoCopyWith<$Res> get bill;
}

/// @nodoc
class __$$BillDetailResponseDtoImplCopyWithImpl<$Res>
    extends
        _$BillDetailResponseDtoCopyWithImpl<$Res, _$BillDetailResponseDtoImpl>
    implements _$$BillDetailResponseDtoImplCopyWith<$Res> {
  __$$BillDetailResponseDtoImplCopyWithImpl(
    _$BillDetailResponseDtoImpl _value,
    $Res Function(_$BillDetailResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? bill = null}) {
    return _then(
      _$BillDetailResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        bill: null == bill
            ? _value.bill
            : bill // ignore: cast_nullable_to_non_nullable
                  as BillDetailDataDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillDetailResponseDtoImpl implements _BillDetailResponseDto {
  const _$BillDetailResponseDtoImpl({required this.status, required this.bill});

  factory _$BillDetailResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillDetailResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final BillDetailDataDto bill;

  @override
  String toString() {
    return 'BillDetailResponseDto(status: $status, bill: $bill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillDetailResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bill, bill) || other.bill == bill));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, bill);

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillDetailResponseDtoImplCopyWith<_$BillDetailResponseDtoImpl>
  get copyWith =>
      __$$BillDetailResponseDtoImplCopyWithImpl<_$BillDetailResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BillDetailResponseDtoImplToJson(this);
  }
}

abstract class _BillDetailResponseDto implements BillDetailResponseDto {
  const factory _BillDetailResponseDto({
    required final int status,
    required final BillDetailDataDto bill,
  }) = _$BillDetailResponseDtoImpl;

  factory _BillDetailResponseDto.fromJson(Map<String, dynamic> json) =
      _$BillDetailResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  BillDetailDataDto get bill;

  /// Create a copy of BillDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillDetailResponseDtoImplCopyWith<_$BillDetailResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BillDetailDataDto _$BillDetailDataDtoFromJson(Map<String, dynamic> json) {
  return _BillDetailDataDto.fromJson(json);
}

/// @nodoc
mixin _$BillDetailDataDto {
  String get billNumber => throw _privateConstructorUsedError;
  String get readingDate => throw _privateConstructorUsedError;
  String get billingDate => throw _privateConstructorUsedError;
  String get previousBalance => throw _privateConstructorUsedError;
  String get lessPayment => throw _privateConstructorUsedError;
  String get balanceForward => throw _privateConstructorUsedError;
  String get consumption => throw _privateConstructorUsedError;
  String get minimumBill => throw _privateConstructorUsedError;
  String get crimeStoppersPledge => throw _privateConstructorUsedError;
  String get otherCharge => throw _privateConstructorUsedError;
  String get gstCharge => throw _privateConstructorUsedError;
  String get taxAdjustment => throw _privateConstructorUsedError;
  String get amountDue => throw _privateConstructorUsedError;
  String get balance => throw _privateConstructorUsedError;
  String get paymentDueDate => throw _privateConstructorUsedError;
  String get previousReading => throw _privateConstructorUsedError;
  String get presentReading => throw _privateConstructorUsedError;
  String get totalConsumption => throw _privateConstructorUsedError;
  String get dueIn => throw _privateConstructorUsedError;
  bool get paid => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get customerNumber => throw _privateConstructorUsedError;

  /// Serializes this BillDetailDataDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillDetailDataDtoCopyWith<BillDetailDataDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillDetailDataDtoCopyWith<$Res> {
  factory $BillDetailDataDtoCopyWith(
    BillDetailDataDto value,
    $Res Function(BillDetailDataDto) then,
  ) = _$BillDetailDataDtoCopyWithImpl<$Res, BillDetailDataDto>;
  @useResult
  $Res call({
    String billNumber,
    String readingDate,
    String billingDate,
    String previousBalance,
    String lessPayment,
    String balanceForward,
    String consumption,
    String minimumBill,
    String crimeStoppersPledge,
    String otherCharge,
    String gstCharge,
    String taxAdjustment,
    String amountDue,
    String balance,
    String paymentDueDate,
    String previousReading,
    String presentReading,
    String totalConsumption,
    String dueIn,
    bool paid,
    String customerName,
    String accountNumber,
    String customerNumber,
  });
}

/// @nodoc
class _$BillDetailDataDtoCopyWithImpl<$Res, $Val extends BillDetailDataDto>
    implements $BillDetailDataDtoCopyWith<$Res> {
  _$BillDetailDataDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billNumber = null,
    Object? readingDate = null,
    Object? billingDate = null,
    Object? previousBalance = null,
    Object? lessPayment = null,
    Object? balanceForward = null,
    Object? consumption = null,
    Object? minimumBill = null,
    Object? crimeStoppersPledge = null,
    Object? otherCharge = null,
    Object? gstCharge = null,
    Object? taxAdjustment = null,
    Object? amountDue = null,
    Object? balance = null,
    Object? paymentDueDate = null,
    Object? previousReading = null,
    Object? presentReading = null,
    Object? totalConsumption = null,
    Object? dueIn = null,
    Object? paid = null,
    Object? customerName = null,
    Object? accountNumber = null,
    Object? customerNumber = null,
  }) {
    return _then(
      _value.copyWith(
            billNumber: null == billNumber
                ? _value.billNumber
                : billNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            readingDate: null == readingDate
                ? _value.readingDate
                : readingDate // ignore: cast_nullable_to_non_nullable
                      as String,
            billingDate: null == billingDate
                ? _value.billingDate
                : billingDate // ignore: cast_nullable_to_non_nullable
                      as String,
            previousBalance: null == previousBalance
                ? _value.previousBalance
                : previousBalance // ignore: cast_nullable_to_non_nullable
                      as String,
            lessPayment: null == lessPayment
                ? _value.lessPayment
                : lessPayment // ignore: cast_nullable_to_non_nullable
                      as String,
            balanceForward: null == balanceForward
                ? _value.balanceForward
                : balanceForward // ignore: cast_nullable_to_non_nullable
                      as String,
            consumption: null == consumption
                ? _value.consumption
                : consumption // ignore: cast_nullable_to_non_nullable
                      as String,
            minimumBill: null == minimumBill
                ? _value.minimumBill
                : minimumBill // ignore: cast_nullable_to_non_nullable
                      as String,
            crimeStoppersPledge: null == crimeStoppersPledge
                ? _value.crimeStoppersPledge
                : crimeStoppersPledge // ignore: cast_nullable_to_non_nullable
                      as String,
            otherCharge: null == otherCharge
                ? _value.otherCharge
                : otherCharge // ignore: cast_nullable_to_non_nullable
                      as String,
            gstCharge: null == gstCharge
                ? _value.gstCharge
                : gstCharge // ignore: cast_nullable_to_non_nullable
                      as String,
            taxAdjustment: null == taxAdjustment
                ? _value.taxAdjustment
                : taxAdjustment // ignore: cast_nullable_to_non_nullable
                      as String,
            amountDue: null == amountDue
                ? _value.amountDue
                : amountDue // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentDueDate: null == paymentDueDate
                ? _value.paymentDueDate
                : paymentDueDate // ignore: cast_nullable_to_non_nullable
                      as String,
            previousReading: null == previousReading
                ? _value.previousReading
                : previousReading // ignore: cast_nullable_to_non_nullable
                      as String,
            presentReading: null == presentReading
                ? _value.presentReading
                : presentReading // ignore: cast_nullable_to_non_nullable
                      as String,
            totalConsumption: null == totalConsumption
                ? _value.totalConsumption
                : totalConsumption // ignore: cast_nullable_to_non_nullable
                      as String,
            dueIn: null == dueIn
                ? _value.dueIn
                : dueIn // ignore: cast_nullable_to_non_nullable
                      as String,
            paid: null == paid
                ? _value.paid
                : paid // ignore: cast_nullable_to_non_nullable
                      as bool,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            customerNumber: null == customerNumber
                ? _value.customerNumber
                : customerNumber // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillDetailDataDtoImplCopyWith<$Res>
    implements $BillDetailDataDtoCopyWith<$Res> {
  factory _$$BillDetailDataDtoImplCopyWith(
    _$BillDetailDataDtoImpl value,
    $Res Function(_$BillDetailDataDtoImpl) then,
  ) = __$$BillDetailDataDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String billNumber,
    String readingDate,
    String billingDate,
    String previousBalance,
    String lessPayment,
    String balanceForward,
    String consumption,
    String minimumBill,
    String crimeStoppersPledge,
    String otherCharge,
    String gstCharge,
    String taxAdjustment,
    String amountDue,
    String balance,
    String paymentDueDate,
    String previousReading,
    String presentReading,
    String totalConsumption,
    String dueIn,
    bool paid,
    String customerName,
    String accountNumber,
    String customerNumber,
  });
}

/// @nodoc
class __$$BillDetailDataDtoImplCopyWithImpl<$Res>
    extends _$BillDetailDataDtoCopyWithImpl<$Res, _$BillDetailDataDtoImpl>
    implements _$$BillDetailDataDtoImplCopyWith<$Res> {
  __$$BillDetailDataDtoImplCopyWithImpl(
    _$BillDetailDataDtoImpl _value,
    $Res Function(_$BillDetailDataDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billNumber = null,
    Object? readingDate = null,
    Object? billingDate = null,
    Object? previousBalance = null,
    Object? lessPayment = null,
    Object? balanceForward = null,
    Object? consumption = null,
    Object? minimumBill = null,
    Object? crimeStoppersPledge = null,
    Object? otherCharge = null,
    Object? gstCharge = null,
    Object? taxAdjustment = null,
    Object? amountDue = null,
    Object? balance = null,
    Object? paymentDueDate = null,
    Object? previousReading = null,
    Object? presentReading = null,
    Object? totalConsumption = null,
    Object? dueIn = null,
    Object? paid = null,
    Object? customerName = null,
    Object? accountNumber = null,
    Object? customerNumber = null,
  }) {
    return _then(
      _$BillDetailDataDtoImpl(
        billNumber: null == billNumber
            ? _value.billNumber
            : billNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        readingDate: null == readingDate
            ? _value.readingDate
            : readingDate // ignore: cast_nullable_to_non_nullable
                  as String,
        billingDate: null == billingDate
            ? _value.billingDate
            : billingDate // ignore: cast_nullable_to_non_nullable
                  as String,
        previousBalance: null == previousBalance
            ? _value.previousBalance
            : previousBalance // ignore: cast_nullable_to_non_nullable
                  as String,
        lessPayment: null == lessPayment
            ? _value.lessPayment
            : lessPayment // ignore: cast_nullable_to_non_nullable
                  as String,
        balanceForward: null == balanceForward
            ? _value.balanceForward
            : balanceForward // ignore: cast_nullable_to_non_nullable
                  as String,
        consumption: null == consumption
            ? _value.consumption
            : consumption // ignore: cast_nullable_to_non_nullable
                  as String,
        minimumBill: null == minimumBill
            ? _value.minimumBill
            : minimumBill // ignore: cast_nullable_to_non_nullable
                  as String,
        crimeStoppersPledge: null == crimeStoppersPledge
            ? _value.crimeStoppersPledge
            : crimeStoppersPledge // ignore: cast_nullable_to_non_nullable
                  as String,
        otherCharge: null == otherCharge
            ? _value.otherCharge
            : otherCharge // ignore: cast_nullable_to_non_nullable
                  as String,
        gstCharge: null == gstCharge
            ? _value.gstCharge
            : gstCharge // ignore: cast_nullable_to_non_nullable
                  as String,
        taxAdjustment: null == taxAdjustment
            ? _value.taxAdjustment
            : taxAdjustment // ignore: cast_nullable_to_non_nullable
                  as String,
        amountDue: null == amountDue
            ? _value.amountDue
            : amountDue // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentDueDate: null == paymentDueDate
            ? _value.paymentDueDate
            : paymentDueDate // ignore: cast_nullable_to_non_nullable
                  as String,
        previousReading: null == previousReading
            ? _value.previousReading
            : previousReading // ignore: cast_nullable_to_non_nullable
                  as String,
        presentReading: null == presentReading
            ? _value.presentReading
            : presentReading // ignore: cast_nullable_to_non_nullable
                  as String,
        totalConsumption: null == totalConsumption
            ? _value.totalConsumption
            : totalConsumption // ignore: cast_nullable_to_non_nullable
                  as String,
        dueIn: null == dueIn
            ? _value.dueIn
            : dueIn // ignore: cast_nullable_to_non_nullable
                  as String,
        paid: null == paid
            ? _value.paid
            : paid // ignore: cast_nullable_to_non_nullable
                  as bool,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        customerNumber: null == customerNumber
            ? _value.customerNumber
            : customerNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillDetailDataDtoImpl implements _BillDetailDataDto {
  const _$BillDetailDataDtoImpl({
    required this.billNumber,
    required this.readingDate,
    required this.billingDate,
    required this.previousBalance,
    required this.lessPayment,
    required this.balanceForward,
    required this.consumption,
    required this.minimumBill,
    required this.crimeStoppersPledge,
    required this.otherCharge,
    required this.gstCharge,
    required this.taxAdjustment,
    required this.amountDue,
    required this.balance,
    required this.paymentDueDate,
    required this.previousReading,
    required this.presentReading,
    required this.totalConsumption,
    required this.dueIn,
    required this.paid,
    required this.customerName,
    required this.accountNumber,
    required this.customerNumber,
  });

  factory _$BillDetailDataDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillDetailDataDtoImplFromJson(json);

  @override
  final String billNumber;
  @override
  final String readingDate;
  @override
  final String billingDate;
  @override
  final String previousBalance;
  @override
  final String lessPayment;
  @override
  final String balanceForward;
  @override
  final String consumption;
  @override
  final String minimumBill;
  @override
  final String crimeStoppersPledge;
  @override
  final String otherCharge;
  @override
  final String gstCharge;
  @override
  final String taxAdjustment;
  @override
  final String amountDue;
  @override
  final String balance;
  @override
  final String paymentDueDate;
  @override
  final String previousReading;
  @override
  final String presentReading;
  @override
  final String totalConsumption;
  @override
  final String dueIn;
  @override
  final bool paid;
  @override
  final String customerName;
  @override
  final String accountNumber;
  @override
  final String customerNumber;

  @override
  String toString() {
    return 'BillDetailDataDto(billNumber: $billNumber, readingDate: $readingDate, billingDate: $billingDate, previousBalance: $previousBalance, lessPayment: $lessPayment, balanceForward: $balanceForward, consumption: $consumption, minimumBill: $minimumBill, crimeStoppersPledge: $crimeStoppersPledge, otherCharge: $otherCharge, gstCharge: $gstCharge, taxAdjustment: $taxAdjustment, amountDue: $amountDue, balance: $balance, paymentDueDate: $paymentDueDate, previousReading: $previousReading, presentReading: $presentReading, totalConsumption: $totalConsumption, dueIn: $dueIn, paid: $paid, customerName: $customerName, accountNumber: $accountNumber, customerNumber: $customerNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillDetailDataDtoImpl &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.readingDate, readingDate) ||
                other.readingDate == readingDate) &&
            (identical(other.billingDate, billingDate) ||
                other.billingDate == billingDate) &&
            (identical(other.previousBalance, previousBalance) ||
                other.previousBalance == previousBalance) &&
            (identical(other.lessPayment, lessPayment) ||
                other.lessPayment == lessPayment) &&
            (identical(other.balanceForward, balanceForward) ||
                other.balanceForward == balanceForward) &&
            (identical(other.consumption, consumption) ||
                other.consumption == consumption) &&
            (identical(other.minimumBill, minimumBill) ||
                other.minimumBill == minimumBill) &&
            (identical(other.crimeStoppersPledge, crimeStoppersPledge) ||
                other.crimeStoppersPledge == crimeStoppersPledge) &&
            (identical(other.otherCharge, otherCharge) ||
                other.otherCharge == otherCharge) &&
            (identical(other.gstCharge, gstCharge) ||
                other.gstCharge == gstCharge) &&
            (identical(other.taxAdjustment, taxAdjustment) ||
                other.taxAdjustment == taxAdjustment) &&
            (identical(other.amountDue, amountDue) ||
                other.amountDue == amountDue) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.paymentDueDate, paymentDueDate) ||
                other.paymentDueDate == paymentDueDate) &&
            (identical(other.previousReading, previousReading) ||
                other.previousReading == previousReading) &&
            (identical(other.presentReading, presentReading) ||
                other.presentReading == presentReading) &&
            (identical(other.totalConsumption, totalConsumption) ||
                other.totalConsumption == totalConsumption) &&
            (identical(other.dueIn, dueIn) || other.dueIn == dueIn) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    billNumber,
    readingDate,
    billingDate,
    previousBalance,
    lessPayment,
    balanceForward,
    consumption,
    minimumBill,
    crimeStoppersPledge,
    otherCharge,
    gstCharge,
    taxAdjustment,
    amountDue,
    balance,
    paymentDueDate,
    previousReading,
    presentReading,
    totalConsumption,
    dueIn,
    paid,
    customerName,
    accountNumber,
    customerNumber,
  ]);

  /// Create a copy of BillDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillDetailDataDtoImplCopyWith<_$BillDetailDataDtoImpl> get copyWith =>
      __$$BillDetailDataDtoImplCopyWithImpl<_$BillDetailDataDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BillDetailDataDtoImplToJson(this);
  }
}

abstract class _BillDetailDataDto implements BillDetailDataDto {
  const factory _BillDetailDataDto({
    required final String billNumber,
    required final String readingDate,
    required final String billingDate,
    required final String previousBalance,
    required final String lessPayment,
    required final String balanceForward,
    required final String consumption,
    required final String minimumBill,
    required final String crimeStoppersPledge,
    required final String otherCharge,
    required final String gstCharge,
    required final String taxAdjustment,
    required final String amountDue,
    required final String balance,
    required final String paymentDueDate,
    required final String previousReading,
    required final String presentReading,
    required final String totalConsumption,
    required final String dueIn,
    required final bool paid,
    required final String customerName,
    required final String accountNumber,
    required final String customerNumber,
  }) = _$BillDetailDataDtoImpl;

  factory _BillDetailDataDto.fromJson(Map<String, dynamic> json) =
      _$BillDetailDataDtoImpl.fromJson;

  @override
  String get billNumber;
  @override
  String get readingDate;
  @override
  String get billingDate;
  @override
  String get previousBalance;
  @override
  String get lessPayment;
  @override
  String get balanceForward;
  @override
  String get consumption;
  @override
  String get minimumBill;
  @override
  String get crimeStoppersPledge;
  @override
  String get otherCharge;
  @override
  String get gstCharge;
  @override
  String get taxAdjustment;
  @override
  String get amountDue;
  @override
  String get balance;
  @override
  String get paymentDueDate;
  @override
  String get previousReading;
  @override
  String get presentReading;
  @override
  String get totalConsumption;
  @override
  String get dueIn;
  @override
  bool get paid;
  @override
  String get customerName;
  @override
  String get accountNumber;
  @override
  String get customerNumber;

  /// Create a copy of BillDetailDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillDetailDataDtoImplCopyWith<_$BillDetailDataDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillDownloadUrlResponseDto _$BillDownloadUrlResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _BillDownloadUrlResponseDto.fromJson(json);
}

/// @nodoc
mixin _$BillDownloadUrlResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BillDownloadUrlResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillDownloadUrlResponseDtoCopyWith<BillDownloadUrlResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillDownloadUrlResponseDtoCopyWith<$Res> {
  factory $BillDownloadUrlResponseDtoCopyWith(
    BillDownloadUrlResponseDto value,
    $Res Function(BillDownloadUrlResponseDto) then,
  ) =
      _$BillDownloadUrlResponseDtoCopyWithImpl<
        $Res,
        BillDownloadUrlResponseDto
      >;
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class _$BillDownloadUrlResponseDtoCopyWithImpl<
  $Res,
  $Val extends BillDownloadUrlResponseDto
>
    implements $BillDownloadUrlResponseDtoCopyWith<$Res> {
  _$BillDownloadUrlResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillDownloadUrlResponseDtoImplCopyWith<$Res>
    implements $BillDownloadUrlResponseDtoCopyWith<$Res> {
  factory _$$BillDownloadUrlResponseDtoImplCopyWith(
    _$BillDownloadUrlResponseDtoImpl value,
    $Res Function(_$BillDownloadUrlResponseDtoImpl) then,
  ) = __$$BillDownloadUrlResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class __$$BillDownloadUrlResponseDtoImplCopyWithImpl<$Res>
    extends
        _$BillDownloadUrlResponseDtoCopyWithImpl<
          $Res,
          _$BillDownloadUrlResponseDtoImpl
        >
    implements _$$BillDownloadUrlResponseDtoImplCopyWith<$Res> {
  __$$BillDownloadUrlResponseDtoImplCopyWithImpl(
    _$BillDownloadUrlResponseDtoImpl _value,
    $Res Function(_$BillDownloadUrlResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _$BillDownloadUrlResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillDownloadUrlResponseDtoImpl implements _BillDownloadUrlResponseDto {
  const _$BillDownloadUrlResponseDtoImpl({required this.status, this.message});

  factory _$BillDownloadUrlResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$BillDownloadUrlResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;

  @override
  String toString() {
    return 'BillDownloadUrlResponseDto(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillDownloadUrlResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of BillDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillDownloadUrlResponseDtoImplCopyWith<_$BillDownloadUrlResponseDtoImpl>
  get copyWith =>
      __$$BillDownloadUrlResponseDtoImplCopyWithImpl<
        _$BillDownloadUrlResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillDownloadUrlResponseDtoImplToJson(this);
  }
}

abstract class _BillDownloadUrlResponseDto
    implements BillDownloadUrlResponseDto {
  const factory _BillDownloadUrlResponseDto({
    required final int status,
    final String? message,
  }) = _$BillDownloadUrlResponseDtoImpl;

  factory _BillDownloadUrlResponseDto.fromJson(Map<String, dynamic> json) =
      _$BillDownloadUrlResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;

  /// Create a copy of BillDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillDownloadUrlResponseDtoImplCopyWith<_$BillDownloadUrlResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PaymentInformationDto _$PaymentInformationDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PaymentInformationDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentInformationDto {
  String get customerNumber => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get paymentAmount => throw _privateConstructorUsedError;
  String get paymentDate => throw _privateConstructorUsedError;
  String get receiptNumber => throw _privateConstructorUsedError;
  String get outstandingBalance => throw _privateConstructorUsedError;
  String? get outstandingBalanceType => throw _privateConstructorUsedError;
  String get updatedDate => throw _privateConstructorUsedError;
  String? get fileUrlLocation => throw _privateConstructorUsedError;

  /// Serializes this PaymentInformationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentInformationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentInformationDtoCopyWith<PaymentInformationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentInformationDtoCopyWith<$Res> {
  factory $PaymentInformationDtoCopyWith(
    PaymentInformationDto value,
    $Res Function(PaymentInformationDto) then,
  ) = _$PaymentInformationDtoCopyWithImpl<$Res, PaymentInformationDto>;
  @useResult
  $Res call({
    String customerNumber,
    String accountNumber,
    String customerName,
    String paymentAmount,
    String paymentDate,
    String receiptNumber,
    String outstandingBalance,
    String? outstandingBalanceType,
    String updatedDate,
    String? fileUrlLocation,
  });
}

/// @nodoc
class _$PaymentInformationDtoCopyWithImpl<
  $Res,
  $Val extends PaymentInformationDto
>
    implements $PaymentInformationDtoCopyWith<$Res> {
  _$PaymentInformationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentInformationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerNumber = null,
    Object? accountNumber = null,
    Object? customerName = null,
    Object? paymentAmount = null,
    Object? paymentDate = null,
    Object? receiptNumber = null,
    Object? outstandingBalance = null,
    Object? outstandingBalanceType = freezed,
    Object? updatedDate = null,
    Object? fileUrlLocation = freezed,
  }) {
    return _then(
      _value.copyWith(
            customerNumber: null == customerNumber
                ? _value.customerNumber
                : customerNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            customerName: null == customerName
                ? _value.customerName
                : customerName // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentAmount: null == paymentAmount
                ? _value.paymentAmount
                : paymentAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentDate: null == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                      as String,
            receiptNumber: null == receiptNumber
                ? _value.receiptNumber
                : receiptNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            outstandingBalance: null == outstandingBalance
                ? _value.outstandingBalance
                : outstandingBalance // ignore: cast_nullable_to_non_nullable
                      as String,
            outstandingBalanceType: freezed == outstandingBalanceType
                ? _value.outstandingBalanceType
                : outstandingBalanceType // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedDate: null == updatedDate
                ? _value.updatedDate
                : updatedDate // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrlLocation: freezed == fileUrlLocation
                ? _value.fileUrlLocation
                : fileUrlLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentInformationDtoImplCopyWith<$Res>
    implements $PaymentInformationDtoCopyWith<$Res> {
  factory _$$PaymentInformationDtoImplCopyWith(
    _$PaymentInformationDtoImpl value,
    $Res Function(_$PaymentInformationDtoImpl) then,
  ) = __$$PaymentInformationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String customerNumber,
    String accountNumber,
    String customerName,
    String paymentAmount,
    String paymentDate,
    String receiptNumber,
    String outstandingBalance,
    String? outstandingBalanceType,
    String updatedDate,
    String? fileUrlLocation,
  });
}

/// @nodoc
class __$$PaymentInformationDtoImplCopyWithImpl<$Res>
    extends
        _$PaymentInformationDtoCopyWithImpl<$Res, _$PaymentInformationDtoImpl>
    implements _$$PaymentInformationDtoImplCopyWith<$Res> {
  __$$PaymentInformationDtoImplCopyWithImpl(
    _$PaymentInformationDtoImpl _value,
    $Res Function(_$PaymentInformationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentInformationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerNumber = null,
    Object? accountNumber = null,
    Object? customerName = null,
    Object? paymentAmount = null,
    Object? paymentDate = null,
    Object? receiptNumber = null,
    Object? outstandingBalance = null,
    Object? outstandingBalanceType = freezed,
    Object? updatedDate = null,
    Object? fileUrlLocation = freezed,
  }) {
    return _then(
      _$PaymentInformationDtoImpl(
        customerNumber: null == customerNumber
            ? _value.customerNumber
            : customerNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        customerName: null == customerName
            ? _value.customerName
            : customerName // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentAmount: null == paymentAmount
            ? _value.paymentAmount
            : paymentAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentDate: null == paymentDate
            ? _value.paymentDate
            : paymentDate // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptNumber: null == receiptNumber
            ? _value.receiptNumber
            : receiptNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        outstandingBalance: null == outstandingBalance
            ? _value.outstandingBalance
            : outstandingBalance // ignore: cast_nullable_to_non_nullable
                  as String,
        outstandingBalanceType: freezed == outstandingBalanceType
            ? _value.outstandingBalanceType
            : outstandingBalanceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedDate: null == updatedDate
            ? _value.updatedDate
            : updatedDate // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrlLocation: freezed == fileUrlLocation
            ? _value.fileUrlLocation
            : fileUrlLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentInformationDtoImpl implements _PaymentInformationDto {
  const _$PaymentInformationDtoImpl({
    required this.customerNumber,
    required this.accountNumber,
    required this.customerName,
    required this.paymentAmount,
    required this.paymentDate,
    required this.receiptNumber,
    required this.outstandingBalance,
    this.outstandingBalanceType,
    required this.updatedDate,
    this.fileUrlLocation,
  });

  factory _$PaymentInformationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentInformationDtoImplFromJson(json);

  @override
  final String customerNumber;
  @override
  final String accountNumber;
  @override
  final String customerName;
  @override
  final String paymentAmount;
  @override
  final String paymentDate;
  @override
  final String receiptNumber;
  @override
  final String outstandingBalance;
  @override
  final String? outstandingBalanceType;
  @override
  final String updatedDate;
  @override
  final String? fileUrlLocation;

  @override
  String toString() {
    return 'PaymentInformationDto(customerNumber: $customerNumber, accountNumber: $accountNumber, customerName: $customerName, paymentAmount: $paymentAmount, paymentDate: $paymentDate, receiptNumber: $receiptNumber, outstandingBalance: $outstandingBalance, outstandingBalanceType: $outstandingBalanceType, updatedDate: $updatedDate, fileUrlLocation: $fileUrlLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentInformationDtoImpl &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.outstandingBalance, outstandingBalance) ||
                other.outstandingBalance == outstandingBalance) &&
            (identical(other.outstandingBalanceType, outstandingBalanceType) ||
                other.outstandingBalanceType == outstandingBalanceType) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.fileUrlLocation, fileUrlLocation) ||
                other.fileUrlLocation == fileUrlLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerNumber,
    accountNumber,
    customerName,
    paymentAmount,
    paymentDate,
    receiptNumber,
    outstandingBalance,
    outstandingBalanceType,
    updatedDate,
    fileUrlLocation,
  );

  /// Create a copy of PaymentInformationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentInformationDtoImplCopyWith<_$PaymentInformationDtoImpl>
  get copyWith =>
      __$$PaymentInformationDtoImplCopyWithImpl<_$PaymentInformationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentInformationDtoImplToJson(this);
  }
}

abstract class _PaymentInformationDto implements PaymentInformationDto {
  const factory _PaymentInformationDto({
    required final String customerNumber,
    required final String accountNumber,
    required final String customerName,
    required final String paymentAmount,
    required final String paymentDate,
    required final String receiptNumber,
    required final String outstandingBalance,
    final String? outstandingBalanceType,
    required final String updatedDate,
    final String? fileUrlLocation,
  }) = _$PaymentInformationDtoImpl;

  factory _PaymentInformationDto.fromJson(Map<String, dynamic> json) =
      _$PaymentInformationDtoImpl.fromJson;

  @override
  String get customerNumber;
  @override
  String get accountNumber;
  @override
  String get customerName;
  @override
  String get paymentAmount;
  @override
  String get paymentDate;
  @override
  String get receiptNumber;
  @override
  String get outstandingBalance;
  @override
  String? get outstandingBalanceType;
  @override
  String get updatedDate;
  @override
  String? get fileUrlLocation;

  /// Create a copy of PaymentInformationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentInformationDtoImplCopyWith<_$PaymentInformationDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ReceiptDetailResponseDto _$ReceiptDetailResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ReceiptDetailResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ReceiptDetailResponseDto {
  int get status => throw _privateConstructorUsedError;
  PaymentInformationDto get paymentInformation =>
      throw _privateConstructorUsedError;

  /// Serializes this ReceiptDetailResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptDetailResponseDtoCopyWith<ReceiptDetailResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptDetailResponseDtoCopyWith<$Res> {
  factory $ReceiptDetailResponseDtoCopyWith(
    ReceiptDetailResponseDto value,
    $Res Function(ReceiptDetailResponseDto) then,
  ) = _$ReceiptDetailResponseDtoCopyWithImpl<$Res, ReceiptDetailResponseDto>;
  @useResult
  $Res call({int status, PaymentInformationDto paymentInformation});

  $PaymentInformationDtoCopyWith<$Res> get paymentInformation;
}

/// @nodoc
class _$ReceiptDetailResponseDtoCopyWithImpl<
  $Res,
  $Val extends ReceiptDetailResponseDto
>
    implements $ReceiptDetailResponseDtoCopyWith<$Res> {
  _$ReceiptDetailResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? paymentInformation = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentInformation: null == paymentInformation
                ? _value.paymentInformation
                : paymentInformation // ignore: cast_nullable_to_non_nullable
                      as PaymentInformationDto,
          )
          as $Val,
    );
  }

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentInformationDtoCopyWith<$Res> get paymentInformation {
    return $PaymentInformationDtoCopyWith<$Res>(_value.paymentInformation, (
      value,
    ) {
      return _then(_value.copyWith(paymentInformation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReceiptDetailResponseDtoImplCopyWith<$Res>
    implements $ReceiptDetailResponseDtoCopyWith<$Res> {
  factory _$$ReceiptDetailResponseDtoImplCopyWith(
    _$ReceiptDetailResponseDtoImpl value,
    $Res Function(_$ReceiptDetailResponseDtoImpl) then,
  ) = __$$ReceiptDetailResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, PaymentInformationDto paymentInformation});

  @override
  $PaymentInformationDtoCopyWith<$Res> get paymentInformation;
}

/// @nodoc
class __$$ReceiptDetailResponseDtoImplCopyWithImpl<$Res>
    extends
        _$ReceiptDetailResponseDtoCopyWithImpl<
          $Res,
          _$ReceiptDetailResponseDtoImpl
        >
    implements _$$ReceiptDetailResponseDtoImplCopyWith<$Res> {
  __$$ReceiptDetailResponseDtoImplCopyWithImpl(
    _$ReceiptDetailResponseDtoImpl _value,
    $Res Function(_$ReceiptDetailResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? paymentInformation = null}) {
    return _then(
      _$ReceiptDetailResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentInformation: null == paymentInformation
            ? _value.paymentInformation
            : paymentInformation // ignore: cast_nullable_to_non_nullable
                  as PaymentInformationDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptDetailResponseDtoImpl implements _ReceiptDetailResponseDto {
  const _$ReceiptDetailResponseDtoImpl({
    required this.status,
    required this.paymentInformation,
  });

  factory _$ReceiptDetailResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptDetailResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final PaymentInformationDto paymentInformation;

  @override
  String toString() {
    return 'ReceiptDetailResponseDto(status: $status, paymentInformation: $paymentInformation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptDetailResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentInformation, paymentInformation) ||
                other.paymentInformation == paymentInformation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, paymentInformation);

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptDetailResponseDtoImplCopyWith<_$ReceiptDetailResponseDtoImpl>
  get copyWith =>
      __$$ReceiptDetailResponseDtoImplCopyWithImpl<
        _$ReceiptDetailResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptDetailResponseDtoImplToJson(this);
  }
}

abstract class _ReceiptDetailResponseDto implements ReceiptDetailResponseDto {
  const factory _ReceiptDetailResponseDto({
    required final int status,
    required final PaymentInformationDto paymentInformation,
  }) = _$ReceiptDetailResponseDtoImpl;

  factory _ReceiptDetailResponseDto.fromJson(Map<String, dynamic> json) =
      _$ReceiptDetailResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  PaymentInformationDto get paymentInformation;

  /// Create a copy of ReceiptDetailResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptDetailResponseDtoImplCopyWith<_$ReceiptDetailResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ReceiptDownloadUrlResponseDto _$ReceiptDownloadUrlResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _ReceiptDownloadUrlResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ReceiptDownloadUrlResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ReceiptDownloadUrlResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptDownloadUrlResponseDtoCopyWith<ReceiptDownloadUrlResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptDownloadUrlResponseDtoCopyWith<$Res> {
  factory $ReceiptDownloadUrlResponseDtoCopyWith(
    ReceiptDownloadUrlResponseDto value,
    $Res Function(ReceiptDownloadUrlResponseDto) then,
  ) =
      _$ReceiptDownloadUrlResponseDtoCopyWithImpl<
        $Res,
        ReceiptDownloadUrlResponseDto
      >;
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class _$ReceiptDownloadUrlResponseDtoCopyWithImpl<
  $Res,
  $Val extends ReceiptDownloadUrlResponseDto
>
    implements $ReceiptDownloadUrlResponseDtoCopyWith<$Res> {
  _$ReceiptDownloadUrlResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReceiptDownloadUrlResponseDtoImplCopyWith<$Res>
    implements $ReceiptDownloadUrlResponseDtoCopyWith<$Res> {
  factory _$$ReceiptDownloadUrlResponseDtoImplCopyWith(
    _$ReceiptDownloadUrlResponseDtoImpl value,
    $Res Function(_$ReceiptDownloadUrlResponseDtoImpl) then,
  ) = __$$ReceiptDownloadUrlResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message});
}

/// @nodoc
class __$$ReceiptDownloadUrlResponseDtoImplCopyWithImpl<$Res>
    extends
        _$ReceiptDownloadUrlResponseDtoCopyWithImpl<
          $Res,
          _$ReceiptDownloadUrlResponseDtoImpl
        >
    implements _$$ReceiptDownloadUrlResponseDtoImplCopyWith<$Res> {
  __$$ReceiptDownloadUrlResponseDtoImplCopyWithImpl(
    _$ReceiptDownloadUrlResponseDtoImpl _value,
    $Res Function(_$ReceiptDownloadUrlResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReceiptDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? message = freezed}) {
    return _then(
      _$ReceiptDownloadUrlResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptDownloadUrlResponseDtoImpl
    implements _ReceiptDownloadUrlResponseDto {
  const _$ReceiptDownloadUrlResponseDtoImpl({
    required this.status,
    this.message,
  });

  factory _$ReceiptDownloadUrlResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ReceiptDownloadUrlResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;

  @override
  String toString() {
    return 'ReceiptDownloadUrlResponseDto(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptDownloadUrlResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of ReceiptDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptDownloadUrlResponseDtoImplCopyWith<
    _$ReceiptDownloadUrlResponseDtoImpl
  >
  get copyWith =>
      __$$ReceiptDownloadUrlResponseDtoImplCopyWithImpl<
        _$ReceiptDownloadUrlResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptDownloadUrlResponseDtoImplToJson(this);
  }
}

abstract class _ReceiptDownloadUrlResponseDto
    implements ReceiptDownloadUrlResponseDto {
  const factory _ReceiptDownloadUrlResponseDto({
    required final int status,
    final String? message,
  }) = _$ReceiptDownloadUrlResponseDtoImpl;

  factory _ReceiptDownloadUrlResponseDto.fromJson(Map<String, dynamic> json) =
      _$ReceiptDownloadUrlResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;

  /// Create a copy of ReceiptDownloadUrlResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptDownloadUrlResponseDtoImplCopyWith<
    _$ReceiptDownloadUrlResponseDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

PaymentTransactionDto _$PaymentTransactionDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PaymentTransactionDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentTransactionDto {
  String get transactionDate => throw _privateConstructorUsedError;
  String get transactionDescription => throw _privateConstructorUsedError;
  String get transactionAmount => throw _privateConstructorUsedError;
  String get accountBalance => throw _privateConstructorUsedError;
  String get dateTime => throw _privateConstructorUsedError;
  String get billNumber => throw _privateConstructorUsedError;
  String get receiptNumber => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String get row => throw _privateConstructorUsedError;

  /// Serializes this PaymentTransactionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentTransactionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentTransactionDtoCopyWith<PaymentTransactionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentTransactionDtoCopyWith<$Res> {
  factory $PaymentTransactionDtoCopyWith(
    PaymentTransactionDto value,
    $Res Function(PaymentTransactionDto) then,
  ) = _$PaymentTransactionDtoCopyWithImpl<$Res, PaymentTransactionDto>;
  @useResult
  $Res call({
    String transactionDate,
    String transactionDescription,
    String transactionAmount,
    String accountBalance,
    String dateTime,
    String billNumber,
    String receiptNumber,
    String? status,
    String row,
  });
}

/// @nodoc
class _$PaymentTransactionDtoCopyWithImpl<
  $Res,
  $Val extends PaymentTransactionDto
>
    implements $PaymentTransactionDtoCopyWith<$Res> {
  _$PaymentTransactionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentTransactionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionDate = null,
    Object? transactionDescription = null,
    Object? transactionAmount = null,
    Object? accountBalance = null,
    Object? dateTime = null,
    Object? billNumber = null,
    Object? receiptNumber = null,
    Object? status = freezed,
    Object? row = null,
  }) {
    return _then(
      _value.copyWith(
            transactionDate: null == transactionDate
                ? _value.transactionDate
                : transactionDate // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionDescription: null == transactionDescription
                ? _value.transactionDescription
                : transactionDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionAmount: null == transactionAmount
                ? _value.transactionAmount
                : transactionAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            accountBalance: null == accountBalance
                ? _value.accountBalance
                : accountBalance // ignore: cast_nullable_to_non_nullable
                      as String,
            dateTime: null == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as String,
            billNumber: null == billNumber
                ? _value.billNumber
                : billNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            receiptNumber: null == receiptNumber
                ? _value.receiptNumber
                : receiptNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            row: null == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentTransactionDtoImplCopyWith<$Res>
    implements $PaymentTransactionDtoCopyWith<$Res> {
  factory _$$PaymentTransactionDtoImplCopyWith(
    _$PaymentTransactionDtoImpl value,
    $Res Function(_$PaymentTransactionDtoImpl) then,
  ) = __$$PaymentTransactionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String transactionDate,
    String transactionDescription,
    String transactionAmount,
    String accountBalance,
    String dateTime,
    String billNumber,
    String receiptNumber,
    String? status,
    String row,
  });
}

/// @nodoc
class __$$PaymentTransactionDtoImplCopyWithImpl<$Res>
    extends
        _$PaymentTransactionDtoCopyWithImpl<$Res, _$PaymentTransactionDtoImpl>
    implements _$$PaymentTransactionDtoImplCopyWith<$Res> {
  __$$PaymentTransactionDtoImplCopyWithImpl(
    _$PaymentTransactionDtoImpl _value,
    $Res Function(_$PaymentTransactionDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentTransactionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionDate = null,
    Object? transactionDescription = null,
    Object? transactionAmount = null,
    Object? accountBalance = null,
    Object? dateTime = null,
    Object? billNumber = null,
    Object? receiptNumber = null,
    Object? status = freezed,
    Object? row = null,
  }) {
    return _then(
      _$PaymentTransactionDtoImpl(
        transactionDate: null == transactionDate
            ? _value.transactionDate
            : transactionDate // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionDescription: null == transactionDescription
            ? _value.transactionDescription
            : transactionDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionAmount: null == transactionAmount
            ? _value.transactionAmount
            : transactionAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        accountBalance: null == accountBalance
            ? _value.accountBalance
            : accountBalance // ignore: cast_nullable_to_non_nullable
                  as String,
        dateTime: null == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as String,
        billNumber: null == billNumber
            ? _value.billNumber
            : billNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        receiptNumber: null == receiptNumber
            ? _value.receiptNumber
            : receiptNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        row: null == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentTransactionDtoImpl implements _PaymentTransactionDto {
  const _$PaymentTransactionDtoImpl({
    required this.transactionDate,
    required this.transactionDescription,
    required this.transactionAmount,
    required this.accountBalance,
    required this.dateTime,
    required this.billNumber,
    required this.receiptNumber,
    this.status,
    required this.row,
  });

  factory _$PaymentTransactionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentTransactionDtoImplFromJson(json);

  @override
  final String transactionDate;
  @override
  final String transactionDescription;
  @override
  final String transactionAmount;
  @override
  final String accountBalance;
  @override
  final String dateTime;
  @override
  final String billNumber;
  @override
  final String receiptNumber;
  @override
  final String? status;
  @override
  final String row;

  @override
  String toString() {
    return 'PaymentTransactionDto(transactionDate: $transactionDate, transactionDescription: $transactionDescription, transactionAmount: $transactionAmount, accountBalance: $accountBalance, dateTime: $dateTime, billNumber: $billNumber, receiptNumber: $receiptNumber, status: $status, row: $row)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentTransactionDtoImpl &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.transactionDescription, transactionDescription) ||
                other.transactionDescription == transactionDescription) &&
            (identical(other.transactionAmount, transactionAmount) ||
                other.transactionAmount == transactionAmount) &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.row, row) || other.row == row));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    transactionDate,
    transactionDescription,
    transactionAmount,
    accountBalance,
    dateTime,
    billNumber,
    receiptNumber,
    status,
    row,
  );

  /// Create a copy of PaymentTransactionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentTransactionDtoImplCopyWith<_$PaymentTransactionDtoImpl>
  get copyWith =>
      __$$PaymentTransactionDtoImplCopyWithImpl<_$PaymentTransactionDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentTransactionDtoImplToJson(this);
  }
}

abstract class _PaymentTransactionDto implements PaymentTransactionDto {
  const factory _PaymentTransactionDto({
    required final String transactionDate,
    required final String transactionDescription,
    required final String transactionAmount,
    required final String accountBalance,
    required final String dateTime,
    required final String billNumber,
    required final String receiptNumber,
    final String? status,
    required final String row,
  }) = _$PaymentTransactionDtoImpl;

  factory _PaymentTransactionDto.fromJson(Map<String, dynamic> json) =
      _$PaymentTransactionDtoImpl.fromJson;

  @override
  String get transactionDate;
  @override
  String get transactionDescription;
  @override
  String get transactionAmount;
  @override
  String get accountBalance;
  @override
  String get dateTime;
  @override
  String get billNumber;
  @override
  String get receiptNumber;
  @override
  String? get status;
  @override
  String get row;

  /// Create a copy of PaymentTransactionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentTransactionDtoImplCopyWith<_$PaymentTransactionDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TransactionHistoryResponseDto _$TransactionHistoryResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _TransactionHistoryResponseDto.fromJson(json);
}

/// @nodoc
mixin _$TransactionHistoryResponseDto {
  int get status => throw _privateConstructorUsedError;
  List<PaymentTransactionDto> get paymentTransactions =>
      throw _privateConstructorUsedError;

  /// Serializes this TransactionHistoryResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionHistoryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionHistoryResponseDtoCopyWith<TransactionHistoryResponseDto>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionHistoryResponseDtoCopyWith<$Res> {
  factory $TransactionHistoryResponseDtoCopyWith(
    TransactionHistoryResponseDto value,
    $Res Function(TransactionHistoryResponseDto) then,
  ) =
      _$TransactionHistoryResponseDtoCopyWithImpl<
        $Res,
        TransactionHistoryResponseDto
      >;
  @useResult
  $Res call({int status, List<PaymentTransactionDto> paymentTransactions});
}

/// @nodoc
class _$TransactionHistoryResponseDtoCopyWithImpl<
  $Res,
  $Val extends TransactionHistoryResponseDto
>
    implements $TransactionHistoryResponseDtoCopyWith<$Res> {
  _$TransactionHistoryResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionHistoryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? paymentTransactions = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentTransactions: null == paymentTransactions
                ? _value.paymentTransactions
                : paymentTransactions // ignore: cast_nullable_to_non_nullable
                      as List<PaymentTransactionDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionHistoryResponseDtoImplCopyWith<$Res>
    implements $TransactionHistoryResponseDtoCopyWith<$Res> {
  factory _$$TransactionHistoryResponseDtoImplCopyWith(
    _$TransactionHistoryResponseDtoImpl value,
    $Res Function(_$TransactionHistoryResponseDtoImpl) then,
  ) = __$$TransactionHistoryResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, List<PaymentTransactionDto> paymentTransactions});
}

/// @nodoc
class __$$TransactionHistoryResponseDtoImplCopyWithImpl<$Res>
    extends
        _$TransactionHistoryResponseDtoCopyWithImpl<
          $Res,
          _$TransactionHistoryResponseDtoImpl
        >
    implements _$$TransactionHistoryResponseDtoImplCopyWith<$Res> {
  __$$TransactionHistoryResponseDtoImplCopyWithImpl(
    _$TransactionHistoryResponseDtoImpl _value,
    $Res Function(_$TransactionHistoryResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionHistoryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? paymentTransactions = null}) {
    return _then(
      _$TransactionHistoryResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentTransactions: null == paymentTransactions
            ? _value._paymentTransactions
            : paymentTransactions // ignore: cast_nullable_to_non_nullable
                  as List<PaymentTransactionDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionHistoryResponseDtoImpl
    implements _TransactionHistoryResponseDto {
  const _$TransactionHistoryResponseDtoImpl({
    required this.status,
    final List<PaymentTransactionDto> paymentTransactions = const [],
  }) : _paymentTransactions = paymentTransactions;

  factory _$TransactionHistoryResponseDtoImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$TransactionHistoryResponseDtoImplFromJson(json);

  @override
  final int status;
  final List<PaymentTransactionDto> _paymentTransactions;
  @override
  @JsonKey()
  List<PaymentTransactionDto> get paymentTransactions {
    if (_paymentTransactions is EqualUnmodifiableListView)
      return _paymentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentTransactions);
  }

  @override
  String toString() {
    return 'TransactionHistoryResponseDto(status: $status, paymentTransactions: $paymentTransactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._paymentTransactions,
              _paymentTransactions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_paymentTransactions),
  );

  /// Create a copy of TransactionHistoryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionHistoryResponseDtoImplCopyWith<
    _$TransactionHistoryResponseDtoImpl
  >
  get copyWith =>
      __$$TransactionHistoryResponseDtoImplCopyWithImpl<
        _$TransactionHistoryResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionHistoryResponseDtoImplToJson(this);
  }
}

abstract class _TransactionHistoryResponseDto
    implements TransactionHistoryResponseDto {
  const factory _TransactionHistoryResponseDto({
    required final int status,
    final List<PaymentTransactionDto> paymentTransactions,
  }) = _$TransactionHistoryResponseDtoImpl;

  factory _TransactionHistoryResponseDto.fromJson(Map<String, dynamic> json) =
      _$TransactionHistoryResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  List<PaymentTransactionDto> get paymentTransactions;

  /// Create a copy of TransactionHistoryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionHistoryResponseDtoImplCopyWith<
    _$TransactionHistoryResponseDtoImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

MeterReadingDto _$MeterReadingDtoFromJson(Map<String, dynamic> json) {
  return _MeterReadingDto.fromJson(json);
}

/// @nodoc
mixin _$MeterReadingDto {
  String get readDate => throw _privateConstructorUsedError;
  String get readMonth => throw _privateConstructorUsedError;
  String get readYear => throw _privateConstructorUsedError;
  String get days => throw _privateConstructorUsedError;
  String get consumption => throw _privateConstructorUsedError;
  String get averageUsage => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;

  /// Serializes this MeterReadingDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterReadingDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterReadingDtoCopyWith<MeterReadingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterReadingDtoCopyWith<$Res> {
  factory $MeterReadingDtoCopyWith(
    MeterReadingDto value,
    $Res Function(MeterReadingDto) then,
  ) = _$MeterReadingDtoCopyWithImpl<$Res, MeterReadingDto>;
  @useResult
  $Res call({
    String readDate,
    String readMonth,
    String readYear,
    String days,
    String consumption,
    String averageUsage,
    String amount,
    String? accountNumber,
  });
}

/// @nodoc
class _$MeterReadingDtoCopyWithImpl<$Res, $Val extends MeterReadingDto>
    implements $MeterReadingDtoCopyWith<$Res> {
  _$MeterReadingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterReadingDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readDate = null,
    Object? readMonth = null,
    Object? readYear = null,
    Object? days = null,
    Object? consumption = null,
    Object? averageUsage = null,
    Object? amount = null,
    Object? accountNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            readDate: null == readDate
                ? _value.readDate
                : readDate // ignore: cast_nullable_to_non_nullable
                      as String,
            readMonth: null == readMonth
                ? _value.readMonth
                : readMonth // ignore: cast_nullable_to_non_nullable
                      as String,
            readYear: null == readYear
                ? _value.readYear
                : readYear // ignore: cast_nullable_to_non_nullable
                      as String,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as String,
            consumption: null == consumption
                ? _value.consumption
                : consumption // ignore: cast_nullable_to_non_nullable
                      as String,
            averageUsage: null == averageUsage
                ? _value.averageUsage
                : averageUsage // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNumber: freezed == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeterReadingDtoImplCopyWith<$Res>
    implements $MeterReadingDtoCopyWith<$Res> {
  factory _$$MeterReadingDtoImplCopyWith(
    _$MeterReadingDtoImpl value,
    $Res Function(_$MeterReadingDtoImpl) then,
  ) = __$$MeterReadingDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String readDate,
    String readMonth,
    String readYear,
    String days,
    String consumption,
    String averageUsage,
    String amount,
    String? accountNumber,
  });
}

/// @nodoc
class __$$MeterReadingDtoImplCopyWithImpl<$Res>
    extends _$MeterReadingDtoCopyWithImpl<$Res, _$MeterReadingDtoImpl>
    implements _$$MeterReadingDtoImplCopyWith<$Res> {
  __$$MeterReadingDtoImplCopyWithImpl(
    _$MeterReadingDtoImpl _value,
    $Res Function(_$MeterReadingDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeterReadingDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readDate = null,
    Object? readMonth = null,
    Object? readYear = null,
    Object? days = null,
    Object? consumption = null,
    Object? averageUsage = null,
    Object? amount = null,
    Object? accountNumber = freezed,
  }) {
    return _then(
      _$MeterReadingDtoImpl(
        readDate: null == readDate
            ? _value.readDate
            : readDate // ignore: cast_nullable_to_non_nullable
                  as String,
        readMonth: null == readMonth
            ? _value.readMonth
            : readMonth // ignore: cast_nullable_to_non_nullable
                  as String,
        readYear: null == readYear
            ? _value.readYear
            : readYear // ignore: cast_nullable_to_non_nullable
                  as String,
        days: null == days
            ? _value.days
            : days // ignore: cast_nullable_to_non_nullable
                  as String,
        consumption: null == consumption
            ? _value.consumption
            : consumption // ignore: cast_nullable_to_non_nullable
                  as String,
        averageUsage: null == averageUsage
            ? _value.averageUsage
            : averageUsage // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: freezed == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterReadingDtoImpl implements _MeterReadingDto {
  const _$MeterReadingDtoImpl({
    required this.readDate,
    required this.readMonth,
    required this.readYear,
    required this.days,
    required this.consumption,
    required this.averageUsage,
    required this.amount,
    this.accountNumber,
  });

  factory _$MeterReadingDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterReadingDtoImplFromJson(json);

  @override
  final String readDate;
  @override
  final String readMonth;
  @override
  final String readYear;
  @override
  final String days;
  @override
  final String consumption;
  @override
  final String averageUsage;
  @override
  final String amount;
  @override
  final String? accountNumber;

  @override
  String toString() {
    return 'MeterReadingDto(readDate: $readDate, readMonth: $readMonth, readYear: $readYear, days: $days, consumption: $consumption, averageUsage: $averageUsage, amount: $amount, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterReadingDtoImpl &&
            (identical(other.readDate, readDate) ||
                other.readDate == readDate) &&
            (identical(other.readMonth, readMonth) ||
                other.readMonth == readMonth) &&
            (identical(other.readYear, readYear) ||
                other.readYear == readYear) &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.consumption, consumption) ||
                other.consumption == consumption) &&
            (identical(other.averageUsage, averageUsage) ||
                other.averageUsage == averageUsage) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    readDate,
    readMonth,
    readYear,
    days,
    consumption,
    averageUsage,
    amount,
    accountNumber,
  );

  /// Create a copy of MeterReadingDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterReadingDtoImplCopyWith<_$MeterReadingDtoImpl> get copyWith =>
      __$$MeterReadingDtoImplCopyWithImpl<_$MeterReadingDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterReadingDtoImplToJson(this);
  }
}

abstract class _MeterReadingDto implements MeterReadingDto {
  const factory _MeterReadingDto({
    required final String readDate,
    required final String readMonth,
    required final String readYear,
    required final String days,
    required final String consumption,
    required final String averageUsage,
    required final String amount,
    final String? accountNumber,
  }) = _$MeterReadingDtoImpl;

  factory _MeterReadingDto.fromJson(Map<String, dynamic> json) =
      _$MeterReadingDtoImpl.fromJson;

  @override
  String get readDate;
  @override
  String get readMonth;
  @override
  String get readYear;
  @override
  String get days;
  @override
  String get consumption;
  @override
  String get averageUsage;
  @override
  String get amount;
  @override
  String? get accountNumber;

  /// Create a copy of MeterReadingDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterReadingDtoImplCopyWith<_$MeterReadingDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeterReadingsResponseDto _$MeterReadingsResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _MeterReadingsResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MeterReadingsResponseDto {
  List<MeterReadingDto> get readings => throw _privateConstructorUsedError;

  /// Serializes this MeterReadingsResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterReadingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterReadingsResponseDtoCopyWith<MeterReadingsResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterReadingsResponseDtoCopyWith<$Res> {
  factory $MeterReadingsResponseDtoCopyWith(
    MeterReadingsResponseDto value,
    $Res Function(MeterReadingsResponseDto) then,
  ) = _$MeterReadingsResponseDtoCopyWithImpl<$Res, MeterReadingsResponseDto>;
  @useResult
  $Res call({List<MeterReadingDto> readings});
}

/// @nodoc
class _$MeterReadingsResponseDtoCopyWithImpl<
  $Res,
  $Val extends MeterReadingsResponseDto
>
    implements $MeterReadingsResponseDtoCopyWith<$Res> {
  _$MeterReadingsResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterReadingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readings = null}) {
    return _then(
      _value.copyWith(
            readings: null == readings
                ? _value.readings
                : readings // ignore: cast_nullable_to_non_nullable
                      as List<MeterReadingDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeterReadingsResponseDtoImplCopyWith<$Res>
    implements $MeterReadingsResponseDtoCopyWith<$Res> {
  factory _$$MeterReadingsResponseDtoImplCopyWith(
    _$MeterReadingsResponseDtoImpl value,
    $Res Function(_$MeterReadingsResponseDtoImpl) then,
  ) = __$$MeterReadingsResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MeterReadingDto> readings});
}

/// @nodoc
class __$$MeterReadingsResponseDtoImplCopyWithImpl<$Res>
    extends
        _$MeterReadingsResponseDtoCopyWithImpl<
          $Res,
          _$MeterReadingsResponseDtoImpl
        >
    implements _$$MeterReadingsResponseDtoImplCopyWith<$Res> {
  __$$MeterReadingsResponseDtoImplCopyWithImpl(
    _$MeterReadingsResponseDtoImpl _value,
    $Res Function(_$MeterReadingsResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeterReadingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readings = null}) {
    return _then(
      _$MeterReadingsResponseDtoImpl(
        readings: null == readings
            ? _value._readings
            : readings // ignore: cast_nullable_to_non_nullable
                  as List<MeterReadingDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterReadingsResponseDtoImpl implements _MeterReadingsResponseDto {
  const _$MeterReadingsResponseDtoImpl({
    final List<MeterReadingDto> readings = const [],
  }) : _readings = readings;

  factory _$MeterReadingsResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterReadingsResponseDtoImplFromJson(json);

  final List<MeterReadingDto> _readings;
  @override
  @JsonKey()
  List<MeterReadingDto> get readings {
    if (_readings is EqualUnmodifiableListView) return _readings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readings);
  }

  @override
  String toString() {
    return 'MeterReadingsResponseDto(readings: $readings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterReadingsResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._readings, _readings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_readings));

  /// Create a copy of MeterReadingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterReadingsResponseDtoImplCopyWith<_$MeterReadingsResponseDtoImpl>
  get copyWith =>
      __$$MeterReadingsResponseDtoImplCopyWithImpl<
        _$MeterReadingsResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterReadingsResponseDtoImplToJson(this);
  }
}

abstract class _MeterReadingsResponseDto implements MeterReadingsResponseDto {
  const factory _MeterReadingsResponseDto({
    final List<MeterReadingDto> readings,
  }) = _$MeterReadingsResponseDtoImpl;

  factory _MeterReadingsResponseDto.fromJson(Map<String, dynamic> json) =
      _$MeterReadingsResponseDtoImpl.fromJson;

  @override
  List<MeterReadingDto> get readings;

  /// Create a copy of MeterReadingsResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterReadingsResponseDtoImplCopyWith<_$MeterReadingsResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DailyTotalKwhDto _$DailyTotalKwhDtoFromJson(Map<String, dynamic> json) {
  return _DailyTotalKwhDto.fromJson(json);
}

/// @nodoc
mixin _$DailyTotalKwhDto {
  double get dailyTotalKwh => throw _privateConstructorUsedError;

  /// Serializes this DailyTotalKwhDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyTotalKwhDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyTotalKwhDtoCopyWith<DailyTotalKwhDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyTotalKwhDtoCopyWith<$Res> {
  factory $DailyTotalKwhDtoCopyWith(
    DailyTotalKwhDto value,
    $Res Function(DailyTotalKwhDto) then,
  ) = _$DailyTotalKwhDtoCopyWithImpl<$Res, DailyTotalKwhDto>;
  @useResult
  $Res call({double dailyTotalKwh});
}

/// @nodoc
class _$DailyTotalKwhDtoCopyWithImpl<$Res, $Val extends DailyTotalKwhDto>
    implements $DailyTotalKwhDtoCopyWith<$Res> {
  _$DailyTotalKwhDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyTotalKwhDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyTotalKwh = null}) {
    return _then(
      _value.copyWith(
            dailyTotalKwh: null == dailyTotalKwh
                ? _value.dailyTotalKwh
                : dailyTotalKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyTotalKwhDtoImplCopyWith<$Res>
    implements $DailyTotalKwhDtoCopyWith<$Res> {
  factory _$$DailyTotalKwhDtoImplCopyWith(
    _$DailyTotalKwhDtoImpl value,
    $Res Function(_$DailyTotalKwhDtoImpl) then,
  ) = __$$DailyTotalKwhDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double dailyTotalKwh});
}

/// @nodoc
class __$$DailyTotalKwhDtoImplCopyWithImpl<$Res>
    extends _$DailyTotalKwhDtoCopyWithImpl<$Res, _$DailyTotalKwhDtoImpl>
    implements _$$DailyTotalKwhDtoImplCopyWith<$Res> {
  __$$DailyTotalKwhDtoImplCopyWithImpl(
    _$DailyTotalKwhDtoImpl _value,
    $Res Function(_$DailyTotalKwhDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyTotalKwhDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyTotalKwh = null}) {
    return _then(
      _$DailyTotalKwhDtoImpl(
        dailyTotalKwh: null == dailyTotalKwh
            ? _value.dailyTotalKwh
            : dailyTotalKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyTotalKwhDtoImpl implements _DailyTotalKwhDto {
  const _$DailyTotalKwhDtoImpl({required this.dailyTotalKwh});

  factory _$DailyTotalKwhDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyTotalKwhDtoImplFromJson(json);

  @override
  final double dailyTotalKwh;

  @override
  String toString() {
    return 'DailyTotalKwhDto(dailyTotalKwh: $dailyTotalKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyTotalKwhDtoImpl &&
            (identical(other.dailyTotalKwh, dailyTotalKwh) ||
                other.dailyTotalKwh == dailyTotalKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dailyTotalKwh);

  /// Create a copy of DailyTotalKwhDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyTotalKwhDtoImplCopyWith<_$DailyTotalKwhDtoImpl> get copyWith =>
      __$$DailyTotalKwhDtoImplCopyWithImpl<_$DailyTotalKwhDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyTotalKwhDtoImplToJson(this);
  }
}

abstract class _DailyTotalKwhDto implements DailyTotalKwhDto {
  const factory _DailyTotalKwhDto({required final double dailyTotalKwh}) =
      _$DailyTotalKwhDtoImpl;

  factory _DailyTotalKwhDto.fromJson(Map<String, dynamic> json) =
      _$DailyTotalKwhDtoImpl.fromJson;

  @override
  double get dailyTotalKwh;

  /// Create a copy of DailyTotalKwhDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyTotalKwhDtoImplCopyWith<_$DailyTotalKwhDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyTotalKwhResponseDto _$DailyTotalKwhResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _DailyTotalKwhResponseDto.fromJson(json);
}

/// @nodoc
mixin _$DailyTotalKwhResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DailyTotalKwhDto get data => throw _privateConstructorUsedError;

  /// Serializes this DailyTotalKwhResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyTotalKwhResponseDtoCopyWith<DailyTotalKwhResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyTotalKwhResponseDtoCopyWith<$Res> {
  factory $DailyTotalKwhResponseDtoCopyWith(
    DailyTotalKwhResponseDto value,
    $Res Function(DailyTotalKwhResponseDto) then,
  ) = _$DailyTotalKwhResponseDtoCopyWithImpl<$Res, DailyTotalKwhResponseDto>;
  @useResult
  $Res call({int status, String? message, DailyTotalKwhDto data});

  $DailyTotalKwhDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$DailyTotalKwhResponseDtoCopyWithImpl<
  $Res,
  $Val extends DailyTotalKwhResponseDto
>
    implements $DailyTotalKwhResponseDtoCopyWith<$Res> {
  _$DailyTotalKwhResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as DailyTotalKwhDto,
          )
          as $Val,
    );
  }

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyTotalKwhDtoCopyWith<$Res> get data {
    return $DailyTotalKwhDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyTotalKwhResponseDtoImplCopyWith<$Res>
    implements $DailyTotalKwhResponseDtoCopyWith<$Res> {
  factory _$$DailyTotalKwhResponseDtoImplCopyWith(
    _$DailyTotalKwhResponseDtoImpl value,
    $Res Function(_$DailyTotalKwhResponseDtoImpl) then,
  ) = __$$DailyTotalKwhResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, DailyTotalKwhDto data});

  @override
  $DailyTotalKwhDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$DailyTotalKwhResponseDtoImplCopyWithImpl<$Res>
    extends
        _$DailyTotalKwhResponseDtoCopyWithImpl<
          $Res,
          _$DailyTotalKwhResponseDtoImpl
        >
    implements _$$DailyTotalKwhResponseDtoImplCopyWith<$Res> {
  __$$DailyTotalKwhResponseDtoImplCopyWithImpl(
    _$DailyTotalKwhResponseDtoImpl _value,
    $Res Function(_$DailyTotalKwhResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _$DailyTotalKwhResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as DailyTotalKwhDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyTotalKwhResponseDtoImpl implements _DailyTotalKwhResponseDto {
  const _$DailyTotalKwhResponseDtoImpl({
    required this.status,
    this.message,
    required this.data,
  });

  factory _$DailyTotalKwhResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyTotalKwhResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  @override
  final DailyTotalKwhDto data;

  @override
  String toString() {
    return 'DailyTotalKwhResponseDto(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyTotalKwhResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyTotalKwhResponseDtoImplCopyWith<_$DailyTotalKwhResponseDtoImpl>
  get copyWith =>
      __$$DailyTotalKwhResponseDtoImplCopyWithImpl<
        _$DailyTotalKwhResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyTotalKwhResponseDtoImplToJson(this);
  }
}

abstract class _DailyTotalKwhResponseDto implements DailyTotalKwhResponseDto {
  const factory _DailyTotalKwhResponseDto({
    required final int status,
    final String? message,
    required final DailyTotalKwhDto data,
  }) = _$DailyTotalKwhResponseDtoImpl;

  factory _DailyTotalKwhResponseDto.fromJson(Map<String, dynamic> json) =
      _$DailyTotalKwhResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  DailyTotalKwhDto get data;

  /// Create a copy of DailyTotalKwhResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyTotalKwhResponseDtoImplCopyWith<_$DailyTotalKwhResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DailyUsageEntryDto _$DailyUsageEntryDtoFromJson(Map<String, dynamic> json) {
  return _DailyUsageEntryDto.fromJson(json);
}

/// @nodoc
mixin _$DailyUsageEntryDto {
  String get usageDate => throw _privateConstructorUsedError;
  double get dailyUsageKwh => throw _privateConstructorUsedError;

  /// Serializes this DailyUsageEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyUsageEntryDtoCopyWith<DailyUsageEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyUsageEntryDtoCopyWith<$Res> {
  factory $DailyUsageEntryDtoCopyWith(
    DailyUsageEntryDto value,
    $Res Function(DailyUsageEntryDto) then,
  ) = _$DailyUsageEntryDtoCopyWithImpl<$Res, DailyUsageEntryDto>;
  @useResult
  $Res call({String usageDate, double dailyUsageKwh});
}

/// @nodoc
class _$DailyUsageEntryDtoCopyWithImpl<$Res, $Val extends DailyUsageEntryDto>
    implements $DailyUsageEntryDtoCopyWith<$Res> {
  _$DailyUsageEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usageDate = null, Object? dailyUsageKwh = null}) {
    return _then(
      _value.copyWith(
            usageDate: null == usageDate
                ? _value.usageDate
                : usageDate // ignore: cast_nullable_to_non_nullable
                      as String,
            dailyUsageKwh: null == dailyUsageKwh
                ? _value.dailyUsageKwh
                : dailyUsageKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyUsageEntryDtoImplCopyWith<$Res>
    implements $DailyUsageEntryDtoCopyWith<$Res> {
  factory _$$DailyUsageEntryDtoImplCopyWith(
    _$DailyUsageEntryDtoImpl value,
    $Res Function(_$DailyUsageEntryDtoImpl) then,
  ) = __$$DailyUsageEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String usageDate, double dailyUsageKwh});
}

/// @nodoc
class __$$DailyUsageEntryDtoImplCopyWithImpl<$Res>
    extends _$DailyUsageEntryDtoCopyWithImpl<$Res, _$DailyUsageEntryDtoImpl>
    implements _$$DailyUsageEntryDtoImplCopyWith<$Res> {
  __$$DailyUsageEntryDtoImplCopyWithImpl(
    _$DailyUsageEntryDtoImpl _value,
    $Res Function(_$DailyUsageEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? usageDate = null, Object? dailyUsageKwh = null}) {
    return _then(
      _$DailyUsageEntryDtoImpl(
        usageDate: null == usageDate
            ? _value.usageDate
            : usageDate // ignore: cast_nullable_to_non_nullable
                  as String,
        dailyUsageKwh: null == dailyUsageKwh
            ? _value.dailyUsageKwh
            : dailyUsageKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyUsageEntryDtoImpl implements _DailyUsageEntryDto {
  const _$DailyUsageEntryDtoImpl({
    required this.usageDate,
    required this.dailyUsageKwh,
  });

  factory _$DailyUsageEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyUsageEntryDtoImplFromJson(json);

  @override
  final String usageDate;
  @override
  final double dailyUsageKwh;

  @override
  String toString() {
    return 'DailyUsageEntryDto(usageDate: $usageDate, dailyUsageKwh: $dailyUsageKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyUsageEntryDtoImpl &&
            (identical(other.usageDate, usageDate) ||
                other.usageDate == usageDate) &&
            (identical(other.dailyUsageKwh, dailyUsageKwh) ||
                other.dailyUsageKwh == dailyUsageKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, usageDate, dailyUsageKwh);

  /// Create a copy of DailyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyUsageEntryDtoImplCopyWith<_$DailyUsageEntryDtoImpl> get copyWith =>
      __$$DailyUsageEntryDtoImplCopyWithImpl<_$DailyUsageEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyUsageEntryDtoImplToJson(this);
  }
}

abstract class _DailyUsageEntryDto implements DailyUsageEntryDto {
  const factory _DailyUsageEntryDto({
    required final String usageDate,
    required final double dailyUsageKwh,
  }) = _$DailyUsageEntryDtoImpl;

  factory _DailyUsageEntryDto.fromJson(Map<String, dynamic> json) =
      _$DailyUsageEntryDtoImpl.fromJson;

  @override
  String get usageDate;
  @override
  double get dailyUsageKwh;

  /// Create a copy of DailyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyUsageEntryDtoImplCopyWith<_$DailyUsageEntryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyUsageResponseDto _$DailyUsageResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _DailyUsageResponseDto.fromJson(json);
}

/// @nodoc
mixin _$DailyUsageResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<DailyUsageEntryDto> get data => throw _privateConstructorUsedError;

  /// Serializes this DailyUsageResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyUsageResponseDtoCopyWith<DailyUsageResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyUsageResponseDtoCopyWith<$Res> {
  factory $DailyUsageResponseDtoCopyWith(
    DailyUsageResponseDto value,
    $Res Function(DailyUsageResponseDto) then,
  ) = _$DailyUsageResponseDtoCopyWithImpl<$Res, DailyUsageResponseDto>;
  @useResult
  $Res call({int status, String? message, List<DailyUsageEntryDto> data});
}

/// @nodoc
class _$DailyUsageResponseDtoCopyWithImpl<
  $Res,
  $Val extends DailyUsageResponseDto
>
    implements $DailyUsageResponseDtoCopyWith<$Res> {
  _$DailyUsageResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<DailyUsageEntryDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyUsageResponseDtoImplCopyWith<$Res>
    implements $DailyUsageResponseDtoCopyWith<$Res> {
  factory _$$DailyUsageResponseDtoImplCopyWith(
    _$DailyUsageResponseDtoImpl value,
    $Res Function(_$DailyUsageResponseDtoImpl) then,
  ) = __$$DailyUsageResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, List<DailyUsageEntryDto> data});
}

/// @nodoc
class __$$DailyUsageResponseDtoImplCopyWithImpl<$Res>
    extends
        _$DailyUsageResponseDtoCopyWithImpl<$Res, _$DailyUsageResponseDtoImpl>
    implements _$$DailyUsageResponseDtoImplCopyWith<$Res> {
  __$$DailyUsageResponseDtoImplCopyWithImpl(
    _$DailyUsageResponseDtoImpl _value,
    $Res Function(_$DailyUsageResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _$DailyUsageResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<DailyUsageEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyUsageResponseDtoImpl implements _DailyUsageResponseDto {
  const _$DailyUsageResponseDtoImpl({
    required this.status,
    this.message,
    final List<DailyUsageEntryDto> data = const [],
  }) : _data = data;

  factory _$DailyUsageResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyUsageResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  final List<DailyUsageEntryDto> _data;
  @override
  @JsonKey()
  List<DailyUsageEntryDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DailyUsageResponseDto(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyUsageResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of DailyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyUsageResponseDtoImplCopyWith<_$DailyUsageResponseDtoImpl>
  get copyWith =>
      __$$DailyUsageResponseDtoImplCopyWithImpl<_$DailyUsageResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyUsageResponseDtoImplToJson(this);
  }
}

abstract class _DailyUsageResponseDto implements DailyUsageResponseDto {
  const factory _DailyUsageResponseDto({
    required final int status,
    final String? message,
    final List<DailyUsageEntryDto> data,
  }) = _$DailyUsageResponseDtoImpl;

  factory _DailyUsageResponseDto.fromJson(Map<String, dynamic> json) =
      _$DailyUsageResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  List<DailyUsageEntryDto> get data;

  /// Create a copy of DailyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyUsageResponseDtoImplCopyWith<_$DailyUsageResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

IntervalUsageEntryDto _$IntervalUsageEntryDtoFromJson(
  Map<String, dynamic> json,
) {
  return _IntervalUsageEntryDto.fromJson(json);
}

/// @nodoc
mixin _$IntervalUsageEntryDto {
  String get meterId => throw _privateConstructorUsedError;
  String get readDate => throw _privateConstructorUsedError;
  String get firstIntervalDateTime => throw _privateConstructorUsedError;
  String get intervalDateTime => throw _privateConstructorUsedError;
  int get intervalNumber => throw _privateConstructorUsedError;
  double get kWh => throw _privateConstructorUsedError;

  /// Serializes this IntervalUsageEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntervalUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntervalUsageEntryDtoCopyWith<IntervalUsageEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntervalUsageEntryDtoCopyWith<$Res> {
  factory $IntervalUsageEntryDtoCopyWith(
    IntervalUsageEntryDto value,
    $Res Function(IntervalUsageEntryDto) then,
  ) = _$IntervalUsageEntryDtoCopyWithImpl<$Res, IntervalUsageEntryDto>;
  @useResult
  $Res call({
    String meterId,
    String readDate,
    String firstIntervalDateTime,
    String intervalDateTime,
    int intervalNumber,
    double kWh,
  });
}

/// @nodoc
class _$IntervalUsageEntryDtoCopyWithImpl<
  $Res,
  $Val extends IntervalUsageEntryDto
>
    implements $IntervalUsageEntryDtoCopyWith<$Res> {
  _$IntervalUsageEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntervalUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? readDate = null,
    Object? firstIntervalDateTime = null,
    Object? intervalDateTime = null,
    Object? intervalNumber = null,
    Object? kWh = null,
  }) {
    return _then(
      _value.copyWith(
            meterId: null == meterId
                ? _value.meterId
                : meterId // ignore: cast_nullable_to_non_nullable
                      as String,
            readDate: null == readDate
                ? _value.readDate
                : readDate // ignore: cast_nullable_to_non_nullable
                      as String,
            firstIntervalDateTime: null == firstIntervalDateTime
                ? _value.firstIntervalDateTime
                : firstIntervalDateTime // ignore: cast_nullable_to_non_nullable
                      as String,
            intervalDateTime: null == intervalDateTime
                ? _value.intervalDateTime
                : intervalDateTime // ignore: cast_nullable_to_non_nullable
                      as String,
            intervalNumber: null == intervalNumber
                ? _value.intervalNumber
                : intervalNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            kWh: null == kWh
                ? _value.kWh
                : kWh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IntervalUsageEntryDtoImplCopyWith<$Res>
    implements $IntervalUsageEntryDtoCopyWith<$Res> {
  factory _$$IntervalUsageEntryDtoImplCopyWith(
    _$IntervalUsageEntryDtoImpl value,
    $Res Function(_$IntervalUsageEntryDtoImpl) then,
  ) = __$$IntervalUsageEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String meterId,
    String readDate,
    String firstIntervalDateTime,
    String intervalDateTime,
    int intervalNumber,
    double kWh,
  });
}

/// @nodoc
class __$$IntervalUsageEntryDtoImplCopyWithImpl<$Res>
    extends
        _$IntervalUsageEntryDtoCopyWithImpl<$Res, _$IntervalUsageEntryDtoImpl>
    implements _$$IntervalUsageEntryDtoImplCopyWith<$Res> {
  __$$IntervalUsageEntryDtoImplCopyWithImpl(
    _$IntervalUsageEntryDtoImpl _value,
    $Res Function(_$IntervalUsageEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IntervalUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? readDate = null,
    Object? firstIntervalDateTime = null,
    Object? intervalDateTime = null,
    Object? intervalNumber = null,
    Object? kWh = null,
  }) {
    return _then(
      _$IntervalUsageEntryDtoImpl(
        meterId: null == meterId
            ? _value.meterId
            : meterId // ignore: cast_nullable_to_non_nullable
                  as String,
        readDate: null == readDate
            ? _value.readDate
            : readDate // ignore: cast_nullable_to_non_nullable
                  as String,
        firstIntervalDateTime: null == firstIntervalDateTime
            ? _value.firstIntervalDateTime
            : firstIntervalDateTime // ignore: cast_nullable_to_non_nullable
                  as String,
        intervalDateTime: null == intervalDateTime
            ? _value.intervalDateTime
            : intervalDateTime // ignore: cast_nullable_to_non_nullable
                  as String,
        intervalNumber: null == intervalNumber
            ? _value.intervalNumber
            : intervalNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        kWh: null == kWh
            ? _value.kWh
            : kWh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IntervalUsageEntryDtoImpl implements _IntervalUsageEntryDto {
  const _$IntervalUsageEntryDtoImpl({
    required this.meterId,
    required this.readDate,
    required this.firstIntervalDateTime,
    required this.intervalDateTime,
    required this.intervalNumber,
    required this.kWh,
  });

  factory _$IntervalUsageEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntervalUsageEntryDtoImplFromJson(json);

  @override
  final String meterId;
  @override
  final String readDate;
  @override
  final String firstIntervalDateTime;
  @override
  final String intervalDateTime;
  @override
  final int intervalNumber;
  @override
  final double kWh;

  @override
  String toString() {
    return 'IntervalUsageEntryDto(meterId: $meterId, readDate: $readDate, firstIntervalDateTime: $firstIntervalDateTime, intervalDateTime: $intervalDateTime, intervalNumber: $intervalNumber, kWh: $kWh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntervalUsageEntryDtoImpl &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.readDate, readDate) ||
                other.readDate == readDate) &&
            (identical(other.firstIntervalDateTime, firstIntervalDateTime) ||
                other.firstIntervalDateTime == firstIntervalDateTime) &&
            (identical(other.intervalDateTime, intervalDateTime) ||
                other.intervalDateTime == intervalDateTime) &&
            (identical(other.intervalNumber, intervalNumber) ||
                other.intervalNumber == intervalNumber) &&
            (identical(other.kWh, kWh) || other.kWh == kWh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meterId,
    readDate,
    firstIntervalDateTime,
    intervalDateTime,
    intervalNumber,
    kWh,
  );

  /// Create a copy of IntervalUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntervalUsageEntryDtoImplCopyWith<_$IntervalUsageEntryDtoImpl>
  get copyWith =>
      __$$IntervalUsageEntryDtoImplCopyWithImpl<_$IntervalUsageEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IntervalUsageEntryDtoImplToJson(this);
  }
}

abstract class _IntervalUsageEntryDto implements IntervalUsageEntryDto {
  const factory _IntervalUsageEntryDto({
    required final String meterId,
    required final String readDate,
    required final String firstIntervalDateTime,
    required final String intervalDateTime,
    required final int intervalNumber,
    required final double kWh,
  }) = _$IntervalUsageEntryDtoImpl;

  factory _IntervalUsageEntryDto.fromJson(Map<String, dynamic> json) =
      _$IntervalUsageEntryDtoImpl.fromJson;

  @override
  String get meterId;
  @override
  String get readDate;
  @override
  String get firstIntervalDateTime;
  @override
  String get intervalDateTime;
  @override
  int get intervalNumber;
  @override
  double get kWh;

  /// Create a copy of IntervalUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntervalUsageEntryDtoImplCopyWith<_$IntervalUsageEntryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

IntervalUsageResponseDto _$IntervalUsageResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _IntervalUsageResponseDto.fromJson(json);
}

/// @nodoc
mixin _$IntervalUsageResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<IntervalUsageEntryDto> get data => throw _privateConstructorUsedError;

  /// Serializes this IntervalUsageResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntervalUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntervalUsageResponseDtoCopyWith<IntervalUsageResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntervalUsageResponseDtoCopyWith<$Res> {
  factory $IntervalUsageResponseDtoCopyWith(
    IntervalUsageResponseDto value,
    $Res Function(IntervalUsageResponseDto) then,
  ) = _$IntervalUsageResponseDtoCopyWithImpl<$Res, IntervalUsageResponseDto>;
  @useResult
  $Res call({int status, String? message, List<IntervalUsageEntryDto> data});
}

/// @nodoc
class _$IntervalUsageResponseDtoCopyWithImpl<
  $Res,
  $Val extends IntervalUsageResponseDto
>
    implements $IntervalUsageResponseDtoCopyWith<$Res> {
  _$IntervalUsageResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntervalUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<IntervalUsageEntryDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IntervalUsageResponseDtoImplCopyWith<$Res>
    implements $IntervalUsageResponseDtoCopyWith<$Res> {
  factory _$$IntervalUsageResponseDtoImplCopyWith(
    _$IntervalUsageResponseDtoImpl value,
    $Res Function(_$IntervalUsageResponseDtoImpl) then,
  ) = __$$IntervalUsageResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, List<IntervalUsageEntryDto> data});
}

/// @nodoc
class __$$IntervalUsageResponseDtoImplCopyWithImpl<$Res>
    extends
        _$IntervalUsageResponseDtoCopyWithImpl<
          $Res,
          _$IntervalUsageResponseDtoImpl
        >
    implements _$$IntervalUsageResponseDtoImplCopyWith<$Res> {
  __$$IntervalUsageResponseDtoImplCopyWithImpl(
    _$IntervalUsageResponseDtoImpl _value,
    $Res Function(_$IntervalUsageResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IntervalUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _$IntervalUsageResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<IntervalUsageEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IntervalUsageResponseDtoImpl implements _IntervalUsageResponseDto {
  const _$IntervalUsageResponseDtoImpl({
    required this.status,
    this.message,
    final List<IntervalUsageEntryDto> data = const [],
  }) : _data = data;

  factory _$IntervalUsageResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntervalUsageResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  final List<IntervalUsageEntryDto> _data;
  @override
  @JsonKey()
  List<IntervalUsageEntryDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'IntervalUsageResponseDto(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntervalUsageResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of IntervalUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntervalUsageResponseDtoImplCopyWith<_$IntervalUsageResponseDtoImpl>
  get copyWith =>
      __$$IntervalUsageResponseDtoImplCopyWithImpl<
        _$IntervalUsageResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntervalUsageResponseDtoImplToJson(this);
  }
}

abstract class _IntervalUsageResponseDto implements IntervalUsageResponseDto {
  const factory _IntervalUsageResponseDto({
    required final int status,
    final String? message,
    final List<IntervalUsageEntryDto> data,
  }) = _$IntervalUsageResponseDtoImpl;

  factory _IntervalUsageResponseDto.fromJson(Map<String, dynamic> json) =
      _$IntervalUsageResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  List<IntervalUsageEntryDto> get data;

  /// Create a copy of IntervalUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntervalUsageResponseDtoImplCopyWith<_$IntervalUsageResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MonthlyUsageEntryDto _$MonthlyUsageEntryDtoFromJson(Map<String, dynamic> json) {
  return _MonthlyUsageEntryDto.fromJson(json);
}

/// @nodoc
mixin _$MonthlyUsageEntryDto {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  double get monthlyUsageKwh => throw _privateConstructorUsedError;

  /// Serializes this MonthlyUsageEntryDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyUsageEntryDtoCopyWith<MonthlyUsageEntryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyUsageEntryDtoCopyWith<$Res> {
  factory $MonthlyUsageEntryDtoCopyWith(
    MonthlyUsageEntryDto value,
    $Res Function(MonthlyUsageEntryDto) then,
  ) = _$MonthlyUsageEntryDtoCopyWithImpl<$Res, MonthlyUsageEntryDto>;
  @useResult
  $Res call({int year, int month, double monthlyUsageKwh});
}

/// @nodoc
class _$MonthlyUsageEntryDtoCopyWithImpl<
  $Res,
  $Val extends MonthlyUsageEntryDto
>
    implements $MonthlyUsageEntryDtoCopyWith<$Res> {
  _$MonthlyUsageEntryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthlyUsageKwh = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            monthlyUsageKwh: null == monthlyUsageKwh
                ? _value.monthlyUsageKwh
                : monthlyUsageKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyUsageEntryDtoImplCopyWith<$Res>
    implements $MonthlyUsageEntryDtoCopyWith<$Res> {
  factory _$$MonthlyUsageEntryDtoImplCopyWith(
    _$MonthlyUsageEntryDtoImpl value,
    $Res Function(_$MonthlyUsageEntryDtoImpl) then,
  ) = __$$MonthlyUsageEntryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, int month, double monthlyUsageKwh});
}

/// @nodoc
class __$$MonthlyUsageEntryDtoImplCopyWithImpl<$Res>
    extends _$MonthlyUsageEntryDtoCopyWithImpl<$Res, _$MonthlyUsageEntryDtoImpl>
    implements _$$MonthlyUsageEntryDtoImplCopyWith<$Res> {
  __$$MonthlyUsageEntryDtoImplCopyWithImpl(
    _$MonthlyUsageEntryDtoImpl _value,
    $Res Function(_$MonthlyUsageEntryDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthlyUsageKwh = null,
  }) {
    return _then(
      _$MonthlyUsageEntryDtoImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        monthlyUsageKwh: null == monthlyUsageKwh
            ? _value.monthlyUsageKwh
            : monthlyUsageKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyUsageEntryDtoImpl implements _MonthlyUsageEntryDto {
  const _$MonthlyUsageEntryDtoImpl({
    required this.year,
    required this.month,
    required this.monthlyUsageKwh,
  });

  factory _$MonthlyUsageEntryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyUsageEntryDtoImplFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  final double monthlyUsageKwh;

  @override
  String toString() {
    return 'MonthlyUsageEntryDto(year: $year, month: $month, monthlyUsageKwh: $monthlyUsageKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyUsageEntryDtoImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthlyUsageKwh, monthlyUsageKwh) ||
                other.monthlyUsageKwh == monthlyUsageKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, month, monthlyUsageKwh);

  /// Create a copy of MonthlyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyUsageEntryDtoImplCopyWith<_$MonthlyUsageEntryDtoImpl>
  get copyWith =>
      __$$MonthlyUsageEntryDtoImplCopyWithImpl<_$MonthlyUsageEntryDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyUsageEntryDtoImplToJson(this);
  }
}

abstract class _MonthlyUsageEntryDto implements MonthlyUsageEntryDto {
  const factory _MonthlyUsageEntryDto({
    required final int year,
    required final int month,
    required final double monthlyUsageKwh,
  }) = _$MonthlyUsageEntryDtoImpl;

  factory _MonthlyUsageEntryDto.fromJson(Map<String, dynamic> json) =
      _$MonthlyUsageEntryDtoImpl.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  double get monthlyUsageKwh;

  /// Create a copy of MonthlyUsageEntryDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyUsageEntryDtoImplCopyWith<_$MonthlyUsageEntryDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MonthlyUsageResponseDto _$MonthlyUsageResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _MonthlyUsageResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MonthlyUsageResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<MonthlyUsageEntryDto> get data => throw _privateConstructorUsedError;

  /// Serializes this MonthlyUsageResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyUsageResponseDtoCopyWith<MonthlyUsageResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyUsageResponseDtoCopyWith<$Res> {
  factory $MonthlyUsageResponseDtoCopyWith(
    MonthlyUsageResponseDto value,
    $Res Function(MonthlyUsageResponseDto) then,
  ) = _$MonthlyUsageResponseDtoCopyWithImpl<$Res, MonthlyUsageResponseDto>;
  @useResult
  $Res call({int status, String? message, List<MonthlyUsageEntryDto> data});
}

/// @nodoc
class _$MonthlyUsageResponseDtoCopyWithImpl<
  $Res,
  $Val extends MonthlyUsageResponseDto
>
    implements $MonthlyUsageResponseDtoCopyWith<$Res> {
  _$MonthlyUsageResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyUsageEntryDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyUsageResponseDtoImplCopyWith<$Res>
    implements $MonthlyUsageResponseDtoCopyWith<$Res> {
  factory _$$MonthlyUsageResponseDtoImplCopyWith(
    _$MonthlyUsageResponseDtoImpl value,
    $Res Function(_$MonthlyUsageResponseDtoImpl) then,
  ) = __$$MonthlyUsageResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, List<MonthlyUsageEntryDto> data});
}

/// @nodoc
class __$$MonthlyUsageResponseDtoImplCopyWithImpl<$Res>
    extends
        _$MonthlyUsageResponseDtoCopyWithImpl<
          $Res,
          _$MonthlyUsageResponseDtoImpl
        >
    implements _$$MonthlyUsageResponseDtoImplCopyWith<$Res> {
  __$$MonthlyUsageResponseDtoImplCopyWithImpl(
    _$MonthlyUsageResponseDtoImpl _value,
    $Res Function(_$MonthlyUsageResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _$MonthlyUsageResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyUsageEntryDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyUsageResponseDtoImpl implements _MonthlyUsageResponseDto {
  const _$MonthlyUsageResponseDtoImpl({
    required this.status,
    this.message,
    final List<MonthlyUsageEntryDto> data = const [],
  }) : _data = data;

  factory _$MonthlyUsageResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyUsageResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  final List<MonthlyUsageEntryDto> _data;
  @override
  @JsonKey()
  List<MonthlyUsageEntryDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'MonthlyUsageResponseDto(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyUsageResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of MonthlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyUsageResponseDtoImplCopyWith<_$MonthlyUsageResponseDtoImpl>
  get copyWith =>
      __$$MonthlyUsageResponseDtoImplCopyWithImpl<
        _$MonthlyUsageResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyUsageResponseDtoImplToJson(this);
  }
}

abstract class _MonthlyUsageResponseDto implements MonthlyUsageResponseDto {
  const factory _MonthlyUsageResponseDto({
    required final int status,
    final String? message,
    final List<MonthlyUsageEntryDto> data,
  }) = _$MonthlyUsageResponseDtoImpl;

  factory _MonthlyUsageResponseDto.fromJson(Map<String, dynamic> json) =
      _$MonthlyUsageResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  List<MonthlyUsageEntryDto> get data;

  /// Create a copy of MonthlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyUsageResponseDtoImplCopyWith<_$MonthlyUsageResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

YearlyUsageDto _$YearlyUsageDtoFromJson(Map<String, dynamic> json) {
  return _YearlyUsageDto.fromJson(json);
}

/// @nodoc
mixin _$YearlyUsageDto {
  double get yearlyUsageKwh => throw _privateConstructorUsedError;

  /// Serializes this YearlyUsageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearlyUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearlyUsageDtoCopyWith<YearlyUsageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlyUsageDtoCopyWith<$Res> {
  factory $YearlyUsageDtoCopyWith(
    YearlyUsageDto value,
    $Res Function(YearlyUsageDto) then,
  ) = _$YearlyUsageDtoCopyWithImpl<$Res, YearlyUsageDto>;
  @useResult
  $Res call({double yearlyUsageKwh});
}

/// @nodoc
class _$YearlyUsageDtoCopyWithImpl<$Res, $Val extends YearlyUsageDto>
    implements $YearlyUsageDtoCopyWith<$Res> {
  _$YearlyUsageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearlyUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? yearlyUsageKwh = null}) {
    return _then(
      _value.copyWith(
            yearlyUsageKwh: null == yearlyUsageKwh
                ? _value.yearlyUsageKwh
                : yearlyUsageKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YearlyUsageDtoImplCopyWith<$Res>
    implements $YearlyUsageDtoCopyWith<$Res> {
  factory _$$YearlyUsageDtoImplCopyWith(
    _$YearlyUsageDtoImpl value,
    $Res Function(_$YearlyUsageDtoImpl) then,
  ) = __$$YearlyUsageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double yearlyUsageKwh});
}

/// @nodoc
class __$$YearlyUsageDtoImplCopyWithImpl<$Res>
    extends _$YearlyUsageDtoCopyWithImpl<$Res, _$YearlyUsageDtoImpl>
    implements _$$YearlyUsageDtoImplCopyWith<$Res> {
  __$$YearlyUsageDtoImplCopyWithImpl(
    _$YearlyUsageDtoImpl _value,
    $Res Function(_$YearlyUsageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearlyUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? yearlyUsageKwh = null}) {
    return _then(
      _$YearlyUsageDtoImpl(
        yearlyUsageKwh: null == yearlyUsageKwh
            ? _value.yearlyUsageKwh
            : yearlyUsageKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyUsageDtoImpl implements _YearlyUsageDto {
  const _$YearlyUsageDtoImpl({required this.yearlyUsageKwh});

  factory _$YearlyUsageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyUsageDtoImplFromJson(json);

  @override
  final double yearlyUsageKwh;

  @override
  String toString() {
    return 'YearlyUsageDto(yearlyUsageKwh: $yearlyUsageKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyUsageDtoImpl &&
            (identical(other.yearlyUsageKwh, yearlyUsageKwh) ||
                other.yearlyUsageKwh == yearlyUsageKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, yearlyUsageKwh);

  /// Create a copy of YearlyUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyUsageDtoImplCopyWith<_$YearlyUsageDtoImpl> get copyWith =>
      __$$YearlyUsageDtoImplCopyWithImpl<_$YearlyUsageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyUsageDtoImplToJson(this);
  }
}

abstract class _YearlyUsageDto implements YearlyUsageDto {
  const factory _YearlyUsageDto({required final double yearlyUsageKwh}) =
      _$YearlyUsageDtoImpl;

  factory _YearlyUsageDto.fromJson(Map<String, dynamic> json) =
      _$YearlyUsageDtoImpl.fromJson;

  @override
  double get yearlyUsageKwh;

  /// Create a copy of YearlyUsageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyUsageDtoImplCopyWith<_$YearlyUsageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YearlyUsageResponseDto _$YearlyUsageResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _YearlyUsageResponseDto.fromJson(json);
}

/// @nodoc
mixin _$YearlyUsageResponseDto {
  int get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  YearlyUsageDto get data => throw _privateConstructorUsedError;

  /// Serializes this YearlyUsageResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearlyUsageResponseDtoCopyWith<YearlyUsageResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlyUsageResponseDtoCopyWith<$Res> {
  factory $YearlyUsageResponseDtoCopyWith(
    YearlyUsageResponseDto value,
    $Res Function(YearlyUsageResponseDto) then,
  ) = _$YearlyUsageResponseDtoCopyWithImpl<$Res, YearlyUsageResponseDto>;
  @useResult
  $Res call({int status, String? message, YearlyUsageDto data});

  $YearlyUsageDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$YearlyUsageResponseDtoCopyWithImpl<
  $Res,
  $Val extends YearlyUsageResponseDto
>
    implements $YearlyUsageResponseDtoCopyWith<$Res> {
  _$YearlyUsageResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as YearlyUsageDto,
          )
          as $Val,
    );
  }

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YearlyUsageDtoCopyWith<$Res> get data {
    return $YearlyUsageDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YearlyUsageResponseDtoImplCopyWith<$Res>
    implements $YearlyUsageResponseDtoCopyWith<$Res> {
  factory _$$YearlyUsageResponseDtoImplCopyWith(
    _$YearlyUsageResponseDtoImpl value,
    $Res Function(_$YearlyUsageResponseDtoImpl) then,
  ) = __$$YearlyUsageResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? message, YearlyUsageDto data});

  @override
  $YearlyUsageDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$YearlyUsageResponseDtoImplCopyWithImpl<$Res>
    extends
        _$YearlyUsageResponseDtoCopyWithImpl<$Res, _$YearlyUsageResponseDtoImpl>
    implements _$$YearlyUsageResponseDtoImplCopyWith<$Res> {
  __$$YearlyUsageResponseDtoImplCopyWithImpl(
    _$YearlyUsageResponseDtoImpl _value,
    $Res Function(_$YearlyUsageResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? data = null,
  }) {
    return _then(
      _$YearlyUsageResponseDtoImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as YearlyUsageDto,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyUsageResponseDtoImpl implements _YearlyUsageResponseDto {
  const _$YearlyUsageResponseDtoImpl({
    required this.status,
    this.message,
    required this.data,
  });

  factory _$YearlyUsageResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyUsageResponseDtoImplFromJson(json);

  @override
  final int status;
  @override
  final String? message;
  @override
  final YearlyUsageDto data;

  @override
  String toString() {
    return 'YearlyUsageResponseDto(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyUsageResponseDtoImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyUsageResponseDtoImplCopyWith<_$YearlyUsageResponseDtoImpl>
  get copyWith =>
      __$$YearlyUsageResponseDtoImplCopyWithImpl<_$YearlyUsageResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyUsageResponseDtoImplToJson(this);
  }
}

abstract class _YearlyUsageResponseDto implements YearlyUsageResponseDto {
  const factory _YearlyUsageResponseDto({
    required final int status,
    final String? message,
    required final YearlyUsageDto data,
  }) = _$YearlyUsageResponseDtoImpl;

  factory _YearlyUsageResponseDto.fromJson(Map<String, dynamic> json) =
      _$YearlyUsageResponseDtoImpl.fromJson;

  @override
  int get status;
  @override
  String? get message;
  @override
  YearlyUsageDto get data;

  /// Create a copy of YearlyUsageResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyUsageResponseDtoImplCopyWith<_$YearlyUsageResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
