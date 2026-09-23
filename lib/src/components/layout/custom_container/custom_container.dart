import 'package:flutter/material.dart';

/// A rounded, filled box for grouping content.
///
/// [color] defaults to [ColorScheme.surface].
class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    required this.child,
    this.color,
    this.margin,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    this.borderRadius = 10.0,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? Theme.of(context).colorScheme.surface,
      ),
      padding: padding,
      child: child,
    );
  }
}
