import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'gradient_fill_button_theme.dart';

/// A filled button painted with a linear gradient.
///
/// Disabled when [onPressed] is `null`; shows a spinner when [isLoading].
class GradientFillButton extends StatelessWidget {
  const GradientFillButton({
    required this.text,
    required this.onPressed,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.areIconsClose = false,
    this.style,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  /// Usually an [Icon]; it inherits the button's foreground color.
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;

  /// When `false`, [leading] and [trailing] are pushed to the edges.
  final bool areIconsClose;

  /// Per-instance overrides on top of the ambient [GradientFillButtonTheme].
  final GradientFillButtonTheme? style;

  static const double _gap = 12;

  @override
  Widget build(BuildContext context) {
    final theme = GradientFillButtonTheme.of(context).merge(style);
    final enabled = onPressed != null && !isLoading;
    final foreground = enabled
        ? theme.foregroundColor!
        : theme.disabledForegroundColor!;
    final background = enabled
        ? theme.gradientStart!
        : theme.disabledBackgroundColor!;
    final borderRadius = BorderRadius.circular(theme.radius!);

    final label = Text(
      text,
      textAlign: TextAlign.center,
      style: theme.textStyle!.copyWith(color: foreground),
    );

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: background,
        disabledBackgroundColor: background,
        foregroundColor: foreground,
        disabledForegroundColor: foreground,
        elevation: enabled ? theme.elevation : 0,
        shadowColor: theme.gradientStart!.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: enabled
                ? [theme.gradientStart!, theme.gradientEnd!]
                : [background, background],
            transform: const GradientRotation(16.94 * math.pi / 180),
          ),
        ),
        child: Padding(
          padding: theme.padding!,
          child: IconTheme.merge(
            data: IconThemeData(color: foreground),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  _Spinner(color: foreground),
                  const SizedBox(width: _gap),
                ] else if (leading != null) ...[
                  leading!,
                  if (areIconsClose) const SizedBox(width: _gap),
                ],
                if (areIconsClose) label else Expanded(child: label),
                if (trailing != null) ...[
                  if (areIconsClose) const SizedBox(width: _gap),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 20,
    child: CircularProgressIndicator(strokeWidth: 2, color: color),
  );
}
