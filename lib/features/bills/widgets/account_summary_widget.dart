import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/formatting_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/meter_readings_chart_widget.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../data/models/consumption.dart';
import '../../../data/models/user.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';
import '../state/bills_providers.dart';

class AccountSummaryWidget extends ConsumerWidget {
  const AccountSummaryWidget({
    super.key,
    required this.accountBalance,
    required this.usageSummary,
    this.yearlyConsumption,
    this.isLoading = false,
    this.onRefresh,
  });

  final AccountBalance accountBalance;
  final UsageSummary usageSummary;
  final Map<int, List<MonthlyConsumption>>? yearlyConsumption;
  final bool isLoading;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountDetailsAsync = ref.watch(accountDetailsProvider);
    
    return AppCard(
      title: Row(
        children: [
          Icon(Icons.account_balance_wallet, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: AppTheme.spacing8),
          const AppText(
            'Account Summary',
            style: AppTextStyle.title,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      child: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(AppTheme.spacing32),
                child: CircularProgressIndicator(),
              ),
            )
          : accountDetailsAsync.when(
              loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.spacing32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
              error: (_, __) => _buildAccountContent(context, null),
              data: (accountDetails) => _buildAccountContent(context, accountDetails),
            ),
    );
  }

  Widget _buildAccountContent(BuildContext context, EditableCustomerAccountDto? accountDetails) {
    if (accountDetails == null) {
      return const SizedBox.shrink();
    }

    // Parse values
    final balance = _parseBalance(accountDetails.balance);
    final currentBill = _parseBalance(accountDetails.currentBill);
    final pastDue = _parseBalance(accountDetails.pastDue);
    final deposit = _parseBalance(accountDetails.deposit);
    final lastBillAmount = _parseBalance(accountDetails.lastBillAmount);
    final lastPaymentAmount = _parseBalance(accountDetails.lastPaymentAmount);
    
    final isPaid = accountDetails.paid;
    final isOverdue = !isPaid && (pastDue > 0 || balance > 0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PRIMARY INFORMATION - Most Important (Top, Large, Bold)
        _buildPrimaryInfoCard(context, balance, accountDetails.dueDate, isPaid, isOverdue),
        const SizedBox(height: AppTheme.spacing16),
        
        // FINANCIAL OVERVIEW - Current Bills & Payments
        _buildFinancialOverviewCard(
          context,
          currentBill: currentBill,
          pastDue: pastDue,
          lastBillAmount: lastBillAmount,
          lastBillDate: accountDetails.lastBillDate,
          lastPaymentAmount: lastPaymentAmount,
          lastPaymentDate: accountDetails.lastPaymentDate,
          deposit: deposit,
        ),
        const SizedBox(height: AppTheme.spacing16),
        
        // ACCOUNT INFORMATION
        _buildAccountInfoCard(
          context,
          accountNumber: accountDetails.accountNumber,
          customerNumber: accountDetails.customerNumber,
          meter: accountDetails.meter,
          name: accountDetails.name,
          nickName: accountDetails.nickName,
          billCode: accountDetails.billCode,
        ),
        const SizedBox(height: AppTheme.spacing16),
        
        // CONTACT & ADDRESS INFORMATION
        _buildContactAddressCard(
          context,
          email: accountDetails.emailAddress,
          cell: accountDetails.cell,
          apartmentNumber: accountDetails.apartmentNumber,
          street: accountDetails.street,
          city: accountDetails.city,
          district: accountDetails.district,
        ),
        const SizedBox(height: AppTheme.spacing16),
        
        // STATUS & ADDITIONAL INFO
        if (accountDetails.collectionStatus != null && accountDetails.collectionStatus!.isNotEmpty)
          _buildStatusCard(context, accountDetails.collectionStatus!),
        
        const SizedBox(height: AppTheme.spacing16),
        
        // YEAR TO DATE SUMMARY
        _buildYTDSummary(context),
      ],
    );
  }

  /// Primary Information Card - Balance, Due Date, Status
  Widget _buildPrimaryInfoCard(
    BuildContext context,
    double balance,
    String? dueDate,
    bool isPaid,
    bool isOverdue,
  ) {
    final dueDateParsed = _parseDate(dueDate);
    final daysUntilDue = dueDateParsed != null
        ? dueDateParsed.difference(DateTime.now()).inDays
        : null;
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Balance - Largest, Boldest
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Current Balance',
                      style: AppTextStyle.body,
                      color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    // Dollar amounts are hidden in this version. They will be shown in a future release.
                    // AppText(
                    //   'BZ\$${balance.toStringAsFixed(2)}',
                    //   style: AppTextStyle.title,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing12,
                  vertical: AppTheme.spacing8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: AppText(
                  isPaid
                      ? 'Paid'
                      : isOverdue
                          ? 'Overdue'
                          : 'Due',
                  style: AppTextStyle.caption,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Next Due Date
          if (dueDateParsed != null) ...[
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Next Due Date',
                        style: AppTextStyle.caption,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Row(
                        children: [
                          AppText(
                            FormattingUtils.formatDate(dueDateParsed),
                            style: AppTextStyle.subtitle,
                            fontWeight: FontWeight.w600,
                          ),
                          if (daysUntilDue != null && !isPaid) ...[
                            const SizedBox(width: AppTheme.spacing8),
                            AppText(
                              daysUntilDue == 0
                                  ? '(Due today)'
                                  : daysUntilDue > 0
                                      ? '($daysUntilDue days)'
                                      : '(${daysUntilDue.abs()} days overdue)',
                              style: AppTextStyle.caption,
                              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Financial Overview Card
  Widget _buildFinancialOverviewCard(
    BuildContext context, {
    required double currentBill,
    required double pastDue,
    required double lastBillAmount,
    String? lastBillDate,
    required double lastPaymentAmount,
    String? lastPaymentDate,
    required double deposit,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Financial Overview',
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Current Bill & Past Due Row - Responsive
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              if (isMobile) {
                return Column(
                  children: [
                    _buildFinancialItem(
                      context,
                      'Current Bill',
                      // Dollar amounts are hidden in this version. They will be shown in a future release.
                      // 'BZ\$${currentBill.toStringAsFixed(2)}',
                      '',
                      Icons.receipt,
                      AppColors.primary,
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildFinancialItem(
                      context,
                      'Past Due',
                      // Dollar amounts are hidden in this version. They will be shown in a future release.
                      // 'BZ\$${pastDue.toStringAsFixed(2)}',
                      '',
                      Icons.warning_amber_rounded,
                      pastDue > 0 ? AppColors.error : AppColors.success,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildFinancialItem(
                      context,
                      'Current Bill',
                      // Dollar amounts are hidden in this version. They will be shown in a future release.
                      // 'BZ\$${currentBill.toStringAsFixed(2)}',
                      '',
                      Icons.receipt,
                      AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildFinancialItem(
                      context,
                      'Past Due',
                      // Dollar amounts are hidden in this version. They will be shown in a future release.
                      // 'BZ\$${pastDue.toStringAsFixed(2)}',
                      '',
                      Icons.warning_amber_rounded,
                      pastDue > 0 ? AppColors.error : AppColors.success,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          // Last Bill Row - Responsive
          if (lastBillAmount > 0 || lastBillDate != null)
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                if (isMobile) {
                  return Column(
                    children: [
                      _buildFinancialItem(
                        context,
                        'Last Bill',
                        lastBillDate != null
                            ? FormattingUtils.formatDate(_parseDate(lastBillDate) ?? DateTime.now())
                            : 'N/A',
                        Icons.description,
                        Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // subtitle: lastBillAmount > 0 ? 'BZ\$${lastBillAmount.toStringAsFixed(2)}' : null,
                        subtitle: null,
                      ),
                      const SizedBox(height: AppTheme.spacing12),
                      _buildFinancialItem(
                        context,
                        'Last Payment',
                        lastPaymentDate != null
                            ? FormattingUtils.formatDate(_parseDate(lastPaymentDate) ?? DateTime.now())
                            : 'N/A',
                        Icons.payment,
                        AppColors.success,
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // subtitle: lastPaymentAmount > 0 ? 'BZ\$${lastPaymentAmount.toStringAsFixed(2)}' : null,
                        subtitle: null,
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: _buildFinancialItem(
                        context,
                        'Last Bill',
                        lastBillDate != null
                            ? FormattingUtils.formatDate(_parseDate(lastBillDate) ?? DateTime.now())
                            : 'N/A',
                        Icons.description,
                        Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // subtitle: lastBillAmount > 0 ? 'BZ\$${lastBillAmount.toStringAsFixed(2)}' : null,
                        subtitle: null,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: _buildFinancialItem(
                        context,
                        'Last Payment',
                        lastPaymentDate != null
                            ? FormattingUtils.formatDate(_parseDate(lastPaymentDate) ?? DateTime.now())
                            : 'N/A',
                        Icons.payment,
                        AppColors.success,
                        // Dollar amounts are hidden in this version. They will be shown in a future release.
                        // subtitle: lastPaymentAmount > 0 ? 'BZ\$${lastPaymentAmount.toStringAsFixed(2)}' : null,
                        subtitle: null,
                      ),
                    ),
                  ],
                );
              },
            ),
          if (deposit != 0) ...[
            const SizedBox(height: AppTheme.spacing12),
            _buildFinancialItem(
              context,
              'Deposit',
              // Dollar amounts are hidden in this version. They will be shown in a future release.
              // 'BZ\$${deposit.abs().toStringAsFixed(2)}',
              '',
              Icons.account_balance,
              deposit < 0 ? AppColors.success : AppColors.info,
              subtitle: deposit < 0 ? 'Credit' : 'Debit',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFinancialItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color, {
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: AppText(
                  label,
                  style: AppTextStyle.caption,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          AppText(
            value,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppTheme.spacing4),
            AppText(
              subtitle,
              style: AppTextStyle.caption,
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
          ],
        ],
      ),
    );
  }

  /// Account Information Card
  Widget _buildAccountInfoCard(
    BuildContext context, {
    String? accountNumber,
    String? customerNumber,
    String? meter,
    String? name,
    String? nickName,
    String? billCode,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Account Information',
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Account & Customer Numbers - Responsive
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              if (isMobile) {
                return Column(
                  children: [
                    _buildInfoRow(
                      context,
                      'Account Number',
                      accountNumber ?? 'N/A',
                      Icons.numbers,
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildInfoRow(
                      context,
                      'Customer Number',
                      customerNumber ?? 'N/A',
                      Icons.person,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      context,
                      'Account Number',
                      accountNumber ?? 'N/A',
                      Icons.numbers,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildInfoRow(
                      context,
                      'Customer Number',
                      customerNumber ?? 'N/A',
                      Icons.person,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          // Meter Number & Bill Code - Responsive
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              if (isMobile) {
                return Column(
                  children: [
                    _buildInfoRow(
                      context,
                      'Meter Number',
                      meter ?? 'N/A',
                      Icons.electrical_services,
                    ),
                    const SizedBox(height: AppTheme.spacing12),
                    _buildInfoRow(
                      context,
                      'Account Type',
                      billCode ?? 'N/A',
                      Icons.category,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      context,
                      'Meter Number',
                      meter ?? 'N/A',
                      Icons.electrical_services,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: _buildInfoRow(
                      context,
                      'Account Type',
                      billCode ?? 'N/A',
                      Icons.category,
                    ),
                  ),
                ],
              );
            },
          ),
          if (name != null && name.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing12),
            _buildInfoRow(
              context,
              'Account Name',
              name,
              Icons.badge,
            ),
          ],
          if (nickName != null && nickName.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing12),
            _buildInfoRow(
              context,
              'Nickname',
              nickName,
              Icons.label,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
        ),
        const SizedBox(width: AppTheme.spacing8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                label,
                style: AppTextStyle.caption,
                color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
              const SizedBox(height: AppTheme.spacing4),
              AppText(
                value,
                style: AppTextStyle.body,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Contact & Address Card
  Widget _buildContactAddressCard(
    BuildContext context, {
    String? email,
    String? cell,
    String? apartmentNumber,
    String? street,
    String? city,
    String? district,
  }) {
    final addressParts = <String>[];
    if (apartmentNumber != null && apartmentNumber.isNotEmpty) {
      addressParts.add(apartmentNumber);
    }
    if (street != null && street.isNotEmpty) {
      addressParts.add(street);
    }
    if (city != null && city.isNotEmpty) {
      addressParts.add(city);
    }
    if (district != null && district.isNotEmpty) {
      addressParts.add(district);
    }
    final fullAddress = addressParts.join(', ');

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Contact & Address',
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: AppTheme.spacing16),
          if (email != null && email.isNotEmpty)
            _buildInfoRow(
              context,
              'Email',
              email,
              Icons.email,
            ),
          if (email != null && email.isNotEmpty && cell != null && cell.isNotEmpty)
            const SizedBox(height: AppTheme.spacing12),
          if (cell != null && cell.isNotEmpty)
            _buildInfoRow(
              context,
              'Phone',
              cell,
              Icons.phone,
            ),
          if ((email != null && email.isNotEmpty) || (cell != null && cell.isNotEmpty))
            const SizedBox(height: AppTheme.spacing12),
          if (fullAddress.isNotEmpty)
            _buildInfoRow(
              context,
              'Service Address',
              fullAddress,
              Icons.location_on,
            ),
        ],
      ),
    );
  }

  /// Status Card
  Widget _buildStatusCard(BuildContext context, String collectionStatus) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Collection Status',
                  style: AppTextStyle.caption,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
                const SizedBox(height: AppTheme.spacing4),
                AppText(
                  collectionStatus,
                  style: AppTextStyle.body,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Year to Date Summary
  Widget _buildYTDSummary(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Year to Date',
              style: AppTextStyle.subtitle,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Usage',
                    '${usageSummary.yearToDate.kwh.toStringAsFixed(0)} kWh',
                  ),
                ),
                Expanded(
                  child: _buildYTDItem(
                    context,
                    'Avg Daily',
                    '${usageSummary.yearToDate.averageDaily.toStringAsFixed(1)} kWh',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            _buildYTDChart(context),
          ],
        ),
      );

  Widget _buildYTDItem(BuildContext context, String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label,
            style: AppTextStyle.caption,
          ),
          const SizedBox(height: AppTheme.spacing4),
          AppText(
            value,
            style: AppTextStyle.subtitle,
            fontWeight: FontWeight.w600,
          ),
        ],
      );

  Widget _buildYTDChart(BuildContext context) {
    // Use the reusable meter readings chart widget with summary configuration
    return MeterReadingsChartWidget(
      config: const MeterReadingsChartConfig(
        showYAxis: false, // No Y-axis values
        showYAxisLabel: false, // No Y-axis label
        showTooltips: false, // No hover tooltips
        showClickableDataPoints: false, // No clickable data points
        showLegend: true, // Show legend with year numbers
        height: 120.0, // Compact height for summary
        showNavigationButton: true, // Show shortcut to usage page
      ),
    );
  }

  /// Helper methods for parsing
  double _parseBalance(String? balanceStr) {
    if (balanceStr == null || balanceStr.isEmpty) {
      return 0.0;
    }
    try {
      final isCredit = balanceStr.toUpperCase().contains('CR') ||
          (balanceStr.contains('(') && balanceStr.contains(')'));
      
      final cleaned = balanceStr
          .replaceAll(r'$', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('CR', '')
          .replaceAll(',', '')
          .trim();

      var balance = double.tryParse(cleaned) ?? 0.0;
      
      if (isCredit && balance > 0) {
        balance = -balance;
      }
      
      return balance;
    } catch (e) {
      return 0.0;
    }
  }

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    
    try {
      final formats = [
        'EEEE d MMM yyyy', // "Thursday 18 Dec 2025"
        'd MMM yyyy',      // "18 Dec 2025"
        'yyyy-MM-dd',      // "2025-12-18"
        'MM/dd/yyyy',      // "12/18/2025"
      ];

      for (final format in formats) {
        try {
          final formatter = DateFormat(format);
          return formatter.parse(dateStr);
        } catch (_) {
          continue;
        }
      }
      
      return DateTime.tryParse(dateStr);
    } catch (e) {
      return null;
    }
  }
}
