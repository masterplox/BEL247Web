import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/account.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../analytics/app_page_names.dart';
import '../providers/engagement_providers.dart';
import '../providers/feature_providers.dart';
import '../providers/meter_data_providers.dart';
import '../utils/logger.dart';
import 'manage_connected_account_dialogs.dart';

const String _kAmiLearnMoreUrl = 'https://bit.ly/AMIbz';

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
    final isAmiMeter = ref.watch(isAmiMeterProvider);

    // Show loading state only if accounts haven't been initialized yet
    // If initialized but empty, we know there are no accounts (don't show loading)
    if (accountState.accounts.isEmpty && !accountState.isInitialized) {
      return Container(
        margin: const EdgeInsets.all(AppTheme.spacing8),
        padding: const EdgeInsets.all(AppTheme.spacing12),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    // If initialized but empty, show nothing (or could show connect button)
    // The main pages will show the empty state with connect button
    if (accountState.accounts.isEmpty && accountState.isInitialized) {
      return const SizedBox.shrink();
    }

    if (activeAccount == null) {
      return const SizedBox.shrink();
    }

    if (!isExpanded) {
      // Collapsed: match [SidebarNavItem] margin/padding and 24px icon so the
      // control aligns with nav icons and nothing clips in the narrow rail.
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing4,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showAccountSwitcherDialog(context, ref),
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing12,
                vertical: AppTheme.spacing12,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                border: Border.all(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: isAmiMeter
                  ? const Badge(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      label: Text(
                        'AMI',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                      child: Icon(
                        Icons.swap_vert_circle,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    )
                  : const Icon(
                      Icons.swap_vert_circle,
                      color: AppColors.primary,
                      size: 24,
                    ),
            ),
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
                  color: AppColors.primaryLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(
                    color: AppColors.primaryLight.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
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
                      child: const Icon(
                    Icons.swap_vert_circle,
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  activeAccount.nickname ?? activeAccount.formattedAccountNumber,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isAmiMeter) ...[
                                const SizedBox(width: AppTheme.spacing8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(AppTheme.radius12),
                                    border: Border.all(
                                      color: AppColors.primary.withValues(alpha: 0.35),
                                    ),
                                  ),
                                  child: Text(
                                    'AMI',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                          letterSpacing: 0.5,
                                        ),
                                  ),
                                ),
                              ],
                            ],
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
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const _AccountSwitcherDialog(),
    );
  }
}

/// Account switcher dialog with search, filters, and sorting
class _AccountSwitcherDialog extends ConsumerStatefulWidget {
  const _AccountSwitcherDialog();

  @override
  ConsumerState<_AccountSwitcherDialog> createState() => _AccountSwitcherDialogState();
}

class _AccountSwitcherDialogState extends ConsumerState<_AccountSwitcherDialog> {
  final TextEditingController _searchController = TextEditingController();
  AccountStatus? _statusFilter;
  AccountSortField _sortField = AccountSortField.none;
  bool _sortAscending = true;
  String _searchQuery = '';
  ConnectedAccountActionResult? _feedback;
  String? _busyAccountId;
  Timer? _feedbackDismissTimer;

