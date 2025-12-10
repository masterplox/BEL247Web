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
    print('[Dashboard] Repository.fetchEnergyPrices useMockApi=${EnvConfig.useMockApi}');
    print('[Dashboard] Repository.fetchEnergyPrices start accountId=$accountId');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // Always use mock service for now (similar to fetch7DayConsumption)
    // TODO: Add live API call when implemented
    final prices = await MockAppDataService.getEnergyPrices();
    final result = prices ?? [];
    if (prices == null || result.isEmpty) {
      print('[Dashboard] Repository.fetchEnergyPrices [ERROR] No prices found for accountId=$accountId, returning empty list');
    } else {
      print('[Dashboard] Repository.fetchEnergyPrices success count=${result.length} accountId=$accountId');
    }
    return result;
  }

  Future<AccountBalance> fetchAccountBalance(String accountId) async {
    print('[Dashboard] Repository.fetchAccountBalance useMockApi=${EnvConfig.useMockApi}');
    print('[Dashboard] Repository.fetchAccountBalance start accountId=$accountId');
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
    if (bal == null) {
      print('[Dashboard] Repository.fetchAccountBalance [ERROR] No balance found for accountId=$accountId, returning default');
    } else {
      print('[Dashboard] Repository.fetchAccountBalance success balance=\$${result.currentBalance.toStringAsFixed(2)} accountId=$accountId');
    }
    return result;
  }

  Future<List<DailyConsumption>> fetch7DayConsumption(String accountId) async {
    print('[Dashboard] Repository.fetch7DayConsumption useMockApi=${EnvConfig.useMockApi}');
    print('[Dashboard] Repository.fetch7DayConsumption start accountId=$accountId');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final repo = MockConsumptionRepository();
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 6));
    final result = await repo.getDailyConsumptionRange(accountId, startDate, endDate);
    if (result.success && result.data != null) {
      print('[Dashboard] Repository.fetch7DayConsumption success count=${result.data!.length} accountId=$accountId');
      return result.data!;
    } else {
      print('[Dashboard] Repository.fetch7DayConsumption [ERROR] No data found for accountId=$accountId, returning empty list');
      return [];
    }
  }

  Future<DashboardData> fetchDashboardData(String accountId) async {
    print('[Dashboard] Repository.fetchDashboardData useMockApi=${EnvConfig.useMockApi}');
    print('[Dashboard] Repository.fetchDashboardData start accountId=$accountId');
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
    if (data == null) {
      print('[Dashboard] Repository.fetchDashboardData [ERROR] No data found for accountId=$accountId, returning default');
    } else {
      print('[Dashboard] Repository.fetchDashboardData success accountId=$accountId');
    }
    return result;
  }

  Future<DailyConsumption> fetchDailyConsumption(String accountId) async {
    print('[Dashboard] Repository.fetchDailyConsumption useMockApi=${EnvConfig.useMockApi}');
    print('[Dashboard] Repository.fetchDailyConsumption start accountId=$accountId');
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
    print('[Dashboard] Repository.fetchDailyConsumption success totalKwh=${consumption.totalKwh.toStringAsFixed(2)} cost=\$${consumption.cost.toStringAsFixed(2)} accountId=$accountId');
    return consumption;
  }
}
