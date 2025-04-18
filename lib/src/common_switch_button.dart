import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform switch widget that adapts to iOS and Android platforms
/// Provides multiple switch variants with platform-specific styling
/// Follows composition-over-inheritance principle with SwitchStyle

/// A platform-adaptive switch widget with multiple style variants
///
/// CommonSwitchButton provides a unified API for creating switches that adapt to
/// the current platform (iOS or Android) with appropriate styling and behavior.
/// It supports multiple visual variants through factory constructors.
///
/// Usage examples:
/// ```dart
/// // Default switch
/// CommonSwitchButton(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
/// )
///
/// // Colored variant
/// CommonSwitchButton.colored(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
///   activeColor: Colors.green,
///   inactiveColor: Colors.grey,
/// )
///
/// // Compact variant
/// CommonSwitchButton.compact(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
/// )
/// ```
class CommonSwitchButton extends StatelessWidget {
  /// Private constructor - forces use of factory constructors
  const CommonSwitchButton._({
    super.key,
    required this.value,
    required this.variant,
    this.onChanged,
    this.style,
    this.useAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// Current state of the switch
  final bool value;

  /// Callback for when the switch is toggled
  final void Function(bool)? onChanged;

  /// Switch variant
  final SwitchVariant variant;

  /// Custom styling for the switch
  final CommonSwitchStyle? style;

  /// Whether to use animation when toggling
  final bool useAnimation;

  /// Duration for the toggle animation
  final Duration animationDuration;

  /// Default switch constructor
  factory CommonSwitchButton({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    CommonSwitchStyle? style,
    bool useAnimation = true,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    return CommonSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.standard,
      style: style,
      useAnimation: useAnimation,
      animationDuration: animationDuration,
    );
  }

  /// Colored switch variant with custom colors
  factory CommonSwitchButton.colored({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    required Color activeColor,
    required Color inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    CommonSwitchStyle? style,
  }) {
    return CommonSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.colored,
      style: style?.copyWith(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
          ) ??
          CommonSwitchStyle(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
          ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
    );
  }

  /// Compact variant of the switch with smaller size
  factory CommonSwitchButton.compact({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    CommonSwitchStyle? style,
  }) {
    return CommonSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.compact,
      style: style?.copyWith(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
            scale: 0.8, // Smaller scale for compact variant
          ) ??
          CommonSwitchStyle(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
            scale: 0.8, // Smaller scale for compact variant
          ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
    );
  }

  /// Large variant of the switch with bigger size
  factory CommonSwitchButton.large({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    CommonSwitchStyle? style,
  }) {
    return CommonSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.large,
      style: style?.copyWith(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
            scale: 1.2, // Larger scale for large variant
          ) ??
          CommonSwitchStyle(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            thumbColor: thumbColor,
            scale: 1.2, // Larger scale for large variant
          ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
    );
  }

  /// Branded variant with custom brand colors
  factory CommonSwitchButton.branded({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    required Color brandColor,
    Color? inactiveColor,
    bool useAnimation = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    CommonSwitchStyle? style,
  }) {
    return CommonSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.branded,
      style: style?.copyWith(
            activeColor: brandColor,
            inactiveColor: inactiveColor ?? Colors.grey[300],
            thumbColor: Colors.white,
          ) ??
          CommonSwitchStyle(
            activeColor: brandColor,
            inactiveColor: inactiveColor ?? Colors.grey[300],
            thumbColor: Colors.white,
          ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _getEffectiveStyle(context);
    final isDisabled = onChanged == null;

    // Build the platform-specific switch
    Widget switchWidget =
        _buildPlatformSwitch(context, effectiveStyle, isDisabled);

    // Apply scale transform if needed
    if (effectiveStyle.scale != null && effectiveStyle.scale != 1.0) {
      switchWidget = Transform.scale(
        scale: effectiveStyle.scale!,
        child: switchWidget,
      );
    }

    // Apply animation if enabled
    if (useAnimation) {
      return AnimatedSwitcher(
        duration: animationDuration,
        reverseDuration: animationDuration,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeInOut,
        child: switchWidget,
      );
    }

    return switchWidget;
  }

  Widget _buildPlatformSwitch(
    BuildContext context,
    CommonSwitchStyle style,
    bool isDisabled,
  ) {
    // Use the appropriate widget based on platform
    if (Platform.isIOS) {
      return _buildCupertinoSwitch(style, isDisabled);
    } else {
      return _buildMaterialSwitch(context, style, isDisabled);
    }
  }

  Widget _buildCupertinoSwitch(CommonSwitchStyle style, bool isDisabled) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: style.activeColor,
        inactiveTrackColor: style.inactiveColor,
        thumbColor: style.thumbColor,
      ),
    );
  }

