import 'package:flutter/material.dart';

/// Responsive breakpoints for different screen sizes
class ResponsiveBreakpoints {
  // Mobile breakpoints
  static const double mobileSmall = 360;
  static const double mobileMedium = 480;
  static const double mobileLarge = 600;
  
  // Tablet breakpoints
  static const double tabletSmall = 768;
  static const double tabletMedium = 900;
  static const double tabletLarge = 1024;
  
  // Desktop breakpoints
  static const double desktopSmall = 1200;
  static const double desktopMedium = 1440;
  static const double desktopLarge = 1920;
  
  // Ultra-wide breakpoints
  static const double ultraWide = 2560;
}

/// Screen size categories
enum ScreenSize {
  mobileSmall,
  mobileMedium,
  mobileLarge,
  tabletSmall,
  tabletMedium,
  tabletLarge,
  desktopSmall,
  desktopMedium,
  desktopLarge,
  ultraWide,
}

/// Responsive utilities for handling different screen sizes
class ResponsiveUtils {
  /// Get current screen size category based on width
  static ScreenSize getScreenSize(double width) {
    if (width < ResponsiveBreakpoints.mobileMedium) {
      return ScreenSize.mobileSmall;
    } else if (width < ResponsiveBreakpoints.mobileLarge) {
      return ScreenSize.mobileMedium;
    } else if (width < ResponsiveBreakpoints.tabletSmall) {
      return ScreenSize.mobileLarge;
    } else if (width < ResponsiveBreakpoints.tabletMedium) {
      return ScreenSize.tabletSmall;
    } else if (width < ResponsiveBreakpoints.tabletLarge) {
      return ScreenSize.tabletMedium;
    } else if (width < ResponsiveBreakpoints.desktopSmall) {
      return ScreenSize.tabletLarge;
    } else if (width < ResponsiveBreakpoints.desktopMedium) {
      return ScreenSize.desktopSmall;
    } else if (width < ResponsiveBreakpoints.desktopLarge) {
      return ScreenSize.desktopMedium;
    } else if (width < ResponsiveBreakpoints.ultraWide) {
      return ScreenSize.desktopLarge;
    } else {
      return ScreenSize.ultraWide;
    }
  }
  
  /// Check if current screen is mobile
  static bool isMobile(double width) => width < ResponsiveBreakpoints.tabletSmall;
  
  /// Check if current screen is tablet
  static bool isTablet(double width) => 
      width >= ResponsiveBreakpoints.tabletSmall && width < ResponsiveBreakpoints.desktopSmall;
  
  /// Check if current screen is desktop
  static bool isDesktop(double width) => width >= ResponsiveBreakpoints.desktopSmall;
  
