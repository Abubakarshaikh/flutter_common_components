import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform card widget that adapts to iOS and Android platforms
/// Provides multiple card variants with customizable styling
/// Follows composition-over-inheritance principle with CardStyle

/// A platform-adaptive card widget with extensive customization options
///
/// CommonCard provides a unified API for creating cards that adapt to
/// the current platform (iOS or Android) with appropriate styling and behavior.
/// It supports multiple visual variants through factory constructors.
///
/// Usage examples:
/// ```dart
/// // Basic card with default styling
/// CommonCard(
///   child: Text('Hello World'),
/// )
///
/// // Custom styled card
/// CommonCard.custom(
///   child: Text('Custom Card'),
///   elevation: 8.0,
///   backgroundColor: Colors.blue[50],
///   borderRadius: 16.0,
///   hasBorder: true,
///   borderColor: Colors.blue,
/// )
///
/// // Flat card with no elevation
/// CommonCard.flat(
///   child: Text('Flat Card'),
///   padding: EdgeInsets.all(16.0),
/// )
///
/// // Circular card for profile pictures
/// CommonCard.circular(
///   child: Image.asset('assets/profile.jpg'),
///   size: 80.0,
/// )
/// ```
class CommonCard extends StatelessWidget {
  /// Default constructor - creates a standard card with default styling
  const CommonCard({
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
  });

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

  /// Factory constructor for a custom styled card
  factory CommonCard.custom({
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
    return CommonCard(
      variant: CardVariant.custom,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ) ??
          CommonCardStyle(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ),
      child: child,
    );
  }

  /// Factory constructor for a flat card with no elevation
  factory CommonCard.flat({
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
    return CommonCard(
      variant: CardVariant.flat,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: backgroundColor,
            elevation: 0,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
          ) ??
          CommonCardStyle(
            backgroundColor: backgroundColor,
            elevation: 0,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
          ),
      child: child,
    );
  }

  /// Factory constructor for an outlined card with a border
  factory CommonCard.outlined({
    required Widget child,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color borderColor = Colors.grey,
    double borderWidth = 1.0,
    VoidCallback? onTap,
    double? width,
    double? height,
    Alignment? alignment,
    CommonCardStyle? style,
  }) {
    return CommonCard(
      variant: CardVariant.outlined,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: backgroundColor,
            elevation: 0,
            borderRadius: borderRadius,
            border: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ) ??
          CommonCardStyle(
            backgroundColor: backgroundColor,
            elevation: 0,
            borderRadius: borderRadius,
            border: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
      child: child,
    );
  }

  /// Factory constructor for a circular card (useful for profile pictures)
  factory CommonCard.circular({
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
    return CommonCard(
      variant: CardVariant.circular,
      margin: margin,
      onTap: onTap,
      width: size,
      height: size,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: size / 2, // Make it circular
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ) ??
          CommonCardStyle(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: size / 2, // Make it circular
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ),
      child: child,
    );
  }

  /// Factory constructor for a transparent card with no background
  factory CommonCard.transparent({
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
    return CommonCard(
      variant: CardVariant.transparent,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: Colors.transparent,
            elevation: 0,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
          ) ??
          CommonCardStyle(
            backgroundColor: Colors.transparent,
            elevation: 0,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
          ),
      child: child,
    );
  }

