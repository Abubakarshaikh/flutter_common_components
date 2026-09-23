import 'package:flutter/material.dart';

/// Which [ColorScheme] role a preset uses as its tile color when
/// [AppTileStyle.tileColor] is null.
enum _TileSurface { surface, surfaceContainerHigh }

/// Style model for [AppTile] to encapsulate styling properties.
///
/// Colors left null resolve from the ambient [ColorScheme] at build time:
/// title → `onSurface`, subtitle → `onSurface` at 70% opacity.
class AppTileStyle {
  static const double _defaultArrowSize = 16.0;

  static const FontWeight _defaultFontWeight = FontWeight.w500;
  static const FontWeight _defaultSubtitleFontWeight = FontWeight.w400;
  static const TextAlign _defaultTextAlign = TextAlign.start;
  static const bool _defaultDense = false;
  static const bool _defaultSelected = false;
  static const bool _defaultEnabled = true;
  static const bool _defaultAutofocus = false;

  static const bool _defaultIsThreeLine = false;
  static const bool _defaultEnableFeedback = true;
  static const EdgeInsetsGeometry _defaultContentPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );

  final Color? titleColor;
  final Color? subtitleColor;

  /// Overrides the `titleMedium` font size when set.
  final double? titleFontSize;

  /// Overrides the `bodyLarge` font size when set.
  final double? subtitleFontSize;
  final FontWeight titleFontWeight;
  final FontWeight subtitleFontWeight;
  final TextAlign textAlign;
  final bool dense;
  final EdgeInsetsGeometry contentPadding;
  final bool selected;
  final Color? selectedColor;
  final Color? tileColor;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool isThreeLine;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final ListTileStyle? style;
  final bool enableFeedback;
  final MouseCursor? mouseCursor;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;

  // Trailing icon properties
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final double? trailingIconSize;
  final Color? splashColor;

  final _TileSurface? _surface;

  const AppTileStyle({
    this.titleColor,
    this.subtitleColor,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleFontWeight = _defaultFontWeight,
    this.subtitleFontWeight = _defaultSubtitleFontWeight,
    this.textAlign = _defaultTextAlign,
    this.dense = _defaultDense,
    this.contentPadding = _defaultContentPadding,
    this.selected = _defaultSelected,
    this.selectedColor,
    this.tileColor,
    this.enabled = _defaultEnabled,
    this.autofocus = _defaultAutofocus,
    this.focusNode,
    this.isThreeLine = _defaultIsThreeLine,
    this.visualDensity,
    this.shape,
    this.style,
    this.enableFeedback = _defaultEnableFeedback,
    this.mouseCursor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconSize,
    this.splashColor,
  }) : _surface = null;

  const AppTileStyle._preset({
    this.titleFontWeight = _defaultFontWeight,
    this.dense = _defaultDense,
    this.contentPadding = _defaultContentPadding,
    this.shape,
    this.trailingIcon,
    this.trailingIconSize,
    _TileSurface? surface,
  }) : titleColor = null,
       subtitleColor = null,
       titleFontSize = null,
       subtitleFontSize = null,
       subtitleFontWeight = _defaultSubtitleFontWeight,
       textAlign = _defaultTextAlign,
       selected = _defaultSelected,
       selectedColor = null,
       tileColor = null,
       enabled = _defaultEnabled,
       autofocus = _defaultAutofocus,
       focusNode = null,
       isThreeLine = _defaultIsThreeLine,
       visualDensity = null,
       style = null,
       enableFeedback = _defaultEnableFeedback,
       mouseCursor = null,
       horizontalTitleGap = null,
       minVerticalPadding = null,
       minLeadingWidth = null,
       trailingIconColor = null,
       splashColor = null,
       _surface = surface;

  /// Style for navigation list tiles with arrow (tile color:
  /// [ColorScheme.surface]).
  static const AppTileStyle navigation = AppTileStyle._preset(
    surface: _TileSurface.surface,
    titleFontWeight: FontWeight.w600,
    trailingIcon: Icons.arrow_forward_ios_rounded,
    trailingIconSize: _defaultArrowSize,
  );

  /// Style for action list tiles with icons (tile color:
  /// [ColorScheme.surfaceContainerHigh]).
  static const AppTileStyle action = AppTileStyle._preset(
    surface: _TileSurface.surfaceContainerHigh,
  );

  /// Style for informational list tiles
  static const AppTileStyle info = AppTileStyle._preset(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
  );

  /// Style for card-like list tiles (tile color: [ColorScheme.surface]).
  static const AppTileStyle card = AppTileStyle._preset(
    surface: _TileSurface.surface,
    contentPadding: EdgeInsets.all(16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  );

  Color? _resolveTileColor(ColorScheme scheme) {
    if (tileColor != null) return tileColor;
    return switch (_surface) {
      _TileSurface.surface => scheme.surface,
      _TileSurface.surfaceContainerHigh => scheme.surfaceContainerHigh,
      null => null,
    };
  }

  /// Copy with method for creating variations
  AppTileStyle copyWith({
    Color? titleColor,
    Color? subtitleColor,
    double? titleFontSize,
    double? subtitleFontSize,
    FontWeight? titleFontWeight,
    FontWeight? subtitleFontWeight,
    TextAlign? textAlign,
    bool? dense,
    EdgeInsetsGeometry? contentPadding,
    bool? selected,
    Color? selectedColor,
    Color? tileColor,
    bool? enabled,
    bool? autofocus,
    FocusNode? focusNode,
    bool? isThreeLine,
    VisualDensity? visualDensity,
    ShapeBorder? shape,
    ListTileStyle? style,
    bool? enableFeedback,
    MouseCursor? mouseCursor,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    IconData? trailingIcon,
    Color? trailingIconColor,
    double? trailingIconSize,
    Color? splashColor,
  }) {
    return AppTileStyle._copy(
      surface: _surface,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      subtitleFontSize: subtitleFontSize ?? this.subtitleFontSize,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      subtitleFontWeight: subtitleFontWeight ?? this.subtitleFontWeight,
      textAlign: textAlign ?? this.textAlign,
      dense: dense ?? this.dense,
      contentPadding: contentPadding ?? this.contentPadding,
      selected: selected ?? this.selected,
      selectedColor: selectedColor ?? this.selectedColor,
      tileColor: tileColor ?? this.tileColor,
      enabled: enabled ?? this.enabled,
      autofocus: autofocus ?? this.autofocus,
      focusNode: focusNode ?? this.focusNode,
      isThreeLine: isThreeLine ?? this.isThreeLine,
      visualDensity: visualDensity ?? this.visualDensity,
      shape: shape ?? this.shape,
      style: style ?? this.style,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      horizontalTitleGap: horizontalTitleGap ?? this.horizontalTitleGap,
      minVerticalPadding: minVerticalPadding ?? this.minVerticalPadding,
      minLeadingWidth: minLeadingWidth ?? this.minLeadingWidth,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      trailingIconSize: trailingIconSize ?? this.trailingIconSize,
      splashColor: splashColor ?? this.splashColor,
    );
  }

  const AppTileStyle._copy({
    required _TileSurface? surface,
    required this.titleColor,
    required this.subtitleColor,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.titleFontWeight,
    required this.subtitleFontWeight,
    required this.textAlign,
    required this.dense,
    required this.contentPadding,
    required this.selected,
    required this.selectedColor,
    required this.tileColor,
    required this.enabled,
    required this.autofocus,
    required this.focusNode,
    required this.isThreeLine,
    required this.visualDensity,
    required this.shape,
    required this.style,
    required this.enableFeedback,
    required this.mouseCursor,
    required this.horizontalTitleGap,
    required this.minVerticalPadding,
    required this.minLeadingWidth,
    required this.trailingIcon,
    required this.trailingIconColor,
    required this.trailingIconSize,
    required this.splashColor,
  }) : _surface = surface;
}

