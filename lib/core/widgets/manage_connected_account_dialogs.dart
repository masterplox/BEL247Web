import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/account.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import '../providers/feature_providers.dart';
import '../utils/error_handler.dart';
import '../utils/logger.dart';
import 'app_dialog.dart';

enum ConnectedAccountActionOutcome { cancelled, success, failure }

/// Result of edit/remove flows for in-dialog feedback in the account switcher.
class ConnectedAccountActionResult {
  const ConnectedAccountActionResult._({
    required this.outcome,
    this.message,
  });

  final ConnectedAccountActionOutcome outcome;
  final String? message;

  bool get isSuccess => outcome == ConnectedAccountActionOutcome.success;
  bool get isCancelled => outcome == ConnectedAccountActionOutcome.cancelled;
  bool get isFailure => outcome == ConnectedAccountActionOutcome.failure;

  static const cancelled = ConnectedAccountActionResult._(
    outcome: ConnectedAccountActionOutcome.cancelled,
  );

  static ConnectedAccountActionResult success(String message) =>
      ConnectedAccountActionResult._(
        outcome: ConnectedAccountActionOutcome.success,
        message: message,
      );

  static ConnectedAccountActionResult failure(String message) =>
      ConnectedAccountActionResult._(
        outcome: ConnectedAccountActionOutcome.failure,
        message: message,
      );
}

Future<void> _refreshConnectedAccounts(WidgetRef ref) async {
  final repo = ref.read(accountsRepositoryProvider);
  final accounts = await repo.fetchConnectedAccounts();
  ref.read(accountSwitcherProvider.notifier).initializeAccounts(accounts);
}

/// Shows dialog to edit a connected account nickname; refreshes account list on success.
Future<ConnectedAccountActionResult?> showEditAccountNicknameDialog(
  BuildContext context,
  WidgetRef ref,
  Account account,
) =>
    showDialog<ConnectedAccountActionResult>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _EditNicknameDialog(
        account: account,
        parentRef: ref,
      ),
    );

/// Confirms then removes a connected account (Active: false via full DTO PUT).
Future<ConnectedAccountActionResult?> showRemoveConnectedAccountDialog(
  BuildContext context,
  WidgetRef ref,
  Account account,
) =>
    showDialog<ConnectedAccountActionResult>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _RemoveAccountConfirmDialog(
        account: account,
        parentRef: ref,
      ),
    );

class _EditNicknameDialog extends ConsumerStatefulWidget {
  const _EditNicknameDialog({
    required this.account,
    required this.parentRef,
  });

  final Account account;
  final WidgetRef parentRef;

  @override
  ConsumerState<_EditNicknameDialog> createState() => _EditNicknameDialogState();
}

class _EditNicknameDialogState extends ConsumerState<_EditNicknameDialog> {
  late final TextEditingController _nicknameController;
  bool _submitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(
      text: widget.account.nickname ?? '',
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final newNickname = _nicknameController.text.trim();
    if (newNickname.isEmpty) {
      setState(() => _errorMessage = 'Nickname cannot be empty');
      return;
    }

    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(accountsRepositoryProvider);
      await repo.updateConnectedAccountNickname(
        accountId: widget.account.id,
        newNickname: newNickname,
      );
      await _refreshConnectedAccounts(widget.parentRef);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(
        ConnectedAccountActionResult.success('Nickname updated'),
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to update nickname', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _submitting = false;
          _errorMessage = ErrorHandler.getErrorMessage(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: !_submitting,
        child: AppDialog(
        title: 'Edit nickname',
        showCloseButton: !_submitting,
        onClose: _submitting
            ? null
            : () => Navigator.of(context, rootNavigator: true).pop(
                  ConnectedAccountActionResult.cancelled,
                ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nicknameController,
              enabled: !_submitting,
              decoration: const InputDecoration(
                labelText: 'Nickname',
                hintText: 'Enter a nickname for this account',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: !_submitting ? (_) => _save() : null,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: AppTheme.spacing12),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.error,
                    ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: _submitting
                ? null
                : () => Navigator.of(context, rootNavigator: true).pop(
                      ConnectedAccountActionResult.cancelled,
                    ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitting ? null : _save,
            child: _submitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      );
}

class _RemoveAccountConfirmDialog extends ConsumerStatefulWidget {
  const _RemoveAccountConfirmDialog({
    required this.account,
    required this.parentRef,
  });

  final Account account;
  final WidgetRef parentRef;

  @override
  ConsumerState<_RemoveAccountConfirmDialog> createState() =>
      _RemoveAccountConfirmDialogState();
}

class _RemoveAccountConfirmDialogState
    extends ConsumerState<_RemoveAccountConfirmDialog> {
  bool _submitting = false;
  String? _errorMessage;

  Future<void> _remove() async {
    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(accountsRepositoryProvider);
      final switcher = ref.read(accountSwitcherProvider.notifier);
      final wasActive =
          ref.read(accountSwitcherProvider).activeAccountId == widget.account.id;

      await repo.removeConnectedAccount(accountId: widget.account.id);
      await _refreshConnectedAccounts(widget.parentRef);

      final accounts = ref.read(accountSwitcherProvider).accounts;
      if (wasActive && accounts.isNotEmpty) {
        switcher.switchAccount(accounts.first.id);
      }

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(
        ConnectedAccountActionResult.success('Account removed'),
      );
    } catch (e, stackTrace) {
      Logger.error('Failed to remove account', error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _submitting = false;
          _errorMessage = ErrorHandler.getErrorMessage(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        widget.account.nickname ?? widget.account.formattedAccountNumber;

    return PopScope(
      canPop: !_submitting,
      child: AppDialog(
      title: 'Remove connected account?',
      showCloseButton: !_submitting,
      onClose: _submitting
          ? null
          : () => Navigator.of(context, rootNavigator: true).pop(
                ConnectedAccountActionResult.cancelled,
              ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Remove "$displayName" (${widget.account.customerNumber}:${widget.account.accountNumber})? '
            'You can connect it again later from Connect Account.',
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: AppTheme.spacing12),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                  ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitting
              ? null
              : () => Navigator.of(context, rootNavigator: true).pop(
                    ConnectedAccountActionResult.cancelled,
                  ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
          ),
          onPressed: _submitting ? null : _remove,
          child: _submitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Remove'),
        ),
      ],
    ),
    );
  }
}
