import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/consumption.dart';
import '../services/cost_calculation_service.dart';

/// State for daily bill data
class DailyBillState {
  const DailyBillState({
    this.currentConsumption,
    this.previousConsumption,
    this.isLoading = false,
    this.error,
    this.costCalculation,
    this.costSavings,
    this.alerts = const [],
  });

  final DailyConsumption? currentConsumption;
  final DailyConsumption? previousConsumption;
  final bool isLoading;
  final String? error;
  final CostCalculationResult? costCalculation;
  final CostSavings? costSavings;
  final List<UsageAlert> alerts;

  DailyBillState copyWith({
    DailyConsumption? currentConsumption,
    DailyConsumption? previousConsumption,
    bool? isLoading,
    String? error,
    CostCalculationResult? costCalculation,
    CostSavings? costSavings,
    List<UsageAlert>? alerts,
  }) => DailyBillState(
      currentConsumption: currentConsumption ?? this.currentConsumption,
      previousConsumption: previousConsumption ?? this.previousConsumption,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      costCalculation: costCalculation ?? this.costCalculation,
      costSavings: costSavings ?? this.costSavings,
      alerts: alerts ?? this.alerts,
    );

  /// Check if there are any alerts
  bool get hasAlerts => alerts.isNotEmpty;

  /// Get unread alerts count
  int get unreadAlertsCount => alerts.where((alert) => !alert.isRead).length;

  /// Get alerts by severity
  List<UsageAlert> getAlertsBySeverity(AlertSeverity severity) => alerts.where((alert) => alert.severity == severity).toList();

  /// Get critical alerts
  List<UsageAlert> get criticalAlerts => getAlertsBySeverity(AlertSeverity.critical);

  /// Get high severity alerts
  List<UsageAlert> get highAlerts => getAlertsBySeverity(AlertSeverity.high);

  /// Check if there are critical alerts
  bool get hasCriticalAlerts => criticalAlerts.isNotEmpty;

  /// Get usage trend
  UsageTrend get usageTrend {
    if (currentConsumption == null) return UsageTrend.unknown;
    return currentConsumption!.usageTrend;
  }

  /// Get efficiency score
  double get efficiencyScore {
    if (currentConsumption == null) return 0;
    return currentConsumption!.efficiencyScore;
  }

  /// Check if usage is above average
  bool get isAboveAverage {
    if (currentConsumption == null) return false;
    return currentConsumption!.isAboveAverage;
  }
}

/// Notifier for managing daily bill state
class DailyBillNotifier extends StateNotifier<DailyBillState> {
  DailyBillNotifier() : super(const DailyBillState());

  /// Load daily consumption data
  Future<void> loadDailyConsumption(DateTime date) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call - replace with actual repository call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data - replace with actual data fetching
      final currentConsumption = _getMockDailyConsumption(date);
      final previousConsumption = _getMockDailyConsumption(date.subtract(const Duration(days: 1)));
      
      // Calculate costs
      final costCalculation = CostCalculationService.calculateDailyCost(currentConsumption);
      final costSavings = CostCalculationService.calculateCostSavings(
        currentConsumption,
        previousConsumption,
      );
      
      // Generate alerts based on consumption
      final alerts = _generateAlerts(currentConsumption, previousConsumption);

