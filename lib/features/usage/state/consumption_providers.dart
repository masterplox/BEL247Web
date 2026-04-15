import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart';
import '../../../data/models/consumption.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';

class ConsumptionRepository {
  Future<DailyConsumption> fetchDailyConsumption(DateTime date, String accountId) async {
    
    // Get account-specific usage summary to use as baseline
    final usageSummary = await MockAppDataService.getUsageSummary(accountId);
    final averageDailyKwh = usageSummary?.currentMonth.averageDaily ?? 25.0;
    
    // Generate base hourly breakdown based on account's average usage
    final hourlyMultipliers = [
      0.3, 0.25, 0.25, 0.3, 0.4, 0.5, 0.7, 1.0, 1.2, 1.1, 0.9, 0.8,
      0.9, 1.0, 1.1, 1.2, 1.3, 1.5, 1.6, 1.4, 1.2, 1.0, 0.8, 0.5,
    ];
    
    final baseHourlyKwh = averageDailyKwh / hourlyMultipliers.fold<double>(0, (sum, m) => sum + m);
    final hourlyBreakdown = hourlyMultipliers.asMap().entries.map((entry) {
      final hour = entry.key;
      final multiplier = entry.value;
      // Add some variation based on date and account ID
      final accountHash = accountId.hashCode.abs() % 100 / 100;
      final dateVariation = (date.day % 10 - 5) / 50;
      final variation = 1.0 + dateVariation + (accountHash - 0.5) * 0.1;
      final kwh = (baseHourlyKwh * multiplier * variation).clamp(0.1, 10.0);
      
      return HourlyConsumption(
        hour: hour,
        kwh: kwh,
        cost: kwh * 0.12,
      );
    }).toList();
    
    final totalKwh = hourlyBreakdown.fold<double>(0, (sum, h) => sum + h.kwh);
    final cost = totalKwh * 0.12;
    
    // Find peak and low usage hours
    final sortedHours = hourlyBreakdown.toList()
      ..sort((a, b) => b.kwh.compareTo(a.kwh));
    final peakUsage = sortedHours.first.kwh;
    final lowestUsage = sortedHours.last.kwh;
    final peakHour = sortedHours.first.hour;
    final lowHour = sortedHours.last.hour;

    
    return DailyConsumption(
      date: date,
      totalKwh: totalKwh,
      cost: cost,
      hourlyBreakdown: hourlyBreakdown,
      peakUsages: [
        PeakUsage(
          hour: peakHour,
          kwh: peakUsage,
          cost: peakUsage * 0.12,
          timestamp: date.add(Duration(hours: peakHour)),
          reason: 'Evening peak usage',
        ),
      ],
      lowUsages: [
        LowUsage(
          hour: lowHour,
          kwh: lowestUsage,
          cost: lowestUsage * 0.12,
          timestamp: date.add(Duration(hours: lowHour)),
          reason: 'Night low usage',
        ),
      ],
      averageHourlyUsage: totalKwh / 24,
      peakHourlyUsage: peakUsage,
      lowestHourlyUsage: lowestUsage,
      standardDeviation: _calculateStandardDeviation(hourlyBreakdown),
      alerts: [],
      pattern: ConsumptionPattern(
        previousDayUsage: totalKwh * 0.95,
        previousWeekAverage: averageDailyKwh,
        previousMonthAverage: averageDailyKwh,
        typicalPeakHours: [18, 19, 20, 21],
        typicalLowHours: [1, 2, 3, 4],
        weekendAverage: averageDailyKwh * 0.9,
        weekdayAverage: averageDailyKwh * 1.1,
        holidayAverage: averageDailyKwh * 0.8,
      ),
    );
  }

  Future<List<DailyConsumption>> fetchDailyConsumptionRange(
    DateTime startDate,
    DateTime endDate,
    String accountId,
  ) async {
    final days = endDate.difference(startDate).inDays + 1;
    final consumptionList = <DailyConsumption>[];
    
    for (int i = 0; i < days; i++) {
      final date = startDate.add(Duration(days: i));
      final consumption = await fetchDailyConsumption(date, accountId);
      consumptionList.add(consumption);
    }
    
    return consumptionList;
  }

