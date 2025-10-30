import 'package:flutter/foundation.dart';

import 'web_operations.dart';

/// Service for HTTPS enforcement and secure connection management
class HTTPSEnforcementService {
  HTTPSEnforcementService._();
  static HTTPSEnforcementService? _instance;
  
  static HTTPSEnforcementService get instance {
    _instance ??= HTTPSEnforcementService._();
    return _instance!;
  }

  // Use conditional imports to get the appropriate implementation
  static WebOperations get _webOperations {
    if (kIsWeb) {
      // This will be replaced by conditional import in web_operations_stub.dart
      return MockWebOperations();
    }
    return MockWebOperations();
  }

  /// Check if current connection is HTTPS
  bool get isHTTPS => _webOperations.isHTTPS;

  /// Check if current connection is secure
  bool get isSecureConnection => _webOperations.isSecureConnection;

  /// Get current protocol
  String get currentProtocol => _webOperations.currentProtocol;

  /// Get current hostname
  String get currentHostname => _webOperations.currentHostname;

  /// Get current port
  String get currentPort => _webOperations.currentPort;

  /// Get current origin
  String get currentOrigin => _webOperations.currentOrigin;

  /// Force HTTPS redirect if not already on HTTPS
  void enforceHTTPS() => _webOperations.enforceHTTPS();

  /// Check for mixed content issues
  List<String> checkMixedContent() => _webOperations.checkMixedContent();

  /// Upgrade insecure requests
  void upgradeInsecureRequests() => _webOperations.upgradeInsecureRequests();

  /// Block mixed content
  void blockMixedContent() => _webOperations.blockMixedContent();

  /// Set HSTS header programmatically
  void setHSTSHeader({int maxAge = 31536000, bool includeSubDomains = true, bool preload = true}) {
    _webOperations.setHSTSHeader(
      maxAge: maxAge,
      includeSubDomains: includeSubDomains,
      preload: preload,
    );
  }

  /// Validate HTTPS configuration
  Map<String, dynamic> validateHTTPSConfiguration() => _webOperations.validateHTTPSConfiguration();

  /// Get HTTPS enforcement report
  Map<String, dynamic> getHTTPSReport() => _webOperations.getHTTPSReport();

  /// Initialize HTTPS enforcement
  void initializeHTTPSEnforcement() {
    // Force HTTPS redirect in production
    if (!kDebugMode && !isHTTPS) {
      enforceHTTPS();
    }

    // Upgrade insecure requests
    upgradeInsecureRequests();

    // Block mixed content
    blockMixedContent();

    // Set appropriate HSTS header
    if (isHTTPS) {
      setHSTSHeader(
        maxAge: kDebugMode ? 300 : 31536000, // 5 minutes in dev, 1 year in prod
        includeSubDomains: true,
        preload: !kDebugMode,
      );
    }
  }

  /// Monitor HTTPS status
  void startHTTPSMonitoring() => _webOperations.startHTTPSMonitoring();

  /// Get security headers for HTTPS enforcement
  Map<String, String> getHTTPSHeaders() => _webOperations.getHTTPSHeaders();
}