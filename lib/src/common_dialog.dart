import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform dialog widget that adapts to iOS and Android platforms.
/// Provides a flexible and reusable API for showing dialogs with custom content,
/// including form inputs, dropdowns, buttons, and more.
class CommonDialog {
  /// Show a generic dialog with custom content
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    List<Widget>? actions,
    DialogStyle? style,
    bool barrierDismissible = true,
    bool useSafeArea = true,
  }) {
    return _showDialog<T>(
      context: context,
      content: content,
      title: title,
      actions: actions,
      style: style,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    );
  }

  /// Show a form dialog with custom form content
  static Future<T?> showForm<T>({
    required BuildContext context,
    required Widget formContent,
    String? title,
    VoidCallback? onCancel,
    void Function()? onSubmit,
    String cancelText = 'Cancel',
    String submitText = 'Submit',
    DialogStyle? style,
    bool barrierDismissible = true,
  }) {
    final actions = <Widget>[
      // Cancel button
      if (Platform.isIOS)
        CupertinoDialogAction(
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            }
            Navigator.of(context).pop();
          },
          isDestructiveAction: true,
          child: Text(cancelText),
        )
      else
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            }
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),

      // Submit button
      if (Platform.isIOS)
        CupertinoDialogAction(
          onPressed: () {
            if (onSubmit != null) {
              onSubmit();
            } else {
              Navigator.of(context).pop();
            }
          },
          isDefaultAction: true,
          child: Text(submitText),
        )
      else
        TextButton(
          onPressed: () {
            if (onSubmit != null) {
              onSubmit();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(submitText),
        ),
    ];

    return _showDialog<T>(
      context: context,
      content: formContent,
      title: title,
      actions: actions,
      style: style,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Helper method to show the dialog based on platform
  static Future<T?> _showDialog<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    List<Widget>? actions,
    DialogStyle? style,
    bool barrierDismissible = true,
    bool useSafeArea = true,
  }) {
    final effectiveStyle = _getEffectiveStyle(context, style);

    if (Platform.isIOS) {
      return _showCupertinoDialog<T>(
        context: context,
        content: content,
        title: title,
        actions: actions,
        style: effectiveStyle,
        barrierDismissible: barrierDismissible,
      );
    } else {
      return _showMaterialDialog<T>(
        context: context,
        content: content,
        title: title,
        actions: actions,
        style: effectiveStyle,
        barrierDismissible: barrierDismissible,
        useSafeArea: useSafeArea,
      );
    }
  }

  /// Get the appropriate style based on platform
  static DialogStyle _getEffectiveStyle(
    BuildContext context,
    DialogStyle? customStyle,
  ) {
    // Default style
    final defaultStyle = DialogStyle(
      backgroundColor:
          Platform.isIOS ? CupertinoColors.systemBackground : Colors.white,
      borderRadius: Platform.isIOS ? 14.0 : 4.0,
      elevation: Platform.isIOS ? 0.0 : 24.0,
      titleTextStyle: Platform.isIOS
          ? const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            )
          : Theme.of(context).textTheme.titleLarge,
      contentPadding: Platform.isIOS
          ? const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 24.0)
          : const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      contentTextStyle: Platform.isIOS
          ? const TextStyle(fontSize: 14.0)
          : Theme.of(context).textTheme.bodyMedium,
      maxWidth: 450.0,
    );

    // Apply custom style if provided
    return customStyle != null
        ? _mergeStyles(defaultStyle, customStyle)
        : defaultStyle;
  }

  /// Merge base style with override style
  static DialogStyle _mergeStyles(DialogStyle base, DialogStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      borderRadius: override.borderRadius,
      elevation: override.elevation,
      titleTextStyle: override.titleTextStyle,
      contentPadding: override.contentPadding,
      contentTextStyle: override.contentTextStyle,
      maxWidth: override.maxWidth,
    );
  }

  /// Show Material-style dialog (for Android)
  static Future<T?> _showMaterialDialog<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    List<Widget>? actions,
    required DialogStyle style,
    bool barrierDismissible = true,
    bool useSafeArea = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
          ),
          elevation: style.elevation,
          backgroundColor: style.backgroundColor,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: style.maxWidth ?? 450.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                    child: Text(
                      title,
                      style: style.titleTextStyle,
                    ),
                  ),
                Padding(
                  padding: style.contentPadding ??
                      const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
                  child: content,
                ),
                if (actions != null && actions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show Cupertino-style dialog (for iOS)
  static Future<T?> _showCupertinoDialog<T>({
    required BuildContext context,
    required Widget content,
    String? title,
    List<Widget>? actions,
    required DialogStyle style,
    bool barrierDismissible = true,
  }) {
    Widget dialog = CupertinoAlertDialog(
      title: title != null ? Text(title, style: style.titleTextStyle) : null,
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: content,
      ),
      actions: actions ?? [],
    );

    // If barrierDismissible is true, use CupertinoModalPopup instead
    if (barrierDismissible) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) => dialog,
      );
    } else {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => dialog,
      );
    }
  }
}

/// Styling configuration for CommonDialog
class DialogStyle {
  /// Background color of the dialog
  final Color? backgroundColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Elevation shadow for Material dialogs
  final double? elevation;

  /// Text style for the dialog title
  final TextStyle? titleTextStyle;

  /// Padding inside the dialog content area
  final EdgeInsets? contentPadding;

  /// Text style for the dialog content
  final TextStyle? contentTextStyle;

  /// Maximum width for the dialog
  final double? maxWidth;

  const DialogStyle({
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.titleTextStyle,
    this.contentPadding,
    this.contentTextStyle,
    this.maxWidth,
  });

  DialogStyle copyWith({
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
    TextStyle? titleTextStyle,
    EdgeInsets? contentPadding,
    TextStyle? contentTextStyle,
    double? maxWidth,
  }) {
    return DialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      maxWidth: maxWidth ?? this.maxWidth,
    );
  }
}
