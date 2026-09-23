import 'package:flutter/material.dart';

class SizedLoadingIndicator extends StatelessWidget {
  const SizedLoadingIndicator({
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.size = const Size(68, 68),
    this.strokeWidth = 3,
    this.color,
    super.key,
  });

  /// 20x20 spinner sized for use inside buttons.
  const SizedLoadingIndicator.small({this.color, super.key})
    : alignment = Alignment.center,
      padding = EdgeInsets.zero,
      size = const Size(20, 20),
      strokeWidth = 2;

  /// 32x32 spinner.
  const SizedLoadingIndicator.medium({this.color, super.key})
    : alignment = Alignment.center,
      padding = EdgeInsets.zero,
      size = const Size(32, 32),
      strokeWidth = 2;

  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Size size;
  final double strokeWidth;

  /// Defaults to [ColorScheme.primary].
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
    alignment: alignment,
    padding: padding,
    width: size.width,
    height: size.height,
    child: CircularProgressIndicator(
      color: color ?? Theme.of(context).colorScheme.primary,
      strokeWidth: strokeWidth,
    ),
  );
}
