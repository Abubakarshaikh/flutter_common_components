import 'package:flutter/material.dart';

/// Dismisses the currently focused keyboard.
void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

/// Wraps [child] so a tap outside the focused field hides the keyboard.
///
/// Use this around a [Scaffold] when tap-to-dismiss is wanted. Do not wrap
/// the scaffold when that behavior should stay off.
class KeyboardDismissWrapper extends StatelessWidget {
  const KeyboardDismissWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
