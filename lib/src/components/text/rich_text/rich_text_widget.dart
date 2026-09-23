import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A span of text for [RichTextWidget]; use [BaseText.link] for tappable text.
@immutable
class BaseText {
  const BaseText({required this.text, this.style});

  const factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style,
  }) = LinkText;

  final String text;
  final TextStyle? style;
}

@immutable
class LinkText extends BaseText {
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  });

  final VoidCallback onTapped;
}

class RichTextWidget extends StatefulWidget {
  const RichTextWidget({required this.texts, this.styleForAll, super.key});

  final Iterable<BaseText> texts;

  /// Base style merged under every span's own style.
  final TextStyle? styleForAll;

  @override
  State<RichTextWidget> createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final spans = <TextSpan>[];
    for (final span in widget.texts) {
      TapGestureRecognizer? recognizer;
      if (span is LinkText) {
        recognizer = TapGestureRecognizer()..onTap = span.onTapped;
        _recognizers.add(recognizer);
      }
      spans.add(
        TextSpan(text: span.text, style: span.style, recognizer: recognizer),
      );
    }

    return RichText(
      text: TextSpan(
        style: widget.styleForAll ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
