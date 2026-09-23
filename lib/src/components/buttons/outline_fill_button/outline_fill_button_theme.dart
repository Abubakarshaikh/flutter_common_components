import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling for [OutlineFillButton].
///
/// Register app-wide via `ThemeData(extensions: [OutlineFillButtonTheme(...)])`
/// or pass per instance through `OutlineFillButton(style: ...)`. Any `null`
/// field falls back to a value derived from the ambient [ColorScheme].
@immutable
class OutlineFillButtonTheme extends ThemeExtension<OutlineFillButtonTheme> {
  const OutlineFillButtonTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledForegroundColor,
    this.textStyle,
    this.padding,
    this.radius,
    this.borderWidth,
    this.elevation,
  });

  factory OutlineFillButtonTheme.fallback(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return OutlineFillButtonTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.primary,
      borderColor: scheme.outlineVariant,
      disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
      textStyle: theme.textTheme.labelLarge,
      padding: const EdgeInsets.all(16),
      radius: 24,
      borderWidth: 2,
      elevation: 1,
    );
  }

  static OutlineFillButtonTheme of(BuildContext context) =>
      OutlineFillButtonTheme.fallback(
        context,
      ).merge(Theme.of(context).extension<OutlineFillButtonTheme>());

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? disabledForegroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? borderWidth;
  final double? elevation;

  OutlineFillButtonTheme merge(OutlineFillButtonTheme? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      borderColor: other.borderColor,
      disabledForegroundColor: other.disabledForegroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: other.padding,
      radius: other.radius,
      borderWidth: other.borderWidth,
      elevation: other.elevation,
    );
  }

  @override
  OutlineFillButtonTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    Color? disabledForegroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    double? radius,
    double? borderWidth,
    double? elevation,
  }) => OutlineFillButtonTheme(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    borderColor: borderColor ?? this.borderColor,
    disabledForegroundColor:
        disabledForegroundColor ?? this.disabledForegroundColor,
    textStyle: textStyle ?? this.textStyle,
    padding: padding ?? this.padding,
    radius: radius ?? this.radius,
    borderWidth: borderWidth ?? this.borderWidth,
    elevation: elevation ?? this.elevation,
  );

  @override
  OutlineFillButtonTheme lerp(
    covariant OutlineFillButtonTheme? other,
    double t,
  ) {
    if (other == null) return this;
    return OutlineFillButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      disabledForegroundColor: Color.lerp(
        disabledForegroundColor,
        other.disabledForegroundColor,
        t,
      ),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      radius: lerpDouble(radius, other.radius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      elevation: lerpDouble(elevation, other.elevation, t),
    );
  }
}
