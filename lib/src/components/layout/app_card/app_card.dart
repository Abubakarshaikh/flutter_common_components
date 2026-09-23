import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_card_theme.dart';

const double _kDefaultRadius = 8.0;
const double _kDefaultRadiusIOS = 10.0;
const EdgeInsets _kDefaultPadding = EdgeInsets.all(16.0);
const Color _kNeutralSurface = Color(0xFFE0E0E0);

/// A platform-adaptive card widget with extensive customization options.
///
/// AppCard provides a unified API for creating cards that adapt to the current
/// platform (iOS or Android) with appropriate styling and behavior. It
/// supports multiple visual variants through factory constructors.
///
/// Usage examples:
/// ```dart
/// // Basic card with default styling
/// AppCard(
///   child: Text('Hello World'),
/// )
///
/// // Custom styled card
/// AppCard.custom(
///   child: Text('Custom Card'),
///   elevation: 8.0,
///   backgroundColor: Colors.blue[50],
///   borderRadius: 16.0,
///   hasBorder: true,
///   borderColor: Colors.blue,
/// )
///
/// // Flat card with no elevation
/// AppCard.flat(
///   child: Text('Flat Card'),
///   padding: EdgeInsets.all(16.0),
/// )
///
/// // Circular card for profile pictures
/// AppCard.circular(
///   child: Image.asset('assets/profile.jpg'),
///   size: 80.0,
/// )
/// ```
///
/// When a factory's `hasBorder` is true and `borderColor` is null, the border
/// uses [ColorScheme.onSurfaceVariant].
class AppCard extends StatelessWidget {
  /// Default constructor - creates a standard card with default styling
  const AppCard({
    super.key,
    required this.child,
    this.style,
    this.variant = CardVariant.standard,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.alignment,
  }) : _hasBorder = false,
       _borderColor = null,
       _borderWidth = 1.0;

  const AppCard._({
    required this.child,
    required this.variant,
    this.style,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.alignment,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
  }) : _hasBorder = hasBorder,
       _borderColor = borderColor,
       _borderWidth = borderWidth;

  /// The widget to display inside the card
  final Widget child;

  /// Style customization for the card
  final CommonCardStyle? style;

  /// The card variant type
  final CardVariant variant;

  /// Padding inside the card (overrides style's padding)
  final EdgeInsets? padding;

  /// Margin around the card (overrides style's margin)
  final EdgeInsets? margin;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Explicit width of the card
  final double? width;

  /// Explicit height of the card
  final double? height;

  /// Alignment of the child within the card
  final Alignment? alignment;

  final bool _hasBorder;
  final Color? _borderColor;
  final double _borderWidth;

