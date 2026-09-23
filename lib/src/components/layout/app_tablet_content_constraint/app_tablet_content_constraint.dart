import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Constrains [child] to a centered column on tablet-class layouts
/// (including large iPads, which width rules can report as desktop).
///
/// On phones and real desktops [child] is returned unchanged.
class AppTabletContentConstraint extends StatelessWidget {
  const AppTabletContentConstraint({
    required this.child,
    this.color,
    this.maxWidth = 720.0,
    this.landscapeMaxWidth = 960.0,
    super.key,
  });

  final Widget child;

  /// Fills the space beside the centered column. Defaults to
  /// [ColorScheme.surface].
  final Color? color;

  /// Content width limit on tablets in portrait.
  final double maxWidth;

  /// Content width limit on tablets in landscape.
  final double landscapeMaxWidth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (!_isTabletFormFactor(size)) {
      return child;
    }

    final effectiveMaxWidth = size.width > size.height
        ? landscapeMaxWidth
        : maxWidth;

    return ColoredBox(
      color: color ?? Theme.of(context).colorScheme.surface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: effectiveMaxWidth,
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

const double _kDesktopBreakpoint = 950;
const double _kTabletBreakpoint = 600;

/// Handheld tablets whose shortest side is at or below this (e.g. large iPads)
/// are still treated as tablets even when classified as desktop.
const double _kTabletFormFactorMaxShortestSide = 1024;

/// Width used to classify layout: full width on web / desktop OS targets,
/// shortest side on handhelds.
double _classificationWidth(Size size) {
  if (kIsWeb) return size.width;
  switch (defaultTargetPlatform) {
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    case TargetPlatform.linux:
      return size.width;
    default:
      return size.shortestSide;
  }
}

bool _isTabletFormFactor(Size size) {
  final width = _classificationWidth(size);
  if (width >= _kDesktopBreakpoint) {
    return size.shortestSide <= _kTabletFormFactorMaxShortestSide;
  }
  return width >= _kTabletBreakpoint;
}
