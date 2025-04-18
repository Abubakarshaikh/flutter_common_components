import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

/// A cross-platform modal bottom sheet widget that adapts to iOS and Android platforms.
/// Provides a flexible and reusable API for showing modal sheets with custom content.
/// Follows composition-over-inheritance principle with ModalSheetStyle.

class CommonModalSheet {
  /// Show a generic modal bottom sheet with custom content
  static void show({
    required BuildContext context,
    required Widget content,
    ModalSheetStyle? style,
    bool isScrollControlled = false,
    bool useSafeArea = true,
  }) {
    _showModalSheet(
      context: context,
      content: content,
      style: style,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
    );
  }

  /// Helper method to show the modal sheet based on platform
  static void _showModalSheet({
    required BuildContext context,
    required Widget content,
    ModalSheetStyle? style,
    bool isScrollControlled = false,
    bool useSafeArea = true,
  }) {
    final effectiveStyle = _getEffectiveStyle(context, style);

    if (Platform.isIOS) {
      _showCupertinoModalSheet(
        context: context,
        content: content,
        style: effectiveStyle,
        useSafeArea: useSafeArea,
      );
    } else {
      _showMaterialModalSheet(
        context: context,
        content: content,
        style: effectiveStyle,
        isScrollControlled: isScrollControlled,
        useSafeArea: useSafeArea,
      );
    }
  }

  /// Get the appropriate style based on platform
  static ModalSheetStyle _getEffectiveStyle(
    BuildContext context,
    ModalSheetStyle? customStyle,
  ) {
    // Default style
    final defaultStyle = ModalSheetStyle(
      backgroundColor: Platform.isIOS
          ? CupertinoColors.systemBackground
          : Colors.white,
      borderRadius: Platform.isIOS ? 14.0 : 4.0,
      elevation: Platform.isIOS ? 0.0 : 6.0,
    );

    // Apply custom style if provided
    return customStyle != null
        ? _mergeStyles(defaultStyle, customStyle)
        : defaultStyle;
  }

  /// Merge base style with override style
  static ModalSheetStyle _mergeStyles(
      ModalSheetStyle base, ModalSheetStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      borderRadius: override.borderRadius,
      elevation: override.elevation,
      padding: override.padding,
      margin: override.margin,
    );
  }

  /// Show Material-style modal bottom sheet (for Android)
  static void _showMaterialModalSheet({
    required BuildContext context,
    required Widget content,
    required ModalSheetStyle style,
    bool isScrollControlled = false,
    bool useSafeArea = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: style.backgroundColor,
      elevation: style.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(style.borderRadius ?? 0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: style.padding ?? const EdgeInsets.all(16.0),
          child: content,
        );
      },
    );
  }

  /// Show Cupertino-style modal bottom sheet (for iOS)
  static void _showCupertinoModalSheet({
    required BuildContext context,
    required Widget content,
    required ModalSheetStyle style,
    bool useSafeArea = true,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SafeArea(
          top: useSafeArea,
          child: Container(
            decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(style.borderRadius ?? 0),
              ),
            ),
            padding: style.padding ?? const EdgeInsets.all(16.0),
            child: content,
          ),
        );
      },
    );
  }
}

/// Styling configuration for CommonModalSheet
class ModalSheetStyle {
  /// Background color of the modal sheet
  final Color? backgroundColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Elevation shadow for Material modal sheets
  final double? elevation;

  /// Padding inside the modal sheet
  final EdgeInsets? padding;

  /// Margin around the modal sheet
  final EdgeInsets? margin;

  const ModalSheetStyle({
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
  });

  ModalSheetStyle copyWith({
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    return ModalSheetStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
    );
  }
}