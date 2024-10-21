import 'package:flutter_common_components/src/app_text.dart';
import 'package:flutter_common_components/src/const_sized_box.dart';
import 'package:flutter_common_components/src/base/extensions/buildcontext/theme_extension.dart';
import 'package:flutter_common_components/src/utils/icons_utils.dart';
import 'package:flutter_common_components/src/utils/radius_utils.dart';
import 'package:flutter/material.dart';

class CommonInputChip extends StatelessWidget {
  const CommonInputChip({
    super.key,
    this.onPressed,
    this.number = 0,
    this.isSelected = false,
    this.onDeletePressed,
    this.name = 'Category',
  });
  final void Function()? onPressed;
  final int number;
  final bool isSelected;
  final void Function()? onDeletePressed;
  final String name;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColorInActive = context.colorScheme.outline;
    final Color forgroundColorInActive = context.colorScheme.onSurface;

    final Color backgroundColorActive = context.colorScheme.primary;
    final Color forgroundColorActive = context.colorScheme.onPrimary;
    return Align(
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: context.textTheme.bodySmall,
          minimumSize: const Size(
            double.minPositive,
            30,
          ),
          padding: const EdgeInsets.fromLTRB(
            6,
            0,
            6,
            0,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              RadiusUtils.k6Radius,
            ),
          ),
          backgroundColor:
              isSelected ? backgroundColorActive : backgroundColorInActive,
          foregroundColor:
              isSelected ? forgroundColorActive : forgroundColorInActive,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppText.labelSmall(
              name,
              color: isSelected ? forgroundColorActive : forgroundColorInActive,
            ),
            ConstSizedBox.kWidth6,
            if (isSelected) ...<Widget>[
              AppText.labelSmall(
                number > 9 ? '+10' : '$number',
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? forgroundColorActive : forgroundColorInActive,
              ),
              ConstSizedBox.kWidth4,
              Padding(
                padding: const EdgeInsets.only(
                  top: 2.6,
                ),
                child: GestureDetector(
                  onTap: onDeletePressed,
                  child: Icon(
                    IconUtils.close,
                    size: 18,
                    color: forgroundColorInActive,
                  ),
                ),
              ),
            ] else
              const Padding(
                padding: EdgeInsets.only(
                  top: 2.6,
                ),
                child: Icon(
                  IconUtils.keyboardArrowDownRounded,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
