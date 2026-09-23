import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Styling configuration for [AppCard].
///
/// Register app-wide via `ThemeData(extensions: [CommonCardStyle(...)])` or
/// pass per instance through `AppCard(style: ...)`. Resolution order is:
/// variant defaults → theme extension → per-instance style. Any `null` field
/// keeps the value from the previous layer.
@immutable
class CommonCardStyle extends ThemeExtension<CommonCardStyle> {
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

  /// The app-wide style registered on the ambient [ThemeData], if any.
  static CommonCardStyle? maybeOf(BuildContext context) =>
      Theme.of(context).extension<CommonCardStyle>();

  /// Returns this style with every non-null field of [other] applied on top.
  CommonCardStyle merge(CommonCardStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      elevation: other.elevation,
      borderRadius: other.borderRadius,
      padding: other.padding,
      margin: other.margin,
      border: other.border,
      shadow: other.shadow,
    );
  }

  @override
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

  @override
  CommonCardStyle lerp(covariant CommonCardStyle? other, double t) {
    if (other == null) return this;
    return CommonCardStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      margin: EdgeInsets.lerp(margin, other.margin, t),
      border: border == null || other.border == null
          ? (t < 0.5 ? border : other.border)
          : BorderSide.lerp(border!, other.border!, t),
      shadow: BoxShadow.lerp(shadow, other.shadow, t),
    );
  }
}
