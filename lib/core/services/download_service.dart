import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../data/models/api_response_dtos.dart';
import '../../data/services/http_client.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../config/env.dart';
import '../constants/api_endpoints.dart';
import '../utils/logger.dart';
import '../widgets/app_dialog.dart';
import 'download_trigger_stub.dart'
    if (dart.library.html) 'download_trigger_web.dart';

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
    
    
    // Show confirmation dialog
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Download Bill',
      message: 'Do you want to download $displayName?',
    );
    
    
    if (!confirmed || !context.mounted) {
      return;
    }

    // Show progress dialog
    _showProgressDialog(
      context,
      title: 'Downloading Bill',
      message: 'Please wait while we prepare your download...',
    );

    try {
      
      // Fetch download URL from API
      final downloadUrl = await _instance._fetchBillDownloadUrl(
        billNumber: billNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
      );


      // Close progress dialog
      if (context.mounted) {
        try {
          Navigator.of(context, rootNavigator: true).pop();
        } catch (e) {
        }
      }

      // Trigger download
      await _instance._triggerDownload(downloadUrl, '$billNumber.pdf');

      // Show success dialog
      if (context.mounted) {
        await _showSuccessDialog(
          context,
          title: 'Download Complete',
          message: '$displayName has been downloaded successfully.',
        );
      }
      
    } catch (e, stackTrace) {
      
      // Close progress dialog if still open
      if (context.mounted) {
        try {
          Navigator.of(context, rootNavigator: true).pop();
        } catch (e) {
        }
      }

      // Show error dialog
      if (context.mounted) {
        await _showErrorDialog(
          context,
          title: 'Download Failed',
          message: 'Unable to download $displayName. Please try again.',
        );
      }

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
    
    
    // Show confirmation dialog
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Download Receipt',
      message: 'Do you want to download $displayName?',
    );
    
    
    if (!confirmed || !context.mounted) {
      return;
    }

    // Show progress dialog
    _showProgressDialog(
      context,
      title: 'Downloading Receipt',
      message: 'Please wait while we prepare your download...',
    );

    try {
      
      // Fetch download URL from API
      final downloadUrl = await _instance._fetchReceiptDownloadUrl(
        receiptNumber: receiptNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
      );


      // Close progress dialog
      if (context.mounted) {
        try {
          Navigator.of(context, rootNavigator: true).pop();
        } catch (e) {
        }
      }

      // Trigger download
      await _instance._triggerDownload(downloadUrl, '$receiptNumber.pdf');

      // Show success dialog
      if (context.mounted) {
        await _showSuccessDialog(
          context,
          title: 'Download Complete',
          message: '$displayName has been downloaded successfully.',
        );
      }
      
    } catch (e, stackTrace) {
      
      // Close progress dialog if still open
      if (context.mounted) {  
        try {
          Navigator.of(context, rootNavigator: true).pop();
        } catch (e) {
        }
      }

      // Show error dialog
      if (context.mounted) {
        await _showErrorDialog(
          context,
          title: 'Download Failed',
          message: 'Unable to download $displayName. Please try again.',
        );
      }

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
        // Simulate API delay
        await Future.delayed(const Duration(seconds: 1));
        // Return mock URL
        final mockUrl = 'https://m.bel.com.bz/BELBillMobileAppTesting/${customerNumber}_${accountNumber}_$billNumber.pdf';
        return mockUrl;
      }

      final endpoint = ApiEndpoints.billDownloadUrl(billNumber, customerNumber, accountNumber);
      final baseUrl = _httpClient.client.options.baseUrl;
      final fullUrl = '$baseUrl$endpoint';
      
      Logger.info('Fetching bill download URL from: $endpoint', tag: 'DownloadService');
      
      final stopwatch = Stopwatch()..start();
      
      final response = await _httpClient.client.get<Map<String, dynamic>>(
        endpoint,
      );
      
      stopwatch.stop();

      Logger.info('Bill download URL response: ${response.statusCode}', tag: 'DownloadService');

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = BillDownloadUrlResponseDto.fromJson(response.data!);
        
        Logger.info('Bill download URL DTO status: ${responseDto.status}, message: ${responseDto.message}', tag: 'DownloadService');
        
        if (responseDto.status == 200 && responseDto.message != null && responseDto.message!.isNotEmpty) {
          final downloadUrl = responseDto.message!;
          Logger.info('Bill download URL retrieved: $downloadUrl', tag: 'DownloadService');
          return downloadUrl;
        } else {
          throw Exception(responseDto.message ?? 'Failed to get download URL');
        }
      } else {
        throw Exception('Failed to fetch download URL: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      
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
        // Simulate API delay
        await Future.delayed(const Duration(seconds: 1));
        // Return mock URL
        final mockUrl = 'https://m.bel.com.bz/BELReceiptMobileAppTesting/${customerNumber}_${accountNumber}_$receiptNumber.pdf';
        return mockUrl;
      }

      final endpoint = ApiEndpoints.receiptDownloadUrl(receiptNumber, customerNumber, accountNumber);
      final baseUrl = _httpClient.client.options.baseUrl;
      final fullUrl = '$baseUrl$endpoint';

      Logger.info('Fetching receipt download URL from: $endpoint', tag: 'DownloadService');
      
      final stopwatch = Stopwatch()..start();
      
      final response = await _httpClient.client.get<Map<String, dynamic>>(
        endpoint,
      );
      
      stopwatch.stop();

      Logger.info('Receipt download URL response: ${response.statusCode}', tag: 'DownloadService');

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = ReceiptDownloadUrlResponseDto.fromJson(response.data!);
        
        Logger.info('Receipt download URL DTO status: ${responseDto.status}, message: ${responseDto.message}', tag: 'DownloadService');
        
        if (responseDto.status == 200 && responseDto.message != null && responseDto.message!.isNotEmpty) {
          final downloadUrl = responseDto.message!;
          Logger.info('Receipt download URL retrieved: $downloadUrl', tag: 'DownloadService');
          return downloadUrl;
        } else {
          throw Exception(responseDto.message ?? 'Failed to get download URL');
        }
      } else {
        throw Exception('Failed to fetch download URL: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      
      Logger.error('Error fetching receipt download URL: $e', tag: 'DownloadService');
      rethrow;
    }
  }

  /// Trigger browser download (Flutter Web)
  Future<void> _triggerDownload(String url, String filename) async {
    if (kIsWeb) {
      try {
        Logger.info('Triggering download: $url', tag: 'DownloadService');
        triggerWebDownload(url, filename);
        Logger.info('Download triggered for: $filename', tag: 'DownloadService');
      } catch (e, stackTrace) {
        Logger.error(
          'Error triggering download: $e',
          error: e,
          stackTrace: stackTrace,
          tag: 'DownloadService',
        );
        rethrow;
      }
    } else {
      // For non-web platforms, you might want to use url_launcher or other methods
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
    
    
    try {
      await AppDialog.showCenter(
        context: context,
        title: title,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              confirmed = false;
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
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
      rethrow;
    }

    return confirmed ?? false;
  }

  /// Show progress dialog
  static void _showProgressDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
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
        showCloseButton: false,
        barrierDismissible: true,
      );
    } catch (e, stackTrace) {
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