  Widget _buildMaterialSwitch(
    BuildContext context,
    CommonSwitchStyle style,
    bool isDisabled,
  ) {
    final theme = Theme.of(context);

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: style.thumbColor,
      activeTrackColor: style.activeColor,
      inactiveThumbColor: style.inactiveThumbColor ?? theme.colorScheme.surface,
      inactiveTrackColor: style.inactiveColor,
    );
  }

  CommonSwitchStyle _getEffectiveStyle(BuildContext context) {
    final theme = Theme.of(context);

    // Define default styles based on platform and variant
    final defaultPrimaryColor =
        Platform.isIOS ? CupertinoColors.systemBlue : theme.colorScheme.primary;

    // Base style depending on variant
    CommonSwitchStyle defaultStyle;

    switch (variant) {
      case SwitchVariant.standard:
        defaultStyle = CommonSwitchStyle(
          activeColor: defaultPrimaryColor,
          inactiveColor: Platform.isIOS
              ? CupertinoColors.systemGrey5
              : theme.colorScheme.onSurface.withOpacity(0.3),
          thumbColor: Platform.isIOS ? Colors.white : null,
          inactiveThumbColor: Platform.isIOS ? Colors.white : null,
          scale: 1.0,
        );
        break;

      case SwitchVariant.colored:
        // Colored variant uses custom colors provided in the factory constructor
        // Defaults are handled there
        defaultStyle = style ?? const CommonSwitchStyle();
        break;

      case SwitchVariant.compact:
        defaultStyle = CommonSwitchStyle(
          activeColor: defaultPrimaryColor,
          inactiveColor: Platform.isIOS
              ? CupertinoColors.systemGrey5
              : theme.colorScheme.onSurface.withOpacity(0.3),
          thumbColor: Platform.isIOS ? Colors.white : null,
          inactiveThumbColor: Platform.isIOS ? Colors.white : null,
          scale: 0.8,
        );
        break;

      case SwitchVariant.large:
        defaultStyle = CommonSwitchStyle(
          activeColor: defaultPrimaryColor,
          inactiveColor: Platform.isIOS
              ? CupertinoColors.systemGrey5
              : theme.colorScheme.onSurface.withOpacity(0.3),
          thumbColor: Platform.isIOS ? Colors.white : null,
          inactiveThumbColor: Platform.isIOS ? Colors.white : null,
          scale: 1.2,
        );
        break;

      case SwitchVariant.branded:
        // Branded variant uses custom brand color provided in the factory constructor
        // Defaults are handled there
        defaultStyle = style ?? const CommonSwitchStyle();
        break;
    }

    // Return merged style if custom style provided
    return style != null &&
            variant != SwitchVariant.colored &&
            variant != SwitchVariant.branded
        ? _mergeStyles(defaultStyle, style!)
        : defaultStyle;
  }

  CommonSwitchStyle _mergeStyles(
    CommonSwitchStyle base,
    CommonSwitchStyle override,
  ) {
    return base.copyWith(
      activeColor: override.activeColor,
      inactiveColor: override.inactiveColor,
      thumbColor: override.thumbColor,
      inactiveThumbColor: override.inactiveThumbColor,
      scale: override.scale,
    );
  }
}

/// Switch variants supported by CommonSwitchButton
enum SwitchVariant {
  /// Standard default switch
  standard,

  /// Custom colored switch
  colored,

  /// Compact smaller switch
  compact,

  /// Large bigger switch
  large,

  /// Branded switch with specific brand color
  branded,
}

/// Styling configuration for CommonSwitchButton
/// Uses composition pattern to configure switch appearance
class CommonSwitchStyle {
  /// Color when the switch is in the on/active state
  final Color? activeColor;

  /// Color when the switch is in the off/inactive state
  final Color? inactiveColor;

  /// Color of the thumb (handle) when active
  final Color? thumbColor;

  /// Color of the thumb when inactive (Android only)
  final Color? inactiveThumbColor;

  /// Scale factor for the switch size
  final double? scale;

  const CommonSwitchStyle({
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.inactiveThumbColor,
    this.scale,
  });

  CommonSwitchStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    Color? inactiveThumbColor,
    double? scale,
  }) {
    return CommonSwitchStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      thumbColor: thumbColor ?? this.thumbColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
      scale: scale ?? this.scale,
    );
  }
}
