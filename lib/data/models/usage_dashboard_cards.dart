/// Response models for GET /AMI/UsageDashboardCards.
///
/// Property names match the server `UsageDashboardCardsResult` /
/// `BilledPeriodSummary` classes. Parsing accepts both camelCase and
/// PascalCase so either Newtonsoft setting works.
library;

/// One billed period row from `spGetUsageDashboardCardsTemp`.
///
/// Drives the details dialog when the user taps More on a dashboard card.
class BilledPeriodSummary {
  const BilledPeriodSummary({
    this.periodId = '',
    this.startDate,
    this.endDate,
    this.label = '',
    this.rangeLabel = '',
    this.days = 0,
    this.billedKWh = 0,
    this.previousReading = 0,
    this.currentReading = 0,
    this.readStatus = '',
    this.readStatusDescription = '',
    this.isPeak = false,
  });

  factory BilledPeriodSummary.fromJson(Map<String, dynamic> json) =>
      BilledPeriodSummary(
        periodId: _asString(json, const ['periodId', 'PeriodId']),
        startDate: _asDate(json, const ['startDate', 'StartDate']),
        endDate: _asDate(json, const ['endDate', 'EndDate']),
        label: _asString(json, const ['label', 'Label']),
        rangeLabel: _asString(json, const ['rangeLabel', 'RangeLabel']),
        days: _asInt(json, const ['days', 'Days']),
        billedKWh: _asDouble(json, const ['billedKWh', 'BilledKWh', 'billedKwh']),
        previousReading:
            _asDouble(json, const ['previousReading', 'PreviousReading']),
        currentReading:
            _asDouble(json, const ['currentReading', 'CurrentReading']),
        readStatus: _asString(json, const ['readStatus', 'ReadStatus']),
        readStatusDescription: _asString(
          json,
          const ['readStatusDescription', 'ReadStatusDescription'],
        ),
        isPeak: _asBool(json, const ['isPeak', 'IsPeak']),
      );

  final String periodId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String label;
  final String rangeLabel;
  final int days;
  final double billedKWh;
  final double previousReading;
  final double currentReading;
  final String readStatus;
  final String readStatusDescription;
  final bool isPeak;
}

/// Full payload for the four AMI dashboard cards plus billed-period details.
class UsageDashboardCardsResult {
  const UsageDashboardCardsResult({
    this.currentPeriodKWh = 0,
    this.currentStartDate,
    this.currentEndDate,
    this.currentPeriodLabel = '',
    this.daysElapsed = 0,
    this.daysInPeriod = 0,
    this.previousPeriodToDateKWh = 0,
    this.varianceKWh = 0,
    this.comparisonLabel = '',
    this.peakBilledKWh = 0,
    this.peakPeriodLabel = '',
    this.avgBilledKWh = 0,
    this.avgRangeLabel = '',
    this.periodsAnalyzed = 0,
    this.billedPeriods = const [],
    this.errorCode = 0,
    this.errorMessage = '',
  });

  const UsageDashboardCardsResult.empty() : this();

  factory UsageDashboardCardsResult.fromJson(Map<String, dynamic> json) {
    final payload = _unwrapPayload(json);
    return UsageDashboardCardsResult(
      currentPeriodKWh: _asDouble(
        payload,
        const ['currentPeriodKWh', 'CurrentPeriodKWh', 'currentPeriodKwh'],
      ),
      currentStartDate:
          _asDate(payload, const ['currentStartDate', 'CurrentStartDate']),
      currentEndDate:
          _asDate(payload, const ['currentEndDate', 'CurrentEndDate']),
      currentPeriodLabel: _asString(
        payload,
        const ['currentPeriodLabel', 'CurrentPeriodLabel'],
      ),
      daysElapsed: _asInt(payload, const ['daysElapsed', 'DaysElapsed']),
      daysInPeriod: _asInt(payload, const ['daysInPeriod', 'DaysInPeriod']),
      previousPeriodToDateKWh: _asDouble(
        payload,
        const [
          'previousPeriodToDateKWh',
          'PreviousPeriodToDateKWh',
          'previousPeriodToDateKwh',
        ],
      ),
      varianceKWh: _asDouble(
        payload,
        const ['varianceKWh', 'VarianceKWh', 'varianceKwh'],
      ),
      comparisonLabel:
          _asString(payload, const ['comparisonLabel', 'ComparisonLabel']),
      peakBilledKWh: _asDouble(
        payload,
        const ['peakBilledKWh', 'PeakBilledKWh', 'peakBilledKwh'],
      ),
      peakPeriodLabel:
          _asString(payload, const ['peakPeriodLabel', 'PeakPeriodLabel']),
      avgBilledKWh: _asDouble(
        payload,
        const ['avgBilledKWh', 'AvgBilledKWh', 'avgBilledKwh'],
      ),
      avgRangeLabel:
          _asString(payload, const ['avgRangeLabel', 'AvgRangeLabel']),
      periodsAnalyzed:
          _asInt(payload, const ['periodsAnalyzed', 'PeriodsAnalyzed']),
      billedPeriods: _asList(
        payload,
        const ['billedPeriods', 'BilledPeriods'],
      ).map(BilledPeriodSummary.fromJson).toList(),
      errorCode: _asInt(payload, const ['errorCode', 'ErrorCode']),
      errorMessage: _asString(
        payload,
        const ['errorMessage', 'ErrorMessage', 'strErrorMsg'],
      ),
    );
  }