  /// Factory constructor for a card with high elevation (shadowed)
  factory CommonCard.elevated({
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
    return CommonCard(
      variant: CardVariant.elevated,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      alignment: alignment,
      style: style?.copyWith(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ) ??
          CommonCardStyle(
            backgroundColor: backgroundColor,
            elevation: elevation,
            borderRadius: borderRadius,
            border: hasBorder
                ? BorderSide(
                    color: borderColor ?? Colors.grey,
                    width: borderWidth,
                  )
                : null,
            shadow: shadow,
          ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _getEffectiveStyle(context);

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
      cardContent = Align(
        alignment: alignment!,
        child: cardContent,
      );
    }

    // Create the card based on platform
    Widget card = Platform.isIOS
        ? _buildCupertinoCard(context, effectiveStyle, cardContent)
        : _buildMaterialCard(context, effectiveStyle, cardContent);

    // Apply size constraints if specified
    if (width != null || height != null) {
      card = SizedBox(
        width: width,
        height: height,
        child: card,
      );
    }

    // Make the card tappable if onTap is provided
    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
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
    // For circular variant
    if (variant == CardVariant.circular) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: style.backgroundColor ?? CupertinoColors.systemBackground,
          shape: BoxShape.circle,
          border: style.border != null
              ? Border.all(
                  color: style.border!.color,
                  width: style.border!.width,
                )
              : null,
          boxShadow: style.elevation == null || style.elevation == 0
              ? null
              : [
                  style.shadow ??
                      BoxShadow(
                        color: CupertinoColors.systemGrey.withOpacity(0.2),
                        blurRadius: style.elevation! * 0.5,
                        offset: Offset(0, style.elevation! * 0.3),
                      ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    // For other variants
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor ?? CupertinoColors.systemBackground,
        borderRadius: style.borderRadius != null
            ? BorderRadius.circular(style.borderRadius!)
            : BorderRadius.circular(8.0),
        border: style.border != null
            ? Border.all(
                color: style.border!.color,
                width: style.border!.width,
              )
            : null,
        boxShadow: style.elevation == null || style.elevation == 0
            ? null
            : [
                style.shadow ??
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: style.elevation! * 0.5,
                      offset: Offset(0, style.elevation! * 0.3),
                    ),
              ],
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
          border: style.border != null
              ? Border.all(
                  color: style.border!.color,
                  width: style.border!.width,
                )
              : null,
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
          border: style.border != null
              ? Border.all(
                  color: style.border!.color,
                  width: style.border!.width,
                )
              : null,
          boxShadow: style.elevation == null || style.elevation == 0
              ? null
              : [
                  style.shadow ??
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
          borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
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
        borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
        side: style.border ?? BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  /// Get the effective style by merging default, variant, and custom styles
  CommonCardStyle _getEffectiveStyle(BuildContext context) {
    // Get default style based on platform and variant
    final defaultStyle = _getDefaultStyle(context);

    // Apply custom style on top of default if provided
    return style != null ? _mergeStyles(defaultStyle, style!) : defaultStyle;
  }

  /// Get default style based on platform and variant
  CommonCardStyle _getDefaultStyle(BuildContext context) {
    final theme = Theme.of(context);

    switch (variant) {
      case CardVariant.standard:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: Platform.isIOS ? 0.5 : 1.0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
        );

      case CardVariant.flat:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: 0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
        );

      case CardVariant.outlined:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: 0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
          border: BorderSide(
            color: Platform.isIOS
                ? CupertinoColors.systemGrey4
                : Colors.grey[300]!,
          ),
        );

      case CardVariant.circular:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: Platform.isIOS ? 0.5 : 1.0,
          borderRadius: 40.0, // Half of default 80.0 size
        );

      case CardVariant.elevated:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: Platform.isIOS ? 3.0 : 8.0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
        );

      case CardVariant.transparent:
        return CommonCardStyle(
          backgroundColor: Colors.transparent,
          elevation: 0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
        );

      case CardVariant.custom:
        return CommonCardStyle(
          backgroundColor: Platform.isIOS
              ? CupertinoColors.systemBackground
              : theme.cardColor,
          elevation: Platform.isIOS ? 0.5 : 1.0,
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          padding: const EdgeInsets.all(16.0),
        );
    }
  }

  /// Merge base style with override style
  CommonCardStyle _mergeStyles(
    CommonCardStyle base,
    CommonCardStyle override,
  ) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      elevation: override.elevation,
      borderRadius: override.borderRadius,
      padding: override.padding,
      margin: override.margin,
      border: override.border,
      shadow: override.shadow,
    );
  }
}

/// Card variants supported by CommonCard
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

/// Styling configuration for CommonCard
/// Uses composition pattern to configure card appearance
class CommonCardStyle {
  /// Background color of the card
  final Color? backgroundColor;

  /// Elevation for Material cards (for shadow depth)
  final double? elevation;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Padding inside the card
  final EdgeInsets? padding;

  /// Margin around the card
  final EdgeInsets? margin;

  /// Border styling for outlined cards
  final BorderSide? border;

  /// Custom shadow styling
  final BoxShadow? shadow;

  const CommonCardStyle({
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.shadow,
  });

  CommonCardStyle copyWith({
    Color? backgroundColor,
    double? elevation,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderSide? border,
    BoxShadow? shadow,
  }) {
    return CommonCardStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }
}
