import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/feature_providers.dart';
import '../utils/account_connection_utils.dart';
import 'app_empty_state.dart';
import 'app_loading_state.dart';

/// A reusable scaffold wrapper for pages that depend on a selected account.
///
/// This centralizes the common pattern used across multiple features:
/// - Watch [accountSwitcherProvider]
/// - While accounts are still loading, show a loading state
/// - When there are no accounts, show a configurable empty state with an
///   optional "Connect Account" action
/// - Otherwise, render the page content via [builder]
///
/// This widget is intentionally conservative and does not change any
/// existing feature behavior. It just extracts the existing patterns into
/// a configurable, reusable shell.
class AccountAwareScaffold extends ConsumerWidget {
  const AccountAwareScaffold({
    super.key,
    this.appBar,
    this.emptyTitle = 'No Connected Accounts',
    required this.emptyMessage,
    this.emptyIcon,
    this.emptyActionLabel,
    this.onEmptyAction,
    this.showConnectAccountAction = true,
    this.loadingMessage,
    required this.builder,
  });

  /// Optional app bar to use when rendering the final page content.
  final PreferredSizeWidget? appBar;

  /// Title for the "no accounts" empty state.
  final String emptyTitle;

  /// Message for the "no accounts" empty state.
  final String emptyMessage;

  /// Icon for the "no accounts" empty state.
  final IconData? emptyIcon;

  /// Label for the primary action in the empty state.
  ///
  /// When [showConnectAccountAction] is true and [onEmptyAction] is null,
  /// this defaults to "Connect Account" and uses
  /// [showConnectAccountDialogAndRefresh] behind the scenes.
  final String? emptyActionLabel;

  /// Custom callback for the empty state action.
  ///
  /// If null and [showConnectAccountAction] is true, the default
  /// connect-account dialog will be used.
  final VoidCallback? onEmptyAction;

  /// Whether to automatically wire up the standard "Connect Account" action
  /// when no [onEmptyAction] is provided.
  final bool showConnectAccountAction;

  /// Optional message to show under the loading spinner while accounts
  /// are being initialized.
  final String? loadingMessage;

  /// Builder for the actual page content once an account is available.
  ///
  /// The builder receives the active [AccountSwitcherState]; pages that need
  /// the active account can read it from there as they did previously.
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AccountSwitcherState accountState,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountSwitcherProvider);

    // 1) Still initializing accounts: show a loading scaffold (null-safe)
    if (accountState.isInitialized != true) {
      return Scaffold(
        appBar: appBar,
        body: AppLoadingState(
          message: loadingMessage ?? 'Loading accounts...',
        ),
      );
    }

    // 2) No accounts after initialization: show configurable empty state
    if (accountState.accounts.isEmpty) {
      VoidCallback? effectiveOnAction = onEmptyAction;
      String? effectiveLabel = emptyActionLabel;

      if (showConnectAccountAction) {
        effectiveLabel ??= 'Connect Account';
        effectiveOnAction ??= () => showConnectAccountDialogAndRefresh(context, ref);
      }

      return Scaffold(
        appBar: appBar,
        body: Center(
          child: AppEmptyState(
            title: emptyTitle,
            message: emptyMessage,
            icon: emptyIcon,
            actionLabel: effectiveLabel,
            onAction: effectiveOnAction,
          ),
        ),
      );
    }

    // 3) We have accounts: delegate to the page-specific builder
    return builder(context, ref, accountState);
  }
}

