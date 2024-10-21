import 'package:flutter/material.dart';

extension ResponsiveLayout on num {
  double width(BuildContext context) {
    final num percentage = this;
    return (MediaQuery.of(context).size.width * percentage) / 100;
  }

  double height(BuildContext context) {
    return ((MediaQuery.of(context).size.height -
                (kBottomNavigationBarHeight + 0)) *
            this) /
        100;
  }

  double fontSize(BuildContext context) {
    if (MediaQuery.of(context).size.width > 540) {
      return MediaQuery.of(context).size.width * this * 0.01699;
    } else {
      return MediaQuery.of(context).size.width * this * 0.02;
    }
  }

  double paddingWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * this * 0.02;
  }

  double paddingHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * this * 0.02;
  }

  double marginWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * this * 0.02;
  }

  double marginHeight(BuildContext context) {
    return (MediaQuery.of(context).size.height -
            kBottomNavigationBarHeight +
            20) *
        this *
        0.02;
  }

  double radius(BuildContext context) {
    return MediaQuery.of(context).size.width * this * 0.01;
  }
}

extension Intx on int {}

extension type Wrapper(int i) {}
