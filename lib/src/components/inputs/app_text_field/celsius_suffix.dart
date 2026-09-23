import 'package:flutter/material.dart';

/// °C suffix for temperature fields. Pass as [AppTextField.suffixIcon].
///
/// [color] defaults to `ColorScheme.onSurface`; [dividerColor] (the left
/// separator) defaults to `ColorScheme.outline`.
class CelsiusSuffix extends StatelessWidget {
  const CelsiusSuffix({super.key, this.color, this.dividerColor});

  final Color? color;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: dividerColor ?? theme.colorScheme.outline,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerRight,
          child: Text(
            '°C',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: color ?? theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
