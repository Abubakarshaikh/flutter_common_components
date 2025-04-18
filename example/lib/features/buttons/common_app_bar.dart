import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final double borderHeight;
  final List<Widget>? actions;
  final void Function()? onPressed;

  const CommonAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.blue,
    this.borderHeight = 0.6,
    this.actions,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      leading: BackButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
          Navigator.pop(context);
        },
      ),
      backgroundColor: colorScheme.primary,
      title: Text(title),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(borderHeight),
        child: Container(
          height: borderHeight,
          color: borderColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}

class CustomBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final String? toolTip;
  final double? size;

  const CustomBackButton({
    super.key,
    this.color,
    this.onPressed,
    this.toolTip,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      icon: Icon(
        Icons
            .arrow_back_ios, // You can change to Icons.arrow_back for Material design
        color: color ?? colorScheme.onPrimary,
        size: size ?? 24.0,
      ),
      tooltip: toolTip ?? MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed ??
          () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
    );
  }
}
