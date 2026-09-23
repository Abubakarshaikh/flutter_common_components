import 'package:flutter/material.dart';

/// Title placement relative to the wrapped field.
enum FieldTitleLayout {
  /// Title above the field (default).
  stacked,

  /// Title and field side by side (flex 2:3).
  inline,

  /// Title above the field, with inline-style padding.
  inlineVertical,
}

/// Lays out a field [title] (and optional [description]) around [child].
///
/// Use this whenever a title is required. Pass [AppTextField] as [child].
///
/// Set [wrapFieldInContainer] to paint the field in the inset surface
/// container. [containerColor] and [containerPadding] only apply then.
///
/// Colors default to the ambient [ColorScheme]: the title uses `onSurface`
/// (or `primary` for inline titles inside a container), the asterisk uses
/// `error`, the description `onSurfaceVariant`, and the container
/// `surfaceContainerHigh`.
class FieldWrapper extends StatelessWidget {
  const FieldWrapper({
    super.key,
    required this.child,
    this.title,
    this.description,
    this.layout = FieldTitleLayout.stacked,
    this.showTitle = true,
    this.showAsterisk = false,
    this.wrapFieldInContainer = false,
    this.containerColor,
    this.containerPadding,
    this.titleColor,
    this.titleFontWeight = FontWeight.w600,
    this.descriptionColor,
    this.descriptionFontWeight,
    this.descriptionFontStyle,
    this.descriptionPadding,
    this.descriptionTextAlign,
    this.padding,
    this.margin,
  });

  final Widget child;
  final String? title;
  final String? description;
  final FieldTitleLayout layout;
  final bool showTitle;
  final bool showAsterisk;
  final bool wrapFieldInContainer;
  final Color? containerColor;
  final EdgeInsetsGeometry? containerPadding;
  final Color? titleColor;
  final FontWeight titleFontWeight;
  final Color? descriptionColor;
  final FontWeight? descriptionFontWeight;
  final FontStyle? descriptionFontStyle;
  final EdgeInsetsGeometry? descriptionPadding;
  final TextAlign? descriptionTextAlign;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  static const _inlineHorizontalSpacing = 8.0;

  bool get _hasTitle => title != null && title!.isNotEmpty;

  Widget _field(ColorScheme scheme) {
    if (!wrapFieldInContainer) return child;
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor ?? scheme.surfaceContainerHigh,
      ),
      padding:
          containerPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget content;
    switch (layout) {
      case FieldTitleLayout.stacked:
        content = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildStackedTitle(context), _field(scheme)],
        );
      case FieldTitleLayout.inline:
        content = _buildInlineHorizontal(context);
      case FieldTitleLayout.inlineVertical:
        content = _buildInlineVertical(context);
    }

    final resolvedPadding =
        padding ??
        (layout == FieldTitleLayout.stacked
            ? null
            : const EdgeInsets.fromLTRB(0, 0, 0, 8));
    if (resolvedPadding != null) {
      content = Padding(padding: resolvedPadding, child: content);
    }
    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }
    return content;
  }

  TextStyle? _titleStyle(BuildContext context, Color color) => Theme.of(
    context,
  ).textTheme.labelLarge?.copyWith(color: color, fontWeight: titleFontWeight);

  Widget _buildStackedTitle(BuildContext context) {
    if (!showTitle && description == null) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    final displayText = title ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  displayText,
                  style: _titleStyle(context, titleColor ?? scheme.onSurface),
                ),
                if (showAsterisk)
                  Text(' *', style: _titleStyle(context, scheme.error)),
              ],
            ),
          if (description != null) _buildDescription(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: descriptionPadding ?? const EdgeInsets.only(top: 2),
      child: Text(
        description!,
        textAlign: descriptionTextAlign ?? TextAlign.start,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: descriptionFontWeight ?? FontWeight.w400,
          fontStyle: descriptionFontStyle,
          color: descriptionColor ?? theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildInlineLabel(BuildContext context) {
    if (!_hasTitle) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final Color labelColor =
        titleColor ??
        (wrapFieldInContainer ? scheme.primary : scheme.onSurface);

    final label = Text(
      title!,
      textAlign: TextAlign.start,
      style: _titleStyle(context, labelColor),
    );

    if (!showAsterisk) return label;

    return Row(
      children: [
        Flexible(child: label),
        Text(' *', style: _titleStyle(context, scheme.error)),
      ],
    );
  }

  Widget _buildInlineHorizontal(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInlineLabel(context),
              if (description != null) _buildDescription(context),
            ],
          ),
        ),
        SizedBox(width: wrapFieldInContainer ? 8 : 10),
        Expanded(flex: 3, child: _field(scheme)),
      ],
    );
  }

  Widget _buildInlineVertical(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = _buildInlineLabel(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: wrapFieldInContainer
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.start,
      children: [
        label,
        if (description != null) _buildDescription(context),
        if (_hasTitle)
          SizedBox(height: wrapFieldInContainer ? _inlineHorizontalSpacing : 4),
        _field(scheme),
      ],
    );
  }
}
