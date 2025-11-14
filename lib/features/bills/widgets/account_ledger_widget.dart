import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/bill.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Ledger entry representing either a bill or payment receipt
class LedgerEntry {

  LedgerEntry({
    required this.id,
    required this.date,
    required this.description,
    this.subDescription,
    required this.amount,
    required this.accountBalance,
    required this.isPayment,
    this.bill,
    this.payment,
    this.isPaidUp = false,
  });
  final String id;
  final DateTime date;
  final String description;
  final String? subDescription; // For receipt numbers
  final double amount;
  final double accountBalance;
  final bool isPayment;
  final Bill? bill; // If it's a bill, this contains the bill data
  final PaymentHistory? payment; // If it's a payment, this contains the payment data
  final bool isPaidUp;
}

/// Account Ledger widget that displays bills and payments in a unified list
class AccountLedgerWidget extends StatefulWidget {
  const AccountLedgerWidget({
    super.key,
    required this.bills,
    this.onDownloadBill,
    this.onDownloadReceipt,
    this.onViewFullDetails,
    this.isLoading = false,
  });

  final List<Bill> bills;
  final Function(Bill)? onDownloadBill;
  final Function(PaymentHistory)? onDownloadReceipt;
  final Function(PaymentHistory)? onViewFullDetails;
  final bool isLoading;

  @override
  State<AccountLedgerWidget> createState() => _AccountLedgerWidgetState();
}

