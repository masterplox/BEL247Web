import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/accounts_repository.dart';
import 'feature_providers.dart' show accountSwitcherProvider;

/// Returns `true` when the current active account has full access.
///
/// This is driven by the connected account / preferred customer account's
/// `fullAccess` flag on `EditableCustomerAccountDto`, looked up via the active
/// account ID. If there is no active account, this defaults to `false`
/// (fail-closed).
final accountVerificationStatusProvider = FutureProvider<bool>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;

  if (activeAccount == null) {
    return false;
  }

  final accountsRepo = ref.read(accountsRepositoryProvider);
  final dto = await accountsRepo.fetchAccountDetails(activeAccount.id);

  // If we can't load details, treat as not verified by default.
  return dto?.fullAccess ?? false;
});

/// Returns `true` when the current active account has bill download access.
///
/// This is driven by the `billDownloadAccess` flag on `EditableCustomerAccountDto`.
/// If there is no active account or details cannot be loaded, this defaults
/// to `false` (fail-closed).
final billDownloadAccessStatusProvider = FutureProvider<bool>((ref) async {
  final accountState = ref.watch(accountSwitcherProvider);
  final activeAccount = accountState.activeAccount;

  if (activeAccount == null) {
    return false;
  }

  final accountsRepo = ref.read(accountsRepositoryProvider);
  final dto = await accountsRepo.fetchAccountDetails(activeAccount.id);

  return dto?.billDownloadAccess ?? false;
});

