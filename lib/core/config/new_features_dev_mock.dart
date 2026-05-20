import '../utils/logger.dart';
import 'env.dart';

/// Dev-only mocks for the new password-reset and connected-account endpoints.
///
/// **Turn all flags off before release** (`false` everywhere).
///
/// | mockSuccess | mockFailure | Behavior |
/// |-------------|-------------|----------|
/// | false       | false       | Real API (default) |
/// | true        | false       | Skip network; return success |
/// | false       | true        | Skip network; return failure |
/// | true        | true        | Failure wins (tests error UI) |
///
/// | mockAllAccountsFullAccess | Behavior |
/// |---------------------------|----------|
/// | false                     | Use API `fullAccess` values (default) |
/// | true                      | All connected accounts report Premium (`fullAccess: true`) — **development only** |
///
/// Affects:
/// - Password code (public + logged-in)
/// - Device password reset (public + logged-in)
/// - Edit nickname / remove account (V3 PUT)
/// - Connected accounts list / account details (`fullAccess` override)
///
/// Note: account edit/remove still loads account details from the real GET before
/// the mocked PUT. After a mocked **remove**, the account list refresh still
/// calls the live GET, so the row may remain until the backend reflects the change.
class NewFeaturesDevMock {
  NewFeaturesDevMock._();

  /// Simulate successful API responses without calling the server.
  static const bool mockSuccess = false;

  /// Simulate failed API responses without calling the server.
  static const bool mockFailure = false;

  /// Treat every connected account as Premium Level (`fullAccess: true`).
  ///
  /// Only applies when [EnvConfig.isDevelopment] is true — ignored in staging/production
  /// even if left `true` by mistake.
  static const bool mockAllAccountsFullAccess = false;

  static const String _tag = 'NewFeaturesDevMock';

  static bool get isActive => mockSuccess || mockFailure;

  /// True when [mockAllAccountsFullAccess] should override API `fullAccess` flags.
  static bool get mockAllAccountsFullAccessActive =>
      mockAllAccountsFullAccess && EnvConfig.isDevelopment;

  static void _logMode(String operation) {
    if (mockFailure) {
      Logger.warning(
        '[$operation] MOCK FAILURE — no API call',
        tag: _tag,
      );
    } else if (mockSuccess) {
      Logger.warning(
        '[$operation] MOCK SUCCESS — no API call',
        tag: _tag,
      );
    }
  }

  /// Returns non-null to short-circuit the real API call (after [simulatedDelay]).
  static T? intercept<T>({
    required String operation,
    required T Function() onSuccess,
    required T Function(String message) onFailure,
    String failureMessage =
        '[Dev mock] Simulated failure — see new_features_dev_mock.dart',
  }) {
    if (!isActive) {
      return null;
    }

    _logMode(operation);

    if (mockFailure) {
      return onFailure(failureMessage);
    }
    return onSuccess();
  }

  /// Simulated network delay so loading states are visible in the UI.
  static Future<void> simulatedDelay() async {
    if (!isActive) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }
}
