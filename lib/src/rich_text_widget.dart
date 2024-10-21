import 'package:flutter_common_components/src/base_text.dart';
import 'package:flutter_common_components/src/link_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    required this.texts,
    super.key,
    this.styleForAll,
  });
  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (BaseText baseText) {
            if (baseText is LinkText) {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    baseText.onTapped();
                  },
              );
            } else {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}
