import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  outlined,
  text,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonType = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String text;
  final AppButtonType buttonType;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final onPressedCallback = isLoading ? null : onPressed;

    Widget buttonContent = Text(text);
    if (isLoading) {
      buttonContent = const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    } else if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    switch (buttonType) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: onPressedCallback,
          child: buttonContent,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressedCallback,
          child: buttonContent,
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: onPressedCallback,
          child: buttonContent,
        );
    }
  }
}
