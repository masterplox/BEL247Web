import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/colors.dart';
import 'customer_portal_support_dialog.dart';

/// Opens [showCustomerPortalSupportDialog] with an optional pre-selected category.
class CustomerPortalSupportButton extends ConsumerWidget {
  const CustomerPortalSupportButton({
    required this.sourcePage,
    this.initialSupportType,
    this.label = 'Customer Portal Support',
    super.key,
  });

  final String sourcePage;
  final String? initialSupportType;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton.icon(
        onPressed: () => showCustomerPortalSupportDialog(
          context,
          ref,
          sourcePage: sourcePage,
          initialSupportType: initialSupportType,
        ),
        icon: const Icon(Icons.support_agent_outlined, size: 18),
        label: Text(label),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        ),
      );
}
