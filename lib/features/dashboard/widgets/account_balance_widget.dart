import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

class AccountBalanceWidget extends StatelessWidget {
  const AccountBalanceWidget({
    super.key,
    required this.accountBalance,
    this.isLoading = false,
    this.onRefresh,
  });

  final AccountBalance accountBalance;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: const Border(
            left: BorderSide(
              color: AppColors.primary,
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Account Balance',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              // Last updated
              Text(
                'Last updated: ${_formatLastUpdated()}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    // Balance amount
                    Text(
                      'BZ\$${_formatAmount(accountBalance.currentBalance)}',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: accountBalance.currentBalance > 0
                            ? AppColors.success
                            : AppColors.error,
                        borderRadius: BorderRadius.circular(AppTheme.radius4),
                      ),
                      child: Text(
                        accountBalance.currentBalance > 0 ? 'Paid' : 'Due',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );

  String _formatAmount(double amount) => amount.abs().toStringAsFixed(2);

  String _formatLastUpdated() {
    final now = DateTime.now();
    final format = DateFormat('d MMM, HH:mm');
    return format.format(now);
  }
}
