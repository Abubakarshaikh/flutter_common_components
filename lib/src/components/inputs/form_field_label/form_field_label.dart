import 'package:flutter/material.dart';

/// A [label] above [child], optionally drawing a border around [child].
///
/// [textColor] defaults to `ColorScheme.primary` and [borderColor] to
/// `ColorScheme.outline`.
class FormFieldLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final Color? textColor;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;

  const FormFieldLabel({
    super.key,
    required this.label,
    required this.child,
    this.top = 0,
    this.bottom = 0,
    this.left = 12,
    this.right = 12,
    this.textColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottom,
        top: top,
        left: left,
        right: right,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: theme.textTheme.titleMedium?.copyWith(
              color: textColor ?? theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          showBorder
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor ?? theme.colorScheme.outline,
                      width: borderWidth,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(8),
                  ),
                  child: child,
                )
              : child,
        ],
      ),
    );
  }
}
