import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/api_response_dtos.dart';
import '../../features/bills/state/bills_providers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../constants/customer_portal_support_types.dart';
import '../providers/account_verification_providers.dart';
import '../services/account_activation_service.dart';
import '../utils/contact_masking.dart';
import 'activation_flow_support_footer.dart';
import 'app_dialog.dart';

/// Copy and post-success behavior for one activation purpose.
class _ActivationConfig {
  const _ActivationConfig({
    required this.purpose,
    required this.title,
    this.subtitle,
    required this.contactPrompt,
    required this.codeEntryPrompt,
    required this.successTitle,
    required this.successFallback,
    required this.supportSourcePage,
    required this.supportType,
    required this.showPremiumBenefits,
  });

  final AccountActivationPurpose purpose;
  final String title;
  final String? subtitle;
  final String contactPrompt;
  final String codeEntryPrompt;
  final String successTitle;
  final String successFallback;
  final String supportSourcePage;
  final String supportType;
  final bool showPremiumBenefits;
}

const _fullAccessConfig = _ActivationConfig(
  purpose: AccountActivationPurpose.fullAccess,
  title: 'Verify your account',
  subtitle:
      'To protect your privacy, we need to verify that you are the account holder before showing full account details.',
  contactPrompt: 'Choose where to send your verification code.',
  codeEntryPrompt:
      'A verification code was sent to the account holder\'s selected contact. Enter that code to continue.',
  successTitle: 'Your account is now verified.',
  successFallback:
      'You can now view your full account and personal details on the dashboard.',
  supportSourcePage: '/premium-activation',
  supportType: CustomerPortalSupportTypes.premiumUpgradeCode,
  showPremiumBenefits: true,
);

const _billDownloadConfig = _ActivationConfig(
  purpose: AccountActivationPurpose.billDownload,
  title: 'Request access',
  subtitle: null,
  contactPrompt:
      'A verification code will be sent to the account holder\'s contact to enable bill viewing and download.',
  codeEntryPrompt:
      'A verification code was sent to the account holder\'s contact to enable bill viewing and download. Enter that code to continue.',
  successTitle: 'Bill download access activated.',
  successFallback:
      'You can now download bills for this account. The next time you sign in, this access will already be enabled.',
  supportSourcePage: '/bill-download-activation',
  supportType: CustomerPortalSupportTypes.billDownloadCode,
  showPremiumBenefits: false,
);

/// Show the full access activation flow dialog.
///
/// Returns `true` if the flow completed successfully.
Future<bool?> showFullAccessActivationDialog(BuildContext context) =>
    _showActivationDialog(context, config: _fullAccessConfig);

/// Show the bill download activation flow dialog.
///
/// Returns `true` if the flow completed successfully.
Future<bool?> showBillDownloadActivationDialog(
  BuildContext context, {
  required String billNumber,
}) =>
    _showActivationDialog(
      context,
      config: _billDownloadConfig,
      billNumber: billNumber,
    );

Future<bool?> _showActivationDialog(
  BuildContext context, {
  required _ActivationConfig config,
  String? billNumber,
}) =>
    AppDialog.showCenter<bool>(
      context: context,
      barrierDismissible: true,
      title: config.title,
      subtitle: config.subtitle,
      content: _AccountActivationFlow(
        config: config,
        billNumber: billNumber,
      ),
      actions: const [],
      maxWidth: 480,
      showCloseButton: true,
    );

enum _ActivationStep {
  contactSelection,
  codeEntry,
  success,
}

class _AccountActivationFlow extends ConsumerStatefulWidget {
  const _AccountActivationFlow({
    required this.config,
    this.billNumber,
  });

  final _ActivationConfig config;
  final String? billNumber;

  @override
  ConsumerState<_AccountActivationFlow> createState() =>
      _AccountActivationFlowState();
}

