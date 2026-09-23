import 'package:flutter/material.dart';

/// [Radio] with consistent colors derived from the ambient [ColorScheme].
///
/// Takes [groupValue] and [onChanged] directly and wraps itself in a
/// [RadioGroup], so it works standalone. The radio is disabled when
/// [onChanged] is null.
class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.fillColor,
    this.overlayColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.toggleable = false,
    this.autofocus = false,
    this.selectedColor,
    this.unselectedColor,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final bool toggleable;
  final bool autofocus;

  /// When [fillColor] is null, used for the selected ring/dot.
  final Color? selectedColor;

  /// When [fillColor] is null, used for the unselected outline.
  final Color? unselectedColor;

  /// Primary when selected, translucent on-surface otherwise.
  static WidgetStateProperty<Color?> defaultFillColor(
    ColorScheme colorScheme, {
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurfaceVariant.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.selected)) {
        return selectedColor ?? colorScheme.primary;
      }
      return unselectedColor ?? colorScheme.onSurface.withValues(alpha: 0.45);
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveFill =
        fillColor ??
        defaultFillColor(
          Theme.of(context).colorScheme,
          selectedColor: selectedColor,
          unselectedColor: unselectedColor,
        );

    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: onChanged ?? (_) {},
      child: Radio<T>(
        value: value,
        enabled: onChanged != null,
        fillColor: effectiveFill,
        overlayColor: overlayColor,
        materialTapTargetSize: materialTapTargetSize,
        visualDensity: visualDensity,
        toggleable: toggleable,
        autofocus: autofocus,
      ),
    );
  }
}
