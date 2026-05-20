import '../../core/config/env.dart';

/// API endpoints constants
/// 
/// All endpoints are defined here with the base domain configured in EnvConfig.
/// The domain is prepended to each endpoint path.
/// Base URL: https://m.bel.com.bz/MobileApisTest
class ApiEndpoints {
  ApiEndpoints._();

  /// Base API domain from environment configuration
  static String get baseUrl => EnvConfig.currentApiUrl;

  // ============================================================================
  // Authentication Endpoints
  // ============================================================================
  
  /// User device login
  /// POST /DeviceSession/V3/Login
  /// Auth: No (0)
  /// Body: { Username, Password, DeviceUUID, PlatformType, DeviceModel }
  static String get login => '/DeviceSession/V3/Login';

  /// User logout
  /// POST /DeviceSession/V3/Logout
  /// Auth: Yes (1)
  /// Body: Empty
  static String get logout => '/DeviceSession/V3/Logout';

  /// Deliver password reset code (login / public flow)
  /// POST /General/V5/Devices/PasswordCode
  /// Auth: No
  /// Body: exactly one of { MobileNumber, Email, Username }
  static String get passwordCodePublic => '/General/V5/Devices/PasswordCode';

  /// Reset password after code validation (login / public flow)
  /// POST /General/V2/Devices/Password
  /// Auth: No
  /// Body: { Username, Password, PasswordCode }
  static String get resetPasswordPublic => '/General/V2/Devices/Password';

  /// Deliver password reset code (logged-in flow)
  /// POST /DeviceSession/V5/Devices/PasswordCode
  /// Auth: Yes
  /// Body: exactly one of { MobileNumber, Email, Username }
  static String get passwordCodeAuthenticated => '/DeviceSession/V5/Devices/PasswordCode';

  /// Reset password after code validation (logged-in flow)
  /// POST /DeviceSession/V2/Devices/Password
  /// Auth: Yes
  /// Body: { Username, Password, PasswordCode }
  static String get resetPasswordAuthenticated => '/DeviceSession/V2/Devices/Password';

  /// Token refresh endpoint (if needed)
  /// Note: Check actual API for refresh token endpoint
  static String get refreshToken => '/DeviceSession/V3/Refresh';

  // ============================================================================
  // Sign Up Endpoints
  // ============================================================================

  /// Sign up Step 1 - Deliver OTP
  /// POST /DeviceSession/V5/Devices/Deliver
  /// Auth: No (0)
  /// Body: { MobileNumber, Email, Username }
  static String get signUpStep1 => '/DeviceSession/V5/Devices/Deliver';

  /// Sign up Step 2 - Activate device with OTP
  /// POST /DeviceSession/V5/Devices/Activate
  /// Auth: No (0)
  /// Body: { Code, PhoneNumber, Email }
  static String get signUpStep2 => '/DeviceSession/V5/Devices/Activate';

  /// Sign up Step 3 - Register user
  /// POST /SignUp/V2/Register
  /// Auth: No (0)
  /// Body: { Username, Password, Email, MobileNumber, GuestUUID }
  static String get signUpStep3 => '/SignUp/V2/Register';

  // ============================================================================
  // Customer Account Endpoints
  // ============================================================================

  /// Get user connected accounts
  /// GET /CustomerAccounts/V4/PreferredCustomerAccounts
  /// Auth: Yes (1)
  /// Query: None
  static String get connectedAccounts => '/CustomerAccounts/V4/PreferredCustomerAccounts';

  /// Deliver activation code for Premium Access (full account access)
  /// POST /CustomerAccounts/V5/FullAccess/ActivationCode
  /// Auth: Yes (1)
  /// Body: { CustomerNumber, AccountNumber, MobileNumber or Email }
  static String get fullAccessActivationCode => '/CustomerAccounts/V5/FullAccess/ActivationCode';

  /// Activate Premium Access using code
  /// POST /CustomerAccounts/V5/FullAccess/Activate
  /// Auth: Yes (1)
  /// Body: { UserId, Code, CustomerNumber, AccountNumber, MobileNumber or Email }
  static String get fullAccessActivate => '/CustomerAccounts/V5/FullAccess/Activate';

