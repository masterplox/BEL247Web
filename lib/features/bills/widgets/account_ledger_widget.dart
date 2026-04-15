import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/account_verification_providers.dart';
import '../../../core/providers/feature_providers.dart';
import '../../../core/services/download_service.dart';
import '../../../core/utils/formatting_utils.dart';
import '../../../core/utils/widget_builder_utils.dart';
import '../../../core/widgets/account_access_activation_dialog.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../data/models/bill.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/bills_providers.dart';

/// Ledger entry representing either a bill, payment receipt, or transaction
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

/// Account Ledger widget that displays bills, payments, and transactions in a unified list
class AccountLedgerWidget extends ConsumerStatefulWidget {
  const AccountLedgerWidget({
    super.key,
    required this.bills,
    this.transactionHistory = const [],
    this.onViewFullDetails,
    this.isLoading = false,
  });

  final List<Bill> bills;
  final List<PaymentHistory> transactionHistory; // Live transaction history from API
  final Function(PaymentHistory)? onViewFullDetails;
  final bool isLoading;

  @override
  ConsumerState<AccountLedgerWidget> createState() => _AccountLedgerWidgetState();
}

enum _FilterType {
  all,
  bills,
  payments,
}

class _AccountLedgerWidgetState extends ConsumerState<AccountLedgerWidget> {
  final Set<String> _expandedItems = {};
  _FilterType _filterType = _FilterType.all;
  int? _selectedYear;
  int? _selectedMonth;

  @override
  void initState() {
    super.initState();
    // Set default to current year/month (left commented out intentionally)
    // final now = DateTime.now();
    // _selectedYear = now.year;
    // _selectedMonth = now.month;
  }

