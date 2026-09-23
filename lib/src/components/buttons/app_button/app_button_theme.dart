import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

const Color _neutralSurfaceLight = Color(0xFFF5F5F5);

/// App-wide defaults for [AppButton] variants.
///
/// Register via `ThemeData(extensions: [AppButtonTheme(...)])`. Any `null`
/// field falls back to a value derived from the ambient [ColorScheme].
/// Per-instance tweaks go through `AppButton.primary(style: AppButtonStyle(...))`.
@immutable
class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  const AppButtonTheme({
    this.primaryBackgroundColor,
    this.primaryForegroundColor,
    this.secondaryBackgroundColor,
    this.secondaryForegroundColor,
    this.outlineForegroundColor,
    this.outlineBorderColor,
    this.circularIconBackgroundColor,
    this.circularIconForegroundColor,
    this.circularIconBorderColor,
    this.textForegroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderRadius,
    this.padding,
    this.textPadding,
    this.fontSize,
    this.tabletFontSize,
    this.animationDuration,
  });

  factory AppButtonTheme.fallback(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppButtonTheme(
      primaryBackgroundColor: scheme.primary,
      primaryForegroundColor: scheme.onPrimary,
      secondaryBackgroundColor: _neutralSurfaceLight,
      secondaryForegroundColor: scheme.primary,
      outlineForegroundColor: scheme.primary,
      outlineBorderColor: scheme.onSurfaceVariant,
      circularIconBackgroundColor: scheme.surfaceContainerHigh,
      circularIconForegroundColor: scheme.onSurface,
      circularIconBorderColor: scheme.primary.withValues(alpha: 0.3),
      textForegroundColor: scheme.primary,
      disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: scheme.onSurfaceVariant,
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      textPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      fontSize: 14,
      tabletFontSize: 20,
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  static AppButtonTheme of(BuildContext context) => AppButtonTheme.fallback(
    context,
  ).merge(Theme.of(context).extension<AppButtonTheme>());

  /// Fill of [AppButton.primary].
  final Color? primaryBackgroundColor;

  /// Label / icon color of [AppButton.primary].
  final Color? primaryForegroundColor;

  /// Fill of the non-outlined [AppButton.secondary].
  final Color? secondaryBackgroundColor;

  /// Label color of [AppButton.secondary].
  final Color? secondaryForegroundColor;

  /// Label color of [AppButton.outline].
  final Color? outlineForegroundColor;

  /// Stroke of [AppButton.outline] and outlined [AppButton.secondary] when no
  /// explicit border color is passed.
  final Color? outlineBorderColor;

  final Color? circularIconBackgroundColor;
  final Color? circularIconForegroundColor;
  final Color? circularIconBorderColor;

  /// Label color of the text-style variants ([AppButton.text],
  /// [AppButton.textWithIcon], [AppButton.textUnderlined],
  /// [AppButton.textColored], [AppButton.icon]).
  final Color? textForegroundColor;

  /// Fill of filled variants while disabled.
  final Color? disabledBackgroundColor;

  /// Label / icon color of every variant while disabled.
  final Color? disabledForegroundColor;

  /// Corner radius of the filled / outlined variants.
  final double? borderRadius;

  /// Inner padding of the filled / outlined variants.
  final EdgeInsets? padding;

  /// Inner padding of the text-style variants.
  final EdgeInsets? textPadding;

  /// Label font size on phones.
  final double? fontSize;

  /// Label font size on tablet form factors.
  final double? tabletFontSize;
  final Duration? animationDuration;

  AppButtonTheme merge(AppButtonTheme? other) {
    if (other == null) return this;
    return copyWith(
      primaryBackgroundColor: other.primaryBackgroundColor,
      primaryForegroundColor: other.primaryForegroundColor,
      secondaryBackgroundColor: other.secondaryBackgroundColor,
      secondaryForegroundColor: other.secondaryForegroundColor,
      outlineForegroundColor: other.outlineForegroundColor,
      outlineBorderColor: other.outlineBorderColor,
      circularIconBackgroundColor: other.circularIconBackgroundColor,
      circularIconForegroundColor: other.circularIconForegroundColor,
      circularIconBorderColor: other.circularIconBorderColor,
      textForegroundColor: other.textForegroundColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      borderRadius: other.borderRadius,
      padding: other.padding,
      textPadding: other.textPadding,
      fontSize: other.fontSize,
      tabletFontSize: other.tabletFontSize,
      animationDuration: other.animationDuration,
    );
  }

  @override
  AppButtonTheme copyWith({
    Color? primaryBackgroundColor,
    Color? primaryForegroundColor,
    Color? secondaryBackgroundColor,
    Color? secondaryForegroundColor,
    Color? outlineForegroundColor,
    Color? outlineBorderColor,
    Color? circularIconBackgroundColor,
    Color? circularIconForegroundColor,
    Color? circularIconBorderColor,
    Color? textForegroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? textPadding,
    double? fontSize,
    double? tabletFontSize,
    Duration? animationDuration,
  }) => AppButtonTheme(
    primaryBackgroundColor:
        primaryBackgroundColor ?? this.primaryBackgroundColor,
    primaryForegroundColor:
        primaryForegroundColor ?? this.primaryForegroundColor,
    secondaryBackgroundColor:
        secondaryBackgroundColor ?? this.secondaryBackgroundColor,
    secondaryForegroundColor:
        secondaryForegroundColor ?? this.secondaryForegroundColor,
    outlineForegroundColor:
        outlineForegroundColor ?? this.outlineForegroundColor,
    outlineBorderColor: outlineBorderColor ?? this.outlineBorderColor,
    circularIconBackgroundColor:
        circularIconBackgroundColor ?? this.circularIconBackgroundColor,
    circularIconForegroundColor:
        circularIconForegroundColor ?? this.circularIconForegroundColor,
    circularIconBorderColor:
        circularIconBorderColor ?? this.circularIconBorderColor,
    textForegroundColor: textForegroundColor ?? this.textForegroundColor,
    disabledBackgroundColor:
        disabledBackgroundColor ?? this.disabledBackgroundColor,
    disabledForegroundColor:
        disabledForegroundColor ?? this.disabledForegroundColor,
    borderRadius: borderRadius ?? this.borderRadius,
    padding: padding ?? this.padding,
    textPadding: textPadding ?? this.textPadding,
    fontSize: fontSize ?? this.fontSize,
    tabletFontSize: tabletFontSize ?? this.tabletFontSize,
    animationDuration: animationDuration ?? this.animationDuration,
  );

  @override
  AppButtonTheme lerp(covariant AppButtonTheme? other, double t) {
    if (other == null) return this;
    return AppButtonTheme(
      primaryBackgroundColor: Color.lerp(
        primaryBackgroundColor,
        other.primaryBackgroundColor,
        t,
      ),
      primaryForegroundColor: Color.lerp(
        primaryForegroundColor,
        other.primaryForegroundColor,
        t,
      ),
      secondaryBackgroundColor: Color.lerp(
        secondaryBackgroundColor,
        other.secondaryBackgroundColor,
        t,
      ),
      secondaryForegroundColor: Color.lerp(
        secondaryForegroundColor,
        other.secondaryForegroundColor,
        t,
      ),
      outlineForegroundColor: Color.lerp(
        outlineForegroundColor,
        other.outlineForegroundColor,
        t,
      ),
      outlineBorderColor: Color.lerp(
        outlineBorderColor,
        other.outlineBorderColor,
        t,
      ),
      circularIconBackgroundColor: Color.lerp(
        circularIconBackgroundColor,
        other.circularIconBackgroundColor,
        t,
      ),
      circularIconForegroundColor: Color.lerp(
        circularIconForegroundColor,
        other.circularIconForegroundColor,
        t,
      ),
      circularIconBorderColor: Color.lerp(
        circularIconBorderColor,
        other.circularIconBorderColor,
        t,
      ),
      textForegroundColor: Color.lerp(
        textForegroundColor,
        other.textForegroundColor,
        t,
      ),
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
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      textPadding: EdgeInsets.lerp(textPadding, other.textPadding, t),
      fontSize: lerpDouble(fontSize, other.fontSize, t),
      tabletFontSize: lerpDouble(tabletFontSize, other.tabletFontSize, t),
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
    );
  }
}
