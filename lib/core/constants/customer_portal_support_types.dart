/// Support categories for Customer Portal Support (WebPortalAppSupportRequest / RequestGen).
class CustomerPortalSupportTypes {
  CustomerPortalSupportTypes._();

  static const String general = 'General Support';
  static const String registerCode = 'Code Issue - Register';
  static const String passwordResetCode = 'Code Issue - Password Reset';
  static const String billDownloadCode = 'Code Issue - Bill Download Access';
  static const String premiumUpgradeCode = 'Code Issue - Premium Level Upgrade';

  static const List<String> all = [
    general,
    registerCode,
    passwordResetCode,
    billDownloadCode,
    premiumUpgradeCode,
  ];
}
