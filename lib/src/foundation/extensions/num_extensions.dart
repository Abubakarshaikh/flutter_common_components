import 'package:flutter/material.dart';

/// Sizes relative to the screen, e.g. `50.width(context)` is 50% of the width.
extension ResponsiveNumX on num {
  double width(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this / 100;

  double height(BuildContext context) =>
      (MediaQuery.sizeOf(context).height - kBottomNavigationBarHeight) *
      this /
      100;

  double fontSize(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return screenWidth * this * (screenWidth > 540 ? 0.01699 : 0.02);
  }

  double paddingWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this * 0.02;

  double paddingHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height * this * 0.02;

  double marginWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this * 0.02;

  double marginHeight(BuildContext context) =>
      (MediaQuery.sizeOf(context).height - kBottomNavigationBarHeight + 20) *
      this *
      0.02;

  double radius(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this * 0.01;
}
