import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// Import for web platform only
import 'dart:html' as html;

import '../config/env.dart';
import '../constants/api_endpoints.dart';
import '../utils/logger.dart';
import '../widgets/app_dialog.dart';
import '../../data/services/http_client.dart';
import '../../data/models/api_response_dtos.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';

/// Service for downloading bills and receipts
class DownloadService {
  DownloadService._internal();
  static final DownloadService _instance = DownloadService._internal();
  static DownloadService get instance => _instance;

  final _httpClient = HttpClient.instance;

  /// Download a bill PDF
  /// Shows confirmation dialog, progress indicator, and completion dialog
  static Future<void> downloadBill({
    required BuildContext context,
    required String billNumber,
    required String customerNumber,
    required String accountNumber,
    String? billDisplayName,
  }) async {
    final displayName = billDisplayName ?? 'Bill #$billNumber';
    
    print('[DownloadService] ========================================');
    print('[DownloadService] DOWNLOAD BILL INITIATED');
    print('[DownloadService] Bill Number: $billNumber');
    print('[DownloadService] Customer Number: $customerNumber');
    print('[DownloadService] Account Number: $accountNumber');
    print('[DownloadService] Display Name: $displayName');
    print('[DownloadService] ========================================');
    
    // Show confirmation dialog
    print('[DownloadService] Showing confirmation dialog...');
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Download Bill',
      message: 'Do you want to download $displayName?',
    );
    
    print('[DownloadService] User confirmed: $confirmed');
    
    if (!confirmed || !context.mounted) {
      print('[DownloadService] Download cancelled or context not mounted');
      return;
    }

    // Show progress dialog
    print('[DownloadService] Showing progress dialog...');
    _showProgressDialog(
      context,
      title: 'Downloading Bill',
      message: 'Please wait while we prepare your download...',
    );

