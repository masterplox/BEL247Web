import 'package:flutter/material.dart';

import 'app_dialog.dart';

Future<void> showCredentialGuidelinesDialog(BuildContext context) =>
    AppDialog.showCenter(
      context: context,
      title: 'Username & password guidelines',
      maxWidth: 480,
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 8),
            _GuidelineItem('At least 6 characters'),
            _GuidelineItem('Maximum of 30 characters'),
            _GuidelineItem('Can contain lower and uppercase letters'),
            _GuidelineItem('Can contain period (.) and underscore (_) characters'),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 8),
            _GuidelineItem('At least one number'),
            _GuidelineItem('At least one lowercase character'),
            _GuidelineItem('At least one uppercase character'),
            _GuidelineItem('At least one special character'),
            _GuidelineItem('At least 8 characters in length'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Close'),
        ),
      ],
    );

class _GuidelineItem extends StatelessWidget {
  const _GuidelineItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('•  '),
            Expanded(child: Text(text)),
          ],
        ),
      );
}
