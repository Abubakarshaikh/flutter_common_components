import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _kContextualSelectColor = Color(0xFF2196F3);

/// A consistent [AppBar] wrapper. Pass [titleWidget] for custom title rows
/// (e.g. a tappable title with an info icon).
///
/// ```dart
/// CommonAppBar(title: 'Home')
///
/// CommonAppBar(
///   title: 'Reports',
///   onInfoTap: () => showDialog(...),
///   actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
/// )
///
/// // Multi-select mode: close button on the left, "Select" on the right.
/// CommonAppBar(
///   title: '3 selected',
///   enableContextualActionBar: true,
///   onClosed: () {},
///   onSelect: () {},
/// )
/// ```
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Shown when [titleWidget] is null. Can be empty when [titleWidget] is set.
  final String title;
  final bool enableContextualActionBar;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// Title color. Defaults to [foregroundColor], then the app bar theme's
  /// foreground color, then [ColorScheme.onSurface].
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;

  /// When true, a long [title] is clipped to [titleMaxLines] (default 2) with
  /// a [readMoreLabel] / [readLessLabel] toggle.
  final bool? titleReadMore;
  final int? titleMaxLines;
  final bool centerTitle;
  final double elevation;
  final double? scrolledUnderElevation;
  final Color? surfaceTintColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final void Function()? onSelect;
  final void Function()? onClosed;
  final String contextualSelectLabel;

  /// Color of the contextual "Select" action. Defaults to `#2196F3`.
  final Color? contextualSelectColor;
  final Color? closeIconColor;

  /// When non-null, renders a trailing info icon next to the [title] that calls
  /// this callback on tap (entire title+icon row becomes tappable). Ignored if
  /// [titleWidget] is provided.
  final VoidCallback? onInfoTap;

  /// Icon to show when [onInfoTap] is set. Defaults to
  /// [Icons.info_outline_rounded].
  final IconData? infoIcon;

  /// Color for the info icon. Defaults to `theme.colorScheme.primary`.
  final Color? infoIconColor;

  /// Size for the info icon on mobile. Defaults to `20`.
  final double infoIconSize;

  /// Size for the info icon on tablet form factors. Defaults to `24` so the
  /// target is easier to hit on larger screens.
  final double infoIconSizeTablet;

  /// Toggle label shown while a [titleReadMore] title is collapsed.
  final String readMoreLabel;

  /// Toggle label shown while a [titleReadMore] title is expanded.
  final String readLessLabel;

  const CommonAppBar({
    super.key,
    this.title = '',
    this.enableContextualActionBar = false,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.fontSize = 20.0,
    this.fontWeight = FontWeight.w600,
    this.titleReadMore,
    this.titleMaxLines,
    this.centerTitle = true,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.surfaceTintColor,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.titleWidget,
    this.bottom,
    this.toolbarHeight,
    this.systemOverlayStyle,
    this.onSelect,
    this.onClosed,
    this.contextualSelectLabel = 'Select',
    this.contextualSelectColor,
    this.closeIconColor,
    this.onInfoTap,
    this.infoIcon,
    this.infoIconColor,
    this.infoIconSize = 20,
    this.infoIconSizeTablet = 24,
    this.readMoreLabel = 'More Info',
    this.readLessLabel = 'Less Info',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedTextColor =
        textColor ??
        foregroundColor ??
        theme.appBarTheme.foregroundColor ??
        theme.colorScheme.onSurface;

    final Widget resolvedTitle =
        titleWidget ??
        _buildTitle(
          context: context,
          theme: theme,
          textColor: resolvedTextColor,
        );

    if (enableContextualActionBar) {
      assert(
        title.isNotEmpty || titleWidget != null,
        'Contextual bar needs a title or titleWidget',
      );
      return AppBar(
        elevation: elevation,
        scrolledUnderElevation: scrolledUnderElevation,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        surfaceTintColor: surfaceTintColor,
        toolbarHeight: toolbarHeight,
        systemOverlayStyle: systemOverlayStyle,
        automaticallyImplyLeading: false,
        bottom: bottom,
        leading:
            leading ??
            IconButton(
              icon: Icon(Icons.close, color: closeIconColor),
              iconSize: 24,
              onPressed: onClosed,
            ),
        title: resolvedTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: TextButton(
              onPressed: onSelect,
              style: TextButton.styleFrom(
                foregroundColor:
                    contextualSelectColor ?? _kContextualSelectColor,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: Text(contextualSelectLabel),
            ),
          ),
        ],
      );
    }

    assert(
      title.isNotEmpty || titleWidget != null,
      'CommonAppBar: set title, or use titleWidget',
    );
    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: surfaceTintColor,
      toolbarHeight: toolbarHeight,
      systemOverlayStyle: systemOverlayStyle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: resolvedTitle,
      actions: actions,
      leading: leading,
      bottom: bottom,
    );
  }

  Widget _buildTitle({
    required BuildContext context,
    required ThemeData theme,
    required Color textColor,
  }) {
    final TextStyle? style = theme.textTheme.titleLarge?.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
    );

    final Widget titleText = titleReadMore == true
        ? _ReadMoreTitle(
            text: title,
            style: style,
            maxLines: titleMaxLines ?? 2,
            moreLabel: readMoreLabel,
            lessLabel: readLessLabel,
            toggleColor: textColor,
          )
        : Text(
            title,
            style: style,
            maxLines: titleMaxLines,
            overflow: titleMaxLines != null ? TextOverflow.ellipsis : null,
          );

    if (onInfoTap == null) return titleText;

    return GestureDetector(
      onTap: onInfoTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: titleText),
          const SizedBox(width: 8),
          Icon(
            infoIcon ?? Icons.info_outline_rounded,
            size: _isTabletFormFactor(MediaQuery.sizeOf(context))
                ? infoIconSizeTablet
                : infoIconSize,
            color: infoIconColor ?? theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final h =
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0);
    return Size.fromHeight(h);
  }
}

