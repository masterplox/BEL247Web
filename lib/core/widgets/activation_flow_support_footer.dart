import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/customer_portal_support_types.dart';
import 'customer_portal_support_button.dart';

/// Support link shown on code-entry steps in activation flows.
class ActivationFlowSupportFooter extends ConsumerWidget {
  const ActivationFlowSupportFooter({
    required this.sourcePage,
    required this.supportType,
    super.key,
  });

  final String sourcePage;
  final String supportType;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Center(
          child: CustomerPortalSupportButton(
            sourcePage: sourcePage,
            initialSupportType: supportType,
          ),
        ),
      );
}

/// Premium upgrade code support.
Widget premiumUpgradeSupportFooter(String sourcePage) =>
    ActivationFlowSupportFooter(
      sourcePage: sourcePage,
      supportType: CustomerPortalSupportTypes.premiumUpgradeCode,
    );

/// Bill download code support.
Widget billDownloadSupportFooter(String sourcePage) =>
    ActivationFlowSupportFooter(
      sourcePage: sourcePage,
      supportType: CustomerPortalSupportTypes.billDownloadCode,
    );
