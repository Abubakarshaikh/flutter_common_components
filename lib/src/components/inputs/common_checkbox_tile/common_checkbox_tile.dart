import 'package:flutter/material.dart';

/// A compact checkbox followed by a label.
///
/// The label is [title] when given, otherwise [text] styled with
/// [TextTheme.titleSmall].
class CommonCheckboxTile extends StatelessWidget {
  final Widget? suffix;
  final Widget? prefix;
  final Widget? title;
  final bool value;
  final String? text;

  /// Checkbox outline color. Defaults to [ColorScheme.onSurface].
  final Color? borderColor;
  final void Function(bool?)? onChanged;
  final bool isExpanded;

  const CommonCheckboxTile({
    super.key,
    this.suffix,
    this.prefix,
    this.title,
    this.value = false,
    this.text,
    this.borderColor,
    this.onChanged,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget label =
        title ??
        Text(
          text ?? '',
          textAlign: TextAlign.start,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        SizedBox(
          width: 21,
          height: 21,
          child: Transform.scale(
            scale: 0.8,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              side: BorderSide(
                color: borderColor ?? theme.colorScheme.onSurface,
              ),
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
        if (isExpanded)
          Expanded(child: label)
        else
          Flexible(fit: FlexFit.loose, child: label),
        if (suffix != null) suffix!,
      ],
    );
  }
}
