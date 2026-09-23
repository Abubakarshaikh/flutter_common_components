import 'package:flutter/material.dart';

/// A checkbox with an optional [title], [subtitle] and [leading] widget.
///
/// Renders a bare [Checkbox] when neither [title] nor [subtitle] is given;
/// otherwise the whole row is tappable and toggles [value].
class CommonCheckbox extends StatelessWidget {
  // ============================================================================
  // VARIABLES
  // ============================================================================
  final bool value;
  final void Function(bool?)? onChanged;
  final String? title;
  final String? subtitle;
  final Widget? leading;

  /// Fill when checked. Defaults to [ColorScheme.primary].
  final Color? activeColor;
  final Color? checkColor;

  /// Defaults to [ColorScheme.outline].
  final Color? borderColor;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final FontWeight? titleFontWeight;

  /// Defaults to [ColorScheme.onSurface].
  final Color? titleColor;

  /// Defaults to [ColorScheme.onSurface] at 70% opacity.
  final Color? subtitleColor;
  final EdgeInsetsGeometry? contentPadding;

  // ============================================================================
  // CONSTRUCTOR
  // ============================================================================
  const CommonCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.title,
    this.subtitle,
    this.leading,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleFontWeight,
    this.titleColor,
    this.subtitleColor,
    this.contentPadding,
  });

  // ============================================================================
  // UI HELPER METHODS
  // ============================================================================
  Widget _buildCheckbox(ColorScheme scheme) {
    final fill = activeColor ?? scheme.primary;
    return Checkbox(
      value: value,
      onChanged: onChanged,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurfaceVariant.withValues(alpha: 0.38);
        }
        if (states.contains(WidgetState.selected)) return fill;
        return null;
      }),
      checkColor: checkColor,
      side: BorderSide(color: borderColor ?? scheme.outline),
    );
  }

  Widget _buildTitleAndSubtitle(ThemeData theme) {
    final scheme = theme.colorScheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: titleFontSize,
                fontWeight: titleFontWeight ?? FontWeight.w500,
                color: titleColor ?? scheme.onSurface,
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: subtitleFontSize,
                color:
                    subtitleColor ?? scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckboxListTile(ThemeData theme) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            _buildCheckbox(theme.colorScheme),
            const SizedBox(width: 8),
            _buildTitleAndSubtitle(theme),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (title == null && subtitle == null) {
      return _buildCheckbox(theme.colorScheme);
    }

    return _buildCheckboxListTile(theme);
  }
}
