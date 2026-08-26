import 'package:freezed_annotation/freezed_annotation.dart';

import 'editable_customer_account_api_json.dart';

part 'api_response_dtos.freezed.dart';
part 'api_response_dtos.g.dart';

/// Base API response DTO that all API responses extend
@freezed
class BaseApiResponseDto with _$BaseApiResponseDto {
  const factory BaseApiResponseDto({
    required int status,
    String? message,
  }) = _BaseApiResponseDto;

  factory BaseApiResponseDto.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status'] ?? json['Status'];
    final rawMessage = json['message'] ?? json['Message'];
    final status = rawStatus is num
        ? rawStatus.toInt()
        : int.tryParse('$rawStatus') ?? 500;
    return BaseApiResponseDto(
      status: status,
      message: rawMessage?.toString(),
    );
  }
}

extension BaseApiResponseDtoX on BaseApiResponseDto {
  /// BEL bodies use `200` or `0` for success.
  bool get isSuccess => status == 200 || status == 0;
}

// ============================================================================
// Authentication DTOs
// ============================================================================

/// User data from API response
@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String username,
    @Default(false) bool sessionExpired,
    required String token,
    @Default(false) bool guest,
    @Default(false) bool identified,
    @Default(false) bool connected,
    @Default(false) bool secured,
    @Default(0) int maxPinnedAccounts,
    @Default(false) bool loggedIn,
    @Default(false) bool requiresUpdate,
    String? preferredAccounts,
    String? customerName,
    @Default(0) int announcements,
    @Default(0) int bills,
    @Default(0) int powerUpdates,
    @Default(0) int payments,
    @Default(0) int paymentOffers,
    @Default(0) int affectedAccounts,
    String? updateRequiredMessage,
    String? email,
    @Default(false) bool tester,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}

/// Login response DTO
@freezed
class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    required int status,
    String? message,
    required UserDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

/// Register Step 3 response DTO (uses same structure as login)
@freezed
class RegisterResponseDto with _$RegisterResponseDto {
  const factory RegisterResponseDto({
    required int status,
    String? message,
    required UserDto user,
  }) = _RegisterResponseDto;

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);
}

/// Simple message response DTO (for register step 1, step 2, logout, etc.)
@freezed
class MessageResponseDto with _$MessageResponseDto {
  const factory MessageResponseDto({
    required int status,
    String? message,
  }) = _MessageResponseDto;

  factory MessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDtoFromJson(json);
}

// ============================================================================
// Customer Account DTOs
// ============================================================================

/// Service address DTO
@freezed
class ServiceAddressDto with _$ServiceAddressDto {
  const factory ServiceAddressDto({
    String? apartmentNumber,
    required String street,
    required String city,
    required String district,
    required String latitude,
    required String longitude,
    @Default(false) bool hasExistingPowerLine,
  }) = _ServiceAddressDto;

  factory ServiceAddressDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceAddressDtoFromJson(json);
}

/// Account balance DTO
@freezed
class AccountBalanceDto with _$AccountBalanceDto {
  const factory AccountBalanceDto({
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    required String color,
    String? collectionStatus,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    @Default(false) bool paid,
  }) = _AccountBalanceDto;

  factory AccountBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceDtoFromJson(json);
}

/// Editable customer account DTO
@freezed
class EditableCustomerAccountDto with _$EditableCustomerAccountDto {
  const factory EditableCustomerAccountDto({
    String? accountNumber,
    String? meter,
    String? balance,
    String? deposit,
    String? lastBillNumber,
    String? lastBillAmount,
    String? lastBillDate,
    String? dueDate,
    String? dueIn,
    String? currentBill,
    String? pastDue,
    String? lastPaymentDate,
    String? lastPaymentAmount,
    String? lastPaymentBillNumber,
    @Default(false) bool paid,
    String? color,
    @Default(true) bool active,
    String? customerNumber,
    String? name,
    String? nickName,
    String? billCode,
    String? cell,
    String? emailAddress,
    @Default(0) int orderIndex,
    @Default(false) bool pinned,
    String? apartmentNumber,
    String? street,
    String? city,
    String? district,
    String? latitude,
    String? longitude,
    String? collectionStatus,
    @Default(false) bool fullAccess,
    @Default(false) bool billDownloadAccess,
  }) = _EditableCustomerAccountDto;

