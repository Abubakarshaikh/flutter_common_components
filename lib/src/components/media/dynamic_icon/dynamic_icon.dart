import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

/// Renders an [IconData], an asset path (`.svg` or raster) or any [Widget].
class DynamicIcon extends StatelessWidget {
  const DynamicIcon(
    this.icon, {
    this.color,
    this.size,
    this.semanticLabel,
    super.key,
  }) : assert(icon is IconData || icon is String || icon is Widget);

  final Object icon;
  final Color? color;
  final double? size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return switch (icon) {
      IconData() => Icon(
        icon,
        color: color,
        size: size,
        semanticLabel: semanticLabel,
      ),
      String() when icon.toLowerCase().endsWith('.svg') => SvgPicture.asset(
        icon,
        width: size,
        height: size,
        semanticsLabel: semanticLabel,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      ),
      String() => Image.asset(
        icon,
        color: color,
        width: size,
        height: size,
        semanticLabel: semanticLabel,
      ),
      Widget() => icon,
      _ => const SizedBox.shrink(),
    };
  }
}
