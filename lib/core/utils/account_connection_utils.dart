import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/accounts_repository.dart';
import '../../features/bills/state/bills_providers.dart' as bills;
import '../../features/dashboard/state/dashboard_providers.dart' as dashboard;
import '../../features/usage/state/meter_readings_providers.dart' as usage;
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../providers/feature_providers.dart';
import '../utils/logger.dart';

/// Show connect account dialog and refresh all data after successful connection
Future<void> showConnectAccountDialogAndRefresh(
  BuildContext context,
  WidgetRef ref,
) async {
  await showDialog(
    context: context,
    builder: (context) => _ConnectAccountFormDialog(
      onSuccess: () async {
        // Refresh accounts after successful connection
        final accountsRepo = ref.read(accountsRepositoryProvider);
        try {
          Logger.info('Refreshing accounts after successful connection...');
          final accounts = await accountsRepo.fetchConnectedAccounts();
          ref.read(accountSwitcherProvider.notifier).initializeAccounts(accounts);
          
          // Refresh all data providers
          Logger.info('Refreshing all data providers...');
          
          // Invalidate all providers to force refresh
          ref.invalidate(bills.billsProvider);
          ref.invalidate(bills.transactionHistoryProvider);
          ref.invalidate(bills.usageSummaryProvider);
          ref.invalidate(bills.yearlyConsumptionProvider);
          ref.invalidate(bills.accountDetailsProvider);
          ref.invalidate(usage.meterReadingsThisYearProvider);
          ref.invalidate(usage.meterReadingsLastYearProvider);
          ref.invalidate(dashboard.dashboardDataProvider);
          ref.invalidate(dashboard.sevenDayConsumptionProvider);
          ref.invalidate(dashboard.energyPricesProvider);
          
          // Note: accountBalanceProvider in bills is a Provider.autoDispose, 
          // it will automatically refresh when accountSwitcherProvider changes
          
          // Call refreshAll on refresh providers
          await Future.wait<void>([
            ref.read(bills.billsRefreshProvider.notifier).refreshAll(ref),
            ref.read(dashboard.dashboardRefreshProvider.notifier).refreshAll(ref),
          ]);
          
          Logger.info('All data refreshed successfully after account connection');
        } catch (e) {
          Logger.error('Failed to refresh data after connection', error: e);
        }
      },
    ),
  );
}

/// Connect Account Form Dialog (extracted from account_switcher.dart for reuse)
class _ConnectAccountFormDialog extends ConsumerStatefulWidget {
  const _ConnectAccountFormDialog({
    required this.onSuccess,
  });

  final VoidCallback onSuccess;

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

  @override
  void dispose() {
    _customerNumberController.dispose();
    _accountNumberHintController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final accountsRepo = ref.read(accountsRepositoryProvider);
      await accountsRepo.connectAccount(
        customerNumber: _customerNumberController.text.trim(),
        accountNumberHint: _accountNumberHintController.text.trim(),
        nickName: _nicknameController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        widget.onSuccess();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account connected successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
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
                      onPressed: _isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing24),
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
                // Account Number Hint
                TextFormField(
                  controller: _accountNumberHintController,
                  decoration: const InputDecoration(
                    labelText: 'Account Number Hint',
                    hintText: 'Enter up to 5 characters',
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                    helperText: 'Maximum 5 characters',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Account number hint is required';
                    }
                    if (value.trim().length > 5) {
                      return 'Maximum 5 characters allowed';
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
            ),
          ),
        ),
      );
}
