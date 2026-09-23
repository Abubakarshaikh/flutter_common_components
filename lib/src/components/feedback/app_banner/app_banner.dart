import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color _kWarningColor = Color(0xFFFF9900);

/// A full-width, tinted status banner with an optional leading icon and
/// trailing widget.
///
/// [color] drives the defaults: the fill is `color` at 10% opacity, the border
/// at 30%, and the text / icon use `color` directly.
///
/// ```dart
/// AppBanner(
///   message: 'Inspection mode is on',
///   color: Theme.of(context).colorScheme.primary,
///   leadingIcon: Icons.info_outline,
/// )
/// ```
class AppBanner extends StatelessWidget {
  final String message;
  final Color color;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? leadingIcon;
  final Widget? trailingWidget;

  /// Gives [trailingWidget] 30% of the row, right-aligned.
  final bool expandTrailingWidget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  /// Corner radius. The default `8.0` becomes `16.0` on tablets; any other
  /// value grows by `8.0` on tablets.
  final double borderRadius;
  final double fontSize;
  final int? maxLines;
  final TextOverflow overflow;

  const AppBanner({
    super.key,
    required this.message,
    required this.color,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.leadingIcon,
    this.trailingWidget,
    this.expandTrailingWidget = false,
    this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.borderRadius = 8.0,
    this.fontSize = 12.0,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  /// Status banner, e.g. for an inspection mode or emergency access.
  const AppBanner.standard({
    super.key,
    required this.message,
    required this.color,
    this.trailingWidget,
    this.expandTrailingWidget = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
  }) : backgroundColor = null,
       borderColor = null,
       textColor = null,
       iconColor = null,
       leadingIcon = null,
       margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
       borderRadius = 8.0,
       fontSize = 12.0,
       maxLines = null,
       overflow = TextOverflow.clip;

  /// View-only / subscription lapsed banner in a warning color
  /// (`#FF9900` unless [color] is given).
  const AppBanner.subscription({
    super.key,
    required this.message,
    this.onTap,
    this.color = _kWarningColor,
  }) : backgroundColor = null,
       borderColor = null,
       textColor = null,
       iconColor = null,
       leadingIcon = null,
       trailingWidget = null,
       expandTrailingWidget = false,
       margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
       padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
       borderRadius = 8.0,
       fontSize = 12.0,
       maxLines = null,
       overflow = TextOverflow.clip;

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTabletFormFactor(context);
    final effectiveBorderRadius = borderRadius == 8.0
        ? (isTablet ? 16.0 : 8.0)
        : borderRadius + (isTablet ? 8.0 : 0.0);

    Widget content = Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: Border.all(
          color: borderColor ?? color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              color: iconColor ?? color,
              size: isTablet ? 22 : 14,
            ),
            const SizedBox(width: 8.0),
          ],
          Expanded(
            flex: expandTrailingWidget ? 7 : 1,
            child: Text(
              message,
              textAlign: TextAlign.start,
              maxLines: maxLines,
              overflow: overflow,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: textColor ?? color,
              ),
            ),
          ),
          if (expandTrailingWidget)
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: trailingWidget == null
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [const SizedBox(width: 8.0), trailingWidget!],
                      ),
              ),
            )
          else if (trailingWidget != null)
            trailingWidget!,
        ],
      ),
    );

    if (onTap != null) {
      content = GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}

/// Tablet-sized layout: handheld shortest side (or desktop/web width) of at
/// least 600, excluding desktop-sized screens with a shortest side over 1024.
bool _isTabletFormFactor(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final usesWidth =
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux;
  final width = usesWidth ? size.width : size.shortestSide;
  if (width < 600) return false;
  if (width < 950) return true;
  return size.shortestSide <= 1024;
}
