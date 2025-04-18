import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform popup menu widget with support for multiple menu item types,
/// platform-specific styling, and customization options.
///
/// Usage examples:
/// ```dart
/// // Basic text menu items
/// CommonPopupMenu(
///   items: [
///     CommonPopupMenuItem.text(
///       label: 'Edit',
///       onTap: () => print('Edit tapped'),
///     ),
///     CommonPopupMenuItem.text(
///       label: 'Delete',
///       onTap: () => print('Delete tapped'),
///     ),
///   ],
/// )
///
/// // Icon menu items
/// CommonPopupMenu(
///   items: [
///     CommonPopupMenuItem.icon(
///       icon: Icons.edit,
///       label: 'Edit',
///       onTap: () => print('Edit tapped'),
///     ),
///     CommonPopupMenuItem.icon(
///       icon: Icons.delete,
///       label: 'Delete',
///       onTap: () => print('Delete tapped'),
///     ),
///   ],
/// )
///
/// // Custom menu items
/// CommonPopupMenu(
///   items: [
///     CommonPopupMenuItem.custom(
///       child: ListTile(
///         leading: Icon(Icons.settings),
///         title: Text('Settings'),
///       ),
///       onTap: () => print('Settings tapped'),
///     ),
///   ],
/// )
/// ```
class CommonPopupMenu extends StatelessWidget {
  /// List of menu items to display
  final List<CommonPopupMenuItem> items;

  /// Padding around the menu
  final EdgeInsets? padding;

  /// Background color of the menu
  final Color? backgroundColor;

  /// Elevation of the menu
  final double? elevation;

  /// Border radius of the menu
  final BorderRadius? borderRadius;

  /// Width of the menu
  final double? width;

  /// Whether to use platform-specific styling
  final bool usePlatformStyle;

  const CommonPopupMenu({
    super.key,
    required this.items,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.width,
    this.usePlatformStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS =
        usePlatformStyle && Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return _buildCupertinoPopupMenu(context);
    } else {
      return _buildMaterialPopupMenu(context);
    }
  }

  /// Builds a Material Design popup menu
  Widget _buildMaterialPopupMenu(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) =>
          items.map((item) => item.toMaterialPopupMenuItem()).toList(),
      padding: padding ?? EdgeInsets.zero,
      elevation: elevation ?? 8.0,
      color: backgroundColor ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: const Icon(Icons.more_vert),
    );
  }

  /// Builds a Cupertino-style popup menu
  Widget _buildCupertinoPopupMenu(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.ellipsis_vertical),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              actions: items
                  .map((item) => item.toCupertinoActionSheetAction())
                  .toList(),
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            );
          },
        );
      },
    );
  }
}

/// Represents a single item in the popup menu
class CommonPopupMenuItem {
  /// The label of the menu item
  final String? label;

  /// The icon of the menu item
  final IconData? icon;

  /// The custom widget for the menu item
  final Widget? child;

  /// Callback when the menu item is tapped
  final VoidCallback? onTap;

  /// Whether the menu item is destructive (e.g., delete)
  final bool isDestructive;

  /// Private constructor - forces use of factory constructors
  const CommonPopupMenuItem._({
    this.label,
    this.icon,
    this.child,
    this.onTap,
    this.isDestructive = false,
  });

  /// Factory constructor for text-only menu items
  factory CommonPopupMenuItem.text({
    required String label,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return CommonPopupMenuItem._(
      label: label,
      onTap: onTap,
      isDestructive: isDestructive,
    );
  }

  /// Factory constructor for icon + text menu items
  factory CommonPopupMenuItem.icon({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return CommonPopupMenuItem._(
      icon: icon,
      label: label,
      onTap: onTap,
      isDestructive: isDestructive,
    );
  }

  /// Factory constructor for custom menu items
  factory CommonPopupMenuItem.custom({
    required Widget child,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return CommonPopupMenuItem._(
      child: child,
      onTap: onTap,
      isDestructive: isDestructive,
    );
  }

  /// Converts the menu item to a Material Design PopupMenuItem
  PopupMenuItem<CommonPopupMenuItem> toMaterialPopupMenuItem() {
    return PopupMenuItem(
      value: this,
      onTap: onTap,
      child: child ??
          ListTile(
            leading: icon != null ? Icon(icon) : null,
            title: Text(label ?? ''),
            textColor: isDestructive ? Colors.red : null,
          ),
    );
  }

  /// Converts the menu item to a Cupertino ActionSheetAction
  CupertinoActionSheetAction toCupertinoActionSheetAction() {
    return CupertinoActionSheetAction(
      onPressed: onTap ?? () {},
      child: Text(
        label ?? '',
        style: TextStyle(
          color: isDestructive ? CupertinoColors.destructiveRed : null,
        ),
      ),
    );
  }
}
