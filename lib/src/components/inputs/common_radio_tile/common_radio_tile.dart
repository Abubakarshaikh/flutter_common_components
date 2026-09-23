import 'package:flutter/material.dart';

/// A [Radio] followed by a bold [text] label.
///
/// Selected when [value] equals [groupValue]; disabled when [onChanged] is
/// null.
class CommonRadioTile extends StatelessWidget {
  final Widget? suffix;
  final Widget? prefix;
  final Widget? title;
  final String value;
  final String groupValue;
  final String text;

  /// Radio color in every state. Defaults to [ColorScheme.onSurface].
  final Color? borderColor;
  final void Function(String?)? onChanged;

  const CommonRadioTile({
    super.key,
    this.suffix,
    this.prefix,
    this.title,
    required this.value,
    required this.groupValue,
    required this.text,
    this.borderColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        RadioGroup<String>(
          groupValue: groupValue,
          onChanged: onChanged ?? (_) {},
          child: Radio<String>(
            value: value,
            enabled: onChanged != null,
            fillColor: WidgetStateProperty.all(
              borderColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          text,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
