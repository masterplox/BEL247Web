import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable detail row widget for displaying key-value pairs.
class AppDetailRow extends StatelessWidget {
  const AppDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final bool isTotal;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: isTotal ? AppTheme.spacing8 : AppTheme.spacing4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: labelStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                      ),
            ),
          ),
          Text(
            value,
            style: valueStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
                    ),
          ),
        ],
      ),
    );
}

