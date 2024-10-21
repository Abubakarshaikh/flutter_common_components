import 'package:flutter_common_components/src/link_text.dart';
import 'package:flutter/foundation.dart' show VoidCallback, immutable;
import 'package:flutter/material.dart' show Colors, TextDecoration, TextStyle;

@immutable
class BaseText {
  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        style: style,
      );
  final String text;
  final TextStyle? style;
}
