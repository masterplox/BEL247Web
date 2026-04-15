import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/account.dart';
import '../models/api_response_dtos.dart';
import '../services/api_client.dart';
import '../services/token_storage_service.dart';

class AccountsRepository {
  AccountsRepository([ApiClient? apiClient]) : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  /// Fetch connected accounts from the API
  /// GET /CustomerAccounts/V4/PreferredCustomerAccounts
  /// Automatically authenticated (uses Bearer token)
  Future<List<Account>> fetchConnectedAccounts() async {
    try {
      // Just pass the endpoint path - base URL and auth are handled automatically
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.connectedAccounts,
        authenticated: true, // This request requires authentication
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = ConnectedAccountsResponseDto.fromJson(response.data!);
        
        // Map DTOs to Account models
        final accounts = responseDto.editableCustomerAccounts
            .map(_mapDtoToAccount)
            .where((account) => account.isActive) // Only include active accounts
            .toList();

        Logger.info('Mapped ${accounts.length} active accounts', tag: 'AccountsRepository');
        return accounts;
      } else {
        Logger.warning(
          'Failed to fetch connected accounts. accounts_repository Status: ${response.statusCode}',
          tag: 'AccountsRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching connected accounts',
        error: e,
        stackTrace: stackTrace,
        tag: 'AccountsRepository',
      );
      rethrow;
    }
  }

  /// Map EditableCustomerAccountDto to Account model
  Account _mapDtoToAccount(EditableCustomerAccountDto dto) {
    // Generate unique ID from customer and account number (use empty strings if null)
    final customerNumber = dto.customerNumber ?? '';
    final accountNumber = dto.accountNumber ?? '';
    final id = '${customerNumber}_$accountNumber';

    // Parse balance - handle formats like "0.00", "$ (40.00) CR", "44,796.93"
    final balance = _parseBalance(dto.balance ?? '0.00');

    // Map billCode to accountType (default to residential if null)
    final accountType = _mapBillCodeToAccountType(dto.billCode ?? 'residential');

    // Build address from components (handle nulls)
    final address = _buildAddress(
      dto.apartmentNumber ?? '',
      dto.street ?? '',
      dto.city ?? '',
      dto.district ?? '',
    );

    // Map paid status to AccountStatus
    final status = _mapPaidStatusToAccountStatus(dto.paid, dto.dueIn ?? '0');

    // Parse dates (handle nulls)
    final lastPaymentDate = _parseDate(dto.lastPaymentDate ?? '');
    final nextDueDate = _parseDate(dto.dueDate ?? '');

    return Account(
      id: id,
      accountNumber: accountNumber,
      customerNumber: customerNumber,
      accountType: accountType,
      address: address,
      balance: balance,
      status: status,
      lastPaymentDate: lastPaymentDate,
      nextDueDate: nextDueDate,
      isActive: dto.active,
      meterNumber: dto.meter ?? '',
      serviceArea: (dto.district?.isNotEmpty ?? false) ? dto.district : null,
      nickname: dto.nickName, // Map nickname from DTO
    );
  }

