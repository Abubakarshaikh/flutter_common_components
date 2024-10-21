import 'package:flutter_common_components/src/base_text.dart';
import 'package:flutter/foundation.dart' show VoidCallback, immutable;

@immutable
class LinkText extends BaseText {
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
  final VoidCallback onTapped;
}
