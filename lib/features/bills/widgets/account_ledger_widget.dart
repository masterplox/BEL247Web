import 'package:flutter/material.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/utils/widget_builder_utils.dart';
import '../../../core/widgets/app_empty_state.dart';
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
                  Icon(
                    Icons.arrow_upward,
                    color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).textTheme.bodySmall?.color,
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
                        ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
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
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
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
        description: FormattingUtils.formatBillingPeriod(bill.billingPeriod),
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
            color: isExpanded ? Theme.of(context).colorScheme.surface : Colors.transparent,
            child: isMobile
                ? _buildMobileRow(context, entry)
                : Row(
              children: [
                // Date with icon
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      WidgetBuilderUtils.buildDateIcon(context, entry.isPayment),
                      const SizedBox(width: AppTheme.spacing8),
                      Flexible(
                        child: Text(
                          FormattingUtils.formatDate(entry.date),
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
                          style: Theme.of(context).textTheme.bodySmall,
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
                      FormattingUtils.formatAmount(entry.amount),
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
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppTheme.radius4),
                          ),
                          child: Text(
                            'Paid Up',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Chevron
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download_outlined),
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        tooltip: entry.isPayment ? 'Download Receipt' : 'Download Bill',
                        onPressed: () {
                          if (entry.isPayment) {
                            if (entry.payment != null) {
                              widget.onDownloadReceipt?.call(entry.payment!);
                            }
                          } else {
                            if (entry.bill != null) {
                              widget.onDownloadBill?.call(entry.bill!);
                            }
                          }
                        },
                      ),
                      Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ],
                  ),
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
              WidgetBuilderUtils.buildDateIcon(context, entry.isPayment),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FormattingUtils.formatDate(entry.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      entry.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (entry.subDescription != null)
                      Text(
                        entry.subDescription!,
                        style: Theme.of(context).textTheme.bodySmall,
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
                FormattingUtils.formatAmount(entry.amount),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: entry.isPayment ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BZ\$${entry.accountBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: entry.accountBalance == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(width: AppTheme.spacing4),
                  Icon(
                    entry.accountBalance == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                    size: 14,
                    color: entry.accountBalance == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ],
          ),
        ],
      );


  Widget _buildExpandedDetails(BuildContext context, LedgerEntry entry) => Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      color: Theme.of(context).colorScheme.surface,
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
        _buildDetailRow(context, 'Electric Payment', 'BZ\$${entry.amount.abs().toStringAsFixed(2)}'),
        _buildDetailRow(context, 'Outstanding Balance', 'BZ\$${entry.accountBalance.toStringAsFixed(2)}'),
        const SizedBox(height: AppTheme.spacing16),
      ],
    );
  }

  Widget _buildBillDetails(BuildContext context, LedgerEntry entry) {
    final bill = entry.bill;
    if (bill == null) return const SizedBox.shrink();

    // Calculate outstanding balance
    final outstandingBalance = bill.amounts.previousBalance + bill.amounts.totalAmount - bill.payment.paidAmount;
    final gst = bill.amounts.taxes * 0.125; // Assuming GST is 12.5% of total taxes. This might need adjustment.

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
        _buildDetailRow(context, 'Bill Number', bill.billNumber),
        _buildDetailRow(context, 'Billing Period', FormattingUtils.formatBillingPeriodDetailed(bill.billingPeriod)),
        _buildDetailRow(context, 'Due Date', FormattingUtils.formatDate(bill.dueDate)),
        const Divider(height: AppTheme.spacing24),
        _buildDetailRow(context, 'Previous Balance', 'BZ\$${bill.amounts.previousBalance.toStringAsFixed(2)}'),
        _buildDetailRow(context, 'Less Payment', '-BZ\$${bill.payment.paidAmount.toStringAsFixed(2)}'),
        _buildDetailRow(
          context,
          'Outstanding Balance',
          'BZ\$${outstandingBalance.toStringAsFixed(2)}',
        ),
        const Divider(height: AppTheme.spacing24),
        _buildDetailRow(context, 'Consumption', '${bill.usage.kwhUsed.toStringAsFixed(2)} kWh'),
        _buildDetailRow(context, 'GST 12.5%', 'BZ\$${gst.toStringAsFixed(2)}'),
        const Divider(height: AppTheme.spacing24),
        _buildDetailRow(
          context,
          'Total Due',
          'BZ\$${bill.amounts.totalAmount.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) => WidgetBuilderUtils.buildDetailRow(context, label, value, isTotal: isTotal);

  Widget _buildEmptyState(BuildContext context) => const AppEmptyState(
        title: 'No transactions found',
        message: 'Your bills and payments will appear here',
        icon: Icons.receipt_long_outlined,
      );
}