  factory EditableCustomerAccountDto.fromJson(Map<String, dynamic> json) =>
      _$EditableCustomerAccountDtoFromJson(
        editableCustomerAccountJsonFromApi(json),
      );
}

/// Connected accounts response DTO
@freezed
class ConnectedAccountsResponseDto with _$ConnectedAccountsResponseDto {
  const factory ConnectedAccountsResponseDto({
    required int status,
    @Default([]) List<EditableCustomerAccountDto> editableCustomerAccounts,
  }) = _ConnectedAccountsResponseDto;

  factory ConnectedAccountsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ConnectedAccountsResponseDtoFromJson(
        connectedAccountsResponseJsonFromApi(json),
      );
}

/// Customer account detail response DTO
@freezed
class CustomerAccountDetailResponseDto with _$CustomerAccountDetailResponseDto {
  const factory CustomerAccountDetailResponseDto({
    required int status,
    required CustomerAccountDetailDataDto customerAccountDetail,
  }) = _CustomerAccountDetailResponseDto;

  factory CustomerAccountDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerAccountDetailResponseDtoFromJson(json);
}

/// Customer account detail data DTO
@freezed
class CustomerAccountDetailDataDto with _$CustomerAccountDetailDataDto {
  const factory CustomerAccountDetailDataDto({
    required String accountNumber,
    required String customerNumber,
    required ServiceAddressDto serviceAddress,
    required String name,
    required String town,
    required String accountStatus,
    required String owner,
    required String billCode,
    required String meter,
    required String emailAddress,
    required String cell,
    String? rating,
    required AccountBalanceDto accountBalance,
  }) = _CustomerAccountDetailDataDto;

  factory CustomerAccountDetailDataDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerAccountDetailDataDtoFromJson(json);
}

/// Connect customer account response DTO
@freezed
class ConnectCustomerAccountResponseDto with _$ConnectCustomerAccountResponseDto {
  const factory ConnectCustomerAccountResponseDto({
    required int status,
    String? message,
    required EditableCustomerAccountDto editableCustomerAccount,
  }) = _ConnectCustomerAccountResponseDto;

  factory ConnectCustomerAccountResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ConnectCustomerAccountResponseDtoFromJson(json);

  const ConnectCustomerAccountResponseDto._();

  /// BEL APIs use `200` in the JSON body for success on several endpoints; some
  /// responses may use `0` instead.
  bool get isSuccess => status == 0 || status == 200;
}

// ============================================================================
// Bill DTOs
// ============================================================================

/// Bill detail response DTO
@freezed
class BillDetailResponseDto with _$BillDetailResponseDto {
  const factory BillDetailResponseDto({
    required int status,
    required BillDetailDataDto bill,
  }) = _BillDetailResponseDto;

  factory BillDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BillDetailResponseDtoFromJson(json);
}

/// Bill detail data DTO
@freezed
class BillDetailDataDto with _$BillDetailDataDto {
  const factory BillDetailDataDto({
    required String billNumber,
    required String readingDate,
    required String billingDate,
    required String previousBalance,
    required String lessPayment,
    required String balanceForward,
    required String consumption,
    required String minimumBill,
    required String crimeStoppersPledge,
    required String otherCharge,
    required String gstCharge,
    required String taxAdjustment,
    required String amountDue,
    required String balance,
    required String paymentDueDate,
    required String previousReading,
    required String presentReading,
    required String totalConsumption,
    required String dueIn,
    required bool paid,
    required String customerName,
    required String accountNumber,
    required String customerNumber,
  }) = _BillDetailDataDto;