/// A plain-text title clipped to [maxLines] with a toggle when it overflows.
class _ReadMoreTitle extends StatefulWidget {
  const _ReadMoreTitle({
    required this.text,
    required this.style,
    required this.maxLines,
    required this.moreLabel,
    required this.lessLabel,
    required this.toggleColor,
  });

  final String text;
  final TextStyle? style;
  final int maxLines;
  final String moreLabel;
  final String lessLabel;
  final Color toggleColor;

  @override
  State<_ReadMoreTitle> createState() => _ReadMoreTitleState();
}

class _ReadMoreTitleState extends State<_ReadMoreTitle> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: DefaultTextStyle.of(context).style.merge(widget.style),
          ),
          maxLines: widget.maxLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;
        painter.dispose();

        final text = Text(
          widget.text,
          style: widget.style,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? null : TextOverflow.clip,
        );
        if (!overflows) return text;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: text),
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              behavior: HitTestBehavior.opaque,
              child: Text(
                _isExpanded ? widget.lessLabel : widget.moreLabel,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: widget.toggleColor,
                  decoration: TextDecoration.underline,
                  decorationColor: widget.toggleColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

const double _kDesktopBreakpoint = 950;
const double _kTabletBreakpoint = 600;
const double _kTabletFormFactorMaxShortestSide = 1024;

/// Tablet buckets plus large iPads that width rules classify as desktop.
bool _isTabletFormFactor(Size size) {
  final double width;
  if (kIsWeb) {
    width = size.width;
  } else {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        width = size.width;
      default:
        width = size.shortestSide;
    }
  }
  if (width >= _kDesktopBreakpoint) {
    return size.shortestSide <= _kTabletFormFactorMaxShortestSide;
  }
  return width >= _kTabletBreakpoint;
}