  @override
  void dispose() {
    _feedbackDismissTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _applyActionFeedback(ConnectedAccountActionResult? result) {
    _feedbackDismissTimer?.cancel();
    if (result == null || result.isCancelled) {
      if (_feedback != null) {
        setState(() => _feedback = null);
      }
      return;
    }
    setState(() => _feedback = result);
    if (result.isSuccess) {
      _feedbackDismissTimer = Timer(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() => _feedback = null);
        }
      });
    }
  }

  void _dismissFeedback() {
    _feedbackDismissTimer?.cancel();
    setState(() => _feedback = null);
  }

  Future<void> _handleEditNickname(Account account) async {
    setState(() => _busyAccountId = account.id);
    final result = await showEditAccountNicknameDialog(context, ref, account);
    if (!mounted) return;
    setState(() => _busyAccountId = null);
    _applyActionFeedback(result);
  }

  Future<void> _handleRemoveAccount(Account account) async {
    setState(() => _busyAccountId = account.id);
    final result = await showRemoveConnectedAccountDialog(context, ref, account);
    if (!mounted) return;
    setState(() => _busyAccountId = null);
    _applyActionFeedback(result);
  }

  List<Account> _getFilteredAndSortedAccounts(List<Account> accounts) {
    // Apply search filter
    var filtered = accounts.where((account) {
      if (_searchQuery.isEmpty) return true;
      
      final query = _searchQuery.toLowerCase();
      return account.address.toLowerCase().contains(query) ||
          account.customerNumber.toLowerCase().contains(query) ||
          account.accountNumber.toLowerCase().contains(query) ||
          account.accountType.toLowerCase().contains(query) ||
          (account.nickname != null && account.nickname!.toLowerCase().contains(query));
    }).toList();

    // Apply status filter
    if (_statusFilter != null) {
      filtered = filtered.where((account) => account.status == _statusFilter).toList();
    }

    // Apply sorting
    if (_sortField != AccountSortField.none) {
      filtered.sort((a, b) {
        int comparison = 0;
        switch (_sortField) {
          case AccountSortField.balance:
            comparison = a.balance.compareTo(b.balance);
            break;
          case AccountSortField.address:
            comparison = a.address.compareTo(b.address);
            break;
          case AccountSortField.accountNumber:
            comparison = a.accountNumber.compareTo(b.accountNumber);
            break;
          case AccountSortField.customerNumber:
            comparison = a.customerNumber.compareTo(b.customerNumber);
            break;
          case AccountSortField.accountType:
            comparison = a.accountType.compareTo(b.accountType);
            break;
          case AccountSortField.none:
            return 0;
        }
        return _sortAscending ? comparison : -comparison;
      });
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountSwitcherProvider);
    final accounts = accountState.accounts;
    final activeAccountId = accountState.activeAccountId;

    // Show loading state only if accounts haven't been initialized yet
    // If initialized but empty, we know there are no accounts (show empty state in dialog)
    if (accounts.isEmpty && !accountState.isInitialized) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(AppTheme.spacing32),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: AppTheme.spacing16),
              Text('Loading accounts...'),
            ],
          ),
        ),
      );
    }

    final filteredAccounts = _getFilteredAndSortedAccounts(accounts);

    final screenW = MediaQuery.sizeOf(context).width;
    final screenH = MediaQuery.sizeOf(context).height;
    final dialogMaxW = screenW > 624 ? 600.0 : (screenW - 24).clamp(280.0, 600.0);
    final dialogMaxH = screenH * 0.9 < 700 ? screenH * 0.9 : 700.0;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Container(
        width: dialogMaxW,
        constraints: BoxConstraints(maxHeight: dialogMaxH),
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ),
            if (_feedback != null)
              _AccountSwitcherFeedbackBar(
                result: _feedback!,
                onDismiss: _dismissFeedback,
              ),
            // Search field
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by address, customer number, account number, nickname, or type...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                  ),
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            // Filters and Sorting (label + wrap so narrow screens don't overflow)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Status:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Wrap(
                    spacing: AppTheme.spacing8,
                    runSpacing: AppTheme.spacing8,
                    children: [
                      _StatusChip(
                        label: 'All',
                        isSelected: _statusFilter == null,
                        onTap: () => setState(() => _statusFilter = null),
                      ),
                      _StatusChip(
                        label: 'Paid',
                        isSelected: _statusFilter == AccountStatus.paid,
                        onTap: () => setState(() => _statusFilter = AccountStatus.paid),
                        color: AppColors.success,
                      ),
                      _StatusChip(
                        label: 'Due',
                        isSelected: _statusFilter == AccountStatus.due,
                        onTap: () => setState(() => _statusFilter = AccountStatus.due),
                        color: AppColors.warning,
                      ),
                      _StatusChip(
                        label: 'Overdue',
                        isSelected: _statusFilter == AccountStatus.overdue,
                        onTap: () => setState(() => _statusFilter = AccountStatus.overdue),
                        color: AppColors.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Text(
                    'Sort by:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Wrap(
                    spacing: AppTheme.spacing4,
                    runSpacing: AppTheme.spacing8,
                    children: [
                      _SortButton(
                        icon: Icons.account_balance_wallet,
                        label: 'Balance',
                        isActive: _sortField == AccountSortField.balance,
                        isAscending: _sortAscending,
                        onTap: () {
                          setState(() {
                            if (_sortField == AccountSortField.balance) {
                              _sortAscending = !_sortAscending;
                            } else {
                              _sortField = AccountSortField.balance;
                              _sortAscending = true;
                            }
                          });
                        },
                      ),
                      _SortButton(
                        icon: Icons.location_on,
                        label: 'Address',
                        isActive: _sortField == AccountSortField.address,
                        isAscending: _sortAscending,
                        onTap: () {
                          setState(() {
                            if (_sortField == AccountSortField.address) {
                              _sortAscending = !_sortAscending;
                            } else {
                              _sortField = AccountSortField.address;
                              _sortAscending = true;
                            }
                          });
                        },
                      ),
                      _SortButton(
                        icon: Icons.numbers,
                        label: 'Account #',
                        isActive: _sortField == AccountSortField.accountNumber,
                        isAscending: _sortAscending,
                        onTap: () {
                          setState(() {
                            if (_sortField == AccountSortField.accountNumber) {
                              _sortAscending = !_sortAscending;
                            } else {
                              _sortField = AccountSortField.accountNumber;
                              _sortAscending = true;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // Accounts list
            Expanded(
              child: filteredAccounts.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppTheme.spacing32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: AppColors.textSecondary.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: AppTheme.spacing16),
                          Text(
                            'No accounts found',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                      itemCount: filteredAccounts.length,
                      itemBuilder: (context, index) {
                        final account = filteredAccounts[index];
                        final isSelected = account.id == activeAccountId;

                        return _AccountCard(
                          account: account,
                          isSelected: isSelected,
                          menuEnabled: _busyAccountId == null,
                          isBusy: _busyAccountId == account.id,
                          onTap: _busyAccountId == null
                              ? () {
                                  ref
                                      .read(accountSwitcherProvider.notifier)
                                      .switchAccount(account.id);
                                  Navigator.of(context, rootNavigator: true).pop();
                                }
                              : null,
                          onEditNickname: () => _handleEditNickname(account),
                          onRemove: () => _handleRemoveAccount(account),
                        );
                      },
                    ),
            ),
            // Sticky Connect Account Button
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(
                  top: BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showConnectAccountDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Connect Account'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConnectAccountDialog(BuildContext context, WidgetRef ref) {
    String page = AppPageNames.unknown;
    try {
      final matchedLocation = GoRouterState.of(context).matchedLocation;
      page = AppPageNames.navigationSubtypeForRoute(matchedLocation);
    } catch (_) {
      page = AppPageNames.unknown;
    }
    ref.read(deviceEventsRepositoryProvider).logInteractionDialogOpen(
          currentPageName: page,
          dialogDetails: AppPageNames.connectCustomerAccount,
        );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ConnectAccountFormDialog(
        onSuccess: () async {
          // Refresh accounts after successful connection
          final accountsRepo = ref.read(accountsRepositoryProvider);
          try {
            final accounts = await accountsRepo.fetchConnectedAccounts();
            ref.read(accountSwitcherProvider.notifier).initializeAccounts(accounts);
          } catch (e) {
            Logger.error('Failed to refresh accounts after connection', error: e);
          }
        },
      ),
    );
  }
}

/// Status filter chip
class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (color ?? AppColors.primary).withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius16),
          border: Border.all(
            color: isSelected
                ? (color ?? AppColors.primary)
                : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? (color ?? AppColors.primary)
                    : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
        ),
      ),
    );
}

/// Sort button with up/down icons
class _SortButton extends StatelessWidget {
  const _SortButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isAscending,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final bool isAscending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radius8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing8,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppTheme.spacing4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isActive ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            if (isActive) ...[
              const SizedBox(width: AppTheme.spacing4),
              Icon(
                isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: AppColors.primary,
              ),
            ],
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
    required this.onEditNickname,
    required this.onRemove,
    this.onTap,
    this.menuEnabled = true,
    this.isBusy = false,
  });

  final Account account;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback onEditNickname;
  final VoidCallback onRemove;
  final bool menuEnabled;
  final bool isBusy;

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          child: Opacity(
            opacity: isBusy ? 0.55 : 1,
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
                            ? const Color(0xFF8B5CF6).withValues(alpha: 0.1)
                            : AppColors.primaryLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radius8),
                      ),
                      child: const Icon(
                    Icons.swap_vert_circle,
                        // color: account.accountType == 'commercial'
                        //     ? const Color(0xFF8B5CF6)
                        //     : AppColors.primary,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  account.nickname ?? account.formattedAccountNumber,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                            '${account.customerNumber}:${account.accountNumber}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
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
                    PopupMenuButton<String>(
                      enabled: menuEnabled,
                      icon: Icon(
                        Icons.more_vert,
                        color: menuEnabled
                            ? AppColors.textSecondary
                            : AppColors.textSecondary.withValues(alpha: 0.4),
                      ),
                      onSelected: menuEnabled
                          ? (value) {
                              if (value == 'edit') {
                                onEditNickname();
                              } else if (value == 'remove') {
                                onRemove();
                              }
                            }
                          : null,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Edit nickname'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'remove',
                          child: ListTile(
                            leading: Icon(Icons.delete_outline, color: AppColors.error),
                            title: Text(
                              'Remove account',
                              style: TextStyle(color: AppColors.error),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Selected indicator
                if (isBusy)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
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
      ),
    );
}

/// Success/error banner shown inside the switch-account dialog (not snackbars).
class _AccountSwitcherFeedbackBar extends StatelessWidget {
  const _AccountSwitcherFeedbackBar({
    required this.result,
    required this.onDismiss,
  });

  final ConnectedAccountActionResult result;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final isSuccess = result.isSuccess;
    final color = isSuccess ? AppColors.success : AppColors.error;

    return Material(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing12,
        ),
        child: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle_outline : Icons.error_outline,
              color: color,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacing8),
            Expanded(
              child: Text(
                result.message ??
                    (isSuccess ? 'Changes saved' : 'Something went wrong'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Connect Account Form Dialog
class _ConnectAccountFormDialog extends ConsumerStatefulWidget {
  const _ConnectAccountFormDialog({required this.onSuccess});

  final Future<void> Function() onSuccess;

  @override
  ConsumerState<_ConnectAccountFormDialog> createState() => _ConnectAccountFormDialogState();
}

class _ConnectAccountFormDialogState extends ConsumerState<_ConnectAccountFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _customerNumberController = TextEditingController();
  final _accountNumberHintController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String? _connectedAccountNumber;
  bool _isSuccess = false;
  late final TapGestureRecognizer _amiLearnMoreTap;

  @override
  void initState() {
    super.initState();
    _amiLearnMoreTap = TapGestureRecognizer()..onTap = _openAmiLearnMore;
  }

  @override
  void dispose() {
    _customerNumberController.dispose();
    _accountNumberHintController.dispose();
    _nicknameController.dispose();
    _amiLearnMoreTap.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final accountsRepo = ref.read(accountsRepositoryProvider);
      final response = await accountsRepo.connectAccount(
        customerNumber: _customerNumberController.text.trim(),
        accountNumberHint: _accountNumberHintController.text.trim(),
        nickName: _nicknameController.text.trim(),
      );

      if (response.isSuccess) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
          _successMessage = response.message ?? 'Account connected successfully!';
          _connectedAccountNumber =
              response.editableCustomerAccount.accountNumber?.trim();
        });
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = response.message ?? 'Failed to connect account.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        // _errorMessage = e.toString().replaceAll('Exception: ', '');
         _errorMessage = _extractConnectAccountErrorMessage(e);
      });
    }
  }
  Future<void> _handleSuccessOkay() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onSuccess();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _openAmiLearnMore() async {
    final uri = Uri.parse(_kAmiLearnMoreUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  String _extractConnectAccountErrorMessage(Object error) {
    // Prefer backend-provided `message` when available.
    if (error is DioException) {
      final data = error.response?.data;

      if (data is Map) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message.trim();
        }
      }

      if (data is String) {
        try {
          final decoded = jsonDecode(data);
          if (decoded is Map) {
            final message = decoded['message'];
            if (message is String && message.trim().isNotEmpty) {
              return message.trim();
            }
          }
        } catch (_) {
          // Ignore JSON parse errors and fall back.
        }
      }

      // Fallback to Dio's message if present.
      final msg = error.message;
      if (msg != null && msg.trim().isNotEmpty) {
        return msg.trim();
      }
    }

    // Generic fallback: strip "Exception: " prefix if present.
    return error.toString().replaceAll('Exception: ', '').trim();
  }

  @override
  Widget build(BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'Connect Account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_isSuccess) {
                              _handleSuccessOkay();
                            } else {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing24),
              if (_isSuccess) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    border: Border.all(color: AppColors.success),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.success),
                      const SizedBox(width: AppTheme.spacing8),
                      Expanded(
                        child: Text(
                          _successMessage ?? 'Account connected successfully!',
                          style: const TextStyle(color: AppColors.success),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacing12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    border: Border.all(
                      color: AppColors.info.withValues(alpha: 0.45),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                      children: [
                        const TextSpan(
                          text:
                              'Detailed energy usage insights are available only for Customers with AMI meters. ',
                        ),
                        TextSpan(
                          text:
                              'After Account#${_connectedAccountNumber?.isNotEmpty ?? false ? _connectedAccountNumber : 'this account'} is updated with an AMI meter, these features will become available unlocking deeper insights and new ways to understand and manage your energy use. Learn More: ',
                        ),
                        TextSpan(
                          text: 'bit.ly/AMIbz',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                              ),
                          recognizer: _amiLearnMoreTap,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacing24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleSuccessOkay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white,
                                ),
                              ),
                            )
                          : const Text('Okay'),
                    ),
                  ],
                ),
              ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: AppColors.warning),
                ),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                    children: const [
                      TextSpan(text: 'This account will be added at '),
                      TextSpan(
                        text: 'Basic Level',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '. You may upgrade to the ',
                      ),
                      TextSpan(
                        text: 'Premium Level',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' once it has been added.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Customer Number
              TextFormField(
                controller: _customerNumberController,
                decoration: const InputDecoration(
                  labelText: 'Customer Number',
                  hintText: 'Enter customer number',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Customer number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Account Number (Last 5 digits)
              TextFormField(
                controller: _accountNumberHintController,
                decoration: const InputDecoration(
                  labelText: 'Account number (Last 5 digits)',
                  hintText: 'Enter last 5 digits',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                  helperText: 'Maximum 5 digits',
                ),
                keyboardType: TextInputType.number,
                maxLength: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Last 5 digits are required';
                  }
                  if (value.trim().length > 5) {
                    return 'Maximum 5 digits allowed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Nickname
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  hintText: 'Enter a nickname for this account',
                  prefixIcon: Icon(Icons.label),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nickname is required';
                  }
                  return null;
                },
              ),
              // Error message
              if (_errorMessage != null) ...[
                const SizedBox(height: AppTheme.spacing16),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    border: Border.all(color: AppColors.error),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error),
                      const SizedBox(width: AppTheme.spacing8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppTheme.spacing24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                            ),
                          )
                        : const Text('Connect'),
                  ),
                ],
              ),
              ],
            ],
          ),
        ),
      ),
    );
}

/// Enum for account sort fields
enum AccountSortField {
  none,
  balance,
  address,
  accountNumber,
  customerNumber,
  accountType,
}