  /// Get customer account information
  /// GET /CustomerAccounts/V3/Detail
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber }
  static String get customerAccountDetail => '/CustomerAccounts/V3/Detail';

  /// Connect customer account
  /// POST /CustomerAccounts/V2/Connect
  /// Auth: Yes (1)
  /// Body: { CustomerNumber, AccountNumberHint, NickName }
  static String get connectCustomerAccount => '/CustomerAccounts/V2/Connect';

  /// Edit nickname or remove connected account (send full account DTO)
  /// PUT /CustomerAccounts/V3/PreferredCustomerAccounts
  /// Auth: Yes (1)
  static String get updatePreferredCustomerAccount =>
      '/CustomerAccounts/V3/PreferredCustomerAccounts';

  // ============================================================================
  // Bill Endpoints
  // ============================================================================

  /// Get bill detail
  /// GET /Bills/V3/Detail/{billNumber}
  /// Auth: Yes (1)
  /// Path: billNumber
  static String billDetail(String billNumber) => '/Bills/V3/Detail/$billNumber';

  /// Get bill download URL
  /// GET /Bills/V1/Url/PDFString/{billNumber}/{customerNumber}
  /// Auth: Yes (1)
  /// Path: billNumber, customerNumber
  static String billDownloadUrl(String billNumber, String customerNumber, String accountNumber) => 
      '/Bills/V1/Url/PDFString/$billNumber/$customerNumber/$accountNumber';

  /// Deliver activation code for bill download access
  /// POST /Bills/V5/BillDownloadActivationCode
  /// Auth: Yes (1)
  /// Body: { BillNumber }
  static String get billDownloadActivationCode => '/Bills/V5/BillDownloadActivationCode';

  /// Validate activation code for bill download access
  /// POST /Bills/V5/BillDownloadAuthenticationCode
  /// Auth: Yes (1)
  /// Body: { Code, BillNumber }
  static String get billDownloadAuthenticationCode => '/Bills/V5/BillDownloadAuthenticationCode';

  // ============================================================================
  // Payment/Transaction Endpoints
  // ============================================================================

  /// Get payment/transaction detail
  /// GET /Payments/V3/Detail/{transactionNumber}
  /// Auth: Yes (1)
  /// Path: transactionNumber
  static String transactionDetail(String transactionNumber) => 
      '/Payments/V3/Detail/$transactionNumber';

  /// Get account transaction/payment history
  /// GET /Payments/V2/Payments
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber }
  static String get transactionHistory => '/Payments/V2/Payments';

  /// CC/Debit Payment Process
  /// GET /Payments/V1/BBBillPay
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber, payingAmount }
  static String get paymentProcess => '/Payments/V1/BBBillPay';

  // ============================================================================
  // Receipt Endpoints
  // ============================================================================

  /// Download receipt URL
  /// GET /Receipts/V1/Url/PDF/{receiptNumber}/{customerNumber}
  /// Auth: Yes (1)
  /// Path: receiptNumber, customerNumber
  static String receiptDownloadUrl(String receiptNumber, String customerNumber, String accountNumber) => 
      '/Receipts/V1/Url/PDF/$receiptNumber/$customerNumber/$accountNumber';

  // ============================================================================
  // Meter Readings Endpoints
  // ============================================================================

  /// Get meter readings for this year
  /// GET /CustomerAccounts/V3/Readings
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber }
  static String get meterReadingsThisYear => '/CustomerAccounts/V3/Readings';

  /// Get meter readings for last year
  /// GET /CustomerAccounts/V3/Readings/Year
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber }
  static String get meterReadingsLastYear => '/CustomerAccounts/V3/Readings/Year';

  /// Get meter readings for the year before last (two years ago)
  /// GET /CustomerAccounts/V3/Readings/YearTwo
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber }
  static String get meterReadingsYearTwo => '/CustomerAccounts/V3/Readings/YearTwo';

  // ============================================================================
  // User Endpoints
  // ============================================================================

  /// Get user status
  /// GET /User/V3/Status
  /// Auth: Yes (1)
  /// Query: { versionNumber, buildNumber, platformType }
  static String get userStatus => '/User/V3/Status';

  // ============================================================================
  // AMI Usage Endpoints
  // ============================================================================

  /// Get daily interval kWh details for a meter and date
  /// GET /V1/MeterUsage/DailyIntervals
  /// Auth: Yes (1)
  /// Query: { meterId, targetDate }
  static String get amiDailyIntervals => '/AMI/DailyIntervals';

  /// Get daily usage for a date range
  /// GET /V1/MeterUsage/DailyRange
  /// Auth: Yes (1)
  /// Query: { meterId, startDate, endDate }
  static String get amiDailyRange => '/AMI/DailyRange';

  /// Get monthly totals for a year
  /// GET /V1/MeterUsage/MonthlyTotals
  /// Auth: Yes (1)
  /// Query: { meterId, year }
  static String get amiMonthlyTotals => '/AMI/MonthlyTotals';

  // ============================================================================
  // Digiwallet Endpoints
  // ============================================================================

  /// Digiwallet Step 1 - Get code
  /// GET /Digiwallet/V1/Code
  /// Auth: Yes (1)
  /// Query: { customerNumber, accountNumber, mobileNumber, payingAmount }
  static String get digiwalletCode => '/Digiwallet/V1/Code';

  /// Digiwallet Step 2 - Validate code
  /// GET /Digiwallet/V1/Code/Validate
  /// Auth: Yes (1)
  /// Query: { smsCode, requestId }
  static String get digiwalletValidate => '/Digiwallet/V1/Code/Validate';

  // ============================================================================
  // Analytics & support
  // ============================================================================

  /// Log client/device events (navigation, interaction, lifecycle)
  /// POST /ApiEvent/V1/Event
  /// Auth: Yes
  /// Body: { PageEvent, EventType, EventSubtype, EventDetails }
  static String get deviceEvent => '/ApiEvent/V1/Event';

  /// Submit general support / feedback request
  /// POST /General/V5/AppSupportRequestGen
  /// Auth: Yes
  static String get appSupportRequest => '/General/V5/AppSupportRequestGen';

  /// Build full URL from endpoint path
  /// 
  /// Example: buildUrl('/DeviceSession/V3/Login') -> 'https://m.bel.com.bz/MobileApisTest/DeviceSession/V3/Login'
  static String buildUrl(String endpoint) {
    if (endpoint.startsWith('http://') || endpoint.startsWith('https://')) {
      return endpoint;
    }
    final base = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    final path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return '$base$path';
  }
}
