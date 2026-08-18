import 'package:bel247_web/app.dart';
import 'package:bel247_web/core/providers/riverpod_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BEL247 app mounts (same scope as main)', (WidgetTester tester) async {
    await tester.pumpWidget(
      RiverpodConfig.createScope(
        child: const BEL247App(),
      ),
    );
    await tester.pump();

    expect(find.byType(MaterialApp), findsWidgets);
  });
}
