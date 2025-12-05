import 'package:flutter/material.dart';

enum AppTextStyle {
  title,
  subtitle,
  body,
  caption,
  button,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextStyle style;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const AppText(
    this.text, {
    super.key,
    this.style = AppTextStyle.body,
    this.color,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(context),
      textAlign: textAlign,
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (style) {
      case AppTextStyle.title:
        return textTheme.headlineMedium?.copyWith(color: color, fontWeight: fontWeight);
      case AppTextStyle.subtitle:
        return textTheme.titleMedium?.copyWith(color: color, fontWeight: fontWeight);
      case AppTextStyle.body:
        return textTheme.bodyMedium?.copyWith(color: color, fontWeight: fontWeight);
      case AppTextStyle.caption:
        return textTheme.bodySmall?.copyWith(color: color, fontWeight: fontWeight);
      case AppTextStyle.button:
        return textTheme.labelLarge?.copyWith(color: color, fontWeight: fontWeight);
      default:
        return textTheme.bodyMedium?.copyWith(color: color, fontWeight: fontWeight);
    }
  }
}
