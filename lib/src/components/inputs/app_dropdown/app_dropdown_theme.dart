import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

const _kInfoColor = Color(0xFF2196F3);
const _kCheckColor = Color(0xFFFFFFFF);

/// Styling for [AppDropdown] and [MultiSelectDropdown].
///
/// Register app-wide via `ThemeData(extensions: [AppDropdownStyle(...)])`
/// or pass per instance through `AppDropdown(style: ...)`. Any `null` field
/// falls back to a value derived from the ambient [ColorScheme].
@immutable
class AppDropdownStyle extends ThemeExtension<AppDropdownStyle> {
  const AppDropdownStyle({
    this.backgroundColor,
    this.fillColor,
    this.borderColor,
    this.lineColor,
    this.menuColor,
    this.textColor,
    this.iconColor,
    this.disabledIconColor,
    this.accentColor,
    this.checkColor,
    this.borderRadius,
    this.height,
    this.menuMaxHeight,
    this.padding,
  });

  factory AppDropdownStyle.fallback(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppDropdownStyle(
      backgroundColor: scheme.surfaceContainerHigh,
      fillColor: scheme.surfaceContainerHighest,
      borderColor: scheme.outline,
      lineColor: _kInfoColor,
      menuColor: scheme.surfaceContainerHigh,
      textColor: scheme.onSurface,
      iconColor: _kInfoColor,
      disabledIconColor: scheme.onSurfaceVariant,
      accentColor: _kInfoColor,
      checkColor: _kCheckColor,
      borderRadius: 12,
      height: 50,
      menuMaxHeight: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  static AppDropdownStyle of(BuildContext context) => AppDropdownStyle.fallback(
    context,
  ).merge(Theme.of(context).extension<AppDropdownStyle>());

  /// Field background for the default variant.
  final Color? backgroundColor;

  /// Field background for the filled variant.
  final Color? fillColor;

  /// Border color for the default and outline variants.
  final Color? borderColor;

  /// Bottom line color for the underlined variant.
  final Color? lineColor;

  /// Background of the open menu.
  final Color? menuColor;

  /// Placeholder, value and item text color.
  final Color? textColor;

  /// Arrow icon color when enabled (default variant).
  final Color? iconColor;

  /// Arrow icon and text color when disabled.
  final Color? disabledIconColor;

  /// Scrollbar thumb, multi-select checkbox fill and selected item text.
  final Color? accentColor;

  /// Check mark color of multi-select checkboxes.
  final Color? checkColor;
  final double? borderRadius;
  final double? height;
  final double? menuMaxHeight;

  /// Padding inside the field.
  final EdgeInsetsGeometry? padding;

  AppDropdownStyle merge(AppDropdownStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      fillColor: other.fillColor,
      borderColor: other.borderColor,
      lineColor: other.lineColor,
      menuColor: other.menuColor,
      textColor: other.textColor,
      iconColor: other.iconColor,
      disabledIconColor: other.disabledIconColor,
      accentColor: other.accentColor,
      checkColor: other.checkColor,
      borderRadius: other.borderRadius,
      height: other.height,
      menuMaxHeight: other.menuMaxHeight,
      padding: other.padding,
    );
  }

  @override
  AppDropdownStyle copyWith({
    Color? backgroundColor,
    Color? fillColor,
    Color? borderColor,
    Color? lineColor,
    Color? menuColor,
    Color? textColor,
    Color? iconColor,
    Color? disabledIconColor,
    Color? accentColor,
    Color? checkColor,
    double? borderRadius,
    double? height,
    double? menuMaxHeight,
    EdgeInsetsGeometry? padding,
  }) => AppDropdownStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    fillColor: fillColor ?? this.fillColor,
    borderColor: borderColor ?? this.borderColor,
    lineColor: lineColor ?? this.lineColor,
    menuColor: menuColor ?? this.menuColor,
    textColor: textColor ?? this.textColor,
    iconColor: iconColor ?? this.iconColor,
    disabledIconColor: disabledIconColor ?? this.disabledIconColor,
    accentColor: accentColor ?? this.accentColor,
    checkColor: checkColor ?? this.checkColor,
    borderRadius: borderRadius ?? this.borderRadius,
    height: height ?? this.height,
    menuMaxHeight: menuMaxHeight ?? this.menuMaxHeight,
    padding: padding ?? this.padding,
  );

  @override
  AppDropdownStyle lerp(covariant AppDropdownStyle? other, double t) {
    if (other == null) return this;
    return AppDropdownStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      fillColor: Color.lerp(fillColor, other.fillColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      lineColor: Color.lerp(lineColor, other.lineColor, t),
      menuColor: Color.lerp(menuColor, other.menuColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      disabledIconColor: Color.lerp(
        disabledIconColor,
        other.disabledIconColor,
        t,
      ),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      checkColor: Color.lerp(checkColor, other.checkColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      height: lerpDouble(height, other.height, t),
      menuMaxHeight: lerpDouble(menuMaxHeight, other.menuMaxHeight, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }
}
