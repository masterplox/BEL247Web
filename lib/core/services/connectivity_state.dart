/// Tracks whether the app considers the device online (web: Navigator.onLine).
class ConnectivityState {
  const ConnectivityState({required this.isOnline});

  final bool isOnline;
  bool get isOffline => !isOnline;

  static const ConnectivityState online = ConnectivityState(isOnline: true);
  static const ConnectivityState offline = ConnectivityState(isOnline: false);
}
