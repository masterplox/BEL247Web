import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../constants/customer_portal_support_types.dart';
import '../providers/engagement_providers.dart';
import '../providers/feature_providers.dart';
import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'app_dialog.dart';
import 'app_toast.dart';

/// Shows Customer Portal Support with category dropdown and optional guest fields.
Future<void> showCustomerPortalSupportDialog(
  BuildContext context,
  WidgetRef ref, {
  required String sourcePage,
  String? initialSupportType,
}) async {
  await AppDialog.showCenter(
    context: context,
    title: 'Customer Portal Support',
    subtitle:
        'Tell us what happened. We\'ll route your request to our support team.',
    maxWidth: 480,
    content: _CustomerPortalSupportForm(
      sourcePage: sourcePage,
      initialSupportType:
          initialSupportType ?? CustomerPortalSupportTypes.general,
    ),
    barrierDismissible: true,
  );
}

class _CustomerPortalSupportForm extends ConsumerStatefulWidget {
  const _CustomerPortalSupportForm({
    required this.sourcePage,
    required this.initialSupportType,
  });

  /// Sent to API as [SourcePage]; not shown in the UI.
  final String sourcePage;
  final String initialSupportType;

  @override
  ConsumerState<_CustomerPortalSupportForm> createState() =>
      _CustomerPortalSupportFormState();
}

class _CustomerPortalSupportFormState
    extends ConsumerState<_CustomerPortalSupportForm> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  late String _supportType;
  bool _submitting = false;
  bool _autovalidate = false;

  @override
  void initState() {
    super.initState();
    _supportType = widget.initialSupportType;
    final session = ref.read(authNotifierProvider).userSession;
    if (session != null) {
      _nameController.text =
          '${session.firstName} ${session.lastName}'.trim();
      _emailController.text = session.email;
      _phoneController.text = session.preferences['phone'] as String? ?? '';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = true);
      return;
    }

    final session = ref.read(authNotifierProvider).userSession;
    final account = ref.read(accountSwitcherProvider).activeAccount;

    setState(() => _submitting = true);
    try {
      final repo = ref.read(appSupportRepositoryProvider);
      final ok = await repo.submitRequest(
        contactFullName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        requestMessage: _messageController.text.trim(),
        sourcePage: widget.sourcePage,
        accountNumber: account?.accountNumber ?? '',
        customerNumber: account?.customerNumber ?? '',
        supportType: _supportType,
        authenticated: session != null,
      );
      if (!mounted) return;
      if (ok) {
        Navigator.of(context, rootNavigator: true).pop();
        AppToast.success(context, 'Thanks — your message was sent.');
      } else {
        AppToast.error(context, 'Could not send your request. Please try again.');
      }
    } catch (_) {
      if (mounted) {
        AppToast.error(context, 'Could not send your request. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(authNotifierProvider).userSession;
    final account = ref.watch(accountSwitcherProvider).activeAccount;
    final isGuest = session == null;

    return Form(
      key: _formKey,
      autovalidateMode:
          _autovalidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (account != null) ...[
            Text(
              'Account ${account.accountNumber} · Customer ${account.customerNumber}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppTheme.spacing16),
          ],
          DropdownButtonFormField<String>(
            value: _supportType,
            decoration: const InputDecoration(
              labelText: 'Support category',
              border: OutlineInputBorder(),
            ),
            items: CustomerPortalSupportTypes.all
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: _submitting
                ? null
                : (value) {
                    if (value != null) setState(() => _supportType = value);
                  },
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (isGuest) ...[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full name',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: AppTheme.spacing12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: AppTheme.spacing12),
          ],
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
