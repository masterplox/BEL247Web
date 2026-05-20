import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/customer_portal_support_types.dart';
import 'customer_portal_support_dialog.dart';

/// Shows feedback / support (shell FAB) — same form as Customer Portal Support.
Future<void> showAppSupportDialog(BuildContext context, WidgetRef ref) async {
  final matchedLocation = GoRouterState.of(context).matchedLocation;
  await showCustomerPortalSupportDialog(
    context,
    ref,
    sourcePage: matchedLocation,
    initialSupportType: CustomerPortalSupportTypes.general,
  );
}
