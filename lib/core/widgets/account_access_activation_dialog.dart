import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/accounts_repository.dart';
import '../../features/bills/state/bills_providers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../providers/account_verification_providers.dart';
import 'app_dialog.dart';

/// Show the full access activation flow dialog.
///
/// Returns `true` if the flow completed successfully.
Future<bool?> showFullAccessActivationDialog(BuildContext context) => AppDialog.showCenter<bool>(
    context: context,
    barrierDismissible: true,
    title: 'Verify your account',
    subtitle:
        'To protect your privacy, we need to verify that you are the account holder before showing full account details.',
    content: const _FullAccessActivationFlow(),
    actions: const [],
    maxWidth: 480,
    showCloseButton: true,
  );

/// Show the bill download activation flow dialog.
///
/// Returns `true` if the flow completed successfully.
Future<bool?> showBillDownloadActivationDialog(
  BuildContext context, {
  required String billNumber,
}) => AppDialog.showCenter<bool>(
    context: context,
    barrierDismissible: true,
    title: 'Activate bill downloads',
    subtitle:
        'For your security, we need to verify this account before allowing bill downloads.',
    content: _BillDownloadActivationFlow(billNumber: billNumber),
    actions: const [],
    maxWidth: 480,
    showCloseButton: true,
  );

enum _ActivationStep {
  contactSelection,
  codeEntry,
  success,
}

class _FullAccessActivationFlow extends ConsumerStatefulWidget {
  const _FullAccessActivationFlow();

  @override
  ConsumerState<_FullAccessActivationFlow> createState() =>
      _FullAccessActivationFlowState();
}

class _FullAccessActivationFlowState
    extends ConsumerState<_FullAccessActivationFlow> {
  _ActivationStep _step = _ActivationStep.contactSelection;
  bool _isSubmitting = false;
  String _channel = 'sms';
  String? _error;
  String? _infoMessage;
  final TextEditingController _codeController = TextEditingController();

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
          _buildContactSelection(context)
        else if (_step == _ActivationStep.codeEntry)
          _buildCodeEntry(context)
        else
          _buildSuccess(context),
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
                    'What you get after verification',
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
            Text(
              'Choose where to send your verification code.',
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
                  subtitle: Text(_maskPhone(phone)),
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
                  subtitle: Text(_maskEmail(email)),
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
          'Enter the verification code we sent to your selected contact method.',
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
        if (_infoMessage != null) ...[
          const SizedBox(height: AppTheme.spacing8),
          Text(
            _infoMessage!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
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
          'Your account is now verified.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Text(
          _infoMessage ??
              'You can now view your full account and personal details on the dashboard.',
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
      _infoMessage = null;
    });

    try {
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

      final repo = ref.read(accountsRepositoryProvider);
      final response = await repo.requestFullAccessActivationCode(
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        mobileNumber: _channel == 'sms' ? accountDetails.cell : null,
        email: _channel == 'email' ? accountDetails.emailAddress : null,
      );

      if (response.status != 200) {
        setState(() {
          _error = response.message ?? 'Failed to send verification code.';
          _isSubmitting = false;
        });
        return;
      }

      setState(() {
        _step = _ActivationStep.codeEntry;
        _isSubmitting = false;
        _infoMessage = response.message;
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

      final repo = ref.read(accountsRepositoryProvider);
      final response = await repo.activateFullAccess(
        customerNumber: customerNumber,
        accountNumber: accountNumber,
        code: code,
        mobileNumber: _channel == 'sms' ? accountDetails.cell : null,
        email: _channel == 'email' ? accountDetails.emailAddress : null,
      );

      if (response.status != 200) {
        setState(() {
          _error = response.message ?? 'Verification failed. Please try again.';
          _isSubmitting = false;
        });
        return;
      }

      // Refresh verification status and account details.
      ref.invalidate(accountVerificationStatusProvider);
      ref.invalidate(accountDetailsProvider);

      setState(() {
        _step = _ActivationStep.success;
        _isSubmitting = false;
        _infoMessage = response.message;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong while verifying the code.';
        _isSubmitting = false;
      });
    }
  }

  String _maskPhone(String phone) {
    if (phone.length <= 2) return phone;
    final last2 = phone.substring(phone.length - 2);
    return '••••••$last2';
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final local = parts[0];
    final domain = parts[1];
    final visible = local.length <= 2 ? local : local.substring(0, 2);
    return '$visible***@$domain';
  }
}

class _BillDownloadActivationFlow extends ConsumerStatefulWidget {
  const _BillDownloadActivationFlow({
    required this.billNumber,
  });

  final String billNumber;

  @override
  ConsumerState<_BillDownloadActivationFlow> createState() =>
      _BillDownloadActivationFlowState();
}

class _BillDownloadActivationFlowState
    extends ConsumerState<_BillDownloadActivationFlow> {
  _ActivationStep _step = _ActivationStep.contactSelection;
  bool _isSubmitting = false;
  String _channel = 'sms';
  String? _error;
  String? _infoMessage;
  final TextEditingController _codeController = TextEditingController();

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
          _buildContactSelection(context)
        else if (_step == _ActivationStep.codeEntry)
          _buildCodeEntry(context)
        else
          _buildSuccess(context),
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
            Text(
              'Choose where to send your one-time code to enable bill downloads.',
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
                  subtitle: Text(_maskPhone(phone)),
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
                  subtitle: Text(_maskEmail(email)),
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

  Widget _buildCodeEntry(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Enter the code we sent to complete bill download activation.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppTheme.spacing16),
        TextField(
          controller: _codeController,
          decoration: const InputDecoration(
            labelText: 'Activation code',
          ),
          keyboardType: TextInputType.number,
        ),
        if (_infoMessage != null) ...[
          const SizedBox(height: AppTheme.spacing8),
          Text(
            _infoMessage!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
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
          'Bill download access activated.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Text(
          _infoMessage ??
              'You can now download bills for this account. The next time you sign in, this access will already be enabled.',
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
      _infoMessage = null;
    });

    try {
      final repo = ref.read(billsRepositoryProvider);
      final response = await repo.requestBillDownloadActivationCode(
        billNumber: widget.billNumber,
      );

      if (response.status != 200) {
        setState(() {
          _error = response.message ??
              'Failed to send activation code. Please try again.';
          _isSubmitting = false;
        });
        return;
      }

      setState(() {
        _step = _ActivationStep.codeEntry;
        _isSubmitting = false;
        _infoMessage = response.message;
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
        _error = 'Please enter the activation code.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final repo = ref.read(billsRepositoryProvider);
      final response = await repo.validateBillDownloadActivationCode(
        billNumber: widget.billNumber,
        code: code,
      );

      if (response.status != 200) {
        setState(() {
          _error =
              response.message ?? 'Activation failed. Please try again.';
          _isSubmitting = false;
        });
        return;
      }

      // Refresh bill download access flag via account details.
      ref.invalidate(accountDetailsProvider);
      ref.invalidate(billDownloadAccessStatusProvider);

      setState(() {
        _step = _ActivationStep.success;
        _isSubmitting = false;
        _infoMessage = response.message;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong while verifying the code.';
        _isSubmitting = false;
      });
    }
  }

  String _maskPhone(String phone) {
    if (phone.length <= 2) return phone;
    final last2 = phone.substring(phone.length - 2);
    return '••••••$last2';
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final local = parts[0];
    final domain = parts[1];
    final visible = local.length <= 2 ? local : local.substring(0, 2);
    return '$visible***@$domain';
  }
}

