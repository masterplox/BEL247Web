import 'api_response_dtos.dart';

/// One day from `DailyRangeBucket`, including time-of-use splits.
class DailyBucketRow {
  const DailyBucketRow({
    required this.usageDate,
    required this.dailyUsageKwh,
    this.offPeakKwh = 0,
    this.peakKwh = 0,
    this.midPeakKwh = 0,
  });

  final String usageDate;
  final double dailyUsageKwh;
  final double offPeakKwh;
  final double peakKwh;
  final double midPeakKwh;

  DailyUsageEntryDto toDto() => DailyUsageEntryDto(
        usageDate: usageDate,
        dailyUsageKwh: dailyUsageKwh,
      );
}

/// Payload-level totals from DailyRangeBucket / MonthlyTotalsBucket.
class AmiBucketSummary {
  const AmiBucketSummary({
    this.totalKwh,
    this.avgKwh,
    this.peakKwh,
    this.peakDate,
    this.peakMonth,
  });

  final double? totalKwh;
  final double? avgKwh;
  final double? peakKwh;
  final DateTime? peakDate;
  final int? peakMonth;
}

/// Parsed DailyRangeBucket: per-day rows plus the endpoint summary fields.
class DailyRangeResult {
  const DailyRangeResult({
    this.days = const [],
    this.summary = const AmiBucketSummary(),
  });

  final List<DailyBucketRow> days;
  final AmiBucketSummary summary;
}

/// Parsed MonthlyTotalsBucket: per-month rows plus the endpoint summary fields.
class MonthlyTotalsResult {
  const MonthlyTotalsResult({
    this.months = const [],
    this.summary = const AmiBucketSummary(),
  });

  final List<MonthlyBucketRow> months;
  final AmiBucketSummary summary;
}

/// One month from `MonthlyTotalsBucket`, including time-of-use splits.
class MonthlyBucketRow {
  const MonthlyBucketRow({
    required this.year,
    required this.month,
    required this.monthlyUsageKwh,
    this.offPeakKwh = 0,
    this.peakKwh = 0,
    this.midPeakKwh = 0,
  });

  final int year;
  final int month;
  final double monthlyUsageKwh;
  final double offPeakKwh;
  final double peakKwh;
  final double midPeakKwh;

  MonthlyUsageEntryDto toDto() => MonthlyUsageEntryDto(
        year: year,
        month: month,
        monthlyUsageKwh: monthlyUsageKwh,
      );
}

/// Parses AMI bucket endpoints (`DailyIntervalsBucket`, `DailyRangeBucket`,
/// `MonthlyTotalsBucket`). Those payloads use different list keys and field
/// names than the older `data` / `dailyUsageKwh` / `month` mock shape, and
/// some rows arrive with placeholder dates (`0001-01-01`) or `monthNumber: 0`.
class AmiBucketParser {
  const AmiBucketParser._();

  static List<IntervalUsageEntryDto> parseIntervals(
    dynamic json, {
    required String meterId,
    required DateTime targetDate,
  }) {
    final rows = extractList(json);
    final dateStr = _dateOnly(targetDate);
    final entries = <IntervalUsageEntryDto>[];
    for (final row in rows) {
      final entry = _parseIntervalRow(
        row,
        meterId: meterId,
        dateStr: dateStr,
      );
      if (entry != null) entries.add(entry);
    }
    return entries;
  }

