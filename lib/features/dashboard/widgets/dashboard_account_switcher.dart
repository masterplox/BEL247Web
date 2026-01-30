import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/feature_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Simple account switcher button for dashboard header
class DashboardAccountSwitcher extends ConsumerWidget {
  const DashboardAccountSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountSwitcherProvider);
    final activeAccount = accountState.activeAccount;

    if (activeAccount == null) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () => _showAccountSwitcherDialog(context, ref),
      borderRadius: BorderRadius.circular(AppTheme.radius8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(
                activeAccount.accountType == 'commercial' ? Icons.business : Icons.home,
                size: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppTheme.spacing8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activeAccount.nickname ?? activeAccount.displayAddress,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                ),
                Text(
                  '#${activeAccount.accountNumber}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
            const SizedBox(width: AppTheme.spacing8),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountSwitcherDialog(BuildContext context, WidgetRef ref) {
    final accountState = ref.read(accountSwitcherProvider);
    final accounts = accountState.accounts;
    final activeAccountId = accountState.activeAccountId;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Switch Account'),
        content: SizedBox(
          width: 400,
          child: accounts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    final isSelected = account.id == activeAccountId;
                    return ListTile(
                      leading: Icon(
                        account.accountType == 'commercial' ? Icons.business : Icons.home,
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      ),
                      title: Text(account.nickname ?? account.displayAddress),
                      subtitle: Text('#${account.accountNumber}'),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: AppColors.primary)
                          : null,
                      onTap: () {
                        ref.read(accountSwitcherProvider.notifier).switchAccount(account.id);
                        Navigator.of(dialogContext).pop();
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