    try {
      print('[DownloadService] Starting to fetch download URL from API...');
      
      // Fetch download URL from API
      final downloadUrl = await _instance._fetchBillDownloadUrl(
        billNumber: billNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
      );

      print('[DownloadService] ✅ Download URL received: $downloadUrl');

      // Close progress dialog
      if (context.mounted) {
        print('[DownloadService] Closing progress dialog...');
        try {
          Navigator.of(context, rootNavigator: true).pop();
          print('[DownloadService] ✅ Progress dialog closed');
        } catch (e) {
          print('[DownloadService] ⚠️ Error closing progress dialog: $e');
        }
      }

      // Trigger download
      print('[DownloadService] Triggering browser download...');
      await _instance._triggerDownload(downloadUrl, '$billNumber.pdf');
      print('[DownloadService] ✅ Download triggered successfully');

      // Show success dialog
      if (context.mounted) {
        print('[DownloadService] Showing success dialog...');
        await _showSuccessDialog(
          context,
          title: 'Download Complete',
          message: '$displayName has been downloaded successfully.',
        );
      }
      
      print('[DownloadService] ========================================');
      print('[DownloadService] DOWNLOAD BILL COMPLETED SUCCESSFULLY');
      print('[DownloadService] ========================================');
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ ERROR OCCURRED:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
      
      // Close progress dialog if still open
      if (context.mounted) {
        print('[DownloadService] Closing progress dialog due to error...');
        try {
          Navigator.of(context, rootNavigator: true).pop();
          print('[DownloadService] ✅ Progress dialog closed');
        } catch (e) {
          print('[DownloadService] ⚠️ Error closing progress dialog: $e');
        }
      }

      // Show error dialog
      if (context.mounted) {
        print('[DownloadService] Showing error dialog...');
        await _showErrorDialog(
          context,
          title: 'Download Failed',
          message: 'Failed to download $displayName: ${e.toString()}',
        );
      }
      
      print('[DownloadService] ========================================');
      print('[DownloadService] DOWNLOAD BILL FAILED');
      print('[DownloadService] ========================================');
    }
  }

  /// Download a receipt PDF
  /// Shows confirmation dialog, progress indicator, and completion dialog
  static Future<void> downloadReceipt({
    required BuildContext context,
    required String receiptNumber,
    required String customerNumber,
    required String accountNumber,
    String? receiptDisplayName,
  }) async {
    final displayName = receiptDisplayName ?? 'Receipt #$receiptNumber';
    
    print('[DownloadService] ========================================');
    print('[DownloadService] DOWNLOAD RECEIPT INITIATED');
    print('[DownloadService] Receipt Number: $receiptNumber');
    print('[DownloadService] Customer Number: $customerNumber');
    print('[DownloadService] Account Number: $accountNumber');
    print('[DownloadService] Display Name: $displayName');
    print('[DownloadService] ========================================');
    
    // Show confirmation dialog
    print('[DownloadService] Showing confirmation dialog...');
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Download Receipt',
      message: 'Do you want to download $displayName?',
    );
    
    print('[DownloadService] User confirmed: $confirmed');
    
    if (!confirmed || !context.mounted) {
      print('[DownloadService] Download cancelled or context not mounted');
      return;
    }

    // Show progress dialog
    print('[DownloadService] Showing progress dialog...');
    _showProgressDialog(
      context,
      title: 'Downloading Receipt',
      message: 'Please wait while we prepare your download...',
    );

    try {
      print('[DownloadService] Starting to fetch download URL from API...');
      
      // Fetch download URL from API
      final downloadUrl = await _instance._fetchReceiptDownloadUrl(
        receiptNumber: receiptNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
      );

      print('[DownloadService] ✅ Download URL received: $downloadUrl');

      // Close progress dialog
      if (context.mounted) {
        print('[DownloadService] Closing progress dialog...');
        try {
          Navigator.of(context, rootNavigator: true).pop();
          print('[DownloadService] ✅ Progress dialog closed');
        } catch (e) {
          print('[DownloadService] ⚠️ Error closing progress dialog: $e');
        }
      }

      // Trigger download
      print('[DownloadService] Triggering browser download...');
      await _instance._triggerDownload(downloadUrl, '$receiptNumber.pdf');
      print('[DownloadService] ✅ Download triggered successfully');

      // Show success dialog
      if (context.mounted) {
        print('[DownloadService] Showing success dialog...');
        await _showSuccessDialog(
          context,
          title: 'Download Complete',
          message: '$displayName has been downloaded successfully.',
        );
      }
      
      print('[DownloadService] ========================================');
      print('[DownloadService] DOWNLOAD RECEIPT COMPLETED SUCCESSFULLY');
      print('[DownloadService] ========================================');
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ ERROR OCCURRED:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
      
      // Close progress dialog if still open
      if (context.mounted) {
        print('[DownloadService] Closing progress dialog due to error...');
        try {
          Navigator.of(context, rootNavigator: true).pop();
          print('[DownloadService] ✅ Progress dialog closed');
        } catch (e) {
          print('[DownloadService] ⚠️ Error closing progress dialog: $e');
        }
      }

      // Show error dialog
      if (context.mounted) {
        print('[DownloadService] Showing error dialog...');
        await _showErrorDialog(
          context,
          title: 'Download Failed',
          message: 'Failed to download $displayName: ${e.toString()}',
        );
      }
      
      print('[DownloadService] ========================================');
      print('[DownloadService] DOWNLOAD RECEIPT FAILED');
      print('[DownloadService] ========================================');
    }
  }

  /// Fetch bill download URL from API
  Future<String> _fetchBillDownloadUrl({
    required String billNumber,
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      if (EnvConfig.useMockApi) {
        print('[DownloadService] Using MOCK API');
        print('[DownloadService] Simulating API delay (1 second)...');
        // Simulate API delay
        await Future.delayed(const Duration(seconds: 1));
        // Return mock URL
        final mockUrl = 'https://m.bel.com.bz/BELBillMobileAppTesting/${customerNumber}_${accountNumber}_${billNumber}.pdf';
        print('[DownloadService] Mock URL generated: $mockUrl');
        return mockUrl;
      }

      final endpoint = ApiEndpoints.billDownloadUrl(billNumber, customerNumber, accountNumber);
      final baseUrl = _httpClient.client.options.baseUrl;
      final fullUrl = '$baseUrl$endpoint';
      
      print('[DownloadService] ========================================');
      print('[DownloadService] API REQUEST - BILL DOWNLOAD URL');
      print('[DownloadService] Base URL: $baseUrl');
      print('[DownloadService] Endpoint: $endpoint');
      print('[DownloadService] Full URL: $fullUrl');
      print('[DownloadService] Method: GET');
      print('[DownloadService] ========================================');
      
      Logger.info('Fetching bill download URL from: $endpoint', tag: 'DownloadService');
      
      print('[DownloadService] Sending HTTP GET request...');
      final stopwatch = Stopwatch()..start();
      
      final response = await _httpClient.client.get<Map<String, dynamic>>(
        endpoint,
      );
      
      stopwatch.stop();
      print('[DownloadService] ✅ HTTP Response received (${stopwatch.elapsedMilliseconds}ms)');
      print('[DownloadService] Response Status Code: ${response.statusCode}');
      print('[DownloadService] Response Headers: ${response.headers}');
      print('[DownloadService] Response Data: ${response.data}');

      Logger.info('Bill download URL response: ${response.statusCode}', tag: 'DownloadService');

      if (response.statusCode == 200 && response.data != null) {
        print('[DownloadService] Parsing response DTO...');
        final responseDto = BillDownloadUrlResponseDto.fromJson(response.data!);
        print('[DownloadService] DTO Status: ${responseDto.status}');
        print('[DownloadService] DTO Message: ${responseDto.message}');
        
        Logger.info('Bill download URL DTO status: ${responseDto.status}, message: ${responseDto.message}', tag: 'DownloadService');
        
        if (responseDto.status == 200 && responseDto.message != null && responseDto.message!.isNotEmpty) {
          final downloadUrl = responseDto.message!;
          print('[DownloadService] ✅ Download URL extracted: $downloadUrl');
          Logger.info('Bill download URL retrieved: $downloadUrl', tag: 'DownloadService');
          return downloadUrl;
        } else {
          print('[DownloadService] ❌ Invalid DTO response:');
          print('[DownloadService]   - Status: ${responseDto.status}');
          print('[DownloadService]   - Message: ${responseDto.message}');
          throw Exception(responseDto.message ?? 'Failed to get download URL');
        }
      } else {
        print('[DownloadService] ❌ Invalid HTTP response:');
        print('[DownloadService]   - Status Code: ${response.statusCode}');
        print('[DownloadService]   - Data: ${response.data}');
        throw Exception('Failed to fetch download URL: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ EXCEPTION IN _fetchBillDownloadUrl:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
      
      Logger.error('Error fetching bill download URL: $e', tag: 'DownloadService');
      rethrow;
    }
  }

  /// Fetch receipt download URL from API
  Future<String> _fetchReceiptDownloadUrl({
    required String receiptNumber,
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      if (EnvConfig.useMockApi) {
        print('[DownloadService] Using MOCK API');
        print('[DownloadService] Simulating API delay (1 second)...');
        // Simulate API delay
        await Future.delayed(const Duration(seconds: 1));
        // Return mock URL
        final mockUrl = 'https://m.bel.com.bz/BELReceiptMobileAppTesting/${customerNumber}_${accountNumber}_$receiptNumber.pdf';
        print('[DownloadService] Mock URL generated: $mockUrl');
        return mockUrl;
      }

      final endpoint = ApiEndpoints.receiptDownloadUrl(receiptNumber, customerNumber, accountNumber);
      final baseUrl = _httpClient.client.options.baseUrl;
      final fullUrl = '$baseUrl$endpoint';
      
      print('[DownloadService] ========================================');
      print('[DownloadService] API REQUEST - RECEIPT DOWNLOAD URL');
      print('[DownloadService] Base URL: $baseUrl');
      print('[DownloadService] Endpoint: $endpoint');
      print('[DownloadService] Full URL: $fullUrl');
      print('[DownloadService] Method: GET');
      print('[DownloadService] ========================================');
      
      Logger.info('Fetching receipt download URL from: $endpoint', tag: 'DownloadService');
      
      print('[DownloadService] Sending HTTP GET request...');
      final stopwatch = Stopwatch()..start();
      
      final response = await _httpClient.client.get<Map<String, dynamic>>(
        endpoint,
      );
      
      stopwatch.stop();
      print('[DownloadService] ✅ HTTP Response received (${stopwatch.elapsedMilliseconds}ms)');
      print('[DownloadService] Response Status Code: ${response.statusCode}');
      print('[DownloadService] Response Headers: ${response.headers}');
      print('[DownloadService] Response Data: ${response.data}');

      Logger.info('Receipt download URL response: ${response.statusCode}', tag: 'DownloadService');

      if (response.statusCode == 200 && response.data != null) {
        print('[DownloadService] Parsing response DTO...');
        final responseDto = ReceiptDownloadUrlResponseDto.fromJson(response.data!);
        print('[DownloadService] DTO Status: ${responseDto.status}');
        print('[DownloadService] DTO Message: ${responseDto.message}');
        
        Logger.info('Receipt download URL DTO status: ${responseDto.status}, message: ${responseDto.message}', tag: 'DownloadService');
        
        if (responseDto.status == 200 && responseDto.message != null && responseDto.message!.isNotEmpty) {
          final downloadUrl = responseDto.message!;
          print('[DownloadService] ✅ Download URL extracted: $downloadUrl');
          Logger.info('Receipt download URL retrieved: $downloadUrl', tag: 'DownloadService');
          return downloadUrl;
        } else {
          print('[DownloadService] ❌ Invalid DTO response:');
          print('[DownloadService]   - Status: ${responseDto.status}');
          print('[DownloadService]   - Message: ${responseDto.message}');
          throw Exception(responseDto.message ?? 'Failed to get download URL');
        }
      } else {
        print('[DownloadService] ❌ Invalid HTTP response:');
        print('[DownloadService]   - Status Code: ${response.statusCode}');
        print('[DownloadService]   - Data: ${response.data}');
        throw Exception('Failed to fetch download URL: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ EXCEPTION IN _fetchReceiptDownloadUrl:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
      
      Logger.error('Error fetching receipt download URL: $e', tag: 'DownloadService');
      rethrow;
    }
  }

  /// Trigger browser download (Flutter Web)
  Future<void> _triggerDownload(String url, String filename) async {
    if (kIsWeb) {
      try {
        print('[DownloadService] ========================================');
        print('[DownloadService] TRIGGERING BROWSER DOWNLOAD');
        print('[DownloadService] URL: $url');
        print('[DownloadService] Filename: $filename');
        print('[DownloadService] ========================================');
        
        Logger.info('Triggering download: $url', tag: 'DownloadService');
        
        // For Flutter Web, use html.AnchorElement to trigger download
        // Create anchor element
        print('[DownloadService] Creating anchor element...');
        final anchor = html.AnchorElement(href: url)
          ..target = '_blank'
          ..download = filename
          ..style.display = 'none';
        
        print('[DownloadService] Anchor element created:');
        print('[DownloadService]   - href: ${anchor.href}');
        print('[DownloadService]   - target: ${anchor.target}');
        print('[DownloadService]   - download: ${anchor.download}');
        
        // Add to DOM
        print('[DownloadService] Adding anchor to DOM...');
        html.document.body?.append(anchor);
        print('[DownloadService] ✅ Anchor added to DOM');
        
        // Trigger click
        print('[DownloadService] Clicking anchor to trigger download...');
        anchor.click();
        print('[DownloadService] ✅ Anchor clicked');
        
        Logger.info('Download triggered for: $filename', tag: 'DownloadService');
        
        // Remove from DOM after a short delay
        print('[DownloadService] Waiting 200ms before removing anchor...');
        await Future.delayed(const Duration(milliseconds: 200));
        anchor.remove();
        print('[DownloadService] ✅ Anchor removed from DOM');
        
        print('[DownloadService] ========================================');
        print('[DownloadService] DOWNLOAD TRIGGER COMPLETED');
        print('[DownloadService] ========================================');
      } catch (e, stackTrace) {
        print('[DownloadService] ❌ EXCEPTION IN _triggerDownload:');
        print('[DownloadService] Error type: ${e.runtimeType}');
        print('[DownloadService] Error message: $e');
        print('[DownloadService] Stack trace: $stackTrace');
        
        Logger.error('Error triggering download: $e', tag: 'DownloadService');
        rethrow;
      }
    } else {
      // For non-web platforms, you might want to use url_launcher or other methods
      print('[DownloadService] ❌ Not a web platform - download not supported');
      throw UnsupportedError('Download is only supported on web platform');
    }
  }


  /// Show confirmation dialog
  static Future<bool> _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    bool? confirmed = false;
    
    print('[DownloadService] Showing confirmation dialog with title: $title');
    
    try {
      await AppDialog.showCenter(
        context: context,
        title: title,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              print('[DownloadService] User clicked Cancel');
              confirmed = false;
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              print('[DownloadService] User clicked Download');
              confirmed = true;
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: const Text('Download'),
          ),
        ],
      );
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ Error showing confirmation dialog:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
      rethrow;
    }

    print('[DownloadService] Confirmation dialog result: $confirmed');
    return confirmed ?? false;
  }

  /// Show progress dialog
  static void _showProgressDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    print('[DownloadService] Showing progress dialog: $title');
    try {
      AppDialog.showCenter(
        context: context,
        title: title,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppTheme.spacing16),
            Text(message),
          ],
        ),
        actions: [], // No actions during progress
        showCloseButton: false, // Prevent closing during download
        barrierDismissible: false,
      );
    } catch (e, stackTrace) {
      print('[DownloadService] ❌ Error showing progress dialog:');
      print('[DownloadService] Error type: ${e.runtimeType}');
      print('[DownloadService] Error message: $e');
      print('[DownloadService] Stack trace: $stackTrace');
    }
  }

  /// Show success dialog
  static Future<void> _showSuccessDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    await AppDialog.showCenter(
      context: context,
      title: title,
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(child: Text(message)),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  /// Show error dialog
  static Future<void> _showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    await AppDialog.showCenter(
      context: context,
      title: title,
      content: Row(
        children: [
          const Icon(Icons.error, color: AppColors.error),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(child: Text(message)),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
