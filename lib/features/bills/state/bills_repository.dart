import 'package:intl/intl.dart';

import '../../../core/config/env.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/bill.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../data/services/api_client.dart';
import '../../../data/services/http_client.dart';
import '../../../data/sources/mock/mock_app_data_service.dart';
import '../../../data/sources/mock/mock_bill_repository.dart';

class BillsRepository {
  const BillsRepository();

  static final _apiClient = ApiClient.instance;

  Future<List<Bill>> fetchBills(String accountId) async {
    print('[Bills] Repository.fetchBills start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Always use mock repository to load from JSON file
    // TODO: Add live API call when implemented
    final repo = MockBillRepository();
    final result = await repo.getBills(accountId);
    
    if (result.success && result.data != null) {
      print('[Bills] Repository.fetchBills success ${result.data!.bills.length} bills accountId=$accountId');
      return result.data!.bills;
    } else {
      print('[Bills] Repository.fetchBills [ERROR] No bills found for accountId=$accountId, returning empty list');
      print('[Bills] Repository.fetchBills error: ${result.error}');
      return [];
    }
  }

  Future<AccountBalance> fetchAccountBalance(String accountId) async {
    print('[Bills] Repository.fetchAccountBalance start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // Always use mock service for now (similar to fetchBills)
    // TODO: Add live API call when implemented
    final bal = await MockAppDataService.getAccountBalance(accountId);
    final result = bal ?? AccountBalance(
      currentBalance: 0,
      lastPaymentDate: DateTime.now(),
      lastPaymentAmount: 0,
      nextDueDate: DateTime.now(),
      paymentMethod: 'Unknown',
    );
    if (bal == null) {
      print('[Bills] Repository.fetchAccountBalance [ERROR] No balance found for accountId=$accountId, returning default');
    } else {
      print('[Bills] Repository.fetchAccountBalance success balance=\$${result.currentBalance.toStringAsFixed(2)} accountId=$accountId');
    }
    return result;
  }

  Future<List<MonthlyConsumption>> fetchYearlyConsumption(String accountId, int year) async {
    print('[Bills] Repository.fetchYearlyConsumption useMockApi=${EnvConfig.useMockApi}');
    print('[Bills] Repository.fetchYearlyConsumption start accountId=$accountId year=$year');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final repo = MockBillRepository(); // In a real app, this would be determined by EnvConfig
    final result = await repo.getYearlyConsumption(accountId, year);
    if (result.success && result.data != null) {
      print('[Bills] Repository.fetchYearlyConsumption success count=${result.data!.length} accountId=$accountId');
      return result.data!;
    } else {
      print('[Bills] Repository.fetchYearlyConsumption [ERROR] No data found for accountId=$accountId, returning empty list');
      return [];
    }
  }

  Future<UsageSummary> fetchUsageSummary(String accountId) async {
    print('[Bills] Repository.fetchUsageSummary start accountId=$accountId');
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // Always use mock service for now (similar to fetchBills)
    // TODO: Add live API call when implemented
    final usage = await MockAppDataService.getUsageSummary(accountId);
    final result = usage ?? const UsageSummary(
      currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
      yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
    );
    if (usage == null) {
      print('[Bills] Repository.fetchUsageSummary [ERROR] No usage summary found for accountId=$accountId, returning default');
    } else {
      print('[Bills] Repository.fetchUsageSummary success currentMonth=${usage.currentMonth.kwh.toStringAsFixed(2)}kwh cost=\$${usage.currentMonth.cost.toStringAsFixed(2)} accountId=$accountId');
    }
    return result;
  }

  Future<bool> processPayment({
    required double amount,
    required String paymentMethod,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String cardholderName,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing
    
    // Simulate success/failure (90% success rate)
    return DateTime.now().millisecond % 10 < 9;
  }

  Future<bool> downloadBill(String billId) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate download
    
    // Simulate success/failure (95% success rate)
    return DateTime.now().millisecond % 20 < 19;
  }

  /// Fetch transaction history from API
  /// GET /Payments/V2/Payments?customerNumber={customerNumber}&accountNumber={accountNumber}
  Future<List<PaymentHistory>> fetchTransactionHistory({
    required String customerNumber,
    required String accountNumber,
  }) async {
    try {
      print('[Bills] Repository.fetchTransactionHistory start customerNumber=$customerNumber accountNumber=$accountNumber');
      Logger.info('Fetching transaction history...', tag: 'BillsRepository');

      if (EnvConfig.useMockApi) {
        // Use mock data for now
        await Future.delayed(const Duration(milliseconds: 300));
        print('[Bills] Repository.fetchTransactionHistory using mock data');
        return [];
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.transactionHistory,
        authenticated: true, // Transaction history requires authentication
        queryParameters: {
          'customerNumber': customerNumber,
          'accountNumber': accountNumber,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = TransactionHistoryResponseDto.fromJson(response.data!);
        
        print('[Bills] ✅ Successfully fetched ${responseDto.paymentTransactions.length} transactions');
        Logger.info(
          'Successfully fetched ${responseDto.paymentTransactions.length} transactions',
          tag: 'BillsRepository',
        );

        // Map DTOs to PaymentHistory models
        final transactions = responseDto.paymentTransactions
            .map(_mapTransactionDtoToPaymentHistory)
            .toList();

        print('[Bills] ✅ Mapped ${transactions.length} payment history records');
        return transactions;
      } else {
        Logger.warning(
          'Failed to fetch transaction history. Status: ${response.statusCode}',
          tag: 'BillsRepository',
        );
        return [];
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching transaction history',
        error: e,
        stackTrace: stackTrace,
        tag: 'BillsRepository',
      );
      return [];
    }
  }

  /// Map PaymentTransactionDto to PaymentHistory model
  /// Note: Transaction amounts from API are negative for payments, positive for bill charges
  /// We preserve the original amount sign and use description to determine payment vs bill
  PaymentHistory _mapTransactionDtoToPaymentHistory(PaymentTransactionDto dto) {
    // Parse transaction date - handle formats like "Jan 08, 2026"
    final transactionDate = _parseTransactionDate(dto.transactionDate);
    
    // Parse transaction amount - API sends negative amounts for payments, positive for bills
    // Keep the sign - negative = payment, positive = bill
    final amount = _parseTransactionAmount(dto.transactionAmount);
    
    // Parse account balance from DTO
    final accountBalance = _parseTransactionAmount(dto.accountBalance);
    
    // Determine if it's a payment based on description (more reliable than just amount sign)
    final description = dto.transactionDescription.toLowerCase();
    final isPayment = description.contains('payment') && amount < 0;
    
    // Extract payment method from description (e.g., "Payment - Cash (B)" or "Cycle Billing Due: ...")
    final paymentMethod = isPayment 
        ? _extractPaymentMethod(dto.transactionDescription)
        : 'Bill';
    
    // referenceNumber: for bills use billNumber (so bill detail/download API gets correct id); for payments use receiptNumber
    final referenceNumber = isPayment
        ? (dto.receiptNumber.isNotEmpty ? dto.receiptNumber : null)
        : (dto.billNumber.isNotEmpty ? dto.billNumber : null);
    
    // Store absolute value since PaymentHistory.amount expects positive
    // The widget will use the description to determine if it's a payment (negative display) or bill (positive)
    // Store original transactionAmount and accountBalance in metadata for use in ledger display
    return PaymentHistory(
      id: dto.receiptNumber.isNotEmpty ? dto.receiptNumber : dto.row,
      amount: amount.abs(), // Store as positive value
      paymentDate: transactionDate,
      paymentMethod: paymentMethod,
      transactionId: dto.receiptNumber,
      status: PaymentStatus.completed,
      referenceNumber: referenceNumber,
      notes: dto.transactionDescription, // Preserve original description to determine payment vs bill
      metadata: {
        'transactionAmount': amount, // Original signed transaction amount
        'accountBalance': accountBalance, // Account balance from API
      },
    );
  }

  /// Parse transaction date string to DateTime
  /// Handles formats like "Jan 08, 2026"
  DateTime _parseTransactionDate(String dateStr) {
    if (dateStr.isEmpty) return DateTime.now();
    
    try {
      // Try parsing "Jan 08, 2026" format
      final format = DateFormat('MMM dd, yyyy');
      return format.parse(dateStr);
    } catch (e) {
      Logger.warning('Failed to parse transaction date: $dateStr', tag: 'BillsRepository');
      return DateTime.now();
    }
  }

  /// Parse transaction amount string to double
  /// Handles negative amounts for payments (e.g., "-221.61")
  double _parseTransactionAmount(String amountStr) {
    if (amountStr.isEmpty) return 0;
    
    try {
      // Remove any currency symbols and parse
      final cleaned = amountStr
          .replaceAll(r'$', '')
          .replaceAll(',', '')
          .trim();
      return double.tryParse(cleaned) ?? 0.0;
    } catch (e) {
      Logger.warning('Failed to parse transaction amount: $amountStr', tag: 'BillsRepository');
      return 0;
    }
  }

  /// Fetch bill detail from API
  /// GET /Bills/V3/Detail/{billNumber}
  Future<BillDetailDataDto?> fetchBillDetail(String billNumber) async {
    try {
      print('[Bills] Repository.fetchBillDetail start billNumber=$billNumber');
      
      if (EnvConfig.useMockApi) {
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 500));
        // Return mock data based on the real response format
        return BillDetailDataDto(
          billNumber: billNumber,
          readingDate: '04 Nov 25 - 04 Dec 25',
          billingDate: '04-Dec-2025',
          previousBalance: r'$ 298.04',
          lessPayment: r'($ 298.04) CR',
          balanceForward: r'($ 0.00) CR',
          consumption: r'$ 185.17',
          minimumBill: r'$ 0.00',
          crimeStoppersPledge: r'$ 0.00',
          otherCharge: r'$ 0.00',
          gstCharge: r'$ 36.44',
          taxAdjustment: r'$ 0.00',
          amountDue: r'$ 221.61',
          balance: r'$ 0.00',
          paymentDueDate: '03 Jan 26',
          previousReading: '75,956',
          presentReading: '76,663',
          totalConsumption: '707',
          dueIn: '-18',
          paid: true,
          customerName: 'MOCK CUSTOMER',
          accountNumber: '00000000',
          customerNumber: '00000000',
        );
      }

      final endpoint = ApiEndpoints.billDetail(billNumber);
      Logger.info('Fetching bill detail from: $endpoint', tag: 'BillsRepository');
      
      final response = await HttpClient.instance.client.get<Map<String, dynamic>>(
        endpoint,
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseDto = BillDetailResponseDto.fromJson(response.data!);
        
        if (responseDto.status == 200) {
          print('[Bills] ✅ Successfully fetched bill detail for billNumber=$billNumber');
          Logger.info('Successfully fetched bill detail', tag: 'BillsRepository');
          return responseDto.bill;
        } else {
          Logger.warning('Failed to fetch bill detail. Status: ${responseDto.status}', tag: 'BillsRepository');
          return null;
        }
      } else {
        Logger.warning('Failed to fetch bill detail. Status: ${response.statusCode}', tag: 'BillsRepository');
        return null;
      }
    } catch (e, stackTrace) {
      Logger.error(
        'Error fetching bill detail',
        error: e,
        stackTrace: stackTrace,
        tag: 'BillsRepository',
      );
      return null;
    }
  }

  /// Request an activation code for bill download access.
  ///
  /// POST /Bills/V5/BillDownloadActivationCode
  /// For activation code requests, the code itself is returned in the
  /// `message` field.
  Future<BaseApiResponseDto> requestBillDownloadActivationCode({
    required String billNumber,
  }) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.billDownloadActivationCode,
        data: {
          'BillNumber': billNumber,
        },
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        return BaseApiResponseDto.fromJson(response.data!);
      }