  /// Get responsive value based on screen size
  static T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    required double width,
  }) {
    if (isMobile(width)) {
      return mobile;
    } else if (isTablet(width)) {
      return tablet ?? mobile;
    } else {
      return desktop ?? tablet ?? mobile;
    }
  }
  
  /// Get responsive padding based on screen size
  static EdgeInsets responsivePadding({
    required double width,
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final padding = responsiveValue(
      mobile: mobile ?? 16.0,
      tablet: tablet ?? 24.0,
      desktop: desktop ?? 32.0,
      width: width,
    );
    
    return EdgeInsets.all(padding);
  }
  
  /// Get responsive margin based on screen size
  static EdgeInsets responsiveMargin({
    required double width,
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final margin = responsiveValue(
      mobile: mobile ?? 8.0,
      tablet: tablet ?? 16.0,
      desktop: desktop ?? 24.0,
      width: width,
    );
    
    return EdgeInsets.all(margin);
  }
  
  /// Get responsive font size based on screen size
  static double responsiveFontSize({
    required double width,
    required double baseFontSize,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.1,
      desktop: desktopMultiplier ?? 1.2,
      width: width,
    );
    
    return baseFontSize * multiplier;
  }
  
  /// Get responsive spacing based on screen size
  static double responsiveSpacing({
    required double width,
    required double baseSpacing,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.2,
      desktop: desktopMultiplier ?? 1.5,
      width: width,
    );
    
    return baseSpacing * multiplier;
  }
  
  /// Get responsive column count for grid layouts
  static int responsiveColumns({
    required double width,
    required int mobileColumns,
    int? tabletColumns,
    int? desktopColumns,
  }) => responsiveValue(
      mobile: mobileColumns,
      tablet: tabletColumns ?? mobileColumns,
      desktop: desktopColumns ?? tabletColumns ?? mobileColumns,
      width: width,
    );
  
  /// Get responsive aspect ratio for containers
  static double responsiveAspectRatio({
    required double width,
    required double mobileRatio,
    double? tabletRatio,
    double? desktopRatio,
  }) => responsiveValue(
      mobile: mobileRatio,
      tablet: tabletRatio ?? mobileRatio,
      desktop: desktopRatio ?? tabletRatio ?? mobileRatio,
      width: width,
    );
  
  /// Get responsive border radius based on screen size
  static double responsiveBorderRadius({
    required double width,
    required double baseRadius,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.1,
      desktop: desktopMultiplier ?? 1.2,
      width: width,
    );
    
    return baseRadius * multiplier;
  }
  
  /// Get responsive elevation based on screen size
  static double responsiveElevation({
    required double width,
    required double baseElevation,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.2,
      desktop: desktopMultiplier ?? 1.5,
      width: width,
    );
    
    return baseElevation * multiplier;
  }
  
  /// Get responsive icon size based on screen size
  static double responsiveIconSize({
    required double width,
    required double baseIconSize,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.1,
      desktop: desktopMultiplier ?? 1.2,
      width: width,
    );
    
    return baseIconSize * multiplier;
  }
  
  /// Get responsive button height based on screen size
  static double responsiveButtonHeight({
    required double width,
    required double baseHeight,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 1.1,
      desktop: desktopMultiplier ?? 1.2,
      width: width,
    );
    
    return baseHeight * multiplier;
  }
  
  /// Get responsive container width based on screen size
  static double responsiveContainerWidth({
    required double width,
    required double baseWidth,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) {
    final multiplier = responsiveValue(
      mobile: mobileMultiplier ?? 1.0,
      tablet: tabletMultiplier ?? 0.8,
      desktop: desktopMultiplier ?? 0.6,
      width: width,
    );
    
    return baseWidth * multiplier;
  }
  
  /// Get responsive max width for content containers
  static double responsiveMaxWidth({
    required double width,
    double? mobileMaxWidth,
    double? tabletMaxWidth,
    double? desktopMaxWidth,
  }) => responsiveValue(
      mobile: mobileMaxWidth ?? width,
      tablet: tabletMaxWidth ?? 768,
      desktop: desktopMaxWidth ?? 1200,
      width: width,
    );
  
  /// Get responsive grid cross axis count
  static int responsiveGridCrossAxisCount({
    required double width,
    required int mobileCount,
    int? tabletCount,
    int? desktopCount,
  }) => responsiveValue(
      mobile: mobileCount,
      tablet: tabletCount ?? mobileCount,
      desktop: desktopCount ?? tabletCount ?? mobileCount,
      width: width,
    );
  
  /// Get responsive child aspect ratio for grid
  static double responsiveChildAspectRatio({
    required double width,
    required double mobileRatio,
    double? tabletRatio,
    double? desktopRatio,
  }) => responsiveValue(
      mobile: mobileRatio,
      tablet: tabletRatio ?? mobileRatio,
      desktop: desktopRatio ?? tabletRatio ?? mobileRatio,
      width: width,
    );
  
  /// Get responsive main axis spacing for grid
  static double responsiveMainAxisSpacing({
    required double width,
    required double mobileSpacing,
    double? tabletSpacing,
    double? desktopSpacing,
  }) => responsiveValue(
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing,
      desktop: desktopSpacing ?? tabletSpacing ?? mobileSpacing,
      width: width,
    );
  
  /// Get responsive cross axis spacing for grid
  static double responsiveCrossAxisSpacing({
    required double width,
    required double mobileSpacing,
    double? tabletSpacing,
    double? desktopSpacing,
  }) => responsiveValue(
      mobile: mobileSpacing,
      tablet: tabletSpacing ?? mobileSpacing,
      desktop: desktopSpacing ?? tabletSpacing ?? mobileSpacing,
      width: width,
    );
}

/// Extension on BuildContext for easy access to responsive utilities
extension ResponsiveContext on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  
  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  
  /// Get screen size category
  ScreenSize get screenSize => ResponsiveUtils.getScreenSize(screenWidth);
  
  /// Check if current screen is mobile
  bool get isMobile => ResponsiveUtils.isMobile(screenWidth);
  
  /// Check if current screen is tablet
  bool get isTablet => ResponsiveUtils.isTablet(screenWidth);
  
  /// Check if current screen is desktop
  bool get isDesktop => ResponsiveUtils.isDesktop(screenWidth);
  
  /// Get responsive value based on current screen size
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) => ResponsiveUtils.responsiveValue(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
    width: screenWidth,
  );
  
  /// Get responsive padding based on current screen size
  EdgeInsets responsivePadding({
    double? mobile,
    double? tablet,
    double? desktop,
  }) => ResponsiveUtils.responsivePadding(
    width: screenWidth,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
  
  /// Get responsive margin based on current screen size
  EdgeInsets responsiveMargin({
    double? mobile,
    double? tablet,
    double? desktop,
  }) => ResponsiveUtils.responsiveMargin(
    width: screenWidth,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
  
  /// Get responsive font size based on current screen size
  double responsiveFontSize({
    required double baseFontSize,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) => ResponsiveUtils.responsiveFontSize(
    width: screenWidth,
    baseFontSize: baseFontSize,
    mobileMultiplier: mobileMultiplier,
    tabletMultiplier: tabletMultiplier,
    desktopMultiplier: desktopMultiplier,
  );
  
  /// Get responsive spacing based on current screen size
  double responsiveSpacing({
    required double baseSpacing,
    double? mobileMultiplier,
    double? tabletMultiplier,
    double? desktopMultiplier,
  }) => ResponsiveUtils.responsiveSpacing(
    width: screenWidth,
    baseSpacing: baseSpacing,
    mobileMultiplier: mobileMultiplier,
    tabletMultiplier: tabletMultiplier,
    desktopMultiplier: desktopMultiplier,
  );
  
  /// Get responsive column count for grid layouts
  int responsiveColumns({
    required int mobileColumns,
    int? tabletColumns,
    int? desktopColumns,
  }) => ResponsiveUtils.responsiveColumns(
    width: screenWidth,
    mobileColumns: mobileColumns,
    tabletColumns: tabletColumns,
    desktopColumns: desktopColumns,
  );
  
  /// Get responsive max width for content containers
  double responsiveMaxWidth({
    double? mobileMaxWidth,
    double? tabletMaxWidth,
    double? desktopMaxWidth,
  }) => ResponsiveUtils.responsiveMaxWidth(
    width: screenWidth,
    mobileMaxWidth: mobileMaxWidth,
    tabletMaxWidth: tabletMaxWidth,
    desktopMaxWidth: desktopMaxWidth,
  );
}