  /// Factory constructor for a custom styled card
  factory AppCard.custom({
    required Widget child,
    Color? backgroundColor,
    double? elevation,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    BoxShadow? shadow,
    CommonCardStyle? style,
  }) {
    return AppCard._(
      variant: CardVariant.custom,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      hasBorder: hasBorder,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: backgroundColor,
        elevation: elevation,
        borderRadius: borderRadius,
        shadow: shadow,
      ),
      child: child,
    );
  }

  /// Factory constructor for a flat card with no elevation
  factory AppCard.flat({
    required Widget child,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    CommonCardStyle? style,
  }) {
    return AppCard._(
      variant: CardVariant.flat,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      hasBorder: hasBorder,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: backgroundColor,
        elevation: 0,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  /// Factory constructor for an outlined card with a border
  factory AppCard.outlined({
    required Widget child,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    CommonCardStyle? style,
  }) {
    return AppCard._(
      variant: CardVariant.outlined,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      hasBorder: true,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: backgroundColor,
        elevation: 0,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  /// Factory constructor for a circular card (useful for profile pictures)
  factory AppCard.circular({
    required Widget child,
    Color? backgroundColor,
    double? elevation,
    double size = 80.0,
    EdgeInsets? margin,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    BoxShadow? shadow,
    CommonCardStyle? style,
    Alignment? alignment,
  }) {
    return AppCard._(
      variant: CardVariant.circular,
      margin: margin,
      onTap: onTap,
      width: size,
      height: size,
      alignment: alignment,
      hasBorder: hasBorder,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: backgroundColor,
        elevation: elevation,
        borderRadius: size / 2,
        shadow: shadow,
      ),
      child: child,
    );
  }

  /// Factory constructor for a transparent card with no background
  factory AppCard.transparent({
    required Widget child,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    CommonCardStyle? style,
  }) {
    return AppCard._(
      variant: CardVariant.transparent,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      hasBorder: hasBorder,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: Colors.transparent,
        elevation: 0,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  /// Factory constructor for a card with high elevation (shadowed)
  factory AppCard.elevated({
    required Widget child,
    Color? backgroundColor,
    double elevation = 8.0,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool hasBorder = false,
    Color? borderColor,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    BoxShadow? shadow,
    CommonCardStyle? style,
  }) {
    return AppCard._(
      variant: CardVariant.elevated,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      hasBorder: hasBorder,
      borderColor: borderColor,
      borderWidth: borderWidth,
      style: (style ?? const CommonCardStyle()).copyWith(
        backgroundColor: backgroundColor,
        elevation: elevation,
        borderRadius: borderRadius,
        shadow: shadow,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final effectiveStyle = _getEffectiveStyle(context, isIOS);

    Widget cardContent = child;

    // Apply padding if specified
    if (padding != null || effectiveStyle.padding != null) {
      cardContent = Padding(
        padding: padding ?? effectiveStyle.padding ?? EdgeInsets.zero,
        child: cardContent,
      );
    }

    // Apply alignment if specified
    if (alignment != null) {
      cardContent = Align(alignment: alignment!, child: cardContent);
    }

    // Create the card based on platform
    Widget card = isIOS
        ? _buildCupertinoCard(context, effectiveStyle, cardContent)
        : _buildMaterialCard(context, effectiveStyle, cardContent);

    // Apply size constraints if specified
    if (width != null || height != null) {
      card = SizedBox(width: width, height: height, child: card);
    }

    // Make the card tappable if onTap is provided
    if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    // Apply margin if specified
    if (margin != null || effectiveStyle.margin != null) {
      card = Padding(
        padding: margin ?? effectiveStyle.margin ?? EdgeInsets.zero,
        child: card,
      );
    }

    return card;
  }

  /// Build a Cupertino-styled card (for iOS)
  Widget _buildCupertinoCard(
    BuildContext context,
    CommonCardStyle style,
    Widget child,
  ) {
    final List<BoxShadow>? boxShadow =
        style.elevation == null || style.elevation == 0
        ? null
        : [
            style.shadow ??
                BoxShadow(
                  color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
                  blurRadius: style.elevation! * 0.5,
                  offset: Offset(0, style.elevation! * 0.3),
                ),
          ];

    // For circular variant
    if (variant == CardVariant.circular) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: style.backgroundColor ?? CupertinoColors.systemBackground,
          shape: BoxShape.circle,
          border: _boxBorder(style),
          boxShadow: boxShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    // For other variants
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor ?? CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(
          style.borderRadius ?? _kDefaultRadius,
        ),
        border: _boxBorder(style),
        boxShadow: boxShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  /// Build a Material-styled card (for Android)
  Widget _buildMaterialCard(
    BuildContext context,
    CommonCardStyle style,
    Widget child,
  ) {
    final theme = Theme.of(context);

    // For transparent variant, we'll use a simple Container
    if (variant == CardVariant.transparent) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: style.borderRadius != null
              ? BorderRadius.circular(style.borderRadius!)
              : null,
          border: _boxBorder(style),
        ),
        child: child,
      );
    }

    // For circular variant
    if (variant == CardVariant.circular) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: style.backgroundColor ?? theme.cardColor,
          shape: BoxShape.circle,
          border: _boxBorder(style),
          boxShadow: style.elevation == null || style.elevation == 0
              ? null
              : [
                  style.shadow ??
                      BoxShadow(
                        color: theme.colorScheme.scrim.withValues(alpha: 0.1),
                        blurRadius: style.elevation!,
                        offset: Offset(0, style.elevation! * 0.5),
                      ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    // For outlined variant with no elevation
    if (variant == CardVariant.outlined || variant == CardVariant.flat) {
      return Material(
        color: style.backgroundColor ?? theme.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            style.borderRadius ?? _kDefaultRadius,
          ),
          side: style.border ?? BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    // For standard and other variants
    return Material(
      color: style.backgroundColor ?? theme.cardColor,
      elevation: style.elevation ?? 1.0,
      shadowColor: style.shadow?.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          style.borderRadius ?? _kDefaultRadius,
        ),
        side: style.border ?? BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  BoxBorder? _boxBorder(CommonCardStyle style) => style.border != null
      ? Border.all(color: style.border!.color, width: style.border!.width)
      : null;

  /// Merges variant defaults, the theme extension and the per-instance style.
  CommonCardStyle _getEffectiveStyle(BuildContext context, bool isIOS) {
    var effective = _getDefaultStyle(
      context,
      isIOS,
    ).merge(CommonCardStyle.maybeOf(context)).merge(style);

    if (_hasBorder) {
      effective = effective.copyWith(
        border: BorderSide(
          color: _borderColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
          width: _borderWidth,
        ),
      );
    }
    return effective;
  }

  /// Get default style based on platform and variant
  CommonCardStyle _getDefaultStyle(BuildContext context, bool isIOS) {
    final cardColor = Theme.of(context).cardColor;
    final radius = isIOS ? _kDefaultRadiusIOS : _kDefaultRadius;

    switch (variant) {
      case CardVariant.standard:
      case CardVariant.custom:
        return CommonCardStyle(
          backgroundColor: cardColor,
          elevation: isIOS ? 0.5 : 1.0,
          borderRadius: radius,
          padding: _kDefaultPadding,
        );

      case CardVariant.flat:
        return CommonCardStyle(
          backgroundColor: cardColor,
          elevation: 0,
          borderRadius: radius,
          padding: _kDefaultPadding,
        );

      case CardVariant.outlined:
        return CommonCardStyle(
          backgroundColor: cardColor,
          elevation: 0,
          borderRadius: radius,
          padding: _kDefaultPadding,
          border: BorderSide(
            color: isIOS ? CupertinoColors.systemGrey4 : _kNeutralSurface,
          ),
        );

      case CardVariant.circular:
        return CommonCardStyle(
          backgroundColor: cardColor,
          elevation: isIOS ? 0.5 : 1.0,
          borderRadius: 40.0, // Half of default 80.0 size
        );

      case CardVariant.elevated:
        return CommonCardStyle(
          backgroundColor: cardColor,
          elevation: isIOS ? 3.0 : 8.0,
          borderRadius: radius,
          padding: _kDefaultPadding,
        );

      case CardVariant.transparent:
        return CommonCardStyle(
          backgroundColor: Colors.transparent,
          elevation: 0,
          borderRadius: radius,
          padding: _kDefaultPadding,
        );
    }
  }
}

/// Card variants supported by [AppCard]
enum CardVariant {
  /// Standard card with default styling
  standard,

  /// Flat card with no elevation
  flat,

  /// Outlined card with a border
  outlined,

  /// Circular card (useful for profile pictures)
  circular,

  /// Card with higher elevation (shadowed)
  elevated,

  /// Transparent card with no background
  transparent,

  /// Custom card with specified styling
  custom,
}