      Logger.warning(
        'Bill download activationCode request failed. Status: ${response.statusCode}',
        tag: 'BillsRepository',
      );
      return BaseApiResponseDto(
        status: response.statusCode ?? 500,
        message: 'Failed to send activation code.',
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error requesting bill download activation code',
        error: e,
        stackTrace: stackTrace,
        tag: 'BillsRepository',
      );
      return const BaseApiResponseDto(
        status: 500,
        message: 'Unexpected error while sending activation code.',
      );
    }
  }

  /// Validate bill download activation code.
  ///
  /// POST /Bills/V5/BillDownloadAuthenticationCode
  /// For activation, the human-readable result is returned in the `message`
  /// field.
  Future<BaseApiResponseDto> validateBillDownloadActivationCode({
    required String billNumber,
    required String code,
  }) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.billDownloadAuthenticationCode,
        data: {
          'BillNumber': billNumber,
          'Code': code,
        },
        authenticated: true,
      );

      if (response.statusCode == 200 && response.data != null) {
        return BaseApiResponseDto.fromJson(response.data!);
      }

      Logger.warning(
        'Bill download authenticationCode request failed. Status: ${response.statusCode}',
        tag: 'BillsRepository',
      );
      return BaseApiResponseDto(
        status: response.statusCode ?? 500,
        message: 'Failed to verify activation code.',
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error validating bill download activation code',
        error: e,
        stackTrace: stackTrace,
        tag: 'BillsRepository',
      );
      return const BaseApiResponseDto(
        status: 500,
        message: 'Unexpected error while verifying activation code.',
      );
    }
  }

  /// Extract payment method from transaction description
  /// Example: "Payment - Cash (B)" -> "Cash"
  String _extractPaymentMethod(String description) {
    if (description.isEmpty) return 'Unknown';
    
    // Check for common payment methods in description
    if (description.toLowerCase().contains('cash')) {
      return 'Cash';
    } else if (description.toLowerCase().contains('credit')) {
      return 'Credit Card';
    } else if (description.toLowerCase().contains('debit')) {
      return 'Debit Card';
    } else if (description.toLowerCase().contains('check') || description.toLowerCase().contains('cheque')) {
      return 'Check';
    } else if (description.toLowerCase().contains('bank')) {
      return 'Bank Transfer';
    } else if (description.toLowerCase().contains('mobile') || description.toLowerCase().contains('digiwallet')) {
      return 'Mobile Payment';
    }
    
    return 'Unknown';
  }
}
