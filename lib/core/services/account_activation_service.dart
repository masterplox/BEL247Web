import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/api_response_dtos.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../features/bills/state/bills_providers.dart';
import '../../features/bills/state/bills_repository.dart';
import '../utils/logger.dart';

/// Why the user is requesting an activation code.
enum AccountActivationPurpose {
  /// Dashboard / receipts: Premium (full account access).
  fullAccess,

  /// Transaction History bill PDF: bill download access.
  billDownload,
}

/// Shared send/verify for Premium and bill download.
///
/// Premium uses POST /CustomerAccounts/V5/FullAccess/ActivationCode.
/// Bill download send uses POST /Bills/V5/BillDownloadActivationCode?billNumber=.
/// Bill download verify uses POST /Bills/V5/BillDownloadAuthenticateCode
/// with headers Username + Token and body { code, billNumber }.
class AccountActivationService {
  AccountActivationService({
    required AccountsRepository accountsRepository,
    required BillsRepository billsRepository,
  })  : _accountsRepository = accountsRepository,
        _billsRepository = billsRepository;

  final AccountsRepository _accountsRepository;
  final BillsRepository _billsRepository;

  Future<BaseApiResponseDto> requestCode({
    required AccountActivationPurpose purpose,
    required String customerNumber,
    required String accountNumber,
    String? mobileNumber,
    String? email,
    String? billNumber,
  }) async {
    try {
      if (purpose == AccountActivationPurpose.billDownload) {
        final number = billNumber?.trim() ?? '';
        if (number.isEmpty) {
          return const BaseApiResponseDto(
            status: 400,
            message: 'Bill number is required to send an activation code.',
          );
        }
        Logger.info(
          'Sending bill-download activation code (billNumber=$number)',
          tag: 'AccountActivationService',
        );
        return _billsRepository.requestBillDownloadActivationCode(
          billNumber: number,
        );
      }

      Logger.info(
        'Sending FullAccess activation code',
        tag: 'AccountActivationService',
      );
      return _accountsRepository.requestFullAccessActivationCode(
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        mobileNumber: mobileNumber,
        email: email,
      );
    } catch (e) {
      return BaseApiResponseDto(
        status: 500,
        message: _messageFromError(
          e,
          'Unexpected error while sending activation code.',
        ),
      );
    }
  }

  Future<BaseApiResponseDto> verifyCode({
    required AccountActivationPurpose purpose,
    required String customerNumber,
    required String accountNumber,
    required String code,
    String? mobileNumber,
    String? email,
    String? billNumber,
  }) async {
    try {
      if (purpose == AccountActivationPurpose.billDownload) {
        final number = billNumber?.trim() ?? '';
        if (number.isEmpty) {
          return const BaseApiResponseDto(
            status: 400,
            message: 'Bill number is required to verify the activation code.',
          );
        }
        Logger.info(
          'Verifying bill-download activation code (billNumber=$number)',
          tag: 'AccountActivationService',
        );
        return _billsRepository.validateBillDownloadActivationCode(
          billNumber: number,
          code: code,
        );
      }

      Logger.info(
        'Verifying FullAccess activation code',
        tag: 'AccountActivationService',
      );
      return _accountsRepository.activateFullAccess(
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        code: code,
        mobileNumber: mobileNumber,
        email: email,
      );
    } catch (e) {
      return BaseApiResponseDto(
        status: 500,
        message: _messageFromError(
          e,
          'Unexpected error while verifying activation code.',
        ),
      );
    }
  }

  static String _messageFromError(Object error, String fallback) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map) {
        final message = data['message'] ?? data['Message'];
        if (message != null && message.toString().trim().isNotEmpty) {
          return message.toString();
        }
      }
      final status = error.response?.statusCode;
      if (status != null) {
        return 'Activation request failed (HTTP $status).';
      }
      if (error.message != null && error.message!.trim().isNotEmpty) {
        return error.message!;
      }
    }
    return fallback;
  }
}

final accountActivationServiceProvider = Provider<AccountActivationService>(
  (ref) => AccountActivationService(
    accountsRepository: ref.watch(accountsRepositoryProvider),
    billsRepository: ref.watch(billsRepositoryProvider),
  ),
);