  static DailyRangeResult parseDailyRange(
    dynamic json, {
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final payload = _asStringMap(json) ?? const <String, dynamic>{};
    final rows = extractList(json);
    if (rows.isEmpty) return const DailyRangeResult();

    final peakDate = _tryParseDate(
      _readString(payload, const ['peakDate', 'PeakDate']),
    );
    final peakKwh = _readDouble(payload, const [
      'peakKWh',
      'PeakKWh',
      'peakKwh',
      'statsPeakKWh',
    ]);
    final inferredDates = _inferDailyDates(
      rows: rows,
      startDate: startDate,
      endDate: endDate,
      peakDate: peakDate,
      peakKwh: peakKwh,
    );

    final entries = <DailyBucketRow>[];
    for (var i = 0; i < rows.length; i++) {
      final kwh = _readDouble(rows[i], const [
        'dailyKWh',
        'DailyKWh',
        'dailyUsageKwh',
        'DailyUsageKwh',
        'kWh',
        'KWh',
        'usageKwh',
      ]);
      if (kwh == null) continue;
      entries.add(
        DailyBucketRow(
          usageDate: inferredDates[i],
          dailyUsageKwh: kwh,
          offPeakKwh: _readDouble(rows[i], const [
                'offPeakKWh',
                'OffPeakKWh',
                'offPeakKwh',
              ]) ??
              0,
          peakKwh: _readDouble(rows[i], const [
                'peakKWh',
                'PeakKWh',
                'peakKwh',
              ]) ??
              0,
          midPeakKwh: _readDouble(rows[i], const [
                'midPeakKWh',
                'MidPeakKWh',
                'midPeakKwh',
              ]) ??
              0,
        ),
      );
    }
    return DailyRangeResult(
      days: entries,
      summary: _parseSummary(payload),
    );
  }

  static MonthlyTotalsResult parseMonthlyTotals(
    dynamic json, {
    required int year,
  }) {
    final payload = _asStringMap(json) ?? const <String, dynamic>{};
    final rows = extractList(json);
    if (rows.isEmpty) return const MonthlyTotalsResult();

    final peakMonth = _readInt(payload, const ['peakMonth', 'PeakMonth']);
    final peakKwh = _readDouble(payload, const [
      'peakKWh',
      'PeakKWh',
      'peakKwh',
    ]);
    final inferredMonths = _inferMonths(
      rows: rows,
      peakMonth: peakMonth,
      peakKwh: peakKwh,
    );

    final entries = <MonthlyBucketRow>[];
    for (var i = 0; i < rows.length; i++) {
      final month = inferredMonths[i];
      final kwh = _readDouble(rows[i], const [
        'monthlyKWh',
        'MonthlyKWh',
        'monthlyUsageKwh',
        'MonthlyUsageKwh',
        'kWh',
        'KWh',
        'usageKwh',
        'totalKwh',
      ]);
      if (month == null || kwh == null) continue;
      final rowYear = _readInt(rows[i], const ['year', 'Year']) ?? year;
      entries.add(
        MonthlyBucketRow(
          year: rowYear,
          month: month,
          monthlyUsageKwh: kwh,
          offPeakKwh: _readDouble(rows[i], const [
                'offPeakKWh',
                'OffPeakKWh',
                'offPeakKwh',
              ]) ??
              0,
          peakKwh: _readDouble(rows[i], const [
                'peakKWh',
                'PeakKWh',
                'peakKwh',
              ]) ??
              0,
          midPeakKwh: _readDouble(rows[i], const [
                'midPeakKWh',
                'MidPeakKWh',
                'midPeakKwh',
              ]) ??
              0,
        ),
      );
    }
    return MonthlyTotalsResult(
      months: entries,
      summary: _parseSummary(payload),
    );
  }

  static AmiBucketSummary _parseSummary(Map<String, dynamic> payload) =>
      AmiBucketSummary(
        totalKwh: _readDouble(payload, const [
          'totalKWh',
          'TotalKWh',
          'totalKwh',
        ]),
        avgKwh: _readDouble(payload, const [
          'avgKWh',
          'AvgKWh',
          'avgKwh',
        ]),
        peakKwh: _readDouble(payload, const [
          'peakKWh',
          'PeakKWh',
          'peakKwh',
          'statsPeakKWh',
        ]),
        peakDate: _tryParseDate(
          _readString(payload, const ['peakDate', 'PeakDate']),
        ),
        peakMonth: _readInt(payload, const ['peakMonth', 'PeakMonth']),
      );

  /// Pulls the first usable list of row objects from a bucket or mock payload.
  static List<Map<String, dynamic>> extractList(dynamic json) {
    if (json is List) {
      return json
          .map(_asStringMap)
          .whereType<Map<String, dynamic>>()
          .toList();
    }

    final map = _asStringMap(json);
    if (map == null) return const [];

    const namedKeys = [
      'data',
      'Data',
      'intervals',
      'Intervals',
      'dailyUsages',
      'DailyUsages',
      'monthlyUsages',
      'MonthlyUsages',
      'result',
      'Result',
      'months',
      'Months',
    ];

    List<Map<String, dynamic>>? emptyNamed;
    for (final key in namedKeys) {
      final value = map[key];
      if (value is! List) continue;
      final rows = value
          .map(_asStringMap)
          .whereType<Map<String, dynamic>>()
          .toList();
      if (rows.isNotEmpty) return rows;
      emptyNamed ??= rows;
    }

    for (final value in map.values) {
      if (value is! List || value.isEmpty) continue;
      final rows = value
          .map(_asStringMap)
          .whereType<Map<String, dynamic>>()
          .toList();
      if (rows.isNotEmpty) return rows;
    }

    return emptyNamed ?? const [];
  }

  static IntervalUsageEntryDto? _parseIntervalRow(
    Map<String, dynamic> row, {
    required String meterId,
    required String dateStr,
  }) {
    final kwh = _readDouble(row, const [
      'kWh',
      'KWh',
      'kwh',
      'usageKwh',
    ]);
    if (kwh == null) return null;

    final existingDt = _readString(row, const [
      'intervalDateTime',
      'IntervalDateTime',
    ]);
    final hour = _readInt(row, const ['hour', 'Hour']);

    String intervalDateTime;
    if (existingDt != null && !_isPlaceholderDate(existingDt)) {
      intervalDateTime = existingDt;
    } else if (hour != null && hour >= 0 && hour <= 23) {
      intervalDateTime =
          '$dateStr ${hour.toString().padLeft(2, '0')}:00:00.000';
    } else {
      return null;
    }

    final intervalNumber = _readInt(row, const [
          'intervalNumber',
          'IntervalNumber',
        ]) ??
        ((hour ?? 0) + 1);

    return IntervalUsageEntryDto(
      meterId: _readString(row, const ['meterId', 'MeterId']) ?? meterId,
      readDate: _readString(row, const ['readDate', 'ReadDate']) ??
          '$dateStr 00:00:00.000',
      firstIntervalDateTime: _readString(row, const [
            'firstIntervalDateTime',
            'FirstIntervalDateTime',
          ]) ??
          '$dateStr 00:00:00.000',
      intervalDateTime: intervalDateTime,
      intervalNumber: intervalNumber,
      kWh: kwh,
    );
  }

  static List<String> _inferDailyDates({
    required List<Map<String, dynamic>> rows,
    required DateTime startDate,
    required DateTime endDate,
    DateTime? peakDate,
    double? peakKwh,
  }) {
    final explicit = [
      for (final row in rows)
        _tryParseDate(
          _readString(row, const ['usageDate', 'UsageDate', 'date', 'Date']),
        ),
    ];
    // Live DailyRangeBucket now sends real dates. Use each valid date as-is
    // so a missing day (e.g. Jul 5) does not shift the rest of the month.
    if (explicit.any((d) => d != null)) {
      return [
        for (var i = 0; i < rows.length; i++)
          _dateOnly(
            explicit[i] ??
                _fallbackDateForIndex(i, explicit, startDate),
          ),
      ];
    }

    final startDay = DateTime(startDate.year, startDate.month, startDate.day);
    final endDay = DateTime(endDate.year, endDate.month, endDate.day);
    final rangeDays = endDay.difference(startDay).inDays + 1;

    DateTime anchor;
    var anchorIndex = 0;

    if (rows.length == rangeDays) {
      anchor = startDay;
      anchorIndex = 0;
    } else if (peakDate != null) {
      anchor = DateTime(peakDate.year, peakDate.month, peakDate.day);
      anchorIndex = _indexOfClosestKwh(
        rows,
        peakKwh,
        const ['dailyKWh', 'DailyKWh', 'dailyUsageKwh', 'kWh'],
      );
    } else {
      anchor = startDay;
      anchorIndex = 0;
    }

    return List<String>.generate(
      rows.length,
      (i) => _dateOnly(anchor.add(Duration(days: i - anchorIndex))),
    );
  }

  static DateTime _fallbackDateForIndex(
    int index,
    List<DateTime?> explicit,
    DateTime startDate,
  ) {
    for (var j = index - 1; j >= 0; j--) {
      final previous = explicit[j];
      if (previous == null) continue;
      return DateTime(previous.year, previous.month, previous.day)
          .add(Duration(days: index - j));
    }
    for (var j = index + 1; j < explicit.length; j++) {
      final next = explicit[j];
      if (next == null) continue;
      return DateTime(next.year, next.month, next.day)
          .subtract(Duration(days: j - index));
    }
    return DateTime(startDate.year, startDate.month, startDate.day)
        .add(Duration(days: index));
  }

  static List<int?> _inferMonths({
    required List<Map<String, dynamic>> rows,
    int? peakMonth,
    double? peakKwh,
  }) {
    final explicit = [
      for (final row in rows)
        _readInt(row, const ['month', 'Month', 'monthNumber', 'MonthNumber']),
    ];
    if (explicit.every((m) => m != null && m >= 1 && m <= 12)) {
      return explicit;
    }

    if (peakMonth != null && peakMonth >= 1 && peakMonth <= 12) {
      final peakIndex = _indexOfClosestKwh(
        rows,
        peakKwh,
        const ['monthlyKWh', 'MonthlyKWh', 'monthlyUsageKwh', 'kWh'],
      );
      return List<int?>.generate(rows.length, (i) {
        final month = peakMonth + (i - peakIndex);
        if (month < 1 || month > 12) return null;
        return month;
      });
    }

    return List<int?>.generate(rows.length, (i) {
      final month = i + 1;
      return month <= 12 ? month : null;
    });
  }

  static int _indexOfClosestKwh(
    List<Map<String, dynamic>> rows,
    double? target,
    List<String> keys,
  ) {
    if (target == null) {
      var bestIdx = 0;
      var best = double.negativeInfinity;
      for (var i = 0; i < rows.length; i++) {
        final kwh = _readDouble(rows[i], keys) ?? 0;
        if (kwh > best) {
          best = kwh;
          bestIdx = i;
        }
      }
      return bestIdx;
    }

    var bestIdx = 0;
    var bestDiff = double.infinity;
    for (var i = 0; i < rows.length; i++) {
      final kwh = _readDouble(rows[i], keys) ?? 0;
      final diff = (kwh - target).abs();
      if (diff < bestDiff) {
        bestDiff = diff;
        bestIdx = i;
      }
    }
    return bestIdx;
  }

  static Map<String, dynamic>? _asStringMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v));
    }
    return null;
  }

  static int? _readInt(Map<String, dynamic> json, List<String> keys) {
    final value = _readRaw(json, keys);
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _readDouble(Map<String, dynamic> json, List<String> keys) {
    final value = _readRaw(json, keys);
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    final value = _readRaw(json, keys);
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  static dynamic _readRaw(Map<String, dynamic> json, List<String> keys) {
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

  static DateTime? _tryParseDate(String? raw) {
    if (raw == null || _isPlaceholderDate(raw)) return null;
    return DateTime.tryParse(raw.trim().replaceAll(' ', 'T'));
  }

  static bool _isPlaceholderDate(String raw) {
    final parsed = DateTime.tryParse(raw.trim().replaceAll(' ', 'T'));
    if (parsed == null) return true;
    return parsed.year < 1900;
  }

  static String _dateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
