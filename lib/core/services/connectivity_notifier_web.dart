import 'dart:async';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';
import 'connectivity_state.dart';

/// Monitors browser online/offline via [html.window] events.
class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  ConnectivityNotifier()
      : super(
          ConnectivityState(isOnline: html.window.navigator.onLine ?? true),
        ) {
    _subscribeToEvents();
  }

  StreamSubscription<html.Event>? _onlineSub;
  StreamSubscription<html.Event>? _offlineSub;

  void _subscribeToEvents() {
    _onlineSub = html.window.onOnline.listen((_) {
      Logger.info('Network: back online', tag: 'Connectivity');
      state = ConnectivityState.online;
    });

    _offlineSub = html.window.onOffline.listen((_) {
      Logger.warning('Network: went offline', tag: 'Connectivity');
      state = ConnectivityState.offline;
    });
  }

  @override
  void dispose() {
    _onlineSub?.cancel();
    _offlineSub?.cancel();
    super.dispose();
  }
}
