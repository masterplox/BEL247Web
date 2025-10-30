import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart';
import '../../../data/models/consumption.dart';

class ConsumptionRepository {
  Future<DailyConsumption> fetchDailyConsumption(DateTime date, String accountId) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Generate realistic daily data
    final hourlyBreakdown = List.generate(24, (hour) {
      double baseUsage = 1.5;
      if (hour >= 6 && hour <= 9) {
        baseUsage = 2.5; // Morning peak
      } else if (hour >= 18 && hour <= 22) {
        baseUsage = 3.5; // Evening peak
      } else if (hour >= 23 || hour <= 5) {
        baseUsage = 0.8; // Night low usage
      }
      
      // Add some randomness based on date
      final random = (hour * date.day * 0.1) % 1.0;
      final usage = baseUsage + (random - 0.5) * 0.8;
      
      return HourlyConsumption(
        hour: hour,
        kwh: usage.clamp(0.1, 5.0),
        cost: usage.clamp(0.1, 5.0) * 0.12, // $0.12 per kWh
      );
    });
    
    final totalKwh = hourlyBreakdown.fold<double>(0, (sum, h) => sum + h.kwh);
    final cost = totalKwh * 0.12;
    
    return DailyConsumption(
      date: date,
      totalKwh: totalKwh,
      cost: cost,
      hourlyBreakdown: hourlyBreakdown,
      peakUsages: [
        PeakUsage(
          hour: 19,
          kwh: 3.5,
          cost: 0.42,
          timestamp: date,
          reason: 'Evening peak usage',
        ),
      ],
      lowUsages: [
        LowUsage(
          hour: 3,
          kwh: 0.8,
          cost: 0.096,
          timestamp: date,
          reason: 'Night low usage',
        ),
      ],
      averageHourlyUsage: totalKwh / 24,
      peakHourlyUsage: hourlyBreakdown.map((h) => h.kwh).reduce((a, b) => a > b ? a : b),
      lowestHourlyUsage: hourlyBreakdown.map((h) => h.kwh).reduce((a, b) => a < b ? a : b),
      standardDeviation: _calculateStandardDeviation(hourlyBreakdown),
      alerts: [],
      pattern: ConsumptionPattern(
        previousDayUsage: totalKwh - 2.0,
        previousWeekAverage: 42.8,
        previousMonthAverage: 38.2,
        typicalPeakHours: [18, 19, 20, 21],
        typicalLowHours: [1, 2, 3, 4],
        weekendAverage: 35,
        weekdayAverage: 45.2,
        holidayAverage: 30,
      ),
    );
  }

  Future<List<DailyConsumption>> fetchDailyConsumptionRange(
    DateTime startDate,
    DateTime endDate,
    String accountId,
  ) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));
    
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
