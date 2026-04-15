import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../analytics/app_page_names.dart';
import '../providers/engagement_providers.dart';
import '../providers/feature_providers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_dialog.dart';
import 'app_toast.dart';

/// Shows feedback / support request dialog (API: AppSupportRequestGen).
///
/// [context] must be under [GoRouter] (e.g. shell content). Route is read here
/// because the dialog overlay is not under GoRouter's subtree.
Future<void> showAppSupportDialog(BuildContext context, WidgetRef ref) async {
  final matchedLocation = GoRouterState.of(context).matchedLocation;
  final pageLabel = AppPageNames.navigationSubtypeForRoute(matchedLocation);
  await AppDialog.showCenter(
    context: context,
    title: 'Send feedback',
    subtitle: 'Tell us what we can improve. We\'ll route this to our support team.',
    maxWidth: 480,
    content: _AppSupportForm(
      sourcePage: matchedLocation,
      pageLabel: pageLabel,
    ),
    barrierDismissible: true,
  );
}

class _AppSupportForm extends ConsumerStatefulWidget {
  const _AppSupportForm({
    required this.sourcePage,
    required this.pageLabel,
  });

  /// Raw path for API SourcePage (e.g. `/bills`).
  final String sourcePage;

  /// Friendly label for display only.
  final String pageLabel;

  @override
  ConsumerState<_AppSupportForm> createState() => _AppSupportFormState();
}

class _AppSupportFormState extends ConsumerState<_AppSupportForm> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _submitting = false;

  /// After the first failed submit, use live validation so the error outline
  /// clears as the user types (AutovalidateMode.onUserInteraction).
  bool _autovalidateMessage = false;

  @override
  void initState() {
    super.initState();
    final session = ref.read(authNotifierProvider).userSession;
    if (session != null) {
      _phoneController.text = session.preferences['phone'] as String? ?? '';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMessage = true);
      return;
    }

    final session = ref.read(authNotifierProvider).userSession;
    if (session == null) {
      AppToast.error(context, 'You must be signed in to send feedback.');
      return;
    }

    final account = ref.read(accountSwitcherProvider).activeAccount;

    setState(() => _submitting = true);
    try {
      final repo = ref.read(appSupportRepositoryProvider);
      final ok = await repo.submitRequest(
        contactFullName: '${session.firstName} ${session.lastName}'.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: session.email,
        requestMessage: _messageController.text.trim(),
        sourcePage: widget.sourcePage,
        accountNumber: account?.accountNumber ?? '',
        customerNumber: account?.customerNumber ?? '',
      );
      if (!mounted) return;
      if (ok) {
        Navigator.of(context, rootNavigator: true).pop();
        AppToast.success(context, 'Thanks — your message was sent.');
      } else {
        AppToast.error(context, 'Could not send feedback. Please try again.');
      }
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'Could not send feedback. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(authNotifierProvider).userSession;
    final account = ref.watch(accountSwitcherProvider).activeAccount;

    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMessage
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (session != null) ...[
              Text(
                '${session.firstName} ${session.lastName}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                session.email,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing12),
            ],
            Text(
              'Page: ${widget.pageLabel}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (account != null) ...[
              const SizedBox(height: 4),
              Text(
                'Account ${account.accountNumber} · Customer ${account.customerNumber}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
            const SizedBox(height: AppTheme.spacing16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone (optional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppTheme.spacing12),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Your message',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (v) {
                final t = v?.trim() ?? '';
                if (t.length < 8) {
                  return 'Please enter at least a few words.';
                }
                return null;
              },
            ),
            const SizedBox(height: AppTheme.spacing16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Send'),
              ),
            ),
          ],
        ),
    );
  }
}
