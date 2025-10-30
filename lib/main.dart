import 'package:flutter/material.dart';

import 'app.dart';
import 'core/providers/providers.dart';
import 'core/providers/riverpod_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RiverpodConfig.createScope(
      child: const BEL247App(),
    ),
  );
}