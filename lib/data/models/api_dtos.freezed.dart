// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _ApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ApiResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
    ApiResponse<T> value,
    $Res Function(ApiResponse<T>) then,
  ) = _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
  @useResult
  $Res call({
    bool success,
    String message,
    T? data,
    List<String> errors,
    String? errorCode,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
    Object? errors = null,
    Object? errorCode = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ApiResponseImplCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$$ApiResponseImplCopyWith(
    _$ApiResponseImpl<T> value,
    $Res Function(_$ApiResponseImpl<T>) then,
  ) = __$$ApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    T? data,
    List<String> errors,
    String? errorCode,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseImpl<T>>
    implements _$$ApiResponseImplCopyWith<T, $Res> {
  __$$ApiResponseImplCopyWithImpl(
    _$ApiResponseImpl<T> _value,
    $Res Function(_$ApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
    Object? errors = null,
    Object? errorCode = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$ApiResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
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
@JsonSerializable(genericArgumentFactories: true)
class _$ApiResponseImpl<T> implements _ApiResponse<T> {
  const _$ApiResponseImpl({
    required this.success,
    required this.message,
    this.data,
    final List<String> errors = const [],
    this.errorCode = null,
    final Map<String, dynamic>? metadata = null,
  }) : _errors = errors,
       _metadata = metadata;

  factory _$ApiResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$ApiResponseImplFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final String message;
  @override
  final T? data;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  @JsonKey()
  final String? errorCode;
  final Map<String, dynamic>? _metadata;
  @override
  @JsonKey()
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data, errors: $errors, errorCode: $errorCode, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(data),
    const DeepCollectionEquality().hash(_errors),
    errorCode,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<T, _$ApiResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ApiResponse<T> implements ApiResponse<T> {
  const factory _ApiResponse({
    required final bool success,
    required final String message,
    final T? data,
    final List<String> errors,
    final String? errorCode,
    final Map<String, dynamic>? metadata,
  }) = _$ApiResponseImpl<T>;

  factory _ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$ApiResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  T? get data;
  @override
  List<String> get errors;
  @override
  String? get errorCode;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) {
  return _PaginationInfo.fromJson(json);
}

/// @nodoc
mixin _$PaginationInfo {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get itemsPerPage => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;
  bool get hasPreviousPage => throw _privateConstructorUsedError;

  /// Serializes this PaginationInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationInfoCopyWith<PaginationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationInfoCopyWith<$Res> {
  factory $PaginationInfoCopyWith(
    PaginationInfo value,
    $Res Function(PaginationInfo) then,
  ) = _$PaginationInfoCopyWithImpl<$Res, PaginationInfo>;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int totalItems,
    int itemsPerPage,
    bool hasNextPage,
    bool hasPreviousPage,
  });
}

/// @nodoc
class _$PaginationInfoCopyWithImpl<$Res, $Val extends PaginationInfo>
    implements $PaginationInfoCopyWith<$Res> {
  _$PaginationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? itemsPerPage = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
  }) {
    return _then(
      _value.copyWith(
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
            itemsPerPage: null == itemsPerPage
                ? _value.itemsPerPage
                : itemsPerPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasNextPage: null == hasNextPage
                ? _value.hasNextPage
                : hasNextPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPreviousPage: null == hasPreviousPage
                ? _value.hasPreviousPage
                : hasPreviousPage // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationInfoImplCopyWith<$Res>
    implements $PaginationInfoCopyWith<$Res> {
  factory _$$PaginationInfoImplCopyWith(
    _$PaginationInfoImpl value,
    $Res Function(_$PaginationInfoImpl) then,
  ) = __$$PaginationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int totalItems,
    int itemsPerPage,
    bool hasNextPage,
    bool hasPreviousPage,
  });
}

/// @nodoc
class __$$PaginationInfoImplCopyWithImpl<$Res>
    extends _$PaginationInfoCopyWithImpl<$Res, _$PaginationInfoImpl>
    implements _$$PaginationInfoImplCopyWith<$Res> {
  __$$PaginationInfoImplCopyWithImpl(
    _$PaginationInfoImpl _value,
    $Res Function(_$PaginationInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? itemsPerPage = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
  }) {
    return _then(
      _$PaginationInfoImpl(
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
        itemsPerPage: null == itemsPerPage
            ? _value.itemsPerPage
            : itemsPerPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasNextPage: null == hasNextPage
            ? _value.hasNextPage
            : hasNextPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPreviousPage: null == hasPreviousPage
            ? _value.hasPreviousPage
            : hasPreviousPage // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationInfoImpl implements _PaginationInfo {
  const _$PaginationInfoImpl({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
  });

  factory _$PaginationInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationInfoImplFromJson(json);

  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  final int totalItems;
  @override
  final int itemsPerPage;
  @override
  @JsonKey()
  final bool hasNextPage;
  @override
  @JsonKey()
  final bool hasPreviousPage;

  @override
  String toString() {
    return 'PaginationInfo(currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, itemsPerPage: $itemsPerPage, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationInfoImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.itemsPerPage, itemsPerPage) ||
                other.itemsPerPage == itemsPerPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentPage,
    totalPages,
    totalItems,
    itemsPerPage,
    hasNextPage,
    hasPreviousPage,
  );

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationInfoImplCopyWith<_$PaginationInfoImpl> get copyWith =>
      __$$PaginationInfoImplCopyWithImpl<_$PaginationInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationInfoImplToJson(this);
  }
}

abstract class _PaginationInfo implements PaginationInfo {
  const factory _PaginationInfo({
    required final int currentPage,
    required final int totalPages,
    required final int totalItems,
    required final int itemsPerPage,
    final bool hasNextPage,
    final bool hasPreviousPage,
  }) = _$PaginationInfoImpl;

  factory _PaginationInfo.fromJson(Map<String, dynamic> json) =
      _$PaginationInfoImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get totalItems;
  @override
  int get itemsPerPage;
  @override
  bool get hasNextPage;
  @override
  bool get hasPreviousPage;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationInfoImplCopyWith<_$PaginationInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _PaginatedResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PaginatedResponse<T> {
  List<T> get data => throw _privateConstructorUsedError;
  PaginationInfo get pagination => throw _privateConstructorUsedError;

  /// Serializes this PaginatedResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResponseCopyWith<T, PaginatedResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResponseCopyWith<T, $Res> {
  factory $PaginatedResponseCopyWith(
    PaginatedResponse<T> value,
    $Res Function(PaginatedResponse<T>) then,
  ) = _$PaginatedResponseCopyWithImpl<T, $Res, PaginatedResponse<T>>;
  @useResult
  $Res call({List<T> data, PaginationInfo pagination});

  $PaginationInfoCopyWith<$Res> get pagination;
}

/// @nodoc
class _$PaginatedResponseCopyWithImpl<
  T,
  $Res,
  $Val extends PaginatedResponse<T>
>
    implements $PaginatedResponseCopyWith<T, $Res> {
  _$PaginatedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null, Object? pagination = null}) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            pagination: null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                      as PaginationInfo,
          )
          as $Val,
    );
  }

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationInfoCopyWith<$Res> get pagination {
    return $PaginationInfoCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginatedResponseImplCopyWith<T, $Res>
    implements $PaginatedResponseCopyWith<T, $Res> {
  factory _$$PaginatedResponseImplCopyWith(
    _$PaginatedResponseImpl<T> value,
    $Res Function(_$PaginatedResponseImpl<T>) then,
  ) = __$$PaginatedResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> data, PaginationInfo pagination});

  @override
  $PaginationInfoCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$PaginatedResponseImplCopyWithImpl<T, $Res>
    extends _$PaginatedResponseCopyWithImpl<T, $Res, _$PaginatedResponseImpl<T>>
    implements _$$PaginatedResponseImplCopyWith<T, $Res> {
  __$$PaginatedResponseImplCopyWithImpl(
    _$PaginatedResponseImpl<T> _value,
    $Res Function(_$PaginatedResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null, Object? pagination = null}) {
    return _then(
      _$PaginatedResponseImpl<T>(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        pagination: null == pagination
            ? _value.pagination
            : pagination // ignore: cast_nullable_to_non_nullable
                  as PaginationInfo,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PaginatedResponseImpl<T> implements _PaginatedResponse<T> {
  const _$PaginatedResponseImpl({
    required final List<T> data,
    required this.pagination,
  }) : _data = data;

  factory _$PaginatedResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$PaginatedResponseImplFromJson(json, fromJsonT);

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationInfo pagination;

  @override
  String toString() {
    return 'PaginatedResponse<$T>(data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResponseImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    pagination,
  );

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith =>
      __$$PaginatedResponseImplCopyWithImpl<T, _$PaginatedResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PaginatedResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _PaginatedResponse<T> implements PaginatedResponse<T> {
  const factory _PaginatedResponse({
    required final List<T> data,
    required final PaginationInfo pagination,
  }) = _$PaginatedResponseImpl<T>;

  factory _PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$PaginatedResponseImpl<T>.fromJson;

  @override
  List<T> get data;
  @override
  PaginationInfo get pagination;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResponseImplCopyWith<T, _$PaginatedResponseImpl<T>>
  get copyWith => throw _privateConstructorUsedError;
}

PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) {
  return _PaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$PaymentRequest {
  String get billId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get paymentMethodId => throw _privateConstructorUsedError;
  PaymentMethodType get paymentMethodType => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PaymentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentRequestCopyWith<PaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentRequestCopyWith<$Res> {
  factory $PaymentRequestCopyWith(
    PaymentRequest value,
    $Res Function(PaymentRequest) then,
  ) = _$PaymentRequestCopyWithImpl<$Res, PaymentRequest>;
  @useResult
  $Res call({
    String billId,
    double amount,
    String paymentMethodId,
    PaymentMethodType paymentMethodType,
    bool isRecurring,
    String? notes,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$PaymentRequestCopyWithImpl<$Res, $Val extends PaymentRequest>
    implements $PaymentRequestCopyWith<$Res> {
  _$PaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billId = null,
    Object? amount = null,
    Object? paymentMethodId = null,
    Object? paymentMethodType = null,
    Object? isRecurring = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            billId: null == billId
                ? _value.billId
                : billId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethodId: null == paymentMethodId
                ? _value.paymentMethodId
                : paymentMethodId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethodType: null == paymentMethodType
                ? _value.paymentMethodType
                : paymentMethodType // ignore: cast_nullable_to_non_nullable
                      as PaymentMethodType,
            isRecurring: null == isRecurring
                ? _value.isRecurring
                : isRecurring // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$PaymentRequestImplCopyWith<$Res>
    implements $PaymentRequestCopyWith<$Res> {
  factory _$$PaymentRequestImplCopyWith(
    _$PaymentRequestImpl value,
    $Res Function(_$PaymentRequestImpl) then,
  ) = __$$PaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String billId,
    double amount,
    String paymentMethodId,
    PaymentMethodType paymentMethodType,
    bool isRecurring,
    String? notes,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$PaymentRequestImplCopyWithImpl<$Res>
    extends _$PaymentRequestCopyWithImpl<$Res, _$PaymentRequestImpl>
    implements _$$PaymentRequestImplCopyWith<$Res> {
  __$$PaymentRequestImplCopyWithImpl(
    _$PaymentRequestImpl _value,
    $Res Function(_$PaymentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billId = null,
    Object? amount = null,
    Object? paymentMethodId = null,
    Object? paymentMethodType = null,
    Object? isRecurring = null,
    Object? notes = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$PaymentRequestImpl(
        billId: null == billId
            ? _value.billId
            : billId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethodId: null == paymentMethodId
            ? _value.paymentMethodId
            : paymentMethodId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethodType: null == paymentMethodType
            ? _value.paymentMethodType
            : paymentMethodType // ignore: cast_nullable_to_non_nullable
                  as PaymentMethodType,
        isRecurring: null == isRecurring
            ? _value.isRecurring
            : isRecurring // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$PaymentRequestImpl extends _PaymentRequest {
  const _$PaymentRequestImpl({
    required this.billId,
    required this.amount,
    required this.paymentMethodId,
    required this.paymentMethodType,
    this.isRecurring = false,
    this.notes,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$PaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentRequestImplFromJson(json);

  @override
  final String billId;
  @override
  final double amount;
  @override
  final String paymentMethodId;
  @override
  final PaymentMethodType paymentMethodType;
  @override
  @JsonKey()
  final bool isRecurring;
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
    return 'PaymentRequest(billId: $billId, amount: $amount, paymentMethodId: $paymentMethodId, paymentMethodType: $paymentMethodType, isRecurring: $isRecurring, notes: $notes, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentRequestImpl &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.paymentMethodType, paymentMethodType) ||
                other.paymentMethodType == paymentMethodType) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    billId,
    amount,
    paymentMethodId,
    paymentMethodType,
    isRecurring,
    notes,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentRequestImplCopyWith<_$PaymentRequestImpl> get copyWith =>
      __$$PaymentRequestImplCopyWithImpl<_$PaymentRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentRequestImplToJson(this);
  }
}

abstract class _PaymentRequest extends PaymentRequest {
  const factory _PaymentRequest({
    required final String billId,
    required final double amount,
    required final String paymentMethodId,
    required final PaymentMethodType paymentMethodType,
    final bool isRecurring,
    final String? notes,
    final Map<String, dynamic>? metadata,
  }) = _$PaymentRequestImpl;
  const _PaymentRequest._() : super._();

  factory _PaymentRequest.fromJson(Map<String, dynamic> json) =
      _$PaymentRequestImpl.fromJson;

  @override
  String get billId;
  @override
  double get amount;
  @override
  String get paymentMethodId;
  @override
  PaymentMethodType get paymentMethodType;
  @override
  bool get isRecurring;
  @override
  String? get notes;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentRequestImplCopyWith<_$PaymentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return _PaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentResponse {
  String get transactionId => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get processedAt => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PaymentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentResponseCopyWith<PaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentResponseCopyWith<$Res> {
  factory $PaymentResponseCopyWith(
    PaymentResponse value,
    $Res Function(PaymentResponse) then,
  ) = _$PaymentResponseCopyWithImpl<$Res, PaymentResponse>;
  @useResult
  $Res call({
    String transactionId,
    PaymentStatus status,
    double amount,
    DateTime processedAt,
    String? referenceNumber,
    String? receiptUrl,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$PaymentResponseCopyWithImpl<$Res, $Val extends PaymentResponse>
    implements $PaymentResponseCopyWith<$Res> {
  _$PaymentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? status = null,
    Object? amount = null,
    Object? processedAt = null,
    Object? referenceNumber = freezed,
    Object? receiptUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            processedAt: null == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiptUrl: freezed == receiptUrl
                ? _value.receiptUrl
                : receiptUrl // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PaymentResponseImplCopyWith<$Res>
    implements $PaymentResponseCopyWith<$Res> {
  factory _$$PaymentResponseImplCopyWith(
    _$PaymentResponseImpl value,
    $Res Function(_$PaymentResponseImpl) then,
  ) = __$$PaymentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String transactionId,
    PaymentStatus status,
    double amount,
    DateTime processedAt,
    String? referenceNumber,
    String? receiptUrl,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$PaymentResponseImplCopyWithImpl<$Res>
    extends _$PaymentResponseCopyWithImpl<$Res, _$PaymentResponseImpl>
    implements _$$PaymentResponseImplCopyWith<$Res> {
  __$$PaymentResponseImplCopyWithImpl(
    _$PaymentResponseImpl _value,
    $Res Function(_$PaymentResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? status = null,
    Object? amount = null,
    Object? processedAt = null,
    Object? referenceNumber = freezed,
    Object? receiptUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$PaymentResponseImpl(
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        processedAt: null == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiptUrl: freezed == receiptUrl
            ? _value.receiptUrl
            : receiptUrl // ignore: cast_nullable_to_non_nullable
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
class _$PaymentResponseImpl implements _PaymentResponse {
  const _$PaymentResponseImpl({
    required this.transactionId,
    required this.status,
    required this.amount,
    required this.processedAt,
    this.referenceNumber,
    this.receiptUrl,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$PaymentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentResponseImplFromJson(json);

  @override
  final String transactionId;
  @override
  final PaymentStatus status;
  @override
  final double amount;
  @override
  final DateTime processedAt;
  @override
  final String? referenceNumber;
  @override
  final String? receiptUrl;
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
    return 'PaymentResponse(transactionId: $transactionId, status: $status, amount: $amount, processedAt: $processedAt, referenceNumber: $referenceNumber, receiptUrl: $receiptUrl, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentResponseImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    transactionId,
    status,
    amount,
    processedAt,
    referenceNumber,
    receiptUrl,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentResponseImplCopyWith<_$PaymentResponseImpl> get copyWith =>
      __$$PaymentResponseImplCopyWithImpl<_$PaymentResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentResponseImplToJson(this);
  }
}

abstract class _PaymentResponse implements PaymentResponse {
  const factory _PaymentResponse({
    required final String transactionId,
    required final PaymentStatus status,
    required final double amount,
    required final DateTime processedAt,
    final String? referenceNumber,
    final String? receiptUrl,
    final Map<String, dynamic>? metadata,
  }) = _$PaymentResponseImpl;

  factory _PaymentResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentResponseImpl.fromJson;

  @override
  String get transactionId;
  @override
  PaymentStatus get status;
  @override
  double get amount;
  @override
  DateTime get processedAt;
  @override
  String? get referenceNumber;
  @override
  String? get receiptUrl;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentResponseImplCopyWith<_$PaymentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageRequest _$UsageRequestFromJson(Map<String, dynamic> json) {
  return _UsageRequest.fromJson(json);
}

/// @nodoc
mixin _$UsageRequest {
  String get accountNumber => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  UsageGranularity get granularity => throw _privateConstructorUsedError;
  bool get includeForecast => throw _privateConstructorUsedError;
  bool get includeAnomalies => throw _privateConstructorUsedError;
  bool get includeTips => throw _privateConstructorUsedError;

  /// Serializes this UsageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageRequestCopyWith<UsageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageRequestCopyWith<$Res> {
  factory $UsageRequestCopyWith(
    UsageRequest value,
    $Res Function(UsageRequest) then,
  ) = _$UsageRequestCopyWithImpl<$Res, UsageRequest>;
  @useResult
  $Res call({
    String accountNumber,
    DateTime startDate,
    DateTime endDate,
    UsageGranularity granularity,
    bool includeForecast,
    bool includeAnomalies,
    bool includeTips,
  });
}

/// @nodoc
class _$UsageRequestCopyWithImpl<$Res, $Val extends UsageRequest>
    implements $UsageRequestCopyWith<$Res> {
  _$UsageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? granularity = null,
    Object? includeForecast = null,
    Object? includeAnomalies = null,
    Object? includeTips = null,
  }) {
    return _then(
      _value.copyWith(
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            granularity: null == granularity
                ? _value.granularity
                : granularity // ignore: cast_nullable_to_non_nullable
                      as UsageGranularity,
            includeForecast: null == includeForecast
                ? _value.includeForecast
                : includeForecast // ignore: cast_nullable_to_non_nullable
                      as bool,
            includeAnomalies: null == includeAnomalies
                ? _value.includeAnomalies
                : includeAnomalies // ignore: cast_nullable_to_non_nullable
                      as bool,
            includeTips: null == includeTips
                ? _value.includeTips
                : includeTips // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsageRequestImplCopyWith<$Res>
    implements $UsageRequestCopyWith<$Res> {
  factory _$$UsageRequestImplCopyWith(
    _$UsageRequestImpl value,
    $Res Function(_$UsageRequestImpl) then,
  ) = __$$UsageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accountNumber,
    DateTime startDate,
    DateTime endDate,
    UsageGranularity granularity,
    bool includeForecast,
    bool includeAnomalies,
    bool includeTips,
  });
}

/// @nodoc
class __$$UsageRequestImplCopyWithImpl<$Res>
    extends _$UsageRequestCopyWithImpl<$Res, _$UsageRequestImpl>
    implements _$$UsageRequestImplCopyWith<$Res> {
  __$$UsageRequestImplCopyWithImpl(
    _$UsageRequestImpl _value,
    $Res Function(_$UsageRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? granularity = null,
    Object? includeForecast = null,
    Object? includeAnomalies = null,
    Object? includeTips = null,
  }) {
    return _then(
      _$UsageRequestImpl(
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        granularity: null == granularity
            ? _value.granularity
            : granularity // ignore: cast_nullable_to_non_nullable
                  as UsageGranularity,
        includeForecast: null == includeForecast
            ? _value.includeForecast
            : includeForecast // ignore: cast_nullable_to_non_nullable
                  as bool,
        includeAnomalies: null == includeAnomalies
            ? _value.includeAnomalies
            : includeAnomalies // ignore: cast_nullable_to_non_nullable
                  as bool,
        includeTips: null == includeTips
            ? _value.includeTips
            : includeTips // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageRequestImpl extends _UsageRequest {
  const _$UsageRequestImpl({
    required this.accountNumber,
    required this.startDate,
    required this.endDate,
    this.granularity = UsageGranularity.daily,
    this.includeForecast = false,
    this.includeAnomalies = false,
    this.includeTips = false,
  }) : super._();

  factory _$UsageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageRequestImplFromJson(json);

  @override
  final String accountNumber;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final UsageGranularity granularity;
  @override
  @JsonKey()
  final bool includeForecast;
  @override
  @JsonKey()
  final bool includeAnomalies;
  @override
  @JsonKey()
  final bool includeTips;

  @override
  String toString() {
    return 'UsageRequest(accountNumber: $accountNumber, startDate: $startDate, endDate: $endDate, granularity: $granularity, includeForecast: $includeForecast, includeAnomalies: $includeAnomalies, includeTips: $includeTips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageRequestImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.granularity, granularity) ||
                other.granularity == granularity) &&
            (identical(other.includeForecast, includeForecast) ||
                other.includeForecast == includeForecast) &&
            (identical(other.includeAnomalies, includeAnomalies) ||
                other.includeAnomalies == includeAnomalies) &&
            (identical(other.includeTips, includeTips) ||
                other.includeTips == includeTips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountNumber,
    startDate,
    endDate,
    granularity,
    includeForecast,
    includeAnomalies,
    includeTips,
  );

  /// Create a copy of UsageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageRequestImplCopyWith<_$UsageRequestImpl> get copyWith =>
      __$$UsageRequestImplCopyWithImpl<_$UsageRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageRequestImplToJson(this);
  }
}

abstract class _UsageRequest extends UsageRequest {
  const factory _UsageRequest({
    required final String accountNumber,
    required final DateTime startDate,
    required final DateTime endDate,
    final UsageGranularity granularity,
    final bool includeForecast,
    final bool includeAnomalies,
    final bool includeTips,
  }) = _$UsageRequestImpl;
  const _UsageRequest._() : super._();

  factory _UsageRequest.fromJson(Map<String, dynamic> json) =
      _$UsageRequestImpl.fromJson;

  @override
  String get accountNumber;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  UsageGranularity get granularity;
  @override
  bool get includeForecast;
  @override
  bool get includeAnomalies;
  @override
  bool get includeTips;

  /// Create a copy of UsageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageRequestImplCopyWith<_$UsageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BillRequest _$BillRequestFromJson(Map<String, dynamic> json) {
  return _BillRequest.fromJson(json);
}

/// @nodoc
mixin _$BillRequest {
  String get accountNumber => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;
  BillStatus get status => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get includePaymentHistory => throw _privateConstructorUsedError;
  bool get includeCalculations => throw _privateConstructorUsedError;

  /// Serializes this BillRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillRequestCopyWith<BillRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillRequestCopyWith<$Res> {
  factory $BillRequestCopyWith(
    BillRequest value,
    $Res Function(BillRequest) then,
  ) = _$BillRequestCopyWithImpl<$Res, BillRequest>;
  @useResult
  $Res call({
    String accountNumber,
    int limit,
    int offset,
    BillStatus status,
    DateTime? startDate,
    DateTime? endDate,
    bool includePaymentHistory,
    bool includeCalculations,
  });
}

/// @nodoc
class _$BillRequestCopyWithImpl<$Res, $Val extends BillRequest>
    implements $BillRequestCopyWith<$Res> {
  _$BillRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? limit = null,
    Object? offset = null,
    Object? status = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? includePaymentHistory = null,
    Object? includeCalculations = null,
  }) {
    return _then(
      _value.copyWith(
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BillStatus,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            includePaymentHistory: null == includePaymentHistory
                ? _value.includePaymentHistory
                : includePaymentHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            includeCalculations: null == includeCalculations
                ? _value.includeCalculations
                : includeCalculations // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillRequestImplCopyWith<$Res>
    implements $BillRequestCopyWith<$Res> {
  factory _$$BillRequestImplCopyWith(
    _$BillRequestImpl value,
    $Res Function(_$BillRequestImpl) then,
  ) = __$$BillRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accountNumber,
    int limit,
    int offset,
    BillStatus status,
    DateTime? startDate,
    DateTime? endDate,
    bool includePaymentHistory,
    bool includeCalculations,
  });
}

/// @nodoc
class __$$BillRequestImplCopyWithImpl<$Res>
    extends _$BillRequestCopyWithImpl<$Res, _$BillRequestImpl>
    implements _$$BillRequestImplCopyWith<$Res> {
  __$$BillRequestImplCopyWithImpl(
    _$BillRequestImpl _value,
    $Res Function(_$BillRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? limit = null,
    Object? offset = null,
    Object? status = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? includePaymentHistory = null,
    Object? includeCalculations = null,
  }) {
    return _then(
      _$BillRequestImpl(
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BillStatus,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        includePaymentHistory: null == includePaymentHistory
            ? _value.includePaymentHistory
            : includePaymentHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        includeCalculations: null == includeCalculations
            ? _value.includeCalculations
            : includeCalculations // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillRequestImpl extends _BillRequest {
  const _$BillRequestImpl({
    required this.accountNumber,
    this.limit = 10,
    this.offset = 0,
    this.status = BillStatus.pending,
    this.startDate,
    this.endDate,
    this.includePaymentHistory = false,
    this.includeCalculations = false,
  }) : super._();

  factory _$BillRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillRequestImplFromJson(json);

  @override
  final String accountNumber;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;
  @override
  @JsonKey()
  final BillStatus status;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool includePaymentHistory;
  @override
  @JsonKey()
  final bool includeCalculations;

  @override
  String toString() {
    return 'BillRequest(accountNumber: $accountNumber, limit: $limit, offset: $offset, status: $status, startDate: $startDate, endDate: $endDate, includePaymentHistory: $includePaymentHistory, includeCalculations: $includeCalculations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillRequestImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.includePaymentHistory, includePaymentHistory) ||
                other.includePaymentHistory == includePaymentHistory) &&
            (identical(other.includeCalculations, includeCalculations) ||
                other.includeCalculations == includeCalculations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountNumber,
    limit,
    offset,
    status,
    startDate,
    endDate,
    includePaymentHistory,
    includeCalculations,
  );

  /// Create a copy of BillRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillRequestImplCopyWith<_$BillRequestImpl> get copyWith =>
      __$$BillRequestImplCopyWithImpl<_$BillRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillRequestImplToJson(this);
  }
}

abstract class _BillRequest extends BillRequest {
  const factory _BillRequest({
    required final String accountNumber,
    final int limit,
    final int offset,
    final BillStatus status,
    final DateTime? startDate,
    final DateTime? endDate,
    final bool includePaymentHistory,
    final bool includeCalculations,
  }) = _$BillRequestImpl;
  const _BillRequest._() : super._();

  factory _BillRequest.fromJson(Map<String, dynamic> json) =
      _$BillRequestImpl.fromJson;

  @override
  String get accountNumber;
  @override
  int get limit;
  @override
  int get offset;
  @override
  BillStatus get status;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get includePaymentHistory;
  @override
  bool get includeCalculations;

  /// Create a copy of BillRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillRequestImplCopyWith<_$BillRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileUpdateRequest _$UserProfileUpdateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UserProfileUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$UserProfileUpdateRequest {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  UserPreferences? get preferences => throw _privateConstructorUsedError;
  UserSettings? get settings => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this UserProfileUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileUpdateRequestCopyWith<UserProfileUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileUpdateRequestCopyWith<$Res> {
  factory $UserProfileUpdateRequestCopyWith(
    UserProfileUpdateRequest value,
    $Res Function(UserProfileUpdateRequest) then,
  ) = _$UserProfileUpdateRequestCopyWithImpl<$Res, UserProfileUpdateRequest>;
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    Address? address,
    UserPreferences? preferences,
    UserSettings? settings,
    Map<String, dynamic>? metadata,
  });

  $AddressCopyWith<$Res>? get address;
  $UserPreferencesCopyWith<$Res>? get preferences;
  $UserSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$UserProfileUpdateRequestCopyWithImpl<
  $Res,
  $Val extends UserProfileUpdateRequest
>
    implements $UserProfileUpdateRequestCopyWith<$Res> {
  _$UserProfileUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? preferences = freezed,
    Object? settings = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as Address?,
            preferences: freezed == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as UserPreferences?,
            settings: freezed == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as UserSettings?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $UserPreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $UserSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileUpdateRequestImplCopyWith<$Res>
    implements $UserProfileUpdateRequestCopyWith<$Res> {
  factory _$$UserProfileUpdateRequestImplCopyWith(
    _$UserProfileUpdateRequestImpl value,
    $Res Function(_$UserProfileUpdateRequestImpl) then,
  ) = __$$UserProfileUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    Address? address,
    UserPreferences? preferences,
    UserSettings? settings,
    Map<String, dynamic>? metadata,
  });

  @override
  $AddressCopyWith<$Res>? get address;
  @override
  $UserPreferencesCopyWith<$Res>? get preferences;
  @override
  $UserSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$UserProfileUpdateRequestImplCopyWithImpl<$Res>
    extends
        _$UserProfileUpdateRequestCopyWithImpl<
          $Res,
          _$UserProfileUpdateRequestImpl
        >
    implements _$$UserProfileUpdateRequestImplCopyWith<$Res> {
  __$$UserProfileUpdateRequestImplCopyWithImpl(
    _$UserProfileUpdateRequestImpl _value,
    $Res Function(_$UserProfileUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? preferences = freezed,
    Object? settings = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$UserProfileUpdateRequestImpl(
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as Address?,
        preferences: freezed == preferences
            ? _value.preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as UserPreferences?,
        settings: freezed == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as UserSettings?,
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
class _$UserProfileUpdateRequestImpl extends _UserProfileUpdateRequest {
  const _$UserProfileUpdateRequestImpl({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.address,
    this.preferences,
    this.settings,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$UserProfileUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileUpdateRequestImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final Address? address;
  @override
  final UserPreferences? preferences;
  @override
  final UserSettings? settings;
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
    return 'UserProfileUpdateRequest(firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, address: $address, preferences: $preferences, settings: $settings, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileUpdateRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    phone,
    email,
    address,
    preferences,
    settings,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileUpdateRequestImplCopyWith<_$UserProfileUpdateRequestImpl>
  get copyWith =>
      __$$UserProfileUpdateRequestImplCopyWithImpl<
        _$UserProfileUpdateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileUpdateRequestImplToJson(this);
  }
}

abstract class _UserProfileUpdateRequest extends UserProfileUpdateRequest {
  const factory _UserProfileUpdateRequest({
    final String? firstName,
    final String? lastName,
    final String? phone,
    final String? email,
    final Address? address,
    final UserPreferences? preferences,
    final UserSettings? settings,
    final Map<String, dynamic>? metadata,
  }) = _$UserProfileUpdateRequestImpl;
  const _UserProfileUpdateRequest._() : super._();

  factory _UserProfileUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$UserProfileUpdateRequestImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  Address? get address;
  @override
  UserPreferences? get preferences;
  @override
  UserSettings? get settings;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of UserProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileUpdateRequestImplCopyWith<_$UserProfileUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NotificationRequest _$NotificationRequestFromJson(Map<String, dynamic> json) {
  return _NotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationRequest {
  String get userId => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;
  bool get sendEmail => throw _privateConstructorUsedError;
  bool get sendSms => throw _privateConstructorUsedError;
  bool get sendPush => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this NotificationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationRequestCopyWith<NotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRequestCopyWith<$Res> {
  factory $NotificationRequestCopyWith(
    NotificationRequest value,
    $Res Function(NotificationRequest) then,
  ) = _$NotificationRequestCopyWithImpl<$Res, NotificationRequest>;
  @useResult
  $Res call({
    String userId,
    NotificationType type,
    String title,
    String message,
    bool isImportant,
    bool sendEmail,
    bool sendSms,
    bool sendPush,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$NotificationRequestCopyWithImpl<$Res, $Val extends NotificationRequest>
    implements $NotificationRequestCopyWith<$Res> {
  _$NotificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? isImportant = null,
    Object? sendEmail = null,
    Object? sendSms = null,
    Object? sendPush = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NotificationType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            isImportant: null == isImportant
                ? _value.isImportant
                : isImportant // ignore: cast_nullable_to_non_nullable
                      as bool,
            sendEmail: null == sendEmail
                ? _value.sendEmail
                : sendEmail // ignore: cast_nullable_to_non_nullable
                      as bool,
            sendSms: null == sendSms
                ? _value.sendSms
                : sendSms // ignore: cast_nullable_to_non_nullable
                      as bool,
            sendPush: null == sendPush
                ? _value.sendPush
                : sendPush // ignore: cast_nullable_to_non_nullable
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
abstract class _$$NotificationRequestImplCopyWith<$Res>
    implements $NotificationRequestCopyWith<$Res> {
  factory _$$NotificationRequestImplCopyWith(
    _$NotificationRequestImpl value,
    $Res Function(_$NotificationRequestImpl) then,
  ) = __$$NotificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    NotificationType type,
    String title,
    String message,
    bool isImportant,
    bool sendEmail,
    bool sendSms,
    bool sendPush,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$NotificationRequestImplCopyWithImpl<$Res>
    extends _$NotificationRequestCopyWithImpl<$Res, _$NotificationRequestImpl>
    implements _$$NotificationRequestImplCopyWith<$Res> {
  __$$NotificationRequestImplCopyWithImpl(
    _$NotificationRequestImpl _value,
    $Res Function(_$NotificationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? isImportant = null,
    Object? sendEmail = null,
    Object? sendSms = null,
    Object? sendPush = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$NotificationRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NotificationType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        isImportant: null == isImportant
            ? _value.isImportant
            : isImportant // ignore: cast_nullable_to_non_nullable
                  as bool,
        sendEmail: null == sendEmail
            ? _value.sendEmail
            : sendEmail // ignore: cast_nullable_to_non_nullable
                  as bool,
        sendSms: null == sendSms
            ? _value.sendSms
            : sendSms // ignore: cast_nullable_to_non_nullable
                  as bool,
        sendPush: null == sendPush
            ? _value.sendPush
            : sendPush // ignore: cast_nullable_to_non_nullable
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
class _$NotificationRequestImpl extends _NotificationRequest {
  const _$NotificationRequestImpl({
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    this.isImportant = false,
    this.sendEmail = false,
    this.sendSms = false,
    this.sendPush = false,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();

  factory _$NotificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationRequestImplFromJson(json);

  @override
  final String userId;
  @override
  final NotificationType type;
  @override
  final String title;
  @override
  final String message;
  @override
  @JsonKey()
  final bool isImportant;
  @override
  @JsonKey()
  final bool sendEmail;
  @override
  @JsonKey()
  final bool sendSms;
  @override
  @JsonKey()
  final bool sendPush;
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
    return 'NotificationRequest(userId: $userId, type: $type, title: $title, message: $message, isImportant: $isImportant, sendEmail: $sendEmail, sendSms: $sendSms, sendPush: $sendPush, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.sendEmail, sendEmail) ||
                other.sendEmail == sendEmail) &&
            (identical(other.sendSms, sendSms) || other.sendSms == sendSms) &&
            (identical(other.sendPush, sendPush) ||
                other.sendPush == sendPush) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    type,
    title,
    message,
    isImportant,
    sendEmail,
    sendSms,
    sendPush,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRequestImplCopyWith<_$NotificationRequestImpl> get copyWith =>
      __$$NotificationRequestImplCopyWithImpl<_$NotificationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRequestImplToJson(this);
  }
}

abstract class _NotificationRequest extends NotificationRequest {
  const factory _NotificationRequest({
    required final String userId,
    required final NotificationType type,
    required final String title,
    required final String message,
    final bool isImportant,
    final bool sendEmail,
    final bool sendSms,
    final bool sendPush,
    final Map<String, dynamic>? metadata,
  }) = _$NotificationRequestImpl;
  const _NotificationRequest._() : super._();

  factory _NotificationRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationRequestImpl.fromJson;

  @override
  String get userId;
  @override
  NotificationType get type;
  @override
  String get title;
  @override
  String get message;
  @override
  bool get isImportant;
  @override
  bool get sendEmail;
  @override
  bool get sendSms;
  @override
  bool get sendPush;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationRequestImplCopyWith<_$NotificationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsRequest _$AnalyticsRequestFromJson(Map<String, dynamic> json) {
  return _AnalyticsRequest.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsRequest {
  String get accountNumber => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<AnalyticsMetric> get metrics => throw _privateConstructorUsedError;
  AnalyticsGranularity get granularity => throw _privateConstructorUsedError;
  bool get includeComparisons => throw _privateConstructorUsedError;
  bool get includeForecasts => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsRequestCopyWith<AnalyticsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsRequestCopyWith<$Res> {
  factory $AnalyticsRequestCopyWith(
    AnalyticsRequest value,
    $Res Function(AnalyticsRequest) then,
  ) = _$AnalyticsRequestCopyWithImpl<$Res, AnalyticsRequest>;
  @useResult
  $Res call({
    String accountNumber,
    DateTime startDate,
    DateTime endDate,
    List<AnalyticsMetric> metrics,
    AnalyticsGranularity granularity,
    bool includeComparisons,
    bool includeForecasts,
  });
}

/// @nodoc
class _$AnalyticsRequestCopyWithImpl<$Res, $Val extends AnalyticsRequest>
    implements $AnalyticsRequestCopyWith<$Res> {
  _$AnalyticsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? metrics = null,
    Object? granularity = null,
    Object? includeComparisons = null,
    Object? includeForecasts = null,
  }) {
    return _then(
      _value.copyWith(
            accountNumber: null == accountNumber
                ? _value.accountNumber
                : accountNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            metrics: null == metrics
                ? _value.metrics
                : metrics // ignore: cast_nullable_to_non_nullable
                      as List<AnalyticsMetric>,
            granularity: null == granularity
                ? _value.granularity
                : granularity // ignore: cast_nullable_to_non_nullable
                      as AnalyticsGranularity,
            includeComparisons: null == includeComparisons
                ? _value.includeComparisons
                : includeComparisons // ignore: cast_nullable_to_non_nullable
                      as bool,
            includeForecasts: null == includeForecasts
                ? _value.includeForecasts
                : includeForecasts // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsRequestImplCopyWith<$Res>
    implements $AnalyticsRequestCopyWith<$Res> {
  factory _$$AnalyticsRequestImplCopyWith(
    _$AnalyticsRequestImpl value,
    $Res Function(_$AnalyticsRequestImpl) then,
  ) = __$$AnalyticsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accountNumber,
    DateTime startDate,
    DateTime endDate,
    List<AnalyticsMetric> metrics,
    AnalyticsGranularity granularity,
    bool includeComparisons,
    bool includeForecasts,
  });
}

/// @nodoc
class __$$AnalyticsRequestImplCopyWithImpl<$Res>
    extends _$AnalyticsRequestCopyWithImpl<$Res, _$AnalyticsRequestImpl>
    implements _$$AnalyticsRequestImplCopyWith<$Res> {
  __$$AnalyticsRequestImplCopyWithImpl(
    _$AnalyticsRequestImpl _value,
    $Res Function(_$AnalyticsRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? metrics = null,
    Object? granularity = null,
    Object? includeComparisons = null,
    Object? includeForecasts = null,
  }) {
    return _then(
      _$AnalyticsRequestImpl(
        accountNumber: null == accountNumber
            ? _value.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        metrics: null == metrics
            ? _value._metrics
            : metrics // ignore: cast_nullable_to_non_nullable
                  as List<AnalyticsMetric>,
        granularity: null == granularity
            ? _value.granularity
            : granularity // ignore: cast_nullable_to_non_nullable
                  as AnalyticsGranularity,
        includeComparisons: null == includeComparisons
            ? _value.includeComparisons
            : includeComparisons // ignore: cast_nullable_to_non_nullable
                  as bool,
        includeForecasts: null == includeForecasts
            ? _value.includeForecasts
            : includeForecasts // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsRequestImpl extends _AnalyticsRequest {
  const _$AnalyticsRequestImpl({
    required this.accountNumber,
    required this.startDate,
    required this.endDate,
    final List<AnalyticsMetric> metrics = const [],
    this.granularity = AnalyticsGranularity.daily,
    this.includeComparisons = false,
    this.includeForecasts = false,
  }) : _metrics = metrics,
       super._();

  factory _$AnalyticsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsRequestImplFromJson(json);

  @override
  final String accountNumber;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<AnalyticsMetric> _metrics;
  @override
  @JsonKey()
  List<AnalyticsMetric> get metrics {
    if (_metrics is EqualUnmodifiableListView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metrics);
  }

  @override
  @JsonKey()
  final AnalyticsGranularity granularity;
  @override
  @JsonKey()
  final bool includeComparisons;
  @override
  @JsonKey()
  final bool includeForecasts;

  @override
  String toString() {
    return 'AnalyticsRequest(accountNumber: $accountNumber, startDate: $startDate, endDate: $endDate, metrics: $metrics, granularity: $granularity, includeComparisons: $includeComparisons, includeForecasts: $includeForecasts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsRequestImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.granularity, granularity) ||
                other.granularity == granularity) &&
            (identical(other.includeComparisons, includeComparisons) ||
                other.includeComparisons == includeComparisons) &&
            (identical(other.includeForecasts, includeForecasts) ||
                other.includeForecasts == includeForecasts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountNumber,
    startDate,
    endDate,
    const DeepCollectionEquality().hash(_metrics),
    granularity,
    includeComparisons,
    includeForecasts,
  );

  /// Create a copy of AnalyticsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsRequestImplCopyWith<_$AnalyticsRequestImpl> get copyWith =>
      __$$AnalyticsRequestImplCopyWithImpl<_$AnalyticsRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsRequestImplToJson(this);
  }
}

abstract class _AnalyticsRequest extends AnalyticsRequest {
  const factory _AnalyticsRequest({
    required final String accountNumber,
    required final DateTime startDate,
    required final DateTime endDate,
    final List<AnalyticsMetric> metrics,
    final AnalyticsGranularity granularity,
    final bool includeComparisons,
    final bool includeForecasts,
  }) = _$AnalyticsRequestImpl;
  const _AnalyticsRequest._() : super._();

  factory _AnalyticsRequest.fromJson(Map<String, dynamic> json) =
      _$AnalyticsRequestImpl.fromJson;

  @override
  String get accountNumber;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<AnalyticsMetric> get metrics;
  @override
  AnalyticsGranularity get granularity;
  @override
  bool get includeComparisons;
  @override
  bool get includeForecasts;

  /// Create a copy of AnalyticsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsRequestImplCopyWith<_$AnalyticsRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsResponse _$AnalyticsResponseFromJson(Map<String, dynamic> json) {
  return _AnalyticsResponse.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsResponse {
  List<AnalyticsDataPoint> get dataPoints => throw _privateConstructorUsedError;
  Map<String, double> get summary => throw _privateConstructorUsedError;
  List<AnalyticsInsight> get insights => throw _privateConstructorUsedError;
  List<AnalyticsRecommendation> get recommendations =>
      throw _privateConstructorUsedError;

  /// Serializes this AnalyticsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsResponseCopyWith<AnalyticsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsResponseCopyWith<$Res> {
  factory $AnalyticsResponseCopyWith(
    AnalyticsResponse value,
    $Res Function(AnalyticsResponse) then,
  ) = _$AnalyticsResponseCopyWithImpl<$Res, AnalyticsResponse>;
  @useResult
  $Res call({
    List<AnalyticsDataPoint> dataPoints,
    Map<String, double> summary,
    List<AnalyticsInsight> insights,
    List<AnalyticsRecommendation> recommendations,
  });
}

/// @nodoc
class _$AnalyticsResponseCopyWithImpl<$Res, $Val extends AnalyticsResponse>
    implements $AnalyticsResponseCopyWith<$Res> {
  _$AnalyticsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataPoints = null,
    Object? summary = null,
    Object? insights = null,
    Object? recommendations = null,
  }) {
    return _then(
      _value.copyWith(
            dataPoints: null == dataPoints
                ? _value.dataPoints
                : dataPoints // ignore: cast_nullable_to_non_nullable
                      as List<AnalyticsDataPoint>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            insights: null == insights
                ? _value.insights
                : insights // ignore: cast_nullable_to_non_nullable
                      as List<AnalyticsInsight>,
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<AnalyticsRecommendation>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsResponseImplCopyWith<$Res>
    implements $AnalyticsResponseCopyWith<$Res> {
  factory _$$AnalyticsResponseImplCopyWith(
    _$AnalyticsResponseImpl value,
    $Res Function(_$AnalyticsResponseImpl) then,
  ) = __$$AnalyticsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AnalyticsDataPoint> dataPoints,
    Map<String, double> summary,
    List<AnalyticsInsight> insights,
    List<AnalyticsRecommendation> recommendations,
  });
}

/// @nodoc
class __$$AnalyticsResponseImplCopyWithImpl<$Res>
    extends _$AnalyticsResponseCopyWithImpl<$Res, _$AnalyticsResponseImpl>
    implements _$$AnalyticsResponseImplCopyWith<$Res> {
  __$$AnalyticsResponseImplCopyWithImpl(
    _$AnalyticsResponseImpl _value,
    $Res Function(_$AnalyticsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataPoints = null,
    Object? summary = null,
    Object? insights = null,
    Object? recommendations = null,
  }) {
    return _then(
      _$AnalyticsResponseImpl(
        dataPoints: null == dataPoints
            ? _value._dataPoints
            : dataPoints // ignore: cast_nullable_to_non_nullable
                  as List<AnalyticsDataPoint>,
        summary: null == summary
            ? _value._summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        insights: null == insights
            ? _value._insights
            : insights // ignore: cast_nullable_to_non_nullable
                  as List<AnalyticsInsight>,
        recommendations: null == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<AnalyticsRecommendation>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsResponseImpl implements _AnalyticsResponse {
  const _$AnalyticsResponseImpl({
    required final List<AnalyticsDataPoint> dataPoints,
    required final Map<String, double> summary,
    final List<AnalyticsInsight> insights = const [],
    final List<AnalyticsRecommendation> recommendations = const [],
  }) : _dataPoints = dataPoints,
       _summary = summary,
       _insights = insights,
       _recommendations = recommendations;

  factory _$AnalyticsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsResponseImplFromJson(json);

  final List<AnalyticsDataPoint> _dataPoints;
  @override
  List<AnalyticsDataPoint> get dataPoints {
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataPoints);
  }

  final Map<String, double> _summary;
  @override
  Map<String, double> get summary {
    if (_summary is EqualUnmodifiableMapView) return _summary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_summary);
  }

  final List<AnalyticsInsight> _insights;
  @override
  @JsonKey()
  List<AnalyticsInsight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  final List<AnalyticsRecommendation> _recommendations;
  @override
  @JsonKey()
  List<AnalyticsRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  String toString() {
    return 'AnalyticsResponse(dataPoints: $dataPoints, summary: $summary, insights: $insights, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsResponseImpl &&
            const DeepCollectionEquality().equals(
              other._dataPoints,
              _dataPoints,
            ) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality().equals(other._insights, _insights) &&
            const DeepCollectionEquality().equals(
              other._recommendations,
              _recommendations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dataPoints),
    const DeepCollectionEquality().hash(_summary),
    const DeepCollectionEquality().hash(_insights),
    const DeepCollectionEquality().hash(_recommendations),
  );

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsResponseImplCopyWith<_$AnalyticsResponseImpl> get copyWith =>
      __$$AnalyticsResponseImplCopyWithImpl<_$AnalyticsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsResponseImplToJson(this);
  }
}

abstract class _AnalyticsResponse implements AnalyticsResponse {
  const factory _AnalyticsResponse({
    required final List<AnalyticsDataPoint> dataPoints,
    required final Map<String, double> summary,
    final List<AnalyticsInsight> insights,
    final List<AnalyticsRecommendation> recommendations,
  }) = _$AnalyticsResponseImpl;

  factory _AnalyticsResponse.fromJson(Map<String, dynamic> json) =
      _$AnalyticsResponseImpl.fromJson;

  @override
  List<AnalyticsDataPoint> get dataPoints;
  @override
  Map<String, double> get summary;
  @override
  List<AnalyticsInsight> get insights;
  @override
  List<AnalyticsRecommendation> get recommendations;

  /// Create a copy of AnalyticsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsResponseImplCopyWith<_$AnalyticsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsDataPoint _$AnalyticsDataPointFromJson(Map<String, dynamic> json) {
  return _AnalyticsDataPoint.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsDataPoint {
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, double> get values => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsDataPointCopyWith<AnalyticsDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsDataPointCopyWith<$Res> {
  factory $AnalyticsDataPointCopyWith(
    AnalyticsDataPoint value,
    $Res Function(AnalyticsDataPoint) then,
  ) = _$AnalyticsDataPointCopyWithImpl<$Res, AnalyticsDataPoint>;
  @useResult
  $Res call({
    DateTime timestamp,
    Map<String, double> values,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$AnalyticsDataPointCopyWithImpl<$Res, $Val extends AnalyticsDataPoint>
    implements $AnalyticsDataPointCopyWith<$Res> {
  _$AnalyticsDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? values = null,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsDataPointImplCopyWith<$Res>
    implements $AnalyticsDataPointCopyWith<$Res> {
  factory _$$AnalyticsDataPointImplCopyWith(
    _$AnalyticsDataPointImpl value,
    $Res Function(_$AnalyticsDataPointImpl) then,
  ) = __$$AnalyticsDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime timestamp,
    Map<String, double> values,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$AnalyticsDataPointImplCopyWithImpl<$Res>
    extends _$AnalyticsDataPointCopyWithImpl<$Res, _$AnalyticsDataPointImpl>
    implements _$$AnalyticsDataPointImplCopyWith<$Res> {
  __$$AnalyticsDataPointImplCopyWithImpl(
    _$AnalyticsDataPointImpl _value,
    $Res Function(_$AnalyticsDataPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? values = null,
    Object? metadata = null,
  }) {
    return _then(
      _$AnalyticsDataPointImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsDataPointImpl implements _AnalyticsDataPoint {
  const _$AnalyticsDataPointImpl({
    required this.timestamp,
    required final Map<String, double> values,
    final Map<String, dynamic> metadata = const {},
  }) : _values = values,
       _metadata = metadata;

  factory _$AnalyticsDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsDataPointImplFromJson(json);

  @override
  final DateTime timestamp;
  final Map<String, double> _values;
  @override
  Map<String, double> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'AnalyticsDataPoint(timestamp: $timestamp, values: $values, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsDataPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    timestamp,
    const DeepCollectionEquality().hash(_values),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsDataPointImplCopyWith<_$AnalyticsDataPointImpl> get copyWith =>
      __$$AnalyticsDataPointImplCopyWithImpl<_$AnalyticsDataPointImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsDataPointImplToJson(this);
  }
}

abstract class _AnalyticsDataPoint implements AnalyticsDataPoint {
  const factory _AnalyticsDataPoint({
    required final DateTime timestamp,
    required final Map<String, double> values,
    final Map<String, dynamic> metadata,
  }) = _$AnalyticsDataPointImpl;

  factory _AnalyticsDataPoint.fromJson(Map<String, dynamic> json) =
      _$AnalyticsDataPointImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  Map<String, double> get values;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of AnalyticsDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsDataPointImplCopyWith<_$AnalyticsDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsInsight _$AnalyticsInsightFromJson(Map<String, dynamic> json) {
  return _AnalyticsInsight.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsInsight {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  InsightType get type => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsInsight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsInsightCopyWith<AnalyticsInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsInsightCopyWith<$Res> {
  factory $AnalyticsInsightCopyWith(
    AnalyticsInsight value,
    $Res Function(AnalyticsInsight) then,
  ) = _$AnalyticsInsightCopyWithImpl<$Res, AnalyticsInsight>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    InsightType type,
    double confidence,
    List<String> tags,
  });
}

/// @nodoc
class _$AnalyticsInsightCopyWithImpl<$Res, $Val extends AnalyticsInsight>
    implements $AnalyticsInsightCopyWith<$Res> {
  _$AnalyticsInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidence = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as InsightType,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsInsightImplCopyWith<$Res>
    implements $AnalyticsInsightCopyWith<$Res> {
  factory _$$AnalyticsInsightImplCopyWith(
    _$AnalyticsInsightImpl value,
    $Res Function(_$AnalyticsInsightImpl) then,
  ) = __$$AnalyticsInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    InsightType type,
    double confidence,
    List<String> tags,
  });
}

/// @nodoc
class __$$AnalyticsInsightImplCopyWithImpl<$Res>
    extends _$AnalyticsInsightCopyWithImpl<$Res, _$AnalyticsInsightImpl>
    implements _$$AnalyticsInsightImplCopyWith<$Res> {
  __$$AnalyticsInsightImplCopyWithImpl(
    _$AnalyticsInsightImpl _value,
    $Res Function(_$AnalyticsInsightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? confidence = null,
    Object? tags = null,
  }) {
    return _then(
      _$AnalyticsInsightImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as InsightType,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsInsightImpl implements _AnalyticsInsight {
  const _$AnalyticsInsightImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.confidence,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$AnalyticsInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsInsightImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final InsightType type;
  @override
  final double confidence;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'AnalyticsInsight(id: $id, title: $title, description: $description, type: $type, confidence: $confidence, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    confidence,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of AnalyticsInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsInsightImplCopyWith<_$AnalyticsInsightImpl> get copyWith =>
      __$$AnalyticsInsightImplCopyWithImpl<_$AnalyticsInsightImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsInsightImplToJson(this);
  }
}

abstract class _AnalyticsInsight implements AnalyticsInsight {
  const factory _AnalyticsInsight({
    required final String id,
    required final String title,
    required final String description,
    required final InsightType type,
    required final double confidence,
    final List<String> tags,
  }) = _$AnalyticsInsightImpl;

  factory _AnalyticsInsight.fromJson(Map<String, dynamic> json) =
      _$AnalyticsInsightImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  InsightType get type;
  @override
  double get confidence;
  @override
  List<String> get tags;

  /// Create a copy of AnalyticsInsight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsInsightImplCopyWith<_$AnalyticsInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsRecommendation _$AnalyticsRecommendationFromJson(
  Map<String, dynamic> json,
) {
  return _AnalyticsRecommendation.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecommendationType get type => throw _privateConstructorUsedError;
  double get potentialSavings => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsRecommendationCopyWith<AnalyticsRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsRecommendationCopyWith<$Res> {
  factory $AnalyticsRecommendationCopyWith(
    AnalyticsRecommendation value,
    $Res Function(AnalyticsRecommendation) then,
  ) = _$AnalyticsRecommendationCopyWithImpl<$Res, AnalyticsRecommendation>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    RecommendationType type,
    double potentialSavings,
    String difficulty,
    List<String> tags,
  });
}

/// @nodoc
class _$AnalyticsRecommendationCopyWithImpl<
  $Res,
  $Val extends AnalyticsRecommendation
>
    implements $AnalyticsRecommendationCopyWith<$Res> {
  _$AnalyticsRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? potentialSavings = null,
    Object? difficulty = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RecommendationType,
            potentialSavings: null == potentialSavings
                ? _value.potentialSavings
                : potentialSavings // ignore: cast_nullable_to_non_nullable
                      as double,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalyticsRecommendationImplCopyWith<$Res>
    implements $AnalyticsRecommendationCopyWith<$Res> {
  factory _$$AnalyticsRecommendationImplCopyWith(
    _$AnalyticsRecommendationImpl value,
    $Res Function(_$AnalyticsRecommendationImpl) then,
  ) = __$$AnalyticsRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    RecommendationType type,
    double potentialSavings,
    String difficulty,
    List<String> tags,
  });
}

/// @nodoc
class __$$AnalyticsRecommendationImplCopyWithImpl<$Res>
    extends
        _$AnalyticsRecommendationCopyWithImpl<
          $Res,
          _$AnalyticsRecommendationImpl
        >
    implements _$$AnalyticsRecommendationImplCopyWith<$Res> {
  __$$AnalyticsRecommendationImplCopyWithImpl(
    _$AnalyticsRecommendationImpl _value,
    $Res Function(_$AnalyticsRecommendationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? potentialSavings = null,
    Object? difficulty = null,
    Object? tags = null,
  }) {
    return _then(
      _$AnalyticsRecommendationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RecommendationType,
        potentialSavings: null == potentialSavings
            ? _value.potentialSavings
            : potentialSavings // ignore: cast_nullable_to_non_nullable
                  as double,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsRecommendationImpl implements _AnalyticsRecommendation {
  const _$AnalyticsRecommendationImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.potentialSavings,
    required this.difficulty,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$AnalyticsRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecommendationType type;
  @override
  final double potentialSavings;
  @override
  final String difficulty;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'AnalyticsRecommendation(id: $id, title: $title, description: $description, type: $type, potentialSavings: $potentialSavings, difficulty: $difficulty, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.potentialSavings, potentialSavings) ||
                other.potentialSavings == potentialSavings) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    potentialSavings,
    difficulty,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of AnalyticsRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsRecommendationImplCopyWith<_$AnalyticsRecommendationImpl>
  get copyWith =>
      __$$AnalyticsRecommendationImplCopyWithImpl<
        _$AnalyticsRecommendationImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsRecommendationImplToJson(this);
  }
}

abstract class _AnalyticsRecommendation implements AnalyticsRecommendation {
  const factory _AnalyticsRecommendation({
    required final String id,
    required final String title,
    required final String description,
    required final RecommendationType type,
    required final double potentialSavings,
    required final String difficulty,
    final List<String> tags,
  }) = _$AnalyticsRecommendationImpl;

  factory _AnalyticsRecommendation.fromJson(Map<String, dynamic> json) =
      _$AnalyticsRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecommendationType get type;
  @override
  double get potentialSavings;
  @override
  String get difficulty;
  @override
  List<String> get tags;

  /// Create a copy of AnalyticsRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsRecommendationImplCopyWith<_$AnalyticsRecommendationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return _ErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ErrorResponse {
  String get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ErrorResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
    ErrorResponse value,
    $Res Function(ErrorResponse) then,
  ) = _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({
    String error,
    String message,
    String? errorCode,
    String? details,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? errorCode = freezed,
    Object? details = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            error: null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ErrorResponseImplCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$ErrorResponseImplCopyWith(
    _$ErrorResponseImpl value,
    $Res Function(_$ErrorResponseImpl) then,
  ) = __$$ErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String error,
    String message,
    String? errorCode,
    String? details,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$ErrorResponseImplCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$ErrorResponseImpl>
    implements _$$ErrorResponseImplCopyWith<$Res> {
  __$$ErrorResponseImplCopyWithImpl(
    _$ErrorResponseImpl _value,
    $Res Function(_$ErrorResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? errorCode = freezed,
    Object? details = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$ErrorResponseImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
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
class _$ErrorResponseImpl implements _ErrorResponse {
  const _$ErrorResponseImpl({
    required this.error,
    required this.message,
    this.errorCode = null,
    this.details = null,
    final Map<String, dynamic>? metadata = null,
  }) : _metadata = metadata;

  factory _$ErrorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorResponseImplFromJson(json);

  @override
  final String error;
  @override
  final String message;
  @override
  @JsonKey()
  final String? errorCode;
  @override
  @JsonKey()
  final String? details;
  final Map<String, dynamic>? _metadata;
  @override
  @JsonKey()
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ErrorResponse(error: $error, message: $message, errorCode: $errorCode, details: $details, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.details, details) || other.details == details) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    message,
    errorCode,
    details,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      __$$ErrorResponseImplCopyWithImpl<_$ErrorResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorResponseImplToJson(this);
  }
}

abstract class _ErrorResponse implements ErrorResponse {
  const factory _ErrorResponse({
    required final String error,
    required final String message,
    final String? errorCode,
    final String? details,
    final Map<String, dynamic>? metadata,
  }) = _$ErrorResponseImpl;

  factory _ErrorResponse.fromJson(Map<String, dynamic> json) =
      _$ErrorResponseImpl.fromJson;

  @override
  String get error;
  @override
  String get message;
  @override
  String? get errorCode;
  @override
  String? get details;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ErrorResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SuccessResponse _$SuccessResponseFromJson(Map<String, dynamic> json) {
  return _SuccessResponse.fromJson(json);
}

/// @nodoc
mixin _$SuccessResponse {
  String get message => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this SuccessResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuccessResponseCopyWith<SuccessResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuccessResponseCopyWith<$Res> {
  factory $SuccessResponseCopyWith(
    SuccessResponse value,
    $Res Function(SuccessResponse) then,
  ) = _$SuccessResponseCopyWithImpl<$Res, SuccessResponse>;
  @useResult
  $Res call({
    String message,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$SuccessResponseCopyWithImpl<$Res, $Val extends SuccessResponse>
    implements $SuccessResponseCopyWith<$Res> {
  _$SuccessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
abstract class _$$SuccessResponseImplCopyWith<$Res>
    implements $SuccessResponseCopyWith<$Res> {
  factory _$$SuccessResponseImplCopyWith(
    _$SuccessResponseImpl value,
    $Res Function(_$SuccessResponseImpl) then,
  ) = __$$SuccessResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$SuccessResponseImplCopyWithImpl<$Res>
    extends _$SuccessResponseCopyWithImpl<$Res, _$SuccessResponseImpl>
    implements _$$SuccessResponseImplCopyWith<$Res> {
  __$$SuccessResponseImplCopyWithImpl(
    _$SuccessResponseImpl _value,
    $Res Function(_$SuccessResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$SuccessResponseImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
class _$SuccessResponseImpl implements _SuccessResponse {
  const _$SuccessResponseImpl({
    required this.message,
    final Map<String, dynamic>? data = null,
    final Map<String, dynamic>? metadata = null,
  }) : _data = data,
       _metadata = metadata;

  factory _$SuccessResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuccessResponseImplFromJson(json);

  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  @JsonKey()
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  @JsonKey()
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SuccessResponse(message: $message, data: $data, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_data),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith =>
      __$$SuccessResponseImplCopyWithImpl<_$SuccessResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SuccessResponseImplToJson(this);
  }
}

abstract class _SuccessResponse implements SuccessResponse {
  const factory _SuccessResponse({
    required final String message,
    final Map<String, dynamic>? data,
    final Map<String, dynamic>? metadata,
  }) = _$SuccessResponseImpl;

  factory _SuccessResponse.fromJson(Map<String, dynamic> json) =
      _$SuccessResponseImpl.fromJson;

  @override
  String get message;
  @override
  Map<String, dynamic>? get data;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of SuccessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResponseImplCopyWith<_$SuccessResponseImpl> get copyWith =>
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
class _$AddressImpl implements _Address {
  const _$AddressImpl({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

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
  String toString() {
    return 'Address(street: $street, city: $city, state: $state, zipCode: $zipCode, country: $country)';
  }

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

abstract class _Address implements Address {
  const factory _Address({
    required final String street,
    required final String city,
    required final String state,
    required final String zipCode,
    required final String country,
  }) = _$AddressImpl;

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
