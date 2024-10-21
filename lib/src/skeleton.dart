import 'package:flutter_common_components/src/base/extensions/buildcontext/theme_extension.dart';
import 'package:flutter_common_components/src/utils/radius_utils.dart';
import 'package:flutter/widgets.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.margin,
    this.height,
    this.width,
  });
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: context.colorScheme.outline,
        borderRadius: const BorderRadius.all(
          RadiusUtils.k2Radius,
        ),
      ),
    );
  }
}