      state = state.copyWith(
        currentConsumption: currentConsumption,
        previousConsumption: previousConsumption,
        costCalculation: costCalculation,
        costSavings: costSavings,
        alerts: alerts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh current data
  Future<void> refresh() async {
    if (state.currentConsumption != null) {
      await loadDailyConsumption(state.currentConsumption!.date);
    }
  }

  /// Mark alert as read
  void markAlertAsRead(String alertId) {
    final updatedAlerts = state.alerts.map((alert) {
      if (alert.id == alertId) {
        return alert.copyWith(isRead: true);
      }
      return alert;
    }).toList();

    state = state.copyWith(alerts: updatedAlerts);
  }

  /// Mark all alerts as read
  void markAllAlertsAsRead() {
    final updatedAlerts = state.alerts.map((alert) => alert.copyWith(isRead: true)).toList();
    state = state.copyWith(alerts: updatedAlerts);
  }

  /// Dismiss alert
  void dismissAlert(String alertId) {
    final updatedAlerts = state.alerts.where((alert) => alert.id != alertId).toList();
    state = state.copyWith(alerts: updatedAlerts);
  }

  /// Clear all alerts
  void clearAllAlerts() {
    state = state.copyWith(alerts: []);
  }

  /// Add custom alert
  void addAlert(UsageAlert alert) {
    final updatedAlerts = [...state.alerts, alert];
    state = state.copyWith(alerts: updatedAlerts);
  }

  /// Update consumption data
  void updateConsumption(DailyConsumption consumption) {
    final costCalculation = CostCalculationService.calculateDailyCost(consumption);
    final costSavings = state.previousConsumption != null
        ? CostCalculationService.calculateCostSavings(consumption, state.previousConsumption)
        : null;

    state = state.copyWith(
      currentConsumption: consumption,
      costCalculation: costCalculation,
      costSavings: costSavings,
    );
  }

  /// Set previous consumption for comparison
  void setPreviousConsumption(DailyConsumption consumption) {
    final costSavings = state.currentConsumption != null
        ? CostCalculationService.calculateCostSavings(state.currentConsumption!, consumption)
        : null;

    state = state.copyWith(
      previousConsumption: consumption,
      costSavings: costSavings,
    );
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset state
  void reset() {
    state = const DailyBillState();
  }

  /// Generate alerts based on consumption data
  List<UsageAlert> _generateAlerts(
    DailyConsumption current,
    DailyConsumption? previous,
  ) {
    final alerts = <UsageAlert>[];

    // High usage alert
    if (current.isAboveAverage) {
      alerts.add(UsageAlert(
        id: 'high_usage_${current.date.millisecondsSinceEpoch}',
        type: AlertType.highUsage,
        message: 'Your usage is above average for this day',
        timestamp: DateTime.now(),
        severity: AlertSeverity.medium,
        metadata: {
          'currentUsage': current.totalKwh,
          'averageUsage': current.averageHourlyUsage * 24,
        },
      ));
    }

    // Efficiency alert
    if (current.efficiencyScore < 60) {
      alerts.add(UsageAlert(
        id: 'efficiency_${current.date.millisecondsSinceEpoch}',
        type: AlertType.efficiencyAlert,
        message: 'Your usage pattern is inefficient. Consider spreading consumption throughout the day.',
        timestamp: DateTime.now(),
        severity: AlertSeverity.low,
        metadata: {
          'efficiencyScore': current.efficiencyScore,
        },
      ));
    }

    // Cost alert
    if (current.cost > 50) {
      alerts.add(UsageAlert(
        id: 'cost_${current.date.millisecondsSinceEpoch}',
        type: AlertType.costAlert,
        message: 'Daily cost is higher than usual. Check your usage patterns.',
        timestamp: DateTime.now(),
        severity: AlertSeverity.medium,
        metadata: {
          'cost': current.cost,
        },
      ));
    }

    // Peak hour alert
    final peakHours = current.peakUsageHours;
    if (peakHours.isNotEmpty && peakHours.first <= 8) {
      alerts.add(UsageAlert(
        id: 'peak_hour_${current.date.millisecondsSinceEpoch}',
        type: AlertType.peakHourAlert,
        message: 'High usage detected during peak hours. Consider shifting some usage to off-peak times.',
        timestamp: DateTime.now(),
        severity: AlertSeverity.low,
        metadata: {
          'peakHours': peakHours,
        },
      ));
    }

    return alerts;
  }

  /// Mock data generation - replace with actual repository calls
  DailyConsumption _getMockDailyConsumption(DateTime date) {
    // This is a simplified mock - replace with actual data fetching
    return DailyConsumption(
      date: date,
      totalKwh: 25.5 + (date.day % 10) * 2.5,
      cost: 0,
      hourlyBreakdown: List.generate(24, (hour) => HourlyConsumption(
        hour: hour,
        kwh: 0.8 + (hour % 6) * 0.3,
        cost: 0,
      )),
      peakUsages: [
        PeakUsage(
          hour: 18,
          kwh: 2.5,
          cost: 0,
          timestamp: DateTime.now(),
          reason: 'Evening peak',
        ),
      ],
      lowUsages: [
        LowUsage(
          hour: 3,
          kwh: 0.2,
          cost: 0,
          timestamp: DateTime.now(),
          reason: 'Night time',
        ),
      ],
      averageHourlyUsage: 1.1,
      peakHourlyUsage: 2.5,
      lowestHourlyUsage: 0.2,
      standardDeviation: 0.8,
      pattern: const ConsumptionPattern(
        previousDayUsage: 23.2,
        previousWeekAverage: 24.8,
        previousMonthAverage: 26.1,
        typicalPeakHours: [18, 19, 20],
        typicalLowHours: [2, 3, 4],
        weekendAverage: 22.5,
        weekdayAverage: 25.8,
        holidayAverage: 20.1,
      ),
    );
  }
}

/// Provider for daily bill state
final dailyBillProvider = StateNotifierProvider<DailyBillNotifier, DailyBillState>((ref) => DailyBillNotifier());

/// Provider for current consumption data
final currentConsumptionProvider = Provider<DailyConsumption?>((ref) => ref.watch(dailyBillProvider).currentConsumption);

/// Provider for previous consumption data
final previousConsumptionProvider = Provider<DailyConsumption?>((ref) => ref.watch(dailyBillProvider).previousConsumption);

/// Provider for cost calculation result
final costCalculationProvider = Provider<CostCalculationResult?>((ref) => ref.watch(dailyBillProvider).costCalculation);

/// Provider for cost savings
final costSavingsProvider = Provider<CostSavings?>((ref) => ref.watch(dailyBillProvider).costSavings);

/// Provider for alerts
final alertsProvider = Provider<List<UsageAlert>>((ref) => ref.watch(dailyBillProvider).alerts);

/// Provider for unread alerts count
final unreadAlertsCountProvider = Provider<int>((ref) => ref.watch(dailyBillProvider).unreadAlertsCount);

/// Provider for critical alerts
final criticalAlertsProvider = Provider<List<UsageAlert>>((ref) => ref.watch(dailyBillProvider).criticalAlerts);

/// Provider for usage trend
final usageTrendProvider = Provider<UsageTrend>((ref) => ref.watch(dailyBillProvider).usageTrend);

/// Provider for efficiency score
final efficiencyScoreProvider = Provider<double>((ref) => ref.watch(dailyBillProvider).efficiencyScore);

/// Provider for loading state
final dailyBillLoadingProvider = Provider<bool>((ref) => ref.watch(dailyBillProvider).isLoading);

/// Provider for error state
final dailyBillErrorProvider = Provider<String?>((ref) => ref.watch(dailyBillProvider).error);