  factory BillDetailDataDto.fromJson(Map<String, dynamic> json) =>
      _$BillDetailDataDtoFromJson(json);
}

/// Bill download URL response DTO
@freezed
class BillDownloadUrlResponseDto with _$BillDownloadUrlResponseDto {
  const factory BillDownloadUrlResponseDto({
    required int status,
    String? message,
  }) = _BillDownloadUrlResponseDto;

  factory BillDownloadUrlResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BillDownloadUrlResponseDtoFromJson(json);
}

// ============================================================================
// Receipt DTOs
// ============================================================================

/// Payment information DTO
@freezed
class PaymentInformationDto with _$PaymentInformationDto {
  const factory PaymentInformationDto({
    required String customerNumber,
    required String accountNumber,
    required String customerName,
    required String paymentAmount,
    required String paymentDate,
    required String receiptNumber,
    required String outstandingBalance,
    String? outstandingBalanceType,
    required String updatedDate,
    String? fileUrlLocation,
  }) = _PaymentInformationDto;

  factory PaymentInformationDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentInformationDtoFromJson(json);
}

/// Receipt detail response DTO
@freezed
class ReceiptDetailResponseDto with _$ReceiptDetailResponseDto {
  const factory ReceiptDetailResponseDto({
    required int status,
    required PaymentInformationDto paymentInformation,
  }) = _ReceiptDetailResponseDto;

  factory ReceiptDetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReceiptDetailResponseDtoFromJson(json);
}

/// Receipt download URL response DTO
@freezed
class ReceiptDownloadUrlResponseDto with _$ReceiptDownloadUrlResponseDto {
  const factory ReceiptDownloadUrlResponseDto({
    required int status,
    String? message,
  }) = _ReceiptDownloadUrlResponseDto;

  factory ReceiptDownloadUrlResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReceiptDownloadUrlResponseDtoFromJson(json);
}

// ============================================================================
// Transaction History DTOs
// ============================================================================

/// Payment transaction DTO
@freezed
class PaymentTransactionDto with _$PaymentTransactionDto {
  const factory PaymentTransactionDto({
    required String transactionDate,
    required String transactionDescription,
    required String transactionAmount,
    required String accountBalance,
    required String dateTime,
    required String billNumber,
    required String receiptNumber,
    String? status,
    required String row,
  }) = _PaymentTransactionDto;

  factory PaymentTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionDtoFromJson(json);
}

/// Transaction history response DTO
@freezed
class TransactionHistoryResponseDto with _$TransactionHistoryResponseDto {
  const factory TransactionHistoryResponseDto({
    required int status,
    @Default([]) List<PaymentTransactionDto> paymentTransactions,
  }) = _TransactionHistoryResponseDto;

  factory TransactionHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryResponseDtoFromJson(json);
}

// ============================================================================
// Meter Readings DTOs
// ============================================================================

/// Meter reading DTO
@freezed
class MeterReadingDto with _$MeterReadingDto {
  const factory MeterReadingDto({
    required String readDate,
    required String readMonth,
    required String readYear,
    required String days,
    required String consumption,
    required String averageUsage,
    required String amount,
    String? accountNumber,
  }) = _MeterReadingDto;

  factory MeterReadingDto.fromJson(Map<String, dynamic> json) =>
      _$MeterReadingDtoFromJson(json);
}

/// Meter readings response DTO
@freezed
class MeterReadingsResponseDto with _$MeterReadingsResponseDto {
  const factory MeterReadingsResponseDto({
    @Default([]) List<MeterReadingDto> readings,
  }) = _MeterReadingsResponseDto;

  factory MeterReadingsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MeterReadingsResponseDtoFromJson(json);
}

// ============================================================================
// AMI Usage DTOs
// ============================================================================

