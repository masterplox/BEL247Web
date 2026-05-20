import 'package:flutter/material.dart';

import 'app_dialog.dart';

/// Placeholder username/password rules (replace with official copy later).
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
            _GuidelineItem('Use at least 3 characters.'),
            _GuidelineItem('Use only letters, numbers, and common symbols.'),
            _GuidelineItem('Avoid spaces at the beginning or end.'),
            _GuidelineItem('Choose something you can remember but others cannot guess.'),
            _GuidelineItem('Do not share your username with anyone.'),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 8),
            _GuidelineItem('Use at least 8 characters.'),
            _GuidelineItem('Include uppercase and lowercase letters.'),
            _GuidelineItem('Include at least one number.'),
            _GuidelineItem('Include at least one special character.'),
            _GuidelineItem('Do not reuse passwords from other websites.'),
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
