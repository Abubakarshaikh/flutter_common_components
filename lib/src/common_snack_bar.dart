import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform snackbar widget that adapts to iOS and Android platforms
/// Provides multiple snackbar variants with platform-specific styling
/// Follows composition-over-inheritance principle with SnackBarStyle

/// A platform-adaptive snackbar widget with multiple style variants
///
/// CommonSnackBar provides a unified API for creating snackbars that adapt to
/// the current platform (iOS or Android) with appropriate styling and behavior.
/// It supports multiple visual variants through factory constructors.
///
/// Usage examples:
/// ```dart
/// // Basic snackbar
/// CommonSnackBar.show(
///   context: context,
///   message: 'Item saved successfully',
/// );
///
/// // Success snackbar
/// CommonSnackBar.success(
///   context: context,
///   message: 'Payment processed successfully',
///   action: SnackBarAction(
///     label: 'VIEW',
///     onPressed: () => Navigator.pushNamed(context, '/receipts'),
///   ),
/// );
///
/// // Error snackbar
/// CommonSnackBar.error(
///   context: context,
///   message: 'Failed to connect to server',
///   action: SnackBarAction(
///     label: 'RETRY',
///     onPressed: () => fetchData(),
///   ),
/// );
/// ```
class CommonSnackBar {
  /// Show a basic snackbar with a neutral style
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      duration: duration,
      action: action,
      onVisible: onVisible,
      variant: SnackBarVariant.basic,
      style: style,
      showCloseIcon: showCloseIcon,
      width: width,
      margin: margin,
      shape: shape,
    );
  }

  /// Show a success-styled snackbar
  static void success({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      duration: duration,
      action: action,
      onVisible: onVisible,
      variant: SnackBarVariant.success,
      style: style,
      showCloseIcon: showCloseIcon,
      width: width,
      margin: margin,
      shape: shape,
    );
  }

  /// Show an error-styled snackbar
  static void error({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      duration: duration,
      action: action,
      onVisible: onVisible,
      variant: SnackBarVariant.error,
      style: style,
      showCloseIcon: showCloseIcon,
      width: width,
      margin: margin,
      shape: shape,
    );
  }

  /// Show a warning-styled snackbar
  static void warning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      duration: duration,
      action: action,
      onVisible: onVisible,
      variant: SnackBarVariant.warning,
      style: style,
      showCloseIcon: showCloseIcon,
      width: width,
      margin: margin,
      shape: shape,
    );
  }

  /// Show an info-styled snackbar
  static void info({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      duration: duration,
      action: action,
      onVisible: onVisible,
      variant: SnackBarVariant.info,
      style: style,
      showCloseIcon: showCloseIcon,
      width: width,
      margin: margin,
      shape: shape,
    );
  }

  /// Helper method to actually show the snackbar based on platform
  static void _showSnackBar({
    required BuildContext context,
    required String message,
    required Duration duration,
    required SnackBarVariant variant,
    SnackBarAction? action,
    VoidCallback? onVisible,
    SnackBarStyle? style,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    final effectiveStyle = _getEffectiveStyle(context, variant, style);

    // Platform-specific implementation
    if (Platform.isIOS) {
      _showCupertinoSnackBar(
        context: context,
        message: message,
        duration: duration,
        action: action,
        style: effectiveStyle,
        showCloseIcon: showCloseIcon,
        width: width,
        margin: margin,
        shape: shape,
      );
    } else {
      _showMaterialSnackBar(
        context: context,
        message: message,
        duration: duration,
        action: action,
        onVisible: onVisible,
        style: effectiveStyle,
        showCloseIcon: showCloseIcon,
        width: width,
        margin: margin,
        shape: shape,
      );
    }
  }

  /// Get the appropriate style based on variant and platform, with customizations
  static SnackBarStyle _getEffectiveStyle(
    BuildContext context,
    SnackBarVariant variant,
    SnackBarStyle? customStyle,
  ) {
    // Default style based on variant
    SnackBarStyle defaultStyle;

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
    final textColor = Platform.isIOS ? CupertinoColors.white : Colors.white;

    final borderRadius = Platform.isIOS ? 10.0 : 4.0;

    final elevation = Platform.isIOS ? 0.0 : 6.0;

    switch (variant) {
      case SnackBarVariant.basic:
        defaultStyle = SnackBarStyle(
          backgroundColor: neutralColor,
          textColor: textColor,
          actionTextColor:
              Platform.isIOS ? CupertinoColors.activeBlue : Colors.amber[300]!,
          borderRadius: borderRadius,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          behavior: SnackBarBehavior.fixed,
          icon: null,
        );
        break;

      case SnackBarVariant.success:
        defaultStyle = SnackBarStyle(
          backgroundColor: successColor,
          textColor: textColor,
          actionTextColor:
              Platform.isIOS ? CupertinoColors.white : Colors.white,
          borderRadius: borderRadius,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          behavior: SnackBarBehavior.fixed,
          icon: Icons.check_circle_outline,
        );
        break;

      case SnackBarVariant.error:
        defaultStyle = SnackBarStyle(
          backgroundColor: errorColor,
          textColor: textColor,
          actionTextColor:
              Platform.isIOS ? CupertinoColors.white : Colors.white,
          borderRadius: borderRadius,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          behavior: SnackBarBehavior.fixed,
          icon: Icons.error_outline,
        );
        break;

      case SnackBarVariant.warning:
        defaultStyle = SnackBarStyle(
          backgroundColor: warningColor,
          textColor: textColor,
          actionTextColor:
              Platform.isIOS ? CupertinoColors.white : Colors.white,
          borderRadius: borderRadius,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          behavior: SnackBarBehavior.fixed,
          icon: Icons.warning_amber_outlined,
        );
        break;

      case SnackBarVariant.info:
        defaultStyle = SnackBarStyle(
          backgroundColor: infoColor,
          textColor: textColor,
          actionTextColor:
              Platform.isIOS ? CupertinoColors.white : Colors.white,
          borderRadius: borderRadius,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          behavior: SnackBarBehavior.fixed,
          icon: Icons.info_outline,
        );
        break;
    }

    // Apply custom style if provided
    return customStyle != null
        ? _mergeStyles(defaultStyle, customStyle)
        : defaultStyle;
  }

  /// Merge base style with override style
  static SnackBarStyle _mergeStyles(
      SnackBarStyle base, SnackBarStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      textColor: override.textColor,
      actionTextColor: override.actionTextColor,
      borderRadius: override.borderRadius,
      elevation: override.elevation,
      padding: override.padding,
      margin: override.margin,
      behavior: override.behavior,
      width: override.width,
      icon: override.icon,
      textStyle: override.textStyle,
      actionTextStyle: override.actionTextStyle,
      closeIconColor: override.closeIconColor,
    );
  }

  /// Show Material-style snackbar (for Android)
  static void _showMaterialSnackBar({
    required BuildContext context,
    required String message,
    required Duration duration,
    required SnackBarStyle style,
    SnackBarAction? action,
    VoidCallback? onVisible,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    // Build the icon if needed
    Widget? leadingIcon;
    if (style.icon != null) {
      leadingIcon = Icon(
        style.icon,
        color: style.textColor,
        size: 24,
      );
    }

    // Create and show the snackbar
    final snackBar = SnackBar(
      content: Row(
        children: [
          if (leadingIcon != null) ...[
            leadingIcon,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: style.textStyle?.copyWith(color: style.textColor) ??
                  TextStyle(color: style.textColor),
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: style.backgroundColor,
      elevation: style.elevation,
      behavior: style.behavior,
      action: action != null
          ? SnackBarAction(
              label: action.label,
              onPressed: action.onPressed,
              textColor: style.actionTextColor,
            )
          : null,
      onVisible: onVisible,
      padding: style.padding,
      margin: margin ?? style.margin,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius ?? 0),
          ),
      width: width ?? style.width,
      dismissDirection: DismissDirection.down,
      showCloseIcon: showCloseIcon,
      closeIconColor: style.closeIconColor,
    );

    // Remove any existing snackbars first
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show Cupertino-style snackbar overlay (for iOS)
  static void _showCupertinoSnackBar({
    required BuildContext context,
    required String message,
    required Duration duration,
    required SnackBarStyle style,
    SnackBarAction? action,
    bool showCloseIcon = false,
    double? width,
    EdgeInsets? margin,
    ShapeBorder? shape,
  }) {
    // For iOS, we'll create a custom overlay that looks more like iOS toast notifications
    final overlay = OverlayState();
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return _CupertinoSnackBarOverlay(
          message: message,
          action: action,
          style: style,
          showCloseIcon: showCloseIcon,
          width: width ?? style.width,
          margin: margin ?? style.margin,
        );
      },
    );

    // Add to overlay and remove after duration
    overlay.insert(overlayEntry);
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

/// Custom Cupertino overlay implementation for iOS snackbar
class _CupertinoSnackBarOverlay extends StatefulWidget {
  final String message;
  final SnackBarAction? action;
  final SnackBarStyle style;
  final bool showCloseIcon;
  final double? width;
  final EdgeInsets? margin;

  const _CupertinoSnackBarOverlay({
    required this.message,
    required this.style,
    this.action,
    this.showCloseIcon = false,
    this.width,
    this.margin,
  });

  @override
  _CupertinoSnackBarOverlayState createState() =>
      _CupertinoSnackBarOverlayState();
}

class _CupertinoSnackBarOverlayState extends State<_CupertinoSnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate effective width
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveWidth = widget.width ?? screenWidth - 32;

    // Create the snackbar content
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: widget.margin ?? const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_animation),
              child: Container(
                width: effectiveWidth,
                decoration: BoxDecoration(
                  color: widget.style.backgroundColor,
                  borderRadius:
                      BorderRadius.circular(widget.style.borderRadius ?? 10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: widget.style.padding ??
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // Icon if present
                      if (widget.style.icon != null) ...[
                        Icon(
                          widget.style.icon,
                          color: widget.style.textColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                      ],

                      // Message
                      Expanded(
                        child: Text(
                          widget.message,
                          style: widget.style.textStyle
                                  ?.copyWith(color: widget.style.textColor) ??
                              TextStyle(color: widget.style.textColor),
                        ),
                      ),

                      // Action button if present
                      if (widget.action != null) ...[
                        const SizedBox(width: 8),
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minSize: 28,
                          child: Text(
                            widget.action!.label,
                            style: widget.style.actionTextStyle?.copyWith(
                                    color: widget.style.actionTextColor) ??
                                TextStyle(
                                  color: widget.style.actionTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            widget.action!.onPressed();
                            // Animate out when action is pressed
                            _controller.reverse().then((_) {
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                      ],

                      // Close icon if requested
                      if (widget.showCloseIcon) ...[
                        const SizedBox(width: 4),
                        CupertinoButton(
                          padding: const EdgeInsets.all(4),
                          minSize: 0,
                          child: Icon(
                            CupertinoIcons.xmark,
                            color: widget.style.closeIconColor ??
                                widget.style.textColor,
                            size: 16,
                          ),
                          onPressed: () {
                            // Animate out when close is pressed
                            _controller.reverse().then((_) {
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Snackbar variants supported by CommonSnackBar
enum SnackBarVariant {
  /// Basic neutral snackbar
  basic,

  /// Success-styled snackbar (green)
  success,

  /// Error-styled snackbar (red)
  error,

  /// Warning-styled snackbar (orange/amber)
  warning,

  /// Info-styled snackbar (blue)
  info,
}

/// Styling configuration for CommonSnackBar
/// Uses composition pattern to configure snackbar appearance
class SnackBarStyle {
  /// Background color of the snackbar
  final Color? backgroundColor;

  /// Color for snackbar text
  final Color? textColor;

  /// Color for action button text
  final Color? actionTextColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Elevation shadow for Material snackbars
  final double? elevation;

  /// Padding inside the snackbar
  final EdgeInsets? padding;

  /// Margin around the snackbar
  final EdgeInsets? margin;

  /// Behavior of the snackbar (floating or fixed)
  final SnackBarBehavior? behavior;

  /// Optional fixed width for the snackbar
  final double? width;

  /// Optional icon to display at the start of the snackbar
  final IconData? icon;

  /// Text style for snackbar message
  final TextStyle? textStyle;

  /// Text style for action button text
  final TextStyle? actionTextStyle;

  /// Color for the close icon
  final Color? closeIconColor;

  const SnackBarStyle({
    this.backgroundColor,
    this.textColor,
    this.actionTextColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.behavior,
    this.width,
    this.icon,
    this.textStyle,
    this.actionTextStyle,
    this.closeIconColor,
  });

  SnackBarStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? actionTextColor,
    double? borderRadius,
    double? elevation,
    EdgeInsets? padding,
    EdgeInsets? margin,
    SnackBarBehavior? behavior,
    double? width,
    IconData? icon,
    TextStyle? textStyle,
    TextStyle? actionTextStyle,
    Color? closeIconColor,
  }) {
    return SnackBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      actionTextColor: actionTextColor ?? this.actionTextColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      behavior: behavior ?? this.behavior,
      width: width ?? this.width,
      icon: icon ?? this.icon,
      textStyle: textStyle ?? this.textStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      closeIconColor: closeIconColor ?? this.closeIconColor,
    );
  }
}
