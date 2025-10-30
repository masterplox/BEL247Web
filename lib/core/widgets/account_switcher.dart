import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/account.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../providers/feature_providers.dart';

/// Account switcher card displayed in the sidebar
class AccountSwitcherCard extends ConsumerWidget {
  const AccountSwitcherCard({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountSwitcherProvider);
    final activeAccount = accountState.activeAccount;

    if (activeAccount == null) {
      return const SizedBox.shrink();
    }

    if (!isExpanded) {
      // Collapsed state - just show icon
      return Container(
        margin: const EdgeInsets.all(AppTheme.spacing8),
        padding: const EdgeInsets.all(AppTheme.spacing8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Center(
          child: Icon(
            activeAccount.accountType == 'commercial' 
                ? Icons.business 
                : Icons.home,
            color: AppColors.primary,
            size: 24,
          ),
        ),
      );
    }

    // Expanded state - show full card
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Account',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showAccountSwitcherDialog(context, ref),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(
                    color: AppColors.primaryLight.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        activeAccount.accountType == 'commercial' 
                            ? Icons.business 
                            : Icons.home,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    // Account details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activeAccount.formattedAccountNumber,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Text(
                            activeAccount.address,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Dropdown indicator
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAccountSwitcherDialog(BuildContext context, WidgetRef ref) {
    final accountState = ref.read(accountSwitcherProvider);
    final accounts = accountState.accounts;

    showDialog(
      context: context,
      builder: (context) => _AccountSwitcherDialog(
        accounts: accounts,
        activeAccountId: accountState.activeAccountId,
      ),
    );
  }
}

/// Account switcher dialog
class _AccountSwitcherDialog extends ConsumerWidget {
  const _AccountSwitcherDialog({
    required this.accounts,
    required this.activeAccountId,
  });

  final List<Account> accounts;
  final String activeAccountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Switch Account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ),
            // Accounts list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(AppTheme.spacing16),
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  final isSelected = account.id == activeAccountId;

                  return _AccountCard(
                    account: account,
                    isSelected: isSelected,
                    onTap: () {
                      ref.read(accountSwitcherProvider.notifier).switchAccount(account.id);
                      Navigator.of(context).pop();
                      // TODO: Refresh data for the new account
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
}

/// Individual account card in the dialog
class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.account,
    required this.isSelected,
    required this.onTap,
  });

  final Account account;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacing12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              border: isSelected
                  ? Border.all(
                      color: AppColors.primary,
                      width: 2,
                    )
                  : Border.all(
                      color: AppColors.border,
                      width: 1,
                    ),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    // Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: account.accountType == 'commercial'
                            ? const Color(0xFF8B5CF6).withOpacity(0.1)
                            : AppColors.primaryLight.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                      child: Icon(
                        account.accountType == 'commercial' 
                            ? Icons.business 
                            : Icons.home,
                        color: account.accountType == 'commercial'
                            ? const Color(0xFF8B5CF6)
                            : AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    // Account details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                account.formattedAccountNumber,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(width: AppTheme.spacing8),
                              // Status tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacing8,
                                  vertical: AppTheme.spacing4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(account.statusColor),
                                  borderRadius: BorderRadius.circular(AppTheme.radius4),
                                ),
                                child: Text(
                                  account.status.name.toUpperCase(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Text(
                            account.address,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Text(
                            '${account.accountType.substring(0, 1).toUpperCase()}${account.accountType.substring(1)} • Balance: BZ\$${account.balance.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Selected indicator
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
}