/// Daily total kWh DTO
@freezed
class DailyTotalKwhDto with _$DailyTotalKwhDto {
  const factory DailyTotalKwhDto({
    required double dailyTotalKwh,
  }) = _DailyTotalKwhDto;

  factory DailyTotalKwhDto.fromJson(Map<String, dynamic> json) =>
      _$DailyTotalKwhDtoFromJson(json);
}

/// Daily total kWh response DTO
@freezed
class DailyTotalKwhResponseDto with _$DailyTotalKwhResponseDto {
  const factory DailyTotalKwhResponseDto({
    required int status,
    String? message,
    required DailyTotalKwhDto data,
  }) = _DailyTotalKwhResponseDto;

  factory DailyTotalKwhResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DailyTotalKwhResponseDtoFromJson(json);
}

/// Daily usage entry DTO
@freezed
class DailyUsageEntryDto with _$DailyUsageEntryDto {
  const factory DailyUsageEntryDto({
    required String usageDate,
    required double dailyUsageKwh,
  }) = _DailyUsageEntryDto;

  factory DailyUsageEntryDto.fromJson(Map<String, dynamic> json) =>
      _$DailyUsageEntryDtoFromJson(json);
}

/// Daily usage response DTO
@freezed
class DailyUsageResponseDto with _$DailyUsageResponseDto {
  const factory DailyUsageResponseDto({
    required int status,
    String? message,
    @Default([]) List<DailyUsageEntryDto> data,
  }) = _DailyUsageResponseDto;

  factory DailyUsageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DailyUsageResponseDtoFromJson(json);
}

/// Interval usage entry DTO
@freezed
class IntervalUsageEntryDto with _$IntervalUsageEntryDto {
  const factory IntervalUsageEntryDto({
    required String meterId,
    required String readDate,
    required String firstIntervalDateTime,
    required String intervalDateTime,
    required int intervalNumber,
    required double kWh,
  }) = _IntervalUsageEntryDto;

  factory IntervalUsageEntryDto.fromJson(Map<String, dynamic> json) =>
      _$IntervalUsageEntryDtoFromJson(json);
}

/// Interval usage response DTO
@freezed
class IntervalUsageResponseDto with _$IntervalUsageResponseDto {
  const factory IntervalUsageResponseDto({
    required int status,
    String? message,
    @Default([]) List<IntervalUsageEntryDto> data,
  }) = _IntervalUsageResponseDto;

  factory IntervalUsageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$IntervalUsageResponseDtoFromJson(json);
}

/// Monthly usage entry DTO
@freezed
class MonthlyUsageEntryDto with _$MonthlyUsageEntryDto {
  const factory MonthlyUsageEntryDto({
    required int year,
    required int month,
    required double monthlyUsageKwh,
  }) = _MonthlyUsageEntryDto;

  factory MonthlyUsageEntryDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyUsageEntryDtoFromJson(json);
}

/// Monthly usage response DTO
@freezed
class MonthlyUsageResponseDto with _$MonthlyUsageResponseDto {
  const factory MonthlyUsageResponseDto({
    required int status,
    String? message,
    @Default([]) List<MonthlyUsageEntryDto> data,
  }) = _MonthlyUsageResponseDto;

  factory MonthlyUsageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyUsageResponseDtoFromJson(json);
}

/// Yearly usage DTO
@freezed
class YearlyUsageDto with _$YearlyUsageDto {
  const factory YearlyUsageDto({
    required double yearlyUsageKwh,
  }) = _YearlyUsageDto;

  factory YearlyUsageDto.fromJson(Map<String, dynamic> json) =>
      _$YearlyUsageDtoFromJson(json);
}

/// Yearly usage response DTO
@freezed
class YearlyUsageResponseDto with _$YearlyUsageResponseDto {
  const factory YearlyUsageResponseDto({
    required int status,
    String? message,
    required YearlyUsageDto data,
  }) = _YearlyUsageResponseDto;

  factory YearlyUsageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$YearlyUsageResponseDtoFromJson(json);
}
