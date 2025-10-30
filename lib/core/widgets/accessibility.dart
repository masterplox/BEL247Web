import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

/// Accessibility utilities and constants for WCAG compliance
class AccessibilityUtils {
  // WCAG AA contrast ratios
  static const double normalTextContrastRatio = 4.5;
  static const double largeTextContrastRatio = 3;
  static const double uiComponentContrastRatio = 3;
  
  // Minimum touch target sizes (WCAG AA)
  static const double minTouchTargetSize = 44; // 44x44 logical pixels
  
  // Focus indicators
  static const double focusIndicatorWidth = 2;
  static const double focusIndicatorOffset = 4;
  
  // Screen reader support
  static const Duration screenReaderAnnouncementDelay = Duration(milliseconds: 100);
  
  /// Check if text meets WCAG contrast requirements
  static bool meetsContrastRatio(Color foreground, Color background, {bool isLargeText = false}) {
    final ratio = _calculateContrastRatio(foreground, background);
    return ratio >= (isLargeText ? largeTextContrastRatio : normalTextContrastRatio);
  }
  
  /// Calculate contrast ratio between two colors
  static double _calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = _getRelativeLuminance(color1);
    final luminance2 = _getRelativeLuminance(color2);
    
    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;
    
    return (lighter + 0.05) / (darker + 0.05);
  }
  
  /// Get relative luminance of a color
  static double _getRelativeLuminance(Color color) {
    final r = _linearizeColorComponent(color.red / 255.0);
    final g = _linearizeColorComponent(color.green / 255.0);
    final b = _linearizeColorComponent(color.blue / 255.0);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }
  
  /// Linearize color component for luminance calculation
  static double _linearizeColorComponent(double component) => component <= 0.03928 
        ? component / 12.92 
        : math.pow((component + 0.055) / 1.055, 2.4).toDouble();
  
  /// Get accessible color for text on given background
  static Color getAccessibleTextColor(Color background, {bool isLargeText = false}) {
    const lightText = Color(0xFFFFFFFF);
    const darkText = Color(0xFF000000);
    
    final lightContrast = _calculateContrastRatio(lightText, background);
    final darkContrast = _calculateContrastRatio(darkText, background);
    
    final requiredRatio = isLargeText ? largeTextContrastRatio : normalTextContrastRatio;
    
    if (lightContrast >= requiredRatio) {
      return lightText;
    } else if (darkContrast >= requiredRatio) {
      return darkText;
    } else {
      // Return the color with better contrast
      return lightContrast > darkContrast ? lightText : darkText;
    }
  }
  
  /// Check if touch target meets minimum size requirements
  static bool meetsTouchTargetSize(Size size) => size.width >= minTouchTargetSize && size.height >= minTouchTargetSize;
  
  /// Get minimum size for touch target
  static Size getMinTouchTargetSize() => const Size(minTouchTargetSize, minTouchTargetSize);
  
  /// Announce text to screen readers
  static void announceToScreenReader(BuildContext context, String text) {
    SemanticsService.announce(text, TextDirection.ltr);
  }
  
  /// Get semantic label for common UI patterns
  static String getSemanticLabel(String text, {String? role}) {
    if (role != null) {
      return '$text, $role';
    }
    return text;
  }
  
  /// Get semantic hint for interactive elements
  static String getSemanticHint(String action) => 'Double tap to $action';
  
  /// Get semantic value for progress indicators
  static String getSemanticValue(double value, {String? unit}) {
    final percentage = (value * 100).round();
    return unit != null ? '$percentage% $unit' : '$percentage%';
  }
  
  /// Get semantic state for toggle elements
  static String getSemanticState(bool isSelected, {String? label}) {
    final state = isSelected ? 'selected' : 'not selected';
    return label != null ? '$label, $state' : state;
  }
  
  /// Get semantic level for headings
  static int getSemanticLevel(int headingLevel) => headingLevel.clamp(1, 6);
  
  /// Get semantic role for common elements
  static String getSemanticRole(Widget widget) {
    if (widget is ElevatedButton || widget is TextButton || widget is OutlinedButton) {
      return 'button';
    } else if (widget is Checkbox) {
      return 'checkbox';
    } else if (widget is Radio) {
      return 'radio';
    } else if (widget is Switch) {
      return 'switch';
    } else if (widget is Slider) {
      return 'slider';
    } else if (widget is TextField) {
      return 'text field';
    } else if (widget is Card) {
      return 'card';
    } else if (widget is ListTile) {
      return 'list item';
    } else if (widget is Tab) {
      return 'tab';
    } else if (widget is IconButton) {
      return 'button';
    } else if (widget is FloatingActionButton) {
      return 'button';
    }
    return 'widget';
  }
  
  /// Get semantic properties for common elements
  static Map<String, dynamic> getSemanticProperties(Widget widget) {
    final properties = <String, dynamic>{};
    
    if (widget is ElevatedButton || widget is TextButton || widget is OutlinedButton) {
      properties['button'] = true;
    } else if (widget is Checkbox) {
      properties['checkbox'] = true;
    } else if (widget is Radio) {
      properties['radio'] = true;
    } else if (widget is Switch) {
      properties['switch'] = true;
    } else if (widget is Slider) {
      properties['slider'] = true;
    } else if (widget is TextField) {
      properties['textField'] = true;
    } else if (widget is Card) {
      properties['card'] = true;
    } else if (widget is ListTile) {
      properties['listItem'] = true;
    } else if (widget is Tab) {
      properties['tab'] = true;
    } else if (widget is IconButton) {
      properties['button'] = true;
    } else if (widget is FloatingActionButton) {
      properties['button'] = true;
    }
    
    return properties;
  }
}

