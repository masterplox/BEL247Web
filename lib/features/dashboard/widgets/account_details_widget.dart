import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../data/models/api_response_dtos.dart';
import '../../../features/bills/state/bills_providers.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/colors.dart';

/// Account details widget matching the React version design
class AccountDetailsWidget extends ConsumerWidget {
  const AccountDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountDetailsAsync = ref.watch(accountDetailsProvider);

    return accountDetailsAsync.when(
      loading: () => _buildLoadingCard(context),
      error: (_, __) => const SizedBox.shrink(),
      data: (accountDetails) {
        if (accountDetails == null) {
          return const SizedBox.shrink();
        }

        return AppCard(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          showBorder: true,
          borderWidth: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Info',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                  TextButton(
                    onPressed: () => _showFullDetailsDialog(context, accountDetails),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
                      minimumSize: const Size(0, 28),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(width: AppTheme.spacing4),
                        const Icon(
                          Icons.chevron_right,
                          size: 12,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              // Quick Info Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  // Use responsive constraints to determine layout
                  final screenWidth = MediaQuery.of(context).size.width;
                  final isMobile = screenWidth < AppTheme.tabletBreakpoint;

                  final address = _formatAddress(
                    accountDetails.street,
                    accountDetails.apartmentNumber,
                    accountDetails.district,
                    accountDetails.city,
                  );
                  final items = [
                    _buildInfoItem(
                      context,
                      Icons.badge_outlined,
                      'Customer type',
                      accountDetails.billCode ?? '',
                    ),
                    _buildInfoItem(
                      context,
                      Icons.location_on,
                      'Address',
                      address,
                    ),
                    _buildInfoItem(
                      context,
                      Icons.person_outline,
                      'Customer number',
                      accountDetails.customerNumber ?? '',
                    ),
                    _buildInfoItem(
                      context,
                      Icons.numbers,
                      'Account number',
                      accountDetails.accountNumber ?? '',
                    ),
                  ];
                  
                  if (isMobile) {
                    // Mobile: Single column layout (one per row)
                    return Column(
                      children: items
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                                child: item,
                              ))
                          .toList(),
                    );
                  }
                  
                  // Tablet or Desktop: 2-column grid with responsive sizing
                  // Calculate available width for cards (accounting for spacing)
                  final availableWidth = constraints.maxWidth;
                  const crossAxisSpacing = AppTheme.spacing12;
                  final cardWidth = (availableWidth - crossAxisSpacing) / 2;
                  
                  // Use Wrap widget for flexible grid that allows natural height
                  return Wrap(
                    spacing: crossAxisSpacing,
                    runSpacing: AppTheme.spacing12,
                    children: items.map((item) => SizedBox(
                        width: cardWidth,
                        child: item,
                      )).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingCard(BuildContext context) => const AppCard(
      padding: EdgeInsets.all(AppTheme.spacing20),
      showBorder: true,
      borderWidth: 1,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? color,
    Color? bgColor,
  }) {
    final defaultColor = color ?? AppColors.textSecondary;
    final defaultBgColor = bgColor;

    return AppCard(
      padding: const EdgeInsets.all(AppTheme.spacing8),
      color: defaultBgColor,
      showBorder: true,
      borderWidth: 1,
      borderRadius: AppTheme.radius8,
      child: Row(
        children: [
          Icon(icon, size: 16, color: defaultColor),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: defaultColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullDetailsDialog(BuildContext context, EditableCustomerAccountDto accountDetails) {
    final creditStatus = _getCreditStatus(accountDetails.collectionStatus ?? '');

    AppDialog.showCenter(
      context: context,
      title: 'Account Details',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Personal Information'),
          _buildDetailRow(context, 'Name', accountDetails.name ?? ''),
          _buildDetailRow(context, 'Phone', accountDetails.cell ?? ''),
          _buildDetailRow(context, 'Email', accountDetails.emailAddress ?? ''),
          const SizedBox(height: AppTheme.spacing16),
          _buildSectionTitle(context, 'Service Address'),
          _buildDetailRow(context, 'Street', accountDetails.street ?? ''),
          _buildDetailRow(context, 'District', accountDetails.district ?? ''),
          if ((accountDetails.apartmentNumber ?? '').isNotEmpty)
            _buildDetailRow(context, 'Apt #', accountDetails.apartmentNumber ?? ''),
          const SizedBox(height: AppTheme.spacing16),
          _buildSectionTitle(context, 'Account Details'),
          _buildDetailRow(context, 'Customer #', accountDetails.customerNumber ?? ''),
          _buildDetailRow(context, 'Account #', accountDetails.accountNumber ?? ''),
          _buildDetailRow(context, 'Meter #', accountDetails.meter ?? ''),
          _buildDetailRow(context, 'Bill Code', accountDetails.billCode ?? ''),
          _buildDetailRow(
            context,
            'Credit Status',
            accountDetails.collectionStatus ?? ''
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) => Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing12, top: AppTheme.spacing8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
      ),
    );

  Widget _buildDetailRow(BuildContext context, String label, String value, {Color? color}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: color,
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );

  String _getCreditStatus(String collectionStatus) {
    final status = collectionStatus.toLowerCase();
    if (status.contains('poor')) {
      return 'destructive';
    } else if (status.contains('good')) {
      return 'primary';
    } else {
      return 'warning';
    }
  }

  String _formatCreditStatus(String collectionStatus) {
    if (collectionStatus.toUpperCase().contains('POOR')) {
      return 'Poor';
    } else if (collectionStatus.toUpperCase().contains('GOOD')) {
      return 'Good';
    } else {
      return 'Fair';
    }
  }

  String _formatAddress(
    String? street,
    String? apartmentNumber,
    String? district,
    String? city,
  ) {
    final parts = <String>[
      street ?? '',
      if (apartmentNumber != null && apartmentNumber.isNotEmpty) 'Apt $apartmentNumber',
      district ?? '',
      city ?? '',
    ].where((s) => s.isNotEmpty).toList();
    return parts.join(', ');
  }
}
