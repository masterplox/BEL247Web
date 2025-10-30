import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

/// Typography system with responsive scaling
class AppTypography {
  // Font families
  static const String primaryFontFamily = 'Roboto';
  static const String secondaryFontFamily = 'Inter';
  static const String monospaceFontFamily = 'JetBrains Mono';
  
  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  
  // Base font sizes
  static const double baseFontSize = 16;
  static const double smallFontSize = 12;
  static const double mediumFontSize = 14;
  static const double largeFontSize = 18;
  static const double xlargeFontSize = 20;
  static const double xxlargeFontSize = 24;
  static const double xxxlargeFontSize = 32;
  
  // Line heights
  static const double tightLineHeight = 1.2;
  static const double normalLineHeight = 1.4;
  static const double relaxedLineHeight = 1.6;
  static const double looseLineHeight = 1.8;
  
  // Letter spacing
  static const double tightLetterSpacing = -0.5;
  static const double normalLetterSpacing = 0;
  static const double wideLetterSpacing = 0.5;
  static const double widerLetterSpacing = 1;
  
  /// Get responsive font size based on screen size
  static double responsiveFontSize({
    required BuildContext context,
    required double baseFontSize,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) => context.responsiveFontSize(
      baseFontSize: baseFontSize,
      mobileMultiplier: mobileMultiplier ?? 1.0,
      tabletMultiplier: tabletMultiplier ?? 1.1,
      desktopMultiplier: desktopMultiplier ?? 1.2,
    );
  
  /// Display text styles
  static TextStyle displayLarge(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: xxxlargeFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: bold,
    fontFamily: primaryFontFamily,
    height: tightLineHeight,
    letterSpacing: tightLetterSpacing,
  );
  
  static TextStyle displayMedium(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: xxlargeFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: bold,
    fontFamily: primaryFontFamily,
    height: tightLineHeight,
    letterSpacing: tightLetterSpacing,
  );
  
  static TextStyle displaySmall(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: xlargeFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: bold,
    fontFamily: primaryFontFamily,
    height: tightLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  /// Headline text styles
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: largeFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle headlineMedium(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: baseFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle headlineSmall(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: mediumFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  /// Title text styles
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: baseFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: mediumFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle titleSmall(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: smallFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  /// Body text styles
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: baseFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: relaxedLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: mediumFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: relaxedLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: smallFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: relaxedLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  /// Label text styles
  static TextStyle labelLarge(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: mediumFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: wideLetterSpacing,
  );
  
  static TextStyle labelMedium(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: smallFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: wideLetterSpacing,
  );
  
  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: 10,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: wideLetterSpacing,
  );
  
  /// Custom text styles for specific use cases
  static TextStyle button(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: baseFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: semiBold,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: wideLetterSpacing,
  );
  
  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: smallFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle overline(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: 10,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: medium,
    fontFamily: primaryFontFamily,
    height: normalLineHeight,
    letterSpacing: widerLetterSpacing,
  );
  
  static TextStyle code(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: mediumFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: monospaceFontFamily,
    height: normalLineHeight,
    letterSpacing: normalLetterSpacing,
  );
  
  static TextStyle quote(BuildContext context) => TextStyle(
    fontSize: responsiveFontSize(
      context: context,
      baseFontSize: largeFontSize,
      mobileMultiplier: 0.9,
      tabletMultiplier: 1,
      desktopMultiplier: 1.1,
    ),
    fontWeight: regular,
    fontFamily: secondaryFontFamily,
    height: looseLineHeight,
    letterSpacing: normalLetterSpacing,
    fontStyle: FontStyle.italic,
  );
  
  /// Utility methods for text styling
  static TextStyle withColor(TextStyle style, Color color) => style.copyWith(color: color);
  
  static TextStyle withWeight(TextStyle style, FontWeight weight) => style.copyWith(fontWeight: weight);
  
  static TextStyle withSize(TextStyle style, double size) => style.copyWith(fontSize: size);
  
  static TextStyle withHeight(TextStyle style, double height) => style.copyWith(height: height);
  
  static TextStyle withLetterSpacing(TextStyle style, double letterSpacing) => style.copyWith(letterSpacing: letterSpacing);
  
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) => style.copyWith(decoration: decoration);
  
  static TextStyle withShadow(TextStyle style, List<Shadow> shadows) => style.copyWith(shadows: shadows);
  
  /// Text style combinations for common patterns
  static TextStyle heading1(BuildContext context) => displayLarge(context);
  static TextStyle heading2(BuildContext context) => displayMedium(context);
  static TextStyle heading3(BuildContext context) => displaySmall(context);
  static TextStyle heading4(BuildContext context) => headlineLarge(context);
  static TextStyle heading5(BuildContext context) => headlineMedium(context);
  static TextStyle heading6(BuildContext context) => headlineSmall(context);
  
  static TextStyle paragraph(BuildContext context) => bodyLarge(context);
  static TextStyle smallParagraph(BuildContext context) => bodyMedium(context);
  static TextStyle tinyParagraph(BuildContext context) => bodySmall(context);
  
  static TextStyle link(BuildContext context) => bodyLarge(context).copyWith(
    decoration: TextDecoration.underline,
    color: Colors.blue,
  );
  
  static TextStyle error(BuildContext context) => bodyMedium(context).copyWith(
    color: Colors.red,
  );
  
  static TextStyle success(BuildContext context) => bodyMedium(context).copyWith(
    color: Colors.green,
  );
  
  static TextStyle warning(BuildContext context) => bodyMedium(context).copyWith(
    color: Colors.orange,
  );
  
  static TextStyle info(BuildContext context) => bodyMedium(context).copyWith(
    color: Colors.blue,
  );
  
  /// Responsive text widget that automatically applies responsive typography
  static Widget responsiveText(
    BuildContext context,
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextDirection? textDirection,
    Locale? locale,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) => Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      locale: locale,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
}

/// Custom text widgets with responsive typography
class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textDirection,
    this.locale,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final Locale? locale;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) => AppTypography.responsiveText(
      context,
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      locale: locale,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
}

/// Responsive heading widgets
class ResponsiveHeading extends StatelessWidget {
  const ResponsiveHeading(
    this.text, {
    super.key,
    this.level = 1,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final int level;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    switch (level) {
      case 1:
        style = AppTypography.heading1(context);
        break;
      case 2:
        style = AppTypography.heading2(context);
        break;
      case 3:
        style = AppTypography.heading3(context);
        break;
      case 4:
        style = AppTypography.heading4(context);
        break;
      case 5:
        style = AppTypography.heading5(context);
        break;
      case 6:
        style = AppTypography.heading6(context);
        break;
      default:
        style = AppTypography.heading1(context);
    }
    
    if (color != null) {
      style = AppTypography.withColor(style, color!);
    }

    return ResponsiveText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive paragraph widget
class ResponsiveParagraph extends StatelessWidget {
  const ResponsiveParagraph(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.small = false,
    this.tiny = false,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool small;
  final bool tiny;

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    if (tiny) {
      style = AppTypography.tinyParagraph(context);
    } else if (small) {
      style = AppTypography.smallParagraph(context);
    } else {
      style = AppTypography.paragraph(context);
    }
    
    if (color != null) {
      style = AppTypography.withColor(style, color!);
    }

    return ResponsiveText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive label widget
class ResponsiveLabel extends StatelessWidget {
  const ResponsiveLabel(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.small = false,
    this.tiny = false,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool small;
  final bool tiny;

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    if (tiny) {
      style = AppTypography.labelSmall(context);
    } else if (small) {
      style = AppTypography.labelMedium(context);
    } else {
      style = AppTypography.labelLarge(context);
    }
    
    if (color != null) {
      style = AppTypography.withColor(style, color!);
    }

    return ResponsiveText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive button text widget
class ResponsiveButtonText extends StatelessWidget {
  const ResponsiveButtonText(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    TextStyle style = AppTypography.button(context);
    
    if (color != null) {
      style = AppTypography.withColor(style, color!);
    }

    return ResponsiveText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive code text widget
class ResponsiveCodeText extends StatelessWidget {
  const ResponsiveCodeText(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    TextStyle style = AppTypography.code(context);
    
    if (color != null) {
      style = AppTypography.withColor(style, color!);
    }

    return ResponsiveText(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
