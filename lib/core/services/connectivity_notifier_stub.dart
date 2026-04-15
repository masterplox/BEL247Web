import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_state.dart';

/// Non-web / VM: assume online (no Navigator events).
class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  ConnectivityNotifier() : super(ConnectivityState.online);
}
