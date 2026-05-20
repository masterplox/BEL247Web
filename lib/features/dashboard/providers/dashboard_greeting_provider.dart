import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/user_preferences_storage.dart';
import '../../auth/providers/auth_provider.dart';

/// Whether to show "Welcome back" (true) vs first-time "Welcome" (false).
final showWelcomeBackGreetingProvider = FutureProvider<bool>((ref) async {
  final session = ref.watch(authNotifierProvider).userSession;
  if (session == null) return false;
  return UserPreferencesStorage.hasShownWelcomeBack(session.userId);
});
