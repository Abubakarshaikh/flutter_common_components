import 'package:flutter/material.dart';

const Color _kSuccessColor = Color(0xFF04B100);
const Color _kWarningColor = Color(0xFFFF9900);

/// Styling for [ConnectionBanner].
///
/// Register app-wide via `ThemeData(extensions: [ConnectionBannerTheme(...)])`
/// or pass per instance through `ConnectionBanner(style: ...)`. Any `null`
/// field falls back to a value derived from the ambient [ColorScheme].
@immutable
class ConnectionBannerTheme extends ThemeExtension<ConnectionBannerTheme> {
  const ConnectionBannerTheme({
    this.restoredColor,
    this.offlineColor,
    this.backgroundColor,
    this.textColor,
  });

  factory ConnectionBannerTheme.fallback(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConnectionBannerTheme(
      restoredColor: _kSuccessColor,
      offlineColor: _kWarningColor,
      backgroundColor: scheme.surface,
      textColor: scheme.onSurface,
    );
  }

  static ConnectionBannerTheme of(BuildContext context) =>
      ConnectionBannerTheme.fallback(
        context,
      ).merge(Theme.of(context).extension<ConnectionBannerTheme>());

  /// Accent (icon, border) when the connection has come back.
  final Color? restoredColor;

  /// Accent (icon, border) while offline.
  final Color? offlineColor;
  final Color? backgroundColor;
  final Color? textColor;

  ConnectionBannerTheme merge(ConnectionBannerTheme? other) {
    if (other == null) return this;
    return copyWith(
      restoredColor: other.restoredColor,
      offlineColor: other.offlineColor,
      backgroundColor: other.backgroundColor,
      textColor: other.textColor,
    );
  }

  @override
  ConnectionBannerTheme copyWith({
    Color? restoredColor,
    Color? offlineColor,
    Color? backgroundColor,
    Color? textColor,
  }) => ConnectionBannerTheme(
    restoredColor: restoredColor ?? this.restoredColor,
    offlineColor: offlineColor ?? this.offlineColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    textColor: textColor ?? this.textColor,
  );

  @override
  ConnectionBannerTheme lerp(covariant ConnectionBannerTheme? other, double t) {
    if (other == null) return this;
    return ConnectionBannerTheme(
      restoredColor: Color.lerp(restoredColor, other.restoredColor, t),
      offlineColor: Color.lerp(offlineColor, other.offlineColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
    );
  }
}
