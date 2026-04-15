/// Centralized user-friendly error messages for BEL247 web app.
///
/// All messages are written in plain language — no technical jargon
/// or error codes are ever shown to users.
///
/// Usage:
/// ```dart
/// AppToast.error(context, ErrorMessages.offline);
/// ```
class ErrorMessages {
  ErrorMessages._();

  // ── Network & Connectivity ────────────────────────────────────────────────

  static const String offline =
      "You're offline. Check your connection and we'll pick up where you left off.";
  static const String backOnline = "You're back online!";
  static const String slowConnection =
      "This is taking longer than usual. Still trying…";
  static const String timeout =
      "The server didn't respond in time. Check your connection and try again.";
  static const String noInternet =
      "Can't reach our servers right now. Check your connection and try again.";
  static const String connectionFailed =
      "Couldn't connect. Make sure you're online and try again.";

  // ── Server Errors ─────────────────────────────────────────────────────────

  static const String serverError =
      "Something went wrong on our end. We're on it — please try again in a moment.";
  static const String serviceUnavailable =
      "Our servers are taking a quick break. Try again in a moment.";
  static const String badGateway =
      "We're having trouble reaching our services. Try again shortly.";

  // ── Authentication & Session ──────────────────────────────────────────────

  static const String sessionExpired =
      "Your session expired for security. Please log in again to continue.";
  static const String unauthorised = "Please log in to continue.";
  static const String forbidden = "You don't have permission to do that.";
  static const String tokenRefreshFailed =
      "We couldn't renew your session. Please log in again.";
  static const String loginFailed =
      "Couldn't log you in. Double-check your credentials and try again.";
  static const String loggedOutElsewhere =
      "You've been logged out in another tab. Refresh to continue here.";

  // ── Data Loading ──────────────────────────────────────────────────────────

  static const String loadFailed =
      "Couldn't load this content. Tap to try again.";
  static const String dataLoadFailed =
      "Something went wrong loading your data. Let's try that again.";
  static const String billLoadFailed =
      "Couldn't load your bills right now. Try refreshing the page.";
  static const String usageLoadFailed =
      "Couldn't load your usage data. Try again shortly.";
  static const String parseFailed =
      "We received unexpected data. Refresh to try again.";
  static const String emptyData = "No data available yet.";

  // ── File & Downloads ──────────────────────────────────────────────────────

  static const String downloadFailed =
      "Couldn't download this file. Check your connection and try again.";
  static const String fileTooLarge =
      "That file is too large. Try a file under 10 MB.";
  static const String unsupportedFormat = "This file type isn't supported.";

  // ── Forms & Validation ────────────────────────────────────────────────────

  static const String formHasErrors =
      "Please check the highlighted fields and try again.";
  static const String requiredField = "This field is required.";
  static const String invalidEmail =
      "Please enter a valid email address, e.g. name@example.com";
  static const String invalidPhone = "Please enter a valid phone number.";
  static const String passwordTooShort =
      "Password must be at least 8 characters.";
  static const String passwordsDoNotMatch = "Passwords don't match.";

  // ── Browser & Storage ────────────────────────────────────────────────────

  static const String storageFull =
      "Your browser storage is full. Clear some space and try again.";
  static const String storageUnavailable =
      "Storage isn't available. Try disabling private browsing mode.";
  static const String browserUnsupported =
      "Your browser doesn't support this feature. Try updating to the latest version.";
  static const String clipboardDenied =
      "Clipboard access was blocked. Check your browser permissions.";

  // ── Navigation & Routing ─────────────────────────────────────────────────

  static const String pageNotFound =
      "We couldn't find that page. Let's get you back on track.";
  static const String linkExpired =
      "This link has expired. Head back to the dashboard.";
  static const String invalidLink =
      "This link doesn't look right. Try navigating from the menu.";

  // ── Generic / Fallback ────────────────────────────────────────────────────

  static const String unexpected =
      "Something unexpected happened. Refresh the page to start fresh.";
  static const String tryAgain = "Something went wrong. Please try again.";
  static const String contactSupport =
      "If this keeps happening, contact our support team for help.";

  // ── Recovery Action Labels ────────────────────────────────────────────────

  static const String retryAction = "Try Again";
  static const String refreshAction = "Refresh Page";
  static const String goHomeAction = "Go to Dashboard";
  static const String contactSupportAction = "Contact Support";
  static const String loginAgainAction = "Log In Again";
}
