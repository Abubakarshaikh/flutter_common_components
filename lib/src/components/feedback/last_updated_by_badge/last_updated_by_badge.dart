import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A badge that displays a "last updated by" line.
///
/// Shows a subtle clock icon + formatted timestamp + editor name.
/// Renders nothing when [text] is null or empty.
///
/// Usage:
/// ```dart
/// LastUpdatedByBadge(text: '3rd March 2026 09:45:12 by Jane')
/// LastUpdatedByBadge.fromDate(document.updatedAt, name: document.editorName)
/// ```
class LastUpdatedByBadge extends StatelessWidget {
  /// The pre-formatted text. When null the widget renders a zero-sized
  /// SizedBox.
  final String? text;

  /// Override the leading icon (defaults to [Icons.update_rounded]).
  final IconData icon;

  /// Optional custom margin for the badge container.
  /// When null, the original default spacing is used.
  final EdgeInsetsGeometry? margin;

  const LastUpdatedByBadge({
    super.key,
    required this.text,
    this.icon = Icons.update_rounded,
    this.margin,
  });

  /// Formats [dateTime] as `3rd March 2026 09:45:12 by Name`.
  ///
  /// The time is omitted when [showTime] is false and the ` by Name` suffix
  /// when [name] is null or empty. Renders nothing when [dateTime] is null.
  LastUpdatedByBadge.fromDate(
    DateTime? dateTime, {
    super.key,
    String? name,
    bool showTime = true,
    this.icon = Icons.update_rounded,
    this.margin,
  }) : text = dateTime == null
           ? null
           : formatLastUpdatedBy(dateTime, name: name, showTime: showTime);

  /// The formatting used by [LastUpdatedByBadge.fromDate].
  static String formatLastUpdatedBy(
    DateTime dateTime, {
    String? name,
    bool showTime = true,
  }) {
    final time = showTime ? ' ${DateFormat('HH:mm:ss').format(dateTime)}' : '';
    final month = DateFormat('MMMM').format(dateTime);
    final result =
        '${_dayWithSuffix(dateTime.day)} $month ${dateTime.year}$time';
    return (name != null && name.isNotEmpty) ? '$result by $name' : result;
  }

  static String _dayWithSuffix(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    return switch (day % 10) {
      1 => '${day}st',
      2 => '${day}nd',
      3 => '${day}rd',
      _ => '${day}th',
    };
  }

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isTablet = _isTabletFormFactor(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 6.0,
            ),
            margin: margin ?? const EdgeInsets.only(top: 6.0, bottom: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: scheme.primary.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: isTablet ? 17 : 13,
                  color: scheme.primary.withValues(alpha: 0.75),
                ),
                const SizedBox(width: 6.0),
                Flexible(
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Tablet-sized layout: handheld shortest side (or desktop/web width) of at
/// least 600, excluding desktop-sized screens with a shortest side over 1024.
bool _isTabletFormFactor(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final usesWidth =
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux;
  final width = usesWidth ? size.width : size.shortestSide;
  if (width < 600) return false;
  if (width < 950) return true;
  return size.shortestSide <= 1024;
}
