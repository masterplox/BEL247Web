// Production-style integration tests: real [BEL247App], live auth API, and UI taps.
//
// Run (web — closest to production):
//   flutter test integration_test/e2e_smoke_test.dart -d chrome
//
// Run (device / desktop):
//   flutter test integration_test/e2e_smoke_test.dart
//
// Logged-in flow requires compile-time defines (do not commit real secrets):
//   flutter test integration_test/e2e_smoke_test.dart -d chrome \
//     --dart-define=E2E_USER=your@email.com \
//     --dart-define=E2E_PASSWORD=your_password

import 'package:bel247_web/app.dart';
import 'package:bel247_web/core/providers/riverpod_config.dart';
import 'package:bel247_web/core/widgets/app_button.dart';
import 'package:bel247_web/data/services/token_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const e2eUser = String.fromEnvironment('E2E_USER', defaultValue: '');
  const e2ePassword = String.fromEnvironment('E2E_PASSWORD', defaultValue: '');
  final hasE2eCredentials = e2eUser.isNotEmpty && e2ePassword.isNotEmpty;

  Future<void> pumpRealApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });
    await tester.pumpWidget(
      RiverpodConfig.createScope(
        child: const BEL247App(),
      ),
    );
  }

  group('Production E2E', () {
    testWidgets('shows sign-in when starting without a session', (tester) async {
      await TokenStorageService.clearAll();
      await pumpRealApp(tester);

      var seenSignIn = false;
      for (var i = 0; i < 90; i++) {
        await tester.pump(const Duration(milliseconds: 500));
        if (find.text('Sign In').evaluate().isNotEmpty) {
          seenSignIn = true;
          break;
        }
      }
      expect(seenSignIn, isTrue, reason: 'Expected login shell (Sign In) after auth init');
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets(
      'logs in and opens dashboard, usage, and transaction history via shell nav',
      (tester) async {
        await TokenStorageService.clearAll();
        await pumpRealApp(tester);

        for (var i = 0; i < 90; i++) {
          await tester.pump(const Duration(milliseconds: 500));
          if (find.text('Sign In').evaluate().isNotEmpty) break;
        }

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), e2eUser);
        await tester.enterText(fields.at(1), e2ePassword);
        await tester.tap(find.widgetWithText(AppButton, 'Sign In'));
        await tester.pump();

        var reachedShell = false;
        for (var i = 0; i < 180; i++) {
          await tester.pump(const Duration(milliseconds: 500));
          if (find.textContaining('Welcome back').evaluate().isNotEmpty) {
            reachedShell = true;
            break;
          }
        }
        expect(
          reachedShell,
          isTrue,
          reason: 'Expected dashboard welcome header after successful login (check API/credentials)',
        );

        Future<void> settleUi() async {
          for (var i = 0; i < 40; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
        }

        await tester.tap(find.text('Transaction History').first);
        await settleUi();
        expect(find.text('Transaction History'), findsWidgets);

        await tester.tap(find.text('Dashboard').first);
        await settleUi();

        await tester.tap(find.text('Usage History').first);
        await settleUi();
        expect(find.text('Usage History'), findsWidgets);
      },
      skip: !hasE2eCredentials,
    );
  });
}
