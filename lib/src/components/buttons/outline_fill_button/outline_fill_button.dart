import 'package:flutter/material.dart';

import 'outline_fill_button_theme.dart';

/// A surface-filled button with a thick outline.
///
/// Disabled when [onPressed] is `null`; shows a spinner when [isLoading].
class OutlineFillButton extends StatelessWidget {
  const OutlineFillButton({
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

  /// Per-instance overrides on top of the ambient [OutlineFillButtonTheme].
  final OutlineFillButtonTheme? style;

  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    final theme = OutlineFillButtonTheme.of(context).merge(style);
    final enabled = onPressed != null && !isLoading;
    final foreground = enabled
        ? theme.foregroundColor!
        : theme.disabledForegroundColor!;

    final label = Text(
      text,
      textAlign: TextAlign.center,
      style: theme.textStyle!.copyWith(color: foreground, letterSpacing: 0),
    );

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: theme.padding,
        backgroundColor: theme.backgroundColor,
        disabledBackgroundColor: theme.backgroundColor,
        foregroundColor: theme.foregroundColor,
        disabledForegroundColor: foreground,
        elevation: theme.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.radius!),
          side: BorderSide(
            color: theme.borderColor!,
            width: theme.borderWidth!,
          ),
        ),
      ),
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
