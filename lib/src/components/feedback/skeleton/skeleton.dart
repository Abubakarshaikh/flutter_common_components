import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    this.width,
    this.height,
    this.margin,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.key,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  /// Defaults to [ColorScheme.outline].
  final Color? color;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
      color: color ?? Theme.of(context).colorScheme.outline,
      borderRadius: borderRadius,
    ),
  );
}
