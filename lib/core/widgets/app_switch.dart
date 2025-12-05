import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      // You can add more customization here to match your theme
      // For example:
      // activeColor: Theme.of(context).colorScheme.primary,
      // activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      // inactiveThumbColor: Colors.grey,
      // inactiveTrackColor: Colors.grey.withOpacity(0.5),
    );
  }
}
