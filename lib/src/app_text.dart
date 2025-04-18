import 'package:flutter/material.dart';

sealed class TextVariant {
  const TextVariant();
  static const displayLarge = _DisplayLarge();
  static const displayMedium = _DisplayMedium();
  static const displaySmall = _DisplaySmall();
  static const headlineLarge = _HeadlineLarge();
  static const headlineMedium = _HeadlineMedium();
  static const headlineSmall = _HeadlineSmall();
  static const titleLarge = _TitleLarge();
  static const titleMedium = _TitleMedium();
  static const titleSmall = _TitleSmall();
  static const bodyLarge = _BodyLarge();
  static const bodyMedium = _BodyMedium();
  static const bodySmall = _BodySmall();
  static const labelLarge = _LabelLarge();
  static const labelMedium = _LabelMedium();
  static const labelSmall = _LabelSmall();
}

final class _DisplayLarge extends TextVariant {
  const _DisplayLarge();
}

final class _DisplayMedium extends TextVariant {
  const _DisplayMedium();
}

final class _DisplaySmall extends TextVariant {
  const _DisplaySmall();
}

final class _HeadlineLarge extends TextVariant {
  const _HeadlineLarge();
}

final class _HeadlineMedium extends TextVariant {
  const _HeadlineMedium();
}

final class _HeadlineSmall extends TextVariant {
  const _HeadlineSmall();
}

final class _TitleLarge extends TextVariant {
  const _TitleLarge();
}

final class _TitleMedium extends TextVariant {
  const _TitleMedium();
}

final class _TitleSmall extends TextVariant {
  const _TitleSmall();
}

final class _BodyLarge extends TextVariant {
  const _BodyLarge();
}

final class _BodyMedium extends TextVariant {
  const _BodyMedium();
}

final class _BodySmall extends TextVariant {
  const _BodySmall();
}

final class _LabelLarge extends TextVariant {
  const _LabelLarge();
}

final class _LabelMedium extends TextVariant {
  const _LabelMedium();
}

final class _LabelSmall extends TextVariant {
  const _LabelSmall();
}

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextVariant variant;
  final Color? color;
  final double? height;
  final bool selectable;
  final bool scrollable;
  final bool showDivider;

  const AppText._({
    required this.text,
    this.style,
    this.textAlign,
    required this.variant,
    this.color,
    this.height,
    this.selectable = false,
    this.overflow,
    this.scrollable = false,
    this.maxLines,
    this.softWrap,
    this.showDivider = false,
  });

  factory AppText.display1(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.displayLarge,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.display2(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.displayMedium,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.display3(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.displaySmall,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.h1(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.headlineLarge,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.h2(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.headlineMedium,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.h3(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.headlineSmall,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        selectable: selectable,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.t1(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool showDivider = false,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.titleLarge,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );
  factory AppText.t2(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.titleMedium,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.t3(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.titleSmall,
        style: style,
        textAlign: textAlign,
        color: color,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.b1(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool selectable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.bodyLarge,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        selectable: selectable,
        showDivider: showDivider,
      );

  factory AppText.b2(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool selectable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.bodyMedium,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        selectable: selectable,
        showDivider: showDivider,
      );

  factory AppText.b3(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool selectable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.bodySmall,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        scrollable: scrollable,
        selectable: selectable,
        showDivider: showDivider,
      );

  factory AppText.l1(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.labelLarge,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.l2(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.labelMedium,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  factory AppText.l3(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? height,
    bool selectable = false,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    bool scrollable = false,
    bool showDivider = false,
  }) =>
      AppText._(
        text: text,
        variant: TextVariant.labelSmall,
        style: style,
        textAlign: textAlign,
        color: color,
        height: height,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: softWrap,
        selectable: selectable,
        scrollable: scrollable,
        showDivider: showDivider,
      );

  @override
  Widget build(BuildContext context) {
    final defaultStyle = _getTextStyle(Theme.of(context));
    final finalStyle = defaultStyle
        .copyWith(
          color: color,
          height: height,
        )
        .merge(style);

    Widget textWidget = selectable
        ? SelectableText(
            text,
            style: finalStyle,
            textAlign: textAlign,
          )
        : Text(
            text,
            style: finalStyle,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLines,
            softWrap: softWrap,
          );

    // Wrap with SingleChildScrollView if scrollable is true
    if (scrollable) {
      textWidget = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: textWidget,
      );
    }

    // Add divider if showDivider is true
    if (showDivider) {
      textWidget = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget,
          const SizedBox(height: 4),
          const Divider(),
        ],
      );
    }

    return textWidget;
  }

  TextStyle _getTextStyle(ThemeData theme) {
    final textTheme = theme.primaryTextTheme;
    return switch (variant) {
      _DisplayLarge() => textTheme.displayLarge!,
      _DisplayMedium() => textTheme.displayMedium!,
      _DisplaySmall() => textTheme.displaySmall!,
      _HeadlineLarge() => textTheme.headlineLarge!,
      _HeadlineMedium() => textTheme.headlineMedium!,
      _HeadlineSmall() => textTheme.headlineSmall!,
      _TitleLarge() => textTheme.titleLarge!,
      _TitleMedium() => textTheme.titleMedium!,
      _TitleSmall() => textTheme.titleSmall!,
      _BodyLarge() => textTheme.bodyLarge!,
      _BodyMedium() => textTheme.bodyMedium!,
      _BodySmall() => textTheme.bodySmall!,
      _LabelLarge() => textTheme.labelLarge!,
      _LabelMedium() => textTheme.labelMedium!,
      _LabelSmall() => textTheme.labelSmall!
    };
  }
}
