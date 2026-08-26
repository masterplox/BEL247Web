import 'package:flutter/material.dart';

/// A [SingleChildScrollView] that fills the parent, so wheel/trackpad
/// scroll works anywhere in that region, not only over the inner child.
///
/// Use this instead of `Center` + a short scroll view. The centered child
/// pattern shrinks the scrollable hit target to the form width.
class FillViewportScroll extends StatelessWidget {
  const FillViewportScroll({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final minWidth =
              constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;
          final minHeight =
              constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;
          return SingleChildScrollView(
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minWidth,
                minHeight: minHeight,
              ),
              child: ColoredBox(
                color: Colors.transparent,
                child: child,
              ),
            ),
          );
        },
      );
}
