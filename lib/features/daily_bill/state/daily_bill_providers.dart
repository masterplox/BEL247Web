import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart' hide CostCalculationResult, CostSavings;
import '../../../data/models/consumption.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';
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
  DailyBillNotifier(this._ref) : super(const DailyBillState()) {
    // Listen to account changes and reload data
    _ref.listen(accountSwitcherProvider, (_, __) {
      final id = _accountId;
      if (state.currentConsumption != null) {
        loadDailyConsumption(state.currentConsumption!.date);
      }
    });
    // Initial account
  }

  final Ref _ref;
  
  String get _accountId => _ref.read(accountSwitcherProvider).activeAccountId;

  /// Load daily consumption data
  Future<void> loadDailyConsumption(DateTime date) async {
    // Capture accountId at start of async operation
    final accountId = _accountId;
    
    try {
      state = state.copyWith(isLoading: true, error: null);
    } catch (e) {
      // Ignore if notifier was disposed
      return;
    }

    try {
      // Simulate API call - replace with actual repository call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Check if account changed during async operation
      if (_accountId != accountId) {
        return;
      }
      
      // Mock data - generate account-specific data
      final currentConsumption = await _getMockDailyConsumption(date, accountId);
      final previousConsumption = await _getMockDailyConsumption(date.subtract(const Duration(days: 1)), accountId);
      
      // Check if account changed during async operations
      if (_accountId != accountId) {
        return;
      }
      
      // Calculate costs
      final costCalculation = CostCalculationService.calculateDailyCost(currentConsumption);
      final costSavings = CostCalculationService.calculateCostSavings(
        currentConsumption,
        previousConsumption,
      );
      
      // Generate alerts based on consumption
      final alerts = _generateAlerts(currentConsumption, previousConsumption);

      // Check if account changed before updating state
      if (_accountId != accountId) {
        return;
      }
      
      try {
        state = state.copyWith(
          currentConsumption: currentConsumption,
          previousConsumption: previousConsumption,
          costCalculation: costCalculation,
          costSavings: costSavings,
          alerts: alerts,
          isLoading: false,
        );
      } catch (e) {
        // Ignore if notifier was disposed during state update
        return;
      }
    } catch (e) {
      // Check if account changed or notifier was disposed
      if (_accountId != accountId) return;
      try {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
      } catch (_) {
        // Ignore if notifier was disposed
        return;
      }
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

  /// Mock data generation - generates account-specific data based on account's average daily usage
  Future<DailyConsumption> _getMockDailyConsumption(DateTime date, String accountId) async {
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
      // Add some variation based on date to make it feel more realistic
      final variation = 1.0 + ((date.day % 10 - 5) / 50);
      final kwh = (baseHourlyKwh * multiplier * variation).clamp(0.1, 10.0);
      return HourlyConsumption(
        hour: hour,
        kwh: kwh,
        cost: kwh * 0.12, // $0.12 per kWh
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
          reason: 'Evening peak',
        ),
      ],
      lowUsages: [
        LowUsage(
          hour: lowHour,
          kwh: lowestUsage,
          cost: lowestUsage * 0.12,
          timestamp: date.add(Duration(hours: lowHour)),
          reason: 'Night time',
        ),
      ],
      averageHourlyUsage: totalKwh / 24,
      peakHourlyUsage: peakUsage,
      lowestHourlyUsage: lowestUsage,
      standardDeviation: _calculateStandardDeviation(hourlyBreakdown),
      pattern: ConsumptionPattern(
        previousDayUsage: totalKwh * 0.95,
        previousWeekAverage: averageDailyKwh,
        previousMonthAverage: averageDailyKwh,
        typicalPeakHours: [18, 19, 20],
        typicalLowHours: [2, 3, 4],
        weekendAverage: averageDailyKwh * 0.9,
        weekdayAverage: averageDailyKwh * 1.1,
        holidayAverage: averageDailyKwh * 0.8,
      ),
    );
  }
  
  double _calculateStandardDeviation(List<HourlyConsumption> hourlyData) {
    if (hourlyData.isEmpty) return 0;
    final mean = hourlyData.fold<double>(0, (sum, h) => sum + h.kwh) / hourlyData.length;
    final variance = hourlyData.fold<double>(
      0,
      (sum, h) => sum + (h.kwh - mean) * (h.kwh - mean),
    ) / hourlyData.length;
    return variance;
  }
}

/// Provider for daily bill state - watches account switcher to reload when account changes
final dailyBillProvider = StateNotifierProvider<DailyBillNotifier, DailyBillState>(DailyBillNotifier.new);

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
