// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BaseApiResponseDtoImpl _$$BaseApiResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BaseApiResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$BaseApiResponseDtoImplToJson(
  _$BaseApiResponseDtoImpl instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      sessionExpired: json['sessionExpired'] as bool? ?? false,
      token: json['token'] as String,
      guest: json['guest'] as bool? ?? false,
      identified: json['identified'] as bool? ?? false,
      connected: json['connected'] as bool? ?? false,
      secured: json['secured'] as bool? ?? false,
      maxPinnedAccounts: (json['maxPinnedAccounts'] as num?)?.toInt() ?? 0,
      loggedIn: json['loggedIn'] as bool? ?? false,
      requiresUpdate: json['requiresUpdate'] as bool? ?? false,
      preferredAccounts: json['preferredAccounts'] as String?,
      customerName: json['customerName'] as String?,
      announcements: (json['announcements'] as num?)?.toInt() ?? 0,
      bills: (json['bills'] as num?)?.toInt() ?? 0,
      powerUpdates: (json['powerUpdates'] as num?)?.toInt() ?? 0,
      payments: (json['payments'] as num?)?.toInt() ?? 0,
      paymentOffers: (json['paymentOffers'] as num?)?.toInt() ?? 0,
      affectedAccounts: (json['affectedAccounts'] as num?)?.toInt() ?? 0,
      updateRequiredMessage: json['updateRequiredMessage'] as String?,
      email: json['email'] as String?,
      tester: json['tester'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'sessionExpired': instance.sessionExpired,
      'token': instance.token,
      'guest': instance.guest,
      'identified': instance.identified,
      'connected': instance.connected,
      'secured': instance.secured,
      'maxPinnedAccounts': instance.maxPinnedAccounts,
      'loggedIn': instance.loggedIn,
      'requiresUpdate': instance.requiresUpdate,
      'preferredAccounts': instance.preferredAccounts,
      'customerName': instance.customerName,
      'announcements': instance.announcements,
      'bills': instance.bills,
      'powerUpdates': instance.powerUpdates,
      'payments': instance.payments,
      'paymentOffers': instance.paymentOffers,
      'affectedAccounts': instance.affectedAccounts,
      'updateRequiredMessage': instance.updateRequiredMessage,
      'email': instance.email,
      'tester': instance.tester,
    };

_$LoginResponseDtoImpl _$$LoginResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LoginResponseDtoImplToJson(
  _$LoginResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'user': instance.user,
};

_$RegisterResponseDtoImpl _$$RegisterResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$RegisterResponseDtoImplToJson(
  _$RegisterResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'user': instance.user,
};

_$MessageResponseDtoImpl _$$MessageResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MessageResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$MessageResponseDtoImplToJson(
  _$MessageResponseDtoImpl instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};

_$ServiceAddressDtoImpl _$$ServiceAddressDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ServiceAddressDtoImpl(
  apartmentNumber: json['apartmentNumber'] as String?,
  street: json['street'] as String,
  city: json['city'] as String,
  district: json['district'] as String,
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
  hasExistingPowerLine: json['hasExistingPowerLine'] as bool? ?? false,
);

Map<String, dynamic> _$$ServiceAddressDtoImplToJson(
  _$ServiceAddressDtoImpl instance,
) => <String, dynamic>{
  'apartmentNumber': instance.apartmentNumber,
  'street': instance.street,
  'city': instance.city,
  'district': instance.district,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'hasExistingPowerLine': instance.hasExistingPowerLine,
};

