// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: json['id'] as String,
      accountNumber: json['accountNumber'] as String,
      customerNumber: json['customerNumber'] as String,
      accountType: json['accountType'] as String,
      address: json['address'] as String,
      balance: (json['balance'] as num).toDouble(),
      status: $enumDecode(_$AccountStatusEnumMap, json['status']),
      lastPaymentDate: json['lastPaymentDate'] == null
          ? null
          : DateTime.parse(json['lastPaymentDate'] as String),
      nextDueDate: json['nextDueDate'] == null
          ? null
          : DateTime.parse(json['nextDueDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      meterNumber: json['meterNumber'] as String?,
      serviceArea: json['serviceArea'] as String?,
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountNumber': instance.accountNumber,
      'customerNumber': instance.customerNumber,
      'accountType': instance.accountType,
      'address': instance.address,
      'balance': instance.balance,
      'status': _$AccountStatusEnumMap[instance.status]!,
      'lastPaymentDate': instance.lastPaymentDate?.toIso8601String(),
      'nextDueDate': instance.nextDueDate?.toIso8601String(),
      'isActive': instance.isActive,
      'meterNumber': instance.meterNumber,
      'serviceArea': instance.serviceArea,
      'nickname': instance.nickname,
    };

const _$AccountStatusEnumMap = {
  AccountStatus.paid: 'paid',
  AccountStatus.due: 'due',
  AccountStatus.overdue: 'overdue',
};
