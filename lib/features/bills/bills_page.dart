import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/account_aware_scaffold.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/app_page_scaffold.dart';
import '../../core/widgets/app_responsive_layout.dart';
import '../../data/models/user.dart';
import '../../theme/app_theme.dart';
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
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        // padding: EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BillsHeader(),
            // SizedBox(height: AppTheme.spacing24),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: Column(
            //         children: [
            //           AccountSummaryCard(),
            //           SizedBox(height: AppTheme.spacing16),
            //           PaymentCard(),
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: AppTheme.spacing16),
            //     Expanded(
            //       flex: 2,
            //       child: AccountLedgerCard(),
            //     ),
            //   ],
            // ),
            AccountLedgerCard(),
          ],
        ),
      );
}

class TabletBillsLayout extends ConsumerWidget {
  const TabletBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        // padding: EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BillsHeader(),
            // SizedBox(height: AppTheme.spacing20),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: AccountSummaryCard(),
            //     ),
            //     SizedBox(width: AppTheme.spacing16),
            //     Expanded(
            //       child: PaymentCard(),
            //     ),
            //   ],
            // ),
            // SizedBox(height: AppTheme.spacing20),
            AccountLedgerCard(),
          ],
        ),
      );
}

class MobileBillsLayout extends ConsumerWidget {
  const MobileBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        // padding: EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //BillsHeader(),
            SizedBox(height: AppTheme.spacing16),
            Column(
              children: [
                // AccountSummaryCard(),
                // SizedBox(height: AppTheme.spacing16),
                // PaymentCard(),
                // SizedBox(height: AppTheme.spacing16),
                AccountLedgerCard(),
              ],
            ),
          ],
        ),
      );
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
          // Refresh data after successful payment
          ref.read(bills_state.billsRefreshProvider.notifier).refreshAll(ref);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment of \$${amount.toStringAsFixed(2)} successful!'),
              backgroundColor: AppColors.success,
            ),
          );
        },
        onPaymentError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment failed: $error'),
              backgroundColor: AppColors.error,
            ),
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
      child: SizedBox(
        height: 600, // Fixed height for the card
        child: billsAsync.when(
          loading: () => const AccountLedgerWidget(
            bills: [],
            isLoading: true,
          ),
          error: (e, st) => const AccountLedgerWidget(
            bills: [],
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
      ),
    );
  }
}
