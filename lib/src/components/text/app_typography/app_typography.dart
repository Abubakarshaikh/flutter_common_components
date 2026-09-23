import 'package:flutter/material.dart';

/// Type-scale slots used by [AppTypography].
///
/// Each value resolves from the ambient [TextTheme]. [titleMediumPlus] and
/// [bodyXLarge] have no Material equivalent; they reuse [titleMedium] /
/// [bodyLarge] with a larger font size (18 and 20).
enum AppTypographyScale {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleMediumPlus,
  titleSmall,
  bodyXLarge,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Responsive typography scale that renders plain [Text].
///
/// Scale constructors ([AppTypography.bodyMedium],
/// [AppTypography.titleLarge], ...) resolve their base style from
/// `Theme.of(context).textTheme` and apply the given overrides on top.
///
/// Behaviour:
/// * `null` [text] renders nothing.
/// * Text is centered unless a `textAlign` is given.
/// * [maxLines] only applies when [maxLinesEnable] is true (the scale
///   constructors enable it automatically when `maxLines` is passed).
/// * [maxLength] truncates the string and appends `..`.
/// * With [scaleUp] (default), the font size grows ×1.4 on screens at least
///   600 logical pixels wide (×1.45 in landscape).
///
/// ```dart
/// AppTypography.titleLarge('Settings', fontWeight: FontWeight.w600)
/// AppTypography.bodySmall(
///   description,
///   color: Theme.of(context).colorScheme.onSurfaceVariant,
///   textAlign: TextAlign.start,
///   maxLines: 2,
/// )
/// ```
class AppTypography extends StatelessWidget {
  /// Renders [text] with [scale] from the theme, merged with [style].
  const AppTypography(
    this.text, {
    super.key,
    this.style,
    this.scale = AppTypographyScale.bodySmall,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.maxLength,
    this.maxLinesEnable = false,
    this.scaleUp = true,
  });

  AppTypography._scaled(
    this.scale,
    this.text, {
    super.key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    this.textAlign,
    this.maxLines,
    this.maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    this.overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    this.scaleUp = true,
  }) : maxLinesEnable = maxLines != null || maxLinesEnable,
       style = TextStyle(
         fontFamily: fontFamily,
         color: color,
         fontWeight: fontWeight,
         wordSpacing: wordSpacing,
         height: height,
         fontStyle: fontStyle,
         decoration: textDecoration,
         decorationColor: color,
         shadows: shadows,
         fontFeatures: fontFeatures,
         letterSpacing: letterSpacing,
       );

