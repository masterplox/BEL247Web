import 'package:bel247_web/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('BEL247 App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: BEL247App(),
      ),
    );

    // Verify that our app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
