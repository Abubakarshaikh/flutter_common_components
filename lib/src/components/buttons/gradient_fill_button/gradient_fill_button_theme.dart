import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling for [GradientFillButton].
///
/// Register app-wide via `ThemeData(extensions: [GradientFillButtonTheme(...)])`
/// or pass per instance through `GradientFillButton(style: ...)`. Any `null`
/// field falls back to a value derived from the ambient [ColorScheme].
@immutable
class GradientFillButtonTheme extends ThemeExtension<GradientFillButtonTheme> {
  const GradientFillButtonTheme({
    this.gradientStart,
    this.gradientEnd,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.textStyle,
    this.padding,
    this.radius,
    this.elevation,
  });

  factory GradientFillButtonTheme.fallback(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return GradientFillButtonTheme(
      gradientStart: scheme.primary,
      gradientEnd: scheme.tertiary,
      foregroundColor: scheme.onPrimary,
      disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
      textStyle: theme.textTheme.labelLarge,
      padding: const EdgeInsets.all(16),
      radius: 32,
      elevation: 4,
    );
  }

  /// The fully-resolved theme: fallback values overridden by the registered
  /// extension, if any.
  static GradientFillButtonTheme of(BuildContext context) =>
      GradientFillButtonTheme.fallback(
        context,
      ).merge(Theme.of(context).extension<GradientFillButtonTheme>());

  final Color? gradientStart;
  final Color? gradientEnd;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? elevation;

  /// Returns a copy where every non-null field of [other] wins.
  GradientFillButtonTheme merge(GradientFillButtonTheme? other) {
    if (other == null) return this;
    return copyWith(
      gradientStart: other.gradientStart,
      gradientEnd: other.gradientEnd,
      foregroundColor: other.foregroundColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: other.padding,
      radius: other.radius,
      elevation: other.elevation,
    );
  }

  @override
  GradientFillButtonTheme copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    double? radius,
    double? elevation,
  }) => GradientFillButtonTheme(
    gradientStart: gradientStart ?? this.gradientStart,
    gradientEnd: gradientEnd ?? this.gradientEnd,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    disabledBackgroundColor:
        disabledBackgroundColor ?? this.disabledBackgroundColor,
    disabledForegroundColor:
        disabledForegroundColor ?? this.disabledForegroundColor,
    textStyle: textStyle ?? this.textStyle,
    padding: padding ?? this.padding,
    radius: radius ?? this.radius,
    elevation: elevation ?? this.elevation,
  );

  @override
  GradientFillButtonTheme lerp(
    covariant GradientFillButtonTheme? other,
    double t,
  ) {
    if (other == null) return this;
    return GradientFillButtonTheme(
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t),
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      disabledBackgroundColor: Color.lerp(
        disabledBackgroundColor,
        other.disabledBackgroundColor,
        t,
      ),
      disabledForegroundColor: Color.lerp(
        disabledForegroundColor,
        other.disabledForegroundColor,
        t,
      ),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      radius: lerpDouble(radius, other.radius, t),
      elevation: lerpDouble(elevation, other.elevation, t),
    );
  }
}
