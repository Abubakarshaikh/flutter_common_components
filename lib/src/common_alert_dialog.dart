import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform dialog widget that adapts to iOS and Android platforms.
/// Provides multiple dialog variants with platform-specific styling.
/// Follows composition-over-inheritance principle with DialogStyle.

class CommonDialog {
  /// Show a basic dialog with a title, message, and actions
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    _showDialog(
      context: context,
      title: title,
      message: message,
      actions: actions,
      variant: DialogVariant.basic,
      style: style,
    );
  }

  /// Show a success-styled dialog
  static void success({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    _showDialog(
      context: context,
      title: title,
      message: message,
      actions: actions,
      variant: DialogVariant.success,
      style: style,
    );
  }

  /// Show an error-styled dialog
  static void error({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    _showDialog(
      context: context,
      title: title,
      message: message,
      actions: actions,
      variant: DialogVariant.error,
      style: style,
    );
  }

  /// Show a warning-styled dialog
  static void warning({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    _showDialog(
      context: context,
      title: title,
      message: message,
      actions: actions,
      variant: DialogVariant.warning,
      style: style,
    );
  }

  /// Show an info-styled dialog
  static void info({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    _showDialog(
      context: context,
      title: title,
      message: message,
      actions: actions,
      variant: DialogVariant.info,
      style: style,
    );
  }

  /// Helper method to show the dialog based on platform
  static void _showDialog({
    required BuildContext context,
    required String title,
    required String message,
    required DialogVariant variant,
    List<Widget>? actions,
    DialogStyle? style,
  }) {
    final effectiveStyle = _getEffectiveStyle(context, variant, style);

    if (Platform.isIOS) {
      _showCupertinoDialog(
        context: context,
        title: title,
        message: message,
        actions: actions,
        style: effectiveStyle,
      );
    } else {
      _showMaterialDialog(
        context: context,
        title: title,
        message: message,
        actions: actions,
        style: effectiveStyle,
      );
    }
  }

  /// Get the appropriate style based on variant and platform
  static DialogStyle _getEffectiveStyle(
    BuildContext context,
    DialogVariant variant,
    DialogStyle? customStyle,
  ) {
    // Default style based on variant
    DialogStyle defaultStyle;

    // Colors based on platform
    final successColor =
        Platform.isIOS ? CupertinoColors.systemGreen : Colors.green[700]!;

    final errorColor =
        Platform.isIOS ? CupertinoColors.systemRed : Colors.red[700]!;

    final warningColor =
        Platform.isIOS ? CupertinoColors.systemOrange : Colors.orange[700]!;

    final infoColor =
        Platform.isIOS ? CupertinoColors.systemBlue : Colors.blue[700]!;

    final neutralColor =
        Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey[800]!;

    // Platform-specific settings
    final textColor = Platform.isIOS ? CupertinoColors.label : Colors.black;

    final borderRadius = Platform.isIOS ? 14.0 : 4.0;

    switch (variant) {
      case DialogVariant.basic:
        defaultStyle = DialogStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
          titleColor: textColor,
          messageColor: textColor,
          borderRadius: borderRadius,
          icon: null,
        );
        break;

      case DialogVariant.success:
        defaultStyle = DialogStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
          titleColor: successColor,
          messageColor: textColor,
          borderRadius: borderRadius,
          icon: Icons.check_circle_outline,
          iconColor: successColor,
        );
        break;

      case DialogVariant.error:
        defaultStyle = DialogStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
          titleColor: errorColor,
          messageColor: textColor,
          borderRadius: borderRadius,
          icon: Icons.error_outline,
          iconColor: errorColor,
        );
        break;

      case DialogVariant.warning:
        defaultStyle = DialogStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
          titleColor: warningColor,
          messageColor: textColor,
          borderRadius: borderRadius,
          icon: Icons.warning_amber_outlined,
          iconColor: warningColor,
        );
        break;

      case DialogVariant.info:
        defaultStyle = DialogStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
          titleColor: infoColor,
          messageColor: textColor,
          borderRadius: borderRadius,
          icon: Icons.info_outline,
          iconColor: infoColor,
        );
        break;
    }

    // Apply custom style if provided
    return customStyle != null
        ? _mergeStyles(defaultStyle, customStyle)
        : defaultStyle;
  }

  /// Merge base style with override style
  static DialogStyle _mergeStyles(DialogStyle base, DialogStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      titleColor: override.titleColor,
      messageColor: override.messageColor,
      borderRadius: override.borderRadius,
      icon: override.icon,
      iconColor: override.iconColor,
    );
  }

  /// Show Material-style dialog (for Android)
  static void _showMaterialDialog({
    required BuildContext context,
    required String title,
    required String message,
    required DialogStyle style,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: style.titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: style.messageColor),
          ),
          actions: actions,
          backgroundColor: style.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
          ),
        );
      },
    );
  }

  /// Show Cupertino-style dialog (for iOS)
  static void _showCupertinoDialog({
    required BuildContext context,
    required String title,
    required String message,
    required DialogStyle style,
    List<Widget>? actions,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(color: style.titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: style.messageColor),
          ),
          actions: actions ?? [],
        );
      },
    );
  }
}

/// Dialog variants supported by CommonDialog
enum DialogVariant {
  /// Basic neutral dialog
  basic,

  /// Success-styled dialog (green)
  success,

  /// Error-styled dialog (red)
  error,

  /// Warning-styled dialog (orange/amber)
  warning,

  /// Info-styled dialog (blue)
  info,
}

/// Styling configuration for CommonDialog
class DialogStyle {
  /// Background color of the dialog
  final Color? backgroundColor;

  /// Color for dialog title
  final Color? titleColor;

  /// Color for dialog message
  final Color? messageColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Optional icon to display in the dialog
  final IconData? icon;

  /// Color for the icon
  final Color? iconColor;

  const DialogStyle({
    this.backgroundColor,
    this.titleColor,
    this.messageColor,
    this.borderRadius,
    this.icon,
    this.iconColor,
  });

  DialogStyle copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? messageColor,
    double? borderRadius,
    IconData? icon,
    Color? iconColor,
  }) {
    return DialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      messageColor: messageColor ?? this.messageColor,
      borderRadius: borderRadius ?? this.borderRadius,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