class _AccountActivationFlowState
    extends ConsumerState<_AccountActivationFlow> {
  _ActivationStep _step = _ActivationStep.contactSelection;
  bool _isSubmitting = false;
  String _channel = 'sms';
  String? _error;
  final TextEditingController _codeController = TextEditingController();

  _ActivationConfig get _config => widget.config;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: _step == _ActivationStep.contactSelection
                ? 0.33
                : _step == _ActivationStep.codeEntry
                    ? 0.66
                    : 1.0,
            backgroundColor: AppColors.surface,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: AppTheme.spacing16),
          if (_step == _ActivationStep.contactSelection)
            _config.purpose == AccountActivationPurpose.billDownload
                ? _buildBillDownloadRequest(context)
                : _buildContactSelection(context)
          else if (_step == _ActivationStep.codeEntry)
            _buildCodeEntry(context)
          else
            _buildSuccess(context),
        ],
      );

  Widget _buildBillDownloadRequest(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _config.contactPrompt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppTheme.spacing12),
            Text(
              _error!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppTheme.spacing16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _requestActivationCode,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Send code'),
            ),
          ),
        ],
      );

  Widget _buildContactSelection(BuildContext context) {
    final accountDetailsAsync = ref.watch(accountDetailsProvider);

    return accountDetailsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Text(
        'Unable to load account details. Please try again.',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.error),
      ),
      data: (details) {
        if (details == null) {
          return Text(
            'Account details are not available.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.error),
          );
        }

        final phone = details.cell ?? '';
        final email = details.emailAddress ?? '';
        final hasPhone = phone.isNotEmpty;
        final hasEmail = email.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_config.showPremiumBenefits) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium Level offers features including:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    _benefitRow(context, 'Unrestricted Bill Download'),
                    _benefitRow(context, 'View account details'),
                    _benefitRow(context, 'Deeper usage insights'),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
            ],
            Text(
              _config.contactPrompt,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppTheme.spacing16),
            if (!hasPhone && !hasEmail)
              Text(
                'We do not have a phone number or email address on file for this account. Please contact appsupport@bel.com.bz',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.error),
              )
            else ...[
              if (hasPhone)
                RadioListTile<String>(
                  value: 'sms',
                  groupValue: _channel,
                  onChanged: _isSubmitting
                      ? null
                      : (value) {
                          if (value != null) {
                            setState(() => _channel = value);
                          }
                        },
                  title: const Text('Text message'),
                  subtitle: Text(ContactMasking.maskPhone(phone)),
                ),
              if (hasEmail)
                RadioListTile<String>(
                  value: 'email',
                  groupValue: _channel,
                  onChanged: _isSubmitting
                      ? null
                      : (value) {
                          if (value != null) {
                            setState(() => _channel = value);
                          }
                        },
                  title: const Text('Email'),
                  subtitle: Text(ContactMasking.maskEmail(email)),
                ),
              if (_error != null) ...[
                const SizedBox(height: AppTheme.spacing8),
                Text(
                  _error!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.error),
                ),
              ],
              const SizedBox(height: AppTheme.spacing16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _isSubmitting || (!hasPhone && !hasEmail)
                      ? null
                      : _requestActivationCode,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Send code'),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _benefitRow(BuildContext context, String benefit) => Padding(
        padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
        child: Row(
          children: [
            const Icon(Icons.check_circle, size: 14, color: AppColors.primary),
            const SizedBox(width: AppTheme.spacing8),
            Expanded(
              child: Text(
                benefit,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      );

  Widget _buildCodeEntry(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _config.codeEntryPrompt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppTheme.spacing16),
          TextField(
            controller: _codeController,
            decoration: const InputDecoration(
              labelText: 'Verification code',
            ),
            keyboardType: TextInputType.number,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppTheme.spacing8),
            Text(
              _error!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppTheme.spacing16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _isSubmitting
                    ? null
                    : () {
                        setState(() {
                          _step = _ActivationStep.contactSelection;
                          _error = null;
                        });
                      },
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _verifyCode,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Verify'),
              ),
            ],
          ),
          ActivationFlowSupportFooter(
            sourcePage: _config.supportSourcePage,
            supportType: _config.supportType,
          ),
        ],
      );

  Widget _buildSuccess(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 32,
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            _config.successTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            _config.successFallback,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppTheme.spacing16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
              child: const Text('Done'),
            ),
          ),
        ],
      );

  Future<void> _requestActivationCode() async {
    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      if (_config.purpose == AccountActivationPurpose.billDownload) {
        final response =
            await ref.read(accountActivationServiceProvider).requestCode(
                  purpose: _config.purpose,
                  customerNumber: '',
                  accountNumber: '',
                  billNumber: widget.billNumber,
                );

        if (!response.isSuccess) {
          setState(() {
            _error = response.message ?? 'Failed to send verification code.';
            _isSubmitting = false;
          });
          return;
        }

        setState(() {
          _step = _ActivationStep.codeEntry;
          _isSubmitting = false;
        });
        return;
      }

      final accountDetails = await ref.read(accountDetailsProvider.future);
      if (accountDetails == null) {
        setState(() {
          _error = 'Account details are not available.';
          _isSubmitting = false;
        });
        return;
      }

      final customerNumber = accountDetails.customerNumber ?? '';
      final accountNumber = accountDetails.accountNumber ?? '';
      if (customerNumber.isEmpty || accountNumber.isEmpty) {
        setState(() {
          _error =
              'Customer number or account number is missing for this account.';
          _isSubmitting = false;
        });
        return;
      }

      final useSms = _channel == 'sms' &&
          (accountDetails.cell?.isNotEmpty ?? false);

      final response =
          await ref.read(accountActivationServiceProvider).requestCode(
                purpose: _config.purpose,
                customerNumber: customerNumber,
                accountNumber: accountNumber,
                mobileNumber: useSms ? accountDetails.cell : null,
                email: useSms ? null : accountDetails.emailAddress,
                billNumber: widget.billNumber,
              );

      if (!response.isSuccess) {
        setState(() {
          _error = response.message ?? 'Failed to send verification code.';
          _isSubmitting = false;
        });
        return;
      }

      setState(() {
        _step = _ActivationStep.codeEntry;
        _isSubmitting = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong while requesting the code.';
        _isSubmitting = false;
      });
    }
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _error = 'Please enter the verification code.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      if (_config.purpose == AccountActivationPurpose.billDownload) {
        final response =
            await ref.read(accountActivationServiceProvider).verifyCode(
                  purpose: _config.purpose,
                  customerNumber: '',
                  accountNumber: '',
                  code: code,
                  billNumber: widget.billNumber,
                );

        if (!response.isSuccess) {
          setState(() {
            _error = response.message ?? 'Verification failed. Please try again.';
            _isSubmitting = false;
          });
          return;
        }

        ref.invalidate(accountVerificationStatusProvider);
        ref.invalidate(accountDetailsProvider);
        ref.invalidate(billDownloadAccessStatusProvider);

        setState(() {
          _step = _ActivationStep.success;
          _isSubmitting = false;
        });
        return;
      }

      final accountDetails = await ref.read(accountDetailsProvider.future);
      if (accountDetails == null) {
        setState(() {
          _error = 'Account details are not available.';
          _isSubmitting = false;
        });
        return;
      }

      final customerNumber = accountDetails.customerNumber ?? '';
      final accountNumber = accountDetails.accountNumber ?? '';

      final useSms = _channel == 'sms' &&
          (accountDetails.cell?.isNotEmpty ?? false);

      final response =
          await ref.read(accountActivationServiceProvider).verifyCode(
                purpose: _config.purpose,
                customerNumber: customerNumber,
                accountNumber: accountNumber,
                code: code,
                mobileNumber: useSms ? accountDetails.cell : null,
                email: useSms ? null : accountDetails.emailAddress,
                billNumber: widget.billNumber,
              );

      if (!response.isSuccess) {
        setState(() {
          _error = response.message ?? 'Verification failed. Please try again.';
          _isSubmitting = false;
        });
        return;
      }

      ref.invalidate(accountVerificationStatusProvider);
      ref.invalidate(accountDetailsProvider);
      ref.invalidate(billDownloadAccessStatusProvider);

      setState(() {
        _step = _ActivationStep.success;
        _isSubmitting = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong while verifying the code.';
        _isSubmitting = false;
      });
    }
  }
}
