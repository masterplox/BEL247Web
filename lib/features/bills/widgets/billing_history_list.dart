import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/bill.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class BillingHistoryList extends ConsumerWidget {
  const BillingHistoryList({
    super.key,
    this.bills = const [],
    this.isLoading = false,
    this.onRefresh,
    this.onBillTap,
  });

  final List<Bill> bills;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final Function(Bill)? onBillTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
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
                  const Icon(Icons.history, color: AppColors.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Billing History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  if (onRefresh != null)
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: isLoading ? null : onRefresh,
                    ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.spacing32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (bills.isEmpty)
                _buildEmptyState(context)
              else
                _buildBillsList(context),
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
                'No bills found',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Your billing history will appear here',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
        ),
      );

  Widget _buildBillsList(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bills.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => _buildBillItem(context, bills[index]),
      );

  Widget _buildBillItem(BuildContext context, Bill bill) => ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () => onBillTap?.call(bill),
        leading: _buildStatusIndicator(bill.paymentStatus),
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
              'Due: ${_formatDate(bill.dueDate)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              'Bill #${bill.billNumber}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              // Dollar amounts are hidden in this version. They will be shown in a future release.
              // r'$' '${bill.amounts.totalAmount.toStringAsFixed(2)}',
              '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getAmountColor(bill.paymentStatus),
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            _buildStatusChip(bill.paymentStatus),
          ],
        ),
      );

  Widget _buildStatusIndicator(PaymentStatus status) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: _getStatusColor(status),
          shape: BoxShape.circle,
        ),
      );

  Widget _buildStatusChip(PaymentStatus status) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing4,
        ),
        decoration: BoxDecoration(
          color: _getStatusColor(status).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius4),
          border: Border.all(
            color: _getStatusColor(status).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          _getStatusText(status),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getStatusColor(status),
          ),
        ),
      );

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

  Color _getAmountColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return AppColors.success;
      case PaymentStatus.overdue:
        return AppColors.error;
      case PaymentStatus.dueSoon:
        return AppColors.warning;
      default:
        return AppColors.textPrimary;
    }
  }

  String _getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return 'Paid';
      case PaymentStatus.overdue:
        return 'Overdue';
      case PaymentStatus.dueSoon:
        return 'Due Soon';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
      case PaymentStatus.refunded:
        return 'Refunded';
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
}