/// Accessible button widget with proper semantics and touch targets
class AccessibleButton extends StatelessWidget {
  const AccessibleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.semanticLabel,
    this.semanticHint,
    this.tooltip,
    this.minSize,
    this.padding,
    this.style,
    this.focusNode,
    this.autofocus = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final String? semanticLabel;
  final String? semanticHint;
  final String? tooltip;
  final Size? minSize;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final effectiveMinSize = minSize ?? AccessibilityUtils.getMinTouchTargetSize();
    
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      button: true,
      enabled: onPressed != null,
      child: Tooltip(
        message: tooltip ?? semanticLabel ?? '',
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: effectiveMinSize.width,
            minHeight: effectiveMinSize.height,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: style,
            focusNode: focusNode,
            autofocus: autofocus,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(8),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Accessible icon button with proper semantics and touch targets
class AccessibleIconButton extends StatelessWidget {
  const AccessibleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.semanticLabel,
    this.semanticHint,
    this.tooltip,
    this.minSize,
    this.padding,
    this.style,
    this.focusNode,
    this.autofocus = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? semanticLabel;
  final String? semanticHint;
  final String? tooltip;
  final Size? minSize;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final effectiveMinSize = minSize ?? AccessibilityUtils.getMinTouchTargetSize();
    
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      button: true,
      enabled: onPressed != null,
      child: Tooltip(
        message: tooltip ?? semanticLabel ?? '',
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: effectiveMinSize.width,
            minHeight: effectiveMinSize.height,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            style: style,
            focusNode: focusNode,
            autofocus: autofocus,
            padding: padding ?? const EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }
}

/// Accessible text field with proper semantics and labels
class AccessibleTextField extends StatelessWidget {
  const AccessibleTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.semanticLabel,
    this.semanticHint,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final bool autofocus;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final String? semanticLabel;
  final String? semanticHint;

  @override
  Widget build(BuildContext context) => Semantics(
      label: semanticLabel,
      hint: semanticHint,
      enabled: enabled ?? true,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: decoration,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textDirection: textDirection,
        readOnly: readOnly,
        toolbarOptions: toolbarOptions,
        showCursor: showCursor,
        autofocus: autofocus,
        autocorrect: autocorrect,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        onAppPrivateCommand: onAppPrivateCommand,
        inputFormatters: inputFormatters,
        enabled: enabled,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        keyboardAppearance: keyboardAppearance,
        enableInteractiveSelection: enableInteractiveSelection,
        selectionControls: selectionControls,
        onTap: onTap,
        onTapOutside: onTapOutside,
        mouseCursor: mouseCursor,
        buildCounter: buildCounter,
        scrollController: scrollController,
        scrollPhysics: scrollPhysics,
        autofillHints: autofillHints,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        scribbleEnabled: scribbleEnabled,
        canRequestFocus: canRequestFocus,
        spellCheckConfiguration: spellCheckConfiguration,
        magnifierConfiguration: magnifierConfiguration,
      ),
    );
}

/// Accessible card widget with proper semantics
class AccessibleCard extends StatelessWidget {
  const AccessibleCard({
    super.key,
    required this.child,
    this.semanticLabel,
    this.semanticHint,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticsContainer = false,
  });

  final Widget child;
  final String? semanticLabel;
  final String? semanticHint;
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final bool semanticsContainer;

  @override
  Widget build(BuildContext context) => Semantics(
      label: semanticLabel,
      hint: semanticHint,
      container: semanticsContainer,
      child: Card(
        color: color,
        shadowColor: shadowColor,
        elevation: elevation,
        shape: shape,
        borderOnForeground: borderOnForeground,
        margin: margin,
        clipBehavior: clipBehavior,
        child: child,
      ),
    );
}

/// Accessible list tile with proper semantics
class AccessibleListTile extends StatelessWidget {
  const AccessibleListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.onFocusChange,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.autofocus = false,
    this.focusNode,
    this.semanticLabel,
    this.semanticHint,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool? dense;
  final ShapeBorder? shape;
  final ListTileStyle? style;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onFocusChange;
  final MouseCursor? mouseCursor;
  final bool selected;
  final Color? focusColor;
  final Color? hoverColor;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final String? semanticHint;