  /// Request a full access activation code for the given account.
  ///
  /// This calls POST /CustomerAccounts/V5/FullAccess/ActivationCode and returns
  /// a simple status/message response. For activation code requests, the
  /// activation code itself is returned in the `message` field.
  Future<BaseApiResponseDto> requestFullAccessActivationCode({
    required String customerNumber,
    required String accountNumber,
    String? mobileNumber,
    String? email,
  }) async {
    try {
      final body = <String, dynamic>{
        'CustomerNumber': customerNumber,
        'AccountNumber': accountNumber,
      };
      if (mobileNumber != null && mobileNumber.isNotEmpty) {
        body['MobileNumber'] = mobileNumber;
      }
      if (email != null && email.isNotEmpty) {
        body['Email'] = email;
      }

      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.fullAccessActivationCode,
        data: body,
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        return BaseApiResponseDto.fromJson(response.data!);
      }

      Logger.warning(
        'Full access activationCode request failed. Status: ${response.statusCode}',
        tag: 'AccountsRepository',
      );
      return BaseApiResponseDto(
        status: response.statusCode ?? 500,
        message: 'Failed to send activation code.',
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error requesting full access activation code',
        error: e,
        stackTrace: stackTrace,
        tag: 'AccountsRepository',
      );
      return const BaseApiResponseDto(
        status: 500,
        message: 'Unexpected error while sending activation code.',
      );
    }
  }

  /// Activate full account access using a verification code.
  ///
  /// This calls POST /CustomerAccounts/V5/FullAccess/Activate and returns
  /// a simple status/message response. For activation, the human-readable
  /// result is provided in the `message` field.
  Future<BaseApiResponseDto> activateFullAccess({
    required String customerNumber,
    required String accountNumber,
    required String code,
    String? mobileNumber,
    String? email,
  }) async {
    try {
      final session = await TokenStorageService.getUserSession();
      final userId = session?.userId ?? '';

      final body = <String, dynamic>{
        'UserId': userId,
        'Code': code,
        'CustomerNumber': customerNumber,
        'AccountNumber': accountNumber,
      };
      if (mobileNumber != null && mobileNumber.isNotEmpty) {
        body['MobileNumber'] = mobileNumber;
      }
      if (email != null && email.isNotEmpty) {
        body['Email'] = email;
      }

      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.fullAccessActivate,
        data: body,
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        return BaseApiResponseDto.fromJson(response.data!);
      }

      Logger.warning(
        'Full access activate request failed. Status: ${response.statusCode}',
        tag: 'AccountsRepository',
      );
      return BaseApiResponseDto(
        status: response.statusCode ?? 500,
        message: 'Failed to verify activation code.',
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error activating full access',
        error: e,
        stackTrace: stackTrace,
        tag: 'AccountsRepository',
      );
      return const BaseApiResponseDto(
        status: 500,
        message: 'Unexpected error while verifying activation code.',
      );
    }
  }

  /// Parse balance string to double
  /// Handles formats: "0.00", "$ (40.00) CR", "44,796.93", "-100.50"
  /// Credits (CR) are converted to negative values for accounting accuracy
  /// Returns 0.0 if balanceStr is null or empty
  double _parseBalance(String? balanceStr) {
    if (balanceStr == null || balanceStr.isEmpty) {
      return 0;
    }
    try {
      // Check if it's a credit (has "CR" or parentheses with positive number)
      final isCredit = balanceStr.toUpperCase().contains('CR') || 
                       (balanceStr.contains('(') && balanceStr.contains(')'));
      
      // Remove currency symbols, parentheses, "CR", commas, and whitespace
      final cleaned = balanceStr
          .replaceAll(r'$', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('CR', '')
          .replaceAll(',', '')
          .trim();

      // Parse to double
      var balance = double.tryParse(cleaned) ?? 0.0;
      
      // If it's a credit, make it negative (credits reduce debt)
      if (isCredit && balance > 0) {
        balance = -balance;
      }
      
      return balance;
    } catch (e) {
      Logger.warning('Failed to parse balance: $balanceStr', tag: 'AccountsRepository');
      return 0;
    }
  }

  /// Map billCode to accountType
  /// Returns 'residential' if billCode is null or empty
  String _mapBillCodeToAccountType(String? billCode) {
    if (billCode == null || billCode.isEmpty) {
      return 'residential';
    }
    switch (billCode.toLowerCase()) {
      case 'commercial':
      case 'business':
        return 'commercial';
      case 'industrial':
        return 'commercial'; // Treat industrial as commercial
      case 'residential':
      default:
        return 'residential';
    }
  }

  /// Build address string from components
  String _buildAddress(String apartmentNumber, String street, String city, String district) {
    final parts = <String>[];
    
    if (apartmentNumber.isNotEmpty && apartmentNumber.trim() != '') {
      parts.add(apartmentNumber.trim());
    }
    if (street.isNotEmpty && street.trim() != '') {
      parts.add(street.trim());
    }
    if (city.isNotEmpty && city.trim() != '' && city.trim() != ' ') {
      parts.add(city.trim());
    }
    if (district.isNotEmpty && district.trim() != '' && district.trim() != ' ') {
      parts.add(district.trim());
    }
    
    return parts.isNotEmpty ? parts.join(', ') : 'Address not available';
  }

  /// Map paid status and dueIn to AccountStatus
  /// Returns AccountStatus.due if dueInStr is null or empty
  AccountStatus _mapPaidStatusToAccountStatus(bool paid, String? dueInStr) {
    if (dueInStr == null || dueInStr.isEmpty) {
      return paid ? AccountStatus.paid : AccountStatus.due;
    }
    if (paid) {
      return AccountStatus.paid;
    }
    
    // Parse dueIn to determine if overdue
    final dueIn = int.tryParse(dueInStr.replaceAll(RegExp(r'[^\d-]'), '')) ?? 0;
    if (dueIn < 0) {
      return AccountStatus.overdue;
    }
    
    return AccountStatus.due;
  }

  /// Parse date string to DateTime
  /// Handles formats like "Thursday 18 Dec 2025", "Sunday 28 Dec 2025"
  /// Returns null if dateStr is null or empty
  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    
    try {
      // Try common date formats
      final formats = [
        'EEEE d MMM yyyy', // "Thursday 18 Dec 2025"
        'd MMM yyyy',      // "18 Dec 2025"
        'yyyy-MM-dd',      // "2025-12-18"
        'MM/dd/yyyy',      // "12/18/2025"
      ];

      for (final format in formats) {
        try {
          final formatter = DateFormat(format);
          return formatter.parse(dateStr);
        } catch (_) {
          continue;
        }
      }
      
      // Fallback: try parsing as ISO string
      return DateTime.tryParse(dateStr);
    } catch (e) {
      Logger.warning('Failed to parse date: $dateStr', tag: 'AccountsRepository');
      return null;
    }
  }

  /// Fetch full account details DTO for a specific account
  /// Returns the EditableCustomerAccountDto for the account matching the given account ID
  Future<EditableCustomerAccountDto?> fetchAccountDetails(String accountId) async {
    try {
      // Fetch all accounts and find the matching one
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.connectedAccounts,
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = ConnectedAccountsResponseDto.fromJson(response.data!);
        
        // Find the account matching the ID (format: customerNumber_accountNumber)
        final parts = accountId.split('_');
        if (parts.length != 2) return null;
        
        final customerNumber = parts[0];
        final accountNumber = parts[1];
        
        final matchingDto = responseDto.editableCustomerAccounts.firstWhere(
          (dto) => 
            (dto.customerNumber ?? '') == customerNumber &&
            (dto.accountNumber ?? '') == accountNumber,
          orElse: () => throw StateError('Account not found'),
        );

        // Frontend-only override for dev/testing:
        // mimic the API returning these flags as `true`.
        // (Keeping this gated to development so we don't accidentally grant access in prod.)
        // if (EnvConfig.isDevelopment) {
        //   return matchingDto.copyWith(
        //     fullAccess: true,
        //     billDownloadAccess: false,
        //   );
        // }

        return matchingDto;
      }
      return null;
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching account details for accountId: $accountId',
        error: e,
        stackTrace: stackTrace,
        tag: 'AccountsRepository',
      );
      return null;
    }
  }

  /// Connect a customer account
  /// POST /CustomerAccounts/V2/Connect
  /// Body: { CustomerNumber, AccountNumberHint, NickName }
  /// Automatically authenticated (uses Bearer token)
  Future<ConnectCustomerAccountResponseDto> connectAccount({
    required String customerNumber,
    required String accountNumberHint,
    required String nickName,
  }) async {
    try {
      Logger.info(
        'Connecting account: CustomerNumber=$customerNumber, AccountNumberHint=$accountNumberHint, NickName=$nickName',
        tag: 'AccountsRepository',
      );

      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.connectCustomerAccount,
        data: {
          'CustomerNumber': customerNumber,
          'AccountNumberHint': accountNumberHint,
          'NickName': nickName,
        },
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = ConnectCustomerAccountResponseDto.fromJson(response.data!);
        
        Logger.info(
          'Successfully connected account: ${responseDto.message ?? "No message"}',
          tag: 'AccountsRepository',
        );
        
        return responseDto;
      } else {
        Logger.warning(
          'Failed to connect account. Status: ${response.statusCode}',
          tag: 'AccountsRepository',
        );
        throw Exception('Failed to connect account. Status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error connecting account',
        error: e,
        stackTrace: stackTrace,
        tag: 'AccountsRepository',
      );
      rethrow;
    }
  }

  /// Legacy method for backward compatibility
  /// @deprecated Use fetchConnectedAccounts instead
  Future<List<Account>> fetchUserAccounts(String userId) async {
    Logger.info(
      'fetchUserAccounts is deprecated. Using fetchConnectedAccounts instead.',
      tag: 'AccountsRepository',
    );
    return fetchConnectedAccounts();
  }
}

// Provider for AccountsRepository
final accountsRepositoryProvider = Provider<AccountsRepository>((ref) {
  // Use the default ApiClient instance (singleton)
  return AccountsRepository();
});


