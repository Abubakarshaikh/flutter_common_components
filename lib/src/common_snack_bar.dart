import 'package:flutter/material.dart';
import 'package:flutter_common_components/src/app_text.dart';

class CommonSnackBar extends StatelessWidget {
  final String? bodyText;
  final Color? backgroundColor;
  final Widget? content;
  final VoidCallback? onClose;
  final Duration? snackBarDisplayDuration;
  const CommonSnackBar({
    super.key,
    this.bodyText,
    this.backgroundColor,
    this.content,
    this.onClose,
    this.snackBarDisplayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 36,
        left: 18,
        right: 18,
      ),
      duration: snackBarDisplayDuration ?? const Duration(seconds: 5),
      content: Row(
        children: [
          Expanded(
            child: AppText.bodySmall(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              bodyText ?? "Tap and Hold to pause, resume\n or delete your Gig",
            ),
          ),
          InkWell(
            onTap: () {
              onClose;
              ScaffoldMessenger.of(context).clearSnackBars();
            },
            child: AppText.bodyMedium(
              "Got it",
              fontWeight: FontWeight.bold,
              color: Colors.green.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
