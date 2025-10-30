// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumption.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConsumptionResponse _$ConsumptionResponseFromJson(Map<String, dynamic> json) {
  return _ConsumptionResponse.fromJson(json);
}

/// @nodoc
mixin _$ConsumptionResponse {
  List<DailyConsumption> get dailyConsumption =>
      throw _privateConstructorUsedError;
  List<MonthlyConsumption> get monthlyConsumption =>
      throw _privateConstructorUsedError;
  List<YearlyConsumption> get yearlyConsumption =>
      throw _privateConstructorUsedError;
  UsageStatistics get usageStatistics => throw _privateConstructorUsedError;

  /// Serializes this ConsumptionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsumptionResponseCopyWith<ConsumptionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumptionResponseCopyWith<$Res> {
  factory $ConsumptionResponseCopyWith(
    ConsumptionResponse value,
    $Res Function(ConsumptionResponse) then,
  ) = _$ConsumptionResponseCopyWithImpl<$Res, ConsumptionResponse>;
  @useResult
  $Res call({
    List<DailyConsumption> dailyConsumption,
    List<MonthlyConsumption> monthlyConsumption,
    List<YearlyConsumption> yearlyConsumption,
    UsageStatistics usageStatistics,
  });

  $UsageStatisticsCopyWith<$Res> get usageStatistics;
}

