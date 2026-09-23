import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling for [AppTextField].
///
/// Register app-wide via `ThemeData(extensions: [AppTextFieldTheme(...)])`
/// or pass per instance through `AppTextField(style: ...)`. Any `null` field
/// falls back to a value derived from the ambient [ColorScheme]. Explicit
/// per-field params on [AppTextField] (e.g. `borderColor`) win over both.
@immutable
class AppTextFieldTheme extends ThemeExtension<AppTextFieldTheme> {
  const AppTextFieldTheme({
    this.textColor,
    this.hintColor,
    this.fillColor,
    this.borderColor,
    this.errorColor,
    this.cursorColor,
    this.borderRadius,
    this.contentPadding,
    this.fontSize,
    this.hintFontSize,
  });

  factory AppTextFieldTheme.fallback(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppTextFieldTheme(
      textColor: scheme.onSurface,
      hintColor: scheme.onSurfaceVariant,
      fillColor: Colors.transparent,
      borderColor: scheme.outline,
      errorColor: scheme.error,
      cursorColor: scheme.primary,
      borderRadius: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      fontSize: 14,
      hintFontSize: 14,
    );
  }

  static AppTextFieldTheme of(BuildContext context) =>
      AppTextFieldTheme.fallback(
        context,
      ).merge(Theme.of(context).extension<AppTextFieldTheme>());

  final Color? textColor;
  final Color? hintColor;
  final Color? fillColor;
  final Color? borderColor;

  /// Error border and error text color.
  final Color? errorColor;
  final Color? cursorColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final double? fontSize;
  final double? hintFontSize;

  AppTextFieldTheme merge(AppTextFieldTheme? other) {
    if (other == null) return this;
    return copyWith(
      textColor: other.textColor,
      hintColor: other.hintColor,
      fillColor: other.fillColor,
      borderColor: other.borderColor,
      errorColor: other.errorColor,
      cursorColor: other.cursorColor,
      borderRadius: other.borderRadius,
      contentPadding: other.contentPadding,
      fontSize: other.fontSize,
      hintFontSize: other.hintFontSize,
    );
  }

  @override
  AppTextFieldTheme copyWith({
    Color? textColor,
    Color? hintColor,
    Color? fillColor,
    Color? borderColor,
    Color? errorColor,
    Color? cursorColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    double? fontSize,
    double? hintFontSize,
  }) => AppTextFieldTheme(
    textColor: textColor ?? this.textColor,
    hintColor: hintColor ?? this.hintColor,
    fillColor: fillColor ?? this.fillColor,
    borderColor: borderColor ?? this.borderColor,
    errorColor: errorColor ?? this.errorColor,
    cursorColor: cursorColor ?? this.cursorColor,
    borderRadius: borderRadius ?? this.borderRadius,
    contentPadding: contentPadding ?? this.contentPadding,
    fontSize: fontSize ?? this.fontSize,
    hintFontSize: hintFontSize ?? this.hintFontSize,
  );

  @override
  AppTextFieldTheme lerp(covariant AppTextFieldTheme? other, double t) {
    if (other == null) return this;
    return AppTextFieldTheme(
      textColor: Color.lerp(textColor, other.textColor, t),
      hintColor: Color.lerp(hintColor, other.hintColor, t),
      fillColor: Color.lerp(fillColor, other.fillColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t),
      fontSize: lerpDouble(fontSize, other.fontSize, t),
      hintFontSize: lerpDouble(hintFontSize, other.hintFontSize, t),
    );
  }
}