class _AccountLedgerWidgetState extends State<AccountLedgerWidget> {
  final Set<String> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    final ledgerEntries = _buildLedgerEntries();
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                    Text(
                      'Transaction History',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing4),
              Text(
                'Bills and payments affecting your account balance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
        // Column headers (hidden on mobile; rows become self-labeled)
        if (!isMobile)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing12,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Bill Amount',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Account Balance',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing16), // Space for chevron
              ],
            ),
          ),
        // Ledger entries
        if (widget.isLoading)
          const Padding(
            padding: EdgeInsets.all(AppTheme.spacing32),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (ledgerEntries.isEmpty)
          _buildEmptyState(context)
        else
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: ledgerEntries.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = ledgerEntries[index];
                final isExpanded = _expandedItems.contains(entry.id);
                return _buildLedgerRow(context, entry, isExpanded, isMobile: isMobile);
              },
            ),
          ),
      ],
    );
  }

  List<LedgerEntry> _buildLedgerEntries() {
    final entries = <LedgerEntry>[];
    double runningBalance = 0;

    // Sort bills by issue date (newest first) and payments by date
    final sortedBills = List<Bill>.from(widget.bills)
      ..sort((a, b) => b.issueDate.compareTo(a.issueDate));

    // Create entries from bills and their payments
    // First, build all entries without sorting
    final allEntries = <LedgerEntry>[];
    
    for (final bill in sortedBills) {
      // Add bill entry first (before payment)
      runningBalance += bill.amounts.totalAmount;
      allEntries.add(LedgerEntry(
        id: 'bill_${bill.id}',
        date: bill.issueDate,
        description: _formatBillingPeriod(bill.billingPeriod),
        amount: bill.amounts.totalAmount,
        accountBalance: runningBalance,
        isPayment: false,
        bill: bill,
        isPaidUp: bill.isPaid && runningBalance == 0,
      ));

      // Add payment entry if bill is paid
      // Check both paymentHistory and the payment field
      PaymentHistory? latestPayment;
      if (bill.paymentHistory.isNotEmpty) {
        // Sort payments by date (newest first) to get the latest
        final sortedPayments = List<PaymentHistory>.from(bill.paymentHistory)
          ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
        latestPayment = sortedPayments.first;
      } else if (bill.isPaid) {
        // Use the payment field as fallback
        latestPayment = PaymentHistory(
          id: 'payment_${bill.id}',
          amount: bill.payment.paidAmount,
          paymentDate: bill.payment.paidDate,
          paymentMethod: bill.payment.paymentMethod,
          transactionId: bill.payment.transactionId,
          status: PaymentStatus.completed,
          referenceNumber: 'RCP-${bill.billNumber}',
        );
      }

      if (latestPayment != null) {
        // Payment reduces balance
        runningBalance -= latestPayment.amount;
        allEntries.add(LedgerEntry(
          id: 'payment_${bill.id}',
          date: latestPayment.paymentDate,
          description: 'Payment - ${latestPayment.paymentMethod}',
          subDescription: latestPayment.referenceNumber ?? 'RCP-${bill.billNumber}',
          amount: -latestPayment.amount, // Negative for payments
          accountBalance: runningBalance,
          isPayment: true,
          payment: latestPayment,
          isPaidUp: runningBalance == 0,
        ));
      }
    }
    
    entries.addAll(allEntries);

    // Sort all entries by date (newest first)
    entries.sort((a, b) => b.date.compareTo(a.date));

    return entries;
  }

  String _formatBillingPeriod(BillingPeriod period) {
    final monthName = DateFormat('MMMM').format(period.startDate);
    final year = period.startDate.year;
    return '$monthName $year';
  }

  Widget _buildLedgerRow(BuildContext context, LedgerEntry entry, bool isExpanded, {required bool isMobile}) => Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (isExpanded) {
                _expandedItems.remove(entry.id);
              } else {
                _expandedItems.add(entry.id);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing12,
            ),
            color: isExpanded ? AppColors.surface : Colors.transparent,
            child: isMobile
                ? _buildMobileRow(context, entry)
                : Row(
              children: [
                // Date with icon
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      _buildDateIcon(entry.isPayment),
                      const SizedBox(width: AppTheme.spacing8),
                      Flexible(
                        child: Text(
                          _formatDate(entry.date),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                // Description
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      if (entry.subDescription != null) ...[
                        const SizedBox(height: AppTheme.spacing4),
                        Text(
                          entry.subDescription!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ],
                    ],
                  ),
                ),
                // Bill Amount
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _formatAmount(entry.amount),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                // Account Balance
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'BZ\$${entry.accountBalance.toStringAsFixed(2)}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      if (entry.isPaidUp) ...[
                        const SizedBox(height: AppTheme.spacing4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacing8,
                            vertical: AppTheme.spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.radius4),
                          ),
                          child: Text(
                            'Paid Up',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Chevron
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        // Expanded details
        if (isExpanded) _buildExpandedDetails(context, entry),
      ],
    );

  Widget _buildMobileRow(BuildContext context, LedgerEntry entry) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line 1: icon + date + description (wrap)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateIcon(entry.isPayment),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(entry.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      entry.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (entry.subDescription != null)
                      Text(
                        entry.subDescription!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          // Line 2: amounts right-aligned
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatAmount(entry.amount),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: entry.isPayment ? AppColors.success : AppColors.error,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BZ\$${entry.accountBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: entry.accountBalance == 0 ? AppColors.success : AppColors.error,
                        ),
                  ),
                  const SizedBox(width: AppTheme.spacing4),
                  Icon(
                    entry.accountBalance == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 14,
                    color: entry.accountBalance == 0 ? AppColors.success : AppColors.error,
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Widget _buildDateIcon(bool isPayment) {
    if (isPayment) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        ),
      );
    } else {
      return const Icon(
        Icons.description,
        color: Colors.blue,
        size: 24,
      );
    }
  }

  Widget _buildExpandedDetails(BuildContext context, LedgerEntry entry) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      color: AppColors.surface,
      child: entry.isPayment
          ? _buildPaymentDetails(context, entry)
          : _buildBillDetails(context, entry),
    );

  Widget _buildPaymentDetails(BuildContext context, LedgerEntry entry) {
    final payment = entry.payment;
    if (payment == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        _buildDetailRow(context, 'Receipt Number', payment.referenceNumber ?? 'N/A'),
        _buildDetailRow(context, 'Payment Method', payment.paymentMethod),
        _buildDetailRow(context, 'Amount', 'BZ\$${entry.amount.abs().toStringAsFixed(2)}'),
        _buildDetailRow(context, 'Transaction ID', payment.transactionId),
        if (payment.referenceNumber != null)
          _buildDetailRow(context, 'Reference', payment.referenceNumber!),
        const SizedBox(height: AppTheme.spacing16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => widget.onDownloadReceipt?.call(payment),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Download Receipt'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            OutlinedButton.icon(
              onPressed: () => widget.onViewFullDetails?.call(payment),
              icon: const Icon(Icons.description, size: 18),
              label: const Text('Full Details'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBillDetails(BuildContext context, LedgerEntry entry) {
    final bill = entry.bill;
    if (bill == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bill Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        _buildDetailRow(
          context,
          'Energy Charge',
          'BZ\$${bill.usage.generationCharge.toStringAsFixed(2)}',
        ),
        _buildDetailRow(
          context,
          'Service Fee',
          'BZ\$${bill.amounts.fees.toStringAsFixed(2)}',
        ),
        _buildDetailRow(
          context,
          'Taxes',
          'BZ\$${bill.amounts.taxes.toStringAsFixed(2)}',
        ),
        const Divider(height: AppTheme.spacing24),
        _buildDetailRow(
          context,
          'Total Amount',
          'BZ\$${bill.amounts.totalAmount.toStringAsFixed(2)}',
          isTotal: true,
        ),
        _buildDetailRow(
          context,
          'Due Date',
          _formatDate(bill.dueDate),
        ),
        const SizedBox(height: AppTheme.spacing16),
        Center(
          child: ElevatedButton.icon(
            onPressed: () => widget.onDownloadBill?.call(bill),
            icon: const Icon(Icons.download, size: 18),
            label: const Text('Download Bill'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                  color: isTotal ? AppColors.textPrimary : null,
                ),
          ),
        ],
      ),
    );

  Widget _buildEmptyState(BuildContext context) => Padding(
      padding: const EdgeInsets.all(AppTheme.spacing32),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'No transactions found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Your bills and payments will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ],
        ),
      ),
    );

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatAmount(double amount) {
    final absAmount = amount.abs();
    if (amount < 0) {
      return '-BZ\$${absAmount.toStringAsFixed(2)}';
    } else {
      return 'BZ\$${absAmount.toStringAsFixed(2)}';
    }
  }
}

