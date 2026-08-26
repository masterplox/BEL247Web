import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// App version from Flutter (`pubspec.yaml`), without the `+` build suffix.
///
/// `PackageInfo.version` is the `2.1.2` part; `buildNumber` is the value after
/// `+`. We only surface the version numbers.
final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  final version = info.version.trim();
  if (version.isEmpty) return '';
  return version.split('+').first;
});
