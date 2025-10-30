// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bill _$BillFromJson(Map<String, dynamic> json) {
  return _Bill.fromJson(json);
}

/// @nodoc
mixin _$Bill {
  String get id => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get billNumber => throw _privateConstructorUsedError;
  BillingPeriod get billingPeriod => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  DateTime get issueDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  BillAmounts get amounts => throw _privateConstructorUsedError;
  BillUsage get usage => throw _privateConstructorUsedError;
  BillPayment get payment => throw _privateConstructorUsedError;
  String get pdfUrl => throw _privateConstructorUsedError;
  List<PaymentHistory> get paymentHistory => throw _privateConstructorUsedError;
  List<BillAdjustment> get adjustments => throw _privateConstructorUsedError;
  List<BillFee> get fees => throw _privateConstructorUsedError;
  List<BillTax> get taxes => throw _privateConstructorUsedError;
  List<BillDiscount> get discounts => throw _privateConstructorUsedError;
  BillCalculations get calculations => throw _privateConstructorUsedError;
  List<BillNote> get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Bill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillCopyWith<Bill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillCopyWith<$Res> {
  factory $BillCopyWith(Bill value, $Res Function(Bill) then) =
      _$BillCopyWithImpl<$Res, Bill>;
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String billNumber,
    BillingPeriod billingPeriod,
    DateTime dueDate,
    DateTime issueDate,
    String status,
    BillAmounts amounts,
    BillUsage usage,
    BillPayment payment,
    String pdfUrl,
    List<PaymentHistory> paymentHistory,
    List<BillAdjustment> adjustments,
    List<BillFee> fees,
    List<BillTax> taxes,
    List<BillDiscount> discounts,
    BillCalculations calculations,
    List<BillNote> notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $BillingPeriodCopyWith<$Res> get billingPeriod;
  $BillAmountsCopyWith<$Res> get amounts;
  $BillUsageCopyWith<$Res> get usage;
  $BillPaymentCopyWith<$Res> get payment;
  $BillCalculationsCopyWith<$Res> get calculations;
}

/// @nodoc
class _$BillCopyWithImpl<$Res, $Val extends Bill>
    implements $BillCopyWith<$Res> {
  _$BillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? billNumber = null,
    Object? billingPeriod = null,
    Object? dueDate = null,
    Object? issueDate = null,
    Object? status = null,
    Object? amounts = null,
    Object? usage = null,
    Object? payment = null,
    Object? pdfUrl = null,
    Object? paymentHistory = null,
    Object? adjustments = null,
    Object? fees = null,
    Object? taxes = null,
    Object? discounts = null,
    Object? calculations = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            billNumber: null == billNumber
                ? _value.billNumber
                : billNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            billingPeriod: null == billingPeriod
                ? _value.billingPeriod
                : billingPeriod // ignore: cast_nullable_to_non_nullable
                      as BillingPeriod,
            dueDate: null == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            issueDate: null == issueDate
                ? _value.issueDate
                : issueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            amounts: null == amounts
                ? _value.amounts
                : amounts // ignore: cast_nullable_to_non_nullable
                      as BillAmounts,
            usage: null == usage
                ? _value.usage
                : usage // ignore: cast_nullable_to_non_nullable
                      as BillUsage,
            payment: null == payment
                ? _value.payment
                : payment // ignore: cast_nullable_to_non_nullable
                      as BillPayment,
            pdfUrl: null == pdfUrl
                ? _value.pdfUrl
                : pdfUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentHistory: null == paymentHistory
                ? _value.paymentHistory
                : paymentHistory // ignore: cast_nullable_to_non_nullable
                      as List<PaymentHistory>,
            adjustments: null == adjustments
                ? _value.adjustments
                : adjustments // ignore: cast_nullable_to_non_nullable
                      as List<BillAdjustment>,
            fees: null == fees
                ? _value.fees
                : fees // ignore: cast_nullable_to_non_nullable
                      as List<BillFee>,
            taxes: null == taxes
                ? _value.taxes
                : taxes // ignore: cast_nullable_to_non_nullable
                      as List<BillTax>,
            discounts: null == discounts
                ? _value.discounts
                : discounts // ignore: cast_nullable_to_non_nullable
                      as List<BillDiscount>,
            calculations: null == calculations
                ? _value.calculations
                : calculations // ignore: cast_nullable_to_non_nullable
                      as BillCalculations,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as List<BillNote>,
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

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillingPeriodCopyWith<$Res> get billingPeriod {
    return $BillingPeriodCopyWith<$Res>(_value.billingPeriod, (value) {
      return _then(_value.copyWith(billingPeriod: value) as $Val);
    });
  }

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillAmountsCopyWith<$Res> get amounts {
    return $BillAmountsCopyWith<$Res>(_value.amounts, (value) {
      return _then(_value.copyWith(amounts: value) as $Val);
    });
  }

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillUsageCopyWith<$Res> get usage {
    return $BillUsageCopyWith<$Res>(_value.usage, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillPaymentCopyWith<$Res> get payment {
    return $BillPaymentCopyWith<$Res>(_value.payment, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillCalculationsCopyWith<$Res> get calculations {
    return $BillCalculationsCopyWith<$Res>(_value.calculations, (value) {
      return _then(_value.copyWith(calculations: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BillImplCopyWith<$Res> implements $BillCopyWith<$Res> {
  factory _$$BillImplCopyWith(
    _$BillImpl value,
    $Res Function(_$BillImpl) then,
  ) = __$$BillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String accountNumber,
    String billNumber,
    BillingPeriod billingPeriod,
    DateTime dueDate,
    DateTime issueDate,
    String status,
    BillAmounts amounts,
    BillUsage usage,
    BillPayment payment,
    String pdfUrl,
    List<PaymentHistory> paymentHistory,
    List<BillAdjustment> adjustments,
    List<BillFee> fees,
    List<BillTax> taxes,
    List<BillDiscount> discounts,
    BillCalculations calculations,
    List<BillNote> notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $BillingPeriodCopyWith<$Res> get billingPeriod;
  @override
  $BillAmountsCopyWith<$Res> get amounts;
  @override
  $BillUsageCopyWith<$Res> get usage;
  @override
  $BillPaymentCopyWith<$Res> get payment;
  @override
  $BillCalculationsCopyWith<$Res> get calculations;
}

/// @nodoc
class __$$BillImplCopyWithImpl<$Res>
    extends _$BillCopyWithImpl<$Res, _$BillImpl>
    implements _$$BillImplCopyWith<$Res> {
  __$$BillImplCopyWithImpl(_$BillImpl _value, $Res Function(_$BillImpl) _then)
    : super(_value, _then);

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountNumber = null,
    Object? billNumber = null,
    Object? billingPeriod = null,
    Object? dueDate = null,
    Object? issueDate = null,
    Object? status = null,
    Object? amounts = null,
    Object? usage = null,
    Object? payment = null,
    Object? pdfUrl = null,
    Object? paymentHistory = null,
    Object? adjustments = null,
    Object? fees = null,
    Object? taxes = null,
    Object? discounts = null,
    Object? calculations = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        billNumber: null == billNumber
            ? _value.billNumber
            : billNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        billingPeriod: null == billingPeriod
            ? _value.billingPeriod
            : billingPeriod // ignore: cast_nullable_to_non_nullable
                  as BillingPeriod,
        dueDate: null == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        issueDate: null == issueDate
            ? _value.issueDate
            : issueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        amounts: null == amounts
            ? _value.amounts
            : amounts // ignore: cast_nullable_to_non_nullable
                  as BillAmounts,
        usage: null == usage
            ? _value.usage
            : usage // ignore: cast_nullable_to_non_nullable
                  as BillUsage,
        payment: null == payment
            ? _value.payment
            : payment // ignore: cast_nullable_to_non_nullable
                  as BillPayment,
        pdfUrl: null == pdfUrl
            ? _value.pdfUrl
            : pdfUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentHistory: null == paymentHistory
            ? _value._paymentHistory
            : paymentHistory // ignore: cast_nullable_to_non_nullable
                  as List<PaymentHistory>,
        adjustments: null == adjustments
            ? _value._adjustments
            : adjustments // ignore: cast_nullable_to_non_nullable
                  as List<BillAdjustment>,
        fees: null == fees
            ? _value._fees
            : fees // ignore: cast_nullable_to_non_nullable
                  as List<BillFee>,
        taxes: null == taxes
            ? _value._taxes
            : taxes // ignore: cast_nullable_to_non_nullable
                  as List<BillTax>,
        discounts: null == discounts
            ? _value._discounts
            : discounts // ignore: cast_nullable_to_non_nullable
                  as List<BillDiscount>,
        calculations: null == calculations
            ? _value.calculations
            : calculations // ignore: cast_nullable_to_non_nullable
                  as BillCalculations,
        notes: null == notes
            ? _value._notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as List<BillNote>,
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
class _$BillImpl extends _Bill {
  const _$BillImpl({
    required this.id,
    required this.accountNumber,
    required this.billNumber,
    required this.billingPeriod,
    required this.dueDate,
    required this.issueDate,
    required this.status,
    required this.amounts,
    required this.usage,
    required this.payment,
    required this.pdfUrl,
    final List<PaymentHistory> paymentHistory = const [],
    final List<BillAdjustment> adjustments = const [],
    final List<BillFee> fees = const [],
    final List<BillTax> taxes = const [],
    final List<BillDiscount> discounts = const [],
    this.calculations = const BillCalculations(),
    final List<BillNote> notes = const [],
    this.createdAt,
    this.updatedAt,
  }) : _paymentHistory = paymentHistory,
       _adjustments = adjustments,
       _fees = fees,
       _taxes = taxes,
       _discounts = discounts,
       _notes = notes,
       super._();

  factory _$BillImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillImplFromJson(json);

  @override
  final String id;
  @override
  final String accountNumber;
  @override
  final String billNumber;
  @override
  final BillingPeriod billingPeriod;
  @override
  final DateTime dueDate;
  @override
  final DateTime issueDate;
  @override
  final String status;
  @override
  final BillAmounts amounts;
  @override
  final BillUsage usage;
  @override
  final BillPayment payment;
  @override
  final String pdfUrl;
  final List<PaymentHistory> _paymentHistory;
  @override
  @JsonKey()
  List<PaymentHistory> get paymentHistory {
    if (_paymentHistory is EqualUnmodifiableListView) return _paymentHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentHistory);
  }

  final List<BillAdjustment> _adjustments;
  @override
  @JsonKey()
  List<BillAdjustment> get adjustments {
    if (_adjustments is EqualUnmodifiableListView) return _adjustments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adjustments);
  }

  final List<BillFee> _fees;
  @override
  @JsonKey()
  List<BillFee> get fees {
    if (_fees is EqualUnmodifiableListView) return _fees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fees);
  }

  final List<BillTax> _taxes;
  @override
  @JsonKey()
  List<BillTax> get taxes {
    if (_taxes is EqualUnmodifiableListView) return _taxes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taxes);
  }

  final List<BillDiscount> _discounts;
  @override
  @JsonKey()
  List<BillDiscount> get discounts {
    if (_discounts is EqualUnmodifiableListView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discounts);
  }

  @override
  @JsonKey()
  final BillCalculations calculations;
  final List<BillNote> _notes;
  @override
  @JsonKey()
  List<BillNote> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Bill(id: $id, accountNumber: $accountNumber, billNumber: $billNumber, billingPeriod: $billingPeriod, dueDate: $dueDate, issueDate: $issueDate, status: $status, amounts: $amounts, usage: $usage, payment: $payment, pdfUrl: $pdfUrl, paymentHistory: $paymentHistory, adjustments: $adjustments, fees: $fees, taxes: $taxes, discounts: $discounts, calculations: $calculations, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amounts, amounts) || other.amounts == amounts) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            const DeepCollectionEquality().equals(
              other._paymentHistory,
              _paymentHistory,
            ) &&
            const DeepCollectionEquality().equals(
              other._adjustments,
              _adjustments,
            ) &&
            const DeepCollectionEquality().equals(other._fees, _fees) &&
            const DeepCollectionEquality().equals(other._taxes, _taxes) &&
            const DeepCollectionEquality().equals(
              other._discounts,
              _discounts,
            ) &&
            (identical(other.calculations, calculations) ||
                other.calculations == calculations) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
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
    accountNumber,
    billNumber,
    billingPeriod,
    dueDate,
    issueDate,
    status,
    amounts,
    usage,
    payment,
    pdfUrl,
    const DeepCollectionEquality().hash(_paymentHistory),
    const DeepCollectionEquality().hash(_adjustments),
    const DeepCollectionEquality().hash(_fees),
    const DeepCollectionEquality().hash(_taxes),
    const DeepCollectionEquality().hash(_discounts),
    calculations,
    const DeepCollectionEquality().hash(_notes),
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillImplCopyWith<_$BillImpl> get copyWith =>
      __$$BillImplCopyWithImpl<_$BillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillImplToJson(this);
  }
}

abstract class _Bill extends Bill {
  const factory _Bill({
    required final String id,
    required final String accountNumber,
    required final String billNumber,
    required final BillingPeriod billingPeriod,
    required final DateTime dueDate,
    required final DateTime issueDate,
    required final String status,
    required final BillAmounts amounts,
    required final BillUsage usage,
    required final BillPayment payment,
    required final String pdfUrl,
    final List<PaymentHistory> paymentHistory,
    final List<BillAdjustment> adjustments,
    final List<BillFee> fees,
    final List<BillTax> taxes,
    final List<BillDiscount> discounts,
    final BillCalculations calculations,
    final List<BillNote> notes,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$BillImpl;
  const _Bill._() : super._();

  factory _Bill.fromJson(Map<String, dynamic> json) = _$BillImpl.fromJson;

  @override
  String get id;
  @override
  String get accountNumber;
  @override
  String get billNumber;
  @override
  BillingPeriod get billingPeriod;
  @override
  DateTime get dueDate;
  @override
  DateTime get issueDate;
  @override
  String get status;
  @override
  BillAmounts get amounts;
  @override
  BillUsage get usage;
  @override
  BillPayment get payment;
  @override
  String get pdfUrl;
  @override
  List<PaymentHistory> get paymentHistory;
  @override
  List<BillAdjustment> get adjustments;
  @override
  List<BillFee> get fees;
  @override
  List<BillTax> get taxes;
  @override
  List<BillDiscount> get discounts;
  @override
  BillCalculations get calculations;
  @override
  List<BillNote> get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillImplCopyWith<_$BillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillingPeriod _$BillingPeriodFromJson(Map<String, dynamic> json) {
  return _BillingPeriod.fromJson(json);
}

/// @nodoc
mixin _$BillingPeriod {
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this BillingPeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillingPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillingPeriodCopyWith<BillingPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillingPeriodCopyWith<$Res> {
  factory $BillingPeriodCopyWith(
    BillingPeriod value,
    $Res Function(BillingPeriod) then,
  ) = _$BillingPeriodCopyWithImpl<$Res, BillingPeriod>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate});
}

/// @nodoc
class _$BillingPeriodCopyWithImpl<$Res, $Val extends BillingPeriod>
    implements $BillingPeriodCopyWith<$Res> {
  _$BillingPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillingPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = null, Object? endDate = null}) {
    return _then(
      _value.copyWith(
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillingPeriodImplCopyWith<$Res>
    implements $BillingPeriodCopyWith<$Res> {
  factory _$$BillingPeriodImplCopyWith(
    _$BillingPeriodImpl value,
    $Res Function(_$BillingPeriodImpl) then,
  ) = __$$BillingPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$BillingPeriodImplCopyWithImpl<$Res>
    extends _$BillingPeriodCopyWithImpl<$Res, _$BillingPeriodImpl>
    implements _$$BillingPeriodImplCopyWith<$Res> {
  __$$BillingPeriodImplCopyWithImpl(
    _$BillingPeriodImpl _value,
    $Res Function(_$BillingPeriodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = null, Object? endDate = null}) {
    return _then(
      _$BillingPeriodImpl(
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillingPeriodImpl implements _BillingPeriod {
  const _$BillingPeriodImpl({required this.startDate, required this.endDate});

  factory _$BillingPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillingPeriodImplFromJson(json);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'BillingPeriod(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillingPeriodImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of BillingPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillingPeriodImplCopyWith<_$BillingPeriodImpl> get copyWith =>
      __$$BillingPeriodImplCopyWithImpl<_$BillingPeriodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillingPeriodImplToJson(this);
  }
}

abstract class _BillingPeriod implements BillingPeriod {
  const factory _BillingPeriod({
    required final DateTime startDate,
    required final DateTime endDate,
  }) = _$BillingPeriodImpl;

  factory _BillingPeriod.fromJson(Map<String, dynamic> json) =
      _$BillingPeriodImpl.fromJson;

  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of BillingPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillingPeriodImplCopyWith<_$BillingPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillAmounts _$BillAmountsFromJson(Map<String, dynamic> json) {
  return _BillAmounts.fromJson(json);
}

/// @nodoc
mixin _$BillAmounts {
  double get totalAmount => throw _privateConstructorUsedError;
  double get previousBalance => throw _privateConstructorUsedError;
  double get currentCharges => throw _privateConstructorUsedError;
  double get taxes => throw _privateConstructorUsedError;
  double get fees => throw _privateConstructorUsedError;
  double get adjustments => throw _privateConstructorUsedError;
  double get discounts => throw _privateConstructorUsedError;
  double get lateFees => throw _privateConstructorUsedError;
  double get paymentFees => throw _privateConstructorUsedError;
  double get serviceCharges => throw _privateConstructorUsedError;

  /// Serializes this BillAmounts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillAmounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillAmountsCopyWith<BillAmounts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillAmountsCopyWith<$Res> {
  factory $BillAmountsCopyWith(
    BillAmounts value,
    $Res Function(BillAmounts) then,
  ) = _$BillAmountsCopyWithImpl<$Res, BillAmounts>;
  @useResult
  $Res call({
    double totalAmount,
    double previousBalance,
    double currentCharges,
    double taxes,
    double fees,
    double adjustments,
    double discounts,
    double lateFees,
    double paymentFees,
    double serviceCharges,
  });
}

/// @nodoc
class _$BillAmountsCopyWithImpl<$Res, $Val extends BillAmounts>
    implements $BillAmountsCopyWith<$Res> {
  _$BillAmountsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillAmounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAmount = null,
    Object? previousBalance = null,
    Object? currentCharges = null,
    Object? taxes = null,
    Object? fees = null,
    Object? adjustments = null,
    Object? discounts = null,
    Object? lateFees = null,
    Object? paymentFees = null,
    Object? serviceCharges = null,
  }) {
    return _then(
      _value.copyWith(
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            previousBalance: null == previousBalance
                ? _value.previousBalance
                : previousBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            currentCharges: null == currentCharges
                ? _value.currentCharges
                : currentCharges // ignore: cast_nullable_to_non_nullable
                      as double,
            taxes: null == taxes
                ? _value.taxes
                : taxes // ignore: cast_nullable_to_non_nullable
                      as double,
            fees: null == fees
                ? _value.fees
                : fees // ignore: cast_nullable_to_non_nullable
                      as double,
            adjustments: null == adjustments
                ? _value.adjustments
                : adjustments // ignore: cast_nullable_to_non_nullable
                      as double,
            discounts: null == discounts
                ? _value.discounts
                : discounts // ignore: cast_nullable_to_non_nullable
                      as double,
            lateFees: null == lateFees
                ? _value.lateFees
                : lateFees // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentFees: null == paymentFees
                ? _value.paymentFees
                : paymentFees // ignore: cast_nullable_to_non_nullable
                      as double,
            serviceCharges: null == serviceCharges
                ? _value.serviceCharges
                : serviceCharges // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillAmountsImplCopyWith<$Res>
    implements $BillAmountsCopyWith<$Res> {
  factory _$$BillAmountsImplCopyWith(
    _$BillAmountsImpl value,
    $Res Function(_$BillAmountsImpl) then,
  ) = __$$BillAmountsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalAmount,
    double previousBalance,
    double currentCharges,
    double taxes,
    double fees,
    double adjustments,
    double discounts,
    double lateFees,
    double paymentFees,
    double serviceCharges,
  });
}

/// @nodoc
class __$$BillAmountsImplCopyWithImpl<$Res>
    extends _$BillAmountsCopyWithImpl<$Res, _$BillAmountsImpl>
    implements _$$BillAmountsImplCopyWith<$Res> {
  __$$BillAmountsImplCopyWithImpl(
    _$BillAmountsImpl _value,
    $Res Function(_$BillAmountsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillAmounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAmount = null,
    Object? previousBalance = null,
    Object? currentCharges = null,
    Object? taxes = null,
    Object? fees = null,
    Object? adjustments = null,
    Object? discounts = null,
    Object? lateFees = null,
    Object? paymentFees = null,
    Object? serviceCharges = null,
  }) {
    return _then(
      _$BillAmountsImpl(
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        previousBalance: null == previousBalance
            ? _value.previousBalance
            : previousBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        currentCharges: null == currentCharges
            ? _value.currentCharges
            : currentCharges // ignore: cast_nullable_to_non_nullable
                  as double,
        taxes: null == taxes
            ? _value.taxes
            : taxes // ignore: cast_nullable_to_non_nullable
                  as double,
        fees: null == fees
            ? _value.fees
            : fees // ignore: cast_nullable_to_non_nullable
                  as double,
        adjustments: null == adjustments
            ? _value.adjustments
            : adjustments // ignore: cast_nullable_to_non_nullable
                  as double,
        discounts: null == discounts
            ? _value.discounts
            : discounts // ignore: cast_nullable_to_non_nullable
                  as double,
        lateFees: null == lateFees
            ? _value.lateFees
            : lateFees // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentFees: null == paymentFees
            ? _value.paymentFees
            : paymentFees // ignore: cast_nullable_to_non_nullable
                  as double,
        serviceCharges: null == serviceCharges
            ? _value.serviceCharges
            : serviceCharges // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillAmountsImpl extends _BillAmounts {
  const _$BillAmountsImpl({
    required this.totalAmount,
    required this.previousBalance,
    required this.currentCharges,
    required this.taxes,
    required this.fees,
    required this.adjustments,
    this.discounts = 0.0,
    this.lateFees = 0.0,
    this.paymentFees = 0.0,
    this.serviceCharges = 0.0,
  }) : super._();

  factory _$BillAmountsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillAmountsImplFromJson(json);

  @override
  final double totalAmount;
  @override
  final double previousBalance;
  @override
  final double currentCharges;
  @override
  final double taxes;
  @override
  final double fees;
  @override
  final double adjustments;
  @override
  @JsonKey()
  final double discounts;
  @override
  @JsonKey()
  final double lateFees;
  @override
  @JsonKey()
  final double paymentFees;
  @override
  @JsonKey()
  final double serviceCharges;

  @override
  String toString() {
    return 'BillAmounts(totalAmount: $totalAmount, previousBalance: $previousBalance, currentCharges: $currentCharges, taxes: $taxes, fees: $fees, adjustments: $adjustments, discounts: $discounts, lateFees: $lateFees, paymentFees: $paymentFees, serviceCharges: $serviceCharges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillAmountsImpl &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.previousBalance, previousBalance) ||
                other.previousBalance == previousBalance) &&
            (identical(other.currentCharges, currentCharges) ||
                other.currentCharges == currentCharges) &&
            (identical(other.taxes, taxes) || other.taxes == taxes) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.adjustments, adjustments) ||
                other.adjustments == adjustments) &&
            (identical(other.discounts, discounts) ||
                other.discounts == discounts) &&
            (identical(other.lateFees, lateFees) ||
                other.lateFees == lateFees) &&
            (identical(other.paymentFees, paymentFees) ||
                other.paymentFees == paymentFees) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalAmount,
    previousBalance,
    currentCharges,
    taxes,
    fees,
    adjustments,
    discounts,
    lateFees,
    paymentFees,
    serviceCharges,
  );

  /// Create a copy of BillAmounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillAmountsImplCopyWith<_$BillAmountsImpl> get copyWith =>
      __$$BillAmountsImplCopyWithImpl<_$BillAmountsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillAmountsImplToJson(this);
  }
}

abstract class _BillAmounts extends BillAmounts {
  const factory _BillAmounts({
    required final double totalAmount,
    required final double previousBalance,
    required final double currentCharges,
    required final double taxes,
    required final double fees,
    required final double adjustments,
    final double discounts,
    final double lateFees,
    final double paymentFees,
    final double serviceCharges,
  }) = _$BillAmountsImpl;
  const _BillAmounts._() : super._();

  factory _BillAmounts.fromJson(Map<String, dynamic> json) =
      _$BillAmountsImpl.fromJson;

  @override
  double get totalAmount;
  @override
  double get previousBalance;
  @override
  double get currentCharges;
  @override
  double get taxes;
  @override
  double get fees;
  @override
  double get adjustments;
  @override
  double get discounts;
  @override
  double get lateFees;
  @override
  double get paymentFees;
  @override
  double get serviceCharges;

  /// Create a copy of BillAmounts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillAmountsImplCopyWith<_$BillAmountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillUsage _$BillUsageFromJson(Map<String, dynamic> json) {
  return _BillUsage.fromJson(json);
}

/// @nodoc
mixin _$BillUsage {
  double get kwhUsed => throw _privateConstructorUsedError;
  double get kwhRate => throw _privateConstructorUsedError;
  double get baseCharge => throw _privateConstructorUsedError;
  double get deliveryCharge => throw _privateConstructorUsedError;
  double get generationCharge => throw _privateConstructorUsedError;

  /// Serializes this BillUsage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillUsageCopyWith<BillUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillUsageCopyWith<$Res> {
  factory $BillUsageCopyWith(BillUsage value, $Res Function(BillUsage) then) =
      _$BillUsageCopyWithImpl<$Res, BillUsage>;
  @useResult
  $Res call({
    double kwhUsed,
    double kwhRate,
    double baseCharge,
    double deliveryCharge,
    double generationCharge,
  });
}

/// @nodoc
class _$BillUsageCopyWithImpl<$Res, $Val extends BillUsage>
    implements $BillUsageCopyWith<$Res> {
  _$BillUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kwhUsed = null,
    Object? kwhRate = null,
    Object? baseCharge = null,
    Object? deliveryCharge = null,
    Object? generationCharge = null,
  }) {
    return _then(
      _value.copyWith(
            kwhUsed: null == kwhUsed
                ? _value.kwhUsed
                : kwhUsed // ignore: cast_nullable_to_non_nullable
                      as double,
            kwhRate: null == kwhRate
                ? _value.kwhRate
                : kwhRate // ignore: cast_nullable_to_non_nullable
                      as double,
            baseCharge: null == baseCharge
                ? _value.baseCharge
                : baseCharge // ignore: cast_nullable_to_non_nullable
                      as double,
            deliveryCharge: null == deliveryCharge
                ? _value.deliveryCharge
                : deliveryCharge // ignore: cast_nullable_to_non_nullable
                      as double,
            generationCharge: null == generationCharge
                ? _value.generationCharge
                : generationCharge // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillUsageImplCopyWith<$Res>
    implements $BillUsageCopyWith<$Res> {
  factory _$$BillUsageImplCopyWith(
    _$BillUsageImpl value,
    $Res Function(_$BillUsageImpl) then,
  ) = __$$BillUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double kwhUsed,
    double kwhRate,
    double baseCharge,
    double deliveryCharge,
    double generationCharge,
  });
}

/// @nodoc
class __$$BillUsageImplCopyWithImpl<$Res>
    extends _$BillUsageCopyWithImpl<$Res, _$BillUsageImpl>
    implements _$$BillUsageImplCopyWith<$Res> {
  __$$BillUsageImplCopyWithImpl(
    _$BillUsageImpl _value,
    $Res Function(_$BillUsageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kwhUsed = null,
    Object? kwhRate = null,
    Object? baseCharge = null,
    Object? deliveryCharge = null,
    Object? generationCharge = null,
  }) {
    return _then(
      _$BillUsageImpl(
        kwhUsed: null == kwhUsed
            ? _value.kwhUsed
            : kwhUsed // ignore: cast_nullable_to_non_nullable
                  as double,
        kwhRate: null == kwhRate
            ? _value.kwhRate
            : kwhRate // ignore: cast_nullable_to_non_nullable
                  as double,
        baseCharge: null == baseCharge
            ? _value.baseCharge
            : baseCharge // ignore: cast_nullable_to_non_nullable
                  as double,
        deliveryCharge: null == deliveryCharge
            ? _value.deliveryCharge
            : deliveryCharge // ignore: cast_nullable_to_non_nullable
                  as double,
        generationCharge: null == generationCharge
            ? _value.generationCharge
            : generationCharge // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillUsageImpl implements _BillUsage {
  const _$BillUsageImpl({
    required this.kwhUsed,
    required this.kwhRate,
    required this.baseCharge,
    required this.deliveryCharge,
    required this.generationCharge,
  });

  factory _$BillUsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillUsageImplFromJson(json);

  @override
  final double kwhUsed;
  @override
  final double kwhRate;
  @override
  final double baseCharge;
  @override
  final double deliveryCharge;
  @override
  final double generationCharge;

  @override
  String toString() {
    return 'BillUsage(kwhUsed: $kwhUsed, kwhRate: $kwhRate, baseCharge: $baseCharge, deliveryCharge: $deliveryCharge, generationCharge: $generationCharge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillUsageImpl &&
            (identical(other.kwhUsed, kwhUsed) || other.kwhUsed == kwhUsed) &&
            (identical(other.kwhRate, kwhRate) || other.kwhRate == kwhRate) &&
            (identical(other.baseCharge, baseCharge) ||
                other.baseCharge == baseCharge) &&
            (identical(other.deliveryCharge, deliveryCharge) ||
                other.deliveryCharge == deliveryCharge) &&
            (identical(other.generationCharge, generationCharge) ||
                other.generationCharge == generationCharge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    kwhUsed,
    kwhRate,
    baseCharge,
    deliveryCharge,
    generationCharge,
  );

  /// Create a copy of BillUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillUsageImplCopyWith<_$BillUsageImpl> get copyWith =>
      __$$BillUsageImplCopyWithImpl<_$BillUsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillUsageImplToJson(this);
  }
}

abstract class _BillUsage implements BillUsage {
  const factory _BillUsage({
    required final double kwhUsed,
    required final double kwhRate,
    required final double baseCharge,
    required final double deliveryCharge,
    required final double generationCharge,
  }) = _$BillUsageImpl;

  factory _BillUsage.fromJson(Map<String, dynamic> json) =
      _$BillUsageImpl.fromJson;

  @override
  double get kwhUsed;
  @override
  double get kwhRate;
  @override
  double get baseCharge;
  @override
  double get deliveryCharge;
  @override
  double get generationCharge;

  /// Create a copy of BillUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillUsageImplCopyWith<_$BillUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillPayment _$BillPaymentFromJson(Map<String, dynamic> json) {
  return _BillPayment.fromJson(json);
}

/// @nodoc
mixin _$BillPayment {
  DateTime get paidDate => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;

  /// Serializes this BillPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillPaymentCopyWith<BillPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillPaymentCopyWith<$Res> {
  factory $BillPaymentCopyWith(
    BillPayment value,
    $Res Function(BillPayment) then,
  ) = _$BillPaymentCopyWithImpl<$Res, BillPayment>;
  @useResult
  $Res call({
    DateTime paidDate,
    double paidAmount,
    String paymentMethod,
    String transactionId,
  });
}

/// @nodoc
class _$BillPaymentCopyWithImpl<$Res, $Val extends BillPayment>
    implements $BillPaymentCopyWith<$Res> {
  _$BillPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paidDate = null,
    Object? paidAmount = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
  }) {
    return _then(
      _value.copyWith(
            paidDate: null == paidDate
                ? _value.paidDate
                : paidDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillPaymentImplCopyWith<$Res>
    implements $BillPaymentCopyWith<$Res> {
  factory _$$BillPaymentImplCopyWith(
    _$BillPaymentImpl value,
    $Res Function(_$BillPaymentImpl) then,
  ) = __$$BillPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime paidDate,
    double paidAmount,
    String paymentMethod,
    String transactionId,
  });
}

/// @nodoc
class __$$BillPaymentImplCopyWithImpl<$Res>
    extends _$BillPaymentCopyWithImpl<$Res, _$BillPaymentImpl>
    implements _$$BillPaymentImplCopyWith<$Res> {
  __$$BillPaymentImplCopyWithImpl(
    _$BillPaymentImpl _value,
    $Res Function(_$BillPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paidDate = null,
    Object? paidAmount = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
  }) {
    return _then(
      _$BillPaymentImpl(
        paidDate: null == paidDate
            ? _value.paidDate
            : paidDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillPaymentImpl implements _BillPayment {
  const _$BillPaymentImpl({
    required this.paidDate,
    required this.paidAmount,
    required this.paymentMethod,
    required this.transactionId,
  });

  factory _$BillPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillPaymentImplFromJson(json);

  @override
  final DateTime paidDate;
  @override
  final double paidAmount;
  @override
  final String paymentMethod;
  @override
  final String transactionId;

  @override
  String toString() {
    return 'BillPayment(paidDate: $paidDate, paidAmount: $paidAmount, paymentMethod: $paymentMethod, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillPaymentImpl &&
            (identical(other.paidDate, paidDate) ||
                other.paidDate == paidDate) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    paidDate,
    paidAmount,
    paymentMethod,
    transactionId,
  );

  /// Create a copy of BillPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillPaymentImplCopyWith<_$BillPaymentImpl> get copyWith =>
      __$$BillPaymentImplCopyWithImpl<_$BillPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillPaymentImplToJson(this);
  }
}

abstract class _BillPayment implements BillPayment {
  const factory _BillPayment({
    required final DateTime paidDate,
    required final double paidAmount,
    required final String paymentMethod,
    required final String transactionId,
  }) = _$BillPaymentImpl;

  factory _BillPayment.fromJson(Map<String, dynamic> json) =
      _$BillPaymentImpl.fromJson;

  @override
  DateTime get paidDate;
  @override
  double get paidAmount;
  @override
  String get paymentMethod;
  @override
  String get transactionId;

  /// Create a copy of BillPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillPaymentImplCopyWith<_$BillPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillsResponse _$BillsResponseFromJson(Map<String, dynamic> json) {
  return _BillsResponse.fromJson(json);
}

/// @nodoc
mixin _$BillsResponse {
  List<Bill> get bills => throw _privateConstructorUsedError;
  BillsSummary get summary => throw _privateConstructorUsedError;

  /// Serializes this BillsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillsResponseCopyWith<BillsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillsResponseCopyWith<$Res> {
  factory $BillsResponseCopyWith(
    BillsResponse value,
    $Res Function(BillsResponse) then,
  ) = _$BillsResponseCopyWithImpl<$Res, BillsResponse>;
  @useResult
  $Res call({List<Bill> bills, BillsSummary summary});

  $BillsSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$BillsResponseCopyWithImpl<$Res, $Val extends BillsResponse>
    implements $BillsResponseCopyWith<$Res> {
  _$BillsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bills = null, Object? summary = null}) {
    return _then(
      _value.copyWith(
            bills: null == bills
                ? _value.bills
                : bills // ignore: cast_nullable_to_non_nullable
                      as List<Bill>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as BillsSummary,
          )
          as $Val,
    );
  }

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillsSummaryCopyWith<$Res> get summary {
    return $BillsSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BillsResponseImplCopyWith<$Res>
    implements $BillsResponseCopyWith<$Res> {
  factory _$$BillsResponseImplCopyWith(
    _$BillsResponseImpl value,
    $Res Function(_$BillsResponseImpl) then,
  ) = __$$BillsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Bill> bills, BillsSummary summary});

  @override
  $BillsSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$BillsResponseImplCopyWithImpl<$Res>
    extends _$BillsResponseCopyWithImpl<$Res, _$BillsResponseImpl>
    implements _$$BillsResponseImplCopyWith<$Res> {
  __$$BillsResponseImplCopyWithImpl(
    _$BillsResponseImpl _value,
    $Res Function(_$BillsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bills = null, Object? summary = null}) {
    return _then(
      _$BillsResponseImpl(
        bills: null == bills
            ? _value._bills
            : bills // ignore: cast_nullable_to_non_nullable
                  as List<Bill>,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as BillsSummary,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillsResponseImpl implements _BillsResponse {
  const _$BillsResponseImpl({
    required final List<Bill> bills,
    required this.summary,
  }) : _bills = bills;

  factory _$BillsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillsResponseImplFromJson(json);

  final List<Bill> _bills;
  @override
  List<Bill> get bills {
    if (_bills is EqualUnmodifiableListView) return _bills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bills);
  }

  @override
  final BillsSummary summary;

  @override
  String toString() {
    return 'BillsResponse(bills: $bills, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillsResponseImpl &&
            const DeepCollectionEquality().equals(other._bills, _bills) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_bills),
    summary,
  );

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillsResponseImplCopyWith<_$BillsResponseImpl> get copyWith =>
      __$$BillsResponseImplCopyWithImpl<_$BillsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillsResponseImplToJson(this);
  }
}

abstract class _BillsResponse implements BillsResponse {
  const factory _BillsResponse({
    required final List<Bill> bills,
    required final BillsSummary summary,
  }) = _$BillsResponseImpl;

  factory _BillsResponse.fromJson(Map<String, dynamic> json) =
      _$BillsResponseImpl.fromJson;

  @override
  List<Bill> get bills;
  @override
  BillsSummary get summary;

  /// Create a copy of BillsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillsResponseImplCopyWith<_$BillsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillsSummary _$BillsSummaryFromJson(Map<String, dynamic> json) {
  return _BillsSummary.fromJson(json);
}

/// @nodoc
mixin _$BillsSummary {
  int get totalBills => throw _privateConstructorUsedError;
  double get totalPaid => throw _privateConstructorUsedError;
  double get averageMonthlyBill => throw _privateConstructorUsedError;
  double get highestBill => throw _privateConstructorUsedError;
  double get lowestBill => throw _privateConstructorUsedError;
  DateTime get lastPaymentDate => throw _privateConstructorUsedError;
  DateTime get nextDueDate => throw _privateConstructorUsedError;
  double get totalOutstanding => throw _privateConstructorUsedError;
  int get overdueBills => throw _privateConstructorUsedError;
  double get averagePaymentTime => throw _privateConstructorUsedError;

  /// Serializes this BillsSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillsSummaryCopyWith<BillsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillsSummaryCopyWith<$Res> {
  factory $BillsSummaryCopyWith(
    BillsSummary value,
    $Res Function(BillsSummary) then,
  ) = _$BillsSummaryCopyWithImpl<$Res, BillsSummary>;
  @useResult
  $Res call({
    int totalBills,
    double totalPaid,
    double averageMonthlyBill,
    double highestBill,
    double lowestBill,
    DateTime lastPaymentDate,
    DateTime nextDueDate,
    double totalOutstanding,
    int overdueBills,
    double averagePaymentTime,
  });
}

/// @nodoc
class _$BillsSummaryCopyWithImpl<$Res, $Val extends BillsSummary>
    implements $BillsSummaryCopyWith<$Res> {
  _$BillsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBills = null,
    Object? totalPaid = null,
    Object? averageMonthlyBill = null,
    Object? highestBill = null,
    Object? lowestBill = null,
    Object? lastPaymentDate = null,
    Object? nextDueDate = null,
    Object? totalOutstanding = null,
    Object? overdueBills = null,
    Object? averagePaymentTime = null,
  }) {
    return _then(
      _value.copyWith(
            totalBills: null == totalBills
                ? _value.totalBills
                : totalBills // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPaid: null == totalPaid
                ? _value.totalPaid
                : totalPaid // ignore: cast_nullable_to_non_nullable
                      as double,
            averageMonthlyBill: null == averageMonthlyBill
                ? _value.averageMonthlyBill
                : averageMonthlyBill // ignore: cast_nullable_to_non_nullable
                      as double,
            highestBill: null == highestBill
                ? _value.highestBill
                : highestBill // ignore: cast_nullable_to_non_nullable
                      as double,
            lowestBill: null == lowestBill
                ? _value.lowestBill
                : lowestBill // ignore: cast_nullable_to_non_nullable
                      as double,
            lastPaymentDate: null == lastPaymentDate
                ? _value.lastPaymentDate
                : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            nextDueDate: null == nextDueDate
                ? _value.nextDueDate
                : nextDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalOutstanding: null == totalOutstanding
                ? _value.totalOutstanding
                : totalOutstanding // ignore: cast_nullable_to_non_nullable
                      as double,
            overdueBills: null == overdueBills
                ? _value.overdueBills
                : overdueBills // ignore: cast_nullable_to_non_nullable
                      as int,
            averagePaymentTime: null == averagePaymentTime
                ? _value.averagePaymentTime
                : averagePaymentTime // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillsSummaryImplCopyWith<$Res>
    implements $BillsSummaryCopyWith<$Res> {
  factory _$$BillsSummaryImplCopyWith(
    _$BillsSummaryImpl value,
    $Res Function(_$BillsSummaryImpl) then,
  ) = __$$BillsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalBills,
    double totalPaid,
    double averageMonthlyBill,
    double highestBill,
    double lowestBill,
    DateTime lastPaymentDate,
    DateTime nextDueDate,
    double totalOutstanding,
    int overdueBills,
    double averagePaymentTime,
  });
}

/// @nodoc
class __$$BillsSummaryImplCopyWithImpl<$Res>
    extends _$BillsSummaryCopyWithImpl<$Res, _$BillsSummaryImpl>
    implements _$$BillsSummaryImplCopyWith<$Res> {
  __$$BillsSummaryImplCopyWithImpl(
    _$BillsSummaryImpl _value,
    $Res Function(_$BillsSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBills = null,
    Object? totalPaid = null,
    Object? averageMonthlyBill = null,
    Object? highestBill = null,
    Object? lowestBill = null,
    Object? lastPaymentDate = null,
    Object? nextDueDate = null,
    Object? totalOutstanding = null,
    Object? overdueBills = null,
    Object? averagePaymentTime = null,
  }) {
    return _then(
      _$BillsSummaryImpl(
        totalBills: null == totalBills
            ? _value.totalBills
            : totalBills // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPaid: null == totalPaid
            ? _value.totalPaid
            : totalPaid // ignore: cast_nullable_to_non_nullable
                  as double,
        averageMonthlyBill: null == averageMonthlyBill
            ? _value.averageMonthlyBill
            : averageMonthlyBill // ignore: cast_nullable_to_non_nullable
                  as double,
        highestBill: null == highestBill
            ? _value.highestBill
            : highestBill // ignore: cast_nullable_to_non_nullable
                  as double,
        lowestBill: null == lowestBill
            ? _value.lowestBill
            : lowestBill // ignore: cast_nullable_to_non_nullable
                  as double,
        lastPaymentDate: null == lastPaymentDate
            ? _value.lastPaymentDate
            : lastPaymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        nextDueDate: null == nextDueDate
            ? _value.nextDueDate
            : nextDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalOutstanding: null == totalOutstanding
            ? _value.totalOutstanding
            : totalOutstanding // ignore: cast_nullable_to_non_nullable
                  as double,
        overdueBills: null == overdueBills
            ? _value.overdueBills
            : overdueBills // ignore: cast_nullable_to_non_nullable
                  as int,
        averagePaymentTime: null == averagePaymentTime
            ? _value.averagePaymentTime
            : averagePaymentTime // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillsSummaryImpl implements _BillsSummary {
  const _$BillsSummaryImpl({
    required this.totalBills,
    required this.totalPaid,
    required this.averageMonthlyBill,
    required this.highestBill,
    required this.lowestBill,
    required this.lastPaymentDate,
    required this.nextDueDate,
    this.totalOutstanding = 0.0,
    this.overdueBills = 0,
    this.averagePaymentTime = 0.0,
  });

  factory _$BillsSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillsSummaryImplFromJson(json);

  @override
  final int totalBills;
  @override
  final double totalPaid;
  @override
  final double averageMonthlyBill;
  @override
  final double highestBill;
  @override
  final double lowestBill;
  @override
  final DateTime lastPaymentDate;
  @override
  final DateTime nextDueDate;
  @override
  @JsonKey()
  final double totalOutstanding;
  @override
  @JsonKey()
  final int overdueBills;
  @override
  @JsonKey()
  final double averagePaymentTime;

  @override
  String toString() {
    return 'BillsSummary(totalBills: $totalBills, totalPaid: $totalPaid, averageMonthlyBill: $averageMonthlyBill, highestBill: $highestBill, lowestBill: $lowestBill, lastPaymentDate: $lastPaymentDate, nextDueDate: $nextDueDate, totalOutstanding: $totalOutstanding, overdueBills: $overdueBills, averagePaymentTime: $averagePaymentTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillsSummaryImpl &&
            (identical(other.totalBills, totalBills) ||
                other.totalBills == totalBills) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.averageMonthlyBill, averageMonthlyBill) ||
                other.averageMonthlyBill == averageMonthlyBill) &&
            (identical(other.highestBill, highestBill) ||
                other.highestBill == highestBill) &&
            (identical(other.lowestBill, lowestBill) ||
                other.lowestBill == lowestBill) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.totalOutstanding, totalOutstanding) ||
                other.totalOutstanding == totalOutstanding) &&
            (identical(other.overdueBills, overdueBills) ||
                other.overdueBills == overdueBills) &&
            (identical(other.averagePaymentTime, averagePaymentTime) ||
                other.averagePaymentTime == averagePaymentTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalBills,
    totalPaid,
    averageMonthlyBill,
    highestBill,
    lowestBill,
    lastPaymentDate,
    nextDueDate,
    totalOutstanding,
    overdueBills,
    averagePaymentTime,
  );

  /// Create a copy of BillsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillsSummaryImplCopyWith<_$BillsSummaryImpl> get copyWith =>
      __$$BillsSummaryImplCopyWithImpl<_$BillsSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillsSummaryImplToJson(this);
  }
}

abstract class _BillsSummary implements BillsSummary {
  const factory _BillsSummary({
    required final int totalBills,
    required final double totalPaid,
    required final double averageMonthlyBill,
    required final double highestBill,
    required final double lowestBill,
    required final DateTime lastPaymentDate,
    required final DateTime nextDueDate,
    final double totalOutstanding,
    final int overdueBills,
    final double averagePaymentTime,
  }) = _$BillsSummaryImpl;

  factory _BillsSummary.fromJson(Map<String, dynamic> json) =
      _$BillsSummaryImpl.fromJson;

  @override
  int get totalBills;
  @override
  double get totalPaid;
  @override
  double get averageMonthlyBill;
  @override
  double get highestBill;
  @override
  double get lowestBill;
  @override
  DateTime get lastPaymentDate;
  @override
  DateTime get nextDueDate;
  @override
  double get totalOutstanding;
  @override
  int get overdueBills;
  @override
  double get averagePaymentTime;

  /// Create a copy of BillsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillsSummaryImplCopyWith<_$BillsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) {
  return _PaymentHistory.fromJson(json);
}

/// @nodoc
mixin _$PaymentHistory {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get paymentDate => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PaymentHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentHistoryCopyWith<PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryCopyWith<$Res> {
  factory $PaymentHistoryCopyWith(
    PaymentHistory value,
    $Res Function(PaymentHistory) then,
  ) = _$PaymentHistoryCopyWithImpl<$Res, PaymentHistory>;
  @useResult
  $Res call({
    String id,
    double amount,
    DateTime paymentDate,
    String paymentMethod,
    String transactionId,
    PaymentStatus status,
    String? referenceNumber,
    String? notes,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res, $Val extends PaymentHistory>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
    Object? status = null,
    Object? referenceNumber = freezed,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentDate: null == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$PaymentHistoryImplCopyWith<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  factory _$$PaymentHistoryImplCopyWith(
    _$PaymentHistoryImpl value,
    $Res Function(_$PaymentHistoryImpl) then,
  ) = __$$PaymentHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    double amount,
    DateTime paymentDate,
    String paymentMethod,
    String transactionId,
    PaymentStatus status,
    String? referenceNumber,
    String? notes,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$PaymentHistoryImplCopyWithImpl<$Res>
    extends _$PaymentHistoryCopyWithImpl<$Res, _$PaymentHistoryImpl>
    implements _$$PaymentHistoryImplCopyWith<$Res> {
  __$$PaymentHistoryImplCopyWithImpl(
    _$PaymentHistoryImpl _value,
    $Res Function(_$PaymentHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
    Object? status = null,
    Object? referenceNumber = freezed,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$PaymentHistoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentDate: null == paymentDate
            ? _value.paymentDate
            : paymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$PaymentHistoryImpl extends _PaymentHistory {
  const _$PaymentHistoryImpl({
    required this.id,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.transactionId,
    required this.status,
    this.referenceNumber,
    this.notes,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$PaymentHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final DateTime paymentDate;
  @override
  final String paymentMethod;
  @override
  final String transactionId;
  @override
  final PaymentStatus status;
  @override
  final String? referenceNumber;
  @override
  final String? notes;
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
    return 'PaymentHistory(id: $id, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, transactionId: $transactionId, status: $status, referenceNumber: $referenceNumber, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    paymentDate,
    paymentMethod,
    transactionId,
    status,
    referenceNumber,
    notes,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      __$$PaymentHistoryImplCopyWithImpl<_$PaymentHistoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentHistoryImplToJson(this);
  }
}

abstract class _PaymentHistory extends PaymentHistory {
  const factory _PaymentHistory({
    required final String id,
    required final double amount,
    required final DateTime paymentDate,
    required final String paymentMethod,
    required final String transactionId,
    required final PaymentStatus status,
    final String? referenceNumber,
    final String? notes,
    final Map<String, dynamic>? metadata,
  }) = _$PaymentHistoryImpl;
  const _PaymentHistory._() : super._();

  factory _PaymentHistory.fromJson(Map<String, dynamic> json) =
      _$PaymentHistoryImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  DateTime get paymentDate;
  @override
  String get paymentMethod;
  @override
  String get transactionId;
  @override
  PaymentStatus get status;
  @override
  String? get referenceNumber;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillAdjustment _$BillAdjustmentFromJson(Map<String, dynamic> json) {
  return _BillAdjustment.fromJson(json);
}

/// @nodoc
mixin _$BillAdjustment {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;

  /// Serializes this BillAdjustment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillAdjustment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillAdjustmentCopyWith<BillAdjustment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillAdjustmentCopyWith<$Res> {
  factory $BillAdjustmentCopyWith(
    BillAdjustment value,
    $Res Function(BillAdjustment) then,
  ) = _$BillAdjustmentCopyWithImpl<$Res, BillAdjustment>;
  @useResult
  $Res call({
    String id,
    String type,
    double amount,
    String reason,
    DateTime date,
    String? description,
    String? referenceNumber,
  });
}

/// @nodoc
class _$BillAdjustmentCopyWithImpl<$Res, $Val extends BillAdjustment>
    implements $BillAdjustmentCopyWith<$Res> {
  _$BillAdjustmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillAdjustment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? reason = null,
    Object? date = null,
    Object? description = freezed,
    Object? referenceNumber = freezed,
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
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillAdjustmentImplCopyWith<$Res>
    implements $BillAdjustmentCopyWith<$Res> {
  factory _$$BillAdjustmentImplCopyWith(
    _$BillAdjustmentImpl value,
    $Res Function(_$BillAdjustmentImpl) then,
  ) = __$$BillAdjustmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    double amount,
    String reason,
    DateTime date,
    String? description,
    String? referenceNumber,
  });
}

/// @nodoc
class __$$BillAdjustmentImplCopyWithImpl<$Res>
    extends _$BillAdjustmentCopyWithImpl<$Res, _$BillAdjustmentImpl>
    implements _$$BillAdjustmentImplCopyWith<$Res> {
  __$$BillAdjustmentImplCopyWithImpl(
    _$BillAdjustmentImpl _value,
    $Res Function(_$BillAdjustmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillAdjustment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? reason = null,
    Object? date = null,
    Object? description = freezed,
    Object? referenceNumber = freezed,
  }) {
    return _then(
      _$BillAdjustmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillAdjustmentImpl implements _BillAdjustment {
  const _$BillAdjustmentImpl({
    required this.id,
    required this.type,
    required this.amount,
    required this.reason,
    required this.date,
    this.description,
    this.referenceNumber,
  });

  factory _$BillAdjustmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillAdjustmentImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final double amount;
  @override
  final String reason;
  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final String? referenceNumber;

  @override
  String toString() {
    return 'BillAdjustment(id: $id, type: $type, amount: $amount, reason: $reason, date: $date, description: $description, referenceNumber: $referenceNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillAdjustmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    amount,
    reason,
    date,
    description,
    referenceNumber,
  );

  /// Create a copy of BillAdjustment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillAdjustmentImplCopyWith<_$BillAdjustmentImpl> get copyWith =>
      __$$BillAdjustmentImplCopyWithImpl<_$BillAdjustmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BillAdjustmentImplToJson(this);
  }
}

abstract class _BillAdjustment implements BillAdjustment {
  const factory _BillAdjustment({
    required final String id,
    required final String type,
    required final double amount,
    required final String reason,
    required final DateTime date,
    final String? description,
    final String? referenceNumber,
  }) = _$BillAdjustmentImpl;

  factory _BillAdjustment.fromJson(Map<String, dynamic> json) =
      _$BillAdjustmentImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  double get amount;
  @override
  String get reason;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  String? get referenceNumber;

  /// Create a copy of BillAdjustment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillAdjustmentImplCopyWith<_$BillAdjustmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillFee _$BillFeeFromJson(Map<String, dynamic> json) {
  return _BillFee.fromJson(json);
}

/// @nodoc
mixin _$BillFee {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isRecurring => throw _privateConstructorUsedError;

  /// Serializes this BillFee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillFeeCopyWith<BillFee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillFeeCopyWith<$Res> {
  factory $BillFeeCopyWith(BillFee value, $Res Function(BillFee) then) =
      _$BillFeeCopyWithImpl<$Res, BillFee>;
  @useResult
  $Res call({
    String id,
    String name,
    double amount,
    String type,
    String? description,
    bool? isRecurring,
  });
}

/// @nodoc
class _$BillFeeCopyWithImpl<$Res, $Val extends BillFee>
    implements $BillFeeCopyWith<$Res> {
  _$BillFeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? isRecurring = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRecurring: freezed == isRecurring
                ? _value.isRecurring
                : isRecurring // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillFeeImplCopyWith<$Res> implements $BillFeeCopyWith<$Res> {
  factory _$$BillFeeImplCopyWith(
    _$BillFeeImpl value,
    $Res Function(_$BillFeeImpl) then,
  ) = __$$BillFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double amount,
    String type,
    String? description,
    bool? isRecurring,
  });
}

/// @nodoc
class __$$BillFeeImplCopyWithImpl<$Res>
    extends _$BillFeeCopyWithImpl<$Res, _$BillFeeImpl>
    implements _$$BillFeeImplCopyWith<$Res> {
  __$$BillFeeImplCopyWithImpl(
    _$BillFeeImpl _value,
    $Res Function(_$BillFeeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? isRecurring = freezed,
  }) {
    return _then(
      _$BillFeeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRecurring: freezed == isRecurring
            ? _value.isRecurring
            : isRecurring // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillFeeImpl implements _BillFee {
  const _$BillFeeImpl({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    this.description,
    this.isRecurring,
  });

  factory _$BillFeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillFeeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final String type;
  @override
  final String? description;
  @override
  final bool? isRecurring;

  @override
  String toString() {
    return 'BillFee(id: $id, name: $name, amount: $amount, type: $type, description: $description, isRecurring: $isRecurring)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillFeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    amount,
    type,
    description,
    isRecurring,
  );

  /// Create a copy of BillFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillFeeImplCopyWith<_$BillFeeImpl> get copyWith =>
      __$$BillFeeImplCopyWithImpl<_$BillFeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillFeeImplToJson(this);
  }
}

abstract class _BillFee implements BillFee {
  const factory _BillFee({
    required final String id,
    required final String name,
    required final double amount,
    required final String type,
    final String? description,
    final bool? isRecurring,
  }) = _$BillFeeImpl;

  factory _BillFee.fromJson(Map<String, dynamic> json) = _$BillFeeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  String get type;
  @override
  String? get description;
  @override
  bool? get isRecurring;

  /// Create a copy of BillFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillFeeImplCopyWith<_$BillFeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillTax _$BillTaxFromJson(Map<String, dynamic> json) {
  return _BillTax.fromJson(json);
}

/// @nodoc
mixin _$BillTax {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get jurisdiction => throw _privateConstructorUsedError;

  /// Serializes this BillTax to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillTax
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillTaxCopyWith<BillTax> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillTaxCopyWith<$Res> {
  factory $BillTaxCopyWith(BillTax value, $Res Function(BillTax) then) =
      _$BillTaxCopyWithImpl<$Res, BillTax>;
  @useResult
  $Res call({
    String id,
    String name,
    double rate,
    double amount,
    String type,
    String? jurisdiction,
  });
}

/// @nodoc
class _$BillTaxCopyWithImpl<$Res, $Val extends BillTax>
    implements $BillTaxCopyWith<$Res> {
  _$BillTaxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillTax
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rate = null,
    Object? amount = null,
    Object? type = null,
    Object? jurisdiction = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            rate: null == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            jurisdiction: freezed == jurisdiction
                ? _value.jurisdiction
                : jurisdiction // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillTaxImplCopyWith<$Res> implements $BillTaxCopyWith<$Res> {
  factory _$$BillTaxImplCopyWith(
    _$BillTaxImpl value,
    $Res Function(_$BillTaxImpl) then,
  ) = __$$BillTaxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double rate,
    double amount,
    String type,
    String? jurisdiction,
  });
}

/// @nodoc
class __$$BillTaxImplCopyWithImpl<$Res>
    extends _$BillTaxCopyWithImpl<$Res, _$BillTaxImpl>
    implements _$$BillTaxImplCopyWith<$Res> {
  __$$BillTaxImplCopyWithImpl(
    _$BillTaxImpl _value,
    $Res Function(_$BillTaxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillTax
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rate = null,
    Object? amount = null,
    Object? type = null,
    Object? jurisdiction = freezed,
  }) {
    return _then(
      _$BillTaxImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        rate: null == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        jurisdiction: freezed == jurisdiction
            ? _value.jurisdiction
            : jurisdiction // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillTaxImpl implements _BillTax {
  const _$BillTaxImpl({
    required this.id,
    required this.name,
    required this.rate,
    required this.amount,
    required this.type,
    this.jurisdiction,
  });

  factory _$BillTaxImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillTaxImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double rate;
  @override
  final double amount;
  @override
  final String type;
  @override
  final String? jurisdiction;

  @override
  String toString() {
    return 'BillTax(id: $id, name: $name, rate: $rate, amount: $amount, type: $type, jurisdiction: $jurisdiction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillTaxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.jurisdiction, jurisdiction) ||
                other.jurisdiction == jurisdiction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, rate, amount, type, jurisdiction);

  /// Create a copy of BillTax
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillTaxImplCopyWith<_$BillTaxImpl> get copyWith =>
      __$$BillTaxImplCopyWithImpl<_$BillTaxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillTaxImplToJson(this);
  }
}

abstract class _BillTax implements BillTax {
  const factory _BillTax({
    required final String id,
    required final String name,
    required final double rate,
    required final double amount,
    required final String type,
    final String? jurisdiction,
  }) = _$BillTaxImpl;

  factory _BillTax.fromJson(Map<String, dynamic> json) = _$BillTaxImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get rate;
  @override
  double get amount;
  @override
  String get type;
  @override
  String? get jurisdiction;

  /// Create a copy of BillTax
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillTaxImplCopyWith<_$BillTaxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillDiscount _$BillDiscountFromJson(Map<String, dynamic> json) {
  return _BillDiscount.fromJson(json);
}

/// @nodoc
mixin _$BillDiscount {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get validUntil => throw _privateConstructorUsedError;

  /// Serializes this BillDiscount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillDiscountCopyWith<BillDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillDiscountCopyWith<$Res> {
  factory $BillDiscountCopyWith(
    BillDiscount value,
    $Res Function(BillDiscount) then,
  ) = _$BillDiscountCopyWithImpl<$Res, BillDiscount>;
  @useResult
  $Res call({
    String id,
    String name,
    double amount,
    String type,
    String? description,
    DateTime? validUntil,
  });
}

/// @nodoc
class _$BillDiscountCopyWithImpl<$Res, $Val extends BillDiscount>
    implements $BillDiscountCopyWith<$Res> {
  _$BillDiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            validUntil: freezed == validUntil
                ? _value.validUntil
                : validUntil // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillDiscountImplCopyWith<$Res>
    implements $BillDiscountCopyWith<$Res> {
  factory _$$BillDiscountImplCopyWith(
    _$BillDiscountImpl value,
    $Res Function(_$BillDiscountImpl) then,
  ) = __$$BillDiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double amount,
    String type,
    String? description,
    DateTime? validUntil,
  });
}

/// @nodoc
class __$$BillDiscountImplCopyWithImpl<$Res>
    extends _$BillDiscountCopyWithImpl<$Res, _$BillDiscountImpl>
    implements _$$BillDiscountImplCopyWith<$Res> {
  __$$BillDiscountImplCopyWithImpl(
    _$BillDiscountImpl _value,
    $Res Function(_$BillDiscountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? type = null,
    Object? description = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(
      _$BillDiscountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        validUntil: freezed == validUntil
            ? _value.validUntil
            : validUntil // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillDiscountImpl implements _BillDiscount {
  const _$BillDiscountImpl({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    this.description,
    this.validUntil,
  });

  factory _$BillDiscountImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillDiscountImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final String type;
  @override
  final String? description;
  @override
  final DateTime? validUntil;

  @override
  String toString() {
    return 'BillDiscount(id: $id, name: $name, amount: $amount, type: $type, description: $description, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillDiscountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, amount, type, description, validUntil);

  /// Create a copy of BillDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillDiscountImplCopyWith<_$BillDiscountImpl> get copyWith =>
      __$$BillDiscountImplCopyWithImpl<_$BillDiscountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillDiscountImplToJson(this);
  }
}

abstract class _BillDiscount implements BillDiscount {
  const factory _BillDiscount({
    required final String id,
    required final String name,
    required final double amount,
    required final String type,
    final String? description,
    final DateTime? validUntil,
  }) = _$BillDiscountImpl;

  factory _BillDiscount.fromJson(Map<String, dynamic> json) =
      _$BillDiscountImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  String get type;
  @override
  String? get description;
  @override
  DateTime? get validUntil;

  /// Create a copy of BillDiscount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillDiscountImplCopyWith<_$BillDiscountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillCalculations _$BillCalculationsFromJson(Map<String, dynamic> json) {
  return _BillCalculations.fromJson(json);
}

/// @nodoc
mixin _$BillCalculations {
  double get baseRate => throw _privateConstructorUsedError;
  double get deliveryRate => throw _privateConstructorUsedError;
  double get generationRate => throw _privateConstructorUsedError;
  double get transmissionRate => throw _privateConstructorUsedError;
  double get distributionRate => throw _privateConstructorUsedError;
  double get regulatoryRate => throw _privateConstructorUsedError;
  double get renewableEnergyRate => throw _privateConstructorUsedError;
  double get energyEfficiencyRate => throw _privateConstructorUsedError;
  double get totalRatePerKwh => throw _privateConstructorUsedError;
  double get averageDailyUsage => throw _privateConstructorUsedError;
  double get peakUsage => throw _privateConstructorUsedError;
  double get offPeakUsage => throw _privateConstructorUsedError;
  double get totalUsageCost => throw _privateConstructorUsedError;

  /// Serializes this BillCalculations to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillCalculations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillCalculationsCopyWith<BillCalculations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillCalculationsCopyWith<$Res> {
  factory $BillCalculationsCopyWith(
    BillCalculations value,
    $Res Function(BillCalculations) then,
  ) = _$BillCalculationsCopyWithImpl<$Res, BillCalculations>;
  @useResult
  $Res call({
    double baseRate,
    double deliveryRate,
    double generationRate,
    double transmissionRate,
    double distributionRate,
    double regulatoryRate,
    double renewableEnergyRate,
    double energyEfficiencyRate,
    double totalRatePerKwh,
    double averageDailyUsage,
    double peakUsage,
    double offPeakUsage,
    double totalUsageCost,
  });
}

/// @nodoc
class _$BillCalculationsCopyWithImpl<$Res, $Val extends BillCalculations>
    implements $BillCalculationsCopyWith<$Res> {
  _$BillCalculationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillCalculations
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseRate = null,
    Object? deliveryRate = null,
    Object? generationRate = null,
    Object? transmissionRate = null,
    Object? distributionRate = null,
    Object? regulatoryRate = null,
    Object? renewableEnergyRate = null,
    Object? energyEfficiencyRate = null,
    Object? totalRatePerKwh = null,
    Object? averageDailyUsage = null,
    Object? peakUsage = null,
    Object? offPeakUsage = null,
    Object? totalUsageCost = null,
  }) {
    return _then(
      _value.copyWith(
            baseRate: null == baseRate
                ? _value.baseRate
                : baseRate // ignore: cast_nullable_to_non_nullable
                      as double,
            deliveryRate: null == deliveryRate
                ? _value.deliveryRate
                : deliveryRate // ignore: cast_nullable_to_non_nullable
                      as double,
            generationRate: null == generationRate
                ? _value.generationRate
                : generationRate // ignore: cast_nullable_to_non_nullable
                      as double,
            transmissionRate: null == transmissionRate
                ? _value.transmissionRate
                : transmissionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            distributionRate: null == distributionRate
                ? _value.distributionRate
                : distributionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            regulatoryRate: null == regulatoryRate
                ? _value.regulatoryRate
                : regulatoryRate // ignore: cast_nullable_to_non_nullable
                      as double,
            renewableEnergyRate: null == renewableEnergyRate
                ? _value.renewableEnergyRate
                : renewableEnergyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            energyEfficiencyRate: null == energyEfficiencyRate
                ? _value.energyEfficiencyRate
                : energyEfficiencyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRatePerKwh: null == totalRatePerKwh
                ? _value.totalRatePerKwh
                : totalRatePerKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            averageDailyUsage: null == averageDailyUsage
                ? _value.averageDailyUsage
                : averageDailyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            peakUsage: null == peakUsage
                ? _value.peakUsage
                : peakUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            offPeakUsage: null == offPeakUsage
                ? _value.offPeakUsage
                : offPeakUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            totalUsageCost: null == totalUsageCost
                ? _value.totalUsageCost
                : totalUsageCost // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillCalculationsImplCopyWith<$Res>
    implements $BillCalculationsCopyWith<$Res> {
  factory _$$BillCalculationsImplCopyWith(
    _$BillCalculationsImpl value,
    $Res Function(_$BillCalculationsImpl) then,
  ) = __$$BillCalculationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double baseRate,
    double deliveryRate,
    double generationRate,
    double transmissionRate,
    double distributionRate,
    double regulatoryRate,
    double renewableEnergyRate,
    double energyEfficiencyRate,
    double totalRatePerKwh,
    double averageDailyUsage,
    double peakUsage,
    double offPeakUsage,
    double totalUsageCost,
  });
}

/// @nodoc
class __$$BillCalculationsImplCopyWithImpl<$Res>
    extends _$BillCalculationsCopyWithImpl<$Res, _$BillCalculationsImpl>
    implements _$$BillCalculationsImplCopyWith<$Res> {
  __$$BillCalculationsImplCopyWithImpl(
    _$BillCalculationsImpl _value,
    $Res Function(_$BillCalculationsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillCalculations
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseRate = null,
    Object? deliveryRate = null,
    Object? generationRate = null,
    Object? transmissionRate = null,
    Object? distributionRate = null,
    Object? regulatoryRate = null,
    Object? renewableEnergyRate = null,
    Object? energyEfficiencyRate = null,
    Object? totalRatePerKwh = null,
    Object? averageDailyUsage = null,
    Object? peakUsage = null,
    Object? offPeakUsage = null,
    Object? totalUsageCost = null,
  }) {
    return _then(
      _$BillCalculationsImpl(
        baseRate: null == baseRate
            ? _value.baseRate
            : baseRate // ignore: cast_nullable_to_non_nullable
                  as double,
        deliveryRate: null == deliveryRate
            ? _value.deliveryRate
            : deliveryRate // ignore: cast_nullable_to_non_nullable
                  as double,
        generationRate: null == generationRate
            ? _value.generationRate
            : generationRate // ignore: cast_nullable_to_non_nullable
                  as double,
        transmissionRate: null == transmissionRate
            ? _value.transmissionRate
            : transmissionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        distributionRate: null == distributionRate
            ? _value.distributionRate
            : distributionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        regulatoryRate: null == regulatoryRate
            ? _value.regulatoryRate
            : regulatoryRate // ignore: cast_nullable_to_non_nullable
                  as double,
        renewableEnergyRate: null == renewableEnergyRate
            ? _value.renewableEnergyRate
            : renewableEnergyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        energyEfficiencyRate: null == energyEfficiencyRate
            ? _value.energyEfficiencyRate
            : energyEfficiencyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRatePerKwh: null == totalRatePerKwh
            ? _value.totalRatePerKwh
            : totalRatePerKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        averageDailyUsage: null == averageDailyUsage
            ? _value.averageDailyUsage
            : averageDailyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        peakUsage: null == peakUsage
            ? _value.peakUsage
            : peakUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        offPeakUsage: null == offPeakUsage
            ? _value.offPeakUsage
            : offPeakUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        totalUsageCost: null == totalUsageCost
            ? _value.totalUsageCost
            : totalUsageCost // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillCalculationsImpl extends _BillCalculations {
  const _$BillCalculationsImpl({
    this.baseRate = 0.0,
    this.deliveryRate = 0.0,
    this.generationRate = 0.0,
    this.transmissionRate = 0.0,
    this.distributionRate = 0.0,
    this.regulatoryRate = 0.0,
    this.renewableEnergyRate = 0.0,
    this.energyEfficiencyRate = 0.0,
    this.totalRatePerKwh = 0.0,
    this.averageDailyUsage = 0.0,
    this.peakUsage = 0.0,
    this.offPeakUsage = 0.0,
    this.totalUsageCost = 0.0,
  }) : super._();

  factory _$BillCalculationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillCalculationsImplFromJson(json);

  @override
  @JsonKey()
  final double baseRate;
  @override
  @JsonKey()
  final double deliveryRate;
  @override
  @JsonKey()
  final double generationRate;
  @override
  @JsonKey()
  final double transmissionRate;
  @override
  @JsonKey()
  final double distributionRate;
  @override
  @JsonKey()
  final double regulatoryRate;
  @override
  @JsonKey()
  final double renewableEnergyRate;
  @override
  @JsonKey()
  final double energyEfficiencyRate;
  @override
  @JsonKey()
  final double totalRatePerKwh;
  @override
  @JsonKey()
  final double averageDailyUsage;
  @override
  @JsonKey()
  final double peakUsage;
  @override
  @JsonKey()
  final double offPeakUsage;
  @override
  @JsonKey()
  final double totalUsageCost;

  @override
  String toString() {
    return 'BillCalculations(baseRate: $baseRate, deliveryRate: $deliveryRate, generationRate: $generationRate, transmissionRate: $transmissionRate, distributionRate: $distributionRate, regulatoryRate: $regulatoryRate, renewableEnergyRate: $renewableEnergyRate, energyEfficiencyRate: $energyEfficiencyRate, totalRatePerKwh: $totalRatePerKwh, averageDailyUsage: $averageDailyUsage, peakUsage: $peakUsage, offPeakUsage: $offPeakUsage, totalUsageCost: $totalUsageCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillCalculationsImpl &&
            (identical(other.baseRate, baseRate) ||
                other.baseRate == baseRate) &&
            (identical(other.deliveryRate, deliveryRate) ||
                other.deliveryRate == deliveryRate) &&
            (identical(other.generationRate, generationRate) ||
                other.generationRate == generationRate) &&
            (identical(other.transmissionRate, transmissionRate) ||
                other.transmissionRate == transmissionRate) &&
            (identical(other.distributionRate, distributionRate) ||
                other.distributionRate == distributionRate) &&
            (identical(other.regulatoryRate, regulatoryRate) ||
                other.regulatoryRate == regulatoryRate) &&
            (identical(other.renewableEnergyRate, renewableEnergyRate) ||
                other.renewableEnergyRate == renewableEnergyRate) &&
            (identical(other.energyEfficiencyRate, energyEfficiencyRate) ||
                other.energyEfficiencyRate == energyEfficiencyRate) &&
            (identical(other.totalRatePerKwh, totalRatePerKwh) ||
                other.totalRatePerKwh == totalRatePerKwh) &&
            (identical(other.averageDailyUsage, averageDailyUsage) ||
                other.averageDailyUsage == averageDailyUsage) &&
            (identical(other.peakUsage, peakUsage) ||
                other.peakUsage == peakUsage) &&
            (identical(other.offPeakUsage, offPeakUsage) ||
                other.offPeakUsage == offPeakUsage) &&
            (identical(other.totalUsageCost, totalUsageCost) ||
                other.totalUsageCost == totalUsageCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    baseRate,
    deliveryRate,
    generationRate,
    transmissionRate,
    distributionRate,
    regulatoryRate,
    renewableEnergyRate,
    energyEfficiencyRate,
    totalRatePerKwh,
    averageDailyUsage,
    peakUsage,
    offPeakUsage,
    totalUsageCost,
  );

  /// Create a copy of BillCalculations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillCalculationsImplCopyWith<_$BillCalculationsImpl> get copyWith =>
      __$$BillCalculationsImplCopyWithImpl<_$BillCalculationsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BillCalculationsImplToJson(this);
  }
}

abstract class _BillCalculations extends BillCalculations {
  const factory _BillCalculations({
    final double baseRate,
    final double deliveryRate,
    final double generationRate,
    final double transmissionRate,
    final double distributionRate,
    final double regulatoryRate,
    final double renewableEnergyRate,
    final double energyEfficiencyRate,
    final double totalRatePerKwh,
    final double averageDailyUsage,
    final double peakUsage,
    final double offPeakUsage,
    final double totalUsageCost,
  }) = _$BillCalculationsImpl;
  const _BillCalculations._() : super._();

  factory _BillCalculations.fromJson(Map<String, dynamic> json) =
      _$BillCalculationsImpl.fromJson;

  @override
  double get baseRate;
  @override
  double get deliveryRate;
  @override
  double get generationRate;
  @override
  double get transmissionRate;
  @override
  double get distributionRate;
  @override
  double get regulatoryRate;
  @override
  double get renewableEnergyRate;
  @override
  double get energyEfficiencyRate;
  @override
  double get totalRatePerKwh;
  @override
  double get averageDailyUsage;
  @override
  double get peakUsage;
  @override
  double get offPeakUsage;
  @override
  double get totalUsageCost;

  /// Create a copy of BillCalculations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillCalculationsImplCopyWith<_$BillCalculationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillNote _$BillNoteFromJson(Map<String, dynamic> json) {
  return _BillNote.fromJson(json);
}

/// @nodoc
mixin _$BillNote {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  NoteType get type => throw _privateConstructorUsedError;

  /// Serializes this BillNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillNoteCopyWith<BillNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillNoteCopyWith<$Res> {
  factory $BillNoteCopyWith(BillNote value, $Res Function(BillNote) then) =
      _$BillNoteCopyWithImpl<$Res, BillNote>;
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    String createdBy,
    NoteType type,
  });
}

/// @nodoc
class _$BillNoteCopyWithImpl<$Res, $Val extends BillNote>
    implements $BillNoteCopyWith<$Res> {
  _$BillNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NoteType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillNoteImplCopyWith<$Res>
    implements $BillNoteCopyWith<$Res> {
  factory _$$BillNoteImplCopyWith(
    _$BillNoteImpl value,
    $Res Function(_$BillNoteImpl) then,
  ) = __$$BillNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    String createdBy,
    NoteType type,
  });
}

/// @nodoc
class __$$BillNoteImplCopyWithImpl<$Res>
    extends _$BillNoteCopyWithImpl<$Res, _$BillNoteImpl>
    implements _$$BillNoteImplCopyWith<$Res> {
  __$$BillNoteImplCopyWithImpl(
    _$BillNoteImpl _value,
    $Res Function(_$BillNoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? type = null,
  }) {
    return _then(
      _$BillNoteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NoteType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillNoteImpl implements _BillNote {
  const _$BillNoteImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.createdBy,
    this.type = NoteType.info,
  });

  factory _$BillNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillNoteImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final String createdBy;
  @override
  @JsonKey()
  final NoteType type;

  @override
  String toString() {
    return 'BillNote(id: $id, content: $content, createdAt: $createdAt, createdBy: $createdBy, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, createdAt, createdBy, type);

  /// Create a copy of BillNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillNoteImplCopyWith<_$BillNoteImpl> get copyWith =>
      __$$BillNoteImplCopyWithImpl<_$BillNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillNoteImplToJson(this);
  }
}

abstract class _BillNote implements BillNote {
  const factory _BillNote({
    required final String id,
    required final String content,
    required final DateTime createdAt,
    required final String createdBy,
    final NoteType type,
  }) = _$BillNoteImpl;

  factory _BillNote.fromJson(Map<String, dynamic> json) =
      _$BillNoteImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  String get createdBy;
  @override
  NoteType get type;

  /// Create a copy of BillNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillNoteImplCopyWith<_$BillNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
