// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListViewSeparated extends StatelessWidget {
  const ListViewSeparated({
    required this.itemBuilder,
    required this.itemCount,
    super.key,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.separatedHeight,
    this.separatedWidth,
    this.isBottomPadding = false,
    this.isExpanded = false,
    this.reverse = false,
    this.padding,
  });

  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController? scrollController;
  final int itemCount;
  final Axis scrollDirection;
  final double? separatedHeight;
  final double? separatedWidth;
  final bool isBottomPadding;
  final bool isExpanded;
  final bool reverse;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(
        child: ListView.separated(
          reverse: reverse,
          key: const PageStorageKey<String>('page'),
          controller: scrollController,
          scrollDirection: scrollDirection,
          padding: padding ??
              EdgeInsets.fromLTRB(12, 0, 12, isBottomPadding ? 72 : 0),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          separatorBuilder: (BuildContext context, int index) {
            if (separatedHeight != null) {
              return SizedBox(
                height: separatedHeight,
              );
            } else {
              return SizedBox(
                width: separatedWidth,
              );
            }
          },
        ),
      );
    } else {
      return ListView.separated(
        key: const PageStorageKey<String>('page'),
        reverse: reverse,
        controller: scrollController,
        scrollDirection: scrollDirection,
        padding:
            padding ?? EdgeInsets.fromLTRB(12, 0, 12, isBottomPadding ? 48 : 0),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        separatorBuilder: (BuildContext context, int index) {
          if (separatedHeight != null) {
            return SizedBox(
              height: separatedHeight,
            );
          } else {
            return SizedBox(
              width: separatedWidth,
            );
          }
        },
      );
    }
  }
}
