// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  String get id => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get customerNumber =>
      throw _privateConstructorUsedError; // Added customer number field
  String get accountType =>
      throw _privateConstructorUsedError; // 'residential' or 'commercial'
  String get address => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  AccountStatus get status =>
      throw _privateConstructorUsedError; // 'Paid', 'Due', 'Overdue'
  DateTime? get lastPaymentDate => throw _privateConstructorUsedError;
  DateTime? get nextDueDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get meterNumber => throw _privateConstructorUsedError;
  String? get serviceArea => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String customerNumber,
    String accountType,
    String address,
    double balance,
    AccountStatus status,
    DateTime? lastPaymentDate,
    DateTime? nextDueDate,
    bool isActive,
    String? meterNumber,
    String? serviceArea,
    String? nickname,
  });
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? customerNumber = null,
    Object? accountType = null,
    Object? address = null,
    Object? balance = null,
    Object? status = null,
    Object? lastPaymentDate = freezed,
    Object? nextDueDate = freezed,
    Object? isActive = null,
    Object? meterNumber = freezed,
    Object? serviceArea = freezed,
    Object? nickname = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            customerNumber: null == customerNumber
                ? _value.customerNumber
                : customerNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            accountType: null == accountType
                ? _value.accountType
                : accountType // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AccountStatus,
            lastPaymentDate: freezed == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            nextDueDate: freezed == nextDueDate
                ? _value.nextDueDate
                : nextDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            meterNumber: freezed == meterNumber
                ? _value.meterNumber
                : meterNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceArea: freezed == serviceArea
                ? _value.serviceArea
                : serviceArea // ignore: cast_nullable_to_non_nullable
                      as String?,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(
    _$AccountImpl value,
    $Res Function(_$AccountImpl) then,
  ) = __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String customerNumber,
    String accountType,
    String address,
    double balance,
    AccountStatus status,
    DateTime? lastPaymentDate,
    DateTime? nextDueDate,
    bool isActive,
    String? meterNumber,
    String? serviceArea,
    String? nickname,
  });
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(
    _$AccountImpl _value,
    $Res Function(_$AccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? customerNumber = null,
    Object? accountType = null,
    Object? address = null,
    Object? balance = null,
    Object? status = null,
    Object? lastPaymentDate = freezed,
    Object? nextDueDate = freezed,
    Object? isActive = null,
    Object? meterNumber = freezed,
    Object? serviceArea = freezed,
    Object? nickname = freezed,
  }) {
    return _then(
      _$AccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        customerNumber: null == customerNumber
            ? _value.customerNumber
            : customerNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountType: null == accountType
            ? _value.accountType
            : accountType // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AccountStatus,
        lastPaymentDate: freezed == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        nextDueDate: freezed == nextDueDate
            ? _value.nextDueDate
            : nextDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        meterNumber: freezed == meterNumber
            ? _value.meterNumber
            : meterNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceArea: freezed == serviceArea
            ? _value.serviceArea
            : serviceArea // ignore: cast_nullable_to_non_nullable
                  as String?,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountImpl extends _Account {
  const _$AccountImpl({
    required this.id,
    required this.accountNumber,
    required this.customerNumber,
    required this.accountType,
    required this.address,
    required this.balance,
    required this.status,
    required this.lastPaymentDate,
    required this.nextDueDate,
    this.isActive = true,
    this.meterNumber,
    this.serviceArea,
    this.nickname,
  }) : super._();

  factory _$AccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountImplFromJson(json);

  @override
  final String id;
  @override
  final String accountNumber;
  @override
  final String customerNumber;
  // Added customer number field
  @override
  final String accountType;
  // 'residential' or 'commercial'
  @override
  final String address;
  @override
  final double balance;
  @override
  final AccountStatus status;
  // 'Paid', 'Due', 'Overdue'
  @override
  final DateTime? lastPaymentDate;
  @override
  final DateTime? nextDueDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? meterNumber;
  @override
  final String? serviceArea;
  @override
  final String? nickname;

  @override
  String toString() {
    return 'Account(id: $id, accountNumber: $accountNumber, customerNumber: $customerNumber, accountType: $accountType, address: $address, balance: $balance, status: $status, lastPaymentDate: $lastPaymentDate, nextDueDate: $nextDueDate, isActive: $isActive, meterNumber: $meterNumber, serviceArea: $serviceArea, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.customerNumber, customerNumber) ||
                other.customerNumber == customerNumber) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.meterNumber, meterNumber) ||
                other.meterNumber == meterNumber) &&
            (identical(other.serviceArea, serviceArea) ||
                other.serviceArea == serviceArea) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountNumber,
    customerNumber,
    accountType,
    address,
    balance,
    status,
    lastPaymentDate,
    nextDueDate,
    isActive,
    meterNumber,
    serviceArea,
    nickname,
  );

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountImplToJson(this);
  }
}

abstract class _Account extends Account {
  const factory _Account({
    required final String id,
    required final String accountNumber,
    required final String customerNumber,
    required final String accountType,
    required final String address,
    required final double balance,
    required final AccountStatus status,
    required final DateTime? lastPaymentDate,
    required final DateTime? nextDueDate,
    final bool isActive,
    final String? meterNumber,
    final String? serviceArea,
    final String? nickname,
  }) = _$AccountImpl;
  const _Account._() : super._();

  factory _Account.fromJson(Map<String, dynamic> json) = _$AccountImpl.fromJson;

  @override
  String get id;
  @override
  String get accountNumber;
  @override
  String get customerNumber; // Added customer number field
  @override
  String get accountType; // 'residential' or 'commercial'
  @override
  String get address;
  @override
  double get balance;
  @override
  AccountStatus get status; // 'Paid', 'Due', 'Overdue'
  @override
  DateTime? get lastPaymentDate;
  @override
  DateTime? get nextDueDate;
  @override
  bool get isActive;
  @override
  String? get meterNumber;
  @override
  String? get serviceArea;
  @override
  String? get nickname;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
