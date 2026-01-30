// Web-only: read API base URL from window.__BEL247_CONFIG__ (injected at deploy time in index.html).

import 'dart:html' as html;
import 'dart:js_util' as js_util;

/// Returns API_BASE_URL from window.__BEL247_CONFIG__ if set and not the placeholder; otherwise null.
String? getRuntimeApiBaseUrl() {
  try {
    final config = js_util.getProperty(html.window, '__BEL247_CONFIG__');
    if (config == null) return null;
    final url = js_util.getProperty(config, 'API_BASE_URL');
    if (url == null) return null;
    final s = url.toString().trim();
    // Placeholder left unreplaced (e.g. local dev) → use compile-time config
    if (s.isEmpty || s == '__API_BASE_URL__') return null;
    return s;
  } catch (_) {
    return null;
  }
}