  double _calculateStandardDeviation(List<HourlyConsumption> hourlyData) {
    if (hourlyData.isEmpty) return 0;
    
    final mean = hourlyData.fold<double>(0, (sum, h) => sum + h.kwh) / hourlyData.length;
    final variance = hourlyData.fold<double>(0, (sum, h) => sum + (h.kwh - mean) * (h.kwh - mean)) / hourlyData.length;
    return sqrt(variance);
  }
}

// Repository provider
final consumptionRepositoryProvider = Provider<ConsumptionRepository>((ref) => ConsumptionRepository());

// Daily consumption provider
final dailyConsumptionProvider = FutureProvider.family<DailyConsumption, DateTime>((ref, date) async {
  final repository = ref.read(consumptionRepositoryProvider);
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  return repository.fetchDailyConsumption(date, activeAccountId);
});

// Daily consumption range provider
final dailyConsumptionRangeProvider = FutureProvider.family<List<DailyConsumption>, ({DateTime startDate, DateTime endDate})>((ref, params) async {
  final repository = ref.read(consumptionRepositoryProvider);
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  return repository.fetchDailyConsumptionRange(params.startDate, params.endDate, activeAccountId);
});

// Current consumption provider (today's data)
final currentConsumptionProvider = FutureProvider<DailyConsumption>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repository = ref.read(consumptionRepositoryProvider);
  return repository.fetchDailyConsumption(DateTime.now(), activeAccountId);
});

// Last 30 days consumption provider
final last30DaysConsumptionProvider = FutureProvider<List<DailyConsumption>>((ref) async {
  // Depend on active account so this refetches when user switches accounts
  final activeAccountId = ref.watch(accountSwitcherProvider).activeAccountId;
  final repository = ref.read(consumptionRepositoryProvider);
  final endDate = DateTime.now();
  final startDate = endDate.subtract(const Duration(days: 29));
  return repository.fetchDailyConsumptionRange(startDate, endDate, activeAccountId);
});

// Consumption refresh provider
final consumptionRefreshProvider = Provider<void Function()>((ref) => () {
    ref.invalidate(currentConsumptionProvider);
    ref.invalidate(last30DaysConsumptionProvider);
  });

// Chart state provider
final chartStateProvider = StateNotifierProvider<ChartStateNotifier, ChartState>((ref) => ChartStateNotifier());

// Chart state class
class ChartState {

  const ChartState({
    this.isHourlyChart = true,
    this.selectedHour,
    this.selectedDate,
    this.showZoomControls = false,
    this.zoomLevel = 1.0,
    this.panOffset = 0.0,
  });
  final bool isHourlyChart;
  final int? selectedHour;
  final DateTime? selectedDate;
  final bool showZoomControls;
  final double zoomLevel;
  final double panOffset;

  ChartState copyWith({
    bool? isHourlyChart,
    int? selectedHour,
    DateTime? selectedDate,
    bool? showZoomControls,
    double? zoomLevel,
    double? panOffset,
  }) => ChartState(
      isHourlyChart: isHourlyChart ?? this.isHourlyChart,
      selectedHour: selectedHour ?? this.selectedHour,
      selectedDate: selectedDate ?? this.selectedDate,
      showZoomControls: showZoomControls ?? this.showZoomControls,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      panOffset: panOffset ?? this.panOffset,
    );
}

// Chart state notifier
class ChartStateNotifier extends StateNotifier<ChartState> {
  ChartStateNotifier() : super(const ChartState());

  void toggleChartType() {
    state = state.copyWith(isHourlyChart: !state.isHourlyChart);
  }

  void selectHour(int hour) {
    state = state.copyWith(selectedHour: hour);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void toggleZoomControls() {
    state = state.copyWith(showZoomControls: !state.showZoomControls);
  }

  void setZoomLevel(double zoomLevel) {
    state = state.copyWith(zoomLevel: zoomLevel);
  }

  void setPanOffset(double panOffset) {
    state = state.copyWith(panOffset: panOffset);
  }

  void clearSelection() {
    state = state.copyWith(
      selectedHour: null,
      selectedDate: null,
    );
  }

  void reset() {
    state = const ChartState();
  }
}
