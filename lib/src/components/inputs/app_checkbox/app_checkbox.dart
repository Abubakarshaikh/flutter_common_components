import 'package:flutter/material.dart';

/// Thin wrapper around [Checkbox] for a single place to adjust behavior later.
///
/// **Colors:** Pass [fillColor], [activeColor], [checkColor], and [side] to match
/// each screen. When both [fillColor] and [activeColor] are null, fill uses the
/// theme (same as a raw [Checkbox]).
///
/// **Size:** Use [materialTapTargetSize], [visualDensity], and an outer
/// [SizedBox]/[Transform.scale] at the call site.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.mouseCursor,
    this.fillColor,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool tristate;
  final MouseCursor? mouseCursor;
  final WidgetStateProperty<Color?>? fillColor;

  /// Used only when [fillColor] is null. Applied when [WidgetState.selected].
  final Color? activeColor;

  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;

  /// Fills with [color] when checked and [disabledColor] when disabled.
  ///
  /// Unchecked (and disabled, when [disabledColor] is null) states fall back
  /// to the ambient [CheckboxTheme].
  static WidgetStateProperty<Color?> fillWhenChecked(
    Color color, {
    Color? disabledColor,
  }) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return disabledColor;
      if (states.contains(WidgetState.selected)) return color;
      return null;
    });
  }

  WidgetStateProperty<Color?>? _effectiveFillColor(BuildContext context) {
    if (fillColor != null) return fillColor;
    if (activeColor != null) {
      return fillWhenChecked(
        activeColor!,
        disabledColor: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.38),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      mouseCursor: mouseCursor,
      fillColor: _effectiveFillColor(context),
      checkColor: checkColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      overlayColor: overlayColor,
      splashRadius: splashRadius,
      materialTapTargetSize: materialTapTargetSize,
      visualDensity: visualDensity,
      focusNode: focusNode,
      autofocus: autofocus,
      shape: shape,
      side: side,
      tristate: tristate,
    );
  }
}