_$AccountBalanceDtoImpl _$$AccountBalanceDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AccountBalanceDtoImpl(
  balance: json['balance'] as String?,
  deposit: json['deposit'] as String?,
  lastBillNumber: json['lastBillNumber'] as String?,
  lastBillAmount: json['lastBillAmount'] as String?,
  lastBillDate: json['lastBillDate'] as String?,
  dueDate: json['dueDate'] as String?,
  dueIn: json['dueIn'] as String?,
  currentBill: json['currentBill'] as String?,
  pastDue: json['pastDue'] as String?,
  color: json['color'] as String,
  collectionStatus: json['collectionStatus'] as String?,
  lastPaymentDate: json['lastPaymentDate'] as String?,
  lastPaymentAmount: json['lastPaymentAmount'] as String?,
  lastPaymentBillNumber: json['lastPaymentBillNumber'] as String?,
  paid: json['paid'] as bool? ?? false,
);

Map<String, dynamic> _$$AccountBalanceDtoImplToJson(
  _$AccountBalanceDtoImpl instance,
) => <String, dynamic>{
  'balance': instance.balance,
  'deposit': instance.deposit,
  'lastBillNumber': instance.lastBillNumber,
  'lastBillAmount': instance.lastBillAmount,
  'lastBillDate': instance.lastBillDate,
  'dueDate': instance.dueDate,
  'dueIn': instance.dueIn,
  'currentBill': instance.currentBill,
  'pastDue': instance.pastDue,
  'color': instance.color,
  'collectionStatus': instance.collectionStatus,
  'lastPaymentDate': instance.lastPaymentDate,
  'lastPaymentAmount': instance.lastPaymentAmount,
  'lastPaymentBillNumber': instance.lastPaymentBillNumber,
  'paid': instance.paid,
};

