import 'package:flutter/material.dart';

/// Sizes [child] as a fraction of the screen size.
///
/// [widthFactor] and [heightFactor] are between `0.0` and `1.0`; when a factor
/// is null that axis takes whatever size the child needs.
class AppResponsiveSizeBox extends StatelessWidget {
  final double? widthFactor;
  final double? heightFactor;
  final Widget child;
  final AlignmentGeometry? alignment;

  const AppResponsiveSizeBox({
    super.key,
    this.widthFactor,
    this.heightFactor,
    this.alignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Container(
      alignment: alignment,
      width: widthFactor != null ? screenSize.width * widthFactor! : null,
      height: heightFactor != null ? screenSize.height * heightFactor! : null,
      child: child,
    );
  }
}
