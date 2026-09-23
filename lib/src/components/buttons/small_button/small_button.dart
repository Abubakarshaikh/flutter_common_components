import 'package:flutter/material.dart';

import 'small_button_theme.dart';

enum SmallButtonType { filled, outline, icon }

/// A circular icon-only button.
///
/// Disabled when [onPressed] is `null`; shows a spinner when [isLoading].
class SmallButton extends StatelessWidget {
  const SmallButton({
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.type = SmallButtonType.outline,
    this.isLoading = false,
    this.style,
    super.key,
  });

  final VoidCallback? onPressed;

  /// Usually an [Icon]; it inherits the button's icon color and size.
  final Widget icon;
  final String? tooltip;
  final SmallButtonType type;
  final bool isLoading;

  /// Per-instance overrides on top of the ambient [SmallButtonTheme].
  final SmallButtonTheme? style;

  @override
  Widget build(BuildContext context) {
    final theme = SmallButtonTheme.of(context).merge(style);
    final enabled = onPressed != null && !isLoading;
    final dimension = Size.square(theme.size!);
    final iconColor = !enabled
        ? theme.disabledColor!
        : type == SmallButtonType.filled
        ? theme.onFilledColor!
        : theme.foregroundColor!;

    final content = isLoading
        ? SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.foregroundColor,
            ),
          )
        : IconTheme.merge(
            data: IconThemeData(color: iconColor, size: theme.iconSize),
            child: icon,
          );

    final Widget button = switch (type) {
      SmallButtonType.filled => ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          fixedSize: dimension,
          shape: const CircleBorder(),
          backgroundColor: theme.gradientStart,
          disabledBackgroundColor: theme.disabledColor!.withValues(alpha: 0.12),
        ),
        child: Ink(
          width: dimension.width,
          height: dimension.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: enabled
                ? LinearGradient(
                    colors: [theme.gradientStart!, theme.gradientEnd!],
                  )
                : null,
          ),
          child: Center(child: content),
        ),
      ),
      SmallButtonType.outline => OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          fixedSize: dimension,
          shape: const CircleBorder(),
          side: BorderSide(
            width: theme.borderWidth!,
            color: enabled ? theme.borderColor! : theme.disabledColor!,
          ),
        ),
        child: content,
      ),
      SmallButtonType.icon => IconButton(
        onPressed: enabled ? onPressed : null,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          fixedSize: dimension,
          shape: const CircleBorder(),
        ),
        icon: content,
      ),
    };

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
