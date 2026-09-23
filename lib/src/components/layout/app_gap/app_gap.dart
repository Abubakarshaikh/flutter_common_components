import 'package:flutter/material.dart';

/// Fixed layout spacing — use instead of raw [SizedBox] for gaps so spacing
/// stays consistent and call sites read clearly.
///
/// Examples:
/// * `const AppGap.vertical(16)` replaces `const SizedBox(height: 16)`
/// * `const AppGap.horizontal(8)` replaces `const SizedBox(width: 8)`
/// * `AppGap(width: 24, height: 12)` mirrors [SizedBox] when both axes matter
class AppGap extends StatelessWidget {
  const AppGap({super.key, this.width, this.height, this.child});

  /// Vertical gap ([height] logical pixels; width is unconstrained).
  const AppGap.vertical(double this.height, {super.key})
    : width = null,
      child = null;

  /// Horizontal gap ([width] logical pixels; height is unconstrained).
  const AppGap.horizontal(double this.width, {super.key})
    : height = null,
      child = null;

  /// Square gap (same [size] on both axes).
  const AppGap.square(double size, {super.key})
    : width = size,
      height = size,
      child = null;

  final double? width;
  final double? height;
  final Widget? child;

  /// Same as [SizedBox.shrink].
  static const Widget shrink = SizedBox.shrink();

  /// Same as [SizedBox.expand].
  static Widget expand({Key? key, Widget? child}) =>
      SizedBox.expand(key: key, child: child);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: child);
  }
}
