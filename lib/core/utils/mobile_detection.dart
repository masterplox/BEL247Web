import 'dart:js_interop';

import 'package:flutter/foundation.dart';

@JS('navigator.userAgent')
external JSString get _navigatorUserAgent;

/// Detects whether the visitor is on a mobile phone (not tablet).
///
/// Android phones report both "android" and "mobile" in their UA string.
/// Android tablets report "android" but NOT "mobile".
/// iPhones report "iphone"; iPads report "ipad" (never "mobile").
/// This means tablets — Android or iPad — pass through as non-mobile.
class MobileDetection {
  static bool get isMobilePhone {
    if (!kIsWeb) return false;
    try {
      final ua = _navigatorUserAgent.toDart.toLowerCase();
      final isIphone = ua.contains('iphone') || ua.contains('ipod');
      final isAndroidPhone = ua.contains('android') && ua.contains('mobile');
      return isIphone || isAndroidPhone;
    } catch (_) {
      return false;
    }
  }
}
