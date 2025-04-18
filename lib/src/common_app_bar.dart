import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform app bar widget with support for multiple configurations,
/// platform-specific styling, and customization options.
///
/// Usage examples:
/// ```dart
/// // Basic app bar with title
/// CommonAppBar(
///   title: 'Home',
/// )
///
/// // App bar with actions and leading icon
/// CommonAppBar(
///   title: 'Profile',
///   leadingIcon: Icons.arrow_back,
///   onLeadingPressed: () => Navigator.pop(context),
///   actions: [
///     IconButton(
///       icon: Icon(Icons.search),
///       onPressed: () => print('Search pressed'),
///     ),
///   ],
/// )
///
/// // Custom app bar with flexible space
/// CommonAppBar(
///   title: 'Settings',
///   flexibleSpace: Container(
///     decoration: BoxDecoration(
///       gradient: LinearGradient(
///         colors: [Colors.blue, Colors.green],
///       ),
///     ),
///   ),
/// )
/// ```
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title of the app bar
  final String? title;

  /// Widget to use as the title (overrides [title] if provided)
  final Widget? titleWidget;

  /// Leading icon (e.g., back button)
  final IconData? leadingIcon;

  /// Callback when the leading icon is pressed
  final VoidCallback? onLeadingPressed;

  /// List of actions (e.g., buttons) to display on the app bar
  final List<Widget>? actions;

  /// Whether to automatically imply the leading icon
  final bool automaticallyImplyLeading;

  /// Background color of the app bar
  final Color? backgroundColor;

  /// Elevation of the app bar
  final double? elevation;

  /// Flexible space widget (e.g., for gradients or custom backgrounds)
  final Widget? flexibleSpace;

  /// Whether to use platform-specific styling
  final bool usePlatformStyle;

  /// Padding around the title
  final EdgeInsets? titlePadding;

  /// Whether to center the title
  final bool centerTitle;

  /// Height of the app bar
  final double? toolbarHeight;

  const CommonAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.elevation,
    this.flexibleSpace,
    this.usePlatformStyle = true,
    this.titlePadding,
    this.centerTitle = true,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS =
        usePlatformStyle && Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return _buildCupertinoAppBar(context);
    } else {
      return _buildMaterialAppBar(context);
    }
  }

  /// Builds a Material Design app bar
  PreferredSizeWidget _buildMaterialAppBar(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      leading: leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon),
              onPressed: onLeadingPressed,
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: elevation ?? 4.0,
      flexibleSpace: flexibleSpace,
      // titlePadding: titlePadding,
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight,
    );
  }

  /// Builds a Cupertino-style app bar
  PreferredSizeWidget _buildCupertinoAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: titleWidget ?? (title != null ? Text(title!) : null),
      leading: leadingIcon != null
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onLeadingPressed,
              child: Icon(leadingIcon),
            )
          : null,
      trailing: actions != null ? Row(children: actions!) : null,
      backgroundColor:
          backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
