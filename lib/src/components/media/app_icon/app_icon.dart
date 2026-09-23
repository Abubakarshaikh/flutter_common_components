import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum BackgroundShape { circle, square, roundedSquare }

/// Renders an [IconData], a network image, or an asset image (PNG/SVG) at a
/// fixed size, optionally on a circular or square background.
///
/// With [scaleOnLargeScreens] (default), sizes grow ×1.5 on screens at least
/// 600 logical pixels wide.
///
/// ```dart
/// AppIcon(Icons.home)
/// AppIcon('https://example.com/logo.png', size: 32)
/// AppIcon.icons('diary.svg', color: Theme.of(context).colorScheme.primary)
/// AppIcon(Icons.check, enableBackground: true, backgroundShape: BackgroundShape.roundedSquare)
/// ```
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.value, {
    super.key,
    this.size = 24.0,
    this.color,
    this.padding,
    this.margin,
    this.enableBackground = false,
    this.backgroundColor,
    this.backgroundShape = BackgroundShape.circle,
    this.backgroundRadius = 8.0,
    this.backgroundSize,
    this.backgroundSizeRatio = 1.2,
    this.assetBasePath = 'assets/images/',
    this.errorIcon = Icons.error_outline,
    this.errorColor,
    this.fit = BoxFit.contain,
    this.scaleOnLargeScreens = true,
  });

  /// Base directory used by [AppIcon.icons].
  static const String kIconsAssetDir = 'assets/icons/';

  /// Loads an asset under [kIconsAssetDir].
  ///
  /// Accepts a file name, a relative path such as `subscription/foo.svg`, or
  /// any full path beginning with `assets/`.
  const AppIcon.icons(
    String assetPath, {
    Key? key,
    double size = 24.0,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool enableBackground = false,
    Color? backgroundColor,
    BackgroundShape backgroundShape = BackgroundShape.circle,
    double backgroundRadius = 8.0,
    double? backgroundSize,
    double backgroundSizeRatio = 1.2,
    IconData errorIcon = Icons.error_outline,
    Color? errorColor,
    BoxFit fit = BoxFit.contain,
    bool scaleOnLargeScreens = true,
  }) : this(
         assetPath,
         key: key,
         size: size,
         color: color,
         padding: padding,
         margin: margin,
         enableBackground: enableBackground,
         backgroundColor: backgroundColor,
         backgroundShape: backgroundShape,
         backgroundRadius: backgroundRadius,
         backgroundSize: backgroundSize,
         backgroundSizeRatio: backgroundSizeRatio,
         assetBasePath: kIconsAssetDir,
         errorIcon: errorIcon,
         errorColor: errorColor,
         fit: fit,
         scaleOnLargeScreens: scaleOnLargeScreens,
       );

  /// The value which can be:
  /// - [IconData] for built-in icons
  /// - a `http://` / `https://` URL for network images
  /// - any other String for asset images (prefixed with [assetBasePath]
  ///   unless it already starts with `assets/` or [assetBasePath])
  final Object? value;

  /// Size of the icon
  final double size;

  /// Color of the icon (tints IconData and SVG assets). When
  /// [enableBackground] is true it defaults to `ColorScheme.onSurface`.
  final Color? color;

  /// Padding around the icon
  final EdgeInsetsGeometry? padding;

  /// Margin around the icon container
  final EdgeInsetsGeometry? margin;

  /// Whether to show a background behind the icon
  final bool enableBackground;

  /// Background color. Defaults to `ColorScheme.surfaceContainerHighest`.
  final Color? backgroundColor;

  /// Shape of the background
  final BackgroundShape backgroundShape;

  /// Radius for rounded corners (applies to roundedSquare)
  final double backgroundRadius;

  /// Size of the background
  final double? backgroundSize;

  /// Ratio of background size to icon size (if backgroundSize is not specified)
  final double backgroundSizeRatio;

  /// Base path for asset images
  final String assetBasePath;

  /// Icon to display in case of error
  final IconData errorIcon;

  /// Color for the error icon. Defaults to `ColorScheme.error`.
  final Color? errorColor;

  /// How the asset image should be inscribed
  final BoxFit fit;

  /// Grow sizes ×1.5 on screens at least 600 logical pixels wide.
  final bool scaleOnLargeScreens;

  double _scale(double value, bool isMobile) =>
      scaleOnLargeScreens && !isMobile ? value * 1.5 : value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final effectiveSize = _scale(size, isMobile);
    final effectiveBackgroundSize = backgroundSize != null
        ? _scale(backgroundSize!, isMobile)
        : null;
    final iconWidget = _buildIcon(
      effectiveSize,
      enableBackground ? color ?? scheme.onSurface : color,
      errorColor ?? scheme.error,
    );

    if (enableBackground) {
      final dimension =
          effectiveBackgroundSize ?? effectiveSize * backgroundSizeRatio;
      return Container(
        margin: margin,
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color: backgroundColor ?? scheme.surfaceContainerHighest,
          shape: backgroundShape == BackgroundShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: backgroundShape == BackgroundShape.roundedSquare
              ? BorderRadius.circular(backgroundRadius)
              : null,
        ),
        child: Center(
          child: Padding(
            padding: padding ?? EdgeInsets.all(effectiveSize * 0.1),
            child: iconWidget,
          ),
        ),
      );
    }

    return Container(margin: margin, padding: padding, child: iconWidget);
  }

  Widget _buildIcon(double effectiveSize, Color? effectiveColor, Color error) {
    final value = this.value;
    if (value is IconData) {
      return Icon(value, size: effectiveSize, color: effectiveColor);
    }
    if (value is String) {
      if (value.startsWith('http://') || value.startsWith('https://')) {
        return _buildNetworkImage(value, effectiveSize, error);
      }
      return _buildAssetImage(value, effectiveColor, effectiveSize, error);
    }
    return Icon(errorIcon, size: effectiveSize, color: error);
  }

  Widget _buildAssetImage(
    String assetPath,
    Color? effectiveColor,
    double effectiveSize,
    Color error,
  ) {
    final fullAssetPath =
        assetPath.startsWith('assets/') || assetPath.startsWith(assetBasePath)
        ? assetPath
        : '$assetBasePath$assetPath';

    if (fullAssetPath.toLowerCase().endsWith('.svg')) {
      return SizedBox.square(
        dimension: effectiveSize,
        child: SvgPicture.asset(
          fullAssetPath,
          width: effectiveSize,
          height: effectiveSize,
          fit: fit,
          colorFilter: effectiveColor != null
              ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
              : null,
          // Runs while the SVG decodes, not on failure — an error icon here
          // would flash on every load.
          placeholderBuilder: (_) => SizedBox.square(dimension: size),
        ),
      );
    }

    return SizedBox.square(
      dimension: effectiveSize,
      child: Image.asset(
        fullAssetPath,
        width: effectiveSize,
        height: effectiveSize,
        fit: fit,
        errorBuilder: (context, exception, stackTrace) =>
            Icon(errorIcon, size: effectiveSize, color: error),
      ),
    );
  }

  Widget _buildNetworkImage(String url, double effectiveSize, Color error) {
    return SizedBox.square(
      dimension: effectiveSize,
      child: CachedNetworkImage(
        imageUrl: url,
        width: effectiveSize,
        height: effectiveSize,
        fit: fit,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (context, url, exception) =>
            Icon(errorIcon, size: effectiveSize, color: error),
      ),
    );
  }
}
