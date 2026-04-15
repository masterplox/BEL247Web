/// Maps app routes and feature keys to analytics PageEvent / navigation labels.
class AppPageNames {
  AppPageNames._();

  static const String dashboard = 'Dashboard';
  static const String transactionHistory = 'TransactionHistory';
  static const String usage = 'Usage';
  static const String amiUsage = 'AmiUsage';
  static const String dailyBill = 'DailyBill';
  static const String unknown = 'Unknown';

  /// Dialog / feature identifiers for EventDetails (Interaction + DialogOpen).
  static const String connectCustomerAccount = 'ConnectCustomerAccount';

  /// Navigation EventSubtype value for the current shell matchedLocation.
  static String navigationSubtypeForRoute(String matchedLocation) {
    if (matchedLocation == '/dashboard') return dashboard;
    if (matchedLocation.startsWith('/bills')) return transactionHistory;
    if (matchedLocation.startsWith('/ami-usage')) return amiUsage;
    if (matchedLocation.startsWith('/usage')) return usage;
    if (matchedLocation.startsWith('/daily-bill')) return dailyBill;
    if (matchedLocation.startsWith('/secure/')) {
      return _secureRouteSubtype(matchedLocation);
    }
    return unknown;
  }

  static String _secureRouteSubtype(String loc) {
    final path = loc.split('?').first;
    if (path.contains('bills')) return transactionHistory;
    if (path.contains('ami-usage')) return amiUsage;
    if (path.contains('usage')) return usage;
    if (path.contains('daily-bill')) return dailyBill;
    if (path.contains('dashboard')) return dashboard;
    return unknown;
  }
}
