import 'package:flutter/material.dart';

class CommonInputChip extends StatelessWidget {
  const CommonInputChip({
    required this.label,
    this.onPressed,
    this.onDeletePressed,
    this.count = 0,
    this.isSelected = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onDeletePressed;

  /// Shown when [isSelected]; values above 9 render as `+10`.
  final int count;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final background = isSelected ? scheme.primary : scheme.outline;
    final foreground = isSelected ? scheme.onPrimary : scheme.onSurface;
    final labelStyle = theme.textTheme.labelSmall?.copyWith(color: foreground);

    return Align(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: theme.textTheme.bodySmall,
          minimumSize: const Size(double.minPositive, 30),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          backgroundColor: background,
          foregroundColor: foreground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: labelStyle),
            const SizedBox(width: 6),
            if (isSelected) ...[
              Text(count > 9 ? '+10' : '$count', style: labelStyle),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDeletePressed,
                child: Icon(Icons.close, size: 18, color: foreground),
              ),
            ] else
              const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}
