import 'package:flutter/material.dart';

/// Suffix control that clears the field when [controller] has text.
///
/// Hidden while [controller] is empty. Pass [whenEmpty] to show a different
/// suffix (for example a calendar icon) in that state.
///
/// Pass this as [AppTextField.suffixIcon]. Clear the controller in
/// [onCleared] — this widget does not own that controller.
class TextFieldClearButton extends StatelessWidget {
  const TextFieldClearButton({
    super.key,
    required this.controller,
    required this.onCleared,
    this.whenEmpty,
    this.color,
  });

  final TextEditingController controller;
  final VoidCallback onCleared;

  /// Shown instead of the clear icon while [controller] is empty.
  final Widget? whenEmpty;

  /// Clear icon color. Defaults to `ColorScheme.primary`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.text.isEmpty) {
          return whenEmpty ?? const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: onCleared,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.close_rounded,
              size: 20,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
