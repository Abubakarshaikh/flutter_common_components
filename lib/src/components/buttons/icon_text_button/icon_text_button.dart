import 'package:flutter/material.dart';

import 'icon_text_button_theme.dart';

enum IconTextButtonAppearance { regular, appBar }

/// A text button with an optional leading icon.
///
/// Disabled when [onPressed] is `null`; shows a spinner when [isLoading].
class IconTextButton extends StatelessWidget {
  const IconTextButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.appearance = IconTextButtonAppearance.regular,
    this.splashEffectEnabled = false,
    this.style,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  /// Usually an [Icon]; it inherits the button's foreground color.
  final Widget? icon;
  final bool isLoading;
  final IconTextButtonAppearance appearance;
  final bool splashEffectEnabled;

  /// Per-instance overrides on top of the ambient [IconTextButtonTheme].
  final IconTextButtonTheme? style;

  @override
  Widget build(BuildContext context) {
    final theme = IconTextButtonTheme.of(context).merge(style);
    final enabled = onPressed != null && !isLoading;
    final foreground = enabled
        ? theme.foregroundColor!
        : theme.disabledForegroundColor!;
    final isAppBar = appearance == IconTextButtonAppearance.appBar;

    final button = TextButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        splashFactory: splashEffectEnabled ? null : NoSplash.splashFactory,
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.pressed)
              ? theme.pressedBackgroundColor
              : theme.backgroundColor,
        ),
      ),
      child: isLoading
          ? SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foreground,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: theme.horizontalPadding!,
              ),
              child: IconTheme.merge(
                data: IconThemeData(color: foreground),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      SizedBox(width: theme.iconSpacing),
                    ],
                    Text(
                      text,
                      textAlign: isAppBar ? TextAlign.right : TextAlign.center,
                      style: theme.textStyle!.copyWith(color: foreground),
                    ),
                  ],
                ),
              ),
            ),
    );

    if (!isAppBar) return button;
    return Padding(
      padding: EdgeInsetsDirectional.only(end: theme.appBarEndPadding!),
      child: button,
    );
  }
}
