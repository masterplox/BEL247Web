import 'package:bel247_web/data/models/consumption.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Consumption Model Tests', () {
    late DailyConsumption testDailyConsumption;
    late List<HourlyConsumption> testHourlyBreakdown;

    setUp(() {
      testHourlyBreakdown = List.generate(24, (index) => HourlyConsumption(
        hour: index,
        kwh: 15.0 + (index % 3) * 5.0, // Varying usage
        cost: (15.0 + (index % 3) * 5.0) * 0.12,
      ));

      testDailyConsumption = DailyConsumption(
        date: DateTime(2023, 12, 15),
        totalKwh: 450,
        cost: 54,
        hourlyBreakdown: testHourlyBreakdown,
      );
    });

    group('DailyConsumption Tests', () {
      group('Serialization/Deserialization', () {
        test('should serialize to JSON correctly', () {
          final json = testDailyConsumption.toJson();
          
          expect(json['date'], isNotNull);
          expect(json['totalKwh'], equals(450.0));
          expect(json['cost'], equals(54.0));
          expect(json['hourlyBreakdown'], hasLength(24));
        });

        test('should deserialize from JSON correctly', () {
          final json = testDailyConsumption.toJson();
          final consumptionFromJson = DailyConsumption.fromJson(json);
          
          expect(consumptionFromJson.date, equals(testDailyConsumption.date));
          expect(consumptionFromJson.totalKwh, equals(testDailyConsumption.totalKwh));
          expect(consumptionFromJson.cost, equals(testDailyConsumption.cost));
          expect(consumptionFromJson.hourlyBreakdown, hasLength(24));
        });

        test('should handle optional fields with defaults', () {
          final json = testDailyConsumption.toJson();
          final consumptionFromJson = DailyConsumption.fromJson(json);
          
          expect(consumptionFromJson.peakUsages, isEmpty);
          expect(consumptionFromJson.lowUsages, isEmpty);
          expect(consumptionFromJson.averageHourlyUsage, equals(0.0));
          expect(consumptionFromJson.peakHourlyUsage, equals(0.0));
          expect(consumptionFromJson.lowestHourlyUsage, equals(0.0));
          expect(consumptionFromJson.standardDeviation, equals(0.0));
          expect(consumptionFromJson.alerts, isEmpty);
          expect(consumptionFromJson.pattern, equals(const ConsumptionPattern()));
        });
      });

      group('Validation', () {
        test('should validate successfully with valid data', () {
          final result = testDailyConsumption.validate();
          
          expect(result.isValid, isTrue);
          expect(result.errors, isEmpty);
        });

        test('should fail validation with negative total kWh', () {
          final invalidConsumption = testDailyConsumption.copyWith(totalKwh: -100);
          final result = invalidConsumption.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Total kWh cannot be negative'));
        });

        test('should fail validation with negative cost', () {
          final invalidConsumption = testDailyConsumption.copyWith(cost: -50);
          final result = invalidConsumption.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Cost cannot be negative'));
        });

        test('should fail validation with incorrect hourly breakdown length', () {
          final invalidBreakdown = testHourlyBreakdown.take(12).toList(); // Only 12 hours
          final invalidConsumption = testDailyConsumption.copyWith(hourlyBreakdown: invalidBreakdown);
          final result = invalidConsumption.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Hourly breakdown must have 24 entries'));
        });

        test('should fail validation with negative hourly values', () {
          final invalidBreakdown = testHourlyBreakdown.map((h) => h.copyWith(
            kwh: -10,
            cost: -5,
          )).toList();
          final invalidConsumption = testDailyConsumption.copyWith(hourlyBreakdown: invalidBreakdown);
          final result = invalidConsumption.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Hourly kWh cannot be negative'));
          expect(result.errors, contains('Hourly cost cannot be negative'));
        });
      });

      group('Computed Properties', () {
        test('should return peak usage hours', () {
          final peakHours = testDailyConsumption.peakUsageHours;
          
          expect(peakHours, hasLength(3));
          expect(peakHours, isA<List<int>>());
          // Peak hours should be sorted in descending order
          for (int i = 0; i < peakHours.length - 1; i++) {
            final hour1 = testHourlyBreakdown.firstWhere((h) => h.hour == peakHours[i]);
            final hour2 = testHourlyBreakdown.firstWhere((h) => h.hour == peakHours[i + 1]);
            expect(hour1.kwh, greaterThanOrEqualTo(hour2.kwh));
          }
        });

        test('should return low usage hours', () {
          final lowHours = testDailyConsumption.lowUsageHours;
          
          expect(lowHours, hasLength(3));
          expect(lowHours, isA<List<int>>());
          // Low hours should be sorted in ascending order
          for (int i = 0; i < lowHours.length - 1; i++) {
            final hour1 = testHourlyBreakdown.firstWhere((h) => h.hour == lowHours[i]);
            final hour2 = testHourlyBreakdown.firstWhere((h) => h.hour == lowHours[i + 1]);
            expect(hour1.kwh, lessThanOrEqualTo(hour2.kwh));
          }
        });

        test('should calculate efficiency score', () {
          final efficiencyScore = testDailyConsumption.efficiencyScore;
          
          expect(efficiencyScore, isA<double>());
          expect(efficiencyScore, greaterThanOrEqualTo(0.0));
          expect(efficiencyScore, lessThanOrEqualTo(100.0));
        });

        test('should return zero efficiency score for zero usage', () {
          final zeroConsumption = testDailyConsumption.copyWith(
            totalKwh: 0,
            hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
              hour: index,
              kwh: 0,
              cost: 0,
            )),
          );
          
          expect(zeroConsumption.efficiencyScore, equals(0.0));
        });

        test('should check if usage is above average', () {
          final consumptionWithAverage = testDailyConsumption.copyWith(
            averageHourlyUsage: 20, // 20 * 24 = 480
          );
          
          expect(consumptionWithAverage.isAboveAverage, isFalse); // 450 < 480
          
          final consumptionAboveAverage = testDailyConsumption.copyWith(
            totalKwh: 500,
            averageHourlyUsage: 20,
          );
          
          expect(consumptionAboveAverage.isAboveAverage, isTrue); // 500 > 480
        });

        test('should determine usage trend', () {
          // Unknown trend when no previous day usage
          expect(testDailyConsumption.usageTrend, equals(UsageTrend.unknown));
          
          // Increasing trend
          final increasingConsumption = testDailyConsumption.copyWith(
            pattern: const ConsumptionPattern(previousDayUsage: 400),
          );
          expect(increasingConsumption.usageTrend, equals(UsageTrend.increasing));
          
          // Decreasing trend
          final decreasingConsumption = testDailyConsumption.copyWith(
            totalKwh: 400,
            pattern: const ConsumptionPattern(previousDayUsage: 450),
          );
          expect(decreasingConsumption.usageTrend, equals(UsageTrend.decreasing));
          
          // Stable trend
          final stableConsumption = testDailyConsumption.copyWith(
            totalKwh: 450,
            pattern: const ConsumptionPattern(previousDayUsage: 450),
          );
          expect(stableConsumption.usageTrend, equals(UsageTrend.stable));
        });
      });
    });

    group('UsageStatistics Tests', () {
      late UsageStatistics testStatistics;

      setUp(() {
        testStatistics = const UsageStatistics(
          averageDailyUsage: 15,
          averageMonthlyUsage: 450,
          averageYearlyUsage: 5400,
          peakUsageHour: 18,
          lowestUsageHour: 3,
          seasonalTrends: SeasonalTrends(
            summer: SeasonalData(average: 20, peak: 25),
            fall: SeasonalData(average: 15, peak: 18),
            winter: SeasonalData(average: 12, peak: 15),
            spring: SeasonalData(average: 13, peak: 16),
          ),
        );
      });

      group('Serialization/Deserialization', () {
        test('should serialize to JSON correctly', () {
          final json = testStatistics.toJson();
          
          expect(json['averageDailyUsage'], equals(15.0));
          expect(json['averageMonthlyUsage'], equals(450.0));
          expect(json['averageYearlyUsage'], equals(5400.0));
          expect(json['peakUsageHour'], equals(18));
          expect(json['lowestUsageHour'], equals(3));
        });

        test('should deserialize from JSON correctly', () {
          final json = testStatistics.toJson();
          final statisticsFromJson = UsageStatistics.fromJson(json);
          
          expect(statisticsFromJson.averageDailyUsage, equals(testStatistics.averageDailyUsage));
          expect(statisticsFromJson.averageMonthlyUsage, equals(testStatistics.averageMonthlyUsage));
          expect(statisticsFromJson.averageYearlyUsage, equals(testStatistics.averageYearlyUsage));
          expect(statisticsFromJson.peakUsageHour, equals(testStatistics.peakUsageHour));
          expect(statisticsFromJson.lowestUsageHour, equals(testStatistics.lowestUsageHour));
        });
      });

      group('Validation', () {
        test('should validate successfully with valid data', () {
          final result = testStatistics.validate();
          
          expect(result.isValid, isTrue);
          expect(result.errors, isEmpty);
        });

        test('should fail validation with negative usage values', () {
          final invalidStatistics = testStatistics.copyWith(
            averageDailyUsage: -10,
            averageMonthlyUsage: -300,
            averageYearlyUsage: -3600,
          );
          final result = invalidStatistics.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Average daily usage cannot be negative'));
          expect(result.errors, contains('Average monthly usage cannot be negative'));
          expect(result.errors, contains('Average yearly usage cannot be negative'));
        });

        test('should fail validation with invalid hour values', () {
          final invalidStatistics = testStatistics.copyWith(
            peakUsageHour: 25, // Invalid hour
            lowestUsageHour: -1, // Invalid hour
          );
          final result = invalidStatistics.validate();
          
          expect(result.isValid, isFalse);
          expect(result.errors, contains('Peak usage hour must be between 0 and 23'));
          expect(result.errors, contains('Lowest usage hour must be between 0 and 23'));
        });
      });

      group('Computed Properties', () {
        test('should determine efficiency rating', () {
          final excellentStats = testStatistics.copyWith(efficiencyScore: 95);
          expect(excellentStats.efficiencyRating, equals(EfficiencyRating.excellent));
          
          final goodStats = testStatistics.copyWith(efficiencyScore: 80);
          expect(goodStats.efficiencyRating, equals(EfficiencyRating.good));
          
          final fairStats = testStatistics.copyWith(efficiencyScore: 65);
          expect(fairStats.efficiencyRating, equals(EfficiencyRating.fair));
          
          final poorStats = testStatistics.copyWith(efficiencyScore: 45);
          expect(poorStats.efficiencyRating, equals(EfficiencyRating.poor));
        });

        test('should determine peak usage period', () {
          final morningPeak = testStatistics.copyWith(peakUsageHour: 8);
          expect(morningPeak.peakUsagePeriod, equals('Morning Peak'));
          
          final eveningPeak = testStatistics.copyWith(peakUsageHour: 18);
          expect(eveningPeak.peakUsagePeriod, equals('Evening Peak'));
          
          final middayPeak = testStatistics.copyWith(peakUsageHour: 13);
          expect(middayPeak.peakUsagePeriod, equals('Midday Peak'));
          
          final offPeak = testStatistics.copyWith(peakUsageHour: 2);
          expect(offPeak.peakUsagePeriod, equals('Off-Peak'));
        });

        test('should determine overall trend', () {
          // Unknown trend when no patterns
          expect(testStatistics.overallTrend, equals(UsageTrend.unknown));
          
          // Increasing trend
          final increasingPatterns = [
            UsagePattern(
              id: 'p1',
              date: DateTime(2023, 12, 1),
              averageUsage: 10,
              peakUsage: 15,
              lowUsage: 5,
              peakHours: [18, 19, 20],
              lowHours: [2, 3, 4],
            ),
            UsagePattern(
              id: 'p2',
              date: DateTime(2023, 12, 2),
              averageUsage: 12,
              peakUsage: 17,
              lowUsage: 7,
              peakHours: [18, 19, 20],
              lowHours: [2, 3, 4],
            ),
            UsagePattern(
              id: 'p3',
              date: DateTime(2023, 12, 3),
              averageUsage: 15,
              peakUsage: 20,
              lowUsage: 10,
              peakHours: [18, 19, 20],
              lowHours: [2, 3, 4],
            ),
          ];
          
          final increasingStats = testStatistics.copyWith(patterns: increasingPatterns);
          expect(increasingStats.overallTrend, equals(UsageTrend.increasing));
          
          // Decreasing trend
          final decreasingPatterns = increasingPatterns.reversed.toList();
          final decreasingStats = testStatistics.copyWith(patterns: decreasingPatterns);
          expect(decreasingStats.overallTrend, equals(UsageTrend.decreasing));
          
          // Stable trend
          final stablePatterns = increasingPatterns.map((p) => p.copyWith(averageUsage: 12)).toList();
          final stableStats = testStatistics.copyWith(patterns: stablePatterns);
          expect(stableStats.overallTrend, equals(UsageTrend.stable));
        });
      });
    });

    group('HourlyConsumption Tests', () {
      test('should serialize and deserialize correctly', () {
        const hourlyConsumption = HourlyConsumption(
          hour: 12,
          kwh: 20,
          cost: 2.4,
        );
        
        final json = hourlyConsumption.toJson();
        final consumptionFromJson = HourlyConsumption.fromJson(json);
        
        expect(consumptionFromJson.hour, equals(hourlyConsumption.hour));
        expect(consumptionFromJson.kwh, equals(hourlyConsumption.kwh));
        expect(consumptionFromJson.cost, equals(hourlyConsumption.cost));
      });
    });

    group('MonthlyConsumption Tests', () {
      test('should serialize and deserialize correctly', () {
        const monthlyConsumption = MonthlyConsumption(
          month: 'December 2023',
          totalKwh: 450,
          totalCost: 54,
          averageDaily: 15,
          peakDay: '2023-12-15',
          peakKwh: 25,
          lowestDay: '2023-12-01',
          lowestKwh: 8,
        );
        
        final json = monthlyConsumption.toJson();
        final consumptionFromJson = MonthlyConsumption.fromJson(json);
        
        expect(consumptionFromJson.month, equals(monthlyConsumption.month));
        expect(consumptionFromJson.totalKwh, equals(monthlyConsumption.totalKwh));
        expect(consumptionFromJson.totalCost, equals(monthlyConsumption.totalCost));
        expect(consumptionFromJson.averageDaily, equals(monthlyConsumption.averageDaily));
        expect(consumptionFromJson.peakDay, equals(monthlyConsumption.peakDay));
        expect(consumptionFromJson.peakKwh, equals(monthlyConsumption.peakKwh));
        expect(consumptionFromJson.lowestDay, equals(monthlyConsumption.lowestDay));
        expect(consumptionFromJson.lowestKwh, equals(monthlyConsumption.lowestKwh));
      });
    });

    group('YearlyConsumption Tests', () {
      test('should serialize and deserialize correctly', () {
        const yearlyConsumption = YearlyConsumption(
          year: 2023,
          totalKwh: 5400,
          totalCost: 648,
          averageMonthly: 450,
          peakMonth: 'July',
          peakKwh: 600,
          lowestMonth: 'February',
          lowestKwh: 300,
        );
        
        final json = yearlyConsumption.toJson();
        final consumptionFromJson = YearlyConsumption.fromJson(json);
        
        expect(consumptionFromJson.year, equals(yearlyConsumption.year));
        expect(consumptionFromJson.totalKwh, equals(yearlyConsumption.totalKwh));
        expect(consumptionFromJson.totalCost, equals(yearlyConsumption.totalCost));
        expect(consumptionFromJson.averageMonthly, equals(yearlyConsumption.averageMonthly));
        expect(consumptionFromJson.peakMonth, equals(yearlyConsumption.peakMonth));
        expect(consumptionFromJson.peakKwh, equals(yearlyConsumption.peakKwh));
        expect(consumptionFromJson.lowestMonth, equals(yearlyConsumption.lowestMonth));
        expect(consumptionFromJson.lowestKwh, equals(yearlyConsumption.lowestKwh));
      });
    });

    group('SeasonalTrends Tests', () {
      test('should serialize and deserialize correctly', () {
        const seasonalTrends = SeasonalTrends(
          summer: SeasonalData(average: 20, peak: 25),
          fall: SeasonalData(average: 15, peak: 18),
          winter: SeasonalData(average: 12, peak: 15),
          spring: SeasonalData(average: 13, peak: 16),
        );
        
        final json = seasonalTrends.toJson();
        final trendsFromJson = SeasonalTrends.fromJson(json);
        
        expect(trendsFromJson.summer.average, equals(seasonalTrends.summer.average));
        expect(trendsFromJson.summer.peak, equals(seasonalTrends.summer.peak));
        expect(trendsFromJson.fall.average, equals(seasonalTrends.fall.average));
        expect(trendsFromJson.fall.peak, equals(seasonalTrends.fall.peak));
        expect(trendsFromJson.winter.average, equals(seasonalTrends.winter.average));
        expect(trendsFromJson.winter.peak, equals(seasonalTrends.winter.peak));
        expect(trendsFromJson.spring.average, equals(seasonalTrends.spring.average));
        expect(trendsFromJson.spring.peak, equals(seasonalTrends.spring.peak));
      });
    });

    group('SeasonalData Tests', () {
      test('should serialize and deserialize correctly', () {
        const seasonalData = SeasonalData(
          average: 15,
          peak: 20,
          lowest: 8,
          standardDeviation: 3.5,
          peakDays: ['2023-07-15', '2023-07-20'],
        );
        
        final json = seasonalData.toJson();
        final dataFromJson = SeasonalData.fromJson(json);
        
        expect(dataFromJson.average, equals(seasonalData.average));
        expect(dataFromJson.peak, equals(seasonalData.peak));
        expect(dataFromJson.lowest, equals(seasonalData.lowest));
        expect(dataFromJson.standardDeviation, equals(seasonalData.standardDeviation));
        expect(dataFromJson.peakDays, equals(seasonalData.peakDays));
      });
    });

    group('Edge Cases', () {
      test('should handle zero consumption', () {
        final zeroConsumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 0,
          cost: 0,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 0,
            cost: 0,
          )),
        );
        
        final result = zeroConsumption.validate();
        expect(result.isValid, isTrue);
        expect(zeroConsumption.efficiencyScore, equals(0.0));
        expect(zeroConsumption.isAboveAverage, isFalse);
      });

      test('should handle very high consumption', () {
        final highConsumption = DailyConsumption(
          date: DateTime(2023, 12, 15),
          totalKwh: 1000,
          cost: 120,
          hourlyBreakdown: List.generate(24, (index) => HourlyConsumption(
            hour: index,
            kwh: 40,
            cost: 4.8,
          )),
        );
        
        final result = highConsumption.validate();
        expect(result.isValid, isTrue);
        expect(highConsumption.efficiencyScore, equals(100.0)); // Perfect efficiency with uniform usage
      });

      test('should handle leap year dates', () {
        final leapYearConsumption = DailyConsumption(
          date: DateTime(2024, 2, 29), // Leap year
          totalKwh: 450,
          cost: 54,
          hourlyBreakdown: testHourlyBreakdown,
        );
        
        final result = leapYearConsumption.validate();
        expect(result.isValid, isTrue);
      });
    });
  });
}
