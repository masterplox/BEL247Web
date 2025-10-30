import '../../../data/models/consumption.dart';

/// Service for calculating electricity costs based on consumption data
class CostCalculationService {
  /// Base electricity rate per kWh (in USD)
  static const double baseRatePerKwh = 0.12;
  
  /// Service fee per day (in USD)
  static const double dailyServiceFee = 5;
  
  /// Peak hour rate multiplier (applied during peak hours)
  static const double peakHourMultiplier = 1.5;
  
  /// Off-peak hour rate multiplier (applied during off-peak hours)
  static const double offPeakHourMultiplier = 0.8;
  
  /// Peak hours (6 AM - 9 AM and 5 PM - 8 PM)
  static const List<int> peakHours = [6, 7, 8, 17, 18, 19];
  
  /// Off-peak hours (10 PM - 5 AM)
  static const List<int> offPeakHours = [22, 23, 0, 1, 2, 3, 4];

  /// Calculate total cost for daily consumption
  static CostCalculationResult calculateDailyCost(DailyConsumption consumption) {
    try {
      // Calculate energy charges by hour
      double totalEnergyCharge = 0;
      final hourlyCharges = <HourlyCharge>[];
      
      for (final hourly in consumption.hourlyBreakdown) {
        final rate = _getHourlyRate(hourly.hour);
        final charge = hourly.kwh * rate;
        
        totalEnergyCharge += charge;
        hourlyCharges.add(HourlyCharge(
          hour: hourly.hour,
          kwh: hourly.kwh,
          rate: rate,
          charge: charge,
        ));
      }
      
      // Calculate service fee
      const serviceFee = dailyServiceFee;
      
      // Calculate total cost
      final totalCost = totalEnergyCharge + serviceFee;
      
      // Calculate cost breakdown
      final costBreakdown = CostBreakdown(
        energyCharge: totalEnergyCharge,
        serviceFee: serviceFee,
        totalCost: totalCost,
        peakHourCost: hourlyCharges
            .where((h) => peakHours.contains(h.hour))
            .fold(0, (sum, h) => sum + h.charge),
        offPeakHourCost: hourlyCharges
            .where((h) => offPeakHours.contains(h.hour))
            .fold(0, (sum, h) => sum + h.charge),
        standardHourCost: hourlyCharges
            .where((h) => !peakHours.contains(h.hour) && !offPeakHours.contains(h.hour))
            .fold(0, (sum, h) => sum + h.charge),
      );
      
      return CostCalculationResult(
        totalCost: totalCost,
        costBreakdown: costBreakdown,
        hourlyCharges: hourlyCharges,
        isValid: true,
      );
    } catch (e) {
      return CostCalculationResult(
        totalCost: 0,
        costBreakdown: const CostBreakdown.empty(),
        hourlyCharges: [],
        isValid: false,
        error: e.toString(),
      );
    }
  }

  /// Calculate cost for hourly consumption
  static double calculateHourlyCost(HourlyConsumption hourly) {
    final rate = _getHourlyRate(hourly.hour);
    return hourly.kwh * rate;
  }

  /// Get the rate for a specific hour based on time-of-use pricing
  static double _getHourlyRate(int hour) {
    if (peakHours.contains(hour)) {
      return baseRatePerKwh * peakHourMultiplier;
    } else if (offPeakHours.contains(hour)) {
      return baseRatePerKwh * offPeakHourMultiplier;
    } else {
      return baseRatePerKwh;
    }
  }

  /// Calculate estimated monthly cost based on daily consumption
  static double calculateEstimatedMonthlyCost(DailyConsumption dailyConsumption) {
    final dailyCost = calculateDailyCost(dailyConsumption);
    return dailyCost.totalCost * 30; // Approximate monthly cost
  }

  /// Calculate cost savings compared to previous period
  static CostSavings calculateCostSavings(
    DailyConsumption current,
    DailyConsumption? previous,
  ) {
    if (previous == null) {
      return const CostSavings(
        amountSaved: 0,
        percentageSaved: 0,
        isSavings: false,
      );
    }

    final currentCost = calculateDailyCost(current).totalCost;
    final previousCost = calculateDailyCost(previous).totalCost;
    
    final amountSaved = previousCost - currentCost;
    final percentageSaved = previousCost > 0 ? (amountSaved / previousCost) * 100.0 : 0.0;
    
    return CostSavings(
      amountSaved: amountSaved,
      percentageSaved: percentageSaved,
      isSavings: amountSaved > 0,
    );
  }

