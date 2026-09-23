import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling for [IconTextButton].
///
/// Register app-wide via `ThemeData(extensions: [IconTextButtonTheme(...)])`
/// or pass per instance through `IconTextButton(style: ...)`. Any `null`
/// field falls back to a value derived from the ambient [ColorScheme].
@immutable
class IconTextButtonTheme extends ThemeExtension<IconTextButtonTheme> {
  const IconTextButtonTheme({
    this.foregroundColor,
    this.disabledForegroundColor,
    this.backgroundColor,
    this.pressedBackgroundColor,
    this.textStyle,
    this.horizontalPadding,
    this.iconSpacing,
    this.appBarEndPadding,
  });

  factory IconTextButtonTheme.fallback(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return IconTextButtonTheme(
      foregroundColor: scheme.primary,
      disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
      backgroundColor: Colors.transparent,
      pressedBackgroundColor: scheme.primary.withValues(alpha: 0.12),
      textStyle: theme.textTheme.labelLarge,
      horizontalPadding: 8,
      iconSpacing: 8,
      appBarEndPadding: 8,
    );
  }

  static IconTextButtonTheme of(BuildContext context) =>
      IconTextButtonTheme.fallback(
        context,
      ).merge(Theme.of(context).extension<IconTextButtonTheme>());

  final Color? foregroundColor;
  final Color? disabledForegroundColor;
  final Color? backgroundColor;
  final Color? pressedBackgroundColor;
  final TextStyle? textStyle;
  final double? horizontalPadding;
  final double? iconSpacing;

  /// Trailing space used by [IconTextButtonAppearance.appBar].
  final double? appBarEndPadding;

  IconTextButtonTheme merge(IconTextButtonTheme? other) {
    if (other == null) return this;
    return copyWith(
      foregroundColor: other.foregroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      backgroundColor: other.backgroundColor,
      pressedBackgroundColor: other.pressedBackgroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      horizontalPadding: other.horizontalPadding,
      iconSpacing: other.iconSpacing,
      appBarEndPadding: other.appBarEndPadding,
    );
  }

  @override
  IconTextButtonTheme copyWith({
    Color? foregroundColor,
    Color? disabledForegroundColor,
    Color? backgroundColor,
    Color? pressedBackgroundColor,
    TextStyle? textStyle,
    double? horizontalPadding,
    double? iconSpacing,
    double? appBarEndPadding,
  }) => IconTextButtonTheme(
    foregroundColor: foregroundColor ?? this.foregroundColor,
    disabledForegroundColor:
        disabledForegroundColor ?? this.disabledForegroundColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    pressedBackgroundColor:
        pressedBackgroundColor ?? this.pressedBackgroundColor,
    textStyle: textStyle ?? this.textStyle,
    horizontalPadding: horizontalPadding ?? this.horizontalPadding,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    appBarEndPadding: appBarEndPadding ?? this.appBarEndPadding,
  );

  @override
  IconTextButtonTheme lerp(covariant IconTextButtonTheme? other, double t) {
    if (other == null) return this;
    return IconTextButtonTheme(
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      disabledForegroundColor: Color.lerp(
        disabledForegroundColor,
        other.disabledForegroundColor,
        t,
      ),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      pressedBackgroundColor: Color.lerp(
        pressedBackgroundColor,
        other.pressedBackgroundColor,
        t,
      ),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      horizontalPadding: lerpDouble(
        horizontalPadding,
        other.horizontalPadding,
        t,
      ),
      iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t),
      appBarEndPadding: lerpDouble(appBarEndPadding, other.appBarEndPadding, t),
    );
  }
}
