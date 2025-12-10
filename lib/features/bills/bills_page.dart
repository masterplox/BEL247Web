import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_error_state.dart';
import '../../core/widgets/app_loading_state.dart';
import '../../core/widgets/app_page_header.dart';
import '../../core/widgets/app_responsive_layout.dart';
import '../../data/models/user.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'state/bills_providers.dart';
import 'widgets/account_ledger_widget.dart';
import 'widgets/account_summary_widget.dart';
// Commented out - replaced with Account Ledger
// import 'widgets/bill_download_widget.dart';
// import 'widgets/billing_history_list.dart';
import 'widgets/payment_widget.dart';

class BillsPage extends ConsumerWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        //backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Bills & Receipts'),
          centerTitle: true,
          elevation: 0,
          actions: const [
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () {
            //     ref.read(billsRefreshProvider.notifier).refreshAll(ref);
            //   },
            // ),
          ],
        ),
        body: const BillsLayout(),
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
        padding: EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillsHeader(),
            SizedBox(height: AppTheme.spacing24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      AccountSummaryCard(),
                      SizedBox(height: AppTheme.spacing16),
                      PaymentCard(),
                    ],
                  ),
                ),
                SizedBox(width: AppTheme.spacing16),
                Expanded(
                  flex: 2,
                  child: AccountLedgerCard(),
                ),
              ],
            ),
          ],
        ),
      );
}

class TabletBillsLayout extends ConsumerWidget {
  const TabletBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillsHeader(),
            SizedBox(height: AppTheme.spacing20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AccountSummaryCard(),
                ),
                SizedBox(width: AppTheme.spacing16),
                Expanded(
                  child: PaymentCard(),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacing20),
            AccountLedgerCard(),
          ],
        ),
      );
}

class MobileBillsLayout extends ConsumerWidget {
  const MobileBillsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BillsHeader(),
            SizedBox(height: AppTheme.spacing16),
            Column(
              children: [
                AccountSummaryCard(),
                SizedBox(height: AppTheme.spacing16),
                PaymentCard(),
                SizedBox(height: AppTheme.spacing16),
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
        title: 'Bills & Receipts',
        subtitle: 'Manage your billing history, payments, and account summary',
      );
}

class AccountSummaryCard extends ConsumerWidget {
  const AccountSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountBalanceAsync = ref.watch(accountBalanceProvider);
    final usageSummaryAsync = ref.watch(usageSummaryProvider);
    final yearlyConsumptionAsync = ref.watch(yearlyConsumptionProvider);
    
    return accountBalanceAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, st) => AppErrorState(
        message: 'Error loading account summary: $e',
        onRetry: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
      ),
      data: (accountBalance) => usageSummaryAsync.when(
        loading: () => AccountSummaryWidget(
          accountBalance: accountBalance,
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
          isLoading: true,
          onRefresh: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
        ),
        error: (e, st) => AccountSummaryWidget(
          accountBalance: accountBalance,
          usageSummary: const UsageSummary(
            currentMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            lastMonth: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
            yearToDate: UsagePeriod(kwh: 0, cost: 0, averageDaily: 0),
          ),
          onRefresh: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
        ),
        data: (usageSummary) => yearlyConsumptionAsync.when(
          loading: () => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            isLoading: true,
            onRefresh: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
          ),
          error: (e, st) => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            onRefresh: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
          ),
          data: (yearlyConsumption) => AccountSummaryWidget(
            accountBalance: accountBalance,
            usageSummary: usageSummary,
            yearlyConsumption: yearlyConsumption,
            onRefresh: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
          ),
        ),
      ),
    );
  }
}

class PaymentCard extends ConsumerWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountBalanceAsync = ref.watch(accountBalanceProvider);
    
    return accountBalanceAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, st) => AppErrorState(
        message: 'Error loading account balance: $e',
        onRetry: () => ref.read(billsRefreshProvider.notifier).refreshAll(ref),
      ),
      data: (accountBalance) => PaymentWidget(
        accountBalance: accountBalance,
        onPaymentSuccess: (amount, method) {
          // Refresh data after successful payment
          ref.read(billsRefreshProvider.notifier).refreshAll(ref);
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
      ),
    );
  }
}

// Account Ledger Card - replaces BillingHistoryCard and BillDownloadCard
class AccountLedgerCard extends ConsumerWidget {
  const AccountLedgerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(billsProvider);
    
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
          data: (bills) => AccountLedgerWidget(
            bills: bills,
            onDownloadBill: (bill) {
              // TODO: Implement bill download
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading bill #${bill.billNumber}...'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            onDownloadReceipt: (payment) {
              // TODO: Implement receipt download
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading receipt...'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            onViewFullDetails: (payment) {
              // TODO: Navigate to full payment details
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
