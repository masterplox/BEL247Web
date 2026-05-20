import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/account.dart';
import '../../data/repositories/accounts_repository.dart';
import '../../theme/colors.dart';
import '../providers/feature_providers.dart';
import '../utils/logger.dart';
import 'app_dialog.dart';

/// Shows dialog to edit a connected account nickname; refreshes account list on success.
Future<void> showEditAccountNicknameDialog(
  BuildContext context,
  WidgetRef ref,
  Account account,
) async {
  final nicknameController = TextEditingController(
    text: account.nickname ?? '',
  );

  final saved = await AppDialog.showCenter<bool>(
    context: context,
    title: 'Edit nickname',
    content: TextField(
      controller: nicknameController,
      decoration: const InputDecoration(
        labelText: 'Nickname',
        hintText: 'Enter a nickname for this account',
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          if (nicknameController.text.trim().isEmpty) {
            return;
          }
          Navigator.of(context, rootNavigator: true).pop(true);
        },
        child: const Text('Save'),
      ),
    ],
  );

  if (saved != true || !context.mounted) {
    nicknameController.dispose();
    return;
  }

  final newNickname = nicknameController.text.trim();
  nicknameController.dispose();
  if (newNickname.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nickname cannot be empty')),
    );
    return;
  }

  try {
    final repo = ref.read(accountsRepositoryProvider);
    await repo.updateConnectedAccountNickname(
      accountId: account.id,
      newNickname: newNickname,
    );
    final accounts = await repo.fetchConnectedAccounts();
    ref.read(accountSwitcherProvider.notifier).initializeAccounts(accounts);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nickname updated')),
      );
    }
  } catch (e, stackTrace) {
    Logger.error('Failed to update nickname', error: e, stackTrace: stackTrace);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update nickname: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

/// Confirms then removes a connected account (Active: false via full DTO POST).
Future<void> showRemoveConnectedAccountDialog(
  BuildContext context,
  WidgetRef ref,
  Account account,
) async {
  final displayName =
      account.nickname ?? account.formattedAccountNumber;

  final confirmed = await AppDialog.showCenter<bool>(
    context: context,
    title: 'Remove connected account?',
    content: Text(
      'Remove "$displayName" (${account.customerNumber}:${account.accountNumber})? '
      'You can connect it again later from Connect Account.',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        child: const Text('Remove'),
      ),
    ],
  );

  if (confirmed != true || !context.mounted) {
    return;
  }

  try {
    final repo = ref.read(accountsRepositoryProvider);
    final switcher = ref.read(accountSwitcherProvider.notifier);
    final wasActive = ref.read(accountSwitcherProvider).activeAccountId == account.id;

    await repo.removeConnectedAccount(accountId: account.id);
    final accounts = await repo.fetchConnectedAccounts();
    switcher.initializeAccounts(accounts);

    if (wasActive && accounts.isNotEmpty) {
      switcher.switchAccount(accounts.first.id);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account removed')),
      );
    }
  } catch (e, stackTrace) {
    Logger.error('Failed to remove account', error: e, stackTrace: stackTrace);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove account: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
