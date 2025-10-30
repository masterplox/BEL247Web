// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillImpl _$$BillImplFromJson(Map<String, dynamic> json) => _$BillImpl(
  id: json['id'] as String,
  accountNumber: json['accountNumber'] as String,
  billNumber: json['billNumber'] as String,
  billingPeriod: BillingPeriod.fromJson(
    json['billingPeriod'] as Map<String, dynamic>,
  ),
  dueDate: DateTime.parse(json['dueDate'] as String),
  issueDate: DateTime.parse(json['issueDate'] as String),
  status: json['status'] as String,
  amounts: BillAmounts.fromJson(json['amounts'] as Map<String, dynamic>),
  usage: BillUsage.fromJson(json['usage'] as Map<String, dynamic>),
  payment: BillPayment.fromJson(json['payment'] as Map<String, dynamic>),
  pdfUrl: json['pdfUrl'] as String,
  paymentHistory:
      (json['paymentHistory'] as List<dynamic>?)
          ?.map((e) => PaymentHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  adjustments:
      (json['adjustments'] as List<dynamic>?)
          ?.map((e) => BillAdjustment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  fees:
      (json['fees'] as List<dynamic>?)
          ?.map((e) => BillFee.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  taxes:
      (json['taxes'] as List<dynamic>?)
          ?.map((e) => BillTax.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  discounts:
      (json['discounts'] as List<dynamic>?)
          ?.map((e) => BillDiscount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  calculations: json['calculations'] == null
      ? const BillCalculations()
      : BillCalculations.fromJson(json['calculations'] as Map<String, dynamic>),
  notes:
      (json['notes'] as List<dynamic>?)
          ?.map((e) => BillNote.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$BillImplToJson(_$BillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountNumber': instance.accountNumber,
      'billNumber': instance.billNumber,
      'billingPeriod': instance.billingPeriod,
      'dueDate': instance.dueDate.toIso8601String(),
      'issueDate': instance.issueDate.toIso8601String(),
      'status': instance.status,
      'amounts': instance.amounts,
      'usage': instance.usage,
      'payment': instance.payment,
      'pdfUrl': instance.pdfUrl,
      'paymentHistory': instance.paymentHistory,
      'adjustments': instance.adjustments,
      'fees': instance.fees,
      'taxes': instance.taxes,
      'discounts': instance.discounts,
      'calculations': instance.calculations,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$BillingPeriodImpl _$$BillingPeriodImplFromJson(Map<String, dynamic> json) =>
    _$BillingPeriodImpl(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$BillingPeriodImplToJson(_$BillingPeriodImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

_$BillAmountsImpl _$$BillAmountsImplFromJson(Map<String, dynamic> json) =>
    _$BillAmountsImpl(
      totalAmount: (json['totalAmount'] as num).toDouble(),
      previousBalance: (json['previousBalance'] as num).toDouble(),
      currentCharges: (json['currentCharges'] as num).toDouble(),
      taxes: (json['taxes'] as num).toDouble(),
      fees: (json['fees'] as num).toDouble(),
      adjustments: (json['adjustments'] as num).toDouble(),
      discounts: (json['discounts'] as num?)?.toDouble() ?? 0.0,
      lateFees: (json['lateFees'] as num?)?.toDouble() ?? 0.0,
      paymentFees: (json['paymentFees'] as num?)?.toDouble() ?? 0.0,
      serviceCharges: (json['serviceCharges'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BillAmountsImplToJson(_$BillAmountsImpl instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'previousBalance': instance.previousBalance,
      'currentCharges': instance.currentCharges,
      'taxes': instance.taxes,
      'fees': instance.fees,
      'adjustments': instance.adjustments,
      'discounts': instance.discounts,
      'lateFees': instance.lateFees,
      'paymentFees': instance.paymentFees,
      'serviceCharges': instance.serviceCharges,
    };

_$BillUsageImpl _$$BillUsageImplFromJson(Map<String, dynamic> json) =>
    _$BillUsageImpl(
      kwhUsed: (json['kwhUsed'] as num).toDouble(),
      kwhRate: (json['kwhRate'] as num).toDouble(),
      baseCharge: (json['baseCharge'] as num).toDouble(),
      deliveryCharge: (json['deliveryCharge'] as num).toDouble(),
      generationCharge: (json['generationCharge'] as num).toDouble(),
    );

Map<String, dynamic> _$$BillUsageImplToJson(_$BillUsageImpl instance) =>
    <String, dynamic>{
      'kwhUsed': instance.kwhUsed,
      'kwhRate': instance.kwhRate,
      'baseCharge': instance.baseCharge,
      'deliveryCharge': instance.deliveryCharge,
      'generationCharge': instance.generationCharge,
    };

_$BillPaymentImpl _$$BillPaymentImplFromJson(Map<String, dynamic> json) =>
    _$BillPaymentImpl(
      paidDate: DateTime.parse(json['paidDate'] as String),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$$BillPaymentImplToJson(_$BillPaymentImpl instance) =>
    <String, dynamic>{
      'paidDate': instance.paidDate.toIso8601String(),
      'paidAmount': instance.paidAmount,
      'paymentMethod': instance.paymentMethod,
      'transactionId': instance.transactionId,
    };

_$BillsResponseImpl _$$BillsResponseImplFromJson(Map<String, dynamic> json) =>
    _$BillsResponseImpl(
      bills: (json['bills'] as List<dynamic>)
          .map((e) => Bill.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: BillsSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BillsResponseImplToJson(_$BillsResponseImpl instance) =>
    <String, dynamic>{'bills': instance.bills, 'summary': instance.summary};

_$BillsSummaryImpl _$$BillsSummaryImplFromJson(Map<String, dynamic> json) =>
    _$BillsSummaryImpl(
      totalBills: (json['totalBills'] as num).toInt(),
      totalPaid: (json['totalPaid'] as num).toDouble(),
      averageMonthlyBill: (json['averageMonthlyBill'] as num).toDouble(),
      highestBill: (json['highestBill'] as num).toDouble(),
      lowestBill: (json['lowestBill'] as num).toDouble(),
      lastPaymentDate: DateTime.parse(json['lastPaymentDate'] as String),
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      totalOutstanding: (json['totalOutstanding'] as num?)?.toDouble() ?? 0.0,
      overdueBills: (json['overdueBills'] as num?)?.toInt() ?? 0,
      averagePaymentTime:
          (json['averagePaymentTime'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BillsSummaryImplToJson(_$BillsSummaryImpl instance) =>
    <String, dynamic>{
      'totalBills': instance.totalBills,
      'totalPaid': instance.totalPaid,
      'averageMonthlyBill': instance.averageMonthlyBill,
      'highestBill': instance.highestBill,
      'lowestBill': instance.lowestBill,
      'lastPaymentDate': instance.lastPaymentDate.toIso8601String(),
      'nextDueDate': instance.nextDueDate.toIso8601String(),
      'totalOutstanding': instance.totalOutstanding,
      'overdueBills': instance.overdueBills,
      'averagePaymentTime': instance.averagePaymentTime,
    };

_$PaymentHistoryImpl _$$PaymentHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PaymentHistoryImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      paymentMethod: json['paymentMethod'] as String,
      transactionId: json['transactionId'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      referenceNumber: json['referenceNumber'] as String?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PaymentHistoryImplToJson(
  _$PaymentHistoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'paymentDate': instance.paymentDate.toIso8601String(),
  'paymentMethod': instance.paymentMethod,
  'transactionId': instance.transactionId,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'referenceNumber': instance.referenceNumber,
  'notes': instance.notes,
  'metadata': instance.metadata,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.overdue: 'overdue',
  PaymentStatus.dueSoon: 'dueSoon',
};

_$BillAdjustmentImpl _$$BillAdjustmentImplFromJson(Map<String, dynamic> json) =>
    _$BillAdjustmentImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
    );

Map<String, dynamic> _$$BillAdjustmentImplToJson(
  _$BillAdjustmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'amount': instance.amount,
  'reason': instance.reason,
  'date': instance.date.toIso8601String(),
  'description': instance.description,
  'referenceNumber': instance.referenceNumber,
};

_$BillFeeImpl _$$BillFeeImplFromJson(Map<String, dynamic> json) =>
    _$BillFeeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      description: json['description'] as String?,
      isRecurring: json['isRecurring'] as bool?,
    );

Map<String, dynamic> _$$BillFeeImplToJson(_$BillFeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'isRecurring': instance.isRecurring,
    };

_$BillTaxImpl _$$BillTaxImplFromJson(Map<String, dynamic> json) =>
    _$BillTaxImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      jurisdiction: json['jurisdiction'] as String?,
    );

Map<String, dynamic> _$$BillTaxImplToJson(_$BillTaxImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rate': instance.rate,
      'amount': instance.amount,
      'type': instance.type,
      'jurisdiction': instance.jurisdiction,
    };

_$BillDiscountImpl _$$BillDiscountImplFromJson(Map<String, dynamic> json) =>
    _$BillDiscountImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      description: json['description'] as String?,
      validUntil: json['validUntil'] == null
          ? null
          : DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$$BillDiscountImplToJson(_$BillDiscountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'validUntil': instance.validUntil?.toIso8601String(),
    };

_$BillCalculationsImpl _$$BillCalculationsImplFromJson(
  Map<String, dynamic> json,
) => _$BillCalculationsImpl(
  baseRate: (json['baseRate'] as num?)?.toDouble() ?? 0.0,
  deliveryRate: (json['deliveryRate'] as num?)?.toDouble() ?? 0.0,
  generationRate: (json['generationRate'] as num?)?.toDouble() ?? 0.0,
  transmissionRate: (json['transmissionRate'] as num?)?.toDouble() ?? 0.0,
  distributionRate: (json['distributionRate'] as num?)?.toDouble() ?? 0.0,
  regulatoryRate: (json['regulatoryRate'] as num?)?.toDouble() ?? 0.0,
  renewableEnergyRate: (json['renewableEnergyRate'] as num?)?.toDouble() ?? 0.0,
  energyEfficiencyRate:
      (json['energyEfficiencyRate'] as num?)?.toDouble() ?? 0.0,
  totalRatePerKwh: (json['totalRatePerKwh'] as num?)?.toDouble() ?? 0.0,
  averageDailyUsage: (json['averageDailyUsage'] as num?)?.toDouble() ?? 0.0,
  peakUsage: (json['peakUsage'] as num?)?.toDouble() ?? 0.0,
  offPeakUsage: (json['offPeakUsage'] as num?)?.toDouble() ?? 0.0,
  totalUsageCost: (json['totalUsageCost'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$BillCalculationsImplToJson(
  _$BillCalculationsImpl instance,
) => <String, dynamic>{
  'baseRate': instance.baseRate,
  'deliveryRate': instance.deliveryRate,
  'generationRate': instance.generationRate,
  'transmissionRate': instance.transmissionRate,
  'distributionRate': instance.distributionRate,
  'regulatoryRate': instance.regulatoryRate,
  'renewableEnergyRate': instance.renewableEnergyRate,
  'energyEfficiencyRate': instance.energyEfficiencyRate,
  'totalRatePerKwh': instance.totalRatePerKwh,
  'averageDailyUsage': instance.averageDailyUsage,
  'peakUsage': instance.peakUsage,
  'offPeakUsage': instance.offPeakUsage,
  'totalUsageCost': instance.totalUsageCost,
};

_$BillNoteImpl _$$BillNoteImplFromJson(Map<String, dynamic> json) =>
    _$BillNoteImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
      type:
          $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ?? NoteType.info,
    );

Map<String, dynamic> _$$BillNoteImplToJson(_$BillNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'type': _$NoteTypeEnumMap[instance.type]!,
    };

const _$NoteTypeEnumMap = {
  NoteType.info: 'info',
  NoteType.warning: 'warning',
  NoteType.error: 'error',
  NoteType.success: 'success',
};
