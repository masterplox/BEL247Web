import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/error_messages.dart';
import '../../core/widgets/account_aware_scaffold.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_error_state.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/app_page_scaffold.dart';
import '../../core/widgets/app_responsive_layout.dart';
import '../../core/widgets/app_toast.dart';
import '../../data/models/user.dart';
import '../../theme/colors.dart';
import 'state/bills_providers.dart' as bills_state;
import 'widgets/account_ledger_widget.dart';
import 'widgets/account_summary_widget.dart';
// Commented out - replaced with Account Ledger
// import 'widgets/bill_download_widget.dart';
// import 'widgets/billing_history_list.dart';
import 'widgets/payment_widget.dart';

class BillsPage extends ConsumerWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AccountAwareScaffold(
      emptyMessage:
          'You don\'t have any accounts connected yet. Connect an account to view your transaction history and bills.',
      emptyIcon: Icons.receipt_long_outlined,
      builder: (context, ref, accountState) => const AppPageScaffold(
        title: 'Transaction History',
        subtitle: 'View your bills and payment history',
        body: BillsLayout(),
      ),
    );
}

class BillsLayout extends ConsumerWidget {
  const BillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const AppResponsiveLayout(
        mobile: MobileBillsLayout(),
        tablet: TabletBillsLayout(),
        desktop: DesktopBillsLayout(),
      );
}

class DesktopBillsLayout extends ConsumerWidget {
  const DesktopBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const AccountLedgerCard();
}

class TabletBillsLayout extends ConsumerWidget {
  const TabletBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const AccountLedgerCard();
}

class MobileBillsLayout extends ConsumerWidget {
  const MobileBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const AccountLedgerCard();
}

class BillsHeader extends StatelessWidget {
  const BillsHeader({super.key});

  @override
  Widget build(BuildContext context) => const AppPageHeader(
        title: 'Transaction History',
        subtitle: 'View your transaction history',
      );
}

class AccountSummaryCard extends ConsumerWidget {
  const AccountSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AccountBalance is now a Provider, not FutureProvider - get it directly
    final accountBalance = ref.watch(bills_state.accountBalanceProvider);
    final usageSummaryAsync = ref.watch(bills_state.usageSummaryProvider);
    final yearlyConsumptionAsync = ref.watch(bills_state.yearlyConsumptionProvider);
    
    return usageSummaryAsync.when(
        loading: () => AccountSummaryWidget(
          accountBalance: accountBalance,
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
          isLoading: true,
          onRefresh: () => ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref),
        ),
        error: (e, st) => AccountSummaryWidget(
          accountBalance: accountBalance,
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
          onRefresh: () => ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref),
        ),
        data: (usageSummary) => yearlyConsumptionAsync.when(
          loading: () => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            isLoading: true,
            onRefresh: () => ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref),
          ),
          error: (e, st) => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            onRefresh: () => ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref),
          ),
          data: (yearlyConsumption) => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            yearlyConsumption: yearlyConsumption,
            onRefresh: () => ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref),
          ),
        ),
      
    );  
  }
}

class PaymentCard extends ConsumerWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AccountBalance is now a Provider, not FutureProvider - get it directly
    final accountBalance = ref.watch(bills_state.accountBalanceProvider);
    
    return PaymentWidget(
      accountBalance: accountBalance,
      onPaymentSuccess: (amount, method) {
          ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref);
          AppToast.success(
            context,
            'Payment of \$${amount.toStringAsFixed(2)} submitted successfully!',
          );
        },
        onPaymentError: (error) {
          AppToast.error(
            context,
            "Payment didn't go through. Please try again or use a different method.",
          );
        },
      
    );
  }
}

// Account Ledger Card - replaces BillingHistoryCard and BillDownloadCard
class AccountLedgerCard extends ConsumerWidget {
  const AccountLedgerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(bills_state.billsProvider);
    final transactionHistoryAsync = ref.watch(bills_state.transactionHistoryProvider);
    
    return AppCard(
      child: billsAsync.when(
          loading: () => const AccountLedgerWidget(
            bills: [],
            isLoading: true,
          ),
          error: (e, st) => AppErrorState(
            message: ErrorMessages.billLoadFailed,
            title: "Couldn't load bills",
            icon: Icons.receipt_long_outlined,
            onRetry: () => ref.invalidate(bills_state.billsProvider),
          ),
          data: (bills) => transactionHistoryAsync.when(
            loading: () => AccountLedgerWidget(
              bills: bills,
              isLoading: true,
              onViewFullDetails: (payment) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Viewing full payment details...'),
                    backgroundColor: AppColors.info,
                  ),
                );
              },
            ),
            error: (e, st) => AccountLedgerWidget(
              bills: bills,
              // Fallback to bills-only if transaction history fails
              transactionHistory: const [],
              onViewFullDetails: (payment) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Viewing full payment details...'),
                    backgroundColor: AppColors.info,
                  ),
                );
              },
            ),
            data: (transactionHistory) => AccountLedgerWidget(
              bills: bills,
              transactionHistory: transactionHistory, // Use live transaction history from API
              onViewFullDetails: (payment) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Viewing full payment details...'),
                    backgroundColor: AppColors.info,
                  ),
                );
              },
            ),
          ),
        ),
    );
  }
}
