import 'api_response_dtos.dart';

/// PascalCase keys used by BEL mobile APIs for [EditableCustomerAccountDto].
const Map<String, String> kEditableCustomerAccountPascalToCamel = {
  'AccountNumber': 'accountNumber',
  'Meter': 'meter',
  'Balance': 'balance',
  'Deposit': 'deposit',
  'LastBillNumber': 'lastBillNumber',
  'LastBillAmount': 'lastBillAmount',
  'LastBillDate': 'lastBillDate',
  'DueDate': 'dueDate',
  'DueIn': 'dueIn',
  'CurrentBill': 'currentBill',
  'PastDue': 'pastDue',
  'LastPaymentDate': 'lastPaymentDate',
  'LastPaymentAmount': 'lastPaymentAmount',
  'LastPaymentBillNumber': 'lastPaymentBillNumber',
  'Paid': 'paid',
  'Color': 'color',
  'Active': 'active',
  'CustomerNumber': 'customerNumber',
  'Name': 'name',
  'NickName': 'nickName',
  'BillCode': 'billCode',
  'Cell': 'cell',
  'EmailAddress': 'emailAddress',
  'OrderIndex': 'orderIndex',
  'Pinned': 'pinned',
  'ApartmentNumber': 'apartmentNumber',
  'Street': 'street',
  'City': 'city',
  'District': 'district',
  'Latitude': 'latitude',
  'Longitude': 'longitude',
  'CollectionStatus': 'collectionStatus',
  'FullAccess': 'fullAccess',
  'BillDownloadAccess': 'billDownloadAccess',
};

/// Copy PascalCase account keys onto camelCase when camelCase is missing.
///
/// GET /CustomerAccounts/V4/PreferredCustomerAccounts may return either
/// Newtonsoft setting. Generated `fromJson` only reads camelCase.
Map<String, dynamic> editableCustomerAccountJsonFromApi(
  Map<String, dynamic> json,
) {
  final out = Map<String, dynamic>.from(json);
  for (final entry in kEditableCustomerAccountPascalToCamel.entries) {
    final camel = entry.value;
    final pascal = entry.key;
    final camelMissing = !out.containsKey(camel) || out[camel] == null;
    if (camelMissing && out.containsKey(pascal)) {
      out[camel] = out[pascal];
    }
  }
  return out;
}

/// Copy PascalCase wrapper keys for the connected-accounts response.
Map<String, dynamic> connectedAccountsResponseJsonFromApi(
  Map<String, dynamic> json,
) {
  final out = Map<String, dynamic>.from(json);
  if (!out.containsKey('status') && out.containsKey('Status')) {
    out['status'] = out['Status'];
  }
  if (!out.containsKey('editableCustomerAccounts') &&
      out.containsKey('EditableCustomerAccounts')) {
    out['editableCustomerAccounts'] = out['EditableCustomerAccounts'];
  }
  return out;
}

/// Maps [EditableCustomerAccountDto] to PascalCase JSON for BEL mobile API POST bodies.
Map<String, dynamic> editableCustomerAccountToApiJson(EditableCustomerAccountDto dto) =>
    <String, dynamic>{
      'AccountNumber': dto.accountNumber,
      'Meter': dto.meter,
      'Balance': dto.balance,
      'Deposit': dto.deposit,
      'LastBillNumber': dto.lastBillNumber,
      'LastBillAmount': dto.lastBillAmount,
      'LastBillDate': dto.lastBillDate,
      'DueDate': dto.dueDate,
      'DueIn': dto.dueIn,
      'CurrentBill': dto.currentBill,
      'PastDue': dto.pastDue,
      'LastPaymentDate': dto.lastPaymentDate,
      'LastPaymentAmount': dto.lastPaymentAmount,
      'LastPaymentBillNumber': dto.lastPaymentBillNumber,
      'Paid': dto.paid,
      'Color': dto.color,
      'Active': dto.active,
      'CustomerNumber': dto.customerNumber,
      'Name': dto.name,
      'NickName': dto.nickName,
      'BillCode': dto.billCode,
      'Cell': dto.cell,
      'EmailAddress': dto.emailAddress,
      'OrderIndex': dto.orderIndex,
      'Pinned': dto.pinned,
      'ApartmentNumber': dto.apartmentNumber,
      'Street': dto.street,
      'City': dto.city,
      'District': dto.district,
      'Latitude': dto.latitude,
      'Longitude': dto.longitude,
      'CollectionStatus': dto.collectionStatus,
      'FullAccess': dto.fullAccess,
      'BillDownloadAccess': dto.billDownloadAccess,
    };