/// @nodoc
class _$ConsumptionResponseCopyWithImpl<$Res, $Val extends ConsumptionResponse>
    implements $ConsumptionResponseCopyWith<$Res> {
  _$ConsumptionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyConsumption = null,
    Object? monthlyConsumption = null,
    Object? yearlyConsumption = null,
    Object? usageStatistics = null,
  }) {
    return _then(
      _value.copyWith(
            dailyConsumption: null == dailyConsumption
                ? _value.dailyConsumption
                : dailyConsumption // ignore: cast_nullable_to_non_nullable
                      as List<DailyConsumption>,
            monthlyConsumption: null == monthlyConsumption
                ? _value.monthlyConsumption
                : monthlyConsumption // ignore: cast_nullable_to_non_nullable
                      as List<MonthlyConsumption>,
            yearlyConsumption: null == yearlyConsumption
                ? _value.yearlyConsumption
                : yearlyConsumption // ignore: cast_nullable_to_non_nullable
                      as List<YearlyConsumption>,
            usageStatistics: null == usageStatistics
                ? _value.usageStatistics
                : usageStatistics // ignore: cast_nullable_to_non_nullable
                      as UsageStatistics,
          )
          as $Val,
    );
  }

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsageStatisticsCopyWith<$Res> get usageStatistics {
    return $UsageStatisticsCopyWith<$Res>(_value.usageStatistics, (value) {
      return _then(_value.copyWith(usageStatistics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConsumptionResponseImplCopyWith<$Res>
    implements $ConsumptionResponseCopyWith<$Res> {
  factory _$$ConsumptionResponseImplCopyWith(
    _$ConsumptionResponseImpl value,
    $Res Function(_$ConsumptionResponseImpl) then,
  ) = __$$ConsumptionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<DailyConsumption> dailyConsumption,
    List<MonthlyConsumption> monthlyConsumption,
    List<YearlyConsumption> yearlyConsumption,
    UsageStatistics usageStatistics,
  });

  @override
  $UsageStatisticsCopyWith<$Res> get usageStatistics;
}

/// @nodoc
class __$$ConsumptionResponseImplCopyWithImpl<$Res>
    extends _$ConsumptionResponseCopyWithImpl<$Res, _$ConsumptionResponseImpl>
    implements _$$ConsumptionResponseImplCopyWith<$Res> {
  __$$ConsumptionResponseImplCopyWithImpl(
    _$ConsumptionResponseImpl _value,
    $Res Function(_$ConsumptionResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyConsumption = null,
    Object? monthlyConsumption = null,
    Object? yearlyConsumption = null,
    Object? usageStatistics = null,
  }) {
    return _then(
      _$ConsumptionResponseImpl(
        dailyConsumption: null == dailyConsumption
            ? _value._dailyConsumption
            : dailyConsumption // ignore: cast_nullable_to_non_nullable
                  as List<DailyConsumption>,
        monthlyConsumption: null == monthlyConsumption
            ? _value._monthlyConsumption
            : monthlyConsumption // ignore: cast_nullable_to_non_nullable
                  as List<MonthlyConsumption>,
        yearlyConsumption: null == yearlyConsumption
            ? _value._yearlyConsumption
            : yearlyConsumption // ignore: cast_nullable_to_non_nullable
                  as List<YearlyConsumption>,
        usageStatistics: null == usageStatistics
            ? _value.usageStatistics
            : usageStatistics // ignore: cast_nullable_to_non_nullable
                  as UsageStatistics,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumptionResponseImpl implements _ConsumptionResponse {
  const _$ConsumptionResponseImpl({
    required final List<DailyConsumption> dailyConsumption,
    required final List<MonthlyConsumption> monthlyConsumption,
    required final List<YearlyConsumption> yearlyConsumption,
    required this.usageStatistics,
  }) : _dailyConsumption = dailyConsumption,
       _monthlyConsumption = monthlyConsumption,
       _yearlyConsumption = yearlyConsumption;

  factory _$ConsumptionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumptionResponseImplFromJson(json);

  final List<DailyConsumption> _dailyConsumption;
  @override
  List<DailyConsumption> get dailyConsumption {
    if (_dailyConsumption is EqualUnmodifiableListView)
      return _dailyConsumption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyConsumption);
  }

  final List<MonthlyConsumption> _monthlyConsumption;
  @override
  List<MonthlyConsumption> get monthlyConsumption {
    if (_monthlyConsumption is EqualUnmodifiableListView)
      return _monthlyConsumption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyConsumption);
  }

  final List<YearlyConsumption> _yearlyConsumption;
  @override
  List<YearlyConsumption> get yearlyConsumption {
    if (_yearlyConsumption is EqualUnmodifiableListView)
      return _yearlyConsumption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearlyConsumption);
  }

  @override
  final UsageStatistics usageStatistics;

  @override
  String toString() {
    return 'ConsumptionResponse(dailyConsumption: $dailyConsumption, monthlyConsumption: $monthlyConsumption, yearlyConsumption: $yearlyConsumption, usageStatistics: $usageStatistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumptionResponseImpl &&
            const DeepCollectionEquality().equals(
              other._dailyConsumption,
              _dailyConsumption,
            ) &&
            const DeepCollectionEquality().equals(
              other._monthlyConsumption,
              _monthlyConsumption,
            ) &&
            const DeepCollectionEquality().equals(
              other._yearlyConsumption,
              _yearlyConsumption,
            ) &&
            (identical(other.usageStatistics, usageStatistics) ||
                other.usageStatistics == usageStatistics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyConsumption),
    const DeepCollectionEquality().hash(_monthlyConsumption),
    const DeepCollectionEquality().hash(_yearlyConsumption),
    usageStatistics,
  );

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumptionResponseImplCopyWith<_$ConsumptionResponseImpl> get copyWith =>
      __$$ConsumptionResponseImplCopyWithImpl<_$ConsumptionResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumptionResponseImplToJson(this);
  }
}

abstract class _ConsumptionResponse implements ConsumptionResponse {
  const factory _ConsumptionResponse({
    required final List<DailyConsumption> dailyConsumption,
    required final List<MonthlyConsumption> monthlyConsumption,
    required final List<YearlyConsumption> yearlyConsumption,
    required final UsageStatistics usageStatistics,
  }) = _$ConsumptionResponseImpl;

  factory _ConsumptionResponse.fromJson(Map<String, dynamic> json) =
      _$ConsumptionResponseImpl.fromJson;

  @override
  List<DailyConsumption> get dailyConsumption;
  @override
  List<MonthlyConsumption> get monthlyConsumption;
  @override
  List<YearlyConsumption> get yearlyConsumption;
  @override
  UsageStatistics get usageStatistics;

  /// Create a copy of ConsumptionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsumptionResponseImplCopyWith<_$ConsumptionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyConsumption _$DailyConsumptionFromJson(Map<String, dynamic> json) {
  return _DailyConsumption.fromJson(json);
}

/// @nodoc
mixin _$DailyConsumption {
  DateTime get date => throw _privateConstructorUsedError;
  double get totalKwh => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  List<HourlyConsumption> get hourlyBreakdown =>
      throw _privateConstructorUsedError;
  List<PeakUsage> get peakUsages => throw _privateConstructorUsedError;
  List<LowUsage> get lowUsages => throw _privateConstructorUsedError;
  double get averageHourlyUsage => throw _privateConstructorUsedError;
  double get peakHourlyUsage => throw _privateConstructorUsedError;
  double get lowestHourlyUsage => throw _privateConstructorUsedError;
  double get standardDeviation => throw _privateConstructorUsedError;
  List<UsageAlert> get alerts => throw _privateConstructorUsedError;
  ConsumptionPattern get pattern => throw _privateConstructorUsedError;

  /// Serializes this DailyConsumption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyConsumptionCopyWith<DailyConsumption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyConsumptionCopyWith<$Res> {
  factory $DailyConsumptionCopyWith(
    DailyConsumption value,
    $Res Function(DailyConsumption) then,
  ) = _$DailyConsumptionCopyWithImpl<$Res, DailyConsumption>;
  @useResult
  $Res call({
    DateTime date,
    double totalKwh,
    double cost,
    List<HourlyConsumption> hourlyBreakdown,
    List<PeakUsage> peakUsages,
    List<LowUsage> lowUsages,
    double averageHourlyUsage,
    double peakHourlyUsage,
    double lowestHourlyUsage,
    double standardDeviation,
    List<UsageAlert> alerts,
    ConsumptionPattern pattern,
  });

  $ConsumptionPatternCopyWith<$Res> get pattern;
}

/// @nodoc
class _$DailyConsumptionCopyWithImpl<$Res, $Val extends DailyConsumption>
    implements $DailyConsumptionCopyWith<$Res> {
  _$DailyConsumptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalKwh = null,
    Object? cost = null,
    Object? hourlyBreakdown = null,
    Object? peakUsages = null,
    Object? lowUsages = null,
    Object? averageHourlyUsage = null,
    Object? peakHourlyUsage = null,
    Object? lowestHourlyUsage = null,
    Object? standardDeviation = null,
    Object? alerts = null,
    Object? pattern = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalKwh: null == totalKwh
                ? _value.totalKwh
                : totalKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            hourlyBreakdown: null == hourlyBreakdown
                ? _value.hourlyBreakdown
                : hourlyBreakdown // ignore: cast_nullable_to_non_nullable
                      as List<HourlyConsumption>,
            peakUsages: null == peakUsages
                ? _value.peakUsages
                : peakUsages // ignore: cast_nullable_to_non_nullable
                      as List<PeakUsage>,
            lowUsages: null == lowUsages
                ? _value.lowUsages
                : lowUsages // ignore: cast_nullable_to_non_nullable
                      as List<LowUsage>,
            averageHourlyUsage: null == averageHourlyUsage
                ? _value.averageHourlyUsage
                : averageHourlyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            peakHourlyUsage: null == peakHourlyUsage
                ? _value.peakHourlyUsage
                : peakHourlyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            lowestHourlyUsage: null == lowestHourlyUsage
                ? _value.lowestHourlyUsage
                : lowestHourlyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            standardDeviation: null == standardDeviation
                ? _value.standardDeviation
                : standardDeviation // ignore: cast_nullable_to_non_nullable
                      as double,
            alerts: null == alerts
                ? _value.alerts
                : alerts // ignore: cast_nullable_to_non_nullable
                      as List<UsageAlert>,
            pattern: null == pattern
                ? _value.pattern
                : pattern // ignore: cast_nullable_to_non_nullable
                      as ConsumptionPattern,
          )
          as $Val,
    );
  }

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConsumptionPatternCopyWith<$Res> get pattern {
    return $ConsumptionPatternCopyWith<$Res>(_value.pattern, (value) {
      return _then(_value.copyWith(pattern: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyConsumptionImplCopyWith<$Res>
    implements $DailyConsumptionCopyWith<$Res> {
  factory _$$DailyConsumptionImplCopyWith(
    _$DailyConsumptionImpl value,
    $Res Function(_$DailyConsumptionImpl) then,
  ) = __$$DailyConsumptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    double totalKwh,
    double cost,
    List<HourlyConsumption> hourlyBreakdown,
    List<PeakUsage> peakUsages,
    List<LowUsage> lowUsages,
    double averageHourlyUsage,
    double peakHourlyUsage,
    double lowestHourlyUsage,
    double standardDeviation,
    List<UsageAlert> alerts,
    ConsumptionPattern pattern,
  });

  @override
  $ConsumptionPatternCopyWith<$Res> get pattern;
}

/// @nodoc
class __$$DailyConsumptionImplCopyWithImpl<$Res>
    extends _$DailyConsumptionCopyWithImpl<$Res, _$DailyConsumptionImpl>
    implements _$$DailyConsumptionImplCopyWith<$Res> {
  __$$DailyConsumptionImplCopyWithImpl(
    _$DailyConsumptionImpl _value,
    $Res Function(_$DailyConsumptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalKwh = null,
    Object? cost = null,
    Object? hourlyBreakdown = null,
    Object? peakUsages = null,
    Object? lowUsages = null,
    Object? averageHourlyUsage = null,
    Object? peakHourlyUsage = null,
    Object? lowestHourlyUsage = null,
    Object? standardDeviation = null,
    Object? alerts = null,
    Object? pattern = null,
  }) {
    return _then(
      _$DailyConsumptionImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalKwh: null == totalKwh
            ? _value.totalKwh
            : totalKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        hourlyBreakdown: null == hourlyBreakdown
            ? _value._hourlyBreakdown
            : hourlyBreakdown // ignore: cast_nullable_to_non_nullable
                  as List<HourlyConsumption>,
        peakUsages: null == peakUsages
            ? _value._peakUsages
            : peakUsages // ignore: cast_nullable_to_non_nullable
                  as List<PeakUsage>,
        lowUsages: null == lowUsages
            ? _value._lowUsages
            : lowUsages // ignore: cast_nullable_to_non_nullable
                  as List<LowUsage>,
        averageHourlyUsage: null == averageHourlyUsage
            ? _value.averageHourlyUsage
            : averageHourlyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        peakHourlyUsage: null == peakHourlyUsage
            ? _value.peakHourlyUsage
            : peakHourlyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        lowestHourlyUsage: null == lowestHourlyUsage
            ? _value.lowestHourlyUsage
            : lowestHourlyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        standardDeviation: null == standardDeviation
            ? _value.standardDeviation
            : standardDeviation // ignore: cast_nullable_to_non_nullable
                  as double,
        alerts: null == alerts
            ? _value._alerts
            : alerts // ignore: cast_nullable_to_non_nullable
                  as List<UsageAlert>,
        pattern: null == pattern
            ? _value.pattern
            : pattern // ignore: cast_nullable_to_non_nullable
                  as ConsumptionPattern,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyConsumptionImpl extends _DailyConsumption {
  const _$DailyConsumptionImpl({
    required this.date,
    required this.totalKwh,
    required this.cost,
    required final List<HourlyConsumption> hourlyBreakdown,
    final List<PeakUsage> peakUsages = const [],
    final List<LowUsage> lowUsages = const [],
    this.averageHourlyUsage = 0.0,
    this.peakHourlyUsage = 0.0,
    this.lowestHourlyUsage = 0.0,
    this.standardDeviation = 0.0,
    final List<UsageAlert> alerts = const [],
    this.pattern = const ConsumptionPattern(),
  }) : _hourlyBreakdown = hourlyBreakdown,
       _peakUsages = peakUsages,
       _lowUsages = lowUsages,
       _alerts = alerts,
       super._();

  factory _$DailyConsumptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyConsumptionImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double totalKwh;
  @override
  final double cost;
  final List<HourlyConsumption> _hourlyBreakdown;
  @override
  List<HourlyConsumption> get hourlyBreakdown {
    if (_hourlyBreakdown is EqualUnmodifiableListView) return _hourlyBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hourlyBreakdown);
  }

  final List<PeakUsage> _peakUsages;
  @override
  @JsonKey()
  List<PeakUsage> get peakUsages {
    if (_peakUsages is EqualUnmodifiableListView) return _peakUsages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakUsages);
  }

  final List<LowUsage> _lowUsages;
  @override
  @JsonKey()
  List<LowUsage> get lowUsages {
    if (_lowUsages is EqualUnmodifiableListView) return _lowUsages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lowUsages);
  }

  @override
  @JsonKey()
  final double averageHourlyUsage;
  @override
  @JsonKey()
  final double peakHourlyUsage;
  @override
  @JsonKey()
  final double lowestHourlyUsage;
  @override
  @JsonKey()
  final double standardDeviation;
  final List<UsageAlert> _alerts;
  @override
  @JsonKey()
  List<UsageAlert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  @JsonKey()
  final ConsumptionPattern pattern;

  @override
  String toString() {
    return 'DailyConsumption(date: $date, totalKwh: $totalKwh, cost: $cost, hourlyBreakdown: $hourlyBreakdown, peakUsages: $peakUsages, lowUsages: $lowUsages, averageHourlyUsage: $averageHourlyUsage, peakHourlyUsage: $peakHourlyUsage, lowestHourlyUsage: $lowestHourlyUsage, standardDeviation: $standardDeviation, alerts: $alerts, pattern: $pattern)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyConsumptionImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalKwh, totalKwh) ||
                other.totalKwh == totalKwh) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            const DeepCollectionEquality().equals(
              other._hourlyBreakdown,
              _hourlyBreakdown,
            ) &&
            const DeepCollectionEquality().equals(
              other._peakUsages,
              _peakUsages,
            ) &&
            const DeepCollectionEquality().equals(
              other._lowUsages,
              _lowUsages,
            ) &&
            (identical(other.averageHourlyUsage, averageHourlyUsage) ||
                other.averageHourlyUsage == averageHourlyUsage) &&
            (identical(other.peakHourlyUsage, peakHourlyUsage) ||
                other.peakHourlyUsage == peakHourlyUsage) &&
            (identical(other.lowestHourlyUsage, lowestHourlyUsage) ||
                other.lowestHourlyUsage == lowestHourlyUsage) &&
            (identical(other.standardDeviation, standardDeviation) ||
                other.standardDeviation == standardDeviation) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            (identical(other.pattern, pattern) || other.pattern == pattern));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    totalKwh,
    cost,
    const DeepCollectionEquality().hash(_hourlyBreakdown),
    const DeepCollectionEquality().hash(_peakUsages),
    const DeepCollectionEquality().hash(_lowUsages),
    averageHourlyUsage,
    peakHourlyUsage,
    lowestHourlyUsage,
    standardDeviation,
    const DeepCollectionEquality().hash(_alerts),
    pattern,
  );

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyConsumptionImplCopyWith<_$DailyConsumptionImpl> get copyWith =>
      __$$DailyConsumptionImplCopyWithImpl<_$DailyConsumptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyConsumptionImplToJson(this);
  }
}

abstract class _DailyConsumption extends DailyConsumption {
  const factory _DailyConsumption({
    required final DateTime date,
    required final double totalKwh,
    required final double cost,
    required final List<HourlyConsumption> hourlyBreakdown,
    final List<PeakUsage> peakUsages,
    final List<LowUsage> lowUsages,
    final double averageHourlyUsage,
    final double peakHourlyUsage,
    final double lowestHourlyUsage,
    final double standardDeviation,
    final List<UsageAlert> alerts,
    final ConsumptionPattern pattern,
  }) = _$DailyConsumptionImpl;
  const _DailyConsumption._() : super._();

  factory _DailyConsumption.fromJson(Map<String, dynamic> json) =
      _$DailyConsumptionImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get totalKwh;
  @override
  double get cost;
  @override
  List<HourlyConsumption> get hourlyBreakdown;
  @override
  List<PeakUsage> get peakUsages;
  @override
  List<LowUsage> get lowUsages;
  @override
  double get averageHourlyUsage;
  @override
  double get peakHourlyUsage;
  @override
  double get lowestHourlyUsage;
  @override
  double get standardDeviation;
  @override
  List<UsageAlert> get alerts;
  @override
  ConsumptionPattern get pattern;

  /// Create a copy of DailyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyConsumptionImplCopyWith<_$DailyConsumptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HourlyConsumption _$HourlyConsumptionFromJson(Map<String, dynamic> json) {
  return _HourlyConsumption.fromJson(json);
}

/// @nodoc
mixin _$HourlyConsumption {
  int get hour => throw _privateConstructorUsedError;
  double get kwh => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;

  /// Serializes this HourlyConsumption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HourlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HourlyConsumptionCopyWith<HourlyConsumption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyConsumptionCopyWith<$Res> {
  factory $HourlyConsumptionCopyWith(
    HourlyConsumption value,
    $Res Function(HourlyConsumption) then,
  ) = _$HourlyConsumptionCopyWithImpl<$Res, HourlyConsumption>;
  @useResult
  $Res call({int hour, double kwh, double cost});
}

/// @nodoc
class _$HourlyConsumptionCopyWithImpl<$Res, $Val extends HourlyConsumption>
    implements $HourlyConsumptionCopyWith<$Res> {
  _$HourlyConsumptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HourlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hour = null, Object? kwh = null, Object? cost = null}) {
    return _then(
      _value.copyWith(
            hour: null == hour
                ? _value.hour
                : hour // ignore: cast_nullable_to_non_nullable
                      as int,
            kwh: null == kwh
                ? _value.kwh
                : kwh // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HourlyConsumptionImplCopyWith<$Res>
    implements $HourlyConsumptionCopyWith<$Res> {
  factory _$$HourlyConsumptionImplCopyWith(
    _$HourlyConsumptionImpl value,
    $Res Function(_$HourlyConsumptionImpl) then,
  ) = __$$HourlyConsumptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, double kwh, double cost});
}

/// @nodoc
class __$$HourlyConsumptionImplCopyWithImpl<$Res>
    extends _$HourlyConsumptionCopyWithImpl<$Res, _$HourlyConsumptionImpl>
    implements _$$HourlyConsumptionImplCopyWith<$Res> {
  __$$HourlyConsumptionImplCopyWithImpl(
    _$HourlyConsumptionImpl _value,
    $Res Function(_$HourlyConsumptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HourlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hour = null, Object? kwh = null, Object? cost = null}) {
    return _then(
      _$HourlyConsumptionImpl(
        hour: null == hour
            ? _value.hour
            : hour // ignore: cast_nullable_to_non_nullable
                  as int,
        kwh: null == kwh
            ? _value.kwh
            : kwh // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HourlyConsumptionImpl implements _HourlyConsumption {
  const _$HourlyConsumptionImpl({
    required this.hour,
    required this.kwh,
    required this.cost,
  });

  factory _$HourlyConsumptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HourlyConsumptionImplFromJson(json);

  @override
  final int hour;
  @override
  final double kwh;
  @override
  final double cost;

  @override
  String toString() {
    return 'HourlyConsumption(hour: $hour, kwh: $kwh, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HourlyConsumptionImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.kwh, kwh) || other.kwh == kwh) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hour, kwh, cost);

  /// Create a copy of HourlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HourlyConsumptionImplCopyWith<_$HourlyConsumptionImpl> get copyWith =>
      __$$HourlyConsumptionImplCopyWithImpl<_$HourlyConsumptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HourlyConsumptionImplToJson(this);
  }
}

abstract class _HourlyConsumption implements HourlyConsumption {
  const factory _HourlyConsumption({
    required final int hour,
    required final double kwh,
    required final double cost,
  }) = _$HourlyConsumptionImpl;

  factory _HourlyConsumption.fromJson(Map<String, dynamic> json) =
      _$HourlyConsumptionImpl.fromJson;

  @override
  int get hour;
  @override
  double get kwh;
  @override
  double get cost;

  /// Create a copy of HourlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HourlyConsumptionImplCopyWith<_$HourlyConsumptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyConsumption _$MonthlyConsumptionFromJson(Map<String, dynamic> json) {
  return _MonthlyConsumption.fromJson(json);
}

/// @nodoc
mixin _$MonthlyConsumption {
  String get month => throw _privateConstructorUsedError;
  double get totalKwh => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  double get averageDaily => throw _privateConstructorUsedError;
  String get peakDay => throw _privateConstructorUsedError;
  double get peakKwh => throw _privateConstructorUsedError;
  String get lowestDay => throw _privateConstructorUsedError;
  double get lowestKwh => throw _privateConstructorUsedError;

  /// Serializes this MonthlyConsumption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyConsumptionCopyWith<MonthlyConsumption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyConsumptionCopyWith<$Res> {
  factory $MonthlyConsumptionCopyWith(
    MonthlyConsumption value,
    $Res Function(MonthlyConsumption) then,
  ) = _$MonthlyConsumptionCopyWithImpl<$Res, MonthlyConsumption>;
  @useResult
  $Res call({
    String month,
    double totalKwh,
    double totalCost,
    double averageDaily,
    String peakDay,
    double peakKwh,
    String lowestDay,
    double lowestKwh,
  });
}

/// @nodoc
class _$MonthlyConsumptionCopyWithImpl<$Res, $Val extends MonthlyConsumption>
    implements $MonthlyConsumptionCopyWith<$Res> {
  _$MonthlyConsumptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalKwh = null,
    Object? totalCost = null,
    Object? averageDaily = null,
    Object? peakDay = null,
    Object? peakKwh = null,
    Object? lowestDay = null,
    Object? lowestKwh = null,
  }) {
    return _then(
      _value.copyWith(
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as String,
            totalKwh: null == totalKwh
                ? _value.totalKwh
                : totalKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCost: null == totalCost
                ? _value.totalCost
                : totalCost // ignore: cast_nullable_to_non_nullable
                      as double,
            averageDaily: null == averageDaily
                ? _value.averageDaily
                : averageDaily // ignore: cast_nullable_to_non_nullable
                      as double,
            peakDay: null == peakDay
                ? _value.peakDay
                : peakDay // ignore: cast_nullable_to_non_nullable
                      as String,
            peakKwh: null == peakKwh
                ? _value.peakKwh
                : peakKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            lowestDay: null == lowestDay
                ? _value.lowestDay
                : lowestDay // ignore: cast_nullable_to_non_nullable
                      as String,
            lowestKwh: null == lowestKwh
                ? _value.lowestKwh
                : lowestKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MonthlyConsumptionImplCopyWith<$Res>
    implements $MonthlyConsumptionCopyWith<$Res> {
  factory _$$MonthlyConsumptionImplCopyWith(
    _$MonthlyConsumptionImpl value,
    $Res Function(_$MonthlyConsumptionImpl) then,
  ) = __$$MonthlyConsumptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String month,
    double totalKwh,
    double totalCost,
    double averageDaily,
    String peakDay,
    double peakKwh,
    String lowestDay,
    double lowestKwh,
  });
}

/// @nodoc
class __$$MonthlyConsumptionImplCopyWithImpl<$Res>
    extends _$MonthlyConsumptionCopyWithImpl<$Res, _$MonthlyConsumptionImpl>
    implements _$$MonthlyConsumptionImplCopyWith<$Res> {
  __$$MonthlyConsumptionImplCopyWithImpl(
    _$MonthlyConsumptionImpl _value,
    $Res Function(_$MonthlyConsumptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MonthlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalKwh = null,
    Object? totalCost = null,
    Object? averageDaily = null,
    Object? peakDay = null,
    Object? peakKwh = null,
    Object? lowestDay = null,
    Object? lowestKwh = null,
  }) {
    return _then(
      _$MonthlyConsumptionImpl(
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as String,
        totalKwh: null == totalKwh
            ? _value.totalKwh
            : totalKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCost: null == totalCost
            ? _value.totalCost
            : totalCost // ignore: cast_nullable_to_non_nullable
                  as double,
        averageDaily: null == averageDaily
            ? _value.averageDaily
            : averageDaily // ignore: cast_nullable_to_non_nullable
                  as double,
        peakDay: null == peakDay
            ? _value.peakDay
            : peakDay // ignore: cast_nullable_to_non_nullable
                  as String,
        peakKwh: null == peakKwh
            ? _value.peakKwh
            : peakKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        lowestDay: null == lowestDay
            ? _value.lowestDay
            : lowestDay // ignore: cast_nullable_to_non_nullable
                  as String,
        lowestKwh: null == lowestKwh
            ? _value.lowestKwh
            : lowestKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyConsumptionImpl implements _MonthlyConsumption {
  const _$MonthlyConsumptionImpl({
    required this.month,
    required this.totalKwh,
    required this.totalCost,
    required this.averageDaily,
    required this.peakDay,
    required this.peakKwh,
    required this.lowestDay,
    required this.lowestKwh,
  });

  factory _$MonthlyConsumptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyConsumptionImplFromJson(json);

  @override
  final String month;
  @override
  final double totalKwh;
  @override
  final double totalCost;
  @override
  final double averageDaily;
  @override
  final String peakDay;
  @override
  final double peakKwh;
  @override
  final String lowestDay;
  @override
  final double lowestKwh;

  @override
  String toString() {
    return 'MonthlyConsumption(month: $month, totalKwh: $totalKwh, totalCost: $totalCost, averageDaily: $averageDaily, peakDay: $peakDay, peakKwh: $peakKwh, lowestDay: $lowestDay, lowestKwh: $lowestKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyConsumptionImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalKwh, totalKwh) ||
                other.totalKwh == totalKwh) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.averageDaily, averageDaily) ||
                other.averageDaily == averageDaily) &&
            (identical(other.peakDay, peakDay) || other.peakDay == peakDay) &&
            (identical(other.peakKwh, peakKwh) || other.peakKwh == peakKwh) &&
            (identical(other.lowestDay, lowestDay) ||
                other.lowestDay == lowestDay) &&
            (identical(other.lowestKwh, lowestKwh) ||
                other.lowestKwh == lowestKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    month,
    totalKwh,
    totalCost,
    averageDaily,
    peakDay,
    peakKwh,
    lowestDay,
    lowestKwh,
  );

  /// Create a copy of MonthlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyConsumptionImplCopyWith<_$MonthlyConsumptionImpl> get copyWith =>
      __$$MonthlyConsumptionImplCopyWithImpl<_$MonthlyConsumptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyConsumptionImplToJson(this);
  }
}

abstract class _MonthlyConsumption implements MonthlyConsumption {
  const factory _MonthlyConsumption({
    required final String month,
    required final double totalKwh,
    required final double totalCost,
    required final double averageDaily,
    required final String peakDay,
    required final double peakKwh,
    required final String lowestDay,
    required final double lowestKwh,
  }) = _$MonthlyConsumptionImpl;

  factory _MonthlyConsumption.fromJson(Map<String, dynamic> json) =
      _$MonthlyConsumptionImpl.fromJson;

  @override
  String get month;
  @override
  double get totalKwh;
  @override
  double get totalCost;
  @override
  double get averageDaily;
  @override
  String get peakDay;
  @override
  double get peakKwh;
  @override
  String get lowestDay;
  @override
  double get lowestKwh;

  /// Create a copy of MonthlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyConsumptionImplCopyWith<_$MonthlyConsumptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YearlyConsumption _$YearlyConsumptionFromJson(Map<String, dynamic> json) {
  return _YearlyConsumption.fromJson(json);
}

/// @nodoc
mixin _$YearlyConsumption {
  int get year => throw _privateConstructorUsedError;
  double get totalKwh => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  double get averageMonthly => throw _privateConstructorUsedError;
  String get peakMonth => throw _privateConstructorUsedError;
  double get peakKwh => throw _privateConstructorUsedError;
  String get lowestMonth => throw _privateConstructorUsedError;
  double get lowestKwh => throw _privateConstructorUsedError;

  /// Serializes this YearlyConsumption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearlyConsumptionCopyWith<YearlyConsumption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearlyConsumptionCopyWith<$Res> {
  factory $YearlyConsumptionCopyWith(
    YearlyConsumption value,
    $Res Function(YearlyConsumption) then,
  ) = _$YearlyConsumptionCopyWithImpl<$Res, YearlyConsumption>;
  @useResult
  $Res call({
    int year,
    double totalKwh,
    double totalCost,
    double averageMonthly,
    String peakMonth,
    double peakKwh,
    String lowestMonth,
    double lowestKwh,
  });
}

/// @nodoc
class _$YearlyConsumptionCopyWithImpl<$Res, $Val extends YearlyConsumption>
    implements $YearlyConsumptionCopyWith<$Res> {
  _$YearlyConsumptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? totalKwh = null,
    Object? totalCost = null,
    Object? averageMonthly = null,
    Object? peakMonth = null,
    Object? peakKwh = null,
    Object? lowestMonth = null,
    Object? lowestKwh = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            totalKwh: null == totalKwh
                ? _value.totalKwh
                : totalKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCost: null == totalCost
                ? _value.totalCost
                : totalCost // ignore: cast_nullable_to_non_nullable
                      as double,
            averageMonthly: null == averageMonthly
                ? _value.averageMonthly
                : averageMonthly // ignore: cast_nullable_to_non_nullable
                      as double,
            peakMonth: null == peakMonth
                ? _value.peakMonth
                : peakMonth // ignore: cast_nullable_to_non_nullable
                      as String,
            peakKwh: null == peakKwh
                ? _value.peakKwh
                : peakKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            lowestMonth: null == lowestMonth
                ? _value.lowestMonth
                : lowestMonth // ignore: cast_nullable_to_non_nullable
                      as String,
            lowestKwh: null == lowestKwh
                ? _value.lowestKwh
                : lowestKwh // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YearlyConsumptionImplCopyWith<$Res>
    implements $YearlyConsumptionCopyWith<$Res> {
  factory _$$YearlyConsumptionImplCopyWith(
    _$YearlyConsumptionImpl value,
    $Res Function(_$YearlyConsumptionImpl) then,
  ) = __$$YearlyConsumptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    double totalKwh,
    double totalCost,
    double averageMonthly,
    String peakMonth,
    double peakKwh,
    String lowestMonth,
    double lowestKwh,
  });
}

/// @nodoc
class __$$YearlyConsumptionImplCopyWithImpl<$Res>
    extends _$YearlyConsumptionCopyWithImpl<$Res, _$YearlyConsumptionImpl>
    implements _$$YearlyConsumptionImplCopyWith<$Res> {
  __$$YearlyConsumptionImplCopyWithImpl(
    _$YearlyConsumptionImpl _value,
    $Res Function(_$YearlyConsumptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? totalKwh = null,
    Object? totalCost = null,
    Object? averageMonthly = null,
    Object? peakMonth = null,
    Object? peakKwh = null,
    Object? lowestMonth = null,
    Object? lowestKwh = null,
  }) {
    return _then(
      _$YearlyConsumptionImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        totalKwh: null == totalKwh
            ? _value.totalKwh
            : totalKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCost: null == totalCost
            ? _value.totalCost
            : totalCost // ignore: cast_nullable_to_non_nullable
                  as double,
        averageMonthly: null == averageMonthly
            ? _value.averageMonthly
            : averageMonthly // ignore: cast_nullable_to_non_nullable
                  as double,
        peakMonth: null == peakMonth
            ? _value.peakMonth
            : peakMonth // ignore: cast_nullable_to_non_nullable
                  as String,
        peakKwh: null == peakKwh
            ? _value.peakKwh
            : peakKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        lowestMonth: null == lowestMonth
            ? _value.lowestMonth
            : lowestMonth // ignore: cast_nullable_to_non_nullable
                  as String,
        lowestKwh: null == lowestKwh
            ? _value.lowestKwh
            : lowestKwh // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyConsumptionImpl implements _YearlyConsumption {
  const _$YearlyConsumptionImpl({
    required this.year,
    required this.totalKwh,
    required this.totalCost,
    required this.averageMonthly,
    required this.peakMonth,
    required this.peakKwh,
    required this.lowestMonth,
    required this.lowestKwh,
  });

  factory _$YearlyConsumptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyConsumptionImplFromJson(json);

  @override
  final int year;
  @override
  final double totalKwh;
  @override
  final double totalCost;
  @override
  final double averageMonthly;
  @override
  final String peakMonth;
  @override
  final double peakKwh;
  @override
  final String lowestMonth;
  @override
  final double lowestKwh;

  @override
  String toString() {
    return 'YearlyConsumption(year: $year, totalKwh: $totalKwh, totalCost: $totalCost, averageMonthly: $averageMonthly, peakMonth: $peakMonth, peakKwh: $peakKwh, lowestMonth: $lowestMonth, lowestKwh: $lowestKwh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyConsumptionImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalKwh, totalKwh) ||
                other.totalKwh == totalKwh) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.averageMonthly, averageMonthly) ||
                other.averageMonthly == averageMonthly) &&
            (identical(other.peakMonth, peakMonth) ||
                other.peakMonth == peakMonth) &&
            (identical(other.peakKwh, peakKwh) || other.peakKwh == peakKwh) &&
            (identical(other.lowestMonth, lowestMonth) ||
                other.lowestMonth == lowestMonth) &&
            (identical(other.lowestKwh, lowestKwh) ||
                other.lowestKwh == lowestKwh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    totalKwh,
    totalCost,
    averageMonthly,
    peakMonth,
    peakKwh,
    lowestMonth,
    lowestKwh,
  );

  /// Create a copy of YearlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyConsumptionImplCopyWith<_$YearlyConsumptionImpl> get copyWith =>
      __$$YearlyConsumptionImplCopyWithImpl<_$YearlyConsumptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyConsumptionImplToJson(this);
  }
}

abstract class _YearlyConsumption implements YearlyConsumption {
  const factory _YearlyConsumption({
    required final int year,
    required final double totalKwh,
    required final double totalCost,
    required final double averageMonthly,
    required final String peakMonth,
    required final double peakKwh,
    required final String lowestMonth,
    required final double lowestKwh,
  }) = _$YearlyConsumptionImpl;

  factory _YearlyConsumption.fromJson(Map<String, dynamic> json) =
      _$YearlyConsumptionImpl.fromJson;

  @override
  int get year;
  @override
  double get totalKwh;
  @override
  double get totalCost;
  @override
  double get averageMonthly;
  @override
  String get peakMonth;
  @override
  double get peakKwh;
  @override
  String get lowestMonth;
  @override
  double get lowestKwh;

  /// Create a copy of YearlyConsumption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyConsumptionImplCopyWith<_$YearlyConsumptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageStatistics _$UsageStatisticsFromJson(Map<String, dynamic> json) {
  return _UsageStatistics.fromJson(json);
}

/// @nodoc
mixin _$UsageStatistics {
  double get averageDailyUsage => throw _privateConstructorUsedError;
  double get averageMonthlyUsage => throw _privateConstructorUsedError;
  double get averageYearlyUsage => throw _privateConstructorUsedError;
  int get peakUsageHour => throw _privateConstructorUsedError;
  int get lowestUsageHour => throw _privateConstructorUsedError;
  SeasonalTrends get seasonalTrends => throw _privateConstructorUsedError;
  List<UsagePattern> get patterns => throw _privateConstructorUsedError;
  List<AnomalyDetection> get anomalies => throw _privateConstructorUsedError;
  double get efficiencyScore => throw _privateConstructorUsedError;
  double get carbonFootprint => throw _privateConstructorUsedError;
  List<EnergySavingTip> get savingTips => throw _privateConstructorUsedError;
  ConsumptionForecast get forecast => throw _privateConstructorUsedError;

  /// Serializes this UsageStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageStatisticsCopyWith<UsageStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageStatisticsCopyWith<$Res> {
  factory $UsageStatisticsCopyWith(
    UsageStatistics value,
    $Res Function(UsageStatistics) then,
  ) = _$UsageStatisticsCopyWithImpl<$Res, UsageStatistics>;
  @useResult
  $Res call({
    double averageDailyUsage,
    double averageMonthlyUsage,
    double averageYearlyUsage,
    int peakUsageHour,
    int lowestUsageHour,
    SeasonalTrends seasonalTrends,
    List<UsagePattern> patterns,
    List<AnomalyDetection> anomalies,
    double efficiencyScore,
    double carbonFootprint,
    List<EnergySavingTip> savingTips,
    ConsumptionForecast forecast,
  });

  $SeasonalTrendsCopyWith<$Res> get seasonalTrends;
  $ConsumptionForecastCopyWith<$Res> get forecast;
}

/// @nodoc
class _$UsageStatisticsCopyWithImpl<$Res, $Val extends UsageStatistics>
    implements $UsageStatisticsCopyWith<$Res> {
  _$UsageStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageDailyUsage = null,
    Object? averageMonthlyUsage = null,
    Object? averageYearlyUsage = null,
    Object? peakUsageHour = null,
    Object? lowestUsageHour = null,
    Object? seasonalTrends = null,
    Object? patterns = null,
    Object? anomalies = null,
    Object? efficiencyScore = null,
    Object? carbonFootprint = null,
    Object? savingTips = null,
    Object? forecast = null,
  }) {
    return _then(
      _value.copyWith(
            averageDailyUsage: null == averageDailyUsage
                ? _value.averageDailyUsage
                : averageDailyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            averageMonthlyUsage: null == averageMonthlyUsage
                ? _value.averageMonthlyUsage
                : averageMonthlyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            averageYearlyUsage: null == averageYearlyUsage
                ? _value.averageYearlyUsage
                : averageYearlyUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            peakUsageHour: null == peakUsageHour
                ? _value.peakUsageHour
                : peakUsageHour // ignore: cast_nullable_to_non_nullable
                      as int,
            lowestUsageHour: null == lowestUsageHour
                ? _value.lowestUsageHour
                : lowestUsageHour // ignore: cast_nullable_to_non_nullable
                      as int,
            seasonalTrends: null == seasonalTrends
                ? _value.seasonalTrends
                : seasonalTrends // ignore: cast_nullable_to_non_nullable
                      as SeasonalTrends,
            patterns: null == patterns
                ? _value.patterns
                : patterns // ignore: cast_nullable_to_non_nullable
                      as List<UsagePattern>,
            anomalies: null == anomalies
                ? _value.anomalies
                : anomalies // ignore: cast_nullable_to_non_nullable
                      as List<AnomalyDetection>,
            efficiencyScore: null == efficiencyScore
                ? _value.efficiencyScore
                : efficiencyScore // ignore: cast_nullable_to_non_nullable
                      as double,
            carbonFootprint: null == carbonFootprint
                ? _value.carbonFootprint
                : carbonFootprint // ignore: cast_nullable_to_non_nullable
                      as double,
            savingTips: null == savingTips
                ? _value.savingTips
                : savingTips // ignore: cast_nullable_to_non_nullable
                      as List<EnergySavingTip>,
            forecast: null == forecast
                ? _value.forecast
                : forecast // ignore: cast_nullable_to_non_nullable
                      as ConsumptionForecast,
          )
          as $Val,
    );
  }

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalTrendsCopyWith<$Res> get seasonalTrends {
    return $SeasonalTrendsCopyWith<$Res>(_value.seasonalTrends, (value) {
      return _then(_value.copyWith(seasonalTrends: value) as $Val);
    });
  }

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConsumptionForecastCopyWith<$Res> get forecast {
    return $ConsumptionForecastCopyWith<$Res>(_value.forecast, (value) {
      return _then(_value.copyWith(forecast: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UsageStatisticsImplCopyWith<$Res>
    implements $UsageStatisticsCopyWith<$Res> {
  factory _$$UsageStatisticsImplCopyWith(
    _$UsageStatisticsImpl value,
    $Res Function(_$UsageStatisticsImpl) then,
  ) = __$$UsageStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double averageDailyUsage,
    double averageMonthlyUsage,
    double averageYearlyUsage,
    int peakUsageHour,
    int lowestUsageHour,
    SeasonalTrends seasonalTrends,
    List<UsagePattern> patterns,
    List<AnomalyDetection> anomalies,
    double efficiencyScore,
    double carbonFootprint,
    List<EnergySavingTip> savingTips,
    ConsumptionForecast forecast,
  });

  @override
  $SeasonalTrendsCopyWith<$Res> get seasonalTrends;
  @override
  $ConsumptionForecastCopyWith<$Res> get forecast;
}

/// @nodoc
class __$$UsageStatisticsImplCopyWithImpl<$Res>
    extends _$UsageStatisticsCopyWithImpl<$Res, _$UsageStatisticsImpl>
    implements _$$UsageStatisticsImplCopyWith<$Res> {
  __$$UsageStatisticsImplCopyWithImpl(
    _$UsageStatisticsImpl _value,
    $Res Function(_$UsageStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageDailyUsage = null,
    Object? averageMonthlyUsage = null,
    Object? averageYearlyUsage = null,
    Object? peakUsageHour = null,
    Object? lowestUsageHour = null,
    Object? seasonalTrends = null,
    Object? patterns = null,
    Object? anomalies = null,
    Object? efficiencyScore = null,
    Object? carbonFootprint = null,
    Object? savingTips = null,
    Object? forecast = null,
  }) {
    return _then(
      _$UsageStatisticsImpl(
        averageDailyUsage: null == averageDailyUsage
            ? _value.averageDailyUsage
            : averageDailyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        averageMonthlyUsage: null == averageMonthlyUsage
            ? _value.averageMonthlyUsage
            : averageMonthlyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        averageYearlyUsage: null == averageYearlyUsage
            ? _value.averageYearlyUsage
            : averageYearlyUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        peakUsageHour: null == peakUsageHour
            ? _value.peakUsageHour
            : peakUsageHour // ignore: cast_nullable_to_non_nullable
                  as int,
        lowestUsageHour: null == lowestUsageHour
            ? _value.lowestUsageHour
            : lowestUsageHour // ignore: cast_nullable_to_non_nullable
                  as int,
        seasonalTrends: null == seasonalTrends
            ? _value.seasonalTrends
            : seasonalTrends // ignore: cast_nullable_to_non_nullable
                  as SeasonalTrends,
        patterns: null == patterns
            ? _value._patterns
            : patterns // ignore: cast_nullable_to_non_nullable
                  as List<UsagePattern>,
        anomalies: null == anomalies
            ? _value._anomalies
            : anomalies // ignore: cast_nullable_to_non_nullable
                  as List<AnomalyDetection>,
        efficiencyScore: null == efficiencyScore
            ? _value.efficiencyScore
            : efficiencyScore // ignore: cast_nullable_to_non_nullable
                  as double,
        carbonFootprint: null == carbonFootprint
            ? _value.carbonFootprint
            : carbonFootprint // ignore: cast_nullable_to_non_nullable
                  as double,
        savingTips: null == savingTips
            ? _value._savingTips
            : savingTips // ignore: cast_nullable_to_non_nullable
                  as List<EnergySavingTip>,
        forecast: null == forecast
            ? _value.forecast
            : forecast // ignore: cast_nullable_to_non_nullable
                  as ConsumptionForecast,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageStatisticsImpl extends _UsageStatistics {
  const _$UsageStatisticsImpl({
    required this.averageDailyUsage,
    required this.averageMonthlyUsage,
    required this.averageYearlyUsage,
    required this.peakUsageHour,
    required this.lowestUsageHour,
    required this.seasonalTrends,
    final List<UsagePattern> patterns = const [],
    final List<AnomalyDetection> anomalies = const [],
    this.efficiencyScore = 0.0,
    this.carbonFootprint = 0.0,
    final List<EnergySavingTip> savingTips = const [],
    this.forecast = const ConsumptionForecast(),
  }) : _patterns = patterns,
       _anomalies = anomalies,
       _savingTips = savingTips,
       super._();

  factory _$UsageStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageStatisticsImplFromJson(json);

  @override
  final double averageDailyUsage;
  @override
  final double averageMonthlyUsage;
  @override
  final double averageYearlyUsage;
  @override
  final int peakUsageHour;
  @override
  final int lowestUsageHour;
  @override
  final SeasonalTrends seasonalTrends;
  final List<UsagePattern> _patterns;
  @override
  @JsonKey()
  List<UsagePattern> get patterns {
    if (_patterns is EqualUnmodifiableListView) return _patterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patterns);
  }

  final List<AnomalyDetection> _anomalies;
  @override
  @JsonKey()
  List<AnomalyDetection> get anomalies {
    if (_anomalies is EqualUnmodifiableListView) return _anomalies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_anomalies);
  }

  @override
  @JsonKey()
  final double efficiencyScore;
  @override
  @JsonKey()
  final double carbonFootprint;
  final List<EnergySavingTip> _savingTips;
  @override
  @JsonKey()
  List<EnergySavingTip> get savingTips {
    if (_savingTips is EqualUnmodifiableListView) return _savingTips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savingTips);
  }

  @override
  @JsonKey()
  final ConsumptionForecast forecast;

  @override
  String toString() {
    return 'UsageStatistics(averageDailyUsage: $averageDailyUsage, averageMonthlyUsage: $averageMonthlyUsage, averageYearlyUsage: $averageYearlyUsage, peakUsageHour: $peakUsageHour, lowestUsageHour: $lowestUsageHour, seasonalTrends: $seasonalTrends, patterns: $patterns, anomalies: $anomalies, efficiencyScore: $efficiencyScore, carbonFootprint: $carbonFootprint, savingTips: $savingTips, forecast: $forecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageStatisticsImpl &&
            (identical(other.averageDailyUsage, averageDailyUsage) ||
                other.averageDailyUsage == averageDailyUsage) &&
            (identical(other.averageMonthlyUsage, averageMonthlyUsage) ||
                other.averageMonthlyUsage == averageMonthlyUsage) &&
            (identical(other.averageYearlyUsage, averageYearlyUsage) ||
                other.averageYearlyUsage == averageYearlyUsage) &&
            (identical(other.peakUsageHour, peakUsageHour) ||
                other.peakUsageHour == peakUsageHour) &&
            (identical(other.lowestUsageHour, lowestUsageHour) ||
                other.lowestUsageHour == lowestUsageHour) &&
            (identical(other.seasonalTrends, seasonalTrends) ||
                other.seasonalTrends == seasonalTrends) &&
            const DeepCollectionEquality().equals(other._patterns, _patterns) &&
            const DeepCollectionEquality().equals(
              other._anomalies,
              _anomalies,
            ) &&
            (identical(other.efficiencyScore, efficiencyScore) ||
                other.efficiencyScore == efficiencyScore) &&
            (identical(other.carbonFootprint, carbonFootprint) ||
                other.carbonFootprint == carbonFootprint) &&
            const DeepCollectionEquality().equals(
              other._savingTips,
              _savingTips,
            ) &&
            (identical(other.forecast, forecast) ||
                other.forecast == forecast));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    averageDailyUsage,
    averageMonthlyUsage,
    averageYearlyUsage,
    peakUsageHour,
    lowestUsageHour,
    seasonalTrends,
    const DeepCollectionEquality().hash(_patterns),
    const DeepCollectionEquality().hash(_anomalies),
    efficiencyScore,
    carbonFootprint,
    const DeepCollectionEquality().hash(_savingTips),
    forecast,
  );

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageStatisticsImplCopyWith<_$UsageStatisticsImpl> get copyWith =>
      __$$UsageStatisticsImplCopyWithImpl<_$UsageStatisticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageStatisticsImplToJson(this);
  }
}

abstract class _UsageStatistics extends UsageStatistics {
  const factory _UsageStatistics({
    required final double averageDailyUsage,
    required final double averageMonthlyUsage,
    required final double averageYearlyUsage,
    required final int peakUsageHour,
    required final int lowestUsageHour,
    required final SeasonalTrends seasonalTrends,
    final List<UsagePattern> patterns,
    final List<AnomalyDetection> anomalies,
    final double efficiencyScore,
    final double carbonFootprint,
    final List<EnergySavingTip> savingTips,
    final ConsumptionForecast forecast,
  }) = _$UsageStatisticsImpl;
  const _UsageStatistics._() : super._();

  factory _UsageStatistics.fromJson(Map<String, dynamic> json) =
      _$UsageStatisticsImpl.fromJson;

  @override
  double get averageDailyUsage;
  @override
  double get averageMonthlyUsage;
  @override
  double get averageYearlyUsage;
  @override
  int get peakUsageHour;
  @override
  int get lowestUsageHour;
  @override
  SeasonalTrends get seasonalTrends;
  @override
  List<UsagePattern> get patterns;
  @override
  List<AnomalyDetection> get anomalies;
  @override
  double get efficiencyScore;
  @override
  double get carbonFootprint;
  @override
  List<EnergySavingTip> get savingTips;
  @override
  ConsumptionForecast get forecast;

  /// Create a copy of UsageStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageStatisticsImplCopyWith<_$UsageStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonalTrends _$SeasonalTrendsFromJson(Map<String, dynamic> json) {
  return _SeasonalTrends.fromJson(json);
}

/// @nodoc
mixin _$SeasonalTrends {
  SeasonalData get summer => throw _privateConstructorUsedError;
  SeasonalData get fall => throw _privateConstructorUsedError;
  SeasonalData get winter => throw _privateConstructorUsedError;
  SeasonalData get spring => throw _privateConstructorUsedError;

  /// Serializes this SeasonalTrends to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonalTrendsCopyWith<SeasonalTrends> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalTrendsCopyWith<$Res> {
  factory $SeasonalTrendsCopyWith(
    SeasonalTrends value,
    $Res Function(SeasonalTrends) then,
  ) = _$SeasonalTrendsCopyWithImpl<$Res, SeasonalTrends>;
  @useResult
  $Res call({
    SeasonalData summer,
    SeasonalData fall,
    SeasonalData winter,
    SeasonalData spring,
  });

  $SeasonalDataCopyWith<$Res> get summer;
  $SeasonalDataCopyWith<$Res> get fall;
  $SeasonalDataCopyWith<$Res> get winter;
  $SeasonalDataCopyWith<$Res> get spring;
}

/// @nodoc
class _$SeasonalTrendsCopyWithImpl<$Res, $Val extends SeasonalTrends>
    implements $SeasonalTrendsCopyWith<$Res> {
  _$SeasonalTrendsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summer = null,
    Object? fall = null,
    Object? winter = null,
    Object? spring = null,
  }) {
    return _then(
      _value.copyWith(
            summer: null == summer
                ? _value.summer
                : summer // ignore: cast_nullable_to_non_nullable
                      as SeasonalData,
            fall: null == fall
                ? _value.fall
                : fall // ignore: cast_nullable_to_non_nullable
                      as SeasonalData,
            winter: null == winter
                ? _value.winter
                : winter // ignore: cast_nullable_to_non_nullable
                      as SeasonalData,
            spring: null == spring
                ? _value.spring
                : spring // ignore: cast_nullable_to_non_nullable
                      as SeasonalData,
          )
          as $Val,
    );
  }

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalDataCopyWith<$Res> get summer {
    return $SeasonalDataCopyWith<$Res>(_value.summer, (value) {
      return _then(_value.copyWith(summer: value) as $Val);
    });
  }

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalDataCopyWith<$Res> get fall {
    return $SeasonalDataCopyWith<$Res>(_value.fall, (value) {
      return _then(_value.copyWith(fall: value) as $Val);
    });
  }

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalDataCopyWith<$Res> get winter {
    return $SeasonalDataCopyWith<$Res>(_value.winter, (value) {
      return _then(_value.copyWith(winter: value) as $Val);
    });
  }

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonalDataCopyWith<$Res> get spring {
    return $SeasonalDataCopyWith<$Res>(_value.spring, (value) {
      return _then(_value.copyWith(spring: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeasonalTrendsImplCopyWith<$Res>
    implements $SeasonalTrendsCopyWith<$Res> {
  factory _$$SeasonalTrendsImplCopyWith(
    _$SeasonalTrendsImpl value,
    $Res Function(_$SeasonalTrendsImpl) then,
  ) = __$$SeasonalTrendsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SeasonalData summer,
    SeasonalData fall,
    SeasonalData winter,
    SeasonalData spring,
  });

  @override
  $SeasonalDataCopyWith<$Res> get summer;
  @override
  $SeasonalDataCopyWith<$Res> get fall;
  @override
  $SeasonalDataCopyWith<$Res> get winter;
  @override
  $SeasonalDataCopyWith<$Res> get spring;
}

/// @nodoc
class __$$SeasonalTrendsImplCopyWithImpl<$Res>
    extends _$SeasonalTrendsCopyWithImpl<$Res, _$SeasonalTrendsImpl>
    implements _$$SeasonalTrendsImplCopyWith<$Res> {
  __$$SeasonalTrendsImplCopyWithImpl(
    _$SeasonalTrendsImpl _value,
    $Res Function(_$SeasonalTrendsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summer = null,
    Object? fall = null,
    Object? winter = null,
    Object? spring = null,
  }) {
    return _then(
      _$SeasonalTrendsImpl(
        summer: null == summer
            ? _value.summer
            : summer // ignore: cast_nullable_to_non_nullable
                  as SeasonalData,
        fall: null == fall
            ? _value.fall
            : fall // ignore: cast_nullable_to_non_nullable
                  as SeasonalData,
        winter: null == winter
            ? _value.winter
            : winter // ignore: cast_nullable_to_non_nullable
                  as SeasonalData,
        spring: null == spring
            ? _value.spring
            : spring // ignore: cast_nullable_to_non_nullable
                  as SeasonalData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonalTrendsImpl implements _SeasonalTrends {
  const _$SeasonalTrendsImpl({
    required this.summer,
    required this.fall,
    required this.winter,
    required this.spring,
  });

  factory _$SeasonalTrendsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonalTrendsImplFromJson(json);

  @override
  final SeasonalData summer;
  @override
  final SeasonalData fall;
  @override
  final SeasonalData winter;
  @override
  final SeasonalData spring;

  @override
  String toString() {
    return 'SeasonalTrends(summer: $summer, fall: $fall, winter: $winter, spring: $spring)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalTrendsImpl &&
            (identical(other.summer, summer) || other.summer == summer) &&
            (identical(other.fall, fall) || other.fall == fall) &&
            (identical(other.winter, winter) || other.winter == winter) &&
            (identical(other.spring, spring) || other.spring == spring));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, summer, fall, winter, spring);

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalTrendsImplCopyWith<_$SeasonalTrendsImpl> get copyWith =>
      __$$SeasonalTrendsImplCopyWithImpl<_$SeasonalTrendsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonalTrendsImplToJson(this);
  }
}

abstract class _SeasonalTrends implements SeasonalTrends {
  const factory _SeasonalTrends({
    required final SeasonalData summer,
    required final SeasonalData fall,
    required final SeasonalData winter,
    required final SeasonalData spring,
  }) = _$SeasonalTrendsImpl;

  factory _SeasonalTrends.fromJson(Map<String, dynamic> json) =
      _$SeasonalTrendsImpl.fromJson;

  @override
  SeasonalData get summer;
  @override
  SeasonalData get fall;
  @override
  SeasonalData get winter;
  @override
  SeasonalData get spring;

  /// Create a copy of SeasonalTrends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonalTrendsImplCopyWith<_$SeasonalTrendsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonalData _$SeasonalDataFromJson(Map<String, dynamic> json) {
  return _SeasonalData.fromJson(json);
}

/// @nodoc
mixin _$SeasonalData {
  double get average => throw _privateConstructorUsedError;
  double get peak => throw _privateConstructorUsedError;
  double get lowest => throw _privateConstructorUsedError;
  double get standardDeviation => throw _privateConstructorUsedError;
  List<String> get peakDays => throw _privateConstructorUsedError;

  /// Serializes this SeasonalData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonalDataCopyWith<SeasonalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalDataCopyWith<$Res> {
  factory $SeasonalDataCopyWith(
    SeasonalData value,
    $Res Function(SeasonalData) then,
  ) = _$SeasonalDataCopyWithImpl<$Res, SeasonalData>;
  @useResult
  $Res call({
    double average,
    double peak,
    double lowest,
    double standardDeviation,
    List<String> peakDays,
  });
}

/// @nodoc
class _$SeasonalDataCopyWithImpl<$Res, $Val extends SeasonalData>
    implements $SeasonalDataCopyWith<$Res> {
  _$SeasonalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = null,
    Object? peak = null,
    Object? lowest = null,
    Object? standardDeviation = null,
    Object? peakDays = null,
  }) {
    return _then(
      _value.copyWith(
            average: null == average
                ? _value.average
                : average // ignore: cast_nullable_to_non_nullable
                      as double,
            peak: null == peak
                ? _value.peak
                : peak // ignore: cast_nullable_to_non_nullable
                      as double,
            lowest: null == lowest
                ? _value.lowest
                : lowest // ignore: cast_nullable_to_non_nullable
                      as double,
            standardDeviation: null == standardDeviation
                ? _value.standardDeviation
                : standardDeviation // ignore: cast_nullable_to_non_nullable
                      as double,
            peakDays: null == peakDays
                ? _value.peakDays
                : peakDays // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeasonalDataImplCopyWith<$Res>
    implements $SeasonalDataCopyWith<$Res> {
  factory _$$SeasonalDataImplCopyWith(
    _$SeasonalDataImpl value,
    $Res Function(_$SeasonalDataImpl) then,
  ) = __$$SeasonalDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double average,
    double peak,
    double lowest,
    double standardDeviation,
    List<String> peakDays,
  });
}

/// @nodoc
class __$$SeasonalDataImplCopyWithImpl<$Res>
    extends _$SeasonalDataCopyWithImpl<$Res, _$SeasonalDataImpl>
    implements _$$SeasonalDataImplCopyWith<$Res> {
  __$$SeasonalDataImplCopyWithImpl(
    _$SeasonalDataImpl _value,
    $Res Function(_$SeasonalDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = null,
    Object? peak = null,
    Object? lowest = null,
    Object? standardDeviation = null,
    Object? peakDays = null,
  }) {
    return _then(
      _$SeasonalDataImpl(
        average: null == average
            ? _value.average
            : average // ignore: cast_nullable_to_non_nullable
                  as double,
        peak: null == peak
            ? _value.peak
            : peak // ignore: cast_nullable_to_non_nullable
                  as double,
        lowest: null == lowest
            ? _value.lowest
            : lowest // ignore: cast_nullable_to_non_nullable
                  as double,
        standardDeviation: null == standardDeviation
            ? _value.standardDeviation
            : standardDeviation // ignore: cast_nullable_to_non_nullable
                  as double,
        peakDays: null == peakDays
            ? _value._peakDays
            : peakDays // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonalDataImpl implements _SeasonalData {
  const _$SeasonalDataImpl({
    required this.average,
    required this.peak,
    this.lowest = 0.0,
    this.standardDeviation = 0.0,
    final List<String> peakDays = const [],
  }) : _peakDays = peakDays;

  factory _$SeasonalDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonalDataImplFromJson(json);

  @override
  final double average;
  @override
  final double peak;
  @override
  @JsonKey()
  final double lowest;
  @override
  @JsonKey()
  final double standardDeviation;
  final List<String> _peakDays;
  @override
  @JsonKey()
  List<String> get peakDays {
    if (_peakDays is EqualUnmodifiableListView) return _peakDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakDays);
  }

  @override
  String toString() {
    return 'SeasonalData(average: $average, peak: $peak, lowest: $lowest, standardDeviation: $standardDeviation, peakDays: $peakDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalDataImpl &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.peak, peak) || other.peak == peak) &&
            (identical(other.lowest, lowest) || other.lowest == lowest) &&
            (identical(other.standardDeviation, standardDeviation) ||
                other.standardDeviation == standardDeviation) &&
            const DeepCollectionEquality().equals(other._peakDays, _peakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    average,
    peak,
    lowest,
    standardDeviation,
    const DeepCollectionEquality().hash(_peakDays),
  );

  /// Create a copy of SeasonalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalDataImplCopyWith<_$SeasonalDataImpl> get copyWith =>
      __$$SeasonalDataImplCopyWithImpl<_$SeasonalDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonalDataImplToJson(this);
  }
}

abstract class _SeasonalData implements SeasonalData {
  const factory _SeasonalData({
    required final double average,
    required final double peak,
    final double lowest,
    final double standardDeviation,
    final List<String> peakDays,
  }) = _$SeasonalDataImpl;

  factory _SeasonalData.fromJson(Map<String, dynamic> json) =
      _$SeasonalDataImpl.fromJson;

  @override
  double get average;
  @override
  double get peak;
  @override
  double get lowest;
  @override
  double get standardDeviation;
  @override
  List<String> get peakDays;

  /// Create a copy of SeasonalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonalDataImplCopyWith<_$SeasonalDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PeakUsage _$PeakUsageFromJson(Map<String, dynamic> json) {
  return _PeakUsage.fromJson(json);
}

/// @nodoc
mixin _$PeakUsage {
  int get hour => throw _privateConstructorUsedError;
  double get kwh => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this PeakUsage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PeakUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeakUsageCopyWith<PeakUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeakUsageCopyWith<$Res> {
  factory $PeakUsageCopyWith(PeakUsage value, $Res Function(PeakUsage) then) =
      _$PeakUsageCopyWithImpl<$Res, PeakUsage>;
  @useResult
  $Res call({
    int hour,
    double kwh,
    double cost,
    DateTime timestamp,
    String? reason,
  });
}

/// @nodoc
class _$PeakUsageCopyWithImpl<$Res, $Val extends PeakUsage>
    implements $PeakUsageCopyWith<$Res> {
  _$PeakUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeakUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? kwh = null,
    Object? cost = null,
    Object? timestamp = null,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            hour: null == hour
                ? _value.hour
                : hour // ignore: cast_nullable_to_non_nullable
                      as int,
            kwh: null == kwh
                ? _value.kwh
                : kwh // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PeakUsageImplCopyWith<$Res>
    implements $PeakUsageCopyWith<$Res> {
  factory _$$PeakUsageImplCopyWith(
    _$PeakUsageImpl value,
    $Res Function(_$PeakUsageImpl) then,
  ) = __$$PeakUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int hour,
    double kwh,
    double cost,
    DateTime timestamp,
    String? reason,
  });
}

/// @nodoc
class __$$PeakUsageImplCopyWithImpl<$Res>
    extends _$PeakUsageCopyWithImpl<$Res, _$PeakUsageImpl>
    implements _$$PeakUsageImplCopyWith<$Res> {
  __$$PeakUsageImplCopyWithImpl(
    _$PeakUsageImpl _value,
    $Res Function(_$PeakUsageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PeakUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? kwh = null,
    Object? cost = null,
    Object? timestamp = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$PeakUsageImpl(
        hour: null == hour
            ? _value.hour
            : hour // ignore: cast_nullable_to_non_nullable
                  as int,
        kwh: null == kwh
            ? _value.kwh
            : kwh // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PeakUsageImpl implements _PeakUsage {
  const _$PeakUsageImpl({
    required this.hour,
    required this.kwh,
    required this.cost,
    required this.timestamp,
    this.reason,
  });

  factory _$PeakUsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PeakUsageImplFromJson(json);

  @override
  final int hour;
  @override
  final double kwh;
  @override
  final double cost;
  @override
  final DateTime timestamp;
  @override
  final String? reason;

  @override
  String toString() {
    return 'PeakUsage(hour: $hour, kwh: $kwh, cost: $cost, timestamp: $timestamp, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeakUsageImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.kwh, kwh) || other.kwh == kwh) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hour, kwh, cost, timestamp, reason);

  /// Create a copy of PeakUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeakUsageImplCopyWith<_$PeakUsageImpl> get copyWith =>
      __$$PeakUsageImplCopyWithImpl<_$PeakUsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeakUsageImplToJson(this);
  }
}

abstract class _PeakUsage implements PeakUsage {
  const factory _PeakUsage({
    required final int hour,
    required final double kwh,
    required final double cost,
    required final DateTime timestamp,
    final String? reason,
  }) = _$PeakUsageImpl;

  factory _PeakUsage.fromJson(Map<String, dynamic> json) =
      _$PeakUsageImpl.fromJson;

  @override
  int get hour;
  @override
  double get kwh;
  @override
  double get cost;
  @override
  DateTime get timestamp;
  @override
  String? get reason;

  /// Create a copy of PeakUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeakUsageImplCopyWith<_$PeakUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LowUsage _$LowUsageFromJson(Map<String, dynamic> json) {
  return _LowUsage.fromJson(json);
}

/// @nodoc
mixin _$LowUsage {
  int get hour => throw _privateConstructorUsedError;
  double get kwh => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this LowUsage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LowUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LowUsageCopyWith<LowUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LowUsageCopyWith<$Res> {
  factory $LowUsageCopyWith(LowUsage value, $Res Function(LowUsage) then) =
      _$LowUsageCopyWithImpl<$Res, LowUsage>;
  @useResult
  $Res call({
    int hour,
    double kwh,
    double cost,
    DateTime timestamp,
    String? reason,
  });
}

/// @nodoc
class _$LowUsageCopyWithImpl<$Res, $Val extends LowUsage>
    implements $LowUsageCopyWith<$Res> {
  _$LowUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LowUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? kwh = null,
    Object? cost = null,
    Object? timestamp = null,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            hour: null == hour
                ? _value.hour
                : hour // ignore: cast_nullable_to_non_nullable
                      as int,
            kwh: null == kwh
                ? _value.kwh
                : kwh // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LowUsageImplCopyWith<$Res>
    implements $LowUsageCopyWith<$Res> {
  factory _$$LowUsageImplCopyWith(
    _$LowUsageImpl value,
    $Res Function(_$LowUsageImpl) then,
  ) = __$$LowUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int hour,
    double kwh,
    double cost,
    DateTime timestamp,
    String? reason,
  });
}

/// @nodoc
class __$$LowUsageImplCopyWithImpl<$Res>
    extends _$LowUsageCopyWithImpl<$Res, _$LowUsageImpl>
    implements _$$LowUsageImplCopyWith<$Res> {
  __$$LowUsageImplCopyWithImpl(
    _$LowUsageImpl _value,
    $Res Function(_$LowUsageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LowUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? kwh = null,
    Object? cost = null,
    Object? timestamp = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$LowUsageImpl(
        hour: null == hour
            ? _value.hour
            : hour // ignore: cast_nullable_to_non_nullable
                  as int,
        kwh: null == kwh
            ? _value.kwh
            : kwh // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LowUsageImpl implements _LowUsage {
  const _$LowUsageImpl({
    required this.hour,
    required this.kwh,
    required this.cost,
    required this.timestamp,
    this.reason,
  });

  factory _$LowUsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LowUsageImplFromJson(json);

  @override
  final int hour;
  @override
  final double kwh;
  @override
  final double cost;
  @override
  final DateTime timestamp;
  @override
  final String? reason;

  @override
  String toString() {
    return 'LowUsage(hour: $hour, kwh: $kwh, cost: $cost, timestamp: $timestamp, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LowUsageImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.kwh, kwh) || other.kwh == kwh) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hour, kwh, cost, timestamp, reason);

  /// Create a copy of LowUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LowUsageImplCopyWith<_$LowUsageImpl> get copyWith =>
      __$$LowUsageImplCopyWithImpl<_$LowUsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LowUsageImplToJson(this);
  }
}

abstract class _LowUsage implements LowUsage {
  const factory _LowUsage({
    required final int hour,
    required final double kwh,
    required final double cost,
    required final DateTime timestamp,
    final String? reason,
  }) = _$LowUsageImpl;

  factory _LowUsage.fromJson(Map<String, dynamic> json) =
      _$LowUsageImpl.fromJson;

  @override
  int get hour;
  @override
  double get kwh;
  @override
  double get cost;
  @override
  DateTime get timestamp;
  @override
  String? get reason;

  /// Create a copy of LowUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LowUsageImplCopyWith<_$LowUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageAlert _$UsageAlertFromJson(Map<String, dynamic> json) {
  return _UsageAlert.fromJson(json);
}

/// @nodoc
mixin _$UsageAlert {
  String get id => throw _privateConstructorUsedError;
  AlertType get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  AlertSeverity get severity => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this UsageAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageAlertCopyWith<UsageAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageAlertCopyWith<$Res> {
  factory $UsageAlertCopyWith(
    UsageAlert value,
    $Res Function(UsageAlert) then,
  ) = _$UsageAlertCopyWithImpl<$Res, UsageAlert>;
  @useResult
  $Res call({
    String id,
    AlertType type,
    String message,
    DateTime timestamp,
    AlertSeverity severity,
    bool isRead,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$UsageAlertCopyWithImpl<$Res, $Val extends UsageAlert>
    implements $UsageAlertCopyWith<$Res> {
  _$UsageAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? severity = null,
    Object? isRead = null,
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
                      as AlertType,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as AlertSeverity,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UsageAlertImplCopyWith<$Res>
    implements $UsageAlertCopyWith<$Res> {
  factory _$$UsageAlertImplCopyWith(
    _$UsageAlertImpl value,
    $Res Function(_$UsageAlertImpl) then,
  ) = __$$UsageAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    AlertType type,
    String message,
    DateTime timestamp,
    AlertSeverity severity,
    bool isRead,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$UsageAlertImplCopyWithImpl<$Res>
    extends _$UsageAlertCopyWithImpl<$Res, _$UsageAlertImpl>
    implements _$$UsageAlertImplCopyWith<$Res> {
  __$$UsageAlertImplCopyWithImpl(
    _$UsageAlertImpl _value,
    $Res Function(_$UsageAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? timestamp = null,
    Object? severity = null,
    Object? isRead = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$UsageAlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AlertType,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as AlertSeverity,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
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
class _$UsageAlertImpl implements _UsageAlert {
  const _$UsageAlertImpl({
    required this.id,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.severity,
    this.isRead = false,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$UsageAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageAlertImplFromJson(json);

  @override
  final String id;
  @override
  final AlertType type;
  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  final AlertSeverity severity;
  @override
  @JsonKey()
  final bool isRead;
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
    return 'UsageAlert(id: $id, type: $type, message: $message, timestamp: $timestamp, severity: $severity, isRead: $isRead, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    message,
    timestamp,
    severity,
    isRead,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of UsageAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageAlertImplCopyWith<_$UsageAlertImpl> get copyWith =>
      __$$UsageAlertImplCopyWithImpl<_$UsageAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageAlertImplToJson(this);
  }
}

abstract class _UsageAlert implements UsageAlert {
  const factory _UsageAlert({
    required final String id,
    required final AlertType type,
    required final String message,
    required final DateTime timestamp,
    required final AlertSeverity severity,
    final bool isRead,
    final Map<String, dynamic>? metadata,
  }) = _$UsageAlertImpl;

  factory _UsageAlert.fromJson(Map<String, dynamic> json) =
      _$UsageAlertImpl.fromJson;

  @override
  String get id;
  @override
  AlertType get type;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  AlertSeverity get severity;
  @override
  bool get isRead;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of UsageAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageAlertImplCopyWith<_$UsageAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsumptionPattern _$ConsumptionPatternFromJson(Map<String, dynamic> json) {
  return _ConsumptionPattern.fromJson(json);
}

/// @nodoc
mixin _$ConsumptionPattern {
  double? get previousDayUsage => throw _privateConstructorUsedError;
  double? get previousWeekAverage => throw _privateConstructorUsedError;
  double? get previousMonthAverage => throw _privateConstructorUsedError;
  List<int> get typicalPeakHours => throw _privateConstructorUsedError;
  List<int> get typicalLowHours => throw _privateConstructorUsedError;
  double get weekendAverage => throw _privateConstructorUsedError;
  double get weekdayAverage => throw _privateConstructorUsedError;
  double get holidayAverage => throw _privateConstructorUsedError;

  /// Serializes this ConsumptionPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsumptionPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsumptionPatternCopyWith<ConsumptionPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumptionPatternCopyWith<$Res> {
  factory $ConsumptionPatternCopyWith(
    ConsumptionPattern value,
    $Res Function(ConsumptionPattern) then,
  ) = _$ConsumptionPatternCopyWithImpl<$Res, ConsumptionPattern>;
  @useResult
  $Res call({
    double? previousDayUsage,
    double? previousWeekAverage,
    double? previousMonthAverage,
    List<int> typicalPeakHours,
    List<int> typicalLowHours,
    double weekendAverage,
    double weekdayAverage,
    double holidayAverage,
  });
}

/// @nodoc
class _$ConsumptionPatternCopyWithImpl<$Res, $Val extends ConsumptionPattern>
    implements $ConsumptionPatternCopyWith<$Res> {
  _$ConsumptionPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsumptionPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousDayUsage = freezed,
    Object? previousWeekAverage = freezed,
    Object? previousMonthAverage = freezed,
    Object? typicalPeakHours = null,
    Object? typicalLowHours = null,
    Object? weekendAverage = null,
    Object? weekdayAverage = null,
    Object? holidayAverage = null,
  }) {
    return _then(
      _value.copyWith(
            previousDayUsage: freezed == previousDayUsage
                ? _value.previousDayUsage
                : previousDayUsage // ignore: cast_nullable_to_non_nullable
                      as double?,
            previousWeekAverage: freezed == previousWeekAverage
                ? _value.previousWeekAverage
                : previousWeekAverage // ignore: cast_nullable_to_non_nullable
                      as double?,
            previousMonthAverage: freezed == previousMonthAverage
                ? _value.previousMonthAverage
                : previousMonthAverage // ignore: cast_nullable_to_non_nullable
                      as double?,
            typicalPeakHours: null == typicalPeakHours
                ? _value.typicalPeakHours
                : typicalPeakHours // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            typicalLowHours: null == typicalLowHours
                ? _value.typicalLowHours
                : typicalLowHours // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            weekendAverage: null == weekendAverage
                ? _value.weekendAverage
                : weekendAverage // ignore: cast_nullable_to_non_nullable
                      as double,
            weekdayAverage: null == weekdayAverage
                ? _value.weekdayAverage
                : weekdayAverage // ignore: cast_nullable_to_non_nullable
                      as double,
            holidayAverage: null == holidayAverage
                ? _value.holidayAverage
                : holidayAverage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsumptionPatternImplCopyWith<$Res>
    implements $ConsumptionPatternCopyWith<$Res> {
  factory _$$ConsumptionPatternImplCopyWith(
    _$ConsumptionPatternImpl value,
    $Res Function(_$ConsumptionPatternImpl) then,
  ) = __$$ConsumptionPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double? previousDayUsage,
    double? previousWeekAverage,
    double? previousMonthAverage,
    List<int> typicalPeakHours,
    List<int> typicalLowHours,
    double weekendAverage,
    double weekdayAverage,
    double holidayAverage,
  });
}

/// @nodoc
class __$$ConsumptionPatternImplCopyWithImpl<$Res>
    extends _$ConsumptionPatternCopyWithImpl<$Res, _$ConsumptionPatternImpl>
    implements _$$ConsumptionPatternImplCopyWith<$Res> {
  __$$ConsumptionPatternImplCopyWithImpl(
    _$ConsumptionPatternImpl _value,
    $Res Function(_$ConsumptionPatternImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsumptionPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousDayUsage = freezed,
    Object? previousWeekAverage = freezed,
    Object? previousMonthAverage = freezed,
    Object? typicalPeakHours = null,
    Object? typicalLowHours = null,
    Object? weekendAverage = null,
    Object? weekdayAverage = null,
    Object? holidayAverage = null,
  }) {
    return _then(
      _$ConsumptionPatternImpl(
        previousDayUsage: freezed == previousDayUsage
            ? _value.previousDayUsage
            : previousDayUsage // ignore: cast_nullable_to_non_nullable
                  as double?,
        previousWeekAverage: freezed == previousWeekAverage
            ? _value.previousWeekAverage
            : previousWeekAverage // ignore: cast_nullable_to_non_nullable
                  as double?,
        previousMonthAverage: freezed == previousMonthAverage
            ? _value.previousMonthAverage
            : previousMonthAverage // ignore: cast_nullable_to_non_nullable
                  as double?,
        typicalPeakHours: null == typicalPeakHours
            ? _value._typicalPeakHours
            : typicalPeakHours // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        typicalLowHours: null == typicalLowHours
            ? _value._typicalLowHours
            : typicalLowHours // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        weekendAverage: null == weekendAverage
            ? _value.weekendAverage
            : weekendAverage // ignore: cast_nullable_to_non_nullable
                  as double,
        weekdayAverage: null == weekdayAverage
            ? _value.weekdayAverage
            : weekdayAverage // ignore: cast_nullable_to_non_nullable
                  as double,
        holidayAverage: null == holidayAverage
            ? _value.holidayAverage
            : holidayAverage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumptionPatternImpl implements _ConsumptionPattern {
  const _$ConsumptionPatternImpl({
    this.previousDayUsage,
    this.previousWeekAverage,
    this.previousMonthAverage,
    final List<int> typicalPeakHours = const [],
    final List<int> typicalLowHours = const [],
    this.weekendAverage = 0.0,
    this.weekdayAverage = 0.0,
    this.holidayAverage = 0.0,
  }) : _typicalPeakHours = typicalPeakHours,
       _typicalLowHours = typicalLowHours;

  factory _$ConsumptionPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumptionPatternImplFromJson(json);

  @override
  final double? previousDayUsage;
  @override
  final double? previousWeekAverage;
  @override
  final double? previousMonthAverage;
  final List<int> _typicalPeakHours;
  @override
  @JsonKey()
  List<int> get typicalPeakHours {
    if (_typicalPeakHours is EqualUnmodifiableListView)
      return _typicalPeakHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typicalPeakHours);
  }

  final List<int> _typicalLowHours;
  @override
  @JsonKey()
  List<int> get typicalLowHours {
    if (_typicalLowHours is EqualUnmodifiableListView) return _typicalLowHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typicalLowHours);
  }

  @override
  @JsonKey()
  final double weekendAverage;
  @override
  @JsonKey()
  final double weekdayAverage;
  @override
  @JsonKey()
  final double holidayAverage;

  @override
  String toString() {
    return 'ConsumptionPattern(previousDayUsage: $previousDayUsage, previousWeekAverage: $previousWeekAverage, previousMonthAverage: $previousMonthAverage, typicalPeakHours: $typicalPeakHours, typicalLowHours: $typicalLowHours, weekendAverage: $weekendAverage, weekdayAverage: $weekdayAverage, holidayAverage: $holidayAverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumptionPatternImpl &&
            (identical(other.previousDayUsage, previousDayUsage) ||
                other.previousDayUsage == previousDayUsage) &&
            (identical(other.previousWeekAverage, previousWeekAverage) ||
                other.previousWeekAverage == previousWeekAverage) &&
            (identical(other.previousMonthAverage, previousMonthAverage) ||
                other.previousMonthAverage == previousMonthAverage) &&
            const DeepCollectionEquality().equals(
              other._typicalPeakHours,
              _typicalPeakHours,
            ) &&
            const DeepCollectionEquality().equals(
              other._typicalLowHours,
              _typicalLowHours,
            ) &&
            (identical(other.weekendAverage, weekendAverage) ||
                other.weekendAverage == weekendAverage) &&
            (identical(other.weekdayAverage, weekdayAverage) ||
                other.weekdayAverage == weekdayAverage) &&
            (identical(other.holidayAverage, holidayAverage) ||
                other.holidayAverage == holidayAverage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    previousDayUsage,
    previousWeekAverage,
    previousMonthAverage,
    const DeepCollectionEquality().hash(_typicalPeakHours),
    const DeepCollectionEquality().hash(_typicalLowHours),
    weekendAverage,
    weekdayAverage,
    holidayAverage,
  );

  /// Create a copy of ConsumptionPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumptionPatternImplCopyWith<_$ConsumptionPatternImpl> get copyWith =>
      __$$ConsumptionPatternImplCopyWithImpl<_$ConsumptionPatternImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumptionPatternImplToJson(this);
  }
}

abstract class _ConsumptionPattern implements ConsumptionPattern {
  const factory _ConsumptionPattern({
    final double? previousDayUsage,
    final double? previousWeekAverage,
    final double? previousMonthAverage,
    final List<int> typicalPeakHours,
    final List<int> typicalLowHours,
    final double weekendAverage,
    final double weekdayAverage,
    final double holidayAverage,
  }) = _$ConsumptionPatternImpl;

  factory _ConsumptionPattern.fromJson(Map<String, dynamic> json) =
      _$ConsumptionPatternImpl.fromJson;

  @override
  double? get previousDayUsage;
  @override
  double? get previousWeekAverage;
  @override
  double? get previousMonthAverage;
  @override
  List<int> get typicalPeakHours;
  @override
  List<int> get typicalLowHours;
  @override
  double get weekendAverage;
  @override
  double get weekdayAverage;
  @override
  double get holidayAverage;

  /// Create a copy of ConsumptionPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsumptionPatternImplCopyWith<_$ConsumptionPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsagePattern _$UsagePatternFromJson(Map<String, dynamic> json) {
  return _UsagePattern.fromJson(json);
}

/// @nodoc
mixin _$UsagePattern {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get averageUsage => throw _privateConstructorUsedError;
  double get peakUsage => throw _privateConstructorUsedError;
  double get lowUsage => throw _privateConstructorUsedError;
  List<int> get peakHours => throw _privateConstructorUsedError;
  List<int> get lowHours => throw _privateConstructorUsedError;
  double get efficiencyScore => throw _privateConstructorUsedError;

  /// Serializes this UsagePattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsagePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsagePatternCopyWith<UsagePattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsagePatternCopyWith<$Res> {
  factory $UsagePatternCopyWith(
    UsagePattern value,
    $Res Function(UsagePattern) then,
  ) = _$UsagePatternCopyWithImpl<$Res, UsagePattern>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    double averageUsage,
    double peakUsage,
    double lowUsage,
    List<int> peakHours,
    List<int> lowHours,
    double efficiencyScore,
  });
}

/// @nodoc
class _$UsagePatternCopyWithImpl<$Res, $Val extends UsagePattern>
    implements $UsagePatternCopyWith<$Res> {
  _$UsagePatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsagePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? averageUsage = null,
    Object? peakUsage = null,
    Object? lowUsage = null,
    Object? peakHours = null,
    Object? lowHours = null,
    Object? efficiencyScore = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            averageUsage: null == averageUsage
                ? _value.averageUsage
                : averageUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            peakUsage: null == peakUsage
                ? _value.peakUsage
                : peakUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            lowUsage: null == lowUsage
                ? _value.lowUsage
                : lowUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            peakHours: null == peakHours
                ? _value.peakHours
                : peakHours // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            lowHours: null == lowHours
                ? _value.lowHours
                : lowHours // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            efficiencyScore: null == efficiencyScore
                ? _value.efficiencyScore
                : efficiencyScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsagePatternImplCopyWith<$Res>
    implements $UsagePatternCopyWith<$Res> {
  factory _$$UsagePatternImplCopyWith(
    _$UsagePatternImpl value,
    $Res Function(_$UsagePatternImpl) then,
  ) = __$$UsagePatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    double averageUsage,
    double peakUsage,
    double lowUsage,
    List<int> peakHours,
    List<int> lowHours,
    double efficiencyScore,
  });
}

/// @nodoc
class __$$UsagePatternImplCopyWithImpl<$Res>
    extends _$UsagePatternCopyWithImpl<$Res, _$UsagePatternImpl>
    implements _$$UsagePatternImplCopyWith<$Res> {
  __$$UsagePatternImplCopyWithImpl(
    _$UsagePatternImpl _value,
    $Res Function(_$UsagePatternImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsagePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? averageUsage = null,
    Object? peakUsage = null,
    Object? lowUsage = null,
    Object? peakHours = null,
    Object? lowHours = null,
    Object? efficiencyScore = null,
  }) {
    return _then(
      _$UsagePatternImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        averageUsage: null == averageUsage
            ? _value.averageUsage
            : averageUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        peakUsage: null == peakUsage
            ? _value.peakUsage
            : peakUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        lowUsage: null == lowUsage
            ? _value.lowUsage
            : lowUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        peakHours: null == peakHours
            ? _value._peakHours
            : peakHours // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        lowHours: null == lowHours
            ? _value._lowHours
            : lowHours // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        efficiencyScore: null == efficiencyScore
            ? _value.efficiencyScore
            : efficiencyScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsagePatternImpl implements _UsagePattern {
  const _$UsagePatternImpl({
    required this.id,
    required this.date,
    required this.averageUsage,
    required this.peakUsage,
    required this.lowUsage,
    required final List<int> peakHours,
    required final List<int> lowHours,
    this.efficiencyScore = 0.0,
  }) : _peakHours = peakHours,
       _lowHours = lowHours;

  factory _$UsagePatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsagePatternImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final double averageUsage;
  @override
  final double peakUsage;
  @override
  final double lowUsage;
  final List<int> _peakHours;
  @override
  List<int> get peakHours {
    if (_peakHours is EqualUnmodifiableListView) return _peakHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakHours);
  }

  final List<int> _lowHours;
  @override
  List<int> get lowHours {
    if (_lowHours is EqualUnmodifiableListView) return _lowHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lowHours);
  }

  @override
  @JsonKey()
  final double efficiencyScore;

  @override
  String toString() {
    return 'UsagePattern(id: $id, date: $date, averageUsage: $averageUsage, peakUsage: $peakUsage, lowUsage: $lowUsage, peakHours: $peakHours, lowHours: $lowHours, efficiencyScore: $efficiencyScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsagePatternImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.averageUsage, averageUsage) ||
                other.averageUsage == averageUsage) &&
            (identical(other.peakUsage, peakUsage) ||
                other.peakUsage == peakUsage) &&
            (identical(other.lowUsage, lowUsage) ||
                other.lowUsage == lowUsage) &&
            const DeepCollectionEquality().equals(
              other._peakHours,
              _peakHours,
            ) &&
            const DeepCollectionEquality().equals(other._lowHours, _lowHours) &&
            (identical(other.efficiencyScore, efficiencyScore) ||
                other.efficiencyScore == efficiencyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    averageUsage,
    peakUsage,
    lowUsage,
    const DeepCollectionEquality().hash(_peakHours),
    const DeepCollectionEquality().hash(_lowHours),
    efficiencyScore,
  );

  /// Create a copy of UsagePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsagePatternImplCopyWith<_$UsagePatternImpl> get copyWith =>
      __$$UsagePatternImplCopyWithImpl<_$UsagePatternImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsagePatternImplToJson(this);
  }
}

abstract class _UsagePattern implements UsagePattern {
  const factory _UsagePattern({
    required final String id,
    required final DateTime date,
    required final double averageUsage,
    required final double peakUsage,
    required final double lowUsage,
    required final List<int> peakHours,
    required final List<int> lowHours,
    final double efficiencyScore,
  }) = _$UsagePatternImpl;

  factory _UsagePattern.fromJson(Map<String, dynamic> json) =
      _$UsagePatternImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  double get averageUsage;
  @override
  double get peakUsage;
  @override
  double get lowUsage;
  @override
  List<int> get peakHours;
  @override
  List<int> get lowHours;
  @override
  double get efficiencyScore;

  /// Create a copy of UsagePattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsagePatternImplCopyWith<_$UsagePatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnomalyDetection _$AnomalyDetectionFromJson(Map<String, dynamic> json) {
  return _AnomalyDetection.fromJson(json);
}

/// @nodoc
mixin _$AnomalyDetection {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  AnomalyType get type => throw _privateConstructorUsedError;
  double get expectedValue => throw _privateConstructorUsedError;
  double get actualValue => throw _privateConstructorUsedError;
  double get deviationPercentage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isResolved => throw _privateConstructorUsedError;

  /// Serializes this AnomalyDetection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnomalyDetection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnomalyDetectionCopyWith<AnomalyDetection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnomalyDetectionCopyWith<$Res> {
  factory $AnomalyDetectionCopyWith(
    AnomalyDetection value,
    $Res Function(AnomalyDetection) then,
  ) = _$AnomalyDetectionCopyWithImpl<$Res, AnomalyDetection>;
  @useResult
  $Res call({
    String id,
    DateTime timestamp,
    AnomalyType type,
    double expectedValue,
    double actualValue,
    double deviationPercentage,
    String description,
    bool isResolved,
  });
}

/// @nodoc
class _$AnomalyDetectionCopyWithImpl<$Res, $Val extends AnomalyDetection>
    implements $AnomalyDetectionCopyWith<$Res> {
  _$AnomalyDetectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnomalyDetection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? expectedValue = null,
    Object? actualValue = null,
    Object? deviationPercentage = null,
    Object? description = null,
    Object? isResolved = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AnomalyType,
            expectedValue: null == expectedValue
                ? _value.expectedValue
                : expectedValue // ignore: cast_nullable_to_non_nullable
                      as double,
            actualValue: null == actualValue
                ? _value.actualValue
                : actualValue // ignore: cast_nullable_to_non_nullable
                      as double,
            deviationPercentage: null == deviationPercentage
                ? _value.deviationPercentage
                : deviationPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isResolved: null == isResolved
                ? _value.isResolved
                : isResolved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnomalyDetectionImplCopyWith<$Res>
    implements $AnomalyDetectionCopyWith<$Res> {
  factory _$$AnomalyDetectionImplCopyWith(
    _$AnomalyDetectionImpl value,
    $Res Function(_$AnomalyDetectionImpl) then,
  ) = __$$AnomalyDetectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime timestamp,
    AnomalyType type,
    double expectedValue,
    double actualValue,
    double deviationPercentage,
    String description,
    bool isResolved,
  });
}

/// @nodoc
class __$$AnomalyDetectionImplCopyWithImpl<$Res>
    extends _$AnomalyDetectionCopyWithImpl<$Res, _$AnomalyDetectionImpl>
    implements _$$AnomalyDetectionImplCopyWith<$Res> {
  __$$AnomalyDetectionImplCopyWithImpl(
    _$AnomalyDetectionImpl _value,
    $Res Function(_$AnomalyDetectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnomalyDetection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? expectedValue = null,
    Object? actualValue = null,
    Object? deviationPercentage = null,
    Object? description = null,
    Object? isResolved = null,
  }) {
    return _then(
      _$AnomalyDetectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AnomalyType,
        expectedValue: null == expectedValue
            ? _value.expectedValue
            : expectedValue // ignore: cast_nullable_to_non_nullable
                  as double,
        actualValue: null == actualValue
            ? _value.actualValue
            : actualValue // ignore: cast_nullable_to_non_nullable
                  as double,
        deviationPercentage: null == deviationPercentage
            ? _value.deviationPercentage
            : deviationPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isResolved: null == isResolved
            ? _value.isResolved
            : isResolved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnomalyDetectionImpl implements _AnomalyDetection {
  const _$AnomalyDetectionImpl({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.expectedValue,
    required this.actualValue,
    required this.deviationPercentage,
    required this.description,
    this.isResolved = false,
  });

  factory _$AnomalyDetectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnomalyDetectionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final AnomalyType type;
  @override
  final double expectedValue;
  @override
  final double actualValue;
  @override
  final double deviationPercentage;
  @override
  final String description;
  @override
  @JsonKey()
  final bool isResolved;

  @override
  String toString() {
    return 'AnomalyDetection(id: $id, timestamp: $timestamp, type: $type, expectedValue: $expectedValue, actualValue: $actualValue, deviationPercentage: $deviationPercentage, description: $description, isResolved: $isResolved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnomalyDetectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.expectedValue, expectedValue) ||
                other.expectedValue == expectedValue) &&
            (identical(other.actualValue, actualValue) ||
                other.actualValue == actualValue) &&
            (identical(other.deviationPercentage, deviationPercentage) ||
                other.deviationPercentage == deviationPercentage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isResolved, isResolved) ||
                other.isResolved == isResolved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    timestamp,
    type,
    expectedValue,
    actualValue,
    deviationPercentage,
    description,
    isResolved,
  );

  /// Create a copy of AnomalyDetection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnomalyDetectionImplCopyWith<_$AnomalyDetectionImpl> get copyWith =>
      __$$AnomalyDetectionImplCopyWithImpl<_$AnomalyDetectionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnomalyDetectionImplToJson(this);
  }
}

abstract class _AnomalyDetection implements AnomalyDetection {
  const factory _AnomalyDetection({
    required final String id,
    required final DateTime timestamp,
    required final AnomalyType type,
    required final double expectedValue,
    required final double actualValue,
    required final double deviationPercentage,
    required final String description,
    final bool isResolved,
  }) = _$AnomalyDetectionImpl;

  factory _AnomalyDetection.fromJson(Map<String, dynamic> json) =
      _$AnomalyDetectionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  AnomalyType get type;
  @override
  double get expectedValue;
  @override
  double get actualValue;
  @override
  double get deviationPercentage;
  @override
  String get description;
  @override
  bool get isResolved;

  /// Create a copy of AnomalyDetection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnomalyDetectionImplCopyWith<_$AnomalyDetectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EnergySavingTip _$EnergySavingTipFromJson(Map<String, dynamic> json) {
  return _EnergySavingTip.fromJson(json);
}

/// @nodoc
mixin _$EnergySavingTip {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  TipCategory get category => throw _privateConstructorUsedError;
  double get potentialSavings => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this EnergySavingTip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnergySavingTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnergySavingTipCopyWith<EnergySavingTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnergySavingTipCopyWith<$Res> {
  factory $EnergySavingTipCopyWith(
    EnergySavingTip value,
    $Res Function(EnergySavingTip) then,
  ) = _$EnergySavingTipCopyWithImpl<$Res, EnergySavingTip>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    TipCategory category,
    double potentialSavings,
    String difficulty,
    List<String> tags,
  });
}

/// @nodoc
class _$EnergySavingTipCopyWithImpl<$Res, $Val extends EnergySavingTip>
    implements $EnergySavingTipCopyWith<$Res> {
  _$EnergySavingTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnergySavingTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as TipCategory,
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
abstract class _$$EnergySavingTipImplCopyWith<$Res>
    implements $EnergySavingTipCopyWith<$Res> {
  factory _$$EnergySavingTipImplCopyWith(
    _$EnergySavingTipImpl value,
    $Res Function(_$EnergySavingTipImpl) then,
  ) = __$$EnergySavingTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    TipCategory category,
    double potentialSavings,
    String difficulty,
    List<String> tags,
  });
}

/// @nodoc
class __$$EnergySavingTipImplCopyWithImpl<$Res>
    extends _$EnergySavingTipCopyWithImpl<$Res, _$EnergySavingTipImpl>
    implements _$$EnergySavingTipImplCopyWith<$Res> {
  __$$EnergySavingTipImplCopyWithImpl(
    _$EnergySavingTipImpl _value,
    $Res Function(_$EnergySavingTipImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EnergySavingTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? potentialSavings = null,
    Object? difficulty = null,
    Object? tags = null,
  }) {
    return _then(
      _$EnergySavingTipImpl(
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
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as TipCategory,
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
class _$EnergySavingTipImpl implements _EnergySavingTip {
  const _$EnergySavingTipImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.potentialSavings,
    required this.difficulty,
    final List<String> tags = const [],
  }) : _tags = tags;

  factory _$EnergySavingTipImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnergySavingTipImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final TipCategory category;
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
    return 'EnergySavingTip(id: $id, title: $title, description: $description, category: $category, potentialSavings: $potentialSavings, difficulty: $difficulty, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnergySavingTipImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
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
    category,
    potentialSavings,
    difficulty,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of EnergySavingTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnergySavingTipImplCopyWith<_$EnergySavingTipImpl> get copyWith =>
      __$$EnergySavingTipImplCopyWithImpl<_$EnergySavingTipImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EnergySavingTipImplToJson(this);
  }
}

abstract class _EnergySavingTip implements EnergySavingTip {
  const factory _EnergySavingTip({
    required final String id,
    required final String title,
    required final String description,
    required final TipCategory category,
    required final double potentialSavings,
    required final String difficulty,
    final List<String> tags,
  }) = _$EnergySavingTipImpl;

  factory _EnergySavingTip.fromJson(Map<String, dynamic> json) =
      _$EnergySavingTipImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  TipCategory get category;
  @override
  double get potentialSavings;
  @override
  String get difficulty;
  @override
  List<String> get tags;

  /// Create a copy of EnergySavingTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnergySavingTipImplCopyWith<_$EnergySavingTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsumptionForecast _$ConsumptionForecastFromJson(Map<String, dynamic> json) {
  return _ConsumptionForecast.fromJson(json);
}

/// @nodoc
mixin _$ConsumptionForecast {
  List<ForecastData> get dailyForecast => throw _privateConstructorUsedError;
  List<ForecastData> get weeklyForecast => throw _privateConstructorUsedError;
  List<ForecastData> get monthlyForecast => throw _privateConstructorUsedError;
  double get predictedNextMonthUsage => throw _privateConstructorUsedError;
  double get predictedNextMonthCost => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;

  /// Serializes this ConsumptionForecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsumptionForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsumptionForecastCopyWith<ConsumptionForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumptionForecastCopyWith<$Res> {
  factory $ConsumptionForecastCopyWith(
    ConsumptionForecast value,
    $Res Function(ConsumptionForecast) then,
  ) = _$ConsumptionForecastCopyWithImpl<$Res, ConsumptionForecast>;
  @useResult
  $Res call({
    List<ForecastData> dailyForecast,
    List<ForecastData> weeklyForecast,
    List<ForecastData> monthlyForecast,
    double predictedNextMonthUsage,
    double predictedNextMonthCost,
    double confidenceScore,
  });
}

/// @nodoc
class _$ConsumptionForecastCopyWithImpl<$Res, $Val extends ConsumptionForecast>
    implements $ConsumptionForecastCopyWith<$Res> {
  _$ConsumptionForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsumptionForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyForecast = null,
    Object? weeklyForecast = null,
    Object? monthlyForecast = null,
    Object? predictedNextMonthUsage = null,
    Object? predictedNextMonthCost = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _value.copyWith(
            dailyForecast: null == dailyForecast
                ? _value.dailyForecast
                : dailyForecast // ignore: cast_nullable_to_non_nullable
                      as List<ForecastData>,
            weeklyForecast: null == weeklyForecast
                ? _value.weeklyForecast
                : weeklyForecast // ignore: cast_nullable_to_non_nullable
                      as List<ForecastData>,
            monthlyForecast: null == monthlyForecast
                ? _value.monthlyForecast
                : monthlyForecast // ignore: cast_nullable_to_non_nullable
                      as List<ForecastData>,
            predictedNextMonthUsage: null == predictedNextMonthUsage
                ? _value.predictedNextMonthUsage
                : predictedNextMonthUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            predictedNextMonthCost: null == predictedNextMonthCost
                ? _value.predictedNextMonthCost
                : predictedNextMonthCost // ignore: cast_nullable_to_non_nullable
                      as double,
            confidenceScore: null == confidenceScore
                ? _value.confidenceScore
                : confidenceScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsumptionForecastImplCopyWith<$Res>
    implements $ConsumptionForecastCopyWith<$Res> {
  factory _$$ConsumptionForecastImplCopyWith(
    _$ConsumptionForecastImpl value,
    $Res Function(_$ConsumptionForecastImpl) then,
  ) = __$$ConsumptionForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ForecastData> dailyForecast,
    List<ForecastData> weeklyForecast,
    List<ForecastData> monthlyForecast,
    double predictedNextMonthUsage,
    double predictedNextMonthCost,
    double confidenceScore,
  });
}

/// @nodoc
class __$$ConsumptionForecastImplCopyWithImpl<$Res>
    extends _$ConsumptionForecastCopyWithImpl<$Res, _$ConsumptionForecastImpl>
    implements _$$ConsumptionForecastImplCopyWith<$Res> {
  __$$ConsumptionForecastImplCopyWithImpl(
    _$ConsumptionForecastImpl _value,
    $Res Function(_$ConsumptionForecastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConsumptionForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyForecast = null,
    Object? weeklyForecast = null,
    Object? monthlyForecast = null,
    Object? predictedNextMonthUsage = null,
    Object? predictedNextMonthCost = null,
    Object? confidenceScore = null,
  }) {
    return _then(
      _$ConsumptionForecastImpl(
        dailyForecast: null == dailyForecast
            ? _value._dailyForecast
            : dailyForecast // ignore: cast_nullable_to_non_nullable
                  as List<ForecastData>,
        weeklyForecast: null == weeklyForecast
            ? _value._weeklyForecast
            : weeklyForecast // ignore: cast_nullable_to_non_nullable
                  as List<ForecastData>,
        monthlyForecast: null == monthlyForecast
            ? _value._monthlyForecast
            : monthlyForecast // ignore: cast_nullable_to_non_nullable
                  as List<ForecastData>,
        predictedNextMonthUsage: null == predictedNextMonthUsage
            ? _value.predictedNextMonthUsage
            : predictedNextMonthUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        predictedNextMonthCost: null == predictedNextMonthCost
            ? _value.predictedNextMonthCost
            : predictedNextMonthCost // ignore: cast_nullable_to_non_nullable
                  as double,
        confidenceScore: null == confidenceScore
            ? _value.confidenceScore
            : confidenceScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumptionForecastImpl implements _ConsumptionForecast {
  const _$ConsumptionForecastImpl({
    final List<ForecastData> dailyForecast = const [],
    final List<ForecastData> weeklyForecast = const [],
    final List<ForecastData> monthlyForecast = const [],
    this.predictedNextMonthUsage = 0.0,
    this.predictedNextMonthCost = 0.0,
    this.confidenceScore = 0.0,
  }) : _dailyForecast = dailyForecast,
       _weeklyForecast = weeklyForecast,
       _monthlyForecast = monthlyForecast;

  factory _$ConsumptionForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumptionForecastImplFromJson(json);

  final List<ForecastData> _dailyForecast;
  @override
  @JsonKey()
  List<ForecastData> get dailyForecast {
    if (_dailyForecast is EqualUnmodifiableListView) return _dailyForecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyForecast);
  }

  final List<ForecastData> _weeklyForecast;
  @override
  @JsonKey()
  List<ForecastData> get weeklyForecast {
    if (_weeklyForecast is EqualUnmodifiableListView) return _weeklyForecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyForecast);
  }

  final List<ForecastData> _monthlyForecast;
  @override
  @JsonKey()
  List<ForecastData> get monthlyForecast {
    if (_monthlyForecast is EqualUnmodifiableListView) return _monthlyForecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyForecast);
  }

  @override
  @JsonKey()
  final double predictedNextMonthUsage;
  @override
  @JsonKey()
  final double predictedNextMonthCost;
  @override
  @JsonKey()
  final double confidenceScore;

  @override
  String toString() {
    return 'ConsumptionForecast(dailyForecast: $dailyForecast, weeklyForecast: $weeklyForecast, monthlyForecast: $monthlyForecast, predictedNextMonthUsage: $predictedNextMonthUsage, predictedNextMonthCost: $predictedNextMonthCost, confidenceScore: $confidenceScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumptionForecastImpl &&
            const DeepCollectionEquality().equals(
              other._dailyForecast,
              _dailyForecast,
            ) &&
            const DeepCollectionEquality().equals(
              other._weeklyForecast,
              _weeklyForecast,
            ) &&
            const DeepCollectionEquality().equals(
              other._monthlyForecast,
              _monthlyForecast,
            ) &&
            (identical(
                  other.predictedNextMonthUsage,
                  predictedNextMonthUsage,
                ) ||
                other.predictedNextMonthUsage == predictedNextMonthUsage) &&
            (identical(other.predictedNextMonthCost, predictedNextMonthCost) ||
                other.predictedNextMonthCost == predictedNextMonthCost) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyForecast),
    const DeepCollectionEquality().hash(_weeklyForecast),
    const DeepCollectionEquality().hash(_monthlyForecast),
    predictedNextMonthUsage,
    predictedNextMonthCost,
    confidenceScore,
  );

  /// Create a copy of ConsumptionForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumptionForecastImplCopyWith<_$ConsumptionForecastImpl> get copyWith =>
      __$$ConsumptionForecastImplCopyWithImpl<_$ConsumptionForecastImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumptionForecastImplToJson(this);
  }
}

abstract class _ConsumptionForecast implements ConsumptionForecast {
  const factory _ConsumptionForecast({
    final List<ForecastData> dailyForecast,
    final List<ForecastData> weeklyForecast,
    final List<ForecastData> monthlyForecast,
    final double predictedNextMonthUsage,
    final double predictedNextMonthCost,
    final double confidenceScore,
  }) = _$ConsumptionForecastImpl;

  factory _ConsumptionForecast.fromJson(Map<String, dynamic> json) =
      _$ConsumptionForecastImpl.fromJson;

  @override
  List<ForecastData> get dailyForecast;
  @override
  List<ForecastData> get weeklyForecast;
  @override
  List<ForecastData> get monthlyForecast;
  @override
  double get predictedNextMonthUsage;
  @override
  double get predictedNextMonthCost;
  @override
  double get confidenceScore;

  /// Create a copy of ConsumptionForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsumptionForecastImplCopyWith<_$ConsumptionForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForecastData _$ForecastDataFromJson(Map<String, dynamic> json) {
  return _ForecastData.fromJson(json);
}

/// @nodoc
mixin _$ForecastData {
  DateTime get date => throw _privateConstructorUsedError;
  double get predictedUsage => throw _privateConstructorUsedError;
  double get predictedCost => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  List<double> get confidenceInterval => throw _privateConstructorUsedError;

  /// Serializes this ForecastData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForecastData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForecastDataCopyWith<ForecastData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForecastDataCopyWith<$Res> {
  factory $ForecastDataCopyWith(
    ForecastData value,
    $Res Function(ForecastData) then,
  ) = _$ForecastDataCopyWithImpl<$Res, ForecastData>;
  @useResult
  $Res call({
    DateTime date,
    double predictedUsage,
    double predictedCost,
    double confidence,
    List<double> confidenceInterval,
  });
}

/// @nodoc
class _$ForecastDataCopyWithImpl<$Res, $Val extends ForecastData>
    implements $ForecastDataCopyWith<$Res> {
  _$ForecastDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForecastData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predictedUsage = null,
    Object? predictedCost = null,
    Object? confidence = null,
    Object? confidenceInterval = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            predictedUsage: null == predictedUsage
                ? _value.predictedUsage
                : predictedUsage // ignore: cast_nullable_to_non_nullable
                      as double,
            predictedCost: null == predictedCost
                ? _value.predictedCost
                : predictedCost // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            confidenceInterval: null == confidenceInterval
                ? _value.confidenceInterval
                : confidenceInterval // ignore: cast_nullable_to_non_nullable
                      as List<double>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForecastDataImplCopyWith<$Res>
    implements $ForecastDataCopyWith<$Res> {
  factory _$$ForecastDataImplCopyWith(
    _$ForecastDataImpl value,
    $Res Function(_$ForecastDataImpl) then,
  ) = __$$ForecastDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    double predictedUsage,
    double predictedCost,
    double confidence,
    List<double> confidenceInterval,
  });
}

/// @nodoc
class __$$ForecastDataImplCopyWithImpl<$Res>
    extends _$ForecastDataCopyWithImpl<$Res, _$ForecastDataImpl>
    implements _$$ForecastDataImplCopyWith<$Res> {
  __$$ForecastDataImplCopyWithImpl(
    _$ForecastDataImpl _value,
    $Res Function(_$ForecastDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForecastData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? predictedUsage = null,
    Object? predictedCost = null,
    Object? confidence = null,
    Object? confidenceInterval = null,
  }) {
    return _then(
      _$ForecastDataImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        predictedUsage: null == predictedUsage
            ? _value.predictedUsage
            : predictedUsage // ignore: cast_nullable_to_non_nullable
                  as double,
        predictedCost: null == predictedCost
            ? _value.predictedCost
            : predictedCost // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        confidenceInterval: null == confidenceInterval
            ? _value._confidenceInterval
            : confidenceInterval // ignore: cast_nullable_to_non_nullable
                  as List<double>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForecastDataImpl implements _ForecastData {
  const _$ForecastDataImpl({
    required this.date,
    required this.predictedUsage,
    required this.predictedCost,
    this.confidence = 0.0,
    final List<double> confidenceInterval = const [],
  }) : _confidenceInterval = confidenceInterval;

  factory _$ForecastDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForecastDataImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double predictedUsage;
  @override
  final double predictedCost;
  @override
  @JsonKey()
  final double confidence;
  final List<double> _confidenceInterval;
  @override
  @JsonKey()
  List<double> get confidenceInterval {
    if (_confidenceInterval is EqualUnmodifiableListView)
      return _confidenceInterval;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_confidenceInterval);
  }

  @override
  String toString() {
    return 'ForecastData(date: $date, predictedUsage: $predictedUsage, predictedCost: $predictedCost, confidence: $confidence, confidenceInterval: $confidenceInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForecastDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.predictedUsage, predictedUsage) ||
                other.predictedUsage == predictedUsage) &&
            (identical(other.predictedCost, predictedCost) ||
                other.predictedCost == predictedCost) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(
              other._confidenceInterval,
              _confidenceInterval,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    predictedUsage,
    predictedCost,
    confidence,
    const DeepCollectionEquality().hash(_confidenceInterval),
  );

  /// Create a copy of ForecastData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForecastDataImplCopyWith<_$ForecastDataImpl> get copyWith =>
      __$$ForecastDataImplCopyWithImpl<_$ForecastDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForecastDataImplToJson(this);
  }
}

abstract class _ForecastData implements ForecastData {
  const factory _ForecastData({
    required final DateTime date,
    required final double predictedUsage,
    required final double predictedCost,
    final double confidence,
    final List<double> confidenceInterval,
  }) = _$ForecastDataImpl;

  factory _ForecastData.fromJson(Map<String, dynamic> json) =
      _$ForecastDataImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get predictedUsage;
  @override
  double get predictedCost;
  @override
  double get confidence;
  @override
  List<double> get confidenceInterval;

  /// Create a copy of ForecastData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForecastDataImplCopyWith<_$ForecastDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
