import 'package:flutter/foundation.dart';

/// Abstract interface for web-specific operations
abstract class WebOperations {
  bool get isHTTPS;
  bool get isSecureConnection;
  String get currentProtocol;
  String get currentHostname;
  String get currentPort;
  String get currentOrigin;
  
  void enforceHTTPS();
  List<String> checkMixedContent();
  void upgradeInsecureRequests();
  void blockMixedContent();
  void setHSTSHeader({int maxAge = 31536000, bool includeSubDomains = true, bool preload = true});
  
  Map<String, dynamic> validateHTTPSConfiguration();
  Map<String, dynamic> getHTTPSReport();
  Map<String, String> getHTTPSHeaders();
  
  void startHTTPSMonitoring();
}

/// Mock implementation for non-web platforms and tests
class MockWebOperations implements WebOperations {
  @override
  bool get isHTTPS => true;

  @override
  bool get isSecureConnection => true;

  @override
  String get currentProtocol => 'https:';

  @override
  String get currentHostname => 'localhost';

  @override
  String get currentPort => '443';

  @override
  String get currentOrigin => 'https://localhost';

  @override
  void enforceHTTPS() {
    // No-op for non-web platforms
  }

  @override
  List<String> checkMixedContent() {
    return []; // No mixed content issues in non-web platforms
  }

  @override
  void upgradeInsecureRequests() {
    // No-op for non-web platforms
  }

  @override
  void blockMixedContent() {
    // No-op for non-web platforms
  }

  @override
  void setHSTSHeader({int maxAge = 31536000, bool includeSubDomains = true, bool preload = true}) {
    // No-op for non-web platforms
  }

  @override
  Map<String, dynamic> validateHTTPSConfiguration() => {
      'isHTTPS': true,
      'isSecureConnection': true,
      'currentProtocol': 'https:',
      'currentHostname': 'localhost',
      'currentPort': '443',
      'currentOrigin': 'https://localhost',
      'issues': <String>[],
      'warnings': <String>[],
      'recommendations': <String>[],
      'hasHSTS': true,
      'hasCSP': true,
      'mixedContentIssues': 0,
      'securityScore': 100,
    };

  @override
  Map<String, dynamic> getHTTPSReport() => {
      'timestamp': DateTime.now().toIso8601String(),
      'environment': kDebugMode ? 'development' : 'production',
      'validation': validateHTTPSConfiguration(),
      'mixedContentIssues': <String>[],
      'recommendations': <String>[],
    };

  @override
  Map<String, String> getHTTPSHeaders() => {
      'Strict-Transport-Security': 'max-age=31536000; includeSubDomains; preload',
      'X-Content-Type-Options': 'nosniff',
      'X-Frame-Options': 'DENY',
      'X-XSS-Protection': '1; mode=block',
      'Referrer-Policy': 'strict-origin-when-cross-origin',
    };

  @override
  void startHTTPSMonitoring() {
    // No-op for non-web platforms
  }
}
