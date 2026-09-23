import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.onTap,
    this.icon = Icons.add,
    this.iconSize = 12,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final double iconSize;

  /// Defaults to [ColorScheme.primary].
  final Color? backgroundColor;

  /// Defaults to [ColorScheme.onPrimary].
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: backgroundColor ?? scheme.primary,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: foregroundColor ?? scheme.onPrimary,
        ),
      ),
    );
  }
}
