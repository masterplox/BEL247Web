import 'package:bel247_web/data/models/ami_bucket_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AmiBucketParser DailyIntervalsBucket', () {
    test('maps hour/kWh/touPeriod rows onto interval DTOs', () {
      const payload = {
        'intervals': [
          {'hour': 0, 'kWh': 0.6534, 'touPeriod': 'off_peak'},
          {'hour': 1, 'kWh': 0.5598, 'touPeriod': 'off_peak'},
          {'hour': 10, 'kWh': 0.4428, 'touPeriod': 'off_peak'},
          {'hour': 11, 'kWh': 0.4752, 'touPeriod': 'peak'},
          {'hour': 17, 'kWh': 2.6814, 'touPeriod': 'peak'},
          {'hour': 21, 'kWh': 0.4374, 'touPeriod': 'mid_peak'},
          {'hour': 23, 'kWh': 0.7428, 'touPeriod': 'mid_peak'},
        ],
        'offPeakKWh': 7.0,
        'peakKWh': 8.0,
        'midPeakKWh': 2.0,
        'totalKWh': 17.0,
        'errorCode': 0,
        'errorMessage': 'Success',
      };

      final entries = AmiBucketParser.parseIntervals(
        payload,
        meterId: '0226031929',
        targetDate: DateTime(2026, 7, 18),
      );

      expect(entries, hasLength(7));
      expect(entries.first.kWh, 0.6534);
      expect(entries.first.intervalDateTime, '2026-07-18 00:00:00.000');
      expect(entries.first.meterId, '0226031929');

      final peakHour = entries.firstWhere((e) => e.intervalDateTime.contains('17:'));
      expect(peakHour.kWh, 2.6814);
    });

    test('reads payload totals without mixing TOU peakKWh and statsPeakKWh', () {
      const payload = {
        'intervals': [
          {'hour': 0, 'kWh': 0.4056, 'touPeriod': 'off_peak'},
          {'hour': 11, 'kWh': 2.1696, 'touPeriod': 'peak'},
          {'hour': 20, 'kWh': 3.3162, 'touPeriod': 'peak'},
          {'hour': 21, 'kWh': 2.2998, 'touPeriod': 'mid_peak'},
        ],
        'offPeakKWh': 6.0,
        'peakKWh': 11.0,
        'midPeakKWh': 5.0,
        'totalKWh': 21.0,
        'estimatedCost': 7.0,
        'avgKWh': 1.0,
        'statsPeakKWh': 3.0,
        'peakHour': 20,
        'errorCode': 0,
        'errorMessage': 'Success',
      };

      final result = AmiBucketParser.parseDailyIntervals(
        payload,
        meterId: '0226031929',
        targetDate: DateTime(2026, 8, 26),
      );

      expect(result.intervals, hasLength(4));
      expect(result.summary.offPeakKwh, 6.0);
      expect(result.summary.peakKwh, 11.0);
      expect(result.summary.midPeakKwh, 5.0);
      expect(result.summary.totalKwh, 21.0);
      expect(result.summary.estimatedCost, 7.0);
      expect(result.summary.avgKwh, 1.0);
      expect(result.summary.statsPeakKwh, 3.0);
      expect(result.summary.peakHour, 20);
    });

    test('still parses the older mock intervalDateTime shape', () {
      const payload = {
        'status': 200,
        'data': [
          {
            'meterId': '225003508',
            'readDate': '2025-11-01 01:04:00.000',
            'firstIntervalDateTime': '2025-10-31 20:15:00.000',
            'intervalDateTime': '2025-11-01 00:00:00.000',
            'intervalNumber': 16,
            'kWh': 0.0042,
          },
        ],
      };

      final entries = AmiBucketParser.parseIntervals(
        payload,
        meterId: '225003508',
        targetDate: DateTime(2025, 11, 1),
      );

      expect(entries, hasLength(1));
      expect(entries.single.intervalDateTime, '2025-11-01 00:00:00.000');
      expect(entries.single.intervalNumber, 16);
      expect(entries.single.kWh, 0.0042);
    });
  });

  group('AmiBucketParser DailyRangeBucket', () {
    test('reads dailyKWh and fills placeholder 0001-01-01 dates from the range', () {
      const payload = {
        'dailyUsages': [
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 22.7568,
            'offPeakKWh': 12.0954,
            'peakKWh': 7.0050,
            'midPeakKWh': 3.6564,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 28.1190,
            'offPeakKWh': 12.6438,
            'peakKWh': 10.0788,
            'midPeakKWh': 5.3964,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 24.8616,
            'offPeakKWh': 12.6864,
            'peakKWh': 7.5660,
            'midPeakKWh': 4.6092,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 20.9406,
            'offPeakKWh': 10.1640,
            'peakKWh': 5.8194,
            'midPeakKWh': 4.9572,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 21.7080,
            'offPeakKWh': 10.4808,
            'peakKWh': 7.0488,
            'midPeakKWh': 4.1784,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 24.9084,
            'offPeakKWh': 12.9402,
            'peakKWh': 7.1478,
            'midPeakKWh': 4.8204,
          },
          {
            'usageDate': '0001-01-01T00:00:00',
            'dailyKWh': 20.3058,
            'offPeakKWh': 10.6554,
            'peakKWh': 5.8704,
            'midPeakKWh': 3.7800,
          },
        ],
        'totalKWh': 163.0,
        'avgKWh': 23.0,
        'peakKWh': 28.0,
        'peakDate': '2026-07-13T00:00:00',
        'errorCode': 0,
        'errorMessage': 'Success',
      };

      final result = AmiBucketParser.parseDailyRange(
        payload,
        startDate: DateTime(2026, 7, 12),
        endDate: DateTime(2026, 7, 18),
      );
      final entries = result.days;

      expect(entries, hasLength(7));
      expect(entries.first.usageDate, '2026-07-12');
      expect(entries.first.dailyUsageKwh, 22.7568);
      expect(entries.first.offPeakKwh, 12.0954);
      expect(entries.first.peakKwh, 7.0050);
      expect(entries.first.midPeakKwh, 3.6564);
      expect(entries[1].usageDate, '2026-07-13');
      expect(entries[1].dailyUsageKwh, 28.1190);
      expect(entries.last.usageDate, '2026-07-18');
      expect(entries.last.dailyUsageKwh, 20.3058);
      expect(result.summary.totalKwh, 163.0);
      expect(result.summary.avgKwh, 23.0);
      expect(result.summary.peakKwh, 28.0);
      expect(result.summary.peakDate, DateTime(2026, 7, 13));
      expect(result.summary.hasTouTotals, isFalse);
    });

    test('reads payload TOU totals without mixing them with statsPeakKWh', () {
      const payload = {
        'dailyUsages': [
          {
            'usageDate': '2026-08-24T00:00:00',
            'dailyKWh': 20.0,
            'offPeakKWh': 5.0,
            'peakKWh': 10.0,
            'midPeakKWh': 5.0,
          },
        ],
        'offPeakKWh': 6.0,
        'peakKWh': 11.0,
        'midPeakKWh': 5.0,
        'totalKWh': 21.0,
        'estimatedCost': 7.0,
        'avgKWh': 3.0,
        'statsPeakKWh': 20.0,
        'peakDate': '2026-08-24T00:00:00',
      };

      final result = AmiBucketParser.parseDailyRange(
        payload,
        startDate: DateTime(2026, 8, 24),
        endDate: DateTime(2026, 8, 24),
      );

      expect(result.summary.offPeakKwh, 6.0);
      expect(result.summary.peakKwh, 11.0);
      expect(result.summary.midPeakKwh, 5.0);
      expect(result.summary.totalKwh, 21.0);
      expect(result.summary.estimatedCost, 7.0);
      expect(result.summary.avgKwh, 3.0);
      expect(result.summary.statsPeakKwh, 20.0);
      expect(result.summary.hasTouTotals, isTrue);
    });

    test('anchors placeholder dates to peakDate when the row count is not the range', () {
      const payload = {
        'dailyUsages': [
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 22.7568},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 28.1190},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 24.8616},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 20.9406},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 21.7080},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 24.9084},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 20.3058},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 26.2518},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 23.7378},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 26.8182},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 24.1944},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 22.7940},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 25.8816},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 28.6134},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 22.0908},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 25.2162},
          {'usageDate': '0001-01-01T00:00:00', 'dailyKWh': 25.0062},
        ],
        'totalKWh': 414.0,
        'peakKWh': 29.0,
        'peakDate': '2026-05-28T00:00:00',
        'errorCode': 0,
      };

      final result = AmiBucketParser.parseDailyRange(
        payload,
        startDate: DateTime(2026, 5, 1),
        endDate: DateTime(2026, 5, 31),
      );
      final entries = result.days;

      expect(entries, hasLength(17));
      expect(entries[13].dailyUsageKwh, 28.6134);
      expect(entries[13].usageDate, '2026-05-28');
      expect(entries.first.usageDate, '2026-05-15');
      expect(entries.last.usageDate, '2026-05-31');
      expect(result.summary.totalKwh, 414.0);
    });

    test('keeps real usageDate values so a missing day does not shift the month', () {
      const payload = {
        'dailyUsages': [
          {
            'usageDate': '2026-07-01T00:00:00',
            'dailyKWh': 27.7098,
            'offPeakKWh': 14.5398,
            'peakKWh': 7.5120,
            'midPeakKWh': 5.6580,
          },
          {
            'usageDate': '2026-07-04T00:00:00',
            'dailyKWh': 19.2294,
            'offPeakKWh': 12.7026,
            'peakKWh': 6.5268,
            'midPeakKWh': 0.0000,
          },
          {
            'usageDate': '2026-07-06T00:00:00',
            'dailyKWh': 9.0720,
            'offPeakKWh': 0.0000,
            'peakKWh': 6.1314,
            'midPeakKWh': 2.9406,
          },
          {
            'usageDate': '2026-07-21T00:00:00',
            'dailyKWh': 31.4652,
            'offPeakKWh': 12.6390,
            'peakKWh': 14.0166,
            'midPeakKWh': 4.8096,
          },
        ],
        'totalKWh': 694.0,
        'avgKWh': 23.0,
        'peakKWh': 31.0,
        'peakDate': '2026-07-21T00:00:00',
      };

      final result = AmiBucketParser.parseDailyRange(
        payload,
        startDate: DateTime(2026, 7, 1),
        endDate: DateTime(2026, 7, 31),
      );

      expect(result.days.map((d) => d.usageDate).toList(), [
        '2026-07-01',
        '2026-07-04',
        '2026-07-06',
        '2026-07-21',
      ]);
      expect(result.days.last.dailyUsageKwh, 31.4652);
      expect(result.summary.totalKwh, 694.0);
      expect(result.summary.avgKwh, 23.0);
      expect(result.summary.peakKwh, 31.0);
      expect(result.summary.peakDate, DateTime(2026, 7, 21));
    });
  });

  group('AmiBucketParser MonthlyTotalsBucket', () {
    test('reads monthlyKWh and infers months from peakMonth when monthNumber is 0', () {
      const payload = {
        'monthlyUsages': [
          {
            'monthNumber': 0,
            'monthlyKWh': 414.2046,
            'offPeakKWh': 194.7510,
            'peakKWh': 153.1980,
            'midPeakKWh': 66.2556,
          },
          {
            'monthNumber': 0,
            'monthlyKWh': 698.5590,
            'offPeakKWh': 310.7532,
            'peakKWh': 274.5330,
            'midPeakKWh': 113.2728,
          },
          {
            'monthNumber': 0,
            'monthlyKWh': 694.1538,
            'offPeakKWh': 322.8444,
            'peakKWh': 265.7046,
            'midPeakKWh': 105.6048,
          },
          {
            'monthNumber': 0,
            'monthlyKWh': 74.9142,
            'offPeakKWh': 32.0496,
            'peakKWh': 25.2948,
            'midPeakKWh': 17.5698,
          },
        ],
        'totalKWh': 1882.0,
        'estimatedCost': 602.0,
        'avgKWh': 470.0,
        'peakKWh': 699.0,
        'peakMonth': 6,
        'errorCode': 0,
        'errorMessage': 'Success',
      };

      final result = AmiBucketParser.parseMonthlyTotals(payload, year: 2026);
      final entries = result.months;

      expect(entries, hasLength(4));
      expect(entries.map((e) => e.month).toList(), [5, 6, 7, 8]);
      expect(entries[1].monthlyUsageKwh, 698.5590);
      expect(entries[1].year, 2026);
      expect(entries[1].offPeakKwh, 310.7532);
      expect(entries[1].peakKwh, 274.5330);
      expect(entries[1].midPeakKwh, 113.2728);
      expect(result.summary.totalKwh, 1882.0);
      expect(result.summary.avgKwh, 470.0);
      expect(result.summary.peakKwh, 699.0);
      expect(result.summary.peakMonth, 6);
      expect(result.summary.hasTouTotals, isFalse);
      expect(
        entries.fold<double>(0, (sum, e) => sum + e.offPeakKwh),
        closeTo(860.3982, 0.0001),
      );
    });

    test('reads payload TOU totals without mixing them with statsPeakKWh', () {
      const payload = {
        'monthlyUsages': [
          {
            'monthNumber': 6,
            'monthlyKWh': 698.0,
            'offPeakKWh': 300.0,
            'peakKWh': 270.0,
            'midPeakKWh': 128.0,
          },
        ],
        'offPeakKWh': 860.0,
        'peakKWh': 719.0,
        'midPeakKWh': 303.0,
        'totalKWh': 1882.0,
        'estimatedCost': 602.0,
        'avgKWh': 470.0,
        'statsPeakKWh': 699.0,
        'peakMonth': 6,
      };

      final result = AmiBucketParser.parseMonthlyTotals(payload, year: 2026);
      expect(result.summary.offPeakKwh, 860.0);
      expect(result.summary.peakKwh, 719.0);
      expect(result.summary.midPeakKwh, 303.0);
      expect(result.summary.statsPeakKwh, 699.0);
      expect(result.summary.hasTouTotals, isTrue);
      expect(result.summary.peakMonth, 6);
    });

    test('still parses the older year/month/monthlyUsageKwh mock shape', () {
      const payload = {
        'data': [
          {'year': 2025, 'month': 9, 'monthlyUsageKwh': 71.66},
          {'year': 2025, 'month': 10, 'monthlyUsageKwh': 39.69},
        ],
      };

      final result = AmiBucketParser.parseMonthlyTotals(payload, year: 2025);
      expect(result.months.map((e) => e.month).toList(), [9, 10]);
      expect(result.months.first.monthlyUsageKwh, 71.66);
    });
  });
}