  /// Card 1 — This Billing Period
  final double currentPeriodKWh;
  final DateTime? currentStartDate;
  final DateTime? currentEndDate;
  final String currentPeriodLabel;
  final int daysElapsed;
  final int daysInPeriod;

  /// Card 2 — vs Previous Billing Period (elapsed-days matched)
  final double previousPeriodToDateKWh;
  final double varianceKWh;
  final String comparisonLabel;

  /// Card 3 — Peak Billing Period
  final double peakBilledKWh;
  final String peakPeriodLabel;

  /// Card 4 — Average Usage
  final double avgBilledKWh;
  final String avgRangeLabel;
  final int periodsAnalyzed;

  /// Billed-period rows for the More dialog, newest first.
  final List<BilledPeriodSummary> billedPeriods;
  final int errorCode;
  final String errorMessage;

  bool get hasError => errorCode != 0;

  /// Current period used more than the matched previous-period window.
  bool get usedMoreThanPrevious => varianceKWh > 0;

  bool get usedLessThanPrevious => varianceKWh < 0;

  double get currentDailyAverageKWh =>
      daysElapsed <= 0 ? 0 : currentPeriodKWh / daysElapsed;

  bool get hasCurrentPeriod =>
      currentPeriodLabel.isNotEmpty ||
      daysElapsed > 0 ||
      currentPeriodKWh > 0;

  bool get hasPreviousComparison =>
      comparisonLabel.isNotEmpty || previousPeriodToDateKWh > 0;

  bool get hasPeakPeriod =>
      peakPeriodLabel.isNotEmpty || peakBilledKWh > 0;

  bool get hasAverageUsage => periodsAnalyzed > 0 || avgBilledKWh > 0;

  bool get hasUsageData =>
      !hasError &&
      (hasCurrentPeriod ||
          hasPreviousComparison ||
          hasPeakPeriod ||
          hasAverageUsage ||
          billedPeriods.isNotEmpty);
}

Map<String, dynamic> _unwrapPayload(Map<String, dynamic> json) {
  if (_looksLikeDashboardPayload(json)) return json;

  for (final key in const ['data', 'Data', 'result', 'Result']) {
    final nested = json[key];
    if (nested is Map) {
      final map = nested.map((k, v) => MapEntry(k.toString(), v));
      if (_looksLikeDashboardPayload(map) || nested.isNotEmpty) {
        return Map<String, dynamic>.from(map);
      }
    }
  }
  return json;
}

bool _looksLikeDashboardPayload(Map<String, dynamic> json) {
  final keys = json.keys.map((k) => k.toLowerCase()).toSet();
  return keys.contains('currentperiodkwh') ||
      keys.contains('billedperiods') ||
      keys.contains('peakbilledkwh') ||
      keys.contains('avgbilledkwh');
}

dynamic _raw(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    if (json.containsKey(key) && json[key] != null) return json[key];
  }
  final lower = {
    for (final entry in json.entries) entry.key.toLowerCase(): entry.value,
  };
  for (final key in keys) {
    final value = lower[key.toLowerCase()];
    if (value != null) return value;
  }
  return null;
}

String _asString(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value == null) return '';
  return value.toString();
}

int _asInt(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double _asDouble(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

bool _asBool(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
  }
  return false;
}

DateTime? _asDate(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return DateTime.tryParse(trimmed.replaceFirst(' ', 'T'));
  }
  return null;
}

List<Map<String, dynamic>> _asList(Map<String, dynamic> json, List<String> keys) {
  final value = _raw(json, keys);
  if (value is! List) return const [];
  return value
      .whereType<Object?>()
      .map((item) {
        if (item is Map<String, dynamic>) return item;
        if (item is Map) {
          return item.map((k, v) => MapEntry(k.toString(), v));
        }
        return null;
      })
      .whereType<Map<String, dynamic>>()
      .toList();
}
