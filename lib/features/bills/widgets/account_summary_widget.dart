import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class AccountSummaryWidget extends ConsumerWidget {
  const AccountSummaryWidget({
    super.key,
    required this.accountBalance,
    required this.usageSummary,
    this.isLoading = false,
    this.onRefresh,
  });

  final AccountBalance accountBalance;
  final UsageSummary usageSummary;
  final bool isLoading;
  final VoidCallback? onRefresh;

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
                  const Icon(Icons.account_balance_wallet, color: AppColors.primary),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    'Account Summary',
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
              else
                _buildAccountContent(context),
            ],
          ),
        ),
      );

  Widget _buildAccountContent(BuildContext context) => Column(
        children: [
          _buildCurrentBalance(context),
          const SizedBox(height: AppTheme.spacing16),
          _buildPaymentInfo(context),
          const SizedBox(height: AppTheme.spacing16),
          _buildYTDSummary(context),
        ],
      );

  Widget _buildCurrentBalance(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: _getBalanceColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(
            color: _getBalanceColor().withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getBalanceIcon(),
              color: _getBalanceColor(),
              size: 32,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Balance',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'BZ\$${accountBalance.currentBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ],
              ),
            ),
            _buildBalanceStatusChip(context),
          ],
        ),
      );

  Widget _buildPaymentInfo(BuildContext context) => Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              context,
              'Past due',
              'BZ\$${accountBalance.lastPaymentAmount.toStringAsFixed(2)}',
              _formatDate(accountBalance.lastPaymentDate),
              Icons.payment,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: _buildInfoItem(
              context,
              'Next Due',
              _formatDate(accountBalance.nextDueDate),
              _getDaysUntilDue(),
              Icons.schedule,
            ),
          ),
        ],
      );

  Widget _buildYTDSummary(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Year to Date',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Usage',
                    '${usageSummary.yearToDate.kwh.toStringAsFixed(0)} kWh',
                  ),
                ),
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Cost',
                    'BZ\$${usageSummary.yearToDate.cost.toStringAsFixed(2)}',
                  ),
                ),
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Avg Daily',
                    '${usageSummary.yearToDate.averageDaily.toStringAsFixed(1)} kWh',
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String value,
    String subtitle,
    IconData icon,
  ) =>
      Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: AppTheme.spacing4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );

  Widget _buildYTDItem(BuildContext context, String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      );

  Widget _buildBalanceStatusChip(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing4,
        ),
        decoration: BoxDecoration(
          color: _getBalanceColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius4),
          border: Border.all(
            color: _getBalanceColor().withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          _getBalanceStatusText(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getBalanceColor(),
          ),
        ),
      );

  Color _getBalanceColor() {
    if (accountBalance.currentBalance > 0) {
      return AppColors.error; // Positive balance means we owe money
    } else if (accountBalance.currentBalance < 0) {
      return AppColors.success; // Negative balance means credit
    } else {
      return AppColors.textSecondary; // Zero balance
    }
  }

  IconData _getBalanceIcon() {
    if (accountBalance.currentBalance > 0) {
      return Icons.warning;
    } else if (accountBalance.currentBalance < 0) {
      return Icons.check_circle;
    } else {
      return Icons.account_balance_wallet;
    }
  }

  String _getBalanceStatusText() {
    if (accountBalance.currentBalance > 0) {
      return 'Amount Due';
    } else if (accountBalance.currentBalance < 0) {
      return 'Credit';
    } else {
      return 'Current';
    }
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

  String _getDaysUntilDue() {
    final now = DateTime.now();
    final difference = accountBalance.nextDueDate.difference(now).inDays;
    
    if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else if (difference > 0) {
      return 'Due in $difference days';
    } else {
      return 'Overdue by ${difference.abs()} days';
    }
  }
}