  @override
  Widget build(BuildContext context) {
    final allEntries = _buildLedgerEntries();
    final filteredEntries = _applyFilters(allEntries);
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with Filters
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   'Bills and payments affecting your account balance',
              //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //         color: Theme.of(context).textTheme.bodySmall?.color,
              //       ),
              // ),
              // const SizedBox(height: AppTheme.spacing16),
              // Filter Controls
              _buildFilterControls(context, isMobile),
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
        else if (filteredEntries.isEmpty)
          _buildEmptyState(context)
        else
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: filteredEntries.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = filteredEntries[index];
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

    // Use transaction history from API if available (live data), otherwise fallback to bills
    final useTransactionHistory = widget.transactionHistory.isNotEmpty;

    if (useTransactionHistory) {
      // Build entries from live transaction history from API
      // Transaction history includes both bills (positive amounts) and payments (negative amounts)
      final sortedTransactions = List<PaymentHistory>.from(widget.transactionHistory)
        ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

      // Also include bills data for reference (map by bill number)
      final billsMap = <String, Bill>{
        for (final bill in widget.bills) bill.billNumber: bill
      };

      for (final transaction in sortedTransactions) {
        // Determine if this is a payment or a bill charge based on transaction description
        // API sends descriptions like "Payment - Cash (B)" for payments and "Cycle Billing Due: ..." for bills
        final notes = transaction.notes ?? '';
        final isPayment = notes.toLowerCase().contains('payment') || 
                         notes.toLowerCase().startsWith('payment');
        
        // Get transactionAmount and accountBalance from metadata (stored from API)
        final transactionAmount = transaction.metadata?['transactionAmount'] as double?;
        final accountBalanceFromApi = transaction.metadata?['accountBalance'] as double?;
        
        
        // Use values from API if available, otherwise fallback to calculated values
        final displayAmount = transactionAmount ?? (isPayment ? -transaction.amount : transaction.amount);
        final displayBalance = accountBalanceFromApi ?? runningBalance;
        
        
        // Update running balance for fallback calculation (only if API values not available)
        if (transactionAmount == null || accountBalanceFromApi == null) {
          if (isPayment) {
            runningBalance -= transaction.amount;
          } else {
            runningBalance += transaction.amount;
          }
        }

        if (isPayment) {
          entries.add(LedgerEntry(
            id: transaction.id,
            date: transaction.paymentDate,
            description: notes.isNotEmpty ? notes : 'Payment - ${transaction.paymentMethod}',
            subDescription: transaction.referenceNumber ?? transaction.transactionId,
            amount: displayAmount, // Use transactionAmount from API (negative for payments)
            accountBalance: displayBalance, // Use accountBalance from API
            isPayment: true,
            payment: transaction,
            isPaidUp: displayBalance == 0,
          ));
        } else {
          // Try to find matching bill if available
          Bill? matchingBill;
          try {
            matchingBill = billsMap.values.firstWhere(
              (bill) => bill.billNumber == transaction.referenceNumber || 
                       (transaction.referenceNumber?.contains(bill.billNumber) ?? false),
            );
          } catch (_) {
            // No matching bill found, that's OK
          }
          entries.add(LedgerEntry(
            id: transaction.id,
            date: transaction.paymentDate,
            description: notes.isNotEmpty ? notes : 'Bill Charge',
            subDescription: transaction.referenceNumber,
            amount: displayAmount, // Use transactionAmount from API (positive for bills)
            accountBalance: displayBalance, // Use accountBalance from API
            isPayment: false,
            bill: matchingBill,
            isPaidUp: displayBalance == 0,
          ));
        }
      }
    } else {
      // Fallback: Build entries from bills (mock/legacy behavior)
      final sortedBills = List<Bill>.from(widget.bills)
        ..sort((a, b) => b.issueDate.compareTo(a.issueDate));

      for (final bill in sortedBills) {
        // Add bill entry first (before payment)
        runningBalance += bill.amounts.totalAmount;
        entries.add(LedgerEntry(
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
        PaymentHistory? latestPayment;
        if (bill.paymentHistory.isNotEmpty) {
          final sortedPayments = List<PaymentHistory>.from(bill.paymentHistory)
            ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
          latestPayment = sortedPayments.first;
        } else if (bill.isPaid) {
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
          runningBalance -= latestPayment.amount;
          entries.add(LedgerEntry(
            id: 'payment_${bill.id}',
            date: latestPayment.paymentDate,
            description: 'Payment - ${latestPayment.paymentMethod}',
            subDescription: latestPayment.referenceNumber ?? 'RCP-${bill.billNumber}',
            amount: -latestPayment.amount,
            accountBalance: runningBalance,
            isPayment: true,
            payment: latestPayment,
            isPaidUp: runningBalance == 0,
          ));
        }
      }
    }

    // Sort all entries by date (newest first)
    entries.sort((a, b) => b.date.compareTo(a.date));

    return entries;
  }

  List<LedgerEntry> _applyFilters(List<LedgerEntry> entries) {
    var filtered = entries;

    // Apply type filter (all/bills/payments)
    if (_filterType == _FilterType.bills) {
      filtered = filtered.where((e) => !e.isPayment).toList();
    } else if (_filterType == _FilterType.payments) {
      filtered = filtered.where((e) => e.isPayment).toList();
    }

    // Apply date filters (year and month)
    if (_selectedYear != null) {
      filtered = filtered.where((e) => e.date.year == _selectedYear).toList();
    }
    if (_selectedMonth != null) {
      filtered = filtered.where((e) => e.date.month == _selectedMonth).toList();
    }

    return filtered;
  }

  Widget _buildFilterControls(BuildContext context, bool isMobile) {
    // Get available years and months from entries
    final allEntries = _buildLedgerEntries();
    final availableYears = allEntries
        .map((e) => e.date.year)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a)); // Descending (newest first)
    
    final availableMonths = allEntries
        .map((e) => e.date.month)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a)); // Descending

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Type filter (dropdown on mobile to avoid overflow)
          _buildTypeFilterMobile(context),
          const SizedBox(height: AppTheme.spacing12),
          // Date filters stacked vertically so each dropdown has full width (avoids overflow)
          _buildYearFilter(context, availableYears),
          const SizedBox(height: AppTheme.spacing12),
          _buildMonthFilter(context, availableMonths),
        ],
      );
    }

    return Wrap(
      spacing: AppTheme.spacing12,
      runSpacing: AppTheme.spacing12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Type filter
        _buildTypeFilter(context),
        // Year filter
        SizedBox(
          width: 150,
          child: _buildYearFilter(context, availableYears),
        ),
        // Month filter
        SizedBox(
          width: 150,
          child: _buildMonthFilter(context, availableMonths),
        ),
      ],
    );
  }

  /// Mobile: single dropdown for type filter to avoid overflow
  Widget _buildTypeFilterMobile(BuildContext context) => DropdownButtonFormField<_FilterType>(
      initialValue: _filterType,
      decoration: InputDecoration(
        labelText: 'Filter',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing12,
        ),
        isDense: true,
      ),
      items: const [
        DropdownMenuItem(value: _FilterType.all, child: Text('All')),
        DropdownMenuItem(value: _FilterType.bills, child: Text('Bills')),
        DropdownMenuItem(value: _FilterType.payments, child: Text('Payments')),
      ],
      onChanged: (value) {
        if (value != null) setState(() => _filterType = value);
      },
    );

  Widget _buildTypeFilter(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: SegmentedButton<_FilterType>(
        segments: const [
          ButtonSegment(
            value: _FilterType.all,
            label: Text('All'),
            icon: Icon(Icons.list, size: 16),
          ),
          ButtonSegment(
            value: _FilterType.bills,
            label: Text('Bills'),
            icon: Icon(Icons.receipt, size: 16),
          ),
          ButtonSegment(
            value: _FilterType.payments,
            label: Text('Payments'),
            icon: Icon(Icons.payment, size: 16),
          ),
        ],
        selected: <_FilterType>{_filterType},
        onSelectionChanged: (Set<_FilterType> newSelection) {
          if (newSelection.isNotEmpty) {
            setState(() {
              _filterType = newSelection.first;
            });
          }
        },
      ),
    );

  Widget _buildYearFilter(BuildContext context, List<int> availableYears) => DropdownButtonFormField<int?>(
      isExpanded: true,
      initialValue: _selectedYear,
      decoration: InputDecoration(
        labelText: 'Year',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing12,
        ),
        isDense: true,
      ),
      items: [
        const DropdownMenuItem<int>(
          value: null,
          child: Text('All'),
        ),
        ...availableYears.map((year) => DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            )),
      ],
      onChanged: (value) {
        setState(() {
          _selectedYear = value;
        });
      },
    );

  Widget _buildMonthFilter(BuildContext context, List<int> availableMonths) {
    final monthNames = DateFormat('MMMM').dateSymbols.MONTHS;
    
    return DropdownButtonFormField<int?>(
      isExpanded: true,
      initialValue: _selectedMonth,
      decoration: InputDecoration(
        labelText: 'Month',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing12,
        ),
        isDense: true,
      ),
      items: [
        const DropdownMenuItem<int>(
          value: null,
          child: Text('All'),
        ),
        ...availableMonths.map((month) => DropdownMenuItem<int>(
              value: month,
              child: Text(monthNames[month - 1]),
            )),
      ],
      onChanged: (value) {
        setState(() {
          _selectedMonth = value;
        });
      },
    );
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
                      // WidgetBuilderUtils.buildDateIcon(context, entry.isPayment),
                      // const SizedBox(width: AppTheme.spacing8),
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
                      // if (entry.subDescription != null) ...[
                      //   const SizedBox(height: AppTheme.spacing4),
                      //   Text(
                      //     entry.subDescription!,
                      //     style: Theme.of(context).textTheme.bodySmall,
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //     softWrap: false,
                      //   ),
                      // ],
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
                      // if (entry.isPaidUp) ...[
                      //   const SizedBox(height: AppTheme.spacing4),
                      //   Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: AppTheme.spacing8,
                      //       vertical: AppTheme.spacing4,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      //       borderRadius: BorderRadius.circular(AppTheme.radius4),
                      //     ),
                      //     child: Text(
                      //       'Paid Up',
                      //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //             color: Theme.of(context).colorScheme.primary,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //     ),
                      //   ),
                      // ],
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
                        onPressed: () => _handleDownload(context, entry),
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

  Widget _buildMobileRow(BuildContext context, LedgerEntry entry) {
    final isExpanded = _expandedItems.contains(entry.id);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line 1: icon + date + description (wrap)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WidgetBuilderUtils.buildDateIcon(context, entry.isPayment),
              // const SizedBox(width: AppTheme.spacing8),
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
                    // if (entry.subDescription != null)
                    //   Text(
                    //     entry.subDescription!,
                    //     style: Theme.of(context).textTheme.bodySmall,
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
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
                  // Icon(
                  //   entry.accountBalance == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                  //   size: 14,
                  //   color: entry.accountBalance == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                  // ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          // Line 3: Action buttons (download and expand/collapse)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.download_outlined),
                color: Theme.of(context).textTheme.bodySmall?.color,
                tooltip: entry.isPayment ? 'Download Receipt' : 'Download Bill',
                onPressed: () => _handleDownload(context, entry),
                iconSize: 20,
                padding: const EdgeInsets.all(AppTheme.spacing8),
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Theme.of(context).textTheme.bodySmall?.color,
                size: 20,
              ),
            ],
          ),
        ],
      );
  }


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
    // Get bill number from entry
    String? billNumber;
    
    if (entry.bill != null) {
      billNumber = entry.bill!.billNumber;
    } else if (entry.subDescription != null && entry.subDescription!.isNotEmpty) {
      // Extract from subDescription (contains referenceNumber/billNumber for transaction history)
      billNumber = entry.subDescription;
    } else {
      // Can't fetch without bill number
      return const SizedBox.shrink();
    }

    // Ensure billNumber is not null before using it
    if (billNumber == null || billNumber.isEmpty) {
      return const SizedBox.shrink();
    }

    // Fetch bill detail using provider (cached)
    final billDetailAsync = ref.watch(billDetailProvider(billNumber));

    return billDetailAsync.when(
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.spacing32),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      error: (error, stackTrace) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            'Error loading bill details: ${error.toString()}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                ),
          ),
        ],
      ),
      data: (billDetail) {
        if (billDetail == null) {
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
              Text(
                'Bill details not available',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          );
        }

        // Display bill detail breakdown
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
            // Bill Information
            _buildDetailRow(context, 'Billing Period', billDetail.readingDate),
            _buildDetailRow(context, 'Reading Date', billDetail.billingDate),
            _buildDetailRow(context, 'Payment Due Date', billDetail.paymentDueDate),
            _buildDetailRow(context, 'Status', billDetail.paid ? 'Paid' : 'Unpaid'),
            const Divider(height: AppTheme.spacing24),
            // Balance Information
            _buildDetailRow(context, 'Previous Balance', billDetail.previousBalance),
            _buildDetailRow(context, 'Less Payment', billDetail.lessPayment),
            _buildDetailRow(context, 'Balance Forward', billDetail.balanceForward),
            const Divider(height: AppTheme.spacing24),
            // Consumption Information
            _buildDetailRow(context, 'Previous Reading', billDetail.previousReading),
            _buildDetailRow(context, 'Present Reading', billDetail.presentReading),
            _buildDetailRow(context, 'Total Consumption', '${billDetail.totalConsumption} kWh'),
            const Divider(height: AppTheme.spacing24),
            // Charges Breakdown
            _buildDetailRow(context, 'Consumption', billDetail.consumption),
            _buildDetailRow(context, 'Minimum Bill', billDetail.minimumBill),
            _buildDetailRow(context, 'Crime Stoppers Pledge', billDetail.crimeStoppersPledge),
            _buildDetailRow(context, 'Other Charge', billDetail.otherCharge),
            _buildDetailRow(context, 'GST Charge', billDetail.gstCharge),
            _buildDetailRow(context, 'Tax Adjustment', billDetail.taxAdjustment),
            const Divider(height: AppTheme.spacing24),
            // Totals
            _buildDetailRow(context, 'Amount Due', billDetail.amountDue, isTotal: true),
            _buildDetailRow(context, 'Balance', billDetail.balance),
            if (billDetail.dueIn.isNotEmpty)
              _buildDetailRow(context, 'Due In', billDetail.dueIn),
          ],
        );
      },
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

  /// Handle download for bills or receipts
  Future<void> _handleDownload(BuildContext context, LedgerEntry entry) async {
    
    var isVerified =
        await ref.read(accountVerificationStatusProvider.future);

    // Receipts always require full access.
    if (entry.isPayment && !isVerified) {
      final result = await showFullAccessActivationDialog(context);
      if (result ?? false) {
        isVerified =
            await ref.refresh(accountVerificationStatusProvider.future);
      }
    }
    if (entry.isPayment && !isVerified) {
      return;
    }

    // Bills can be downloaded if the user has either:
    // - fullAccess, OR
    // - billDownloadAccess
    if (!entry.isPayment) {
      var hasBillDownloadAccess =
          await ref.read(billDownloadAccessStatusProvider.future);

      final bill = entry.bill;
      final billNumber = bill?.billNumber ?? entry.subDescription ?? '';

      if (billNumber.isNotEmpty && !isVerified && !hasBillDownloadAccess) {
        final activationResult = await showBillDownloadActivationDialog(
          context,
          billNumber: billNumber,
        );
        if (activationResult ?? false) {
          hasBillDownloadAccess =
              await ref.refresh(billDownloadAccessStatusProvider.future);
        }
      }

      if (!isVerified && !hasBillDownloadAccess) {
        return;
      }
    }

    final accountState = ref.read(accountSwitcherProvider);
    final activeAccount = accountState.activeAccount;
    
    
    if (activeAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No active account selected'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final customerNumber = activeAccount.customerNumber;
    final accountNumber = activeAccount.accountNumber;
    
    if (entry.isPayment) {
      
      // Download receipt
      final payment = entry.payment;
      if (payment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment information not available'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      // Get receipt number from referenceNumber, transactionId, or metadata
      // The receipt number might be in referenceNumber, transactionId, or metadata
      String? receiptNumber = payment.referenceNumber;
      
      // If referenceNumber is not available, try to extract from metadata
      if (receiptNumber == null || receiptNumber.isEmpty) {
        if (payment.metadata != null && payment.metadata!.containsKey('receiptNumber')) {
          receiptNumber = payment.metadata!['receiptNumber'] as String?;
        }
      }
      
      // Fallback to transactionId if still not available
      if (receiptNumber == null || receiptNumber.isEmpty) {
        receiptNumber = payment.transactionId;
      }
      
      if (receiptNumber.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receipt number not available'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }


      await DownloadService.downloadReceipt(
        context: context,
        receiptNumber: receiptNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        receiptDisplayName: 'Receipt #$receiptNumber',
      );
    } else {
      
      // Download bill
      final bill = entry.bill;
      String? billNumber;
      
      if (bill != null) {
          billNumber = bill.billNumber;
      } else {
        
        // Try to extract bill number from subDescription (which contains referenceNumber for bills)
        if (entry.subDescription != null && entry.subDescription!.isNotEmpty) {
          billNumber = entry.subDescription;
        } else {
          // Try to extract from entry ID if it contains bill number
          if (entry.id.startsWith('bill_')) {
            // For fallback bills, ID is 'bill_${bill.id}', but we need billNumber
            // This won't work, so we need another approach
          }
          
          // Last resort: try to find bill in widget.bills by matching date or amount
          
          try {
            final matchingBill = widget.bills.firstWhere(
              (b) => b.issueDate.year == entry.date.year &&
                     b.issueDate.month == entry.date.month &&
                     (b.amounts.totalAmount - entry.amount).abs() < 0.01,
            );
            billNumber = matchingBill.billNumber;
          } catch (e) {
          }
        }
      }

      if (billNumber == null || billNumber.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bill information not available'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }


      await DownloadService.downloadBill(
        context: context,
        billNumber: billNumber,
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        billDisplayName: 'Bill #$billNumber',
      );
    }
    
  }
}

