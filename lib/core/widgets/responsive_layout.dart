import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

/// Responsive container that adapts to different screen sizes
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.alignment,
    this.decoration,
    this.constraints,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final Alignment? alignment;
  final Decoration? decoration;
  final BoxConstraints? constraints;
  
  // Responsive overrides
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? mobileMargin;
  final EdgeInsets? tabletMargin;
  final EdgeInsets? desktopMargin;
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;

  @override
  Widget build(BuildContext context) {
    final responsivePadding = context.responsive(
      mobile: mobilePadding ?? padding,
      tablet: tabletPadding ?? padding,
      desktop: desktopPadding ?? padding,
    );
    
    final responsiveMargin = context.responsive(
      mobile: mobileMargin ?? margin,
      tablet: tabletMargin ?? margin,
      desktop: desktopMargin ?? margin,
    );
    
    final responsiveMaxWidth = context.responsiveMaxWidth(
      mobileMaxWidth: mobileMaxWidth ?? maxWidth,
      tabletMaxWidth: tabletMaxWidth ?? maxWidth,
      desktopMaxWidth: desktopMaxWidth ?? maxWidth,
    );

    return Container(
      padding: responsivePadding,
      margin: responsiveMargin,
      width: width,
      height: height,
      alignment: alignment,
      decoration: decoration,
      constraints: constraints?.copyWith(
        maxWidth: responsiveMaxWidth,
        maxHeight: maxHeight,
        minWidth: minWidth,
        minHeight: minHeight,
      ) ?? BoxConstraints(
        maxWidth: responsiveMaxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
        minWidth: minWidth ?? 0,
        minHeight: minHeight ?? 0,
      ),
      child: child,
    );
  }
}

/// Responsive grid that adapts column count based on screen size
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns,
    this.desktopColumns,
    this.mobileSpacing = 8.0,
    this.tabletSpacing,
    this.desktopSpacing,
    this.mobileChildAspectRatio = 1.0,
    this.tabletChildAspectRatio,
    this.desktopChildAspectRatio,
    this.padding,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.physics,
    this.shrinkWrap = false,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final double mobileChildAspectRatio;
  final double? tabletChildAspectRatio;
  final double? desktopChildAspectRatio;
  final EdgeInsets? padding;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final columns = context.responsiveColumns(
      mobileColumns: mobileColumns,
      tabletColumns: tabletColumns,
      desktopColumns: desktopColumns,
    );
    
    final spacing = context.responsive(
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing,
      desktop: desktopSpacing ?? tabletSpacing ?? mobileSpacing,
    );
    
    final aspectRatio = context.responsive(
      mobile: mobileChildAspectRatio,
      tablet: tabletChildAspectRatio ?? mobileChildAspectRatio,
      desktop: desktopChildAspectRatio ?? tabletChildAspectRatio ?? mobileChildAspectRatio,
    );

    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: mainAxisSpacing ?? spacing,
      crossAxisSpacing: crossAxisSpacing ?? spacing,
      childAspectRatio: aspectRatio,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}

/// Responsive row that adapts spacing and alignment based on screen size
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.mobileSpacing = 8.0,
    this.tabletSpacing,
    this.desktopSpacing,
    this.mobileMainAxisAlignment,
    this.tabletMainAxisAlignment,
    this.desktopMainAxisAlignment,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  
  // Responsive overrides
  final double mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final MainAxisAlignment? mobileMainAxisAlignment;
  final MainAxisAlignment? tabletMainAxisAlignment;
  final MainAxisAlignment? desktopMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsive(
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing,
      desktop: desktopSpacing ?? tabletSpacing ?? mobileSpacing,
    );
    
    final responsiveMainAxisAlignment = context.responsive(
      mobile: mobileMainAxisAlignment ?? mainAxisAlignment,
      tablet: tabletMainAxisAlignment ?? mainAxisAlignment,
      desktop: desktopMainAxisAlignment ?? mainAxisAlignment,
    );

    return Row(
      mainAxisAlignment: responsiveMainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.map((child) {
        if (children.indexOf(child) == children.length - 1) {
          return child;
        }
        return Row(
          children: [
            child,
            SizedBox(width: spacing),
          ],
        );
      }).toList(),
    );
  }
}

/// Responsive column that adapts spacing and alignment based on screen size
class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.mobileSpacing = 8.0,
    this.tabletSpacing,
    this.desktopSpacing,
    this.mobileMainAxisAlignment,
    this.tabletMainAxisAlignment,
    this.desktopMainAxisAlignment,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  
  // Responsive overrides
  final double mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final MainAxisAlignment? mobileMainAxisAlignment;
  final MainAxisAlignment? tabletMainAxisAlignment;
  final MainAxisAlignment? desktopMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsive(
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing,
      desktop: desktopSpacing ?? tabletSpacing ?? mobileSpacing,
    );
    
    final responsiveMainAxisAlignment = context.responsive(
      mobile: mobileMainAxisAlignment ?? mainAxisAlignment,
      tablet: tabletMainAxisAlignment ?? mainAxisAlignment,
      desktop: desktopMainAxisAlignment ?? mainAxisAlignment,
    );

    return Column(
      mainAxisAlignment: responsiveMainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.map((child) {
        if (children.indexOf(child) == children.length - 1) {
          return child;
        }
        return Column(
          children: [
            child,
            SizedBox(height: spacing),
          ],
        );
      }).toList(),
    );
  }
}

/// Responsive padding that adapts padding based on screen size
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobilePadding = EdgeInsets.zero,
    this.tabletPadding,
    this.desktopPadding,
  });

  final Widget child;
  final EdgeInsets mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;

  @override
  Widget build(BuildContext context) {
    final padding = context.responsive(
      mobile: mobilePadding,
      tablet: tabletPadding ?? mobilePadding,
      desktop: desktopPadding ?? tabletPadding ?? mobilePadding,
    );

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

/// Responsive margin that adapts margin based on screen size
class ResponsiveMargin extends StatelessWidget {
  const ResponsiveMargin({
    super.key,
    required this.child,
    this.mobileMargin = EdgeInsets.zero,
    this.tabletMargin,
    this.desktopMargin,
  });

  final Widget child;
  final EdgeInsets mobileMargin;
  final EdgeInsets? tabletMargin;
  final EdgeInsets? desktopMargin;

  @override
  Widget build(BuildContext context) {
    final margin = context.responsive(
      mobile: mobileMargin,
      tablet: tabletMargin ?? mobileMargin,
      desktop: desktopMargin ?? tabletMargin ?? mobileMargin,
    );

    return Container(
      margin: margin,
      child: child,
    );
  }
}
