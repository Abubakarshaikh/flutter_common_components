import 'package:flutter/material.dart';

/// Calls [onFocusLost] when [child] loses focus after it had focus.
///
/// Wrap a text field (or any focusable child) when the value should
/// be committed on unfocus. Does not fire on first build.
class SubmitOnFocusLost extends StatefulWidget {
  const SubmitOnFocusLost({
    super.key,
    required this.onFocusLost,
    required this.child,
  });

  final VoidCallback onFocusLost;
  final Widget child;

  @override
  State<SubmitOnFocusLost> createState() => _SubmitOnFocusLostState();
}

class _SubmitOnFocusLostState extends State<SubmitOnFocusLost> {
  bool _hadFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      onFocusChange: (hasFocus) {
        if (_hadFocus && !hasFocus) {
          widget.onFocusLost();
        }
        _hadFocus = hasFocus;
      },
      child: widget.child,
    );
  }
}