  factory AppTypography.displayLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.displayLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.displayMedium(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.displayMedium,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.displaySmall(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.displaySmall,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.headlineLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.headlineLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.headlineMedium(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.headlineMedium,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.headlineSmall(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.headlineSmall,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.titleLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.titleLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.titleMedium(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.titleMedium,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.titleMediumPlus(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.titleMediumPlus,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.titleSmall(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.titleSmall,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.bodyXLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.bodyXLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.bodyLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.bodyLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.bodyMedium(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.bodyMedium,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.bodySmall(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.bodySmall,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.labelLarge(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.labelLarge,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.labelMedium(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.labelMedium,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  factory AppTypography.labelSmall(
    String? text, {
    Key? key,
    String? fontFamily,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    TextAlign? textAlign,
    int? maxLines,
    int? maxLength,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    TextOverflow? overflow,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    bool maxLinesEnable = false,
    double? letterSpacing,
    bool scaleUp = true,
  }) => AppTypography._scaled(
    AppTypographyScale.labelSmall,
    text,
    key: key,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    textAlign: textAlign,
    maxLines: maxLines,
    maxLength: maxLength,
    height: height,
    fontStyle: fontStyle,
    textDecoration: textDecoration,
    overflow: overflow,
    shadows: shadows,
    fontFeatures: fontFeatures,
    maxLinesEnable: maxLinesEnable,
    letterSpacing: letterSpacing,
    scaleUp: scaleUp,
  );

  final String? text;

  /// Overrides merged on top of the [scale] style from the theme.
  final TextStyle? style;

  /// Which [TextTheme] slot provides the base style.
  final AppTypographyScale scale;

  /// Defaults to [TextAlign.center].
  final TextAlign? textAlign;

  /// Defaults to [TextOverflow.ellipsis] for a single line, otherwise
  /// [TextOverflow.clip].
  final TextOverflow? overflow;
  final int? maxLines;

  /// Truncates [text] to this many characters, appending `..`.
  final int? maxLength;

  /// Whether [maxLines] is applied.
  final bool maxLinesEnable;

  /// Grows the font size on tablet-width screens.
  final bool scaleUp;

  static const double _mobileMaxWidth = 600;
  static const double _largeScreenFactor = 1.4;
  static const double _largeScreenLandscapeFactor = 1.45;

  /// Resolves the [TextStyle] this widget renders with, before responsive
  /// scaling.
  static TextStyle resolveScale(
    BuildContext context,
    AppTypographyScale scale,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final base = switch (scale) {
      AppTypographyScale.displayLarge => textTheme.displayLarge,
      AppTypographyScale.displayMedium => textTheme.displayMedium,
      AppTypographyScale.displaySmall => textTheme.displaySmall,
      AppTypographyScale.headlineLarge => textTheme.headlineLarge,
      AppTypographyScale.headlineMedium => textTheme.headlineMedium,
      AppTypographyScale.headlineSmall => textTheme.headlineSmall,
      AppTypographyScale.titleLarge => textTheme.titleLarge,
      AppTypographyScale.titleMedium => textTheme.titleMedium,
      AppTypographyScale.titleMediumPlus => textTheme.titleMedium?.copyWith(
        fontSize: 18.0,
      ),
      AppTypographyScale.titleSmall => textTheme.titleSmall,
      AppTypographyScale.bodyXLarge => textTheme.bodyLarge?.copyWith(
        fontSize: 20.0,
      ),
      AppTypographyScale.bodyLarge => textTheme.bodyLarge,
      AppTypographyScale.bodyMedium => textTheme.bodyMedium,
      AppTypographyScale.bodySmall => textTheme.bodySmall,
      AppTypographyScale.labelLarge => textTheme.labelLarge,
      AppTypographyScale.labelMedium => textTheme.labelMedium,
      AppTypographyScale.labelSmall => textTheme.labelSmall,
    };
    return base ?? const TextStyle();
  }

  static String _truncate(String value, int? maxLength) {
    if (maxLength == null || maxLength <= 0) return value;
    if (value.length <= maxLength) return value;
    return '${value.substring(0, maxLength)}..';
  }

  double _responsiveFactor(BuildContext context) {
    if (!scaleUp) return 1;
    final size = MediaQuery.sizeOf(context);
    if (size.width < _mobileMaxWidth) return 1;
    return size.width > size.height
        ? _largeScreenLandscapeFactor
        : _largeScreenFactor;
  }

  @override
  Widget build(BuildContext context) {
    final value = text;
    if (value == null) return const SizedBox.shrink();

    final merged = resolveScale(
      context,
      scale,
    ).copyWith(color: Theme.of(context).colorScheme.onSurface).merge(style);
    final fontSize = merged.fontSize ?? 14.0;
    final resolvedLines = maxLinesEnable ? maxLines : null;

    return Text(
      _truncate(value, maxLength),
      style: merged.copyWith(fontSize: fontSize * _responsiveFactor(context)),
      softWrap: true,
      overflow:
          overflow ??
          (resolvedLines == 1 ? TextOverflow.ellipsis : TextOverflow.clip),
      maxLines: resolvedLines,
      textAlign: textAlign ?? TextAlign.center,
      textScaler: MediaQuery.textScalerOf(context),
      textWidthBasis: TextWidthBasis.parent,
    );
  }
}
