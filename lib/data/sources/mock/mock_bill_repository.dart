import '../../../core/utils/error_handler.dart';
import '../../../core/utils/logger.dart';
import '../../models/bill.dart';
import '../../models/consumption.dart';
import '../../repositories/bill_repository.dart';
import 'data_loader.dart';
import 'mock_asset_paths.dart';

/// Mock implementation of BillRepository using local JSON data
class MockBillRepository implements BillRepository {
  static const String _billsDataPath = MockAssetPaths.bills;
  static const String _consumptionDataPath = MockAssetPaths.consumption;

  @override
  Future<ApiResponse<BillsResponse>> getBills(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting bills for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved ${billsResponse.bills.length} bills');
      return ApiResponse.success(billsResponse);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get bills', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve bills: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<BillsResponse>> getBillsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      Logger.info('MockBillRepository: Getting bills by date range for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse allBills = BillsResponse.fromJson(billsData);
      
      // Filter bills by date range
      final filteredBills = allBills.bills.where((bill) => bill.billingPeriod.startDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
               bill.billingPeriod.endDate.isBefore(endDate.add(const Duration(days: 1)))).toList();
      
      final filteredResponse = BillsResponse(
        bills: filteredBills,
        summary: allBills.summary,
      );
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved ${filteredBills.length} bills in date range');
      return ApiResponse.success(filteredResponse);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get bills by date range', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve bills by date range: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<Bill>> getBillById(String billId) async {
    try {
      Logger.info('MockBillRepository: Getting bill by ID: $billId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      final bill = billsResponse.bills.firstWhere(
        (bill) => bill.id == billId,
        orElse: () => throw Exception('Bill not found'),
      );
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved bill: ${bill.billNumber}');
      return ApiResponse.success(bill);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get bill by ID', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve bill: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<Bill>> getLatestBill(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting latest bill for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      // Sort bills by issue date and get the latest
      final sortedBills = billsResponse.bills.toList()
        ..sort((a, b) => b.issueDate.compareTo(a.issueDate));
      
      final latestBill = sortedBills.first;
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved latest bill: ${latestBill.billNumber}');
      return ApiResponse.success(latestBill);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get latest bill', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve latest bill: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<Bill>>> getUnpaidBills(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting unpaid bills for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      final unpaidBills = billsResponse.bills.where((bill) => bill.status != 'paid').toList();
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved ${unpaidBills.length} unpaid bills');
      return ApiResponse.success(unpaidBills);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get unpaid bills', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve unpaid bills: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<BillsSummary>> getBillsSummary(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting bills summary for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved bills summary');
      return ApiResponse.success(billsResponse.summary);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get bills summary', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve bills summary: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<String>> downloadBillPdf(String billId) async {
    try {
      Logger.info('MockBillRepository: Downloading bill PDF: $billId');
      
      await Future.delayed(const Duration(milliseconds: 1000)); // Simulate download time
      
      final pdfUrl = '/api/bills/$billId/pdf';
      Logger.info('MockBillRepository: ApiResponse.successfully generated PDF URL: $pdfUrl');
      return ApiResponse.success(pdfUrl);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to download bill PDF', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to download bill PDF: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<BillPayment>>> getPaymentHistory(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting payment history for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      final paymentHistory = billsResponse.bills
          .where((bill) => bill.status == 'paid')
          .map((bill) => bill.payment)
          .toList();
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved ${paymentHistory.length} payment records');
      return ApiResponse.success(paymentHistory);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get payment history', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve payment history: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<BillPayment>> processPayment(
    String billId,
    double amount,
    String paymentMethod,
  ) async {
    try {
      Logger.info('MockBillRepository: Processing payment for bill: $billId');
      
      await Future.delayed(const Duration(milliseconds: 1500)); // Simulate payment processing
      
      final payment = BillPayment(
        paidDate: DateTime.now(),
        paidAmount: amount,
        paymentMethod: paymentMethod,
        transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      );
      
      Logger.info('MockBillRepository: ApiResponse.successfully processed payment: ${payment.transactionId}');
      return ApiResponse.success(payment);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to process payment', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to process payment: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<Bill>>> getUpcomingBills(String userId) async {
    try {
      Logger.info('MockBillRepository: Getting upcoming bills for user: $userId');
      
      final Map<String, dynamic> billsData = await DataLoader.loadJsonFromAssets(_billsDataPath);
      final BillsResponse billsResponse = BillsResponse.fromJson(billsData);
      
      final now = DateTime.now();
      final upcomingBills = billsResponse.bills.where((bill) => bill.dueDate.isAfter(now) && bill.status != 'paid').toList();
      
      Logger.info('MockBillRepository: ApiResponse.successfully retrieved ${upcomingBills.length} upcoming bills');
      return ApiResponse.success(upcomingBills);
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get upcoming bills', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve upcoming bills: ${e.toString()}');
    }
  }

  @override
  Future<ApiResponse<List<MonthlyConsumption>>> getYearlyConsumption(String userId, int year) async {
    try {
      Logger.info('MockBillRepository: Getting yearly consumption for user: $userId, year: $year');

      final Map<String, dynamic> consumptionData = await DataLoader.loadJsonFromAssets(_consumptionDataPath);
      final Map<String, dynamic> monthlyDataByYear =
          consumptionData['monthlyConsumption'] as Map<String, dynamic>;

      final String yearString = year.toString();
      if (monthlyDataByYear.containsKey(yearString)) {
        final List<dynamic> monthlyData = monthlyDataByYear[yearString] as List<dynamic>;
        final monthlyConsumptionList =
            monthlyData.map((item) => MonthlyConsumption.fromJson(item as Map<String, dynamic>)).toList();

        Logger.info('MockBillRepository: Successfully retrieved ${monthlyConsumptionList.length} months of consumption data');
        return ApiResponse.success(monthlyConsumptionList);
      } else {
        Logger.info('MockBillRepository: No monthly consumption data found for year $year');
        return ApiResponse.success([]); // Return empty list if no data for the year
      }
    } catch (e, stackTrace) {
      Logger.error('MockBillRepository: Failed to get yearly consumption', error: e, stackTrace: stackTrace);
      return ApiResponse.error('Failed to retrieve yearly consumption: ${e.toString()}');
    }
  }

  // BaseRepository implementation
  @override
  Future<T> handleResponse<T>(
    Future<dynamic> Function() apiCall,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await apiCall();
      return fromJson(response as Map<String, dynamic>);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }

  @override
  void handleError(Exception error) {
    Logger.error('MockBillRepository: API Error', error: error);
  }
}
