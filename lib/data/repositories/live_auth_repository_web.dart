// Web-specific implementation
// This file is only imported on web platform where dart:html is available

import 'dart:html' as html;

/// Get user agent string from browser
String getUserAgent() {
  try {
    return html.window.navigator.userAgent.toLowerCase() ?? '';
  } catch (e) {
    return '';
  }
}
