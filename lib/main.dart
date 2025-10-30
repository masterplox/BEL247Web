import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/env.dart';
import 'core/providers/providers.dart';
import 'core/providers/riverpod_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await EnvConfig.load();
  
  runApp(
    RiverpodConfig.createScope(
      child: const BEL247App(),
    ),
  );
}