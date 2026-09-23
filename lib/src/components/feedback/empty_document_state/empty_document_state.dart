import 'package:flutter/material.dart';

/// Centered empty-state visual used when a screen has no documents yet,
/// with a required create action.
///
/// Renders the same layout as `AppEmptyState`; prefer that widget when the
/// action is optional.
class EmptyDocumentState extends StatelessWidget {
  const EmptyDocumentState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onCreatePressed,
    this.buttonPrefix = Icons.add_rounded,
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onCreatePressed;
  final IconData buttonPrefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48.0, color: scheme.primary),
            ),
            const SizedBox(height: 20.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
            if (buttonText.isNotEmpty) ...[
              const SizedBox(height: 24.0),
              FilledButton.icon(
                onPressed: onCreatePressed,
                icon: Icon(buttonPrefix),
                label: Text(buttonText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
