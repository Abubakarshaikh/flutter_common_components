import 'package:flutter/material.dart';

/// A title-weight label on a rounded, tinted container.
///
/// Defaults to `surfaceContainerHighest` behind `onSurface` text.
class TertiaryContainerText extends StatelessWidget {
  final String text;

  /// Container fill. Defaults to `ColorScheme.surfaceContainerHighest`.
  final Color? backgroundColor;

  /// Text color. Defaults to `ColorScheme.onSurface`.
  final Color? textColor;

  const TertiaryContainerText({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor ?? scheme.surfaceContainerHighest,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: theme.textTheme.titleMedium?.copyWith(
          color: textColor ?? scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