class AppTile extends StatelessWidget {
  static const double _defaultIconSize = 24.0;

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final AppTileStyle style;

  /// Standard list tile with structured layout for consistency across the app
  const AppTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.titleWidget,
    this.subtitleWidget,
    this.onTap,
    this.onLongPress,
    this.style = const AppTileStyle(),
  }) : assert(
         titleWidget != null || title != null,
         'Either title or titleWidget must be provided.',
       );

  /// Create a navigation list tile with forward arrow
  factory AppTile.navigation({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Color? arrowColor,
    AppTileStyle? style,
  }) {
    final effectiveStyle = style ?? AppTileStyle.navigation;
    final iconColor = arrowColor ?? effectiveStyle.trailingIconColor;

    // Use default arrow icon if no custom trailing icon is specified
    final iconToUse =
        effectiveStyle.trailingIcon ?? Icons.arrow_forward_ios_rounded;

    return AppTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: _SchemeIcon(
        iconToUse,
        color: iconColor,
        fallback: (scheme) => scheme.onSurface,
        size: effectiveStyle.trailingIconSize ?? AppTileStyle._defaultArrowSize,
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      style: effectiveStyle,
    );
  }

  /// Create an action list tile with add icon
  factory AppTile.action({
    Key? key,
    required String title,
    String? subtitle,
    IconData icon = Icons.add_circle_outline_rounded,
    Color? iconColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    AppTileStyle? style,
  }) {
    return AppTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: _SchemeIcon(
        icon,
        color: iconColor,
        fallback: (scheme) => scheme.primary,
        size: _defaultIconSize,
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      style: style ?? AppTileStyle.action,
    );
  }

  /// Action row for modal bottom sheets (popup menus, report actions, etc.).
  ///
  /// Uses a tinted icon badge, semibold title, and chevron trailing affordance.
  /// [accentColor] defaults to [ColorScheme.primary].
  factory AppTile.sheetAction({
    Key? key,
    required String title,
    String? subtitle,
    required IconData icon,
    Color? accentColor,
    Color? titleColor,
    VoidCallback? onTap,
    bool enabled = true,
    AppTileStyle? style,
  }) {
    return AppTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: _SheetActionBadge(
        icon: icon,
        accentColor: accentColor,
        enabled: enabled,
      ),
      trailing: _SchemeIcon(
        Icons.chevron_right_rounded,
        size: 20.0,
        fallback: (scheme) => scheme.onSurface.withValues(alpha: 0.28),
      ),
      onTap: enabled ? onTap : null,
      style: (style ?? const AppTileStyle()).copyWith(
        tileColor: Colors.transparent,
        titleColor: titleColor,
        titleFontWeight: FontWeight.w600,
        enabled: enabled,
        splashColor: enabled ? accentColor?.withValues(alpha: 0.12) : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
      ),
    );
  }

  /// Create an informational list tile (dense layout)
  factory AppTile.info({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    AppTileStyle? style,
  }) {
    return AppTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      style: style ?? AppTileStyle.info,
    );
  }

  /// Create a card-style list tile with rounded corners
  factory AppTile.card({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    AppTileStyle? style,
  }) {
    return AppTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      style: style ?? AppTileStyle.card,
    );
  }

  /// Create a custom tile with custom widgets
  factory AppTile.custom({
    Key? key,
    Widget? titleWidget,
    Widget? subtitleWidget,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    AppTileStyle? style,
  }) {
    return AppTile(
      key: key,
      titleWidget: titleWidget,
      subtitleWidget: subtitleWidget,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
      style: style ?? const AppTileStyle(),
    );
  }

  Widget _buildTitle(BuildContext context, ThemeData theme) {
    if (titleWidget != null) return titleWidget!;

    final onSurface = theme.colorScheme.onSurface;
    final resolvedTitleColor =
        style.titleColor ??
        (style.enabled ? onSurface : onSurface.withValues(alpha: 0.38));

    return Text(
      title!,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: style.titleFontWeight,
        fontSize: style.titleFontSize,
        color: resolvedTitleColor,
      ),
      textAlign: style.textAlign,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget? _buildSubtitle(BuildContext context, ThemeData theme) {
    if (subtitleWidget != null) return subtitleWidget!;
    if (subtitle == null) return null;

    final resolvedSubtitleColor =
        style.subtitleColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.7);

    return Text(
      subtitle!,
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: style.subtitleFontWeight,
        fontSize: style.subtitleFontSize,
        color: resolvedSubtitleColor,
      ),
      textAlign: style.textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        title: _buildTitle(context, theme),
        subtitle: _buildSubtitle(context, theme),
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        dense: style.dense,
        contentPadding: style.contentPadding,
        selected: style.selected,
        selectedColor: style.selectedColor,
        tileColor: style._resolveTileColor(theme.colorScheme),
        splashColor: style.splashColor,
        enabled: style.enabled,
        autofocus: style.autofocus,
        focusNode: style.focusNode,
        isThreeLine: style.isThreeLine,
        visualDensity: style.visualDensity,
        shape: style.shape,
        style: style.style,
        enableFeedback: style.enableFeedback,
        mouseCursor: style.mouseCursor,
        horizontalTitleGap: style.horizontalTitleGap,
        minVerticalPadding: style.minVerticalPadding,
        minLeadingWidth: style.minLeadingWidth,
      ),
    );
  }
}

/// An [Icon] whose color falls back to a [ColorScheme] role at build time.
class _SchemeIcon extends StatelessWidget {
  const _SchemeIcon(
    this.icon, {
    required this.fallback,
    required this.size,
    this.color,
  });

  final IconData icon;
  final Color? color;
  final Color Function(ColorScheme scheme) fallback;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? fallback(Theme.of(context).colorScheme),
    );
  }
}

class _SheetActionBadge extends StatelessWidget {
  const _SheetActionBadge({
    required this.icon,
    required this.accentColor,
    required this.enabled,
  });

  final IconData icon;
  final Color? accentColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = enabled
        ? (accentColor ?? scheme.primary)
        : scheme.onSurface.withValues(alpha: 0.38);

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(icon, color: accent, size: 20.0),
    );
  }
}