_$EditableCustomerAccountDtoImpl _$$EditableCustomerAccountDtoImplFromJson(
  Map<String, dynamic> json,
) => _$EditableCustomerAccountDtoImpl(
  accountNumber: json['accountNumber'] as String?,
  meter: json['meter'] as String?,
  balance: json['balance'] as String?,
  deposit: json['deposit'] as String?,
  lastBillNumber: json['lastBillNumber'] as String?,
  lastBillAmount: json['lastBillAmount'] as String?,
  lastBillDate: json['lastBillDate'] as String?,
  dueDate: json['dueDate'] as String?,
  dueIn: json['dueIn'] as String?,
  currentBill: json['currentBill'] as String?,
  pastDue: json['pastDue'] as String?,
  lastPaymentDate: json['lastPaymentDate'] as String?,
  lastPaymentAmount: json['lastPaymentAmount'] as String?,
  lastPaymentBillNumber: json['lastPaymentBillNumber'] as String?,
  paid: json['paid'] as bool? ?? false,
  color: json['color'] as String?,
  active: json['active'] as bool? ?? true,
  customerNumber: json['customerNumber'] as String?,
  name: json['name'] as String?,
  nickName: json['nickName'] as String?,
  billCode: json['billCode'] as String?,
  cell: json['cell'] as String?,
  emailAddress: json['emailAddress'] as String?,
  orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
  pinned: json['pinned'] as bool? ?? false,
  apartmentNumber: json['apartmentNumber'] as String?,
  street: json['street'] as String?,
  city: json['city'] as String?,
  district: json['district'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  collectionStatus: json['collectionStatus'] as String?,
  fullAccess: json['fullAccess'] as bool? ?? false,
  billDownloadAccess: json['billDownloadAccess'] as bool? ?? false,
);

Map<String, dynamic> _$$EditableCustomerAccountDtoImplToJson(
  _$EditableCustomerAccountDtoImpl instance,
) => <String, dynamic>{
  'accountNumber': instance.accountNumber,
  'meter': instance.meter,
  'balance': instance.balance,
  'deposit': instance.deposit,
  'lastBillNumber': instance.lastBillNumber,
  'lastBillAmount': instance.lastBillAmount,
  'lastBillDate': instance.lastBillDate,
  'dueDate': instance.dueDate,
  'dueIn': instance.dueIn,
  'currentBill': instance.currentBill,
  'pastDue': instance.pastDue,
  'lastPaymentDate': instance.lastPaymentDate,
  'lastPaymentAmount': instance.lastPaymentAmount,
  'lastPaymentBillNumber': instance.lastPaymentBillNumber,
  'paid': instance.paid,
  'color': instance.color,
  'active': instance.active,
  'customerNumber': instance.customerNumber,
  'name': instance.name,
  'nickName': instance.nickName,
  'billCode': instance.billCode,
  'cell': instance.cell,
  'emailAddress': instance.emailAddress,
  'orderIndex': instance.orderIndex,
  'pinned': instance.pinned,
  'apartmentNumber': instance.apartmentNumber,
  'street': instance.street,
  'city': instance.city,
  'district': instance.district,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'collectionStatus': instance.collectionStatus,
  'fullAccess': instance.fullAccess,
  'billDownloadAccess': instance.billDownloadAccess,
};

_$ConnectedAccountsResponseDtoImpl _$$ConnectedAccountsResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectedAccountsResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  editableCustomerAccounts:
      (json['editableCustomerAccounts'] as List<dynamic>?)
          ?.map(
            (e) =>
                EditableCustomerAccountDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ConnectedAccountsResponseDtoImplToJson(
  _$ConnectedAccountsResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'editableCustomerAccounts': instance.editableCustomerAccounts,
};

_$CustomerAccountDetailResponseDtoImpl
_$$CustomerAccountDetailResponseDtoImplFromJson(Map<String, dynamic> json) =>
    _$CustomerAccountDetailResponseDtoImpl(
      status: (json['status'] as num).toInt(),
      customerAccountDetail: CustomerAccountDetailDataDto.fromJson(
        json['customerAccountDetail'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$CustomerAccountDetailResponseDtoImplToJson(
  _$CustomerAccountDetailResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'customerAccountDetail': instance.customerAccountDetail,
};

_$CustomerAccountDetailDataDtoImpl _$$CustomerAccountDetailDataDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerAccountDetailDataDtoImpl(
  accountNumber: json['accountNumber'] as String,
  customerNumber: json['customerNumber'] as String,
  serviceAddress: ServiceAddressDto.fromJson(
    json['serviceAddress'] as Map<String, dynamic>,
  ),
  name: json['name'] as String,
  town: json['town'] as String,
  accountStatus: json['accountStatus'] as String,
  owner: json['owner'] as String,
  billCode: json['billCode'] as String,
  meter: json['meter'] as String,
  emailAddress: json['emailAddress'] as String,
  cell: json['cell'] as String,
  rating: json['rating'] as String?,
  accountBalance: AccountBalanceDto.fromJson(
    json['accountBalance'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$CustomerAccountDetailDataDtoImplToJson(
  _$CustomerAccountDetailDataDtoImpl instance,
) => <String, dynamic>{
  'accountNumber': instance.accountNumber,
  'customerNumber': instance.customerNumber,
  'serviceAddress': instance.serviceAddress,
  'name': instance.name,
  'town': instance.town,
  'accountStatus': instance.accountStatus,
  'owner': instance.owner,
  'billCode': instance.billCode,
  'meter': instance.meter,
  'emailAddress': instance.emailAddress,
  'cell': instance.cell,
  'rating': instance.rating,
  'accountBalance': instance.accountBalance,
};

_$ConnectCustomerAccountResponseDtoImpl
_$$ConnectCustomerAccountResponseDtoImplFromJson(Map<String, dynamic> json) =>
    _$ConnectCustomerAccountResponseDtoImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String?,
      editableCustomerAccount: EditableCustomerAccountDto.fromJson(
        json['editableCustomerAccount'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$ConnectCustomerAccountResponseDtoImplToJson(
  _$ConnectCustomerAccountResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'editableCustomerAccount': instance.editableCustomerAccount,
};

_$BillDetailResponseDtoImpl _$$BillDetailResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BillDetailResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  bill: BillDetailDataDto.fromJson(json['bill'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BillDetailResponseDtoImplToJson(
  _$BillDetailResponseDtoImpl instance,
) => <String, dynamic>{'status': instance.status, 'bill': instance.bill};

_$BillDetailDataDtoImpl _$$BillDetailDataDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BillDetailDataDtoImpl(
  billNumber: json['billNumber'] as String,
  readingDate: json['readingDate'] as String,
  billingDate: json['billingDate'] as String,
  previousBalance: json['previousBalance'] as String,
  lessPayment: json['lessPayment'] as String,
  balanceForward: json['balanceForward'] as String,
  consumption: json['consumption'] as String,
  minimumBill: json['minimumBill'] as String,
  crimeStoppersPledge: json['crimeStoppersPledge'] as String,
  otherCharge: json['otherCharge'] as String,
  gstCharge: json['gstCharge'] as String,
  taxAdjustment: json['taxAdjustment'] as String,
  amountDue: json['amountDue'] as String,
  balance: json['balance'] as String,
  paymentDueDate: json['paymentDueDate'] as String,
  previousReading: json['previousReading'] as String,
  presentReading: json['presentReading'] as String,
  totalConsumption: json['totalConsumption'] as String,
  dueIn: json['dueIn'] as String,
  paid: json['paid'] as bool,
  customerName: json['customerName'] as String,
  accountNumber: json['accountNumber'] as String,
  customerNumber: json['customerNumber'] as String,
);

Map<String, dynamic> _$$BillDetailDataDtoImplToJson(
  _$BillDetailDataDtoImpl instance,
) => <String, dynamic>{
  'billNumber': instance.billNumber,
  'readingDate': instance.readingDate,
  'billingDate': instance.billingDate,
  'previousBalance': instance.previousBalance,
  'lessPayment': instance.lessPayment,
  'balanceForward': instance.balanceForward,
  'consumption': instance.consumption,
  'minimumBill': instance.minimumBill,
  'crimeStoppersPledge': instance.crimeStoppersPledge,
  'otherCharge': instance.otherCharge,
  'gstCharge': instance.gstCharge,
  'taxAdjustment': instance.taxAdjustment,
  'amountDue': instance.amountDue,
  'balance': instance.balance,
  'paymentDueDate': instance.paymentDueDate,
  'previousReading': instance.previousReading,
  'presentReading': instance.presentReading,
  'totalConsumption': instance.totalConsumption,
  'dueIn': instance.dueIn,
  'paid': instance.paid,
  'customerName': instance.customerName,
  'accountNumber': instance.accountNumber,
  'customerNumber': instance.customerNumber,
};

_$BillDownloadUrlResponseDtoImpl _$$BillDownloadUrlResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$BillDownloadUrlResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$BillDownloadUrlResponseDtoImplToJson(
  _$BillDownloadUrlResponseDtoImpl instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};

_$PaymentInformationDtoImpl _$$PaymentInformationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentInformationDtoImpl(
  customerNumber: json['customerNumber'] as String,
  accountNumber: json['accountNumber'] as String,
  customerName: json['customerName'] as String,
  paymentAmount: json['paymentAmount'] as String,
  paymentDate: json['paymentDate'] as String,
  receiptNumber: json['receiptNumber'] as String,
  outstandingBalance: json['outstandingBalance'] as String,
  outstandingBalanceType: json['outstandingBalanceType'] as String?,
  updatedDate: json['updatedDate'] as String,
  fileUrlLocation: json['fileUrlLocation'] as String?,
);

Map<String, dynamic> _$$PaymentInformationDtoImplToJson(
  _$PaymentInformationDtoImpl instance,
) => <String, dynamic>{
  'customerNumber': instance.customerNumber,
  'accountNumber': instance.accountNumber,
  'customerName': instance.customerName,
  'paymentAmount': instance.paymentAmount,
  'paymentDate': instance.paymentDate,
  'receiptNumber': instance.receiptNumber,
  'outstandingBalance': instance.outstandingBalance,
  'outstandingBalanceType': instance.outstandingBalanceType,
  'updatedDate': instance.updatedDate,
  'fileUrlLocation': instance.fileUrlLocation,
};

_$ReceiptDetailResponseDtoImpl _$$ReceiptDetailResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ReceiptDetailResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  paymentInformation: PaymentInformationDto.fromJson(
    json['paymentInformation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$ReceiptDetailResponseDtoImplToJson(
  _$ReceiptDetailResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'paymentInformation': instance.paymentInformation,
};

_$ReceiptDownloadUrlResponseDtoImpl
_$$ReceiptDownloadUrlResponseDtoImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptDownloadUrlResponseDtoImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ReceiptDownloadUrlResponseDtoImplToJson(
  _$ReceiptDownloadUrlResponseDtoImpl instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};

_$PaymentTransactionDtoImpl _$$PaymentTransactionDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentTransactionDtoImpl(
  transactionDate: json['transactionDate'] as String,
  transactionDescription: json['transactionDescription'] as String,
  transactionAmount: json['transactionAmount'] as String,
  accountBalance: json['accountBalance'] as String,
  dateTime: json['dateTime'] as String,
  billNumber: json['billNumber'] as String,
  receiptNumber: json['receiptNumber'] as String,
  status: json['status'] as String?,
  row: json['row'] as String,
);

Map<String, dynamic> _$$PaymentTransactionDtoImplToJson(
  _$PaymentTransactionDtoImpl instance,
) => <String, dynamic>{
  'transactionDate': instance.transactionDate,
  'transactionDescription': instance.transactionDescription,
  'transactionAmount': instance.transactionAmount,
  'accountBalance': instance.accountBalance,
  'dateTime': instance.dateTime,
  'billNumber': instance.billNumber,
  'receiptNumber': instance.receiptNumber,
  'status': instance.status,
  'row': instance.row,
};

_$TransactionHistoryResponseDtoImpl
_$$TransactionHistoryResponseDtoImplFromJson(Map<String, dynamic> json) =>
    _$TransactionHistoryResponseDtoImpl(
      status: (json['status'] as num).toInt(),
      paymentTransactions:
          (json['paymentTransactions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PaymentTransactionDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TransactionHistoryResponseDtoImplToJson(
  _$TransactionHistoryResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'paymentTransactions': instance.paymentTransactions,
};

_$MeterReadingDtoImpl _$$MeterReadingDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MeterReadingDtoImpl(
  readDate: json['readDate'] as String,
  readMonth: json['readMonth'] as String,
  readYear: json['readYear'] as String,
  days: json['days'] as String,
  consumption: json['consumption'] as String,
  averageUsage: json['averageUsage'] as String,
  amount: json['amount'] as String,
  accountNumber: json['accountNumber'] as String?,
);

Map<String, dynamic> _$$MeterReadingDtoImplToJson(
  _$MeterReadingDtoImpl instance,
) => <String, dynamic>{
  'readDate': instance.readDate,
  'readMonth': instance.readMonth,
  'readYear': instance.readYear,
  'days': instance.days,
  'consumption': instance.consumption,
  'averageUsage': instance.averageUsage,
  'amount': instance.amount,
  'accountNumber': instance.accountNumber,
};

_$MeterReadingsResponseDtoImpl _$$MeterReadingsResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MeterReadingsResponseDtoImpl(
  readings:
      (json['readings'] as List<dynamic>?)
          ?.map((e) => MeterReadingDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MeterReadingsResponseDtoImplToJson(
  _$MeterReadingsResponseDtoImpl instance,
) => <String, dynamic>{'readings': instance.readings};

_$DailyTotalKwhDtoImpl _$$DailyTotalKwhDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DailyTotalKwhDtoImpl(
  dailyTotalKwh: (json['dailyTotalKwh'] as num).toDouble(),
);

Map<String, dynamic> _$$DailyTotalKwhDtoImplToJson(
  _$DailyTotalKwhDtoImpl instance,
) => <String, dynamic>{'dailyTotalKwh': instance.dailyTotalKwh};

_$DailyTotalKwhResponseDtoImpl _$$DailyTotalKwhResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DailyTotalKwhResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  data: DailyTotalKwhDto.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DailyTotalKwhResponseDtoImplToJson(
  _$DailyTotalKwhResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$DailyUsageEntryDtoImpl _$$DailyUsageEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DailyUsageEntryDtoImpl(
  usageDate: json['usageDate'] as String,
  dailyUsageKwh: (json['dailyUsageKwh'] as num).toDouble(),
);

Map<String, dynamic> _$$DailyUsageEntryDtoImplToJson(
  _$DailyUsageEntryDtoImpl instance,
) => <String, dynamic>{
  'usageDate': instance.usageDate,
  'dailyUsageKwh': instance.dailyUsageKwh,
};

_$DailyUsageResponseDtoImpl _$$DailyUsageResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DailyUsageResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => DailyUsageEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DailyUsageResponseDtoImplToJson(
  _$DailyUsageResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$IntervalUsageEntryDtoImpl _$$IntervalUsageEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$IntervalUsageEntryDtoImpl(
  meterId: json['meterId'] as String,
  readDate: json['readDate'] as String,
  firstIntervalDateTime: json['firstIntervalDateTime'] as String,
  intervalDateTime: json['intervalDateTime'] as String,
  intervalNumber: (json['intervalNumber'] as num).toInt(),
  kWh: (json['kWh'] as num).toDouble(),
);

Map<String, dynamic> _$$IntervalUsageEntryDtoImplToJson(
  _$IntervalUsageEntryDtoImpl instance,
) => <String, dynamic>{
  'meterId': instance.meterId,
  'readDate': instance.readDate,
  'firstIntervalDateTime': instance.firstIntervalDateTime,
  'intervalDateTime': instance.intervalDateTime,
  'intervalNumber': instance.intervalNumber,
  'kWh': instance.kWh,
};

_$IntervalUsageResponseDtoImpl _$$IntervalUsageResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$IntervalUsageResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => IntervalUsageEntryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$IntervalUsageResponseDtoImplToJson(
  _$IntervalUsageResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$MonthlyUsageEntryDtoImpl _$$MonthlyUsageEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyUsageEntryDtoImpl(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  monthlyUsageKwh: (json['monthlyUsageKwh'] as num).toDouble(),
);

Map<String, dynamic> _$$MonthlyUsageEntryDtoImplToJson(
  _$MonthlyUsageEntryDtoImpl instance,
) => <String, dynamic>{
  'year': instance.year,
  'month': instance.month,
  'monthlyUsageKwh': instance.monthlyUsageKwh,
};

_$MonthlyUsageResponseDtoImpl _$$MonthlyUsageResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MonthlyUsageResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => MonthlyUsageEntryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MonthlyUsageResponseDtoImplToJson(
  _$MonthlyUsageResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$YearlyUsageDtoImpl _$$YearlyUsageDtoImplFromJson(Map<String, dynamic> json) =>
    _$YearlyUsageDtoImpl(
      yearlyUsageKwh: (json['yearlyUsageKwh'] as num).toDouble(),
    );

Map<String, dynamic> _$$YearlyUsageDtoImplToJson(
  _$YearlyUsageDtoImpl instance,
) => <String, dynamic>{'yearlyUsageKwh': instance.yearlyUsageKwh};

_$YearlyUsageResponseDtoImpl _$$YearlyUsageResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$YearlyUsageResponseDtoImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String?,
  data: YearlyUsageDto.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$YearlyUsageResponseDtoImplToJson(
  _$YearlyUsageResponseDtoImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