  @override
  Widget build(BuildContext context) => Semantics(
      label: semanticLabel,
      hint: semanticHint,
      enabled: enabled,
      selected: selected,
      button: onTap != null,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        shape: shape,
        style: style,
        selectedColor: selectedColor,
        iconColor: iconColor,
        textColor: textColor,
        contentPadding: contentPadding,
        enabled: enabled,
        onTap: onTap,
        onLongPress: onLongPress,
        onFocusChange: onFocusChange,
        mouseCursor: mouseCursor,
        selected: selected,
        focusColor: focusColor,
        hoverColor: hoverColor,
        autofocus: autofocus,
        focusNode: focusNode,
      ),
    );
}

/// Accessible progress indicator with proper semantics
class AccessibleProgressIndicator extends StatelessWidget {
  const AccessibleProgressIndicator({
    super.key,
    required this.value,
    this.backgroundColor,
    this.valueColor,
    this.semanticLabel,
    this.semanticValue,
    this.minHeight,
  });

  final double value;
  final Color? backgroundColor;
  final Color? valueColor;
  final String? semanticLabel;
  final String? semanticValue;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticValue = semanticValue ?? 
        AccessibilityUtils.getSemanticValue(value);
    
    return Semantics(
      label: semanticLabel ?? 'Progress',
      value: effectiveSemanticValue,
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        valueColor: valueColor != null 
            ? AlwaysStoppedAnimation<Color>(valueColor!)
            : null,
        minHeight: minHeight,
      ),
    );
  }
}

/// Accessible checkbox with proper semantics
class AccessibleCheckbox extends StatelessWidget {
  const AccessibleCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
    this.semanticHint,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.focusNode,
    this.autofocus = false,
    this.tristate = false,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? semanticLabel;
  final String? semanticHint;
  final Color? activeColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool tristate;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticLabel = semanticLabel ?? 
        AccessibilityUtils.getSemanticState(value ?? false);
    
    return Semantics(
      label: effectiveSemanticLabel,
      hint: semanticHint,
      checked: value ?? false,
      enabled: onChanged != null,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        materialTapTargetSize: materialTapTargetSize,
        focusNode: focusNode,
        autofocus: autofocus,
        tristate: tristate,
      ),
    );
  }
}

/// Accessible switch with proper semantics
class AccessibleSwitch extends StatelessWidget {
  const AccessibleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
    this.semanticHint,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.thumbColor,
    this.trackColor,
    this.materialTapTargetSize,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;
  final String? semanticHint;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageProvider? inactiveThumbImage;
  final WidgetStateProperty<Color?>? thumbColor;
  final WidgetStateProperty<Color?>? trackColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticLabel = semanticLabel ?? 
        AccessibilityUtils.getSemanticState(value);
    
    return Semantics(
      label: effectiveSemanticLabel,
      hint: semanticHint,
      checked: value,
      enabled: onChanged != null,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: activeColor,
        activeTrackColor: activeTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
        activeThumbImage: activeThumbImage,
        inactiveThumbImage: inactiveThumbImage,
        thumbColor: thumbColor,
        trackColor: trackColor,
        materialTapTargetSize: materialTapTargetSize,
        mouseCursor: mouseCursor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        focusNode: focusNode,
        autofocus: autofocus,
      ),
    );
  }
}

/// Accessible slider with proper semantics
class AccessibleSlider extends StatelessWidget {
  const AccessibleSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.semanticLabel,
    this.semanticValue,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? semanticLabel;
  final String? semanticValue;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticValue = semanticValue ?? 
        AccessibilityUtils.getSemanticValue(value);
    
    return Semantics(
      label: semanticLabel ?? 'Slider',
      value: effectiveSemanticValue,
      enabled: onChanged != null,
      child: Slider(
        value: value,
        onChanged: onChanged,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        thumbColor: thumbColor,
        overlayColor: overlayColor,
        mouseCursor: mouseCursor,
        focusNode: focusNode,
        autofocus: autofocus,
      ),
    );
  }
}

/// Accessible heading with proper semantic level
class AccessibleHeading extends StatelessWidget {
  const AccessibleHeading(
    this.text, {
    super.key,
    required this.level,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticLabel,
  });

  final String text;
  final int level;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    // Use the provided level or default to standard
    
    return Semantics(
      label: semanticLabel ?? text,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}

/// Accessible focus indicator widget
class AccessibleFocusIndicator extends StatelessWidget {
  const AccessibleFocusIndicator({
    super.key,
    required this.child,
    this.focusColor,
    this.focusWidth,
    this.focusOffset,
    this.borderRadius,
  });

  final Widget child;
  final Color? focusColor;
  final double? focusWidth;
  final double? focusOffset;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveFocusColor = focusColor ?? Theme.of(context).focusColor;
    final effectiveFocusWidth = focusWidth ?? AccessibilityUtils.focusIndicatorWidth;
    // Use the provided focus offset or default
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(4);
    
    return Focus(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: effectiveFocusColor,
            width: effectiveFocusWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}
