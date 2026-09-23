import 'package:flutter/material.dart';

import 'connection_banner_theme.dart';

/// {@template connection_banner}
/// A compact pill that reports the device's connectivity.
///
/// The widget does not observe connectivity itself: show it while offline and
/// set [isRestored] to `true` briefly once the connection comes back.
/// {@endtemplate}
class ConnectionBanner extends StatelessWidget {
  final bool isRestored;

  /// Shown while offline.
  final String offlineMessage;

  /// Shown when [isRestored] is `true`.
  final String restoredMessage;

  /// Per-instance overrides for [ConnectionBannerTheme].
  final ConnectionBannerTheme? style;

  /// {@macro connection_banner}
  const ConnectionBanner({
    super.key,
    this.isRestored = false,
    this.offlineMessage = 'No internet connection',
    this.restoredMessage = 'Back Online',
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ConnectionBannerTheme.of(context).merge(style);
    final color = (isRestored ? theme.restoredColor : theme.offlineColor)!;
    final icon = isRestored ? Icons.wifi_rounded : Icons.wifi_off_rounded;
    final message = isRestored ? restoredMessage : offlineMessage;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 16.0),
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: theme.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