  /// Validate cost calculation parameters
  static ValidationResult validateCalculationParameters({
    required double totalKwh,
    required double ratePerKwh,
    required double serviceFee,
  }) {
    final errors = <String>[];

    if (totalKwh < 0) {
      errors.add('Total kWh cannot be negative');
    }
    if (ratePerKwh < 0) {
      errors.add('Rate per kWh cannot be negative');
    }
    if (serviceFee < 0) {
      errors.add('Service fee cannot be negative');
    }
    if (totalKwh > 1000) {
      errors.add('Total kWh seems unusually high (>1000 kWh)');
    }
    if (ratePerKwh > 1.0) {
      errors.add(r'Rate per kWh seems unusually high (>$1.00)');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Result of cost calculation
class CostCalculationResult {
  const CostCalculationResult({
    required this.totalCost,
    required this.costBreakdown,
    required this.hourlyCharges,
    required this.isValid,
    this.error,
  });

  final double totalCost;
  final CostBreakdown costBreakdown;
  final List<HourlyCharge> hourlyCharges;
  final bool isValid;
  final String? error;

  /// Get formatted total cost string
  String get formattedTotalCost => '\$${totalCost.toStringAsFixed(2)}';

  /// Get formatted energy charge string
  String get formattedEnergyCharge => '\$${costBreakdown.energyCharge.toStringAsFixed(2)}';

  /// Get formatted service fee string
  String get formattedServiceFee => '\$${costBreakdown.serviceFee.toStringAsFixed(2)}';
}

/// Breakdown of cost components
class CostBreakdown {
  const CostBreakdown({
    required this.energyCharge,
    required this.serviceFee,
    required this.totalCost,
    required this.peakHourCost,
    required this.offPeakHourCost,
    required this.standardHourCost,
  });

  const CostBreakdown.empty()
      : energyCharge = 0,
        serviceFee = 0,
        totalCost = 0,
        peakHourCost = 0,
        offPeakHourCost = 0,
        standardHourCost = 0;

  final double energyCharge;
  final double serviceFee;
  final double totalCost;
  final double peakHourCost;
  final double offPeakHourCost;
  final double standardHourCost;

  /// Get peak hour cost percentage
  double get peakHourCostPercentage => totalCost > 0 ? (peakHourCost / totalCost) * 100 : 0;

  /// Get off-peak hour cost percentage
  double get offPeakHourCostPercentage => totalCost > 0 ? (offPeakHourCost / totalCost) * 100 : 0;

  /// Get standard hour cost percentage
  double get standardHourCostPercentage => totalCost > 0 ? (standardHourCost / totalCost) * 100 : 0;
}

/// Hourly charge breakdown
class HourlyCharge {
  const HourlyCharge({
    required this.hour,
    required this.kwh,
    required this.rate,
    required this.charge,
  });

  final int hour;
  final double kwh;
  final double rate;
  final double charge;

  /// Get formatted hour string
  String get formattedHour => '${hour.toString().padLeft(2, '0')}:00';

  /// Get formatted charge string
  String get formattedCharge => '\$${charge.toStringAsFixed(2)}';

  /// Get formatted rate string
  String get formattedRate => '\$${rate.toStringAsFixed(3)}/kWh';

  /// Check if this is a peak hour
  bool get isPeakHour => CostCalculationService.peakHours.contains(hour);

  /// Check if this is an off-peak hour
  bool get isOffPeakHour => CostCalculationService.offPeakHours.contains(hour);

  /// Get rate type description
  String get rateTypeDescription {
    if (isPeakHour) return 'Peak Rate';
    if (isOffPeakHour) return 'Off-Peak Rate';
    return 'Standard Rate';
  }
}

/// Cost savings calculation result
class CostSavings {
  const CostSavings({
    required this.amountSaved,
    required this.percentageSaved,
    required this.isSavings,
  });

  final double amountSaved;
  final double percentageSaved;
  final bool isSavings;

  /// Get formatted amount saved string
  String get formattedAmountSaved => '\$${amountSaved.abs().toStringAsFixed(2)}';

  /// Get formatted percentage saved string
  String get formattedPercentageSaved => '${percentageSaved.abs().toStringAsFixed(1)}%';

  /// Get savings description
  String get description {
    if (isSavings) {
      return 'You saved $formattedAmountSaved ($formattedPercentageSaved) compared to the previous period';
    } else {
      return 'You spent $formattedAmountSaved ($formattedPercentageSaved) more compared to the previous period';
    }
  }
}

/// Validation result for cost calculations
class ValidationResult {
  const ValidationResult({
    required this.isValid,
    required this.errors,
  });

  final bool isValid;
  final List<String> errors;

  String get errorMessage => errors.join(', ');
}
