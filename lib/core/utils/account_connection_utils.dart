import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../analytics/app_page_names.dart';
import '../providers/engagement_providers.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../features/bills/state/bills_providers.dart' as bills;
import '../../features/dashboard/state/dashboard_providers.dart' as dashboard;
import '../../features/usage/state/meter_readings_providers.dart' as usage;
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../providers/feature_providers.dart';
import '../utils/logger.dart';

const String _kAmiLearnMoreUrl = 'https://bit.ly/AMIbz';

/// Show connect account dialog and refresh all data after successful connection
Future<void> showConnectAccountDialogAndRefresh(
  BuildContext context,
  WidgetRef ref,
) async {
  final page = AppPageNames.navigationSubtypeForRoute(
    GoRouterState.of(context).matchedLocation,
  );
  ref.read(deviceEventsRepositoryProvider).logInteractionDialogOpen(
        currentPageName: page,
        dialogDetails: AppPageNames.connectCustomerAccount,
      );
  await showDialog(
    context: context,
    barrierDismissible: true,
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

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final compact = media.size.height < 500;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: compact ? 8 : 24,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
            maxHeight: media.size.height * (compact ? 0.95 : 0.88),
          ),
          child: SingleChildScrollView(
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
                    Expanded(
                      child: Text(
                      'Connect Account',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ),
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
                // Account Number Hint
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
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: AppTheme.spacing12,
                  runSpacing: AppTheme.spacing8,
                  children: [
                    TextButton(
                      onPressed: _isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                      child: const Text('Cancel'),
                    ),
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
      ),
    );
  }
}
