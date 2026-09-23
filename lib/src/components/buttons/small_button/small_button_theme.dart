import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling for [SmallButton].
///
/// Register app-wide via `ThemeData(extensions: [SmallButtonTheme(...)])`
/// or pass per instance through `SmallButton(style: ...)`. Any `null` field
/// falls back to a value derived from the ambient [ColorScheme].
@immutable
class SmallButtonTheme extends ThemeExtension<SmallButtonTheme> {
  const SmallButtonTheme({
    this.gradientStart,
    this.gradientEnd,
    this.foregroundColor,
    this.onFilledColor,
    this.borderColor,
    this.disabledColor,
    this.size,
    this.iconSize,
    this.borderWidth,
  });

  factory SmallButtonTheme.fallback(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SmallButtonTheme(
      gradientStart: scheme.primary,
      gradientEnd: scheme.tertiary,
      foregroundColor: scheme.primary,
      onFilledColor: scheme.onPrimary,
      borderColor: scheme.outlineVariant,
      disabledColor: scheme.onSurface.withValues(alpha: 0.38),
      size: 48,
      iconSize: 24,
      borderWidth: 2,
    );
  }

  static SmallButtonTheme of(BuildContext context) => SmallButtonTheme.fallback(
    context,
  ).merge(Theme.of(context).extension<SmallButtonTheme>());

  final Color? gradientStart;
  final Color? gradientEnd;

  /// Icon color for the outline and icon types.
  final Color? foregroundColor;

  /// Icon color for the filled type.
  final Color? onFilledColor;
  final Color? borderColor;
  final Color? disabledColor;
  final double? size;
  final double? iconSize;
  final double? borderWidth;

  SmallButtonTheme merge(SmallButtonTheme? other) {
    if (other == null) return this;
    return copyWith(
      gradientStart: other.gradientStart,
      gradientEnd: other.gradientEnd,
      foregroundColor: other.foregroundColor,
      onFilledColor: other.onFilledColor,
      borderColor: other.borderColor,
      disabledColor: other.disabledColor,
      size: other.size,
      iconSize: other.iconSize,
      borderWidth: other.borderWidth,
    );
  }

  @override
  SmallButtonTheme copyWith({
    Color? gradientStart,
    Color? gradientEnd,
    Color? foregroundColor,
    Color? onFilledColor,
    Color? borderColor,
    Color? disabledColor,
    double? size,
    double? iconSize,
    double? borderWidth,
  }) => SmallButtonTheme(
    gradientStart: gradientStart ?? this.gradientStart,
    gradientEnd: gradientEnd ?? this.gradientEnd,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    onFilledColor: onFilledColor ?? this.onFilledColor,
    borderColor: borderColor ?? this.borderColor,
    disabledColor: disabledColor ?? this.disabledColor,
    size: size ?? this.size,
    iconSize: iconSize ?? this.iconSize,
    borderWidth: borderWidth ?? this.borderWidth,
  );

  @override
  SmallButtonTheme lerp(covariant SmallButtonTheme? other, double t) {
    if (other == null) return this;
    return SmallButtonTheme(
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t),
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      onFilledColor: Color.lerp(onFilledColor, other.onFilledColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
      size: lerpDouble(size, other.size, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
    );
  }
}
