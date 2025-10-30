import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String accountNumber,
    required String billNumber,
    required BillingPeriod billingPeriod,
    required DateTime dueDate,
    required DateTime issueDate,
    required String status,
    required BillAmounts amounts,
    required BillUsage usage,
    required BillPayment payment,
    required String pdfUrl,
    @Default([]) List<PaymentHistory> paymentHistory,
    @Default([]) List<BillAdjustment> adjustments,
    @Default([]) List<BillFee> fees,
    @Default([]) List<BillTax> taxes,
    @Default([]) List<BillDiscount> discounts,
    @Default(BillCalculations()) BillCalculations calculations,
    @Default([]) List<BillNote> notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Bill;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  const Bill._();

  /// Validate bill data
  ValidationResult validate() {
    final errors = <String>[];

    // Validate required fields
    if (id.trim().isEmpty) {
      errors.add('Bill ID is required');
    }
    if (accountNumber.trim().isEmpty) {
      errors.add('Account number is required');
    }
    if (billNumber.trim().isEmpty) {
      errors.add('Bill number is required');
    }

    // Validate dates
    if (dueDate.isBefore(issueDate)) {
      errors.add('Due date cannot be before issue date');
    }
    if (billingPeriod.endDate.isBefore(billingPeriod.startDate)) {
      errors.add('Billing period end date cannot be before start date');
    }

    // Validate amounts
    if (amounts.totalAmount < 0) {
      errors.add('Total amount cannot be negative');
    }
    if (amounts.currentCharges < 0) {
      errors.add('Current charges cannot be negative');
    }

    // Validate usage
    if (usage.kwhUsed < 0) {
      errors.add('Usage cannot be negative');
    }
    if (usage.kwhRate < 0) {
      errors.add('Rate cannot be negative');
    }

    // Validate payment history
    for (final payment in paymentHistory) {
      final paymentErrors = payment.validate();
      if (!paymentErrors.isValid) {
        errors.addAll(paymentErrors.errors.map((e) => 'Payment: $e'));
      }
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Check if bill is overdue
  bool get isOverdue => DateTime.now().isAfter(dueDate) && status != BillStatus.paid.name;

  /// Check if bill is paid
  bool get isPaid => status == BillStatus.paid.name;

  /// Get days until due
  int get daysUntilDue => dueDate.difference(DateTime.now()).inDays;

  /// Get total paid amount
  double get totalPaidAmount => paymentHistory.fold(0, (sum, payment) => sum + payment.amount);

  /// Get remaining balance
  double get remainingBalance => amounts.totalAmount - totalPaidAmount;

  /// Get payment status
  PaymentStatus get paymentStatus {
    if (isPaid) return PaymentStatus.completed;
    if (isOverdue) return PaymentStatus.overdue;
    if (daysUntilDue <= 7) return PaymentStatus.dueSoon;
    return PaymentStatus.pending;
  }

  /// Get billing period duration in days
  int get billingPeriodDays => billingPeriod.endDate.difference(billingPeriod.startDate).inDays;

  /// Get average daily cost
  double get averageDailyCost => amounts.totalAmount / billingPeriodDays;

  /// Get usage cost breakdown
  Map<String, double> get usageCostBreakdown => {
    'Base Charge': usage.baseCharge,
    'Delivery Charge': usage.deliveryCharge,
    'Generation Charge': usage.generationCharge,
    'Total Usage Cost': usage.baseCharge + usage.deliveryCharge + usage.generationCharge,
  };
}

@freezed
class BillingPeriod with _$BillingPeriod {
  const factory BillingPeriod({
    required DateTime startDate,
    required DateTime endDate,
  }) = _BillingPeriod;

  factory BillingPeriod.fromJson(Map<String, dynamic> json) => _$BillingPeriodFromJson(json);
}

@freezed
class BillAmounts with _$BillAmounts {
  const factory BillAmounts({
    required double totalAmount,
    required double previousBalance,
    required double currentCharges,
    required double taxes,
    required double fees,
    required double adjustments,
    @Default(0.0) double discounts,
    @Default(0.0) double lateFees,
    @Default(0.0) double paymentFees,
    @Default(0.0) double serviceCharges,
  }) = _BillAmounts;

  factory BillAmounts.fromJson(Map<String, dynamic> json) => _$BillAmountsFromJson(json);

  const BillAmounts._();

  /// Get subtotal before taxes and fees
  double get subtotal => previousBalance + currentCharges + adjustments - discounts;

  /// Get total after all charges
  double get grandTotal => subtotal + taxes + fees + lateFees + paymentFees + serviceCharges;

  /// Validate amounts
  ValidationResult validate() {
    final errors = <String>[];

    if (totalAmount < 0) {
      errors.add('Total amount cannot be negative');
    }
    if (currentCharges < 0) {
      errors.add('Current charges cannot be negative');
    }
    if (taxes < 0) {
      errors.add('Taxes cannot be negative');
    }
    if (fees < 0) {
      errors.add('Fees cannot be negative');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

@freezed
class BillUsage with _$BillUsage {
  const factory BillUsage({
    required double kwhUsed,
    required double kwhRate,
    required double baseCharge,
    required double deliveryCharge,
    required double generationCharge,
  }) = _BillUsage;

  factory BillUsage.fromJson(Map<String, dynamic> json) => _$BillUsageFromJson(json);
}

@freezed
class BillPayment with _$BillPayment {
  const factory BillPayment({
    required DateTime paidDate,
    required double paidAmount,
    required String paymentMethod,
    required String transactionId,
  }) = _BillPayment;

  factory BillPayment.fromJson(Map<String, dynamic> json) => _$BillPaymentFromJson(json);
}

@freezed
class BillsResponse with _$BillsResponse {
  const factory BillsResponse({
    required List<Bill> bills,
    required BillsSummary summary,
  }) = _BillsResponse;

  factory BillsResponse.fromJson(Map<String, dynamic> json) => _$BillsResponseFromJson(json);
}

@freezed
class BillsSummary with _$BillsSummary {
  const factory BillsSummary({
    required int totalBills,
    required double totalPaid,
    required double averageMonthlyBill,
    required double highestBill,
    required double lowestBill,
    required DateTime lastPaymentDate,
    required DateTime nextDueDate,
    @Default(0.0) double totalOutstanding,
    @Default(0) int overdueBills,
    @Default(0.0) double averagePaymentTime,
  }) = _BillsSummary;

  factory BillsSummary.fromJson(Map<String, dynamic> json) => _$BillsSummaryFromJson(json);
}

@freezed
class PaymentHistory with _$PaymentHistory {
  const factory PaymentHistory({
    required String id,
    required double amount,
    required DateTime paymentDate,
    required String paymentMethod,
    required String transactionId,
    required PaymentStatus status,
    String? referenceNumber,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _PaymentHistory;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => _$PaymentHistoryFromJson(json);

  const PaymentHistory._();

  /// Validate payment data
  ValidationResult validate() {
    final errors = <String>[];

    if (amount <= 0) {
      errors.add('Payment amount must be positive');
    }
    if (paymentMethod.trim().isEmpty) {
      errors.add('Payment method is required');
    }
    if (transactionId.trim().isEmpty) {
      errors.add('Transaction ID is required');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Check if payment is successful
  bool get isSuccessful => status == PaymentStatus.completed;

  /// Get formatted payment date
  String get formattedPaymentDate => '${paymentDate.day}/${paymentDate.month}/${paymentDate.year}';
}

@freezed
class BillAdjustment with _$BillAdjustment {
  const factory BillAdjustment({
    required String id,
    required String type,
    required double amount,
    required String reason,
    required DateTime date,
    String? description,
    String? referenceNumber,
  }) = _BillAdjustment;

  factory BillAdjustment.fromJson(Map<String, dynamic> json) => _$BillAdjustmentFromJson(json);
}

@freezed
class BillFee with _$BillFee {
  const factory BillFee({
    required String id,
    required String name,
    required double amount,
    required String type,
    String? description,
    bool? isRecurring,
  }) = _BillFee;

  factory BillFee.fromJson(Map<String, dynamic> json) => _$BillFeeFromJson(json);
}

@freezed
class BillTax with _$BillTax {
  const factory BillTax({
    required String id,
    required String name,
    required double rate,
    required double amount,
    required String type,
    String? jurisdiction,
  }) = _BillTax;

  factory BillTax.fromJson(Map<String, dynamic> json) => _$BillTaxFromJson(json);
}

@freezed
class BillDiscount with _$BillDiscount {
  const factory BillDiscount({
    required String id,
    required String name,
    required double amount,
    required String type,
    String? description,
    DateTime? validUntil,
  }) = _BillDiscount;

  factory BillDiscount.fromJson(Map<String, dynamic> json) => _$BillDiscountFromJson(json);
}

@freezed
class BillCalculations with _$BillCalculations {
  const factory BillCalculations({
    @Default(0.0) double baseRate,
    @Default(0.0) double deliveryRate,
    @Default(0.0) double generationRate,
    @Default(0.0) double transmissionRate,
    @Default(0.0) double distributionRate,
    @Default(0.0) double regulatoryRate,
    @Default(0.0) double renewableEnergyRate,
    @Default(0.0) double energyEfficiencyRate,
    @Default(0.0) double totalRatePerKwh,
    @Default(0.0) double averageDailyUsage,
    @Default(0.0) double peakUsage,
    @Default(0.0) double offPeakUsage,
    @Default(0.0) double totalUsageCost,
  }) = _BillCalculations;

  factory BillCalculations.fromJson(Map<String, dynamic> json) => _$BillCalculationsFromJson(json);

  const BillCalculations._();

  /// Get total rate per kWh
  double get totalRate => baseRate + deliveryRate + generationRate + transmissionRate + 
                         distributionRate + regulatoryRate + renewableEnergyRate + energyEfficiencyRate;

  /// Get usage cost breakdown
  Map<String, double> get rateBreakdown => {
    'Base Rate': baseRate,
    'Delivery Rate': deliveryRate,
    'Generation Rate': generationRate,
    'Transmission Rate': transmissionRate,
    'Distribution Rate': distributionRate,
    'Regulatory Rate': regulatoryRate,
    'Renewable Energy Rate': renewableEnergyRate,
    'Energy Efficiency Rate': energyEfficiencyRate,
  };
}

@freezed
class BillNote with _$BillNote {
  const factory BillNote({
    required String id,
    required String content,
    required DateTime createdAt,
    required String createdBy,
    @Default(NoteType.info) NoteType type,
  }) = _BillNote;

  factory BillNote.fromJson(Map<String, dynamic> json) => _$BillNoteFromJson(json);
}

enum BillStatus {
  pending,
  paid,
  overdue,
  cancelled,
  disputed,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
  overdue,
  dueSoon,
}

enum NoteType {
  info,
  warning,
  error,
  success,
}

/// Validation result class
class ValidationResult {

  const ValidationResult({
    required this.isValid,
    required this.errors,
  });
  final bool isValid;
  final List<String> errors;

  String get errorMessage => errors.join(', ');
}
