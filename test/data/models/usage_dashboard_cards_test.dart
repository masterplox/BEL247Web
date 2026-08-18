import 'package:bel247_web/data/models/usage_dashboard_cards.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsageDashboardCardsResult', () {
    test('parses camelCase payload from the AMI endpoint', () {
      final result = UsageDashboardCardsResult.fromJson({
        'currentPeriodKWh': 412.5,
        'currentStartDate': '2026-07-04T00:00:00',
        'currentEndDate': '2026-08-04T00:00:00',
        'currentPeriodLabel': 'Jul 4 - Aug 4',
        'daysElapsed': 14,
        'daysInPeriod': 31,
        'previousPeriodToDateKWh': 380.0,
        'varianceKWh': 32.5,
        'comparisonLabel': '32.5 kWh more than last period',
        'peakBilledKWh': 520.0,
        'peakPeriodLabel': 'May 2026',
        'avgBilledKWh': 390.25,
        'avgRangeLabel': 'Sep 2025 - Jul 2026',
        'periodsAnalyzed': 11,
        'billedPeriods': [
          {
            'periodId': 'B-100',
            'label': 'Jun 4 - Jul 4',
            'rangeLabel': 'Jun 4 - Jul 4, 2026',
            'days': 30,
            'billedKWh': 401.2,
            'isPeak': false,
          },
          {
            'periodId': 'B-99',
            'label': 'May 4 - Jun 4',
            'billedKWh': 520.0,
            'isPeak': true,
          },
        ],
        'errorCode': 0,
      });

      expect(result.hasUsageData, isTrue);
      expect(result.currentPeriodKWh, 412.5);
      expect(result.daysElapsed, 14);
      expect(result.usedMoreThanPrevious, isTrue);
      expect(result.peakPeriodLabel, 'May 2026');
      expect(result.billedPeriods, hasLength(2));
      expect(result.billedPeriods.last.isPeak, isTrue);
      expect(result.currentStartDate, DateTime(2026, 7, 4));
    });

    test('parses PascalCase payload wrapped in data', () {
      final result = UsageDashboardCardsResult.fromJson({
        'Status': 200,
        'Message': 'Success',
        'Data': {
          'CurrentPeriodKWh': 100,
          'CurrentPeriodLabel': 'This period',
          'DaysElapsed': 10,
          'DaysInPeriod': 30,
          'PreviousPeriodToDateKWh': 120,
          'VarianceKWh': -20,
          'ComparisonLabel': '20 kWh less',
          'PeakBilledKWh': 200,
          'PeakPeriodLabel': 'Apr 2026',
          'AvgBilledKWh': 150,
          'AvgRangeLabel': 'Last 12 periods',
          'PeriodsAnalyzed': 12,
          'BilledPeriods': <Map<String, dynamic>>[],
          'ErrorCode': 0,
        },
      });

      expect(result.hasCurrentPeriod, isTrue);
      expect(result.usedLessThanPrevious, isTrue);
      expect(result.varianceKWh, -20);
      expect(result.avgRangeLabel, 'Last 12 periods');
    });

    test('treats a non-zero error code as no usage data', () {
      final result = UsageDashboardCardsResult.fromJson({
        'currentPeriodKWh': 10,
        'errorCode': 1,
        'errorMessage': 'Meter not found',
      });

      expect(result.hasError, isTrue);
      expect(result.hasUsageData, isFalse);
    });
  });
}
