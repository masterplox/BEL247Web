// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  Address get serviceAddress => throw _privateConstructorUsedError;
  String get meterNumber => throw _privateConstructorUsedError;
  String get tariffPlan => throw _privateConstructorUsedError;
  DateTime get connectionDate => throw _privateConstructorUsedError;
  DateTime get lastLogin => throw _privateConstructorUsedError;
  UserPreferences get preferences => throw _privateConstructorUsedError;
  AccountBalance get accountBalance => throw _privateConstructorUsedError;
  UsageSummary get usageSummary => throw _privateConstructorUsedError;
  UserProfile get profile => throw _privateConstructorUsedError;
  UserSettings get settings => throw _privateConstructorUsedError;
  UserSecurity get security => throw _privateConstructorUsedError;
  List<PaymentMethod> get paymentMethods => throw _privateConstructorUsedError;
  List<NotificationHistory> get notificationHistory =>
      throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    String phone,
    Address address,
    String accountNumber,
    Address serviceAddress,
    String meterNumber,
    String tariffPlan,
    DateTime connectionDate,
    DateTime lastLogin,
    UserPreferences preferences,
    AccountBalance accountBalance,
    UsageSummary usageSummary,
    UserProfile profile,
    UserSettings settings,
    UserSecurity security,
    List<PaymentMethod> paymentMethods,
    List<NotificationHistory> notificationHistory,
    UserStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $AddressCopyWith<$Res> get address;
  $AddressCopyWith<$Res> get serviceAddress;
  $UserPreferencesCopyWith<$Res> get preferences;
  $AccountBalanceCopyWith<$Res> get accountBalance;
  $UsageSummaryCopyWith<$Res> get usageSummary;
  $UserProfileCopyWith<$Res> get profile;
  $UserSettingsCopyWith<$Res> get settings;
  $UserSecurityCopyWith<$Res> get security;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? address = null,
    Object? accountNumber = null,
    Object? serviceAddress = null,
    Object? meterNumber = null,
    Object? tariffPlan = null,
    Object? connectionDate = null,
    Object? lastLogin = null,
    Object? preferences = null,
    Object? accountBalance = null,
    Object? usageSummary = null,
    Object? profile = null,
    Object? settings = null,
    Object? security = null,
    Object? paymentMethods = null,
    Object? notificationHistory = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
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
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as Address,
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            serviceAddress: null == serviceAddress
                ? _value.serviceAddress
                : serviceAddress // ignore: cast_nullable_to_non_nullable
                      as Address,
            meterNumber: null == meterNumber
                ? _value.meterNumber
                : meterNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            tariffPlan: null == tariffPlan
                ? _value.tariffPlan
                : tariffPlan // ignore: cast_nullable_to_non_nullable
                      as String,
            connectionDate: null == connectionDate
                ? _value.connectionDate
                : connectionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastLogin: null == lastLogin
                ? _value.lastLogin
                : lastLogin // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as UserPreferences,
            accountBalance: null == accountBalance
                ? _value.accountBalance
                : accountBalance // ignore: cast_nullable_to_non_nullable
                      as AccountBalance,
            usageSummary: null == usageSummary
                ? _value.usageSummary
                : usageSummary // ignore: cast_nullable_to_non_nullable
                      as UsageSummary,
            profile: null == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as UserProfile,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as UserSettings,
            security: null == security
                ? _value.security
                : security // ignore: cast_nullable_to_non_nullable
                      as UserSecurity,
            paymentMethods: null == paymentMethods
                ? _value.paymentMethods
                : paymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<PaymentMethod>,
            notificationHistory: null == notificationHistory
                ? _value.notificationHistory
                : notificationHistory // ignore: cast_nullable_to_non_nullable
                      as List<NotificationHistory>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as UserStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get serviceAddress {
    return $AddressCopyWith<$Res>(_value.serviceAddress, (value) {
      return _then(_value.copyWith(serviceAddress: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res> get preferences {
    return $UserPreferencesCopyWith<$Res>(_value.preferences, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountBalanceCopyWith<$Res> get accountBalance {
    return $AccountBalanceCopyWith<$Res>(_value.accountBalance, (value) {
      return _then(_value.copyWith(accountBalance: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsageSummaryCopyWith<$Res> get usageSummary {
    return $UsageSummaryCopyWith<$Res>(_value.usageSummary, (value) {
      return _then(_value.copyWith(usageSummary: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get profile {
    return $UserProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res> get settings {
    return $UserSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSecurityCopyWith<$Res> get security {
    return $UserSecurityCopyWith<$Res>(_value.security, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    String phone,
    Address address,
    String accountNumber,
    Address serviceAddress,
    String meterNumber,
    String tariffPlan,
    DateTime connectionDate,
    DateTime lastLogin,
    UserPreferences preferences,
    AccountBalance accountBalance,
    UsageSummary usageSummary,
    UserProfile profile,
    UserSettings settings,
    UserSecurity security,
    List<PaymentMethod> paymentMethods,
    List<NotificationHistory> notificationHistory,
    UserStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $AddressCopyWith<$Res> get serviceAddress;
  @override
  $UserPreferencesCopyWith<$Res> get preferences;
  @override
  $AccountBalanceCopyWith<$Res> get accountBalance;
  @override
  $UsageSummaryCopyWith<$Res> get usageSummary;
  @override
  $UserProfileCopyWith<$Res> get profile;
  @override
  $UserSettingsCopyWith<$Res> get settings;
  @override
  $UserSecurityCopyWith<$Res> get security;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? address = null,
    Object? accountNumber = null,
    Object? serviceAddress = null,
    Object? meterNumber = null,
    Object? tariffPlan = null,
    Object? connectionDate = null,
    Object? lastLogin = null,
    Object? preferences = null,
    Object? accountBalance = null,
    Object? usageSummary = null,
    Object? profile = null,
    Object? settings = null,
    Object? security = null,
    Object? paymentMethods = null,
    Object? notificationHistory = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as Address,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        serviceAddress: null == serviceAddress
            ? _value.serviceAddress
            : serviceAddress // ignore: cast_nullable_to_non_nullable
                  as Address,
        meterNumber: null == meterNumber
            ? _value.meterNumber
            : meterNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        tariffPlan: null == tariffPlan
            ? _value.tariffPlan
            : tariffPlan // ignore: cast_nullable_to_non_nullable
                  as String,
        connectionDate: null == connectionDate
            ? _value.connectionDate
            : connectionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastLogin: null == lastLogin
            ? _value.lastLogin
            : lastLogin // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        preferences: null == preferences
            ? _value.preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as UserPreferences,
        accountBalance: null == accountBalance
            ? _value.accountBalance
            : accountBalance // ignore: cast_nullable_to_non_nullable
                  as AccountBalance,
        usageSummary: null == usageSummary
            ? _value.usageSummary
            : usageSummary // ignore: cast_nullable_to_non_nullable
                  as UsageSummary,
        profile: null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfile,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as UserSettings,
        security: null == security
            ? _value.security
            : security // ignore: cast_nullable_to_non_nullable
                  as UserSecurity,
        paymentMethods: null == paymentMethods
            ? _value._paymentMethods
            : paymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<PaymentMethod>,
        notificationHistory: null == notificationHistory
            ? _value._notificationHistory
            : notificationHistory // ignore: cast_nullable_to_non_nullable
                  as List<NotificationHistory>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as UserStatus,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.accountNumber,
    required this.serviceAddress,
    required this.meterNumber,
    required this.tariffPlan,
    required this.connectionDate,
    required this.lastLogin,
    required this.preferences,
    required this.accountBalance,
    required this.usageSummary,
    this.profile = const UserProfile(),
    this.settings = const UserSettings(),
    this.security = const UserSecurity(),
    final List<PaymentMethod> paymentMethods = const [],
    final List<NotificationHistory> notificationHistory = const [],
    this.status = UserStatus.active,
    this.createdAt,
    this.updatedAt,
  }) : _paymentMethods = paymentMethods,
       _notificationHistory = notificationHistory,
       super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  final Address address;
  @override
  final String accountNumber;
  @override
  final Address serviceAddress;
  @override
  final String meterNumber;
  @override
  final String tariffPlan;
  @override
  final DateTime connectionDate;
  @override
  final DateTime lastLogin;
  @override
  final UserPreferences preferences;
  @override
  final AccountBalance accountBalance;
  @override
  final UsageSummary usageSummary;
  @override
  @JsonKey()
  final UserProfile profile;
  @override
  @JsonKey()
  final UserSettings settings;
  @override
  @JsonKey()
  final UserSecurity security;
  final List<PaymentMethod> _paymentMethods;
  @override
  @JsonKey()
  List<PaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  final List<NotificationHistory> _notificationHistory;
  @override
  @JsonKey()
  List<NotificationHistory> get notificationHistory {
    if (_notificationHistory is EqualUnmodifiableListView)
      return _notificationHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationHistory);
  }

  @override
  @JsonKey()
  final UserStatus status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, address: $address, accountNumber: $accountNumber, serviceAddress: $serviceAddress, meterNumber: $meterNumber, tariffPlan: $tariffPlan, connectionDate: $connectionDate, lastLogin: $lastLogin, preferences: $preferences, accountBalance: $accountBalance, usageSummary: $usageSummary, profile: $profile, settings: $settings, security: $security, paymentMethods: $paymentMethods, notificationHistory: $notificationHistory, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.serviceAddress, serviceAddress) ||
                other.serviceAddress == serviceAddress) &&
            (identical(other.meterNumber, meterNumber) ||
                other.meterNumber == meterNumber) &&
            (identical(other.tariffPlan, tariffPlan) ||
                other.tariffPlan == tariffPlan) &&
            (identical(other.connectionDate, connectionDate) ||
                other.connectionDate == connectionDate) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance) &&
            (identical(other.usageSummary, usageSummary) ||
                other.usageSummary == usageSummary) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.security, security) ||
                other.security == security) &&
            const DeepCollectionEquality().equals(
              other._paymentMethods,
              _paymentMethods,
            ) &&
            const DeepCollectionEquality().equals(
              other._notificationHistory,
              _notificationHistory,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    phone,
    address,
    accountNumber,
    serviceAddress,
    meterNumber,
    tariffPlan,
    connectionDate,
    lastLogin,
    preferences,
    accountBalance,
    usageSummary,
    profile,
    settings,
    security,
    const DeepCollectionEquality().hash(_paymentMethods),
    const DeepCollectionEquality().hash(_notificationHistory),
    status,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User extends User {
  const factory _User({
    required final String id,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final String phone,
    required final Address address,
    required final String accountNumber,
    required final Address serviceAddress,
    required final String meterNumber,
    required final String tariffPlan,
    required final DateTime connectionDate,
    required final DateTime lastLogin,
    required final UserPreferences preferences,
    required final AccountBalance accountBalance,
    required final UsageSummary usageSummary,
    final UserProfile profile,
    final UserSettings settings,
    final UserSecurity security,
    final List<PaymentMethod> paymentMethods,
    final List<NotificationHistory> notificationHistory,
    final UserStatus status,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  Address get address;
  @override
  String get accountNumber;
  @override
  Address get serviceAddress;
  @override
  String get meterNumber;
  @override
  String get tariffPlan;
  @override
  DateTime get connectionDate;
  @override
  DateTime get lastLogin;
  @override
  UserPreferences get preferences;
  @override
  AccountBalance get accountBalance;
  @override
  UsageSummary get usageSummary;
  @override
  UserProfile get profile;
  @override
  UserSettings get settings;
  @override
  UserSecurity get security;
  @override
  List<PaymentMethod> get paymentMethods;
  @override
  List<NotificationHistory> get notificationHistory;
  @override
  UserStatus get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String get street => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({
    String street,
    String city,
    String state,
    String zipCode,
    String country,
  });
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? country = null,
  }) {
    return _then(
      _value.copyWith(
            street: null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            zipCode: null == zipCode
                ? _value.zipCode
                : zipCode // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
    _$AddressImpl value,
    $Res Function(_$AddressImpl) then,
  ) = __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String street,
    String city,
    String state,
    String zipCode,
    String country,
  });
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
    _$AddressImpl _value,
    $Res Function(_$AddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? country = null,
  }) {
    return _then(
      _$AddressImpl(
        street: null == street
            ? _value.street
            : street // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        zipCode: null == zipCode
            ? _value.zipCode
            : zipCode // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl extends _Address {
  const _$AddressImpl({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  }) : super._();

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String street;
  @override
  final String city;
  @override
  final String state;
  @override
  final String zipCode;
  @override
  final String country;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, street, city, state, zipCode, country);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(this);
  }
}

abstract class _Address extends Address {
  const factory _Address({
    required final String street,
    required final String city,
    required final String state,
    required final String zipCode,
    required final String country,
  }) = _$AddressImpl;
  const _Address._() : super._();

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String get street;
  @override
  String get city;
  @override
  String get state;
  @override
  String get zipCode;
  @override
  String get country;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return _UserPreferences.fromJson(json);
}

/// @nodoc
mixin _$UserPreferences {
  NotificationSettings get notifications => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferencesCopyWith<UserPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferencesCopyWith<$Res> {
  factory $UserPreferencesCopyWith(
    UserPreferences value,
    $Res Function(UserPreferences) then,
  ) = _$UserPreferencesCopyWithImpl<$Res, UserPreferences>;
  @useResult
  $Res call({
    NotificationSettings notifications,
    String currency,
    String timezone,
    String language,
  });

  $NotificationSettingsCopyWith<$Res> get notifications;
}

/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res, $Val extends UserPreferences>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? currency = null,
    Object? timezone = null,
    Object? language = null,
  }) {
    return _then(
      _value.copyWith(
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as NotificationSettings,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            timezone: null == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notifications {
    return $NotificationSettingsCopyWith<$Res>(_value.notifications, (value) {
      return _then(_value.copyWith(notifications: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserPreferencesImplCopyWith<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  factory _$$UserPreferencesImplCopyWith(
    _$UserPreferencesImpl value,
    $Res Function(_$UserPreferencesImpl) then,
  ) = __$$UserPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    NotificationSettings notifications,
    String currency,
    String timezone,
    String language,
  });

  @override
  $NotificationSettingsCopyWith<$Res> get notifications;
}

/// @nodoc
class __$$UserPreferencesImplCopyWithImpl<$Res>
    extends _$UserPreferencesCopyWithImpl<$Res, _$UserPreferencesImpl>
    implements _$$UserPreferencesImplCopyWith<$Res> {
  __$$UserPreferencesImplCopyWithImpl(
    _$UserPreferencesImpl _value,
    $Res Function(_$UserPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? currency = null,
    Object? timezone = null,
    Object? language = null,
  }) {
    return _then(
      _$UserPreferencesImpl(
        notifications: null == notifications
            ? _value.notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as NotificationSettings,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        timezone: null == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPreferencesImpl implements _UserPreferences {
  const _$UserPreferencesImpl({
    required this.notifications,
    required this.currency,
    required this.timezone,
    required this.language,
  });

  factory _$UserPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferencesImplFromJson(json);

  @override
  final NotificationSettings notifications;
  @override
  final String currency;
  @override
  final String timezone;
  @override
  final String language;

  @override
  String toString() {
    return 'UserPreferences(notifications: $notifications, currency: $currency, timezone: $timezone, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferencesImpl &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notifications, currency, timezone, language);

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      __$$UserPreferencesImplCopyWithImpl<_$UserPreferencesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferencesImplToJson(this);
  }
}

abstract class _UserPreferences implements UserPreferences {
  const factory _UserPreferences({
    required final NotificationSettings notifications,
    required final String currency,
    required final String timezone,
    required final String language,
  }) = _$UserPreferencesImpl;

  factory _UserPreferences.fromJson(Map<String, dynamic> json) =
      _$UserPreferencesImpl.fromJson;

  @override
  NotificationSettings get notifications;
  @override
  String get currency;
  @override
  String get timezone;
  @override
  String get language;

  /// Create a copy of UserPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferencesImplCopyWith<_$UserPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  bool get email => throw _privateConstructorUsedError;
  bool get sms => throw _privateConstructorUsedError;
  bool get push => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(
    NotificationSettings value,
    $Res Function(NotificationSettings) then,
  ) = _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call({bool email, bool sms, bool push});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<
  $Res,
  $Val extends NotificationSettings
>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? sms = null, Object? push = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as bool,
            sms: null == sms
                ? _value.sms
                : sms // ignore: cast_nullable_to_non_nullable
                      as bool,
            push: null == push
                ? _value.push
                : push // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(
    _$NotificationSettingsImpl value,
    $Res Function(_$NotificationSettingsImpl) then,
  ) = __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool email, bool sms, bool push});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(
    _$NotificationSettingsImpl _value,
    $Res Function(_$NotificationSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? sms = null, Object? push = null}) {
    return _then(
      _$NotificationSettingsImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as bool,
        sms: null == sms
            ? _value.sms
            : sms // ignore: cast_nullable_to_non_nullable
                  as bool,
        push: null == push
            ? _value.push
            : push // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl({
    required this.email,
    required this.sms,
    required this.push,
  });

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  final bool email;
  @override
  final bool sms;
  @override
  final bool push;

  @override
  String toString() {
    return 'NotificationSettings(email: $email, sms: $sms, push: $push)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.sms, sms) || other.sms == sms) &&
            (identical(other.push, push) || other.push == push));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, sms, push);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
  get copyWith =>
      __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(this);
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings({
    required final bool email,
    required final bool sms,
    required final bool push,
  }) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  bool get email;
  @override
  bool get sms;
  @override
  bool get push;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AccountBalance _$AccountBalanceFromJson(Map<String, dynamic> json) {
  return _AccountBalance.fromJson(json);
}

/// @nodoc
mixin _$AccountBalance {
  double get currentBalance => throw _privateConstructorUsedError;
  DateTime get lastPaymentDate => throw _privateConstructorUsedError;
  double get lastPaymentAmount => throw _privateConstructorUsedError;
  DateTime get nextDueDate => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this AccountBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountBalanceCopyWith<AccountBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountBalanceCopyWith<$Res> {
  factory $AccountBalanceCopyWith(
    AccountBalance value,
    $Res Function(AccountBalance) then,
  ) = _$AccountBalanceCopyWithImpl<$Res, AccountBalance>;
  @useResult
  $Res call({
    double currentBalance,
    DateTime lastPaymentDate,
    double lastPaymentAmount,
    DateTime nextDueDate,
    String paymentMethod,
  });
}

/// @nodoc
class _$AccountBalanceCopyWithImpl<$Res, $Val extends AccountBalance>
    implements $AccountBalanceCopyWith<$Res> {
  _$AccountBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? lastPaymentDate = null,
    Object? lastPaymentAmount = null,
    Object? nextDueDate = null,
    Object? paymentMethod = null,
  }) {
    return _then(
      _value.copyWith(
            currentBalance: null == currentBalance
                ? _value.currentBalance
                : currentBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            lastPaymentDate: null == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastPaymentAmount: null == lastPaymentAmount
                ? _value.lastPaymentAmount
                : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            nextDueDate: null == nextDueDate
                ? _value.nextDueDate
                : nextDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountBalanceImplCopyWith<$Res>
    implements $AccountBalanceCopyWith<$Res> {
  factory _$$AccountBalanceImplCopyWith(
    _$AccountBalanceImpl value,
    $Res Function(_$AccountBalanceImpl) then,
  ) = __$$AccountBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double currentBalance,
    DateTime lastPaymentDate,
    double lastPaymentAmount,
    DateTime nextDueDate,
    String paymentMethod,
  });
}

/// @nodoc
class __$$AccountBalanceImplCopyWithImpl<$Res>
    extends _$AccountBalanceCopyWithImpl<$Res, _$AccountBalanceImpl>
    implements _$$AccountBalanceImplCopyWith<$Res> {
  __$$AccountBalanceImplCopyWithImpl(
    _$AccountBalanceImpl _value,
    $Res Function(_$AccountBalanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? lastPaymentDate = null,
    Object? lastPaymentAmount = null,
    Object? nextDueDate = null,
    Object? paymentMethod = null,
  }) {
    return _then(
      _$AccountBalanceImpl(
        currentBalance: null == currentBalance
            ? _value.currentBalance
            : currentBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        lastPaymentDate: null == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastPaymentAmount: null == lastPaymentAmount
            ? _value.lastPaymentAmount
            : lastPaymentAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        nextDueDate: null == nextDueDate
            ? _value.nextDueDate
            : nextDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountBalanceImpl implements _AccountBalance {
  const _$AccountBalanceImpl({
    required this.currentBalance,
    required this.lastPaymentDate,
    required this.lastPaymentAmount,
    required this.nextDueDate,
    required this.paymentMethod,
  });

  factory _$AccountBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountBalanceImplFromJson(json);

  @override
  final double currentBalance;
  @override
  final DateTime lastPaymentDate;
  @override
  final double lastPaymentAmount;
  @override
  final DateTime nextDueDate;
  @override
  final String paymentMethod;

  @override
  String toString() {
    return 'AccountBalance(currentBalance: $currentBalance, lastPaymentDate: $lastPaymentDate, lastPaymentAmount: $lastPaymentAmount, nextDueDate: $nextDueDate, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountBalanceImpl &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.lastPaymentAmount, lastPaymentAmount) ||
                other.lastPaymentAmount == lastPaymentAmount) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentBalance,
    lastPaymentDate,
    lastPaymentAmount,
    nextDueDate,
    paymentMethod,
  );

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountBalanceImplCopyWith<_$AccountBalanceImpl> get copyWith =>
      __$$AccountBalanceImplCopyWithImpl<_$AccountBalanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountBalanceImplToJson(this);
  }
}

abstract class _AccountBalance implements AccountBalance {
  const factory _AccountBalance({
    required final double currentBalance,
    required final DateTime lastPaymentDate,
    required final double lastPaymentAmount,
    required final DateTime nextDueDate,
    required final String paymentMethod,
  }) = _$AccountBalanceImpl;

  factory _AccountBalance.fromJson(Map<String, dynamic> json) =
      _$AccountBalanceImpl.fromJson;

  @override
  double get currentBalance;
  @override
  DateTime get lastPaymentDate;
  @override
  double get lastPaymentAmount;
  @override
  DateTime get nextDueDate;
  @override
  String get paymentMethod;

  /// Create a copy of AccountBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountBalanceImplCopyWith<_$AccountBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageSummary _$UsageSummaryFromJson(Map<String, dynamic> json) {
  return _UsageSummary.fromJson(json);
}

/// @nodoc
mixin _$UsageSummary {
  UsagePeriod get currentMonth => throw _privateConstructorUsedError;
  UsagePeriod get lastMonth => throw _privateConstructorUsedError;
  UsagePeriod get yearToDate => throw _privateConstructorUsedError;

  /// Serializes this UsageSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageSummaryCopyWith<UsageSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageSummaryCopyWith<$Res> {
  factory $UsageSummaryCopyWith(
    UsageSummary value,
    $Res Function(UsageSummary) then,
  ) = _$UsageSummaryCopyWithImpl<$Res, UsageSummary>;
  @useResult
  $Res call({
    UsagePeriod currentMonth,
    UsagePeriod lastMonth,
    UsagePeriod yearToDate,
  });

  $UsagePeriodCopyWith<$Res> get currentMonth;
  $UsagePeriodCopyWith<$Res> get lastMonth;
  $UsagePeriodCopyWith<$Res> get yearToDate;
}

/// @nodoc
class _$UsageSummaryCopyWithImpl<$Res, $Val extends UsageSummary>
    implements $UsageSummaryCopyWith<$Res> {
  _$UsageSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMonth = null,
    Object? lastMonth = null,
    Object? yearToDate = null,
  }) {
    return _then(
      _value.copyWith(
            currentMonth: null == currentMonth
                ? _value.currentMonth
                : currentMonth // ignore: cast_nullable_to_non_nullable
                      as UsagePeriod,
            lastMonth: null == lastMonth
                ? _value.lastMonth
                : lastMonth // ignore: cast_nullable_to_non_nullable
                      as UsagePeriod,
            yearToDate: null == yearToDate
                ? _value.yearToDate
                : yearToDate // ignore: cast_nullable_to_non_nullable
                      as UsagePeriod,
          )
          as $Val,
    );
  }

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsagePeriodCopyWith<$Res> get currentMonth {
    return $UsagePeriodCopyWith<$Res>(_value.currentMonth, (value) {
      return _then(_value.copyWith(currentMonth: value) as $Val);
    });
  }

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsagePeriodCopyWith<$Res> get lastMonth {
    return $UsagePeriodCopyWith<$Res>(_value.lastMonth, (value) {
      return _then(_value.copyWith(lastMonth: value) as $Val);
    });
  }

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsagePeriodCopyWith<$Res> get yearToDate {
    return $UsagePeriodCopyWith<$Res>(_value.yearToDate, (value) {
      return _then(_value.copyWith(yearToDate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UsageSummaryImplCopyWith<$Res>
    implements $UsageSummaryCopyWith<$Res> {
  factory _$$UsageSummaryImplCopyWith(
    _$UsageSummaryImpl value,
    $Res Function(_$UsageSummaryImpl) then,
  ) = __$$UsageSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UsagePeriod currentMonth,
    UsagePeriod lastMonth,
    UsagePeriod yearToDate,
  });

  @override
  $UsagePeriodCopyWith<$Res> get currentMonth;
  @override
  $UsagePeriodCopyWith<$Res> get lastMonth;
  @override
  $UsagePeriodCopyWith<$Res> get yearToDate;
}

/// @nodoc
class __$$UsageSummaryImplCopyWithImpl<$Res>
    extends _$UsageSummaryCopyWithImpl<$Res, _$UsageSummaryImpl>
    implements _$$UsageSummaryImplCopyWith<$Res> {
  __$$UsageSummaryImplCopyWithImpl(
    _$UsageSummaryImpl _value,
    $Res Function(_$UsageSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentMonth = null,
    Object? lastMonth = null,
    Object? yearToDate = null,
  }) {
    return _then(
      _$UsageSummaryImpl(
        currentMonth: null == currentMonth
            ? _value.currentMonth
            : currentMonth // ignore: cast_nullable_to_non_nullable
                  as UsagePeriod,
        lastMonth: null == lastMonth
            ? _value.lastMonth
            : lastMonth // ignore: cast_nullable_to_non_nullable
                  as UsagePeriod,
        yearToDate: null == yearToDate
            ? _value.yearToDate
            : yearToDate // ignore: cast_nullable_to_non_nullable
                  as UsagePeriod,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageSummaryImpl implements _UsageSummary {
  const _$UsageSummaryImpl({
    required this.currentMonth,
    required this.lastMonth,
    required this.yearToDate,
  });

  factory _$UsageSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageSummaryImplFromJson(json);

  @override
  final UsagePeriod currentMonth;
  @override
  final UsagePeriod lastMonth;
  @override
  final UsagePeriod yearToDate;

  @override
  String toString() {
    return 'UsageSummary(currentMonth: $currentMonth, lastMonth: $lastMonth, yearToDate: $yearToDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageSummaryImpl &&
            (identical(other.currentMonth, currentMonth) ||
                other.currentMonth == currentMonth) &&
            (identical(other.lastMonth, lastMonth) ||
                other.lastMonth == lastMonth) &&
            (identical(other.yearToDate, yearToDate) ||
                other.yearToDate == yearToDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentMonth, lastMonth, yearToDate);

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageSummaryImplCopyWith<_$UsageSummaryImpl> get copyWith =>
      __$$UsageSummaryImplCopyWithImpl<_$UsageSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageSummaryImplToJson(this);
  }
}

abstract class _UsageSummary implements UsageSummary {
  const factory _UsageSummary({
    required final UsagePeriod currentMonth,
    required final UsagePeriod lastMonth,
    required final UsagePeriod yearToDate,
  }) = _$UsageSummaryImpl;

  factory _UsageSummary.fromJson(Map<String, dynamic> json) =
      _$UsageSummaryImpl.fromJson;

  @override
  UsagePeriod get currentMonth;
  @override
  UsagePeriod get lastMonth;
  @override
  UsagePeriod get yearToDate;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageSummaryImplCopyWith<_$UsageSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsagePeriod _$UsagePeriodFromJson(Map<String, dynamic> json) {
  return _UsagePeriod.fromJson(json);
}

/// @nodoc
mixin _$UsagePeriod {
  double get kwh => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  double get averageDaily => throw _privateConstructorUsedError;

  /// Serializes this UsagePeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsagePeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsagePeriodCopyWith<UsagePeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsagePeriodCopyWith<$Res> {
  factory $UsagePeriodCopyWith(
    UsagePeriod value,
    $Res Function(UsagePeriod) then,
  ) = _$UsagePeriodCopyWithImpl<$Res, UsagePeriod>;
  @useResult
  $Res call({double kwh, double cost, double averageDaily});
}

/// @nodoc
class _$UsagePeriodCopyWithImpl<$Res, $Val extends UsagePeriod>
    implements $UsagePeriodCopyWith<$Res> {
  _$UsagePeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsagePeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kwh = null,
    Object? cost = null,
    Object? averageDaily = null,
  }) {
    return _then(
      _value.copyWith(
            kwh: null == kwh
                ? _value.kwh
                : kwh // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            averageDaily: null == averageDaily
                ? _value.averageDaily
                : averageDaily // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsagePeriodImplCopyWith<$Res>
    implements $UsagePeriodCopyWith<$Res> {
  factory _$$UsagePeriodImplCopyWith(
    _$UsagePeriodImpl value,
    $Res Function(_$UsagePeriodImpl) then,
  ) = __$$UsagePeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double kwh, double cost, double averageDaily});
}

/// @nodoc
class __$$UsagePeriodImplCopyWithImpl<$Res>
    extends _$UsagePeriodCopyWithImpl<$Res, _$UsagePeriodImpl>
    implements _$$UsagePeriodImplCopyWith<$Res> {
  __$$UsagePeriodImplCopyWithImpl(
    _$UsagePeriodImpl _value,
    $Res Function(_$UsagePeriodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsagePeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kwh = null,
    Object? cost = null,
    Object? averageDaily = null,
  }) {
    return _then(
      _$UsagePeriodImpl(
        kwh: null == kwh
            ? _value.kwh
            : kwh // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        averageDaily: null == averageDaily
            ? _value.averageDaily
            : averageDaily // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsagePeriodImpl implements _UsagePeriod {
  const _$UsagePeriodImpl({
    required this.kwh,
    required this.cost,
    required this.averageDaily,
  });

  factory _$UsagePeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsagePeriodImplFromJson(json);

  @override
  final double kwh;
  @override
  final double cost;
  @override
  final double averageDaily;

  @override
  String toString() {
    return 'UsagePeriod(kwh: $kwh, cost: $cost, averageDaily: $averageDaily)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsagePeriodImpl &&
            (identical(other.kwh, kwh) || other.kwh == kwh) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.averageDaily, averageDaily) ||
                other.averageDaily == averageDaily));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, kwh, cost, averageDaily);

  /// Create a copy of UsagePeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsagePeriodImplCopyWith<_$UsagePeriodImpl> get copyWith =>
      __$$UsagePeriodImplCopyWithImpl<_$UsagePeriodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsagePeriodImplToJson(this);
  }
}

abstract class _UsagePeriod implements UsagePeriod {
  const factory _UsagePeriod({
    required final double kwh,
    required final double cost,
    required final double averageDaily,
  }) = _$UsagePeriodImpl;

  factory _UsagePeriod.fromJson(Map<String, dynamic> json) =
      _$UsagePeriodImpl.fromJson;

  @override
  double get kwh;
  @override
  double get cost;
  @override
  double get averageDaily;

  /// Create a copy of UsagePeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsagePeriodImplCopyWith<_$UsagePeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String? get profilePicture => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get occupation => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  List<String> get socialLinks => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String? profilePicture,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? occupation,
    String? company,
    String? website,
    List<String> interests,
    List<String> socialLinks,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
    Object? bio = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? occupation = freezed,
    Object? company = freezed,
    Object? website = freezed,
    Object? interests = null,
    Object? socialLinks = null,
  }) {
    return _then(
      _value.copyWith(
            profilePicture: freezed == profilePicture
                ? _value.profilePicture
                : profilePicture // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as String?,
            company: freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            interests: null == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            socialLinks: null == socialLinks
                ? _value.socialLinks
                : socialLinks // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? profilePicture,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? occupation,
    String? company,
    String? website,
    List<String> interests,
    List<String> socialLinks,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
    Object? bio = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? occupation = freezed,
    Object? company = freezed,
    Object? website = freezed,
    Object? interests = null,
    Object? socialLinks = null,
  }) {
    return _then(
      _$UserProfileImpl(
        profilePicture: freezed == profilePicture
            ? _value.profilePicture
            : profilePicture // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        occupation: freezed == occupation
            ? _value.occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as String?,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        interests: null == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        socialLinks: null == socialLinks
            ? _value._socialLinks
            : socialLinks // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    this.profilePicture,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.occupation,
    this.company,
    this.website,
    final List<String> interests = const [],
    final List<String> socialLinks = const [],
  }) : _interests = interests,
       _socialLinks = socialLinks;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String? profilePicture;
  @override
  final String? bio;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? gender;
  @override
  final String? occupation;
  @override
  final String? company;
  @override
  final String? website;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  final List<String> _socialLinks;
  @override
  @JsonKey()
  List<String> get socialLinks {
    if (_socialLinks is EqualUnmodifiableListView) return _socialLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_socialLinks);
  }

  @override
  String toString() {
    return 'UserProfile(profilePicture: $profilePicture, bio: $bio, dateOfBirth: $dateOfBirth, gender: $gender, occupation: $occupation, company: $company, website: $website, interests: $interests, socialLinks: $socialLinks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.website, website) || other.website == website) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            const DeepCollectionEquality().equals(
              other._socialLinks,
              _socialLinks,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    profilePicture,
    bio,
    dateOfBirth,
    gender,
    occupation,
    company,
    website,
    const DeepCollectionEquality().hash(_interests),
    const DeepCollectionEquality().hash(_socialLinks),
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    final String? profilePicture,
    final String? bio,
    final DateTime? dateOfBirth,
    final String? gender,
    final String? occupation,
    final String? company,
    final String? website,
    final List<String> interests,
    final List<String> socialLinks,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String? get profilePicture;
  @override
  String? get bio;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get gender;
  @override
  String? get occupation;
  @override
  String? get company;
  @override
  String? get website;
  @override
  List<String> get interests;
  @override
  List<String> get socialLinks;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  bool get darkMode => throw _privateConstructorUsedError;
  bool get autoRefresh => throw _privateConstructorUsedError;
  int get refreshIntervalMinutes => throw _privateConstructorUsedError;
  bool get showNotifications => throw _privateConstructorUsedError;
  bool get showUsageAlerts => throw _privateConstructorUsedError;
  bool get showPaymentReminders => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  int get dateFormat => throw _privateConstructorUsedError;
  bool get analyticsEnabled => throw _privateConstructorUsedError;
  bool get crashReportingEnabled => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
    UserSettings value,
    $Res Function(UserSettings) then,
  ) = _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({
    bool darkMode,
    bool autoRefresh,
    int refreshIntervalMinutes,
    bool showNotifications,
    bool showUsageAlerts,
    bool showPaymentReminders,
    String language,
    String currency,
    String timezone,
    int dateFormat,
    bool analyticsEnabled,
    bool crashReportingEnabled,
  });
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? autoRefresh = null,
    Object? refreshIntervalMinutes = null,
    Object? showNotifications = null,
    Object? showUsageAlerts = null,
    Object? showPaymentReminders = null,
    Object? language = null,
    Object? currency = null,
    Object? timezone = null,
    Object? dateFormat = null,
    Object? analyticsEnabled = null,
    Object? crashReportingEnabled = null,
  }) {
    return _then(
      _value.copyWith(
            darkMode: null == darkMode
                ? _value.darkMode
                : darkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            autoRefresh: null == autoRefresh
                ? _value.autoRefresh
                : autoRefresh // ignore: cast_nullable_to_non_nullable
                      as bool,
            refreshIntervalMinutes: null == refreshIntervalMinutes
                ? _value.refreshIntervalMinutes
                : refreshIntervalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            showNotifications: null == showNotifications
                ? _value.showNotifications
                : showNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            showUsageAlerts: null == showUsageAlerts
                ? _value.showUsageAlerts
                : showUsageAlerts // ignore: cast_nullable_to_non_nullable
                      as bool,
            showPaymentReminders: null == showPaymentReminders
                ? _value.showPaymentReminders
                : showPaymentReminders // ignore: cast_nullable_to_non_nullable
                      as bool,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            timezone: null == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String,
            dateFormat: null == dateFormat
                ? _value.dateFormat
                : dateFormat // ignore: cast_nullable_to_non_nullable
                      as int,
            analyticsEnabled: null == analyticsEnabled
                ? _value.analyticsEnabled
                : analyticsEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            crashReportingEnabled: null == crashReportingEnabled
                ? _value.crashReportingEnabled
                : crashReportingEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
    _$UserSettingsImpl value,
    $Res Function(_$UserSettingsImpl) then,
  ) = __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool darkMode,
    bool autoRefresh,
    int refreshIntervalMinutes,
    bool showNotifications,
    bool showUsageAlerts,
    bool showPaymentReminders,
    String language,
    String currency,
    String timezone,
    int dateFormat,
    bool analyticsEnabled,
    bool crashReportingEnabled,
  });
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
    _$UserSettingsImpl _value,
    $Res Function(_$UserSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
    Object? autoRefresh = null,
    Object? refreshIntervalMinutes = null,
    Object? showNotifications = null,
    Object? showUsageAlerts = null,
    Object? showPaymentReminders = null,
    Object? language = null,
    Object? currency = null,
    Object? timezone = null,
    Object? dateFormat = null,
    Object? analyticsEnabled = null,
    Object? crashReportingEnabled = null,
  }) {
    return _then(
      _$UserSettingsImpl(
        darkMode: null == darkMode
            ? _value.darkMode
            : darkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        autoRefresh: null == autoRefresh
            ? _value.autoRefresh
            : autoRefresh // ignore: cast_nullable_to_non_nullable
                  as bool,
        refreshIntervalMinutes: null == refreshIntervalMinutes
            ? _value.refreshIntervalMinutes
            : refreshIntervalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        showNotifications: null == showNotifications
            ? _value.showNotifications
            : showNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        showUsageAlerts: null == showUsageAlerts
            ? _value.showUsageAlerts
            : showUsageAlerts // ignore: cast_nullable_to_non_nullable
                  as bool,
        showPaymentReminders: null == showPaymentReminders
            ? _value.showPaymentReminders
            : showPaymentReminders // ignore: cast_nullable_to_non_nullable
                  as bool,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        timezone: null == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String,
        dateFormat: null == dateFormat
            ? _value.dateFormat
            : dateFormat // ignore: cast_nullable_to_non_nullable
                  as int,
        analyticsEnabled: null == analyticsEnabled
            ? _value.analyticsEnabled
            : analyticsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        crashReportingEnabled: null == crashReportingEnabled
            ? _value.crashReportingEnabled
            : crashReportingEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl({
    this.darkMode = true,
    this.autoRefresh = true,
    this.refreshIntervalMinutes = 30,
    this.showNotifications = true,
    this.showUsageAlerts = true,
    this.showPaymentReminders = true,
    this.language = 'en',
    this.currency = 'USD',
    this.timezone = 'America/New_York',
    this.dateFormat = 12,
    this.analyticsEnabled = true,
    this.crashReportingEnabled = true,
  });

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool darkMode;
  @override
  @JsonKey()
  final bool autoRefresh;
  @override
  @JsonKey()
  final int refreshIntervalMinutes;
  @override
  @JsonKey()
  final bool showNotifications;
  @override
  @JsonKey()
  final bool showUsageAlerts;
  @override
  @JsonKey()
  final bool showPaymentReminders;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey()
  final int dateFormat;
  @override
  @JsonKey()
  final bool analyticsEnabled;
  @override
  @JsonKey()
  final bool crashReportingEnabled;

  @override
  String toString() {
    return 'UserSettings(darkMode: $darkMode, autoRefresh: $autoRefresh, refreshIntervalMinutes: $refreshIntervalMinutes, showNotifications: $showNotifications, showUsageAlerts: $showUsageAlerts, showPaymentReminders: $showPaymentReminders, language: $language, currency: $currency, timezone: $timezone, dateFormat: $dateFormat, analyticsEnabled: $analyticsEnabled, crashReportingEnabled: $crashReportingEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode) &&
            (identical(other.autoRefresh, autoRefresh) ||
                other.autoRefresh == autoRefresh) &&
            (identical(other.refreshIntervalMinutes, refreshIntervalMinutes) ||
                other.refreshIntervalMinutes == refreshIntervalMinutes) &&
            (identical(other.showNotifications, showNotifications) ||
                other.showNotifications == showNotifications) &&
            (identical(other.showUsageAlerts, showUsageAlerts) ||
                other.showUsageAlerts == showUsageAlerts) &&
            (identical(other.showPaymentReminders, showPaymentReminders) ||
                other.showPaymentReminders == showPaymentReminders) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.analyticsEnabled, analyticsEnabled) ||
                other.analyticsEnabled == analyticsEnabled) &&
            (identical(other.crashReportingEnabled, crashReportingEnabled) ||
                other.crashReportingEnabled == crashReportingEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    darkMode,
    autoRefresh,
    refreshIntervalMinutes,
    showNotifications,
    showUsageAlerts,
    showPaymentReminders,
    language,
    currency,
    timezone,
    dateFormat,
    analyticsEnabled,
    crashReportingEnabled,
  );

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(this);
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings({
    final bool darkMode,
    final bool autoRefresh,
    final int refreshIntervalMinutes,
    final bool showNotifications,
    final bool showUsageAlerts,
    final bool showPaymentReminders,
    final String language,
    final String currency,
    final String timezone,
    final int dateFormat,
    final bool analyticsEnabled,
    final bool crashReportingEnabled,
  }) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  bool get darkMode;
  @override
  bool get autoRefresh;
  @override
  int get refreshIntervalMinutes;
  @override
  bool get showNotifications;
  @override
  bool get showUsageAlerts;
  @override
  bool get showPaymentReminders;
  @override
  String get language;
  @override
  String get currency;
  @override
  String get timezone;
  @override
  int get dateFormat;
  @override
  bool get analyticsEnabled;
  @override
  bool get crashReportingEnabled;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSecurity _$UserSecurityFromJson(Map<String, dynamic> json) {
  return _UserSecurity.fromJson(json);
}

/// @nodoc
mixin _$UserSecurity {
  bool get twoFactorEnabled => throw _privateConstructorUsedError;
  bool get biometricEnabled => throw _privateConstructorUsedError;
  List<String> get trustedDevices => throw _privateConstructorUsedError;
  DateTime? get lastPasswordChange => throw _privateConstructorUsedError;
  int get failedLoginAttempts => throw _privateConstructorUsedError;
  DateTime? get lastFailedLogin => throw _privateConstructorUsedError;
  bool get accountLocked => throw _privateConstructorUsedError;
  DateTime? get accountLockedUntil => throw _privateConstructorUsedError;

  /// Serializes this UserSecurity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSecurity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSecurityCopyWith<UserSecurity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSecurityCopyWith<$Res> {
  factory $UserSecurityCopyWith(
    UserSecurity value,
    $Res Function(UserSecurity) then,
  ) = _$UserSecurityCopyWithImpl<$Res, UserSecurity>;
  @useResult
  $Res call({
    bool twoFactorEnabled,
    bool biometricEnabled,
    List<String> trustedDevices,
    DateTime? lastPasswordChange,
    int failedLoginAttempts,
    DateTime? lastFailedLogin,
    bool accountLocked,
    DateTime? accountLockedUntil,
  });
}

/// @nodoc
class _$UserSecurityCopyWithImpl<$Res, $Val extends UserSecurity>
    implements $UserSecurityCopyWith<$Res> {
  _$UserSecurityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSecurity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twoFactorEnabled = null,
    Object? biometricEnabled = null,
    Object? trustedDevices = null,
    Object? lastPasswordChange = freezed,
    Object? failedLoginAttempts = null,
    Object? lastFailedLogin = freezed,
    Object? accountLocked = null,
    Object? accountLockedUntil = freezed,
  }) {
    return _then(
      _value.copyWith(
            twoFactorEnabled: null == twoFactorEnabled
                ? _value.twoFactorEnabled
                : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            biometricEnabled: null == biometricEnabled
                ? _value.biometricEnabled
                : biometricEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustedDevices: null == trustedDevices
                ? _value.trustedDevices
                : trustedDevices // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastPasswordChange: freezed == lastPasswordChange
                ? _value.lastPasswordChange
                : lastPasswordChange // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            failedLoginAttempts: null == failedLoginAttempts
                ? _value.failedLoginAttempts
                : failedLoginAttempts // ignore: cast_nullable_to_non_nullable
                      as int,
            lastFailedLogin: freezed == lastFailedLogin
                ? _value.lastFailedLogin
                : lastFailedLogin // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            accountLocked: null == accountLocked
                ? _value.accountLocked
                : accountLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            accountLockedUntil: freezed == accountLockedUntil
                ? _value.accountLockedUntil
                : accountLockedUntil // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSecurityImplCopyWith<$Res>
    implements $UserSecurityCopyWith<$Res> {
  factory _$$UserSecurityImplCopyWith(
    _$UserSecurityImpl value,
    $Res Function(_$UserSecurityImpl) then,
  ) = __$$UserSecurityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool twoFactorEnabled,
    bool biometricEnabled,
    List<String> trustedDevices,
    DateTime? lastPasswordChange,
    int failedLoginAttempts,
    DateTime? lastFailedLogin,
    bool accountLocked,
    DateTime? accountLockedUntil,
  });
}

/// @nodoc
class __$$UserSecurityImplCopyWithImpl<$Res>
    extends _$UserSecurityCopyWithImpl<$Res, _$UserSecurityImpl>
    implements _$$UserSecurityImplCopyWith<$Res> {
  __$$UserSecurityImplCopyWithImpl(
    _$UserSecurityImpl _value,
    $Res Function(_$UserSecurityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSecurity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twoFactorEnabled = null,
    Object? biometricEnabled = null,
    Object? trustedDevices = null,
    Object? lastPasswordChange = freezed,
    Object? failedLoginAttempts = null,
    Object? lastFailedLogin = freezed,
    Object? accountLocked = null,
    Object? accountLockedUntil = freezed,
  }) {
    return _then(
      _$UserSecurityImpl(
        twoFactorEnabled: null == twoFactorEnabled
            ? _value.twoFactorEnabled
            : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        biometricEnabled: null == biometricEnabled
            ? _value.biometricEnabled
            : biometricEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustedDevices: null == trustedDevices
            ? _value._trustedDevices
            : trustedDevices // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastPasswordChange: freezed == lastPasswordChange
            ? _value.lastPasswordChange
            : lastPasswordChange // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        failedLoginAttempts: null == failedLoginAttempts
            ? _value.failedLoginAttempts
            : failedLoginAttempts // ignore: cast_nullable_to_non_nullable
                  as int,
        lastFailedLogin: freezed == lastFailedLogin
            ? _value.lastFailedLogin
            : lastFailedLogin // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        accountLocked: null == accountLocked
            ? _value.accountLocked
            : accountLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        accountLockedUntil: freezed == accountLockedUntil
            ? _value.accountLockedUntil
            : accountLockedUntil // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSecurityImpl implements _UserSecurity {
  const _$UserSecurityImpl({
    this.twoFactorEnabled = false,
    this.biometricEnabled = false,
    final List<String> trustedDevices = const [],
    this.lastPasswordChange,
    this.failedLoginAttempts = 0,
    this.lastFailedLogin,
    this.accountLocked = false,
    this.accountLockedUntil,
  }) : _trustedDevices = trustedDevices;

  factory _$UserSecurityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSecurityImplFromJson(json);

  @override
  @JsonKey()
  final bool twoFactorEnabled;
  @override
  @JsonKey()
  final bool biometricEnabled;
  final List<String> _trustedDevices;
  @override
  @JsonKey()
  List<String> get trustedDevices {
    if (_trustedDevices is EqualUnmodifiableListView) return _trustedDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trustedDevices);
  }

  @override
  final DateTime? lastPasswordChange;
  @override
  @JsonKey()
  final int failedLoginAttempts;
  @override
  final DateTime? lastFailedLogin;
  @override
  @JsonKey()
  final bool accountLocked;
  @override
  final DateTime? accountLockedUntil;

  @override
  String toString() {
    return 'UserSecurity(twoFactorEnabled: $twoFactorEnabled, biometricEnabled: $biometricEnabled, trustedDevices: $trustedDevices, lastPasswordChange: $lastPasswordChange, failedLoginAttempts: $failedLoginAttempts, lastFailedLogin: $lastFailedLogin, accountLocked: $accountLocked, accountLockedUntil: $accountLockedUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSecurityImpl &&
            (identical(other.twoFactorEnabled, twoFactorEnabled) ||
                other.twoFactorEnabled == twoFactorEnabled) &&
            (identical(other.biometricEnabled, biometricEnabled) ||
                other.biometricEnabled == biometricEnabled) &&
            const DeepCollectionEquality().equals(
              other._trustedDevices,
              _trustedDevices,
            ) &&
            (identical(other.lastPasswordChange, lastPasswordChange) ||
                other.lastPasswordChange == lastPasswordChange) &&
            (identical(other.failedLoginAttempts, failedLoginAttempts) ||
                other.failedLoginAttempts == failedLoginAttempts) &&
            (identical(other.lastFailedLogin, lastFailedLogin) ||
                other.lastFailedLogin == lastFailedLogin) &&
            (identical(other.accountLocked, accountLocked) ||
                other.accountLocked == accountLocked) &&
            (identical(other.accountLockedUntil, accountLockedUntil) ||
                other.accountLockedUntil == accountLockedUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    twoFactorEnabled,
    biometricEnabled,
    const DeepCollectionEquality().hash(_trustedDevices),
    lastPasswordChange,
    failedLoginAttempts,
    lastFailedLogin,
    accountLocked,
    accountLockedUntil,
  );

  /// Create a copy of UserSecurity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSecurityImplCopyWith<_$UserSecurityImpl> get copyWith =>
      __$$UserSecurityImplCopyWithImpl<_$UserSecurityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSecurityImplToJson(this);
  }
}

abstract class _UserSecurity implements UserSecurity {
  const factory _UserSecurity({
    final bool twoFactorEnabled,
    final bool biometricEnabled,
    final List<String> trustedDevices,
    final DateTime? lastPasswordChange,
    final int failedLoginAttempts,
    final DateTime? lastFailedLogin,
    final bool accountLocked,
    final DateTime? accountLockedUntil,
  }) = _$UserSecurityImpl;

  factory _UserSecurity.fromJson(Map<String, dynamic> json) =
      _$UserSecurityImpl.fromJson;

  @override
  bool get twoFactorEnabled;
  @override
  bool get biometricEnabled;
  @override
  List<String> get trustedDevices;
  @override
  DateTime? get lastPasswordChange;
  @override
  int get failedLoginAttempts;
  @override
  DateTime? get lastFailedLogin;
  @override
  bool get accountLocked;
  @override
  DateTime? get accountLockedUntil;

  /// Create a copy of UserSecurity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSecurityImplCopyWith<_$UserSecurityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get lastFourDigits => throw _privateConstructorUsedError;
  String get cardholderName => throw _privateConstructorUsedError;
  DateTime get expiryDate => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
    PaymentMethod value,
    $Res Function(PaymentMethod) then,
  ) = _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call({
    String id,
    String type,
    String lastFourDigits,
    String cardholderName,
    DateTime expiryDate,
    bool isPrimary,
    bool isActive,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? lastFourDigits = null,
    Object? cardholderName = null,
    Object? expiryDate = null,
    Object? isPrimary = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            lastFourDigits: null == lastFourDigits
                ? _value.lastFourDigits
                : lastFourDigits // ignore: cast_nullable_to_non_nullable
                      as String,
            cardholderName: null == cardholderName
                ? _value.cardholderName
                : cardholderName // ignore: cast_nullable_to_non_nullable
                      as String,
            expiryDate: null == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isPrimary: null == isPrimary
                ? _value.isPrimary
                : isPrimary // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
    _$PaymentMethodImpl value,
    $Res Function(_$PaymentMethodImpl) then,
  ) = __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String lastFourDigits,
    String cardholderName,
    DateTime expiryDate,
    bool isPrimary,
    bool isActive,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
    _$PaymentMethodImpl _value,
    $Res Function(_$PaymentMethodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? lastFourDigits = null,
    Object? cardholderName = null,
    Object? expiryDate = null,
    Object? isPrimary = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PaymentMethodImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        lastFourDigits: null == lastFourDigits
            ? _value.lastFourDigits
            : lastFourDigits // ignore: cast_nullable_to_non_nullable
                  as String,
        cardholderName: null == cardholderName
            ? _value.cardholderName
            : cardholderName // ignore: cast_nullable_to_non_nullable
                  as String,
        expiryDate: null == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isPrimary: null == isPrimary
            ? _value.isPrimary
            : isPrimary // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodImpl extends _PaymentMethod {
  const _$PaymentMethodImpl({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.cardholderName,
    required this.expiryDate,
    this.isPrimary = false,
    this.isActive = false,
    this.createdAt,
  }) : super._();

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String lastFourDigits;
  @override
  final String cardholderName;
  @override
  final DateTime expiryDate;
  @override
  @JsonKey()
  final bool isPrimary;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PaymentMethod(id: $id, type: $type, lastFourDigits: $lastFourDigits, cardholderName: $cardholderName, expiryDate: $expiryDate, isPrimary: $isPrimary, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastFourDigits, lastFourDigits) ||
                other.lastFourDigits == lastFourDigits) &&
            (identical(other.cardholderName, cardholderName) ||
                other.cardholderName == cardholderName) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    lastFourDigits,
    cardholderName,
    expiryDate,
    isPrimary,
    isActive,
    createdAt,
  );

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(this);
  }
}

abstract class _PaymentMethod extends PaymentMethod {
  const factory _PaymentMethod({
    required final String id,
    required final String type,
    required final String lastFourDigits,
    required final String cardholderName,
    required final DateTime expiryDate,
    final bool isPrimary,
    final bool isActive,
    final DateTime? createdAt,
  }) = _$PaymentMethodImpl;
  const _PaymentMethod._() : super._();

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get lastFourDigits;
  @override
  String get cardholderName;
  @override
  DateTime get expiryDate;
  @override
  bool get isPrimary;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationHistory _$NotificationHistoryFromJson(Map<String, dynamic> json) {
  return _NotificationHistory.fromJson(json);
}

/// @nodoc
mixin _$NotificationHistory {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this NotificationHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationHistoryCopyWith<NotificationHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationHistoryCopyWith<$Res> {
  factory $NotificationHistoryCopyWith(
    NotificationHistory value,
    $Res Function(NotificationHistory) then,
  ) = _$NotificationHistoryCopyWithImpl<$Res, NotificationHistory>;
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String message,
    DateTime timestamp,
    bool isRead,
    bool isImportant,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$NotificationHistoryCopyWithImpl<$Res, $Val extends NotificationHistory>
    implements $NotificationHistoryCopyWith<$Res> {
  _$NotificationHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isImportant = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isImportant: null == isImportant
                ? _value.isImportant
                : isImportant // ignore: cast_nullable_to_non_nullable
                      as bool,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationHistoryImplCopyWith<$Res>
    implements $NotificationHistoryCopyWith<$Res> {
  factory _$$NotificationHistoryImplCopyWith(
    _$NotificationHistoryImpl value,
    $Res Function(_$NotificationHistoryImpl) then,
  ) = __$$NotificationHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String message,
    DateTime timestamp,
    bool isRead,
    bool isImportant,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$NotificationHistoryImplCopyWithImpl<$Res>
    extends _$NotificationHistoryCopyWithImpl<$Res, _$NotificationHistoryImpl>
    implements _$$NotificationHistoryImplCopyWith<$Res> {
  __$$NotificationHistoryImplCopyWithImpl(
    _$NotificationHistoryImpl _value,
    $Res Function(_$NotificationHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isImportant = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$NotificationHistoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isImportant: null == isImportant
            ? _value.isImportant
            : isImportant // ignore: cast_nullable_to_non_nullable
                  as bool,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationHistoryImpl implements _NotificationHistory {
  const _$NotificationHistoryImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.isImportant = false,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$NotificationHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String title;
  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isImportant;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NotificationHistory(id: $id, type: $type, title: $title, message: $message, timestamp: $timestamp, isRead: $isRead, isImportant: $isImportant, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    title,
    message,
    timestamp,
    isRead,
    isImportant,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of NotificationHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationHistoryImplCopyWith<_$NotificationHistoryImpl> get copyWith =>
      __$$NotificationHistoryImplCopyWithImpl<_$NotificationHistoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationHistoryImplToJson(this);
  }
}

abstract class _NotificationHistory implements NotificationHistory {
  const factory _NotificationHistory({
    required final String id,
    required final String type,
    required final String title,
    required final String message,
    required final DateTime timestamp,
    final bool isRead,
    final bool isImportant,
    final Map<String, dynamic>? metadata,
  }) = _$NotificationHistoryImpl;

  factory _NotificationHistory.fromJson(Map<String, dynamic> json) =
      _$NotificationHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get title;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  bool get isRead;
  @override
  bool get isImportant;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of NotificationHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationHistoryImplCopyWith<_$NotificationHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
