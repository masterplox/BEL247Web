import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_notifier_stub.dart'
    if (dart.library.html) 'connectivity_notifier_web.dart';
import 'connectivity_state.dart';

export 'connectivity_state.dart';

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityState>(
  (ref) => ConnectivityNotifier(),
);

/// `true` when the browser reports a network connection.
final isOnlineProvider =
    Provider<bool>((ref) => ref.watch(connectivityProvider).isOnline);

/// `true` when the browser reports no network connection.
final isOfflineProvider =
    Provider<bool>((ref) => ref.watch(connectivityProvider).isOffline);
