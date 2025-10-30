import '../models/bill.dart';
import 'base_repository.dart';
import '../../core/utils/error_handler.dart';

/// Abstract interface for bill data operations
abstract class BillRepository extends BaseRepository {
  /// Get all bills for a user
  Future<ApiResponse<BillsResponse>> getBills(String userId);

  /// Get bills by date range
  Future<ApiResponse<BillsResponse>> getBillsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get a specific bill by ID
  Future<ApiResponse<Bill>> getBillById(String billId);

  /// Get latest bill for a user
  Future<ApiResponse<Bill>> getLatestBill(String userId);

  /// Get unpaid bills for a user
  Future<ApiResponse<List<Bill>>> getUnpaidBills(String userId);

  /// Get bills summary for a user
  Future<ApiResponse<BillsSummary>> getBillsSummary(String userId);

  /// Download bill PDF
  Future<ApiResponse<String>> downloadBillPdf(String billId);

  /// Get bill payment history
  Future<ApiResponse<List<BillPayment>>> getPaymentHistory(String userId);

  /// Process bill payment
  Future<ApiResponse<BillPayment>> processPayment(
    String billId,
    double amount,
    String paymentMethod,
  );

  /// Get upcoming bills
  Future<ApiResponse<List<Bill>>> getUpcomingBills(String userId);
}
