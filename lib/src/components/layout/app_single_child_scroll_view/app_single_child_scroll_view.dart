import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Screens narrower than this use the mobile bottom inset.
const double _kMobileMaxWidth = 600;

/// A [SingleChildScrollView] with screen-level default padding.
///
/// When [padding] is null the content is inset 16 horizontally, 8 at the top,
/// and leaves room at the bottom for a floating bottom navigation bar
/// (2.5× [kBottomNavigationBarHeight] on phones, 3× on wider screens).
class AppSingleChildScrollView extends StatelessWidget {
  final Widget? child;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool primary;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final String? restorationId;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const AppSingleChildScrollView({
    super.key,
    this.child,
    this.controller,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.primary = false,
    this.reverse = false,
    this.padding,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < _kMobileMaxWidth;

    return SingleChildScrollView(
      controller: controller,
      physics: physics,
      scrollDirection: scrollDirection,
      primary: primary,
      reverse: reverse,
      padding:
          padding ??
          EdgeInsets.fromLTRB(
            16.0,
            8.0,
            16.0,
            isMobile
                ? kBottomNavigationBarHeight * 2.5
                : kBottomNavigationBarHeight * 3,
          ),
      clipBehavior: clipBehavior,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      child: child,
    );
  }
}
