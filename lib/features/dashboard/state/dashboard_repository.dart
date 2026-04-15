import 'dart:async';

import '../../../core/config/env.dart';
import '../../../data/models/api_dtos.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';
import '../../../data/sources/mock/mock_consumption_repository.dart';

class DashboardRepository {
  const DashboardRepository();

  Future<List<EnergyPricePoint>> fetchEnergyPrices(String accountId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // Always use mock service for now (similar to fetch7DayConsumption)
    // TODO: Add live API call when implemented
    final prices = await MockAppDataService.getEnergyPrices();
    final result = prices ?? [];
    return result;
  }

  Future<AccountBalance> fetchAccountBalance(String accountId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final bal = EnvConfig.useMockApi
        ? await MockAppDataService.getAccountBalance(accountId)
        : null; // Replace with live call when implemented
    final result = bal ?? AccountBalance(
      currentBalance: 0,
      lastPaymentDate: DateTime.now(),
      lastPaymentAmount: 0,
      nextDueDate: DateTime.now(),
      paymentMethod: 'Unknown',
    );
    return result;
  }

  Future<List<DailyConsumption>> fetch7DayConsumption(String accountId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final repo = MockConsumptionRepository();
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 6));
    final result = await repo.getDailyConsumptionRange(accountId, startDate, endDate);
    if (result.success && result.data != null) {
      return result.data!;
    } else {
      return [];
    }
  }

  Future<DashboardData> fetchDashboardData(String accountId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final data = EnvConfig.useMockApi
        ? await MockAppDataService.getDashboardData(accountId)
        : null; // Replace with live call when implemented
    final result = data ??
        const DashboardData(
          dailyCostSummary: DailyCostSummaryData(
            title: 'Daily Cost',
            description: 'The information below is an estimate of your current billing cycle.',
            billingCycle: 'Billing Cycle: Unknown',
            estimateDisclaimer: '* All dollar values are estimates.',
          ),
          energyPrices: EnergyPricesData(
            title: 'Energy Prices',
            description: 'Daily electricity rates',
          ),
        );
    return result;
  }

  Future<DailyConsumption> fetchDailyConsumption(String accountId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final consumption = DailyConsumption(
      date: DateTime.now(),
      totalKwh: 25.5,
      cost: 12.33,
      averageHourlyUsage: 1.06,
      peakHourlyUsage: 2.5,
      lowestHourlyUsage: 0.3,
      hourlyBreakdown: List.generate(
        24,
        (index) => HourlyConsumption(
          hour: index,
          kwh: (1.0 + (index - 12).abs() * 0.1).clamp(0.3, 2.5),
          cost: ((1.0 + (index - 12).abs() * 0.1).clamp(0.3, 2.5)) * 0.12,
        ),
      ),
      pattern: const ConsumptionPattern(
        previousDayUsage: 22.8,
        previousWeekAverage: 24.2,
        previousMonthAverage: 720,
        typicalPeakHours: [18, 19, 20],
        typicalLowHours: [2, 3, 4],
        weekendAverage: 20,
        weekdayAverage: 25,
        holidayAverage: 15,
      ),
    );
    return consumption;
  }
}
