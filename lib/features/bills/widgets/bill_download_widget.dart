import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/bill.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class BillDownloadWidget extends ConsumerStatefulWidget {
  const BillDownloadWidget({
    super.key,
    this.bills = const [],
    this.isLoading = false,
    this.onDownload,
  });

  final List<Bill> bills;
  final bool isLoading;
  final Function(Bill bill)? onDownload;

  @override
  ConsumerState<BillDownloadWidget> createState() => _BillDownloadWidgetState();
}

class _BillDownloadWidgetState extends ConsumerState<BillDownloadWidget> {
  final Map<String, bool> _downloadingBills = {};

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.download, color: AppColors.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Download Bills',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              if (widget.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.spacing32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (widget.bills.isEmpty)
                _buildEmptyState(context)
              else
                _buildDownloadList(context),
            ],
          ),
        ),
      );

  Widget _buildEmptyState(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing32),
          child: Column(
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppTheme.spacing16),
              Text(
                'No bills available',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Bills will appear here when available',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
        ),
      );

  Widget _buildDownloadList(BuildContext context) => Column(
        children: [
          _buildDownloadOptions(context),
          const SizedBox(height: AppTheme.spacing16),
          _buildRecentBills(context),
        ],
      );

  Widget _buildDownloadOptions(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Download Options',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _downloadLatestBill,
                    icon: const Icon(Icons.download),
                    label: const Text('Latest Bill'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _downloadAllBills,
                    icon: const Icon(Icons.download_for_offline),
                    label: const Text('All Bills'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildRecentBills(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Bills',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.bills.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) => _buildBillDownloadItem(context, widget.bills[index]),
          ),
        ],
      );

  Widget _buildBillDownloadItem(BuildContext context, Bill bill) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: _buildBillIcon(bill),
        title: Text(
          _formatBillingPeriod(bill.billingPeriod),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppTheme.spacing4),
            Text(
              'Bill #${bill.billNumber} • \$${bill.amounts.totalAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              'Due: ${_formatDate(bill.dueDate)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ],
        ),
        trailing: _buildDownloadButton(bill),
      );

  Widget _buildBillIcon(Bill bill) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getStatusColor(bill.paymentStatus).withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Icon(
          Icons.receipt_long,
          color: _getStatusColor(bill.paymentStatus),
          size: 20,
        ),
      );

  Widget _buildDownloadButton(Bill bill) {
    final isDownloading = _downloadingBills[bill.id] ?? false;
    
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: isDownloading ? null : () => _downloadBill(bill),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
        ),
        child: isDownloading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text('Download'),
      ),
    );
  }

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return AppColors.success;
      case PaymentStatus.overdue:
        return AppColors.error;
      case PaymentStatus.dueSoon:
        return AppColors.warning;
      case PaymentStatus.pending:
        return AppColors.textSecondary;
      case PaymentStatus.processing:
        return AppColors.primary;
      case PaymentStatus.failed:
        return AppColors.error;
      case PaymentStatus.cancelled:
        return AppColors.textTertiary;
      case PaymentStatus.refunded:
        return AppColors.info;
    }
  }

  String _formatBillingPeriod(BillingPeriod period) {
    final startMonth = _getMonthName(period.startDate.month);
    final endMonth = _getMonthName(period.endDate.month);
    final year = period.startDate.year;
    
    if (startMonth == endMonth) {
      return '$startMonth $year';
    } else {
      return '$startMonth - $endMonth $year';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 0) {
      return 'In $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }

  Future<void> _downloadBill(Bill bill) async {
    setState(() {
      _downloadingBills[bill.id] = true;
    });

    try {
      // Simulate download process
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success/failure (95% success rate)
      if (DateTime.now().millisecond % 20 < 19) {
        _showDownloadSuccess(bill);
        widget.onDownload?.call(bill);
      } else {
        throw Exception('Download failed');
      }
    } catch (e) {
      _showDownloadError(e.toString());
    } finally {
      setState(() {
        _downloadingBills[bill.id] = false;
      });
    }
  }

  Future<void> _downloadLatestBill() async {
    if (widget.bills.isEmpty) return;
    
    final latestBill = widget.bills.first;
    await _downloadBill(latestBill);
  }

  Future<void> _downloadAllBills() async {
    if (widget.bills.isEmpty) return;

    // Download all bills sequentially
    for (final bill in widget.bills) {
      await _downloadBill(bill);
      // Small delay between downloads
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void _showDownloadSuccess(Bill bill) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bill #${bill.billNumber} downloaded successfully'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Open downloaded file
          },
        ),
      ),
    );
  }

  void _showDownloadError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Download failed: $error'),
        backgroundColor: AppColors.error,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Implement retry logic
          },
        ),
      ),
    );
  }
}
