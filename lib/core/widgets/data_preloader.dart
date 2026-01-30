import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/bills/state/bills_providers.dart';
import '../../features/usage/state/meter_readings_providers.dart';
import '../providers/feature_providers.dart';

/// Invisible widget that preloads data when an active account is selected
/// This ensures transaction history and meter readings are loaded immediately
/// when the user logs in and an account is selected, rather than waiting
/// until they visit the bills or usage pages.
class DataPreloader extends ConsumerWidget {
  const DataPreloader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountSwitcherProvider);
    final activeAccount = accountState.activeAccount;

    // Preload data if we have an active account
    if (activeAccount != null) {
      // Watch these providers to trigger data loading
      // The providers will automatically fetch when account changes
      ref.watch(transactionHistoryProvider);
      ref.watch(meterReadingsThisYearProvider);
      ref.watch(meterReadingsLastYearProvider);
    }

    // Return child unchanged - this widget is invisible
    return child;
  }
}
