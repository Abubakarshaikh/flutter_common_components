import 'package:flutter_common_components/src/base/extensions/buildcontext/theme_extension.dart';
import 'package:flutter_common_components/src/utils/icons_utils.dart';
import 'package:flutter/material.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        IconUtils.checkCircleOutlineRounded,
        color: context.colorScheme.primary,
        size: 46,
      ),
      title: const Text(
        'Profile Updated Successfully',
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'OK',
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
