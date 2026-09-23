import 'dart:ui' show lerpDouble;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Styling for [AppSwitchButton].
///
/// Register app-wide via `ThemeData(extensions: [CommonSwitchStyle(...)])`
/// or pass per instance through `AppSwitchButton(style: ...)`. Any `null`
/// field falls back to a platform-appropriate value derived from the ambient
/// [ColorScheme].
@immutable
class CommonSwitchStyle extends ThemeExtension<CommonSwitchStyle> {
  const CommonSwitchStyle({
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.inactiveThumbColor,
    this.scale,
  });

  factory CommonSwitchStyle.fallback(BuildContext context) {
    final theme = Theme.of(context);
    final isIOS = theme.platform == TargetPlatform.iOS;
    return CommonSwitchStyle(
      activeColor: isIOS ? CupertinoColors.systemBlue : theme.colorScheme.primary,
      inactiveColor: isIOS
          ? CupertinoColors.systemGrey5
          : theme.colorScheme.onSurface.withValues(alpha: 0.3),
      thumbColor: isIOS ? CupertinoColors.white : null,
      inactiveThumbColor: isIOS
          ? CupertinoColors.white
          : theme.colorScheme.surface,
      scale: 1.0,
    );
  }

  static CommonSwitchStyle of(BuildContext context) => CommonSwitchStyle.fallback(
    context,
  ).merge(Theme.of(context).extension<CommonSwitchStyle>());

  /// Track color when the switch is on.
  final Color? activeColor;

  /// Track color when the switch is off.
  final Color? inactiveColor;

  /// Thumb (handle) color when on (and always, on iOS).
  final Color? thumbColor;

  /// Thumb color when off (Material only).
  final Color? inactiveThumbColor;

  /// Scale factor applied to the switch.
  final double? scale;

  CommonSwitchStyle merge(CommonSwitchStyle? other) {
    if (other == null) return this;
    return copyWith(
      activeColor: other.activeColor,
      inactiveColor: other.inactiveColor,
      thumbColor: other.thumbColor,
      inactiveThumbColor: other.inactiveThumbColor,
      scale: other.scale,
    );
  }

  @override
  CommonSwitchStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    Color? inactiveThumbColor,
    double? scale,
  }) => CommonSwitchStyle(
    activeColor: activeColor ?? this.activeColor,
    inactiveColor: inactiveColor ?? this.inactiveColor,
    thumbColor: thumbColor ?? this.thumbColor,
    inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
    scale: scale ?? this.scale,
  );

  @override
  CommonSwitchStyle lerp(covariant CommonSwitchStyle? other, double t) {
    if (other == null) return this;
    return CommonSwitchStyle(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t),
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
      inactiveThumbColor: Color.lerp(
        inactiveThumbColor,
        other.inactiveThumbColor,
        t,
      ),
      scale: lerpDouble(scale, other.scale, t),
    );
  }
}
