import 'package:flutter/material.dart';

/// Reusable empty-state placeholder for lists and screens with no data.
///
/// Shows an optional icon, a title, an optional description, and an optional
/// primary action button (rendered only when both [actionLabel] and
/// [onActionPressed] are set).
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.showIcon = true,
    this.actionLabel,
    this.onActionPressed,
    this.actionPrefix = Icons.add_rounded,
    this.padding,
  });

  final String title;
  final String? description;
  final IconData icon;
  final bool showIcon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final IconData actionPrefix;
  final EdgeInsetsGeometry? padding;

  bool get _hasAction =>
      actionLabel != null && actionLabel!.isNotEmpty && onActionPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48.0, color: scheme.primary),
              ),
              const SizedBox(height: 20.0),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            if (description != null && description!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
            if (_hasAction) ...[
              const SizedBox(height: 24.0),
              FilledButton.icon(
                onPressed: onActionPressed,
                icon: Icon(actionPrefix),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
