import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/account_verification_providers.dart';
import '../../../core/providers/feature_providers.dart';
import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../data/models/account.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../features/bills/state/bills_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Balance card widget matching the React version design
class BalanceCardWidget extends ConsumerStatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  ConsumerState<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends ConsumerState<BalanceCardWidget> {
  bool _showBalance = true;

  @override
  Widget build(BuildContext context) {
    final accountDetailsAsync = ref.watch(accountDetailsProvider);
    final accountState = ref.watch(accountSwitcherProvider);
    final activeAccount = accountState.activeAccount;
    final verificationAsync = ref.watch(accountVerificationStatusProvider);
    final isVerified = verificationAsync.maybeWhen(
      data: (v) => v,
      orElse: () => false,
    );

    return accountDetailsAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (_, __) => _buildErrorCard(context),
      data: (accountDetails) {
        if (accountDetails == null || activeAccount == null) {
          return const SizedBox.shrink();
        }

        final balance = _parseBalance(accountDetails.balance);
        final pastDue = _parseBalance(accountDetails.pastDue);
        final lastBillAmount = _parseBalance(accountDetails.lastBillAmount);
        final lastPaymentAmount = _parseBalance(accountDetails.lastPaymentAmount);
        final status = activeAccount.status;
        final dueInText = _dueInLabel(accountDetails.dueIn);
        final statusLabel = status == AccountStatus.paid
            ? 'Paid'
            : dueInText.isNotEmpty
                ? dueInText
                : (status == AccountStatus.overdue ? 'Overdue' : 'Due');
        final statusColor = status == AccountStatus.paid
            ? AppColors.success
            : status == AccountStatus.overdue
                ? AppColors.error
                : AppColors.warning;

        return AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          showBorder: true,
          borderWidth: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Section (stack chip below on narrow widths to avoid overflow)
              LayoutBuilder(
                builder: (context, constraints) {
                  final balanceColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your balance',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              _showBalance ? _formatBalance(balance) : '••••••',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacing8),
                          IconButton(
                            icon: Icon(
                              _showBalance ? Icons.visibility_off : Icons.visibility,
                              size: 16,
                            ),
                            onPressed: () => setState(() => _showBalance = !_showBalance),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      if (isVerified &&
                          (accountDetails.collectionStatus ?? '').isNotEmpty) ...[
                        const SizedBox(height: AppTheme.spacing4),
                        Text(
                          accountDetails.collectionStatus!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ],
                  );

                  final statusChip = Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8,
                      vertical: AppTheme.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (status != AccountStatus.paid)
                          Padding(
                            padding: const EdgeInsets.only(right: AppTheme.spacing4),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 12,
                              color: statusColor,
                            ),
                          ),
                        Text(
                          statusLabel,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: statusColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );

                  final narrow = constraints.maxWidth < 420;
                  if (narrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        balanceColumn,
                        const SizedBox(height: AppTheme.spacing12),
                        statusChip,
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: balanceColumn),
                      const SizedBox(width: AppTheme.spacing8),
                      statusChip,
                    ],
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacing16),
              const Divider(height: 1),
              const SizedBox(height: AppTheme.spacing16),

              // Quick Stats
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < AppTheme.tabletBreakpoint;
                  final dueDate = accountDetails.dueDate ?? '';
                  if (isMobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildStatButton(
                          context,
                          'Electricity bill this month',
                          FormattingUtils.formatCurrency(lastBillAmount),
                          Icons.description,
                          () => _showBillDetailsDialog(
                            context,
                            accountDetails,
                          ),
                          dueLabel: 'Due:',
                          dueValue: dueDate,
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildStatButton(
                          context,
                          'Past due',
                          FormattingUtils.formatCurrency(pastDue),
                          Icons.schedule,
                          null,
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        _buildStatButton(
                          context,
                          'Last Payment',
                          FormattingUtils.formatCurrency(lastPaymentAmount),
                          Icons.payment,
                          () => _showPaymentDetailsDialog(context, accountDetails),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatButton(
                              context,
                              'Electricity bill this month',
                              FormattingUtils.formatCurrency(lastBillAmount),
                              Icons.description,
                              () => _showBillDetailsDialog(
                                context,
                                accountDetails,
                              ),
                              dueLabel: 'Due:',
                              dueValue: dueDate,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacing12),
                          Expanded(
                            child: _buildStatButton(
                              context,
                              'Last Payment',
                              FormattingUtils.formatCurrency(lastPaymentAmount),
                              Icons.payment,
                              () => _showPaymentDetailsDialog(context, accountDetails),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatButton(
                              context,
                              'Past due',
                              FormattingUtils.formatCurrency(pastDue),
                              Icons.schedule,
                              null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Pay Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Kept intentionally for upcoming rollout:
                    // final accountBalance = user_models.AccountBalance(...);
                    // PaymentDialogWidget.showBottom/showCenter(...);
                    AppDialog.showCenter(
                      context: context,
                      title: 'Coming soon',
                      subtitle: 'Online dashboard payments are being finalized.',
                      content: const Text(
                        'This feature will be available in a future update.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.credit_card, size: 16),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        'Pay ${_formatBalance(balance)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingCard(BuildContext context) => const AppCard(
      padding: EdgeInsets.all(AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

  Widget _buildErrorCard(BuildContext context) => AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Center(
        child: Text(
          'Error loading balance',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.error,
              ),
        ),
      ),
    );

  Widget _buildStatButton(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    VoidCallback? onTap, {
    String? dueLabel,
    String? dueValue,
  }) {
    final content = Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          if (dueLabel != null && dueValue != null && dueValue.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing4),
            Row(
              children: [
                Text(
                  '$dueLabel ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
                Text(
                  dueValue,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
          if (onTap != null) ...[
            const SizedBox(height: AppTheme.spacing4),
            Row(
              children: [
                Text(
                  'Details',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
                const SizedBox(width: AppTheme.spacing4),
                const Icon(Icons.chevron_right, size: 12, color: AppColors.textSecondary),
              ],
            ),
          ],
        ],
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        child: content,
      );
    }
    return content;
  }

  /// Format balance: negative values as (amount) CR, positive as normal currency.
  String _formatBalance(double amount) {
    if (amount < 0) {
      final abs = FormattingUtils.formatCurrency(amount.abs());
      return '($abs) CR';
    }
    return FormattingUtils.formatCurrency(amount);
  }

  void _showBillDetailsDialog(
    BuildContext context,
    EditableCustomerAccountDto accountDetails,
  ) {
    final lastBillAmount = _parseBalance(accountDetails.lastBillAmount);
    final pastDue = _parseBalance(accountDetails.pastDue);

    AppDialog.showCenter(
      context: context,
      title: 'Bill Details',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Bill Date', accountDetails.lastBillDate ?? ''),
          const Divider(),
          _buildDetailRow('Bill Amount', FormattingUtils.formatCurrency(lastBillAmount)),
          const Divider(),
          _buildDetailRow(
            'Past Due',
            FormattingUtils.formatCurrency(pastDue),
            color: pastDue > 0 ? AppColors.error : null,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _showPaymentDetailsDialog(BuildContext context, EditableCustomerAccountDto accountDetails) {
    final lastPaymentAmount = _parseBalance(accountDetails.lastPaymentAmount);

    AppDialog.showCenter(
      context: context,
      title: 'Payment History',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Payment Date', accountDetails.lastPaymentDate ?? ''),
          const Divider(),
          _buildDetailRow('Amount Paid', FormattingUtils.formatCurrency(lastPaymentAmount)),
          const Divider(),
          _buildDetailRow('Status', 'Completed', color: AppColors.success),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ],
      ),
    );

  /// Build "Due in X days" (or "Due today" / "X days overdue") from account dueIn.
  String _dueInLabel(String? dueIn) {
    if (dueIn == null || dueIn.isEmpty) return '';
    final days = int.tryParse(dueIn.replaceAll(RegExp(r'[^\d-]'), '').trim());
    if (days == null) return '';
    if (days == 0) return 'Due today';
    if (days > 0) return 'Due in $days days';
    return '${days.abs()} days overdue';
  }

  double _parseBalance(String? balanceStr) {
    if (balanceStr == null || balanceStr.isEmpty) {
      return 0;
    }
    try {
      final isCredit = balanceStr.toUpperCase().contains('CR') ||
          (balanceStr.contains('(') && balanceStr.contains(')'));
      
      final cleaned = balanceStr
          .replaceAll(r'$', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('CR', '')
          .replaceAll(',', '')
          .trim();

      var balance = double.tryParse(cleaned) ?? 0.0;
      
      if (isCredit && balance > 0) {
        balance = -balance;
      }
      
      return balance;
    } catch (e) {
      return 0;
    }
  }
}
