import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_switch_button_theme.dart';

const _kDefaultAnimationDuration = Duration(milliseconds: 400);
const _kBrandedInactiveColor = Color(0xFFE0E0E0);

/// A platform-adaptive switch widget with multiple style variants.
///
/// Renders a [CupertinoSwitch] on iOS and a Material [Switch] elsewhere
/// (based on [ThemeData.platform]). Visual variants are available through
/// factory constructors; colors come from [CommonSwitchStyle].
///
/// Usage examples:
/// ```dart
/// // Default switch
/// AppSwitchButton(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
/// )
///
/// // Colored variant
/// AppSwitchButton.colored(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
///   activeColor: Colors.green,
///   inactiveColor: Colors.grey,
/// )
///
/// // Compact variant
/// AppSwitchButton.compact(
///   value: isActive,
///   onChanged: (value) => setState(() => isActive = value),
/// )
/// ```
class AppSwitchButton extends StatelessWidget {
  /// Private constructor - forces use of factory constructors
  const AppSwitchButton._({
    super.key,
    required this.value,
    this.onChanged,
    required this.variant,
    this.style,
    this.useAnimation = true,
    this.animationDuration = _kDefaultAnimationDuration,
    this.dismissKeyboard = true,
  });

  /// Current state of the switch
  final bool value;

  /// Callback for when the switch is toggled. The switch is disabled when null.
  final void Function(bool)? onChanged;

  /// Switch variant
  final SwitchVariant variant;

  /// Per-instance overrides on top of the ambient [CommonSwitchStyle].
  final CommonSwitchStyle? style;

  /// Whether to use animation when toggling
  final bool useAnimation;

  /// Duration for the toggle animation
  final Duration animationDuration;

  /// Whether toggling unfocuses the current primary focus (closing the
  /// keyboard).
  final bool dismissKeyboard;

  /// Default switch constructor
  factory AppSwitchButton({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    CommonSwitchStyle? style,
    bool useAnimation = true,
    Duration animationDuration = _kDefaultAnimationDuration,
    bool dismissKeyboard = true,
  }) {
    return AppSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.standard,
      style: style,
      useAnimation: useAnimation,
      animationDuration: animationDuration,
      dismissKeyboard: dismissKeyboard,
    );
  }

  /// Factory for a brightly colored variant of the switch
  factory AppSwitchButton.colored({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    required Color activeColor,
    required Color inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = _kDefaultAnimationDuration,
    CommonSwitchStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.colored,
      style: (style ?? const CommonSwitchStyle()).copyWith(
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        thumbColor: thumbColor,
      ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
      dismissKeyboard: dismissKeyboard,
    );
  }

  /// Factory for a smaller, compact variant of the switch
  factory AppSwitchButton.compact({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = _kDefaultAnimationDuration,
    CommonSwitchStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.compact,
      style: (style ?? const CommonSwitchStyle()).copyWith(
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        thumbColor: thumbColor,
        scale: 0.8,
      ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
      dismissKeyboard: dismissKeyboard,
    );
  }

  /// Factory for a larger, more prominent variant of the switch
  factory AppSwitchButton.large({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    bool useAnimation = true,
    Duration animationDuration = _kDefaultAnimationDuration,
    CommonSwitchStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.large,
      style: (style ?? const CommonSwitchStyle()).copyWith(
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        thumbColor: thumbColor,
        scale: 1.2,
      ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
      dismissKeyboard: dismissKeyboard,
    );
  }

  /// Factory for a branded variant of the switch.
  ///
  /// The thumb defaults to [ColorScheme.onPrimary] and the off track to a
  /// light neutral grey.
  factory AppSwitchButton.branded({
    Key? key,
    required bool value,
    void Function(bool)? onChanged,
    required Color brandColor,
    Color? inactiveColor,
    bool useAnimation = true,
    Duration animationDuration = _kDefaultAnimationDuration,
    CommonSwitchStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppSwitchButton._(
      key: key,
      value: value,
      onChanged: onChanged,
      variant: SwitchVariant.branded,
      style: (style ?? const CommonSwitchStyle()).copyWith(
        activeColor: brandColor,
        inactiveColor: inactiveColor ?? _kBrandedInactiveColor,
      ),
      useAnimation: useAnimation,
      animationDuration: animationDuration,
      dismissKeyboard: dismissKeyboard,
    );
  }

  void Function(bool)? _handleChanged() {
    if (onChanged == null) return null;

    return (bool newValue) {
      if (dismissKeyboard) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      onChanged!(newValue);
    };
  }

  CommonSwitchStyle _effectiveStyle(BuildContext context) {
    var effective = CommonSwitchStyle.of(context);
    if (variant == SwitchVariant.branded) {
      final onBrand = Theme.of(context).colorScheme.onPrimary;
      effective = effective.copyWith(
        thumbColor: onBrand,
        inactiveThumbColor: onBrand,
      );
    }
    return effective.merge(style);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _effectiveStyle(context);
    final handleChanged = _handleChanged();
    final isDisabled = onChanged == null;

    Widget switchWidget = Theme.of(context).platform == TargetPlatform.iOS
        ? _buildCupertinoSwitch(effectiveStyle, isDisabled, handleChanged)
        : _buildMaterialSwitch(effectiveStyle, handleChanged);

    final scale = effectiveStyle.scale;
    if (scale != null && scale != 1.0) {
      switchWidget = Transform.scale(scale: scale, child: switchWidget);
    }

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

  Widget _buildCupertinoSwitch(
    CommonSwitchStyle style,
    bool isDisabled,
    void Function(bool)? handleChanged,
  ) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: CupertinoSwitch(
        value: value,
        onChanged: handleChanged,
        activeTrackColor: style.activeColor,
        inactiveTrackColor: style.inactiveColor,
        thumbColor: style.thumbColor,
      ),
    );
  }

  Widget _buildMaterialSwitch(
    CommonSwitchStyle style,
    void Function(bool)? handleChanged,
  ) {
    return Switch(
      value: value,
      onChanged: handleChanged,
      activeThumbColor: style.thumbColor,
      activeTrackColor: style.activeColor,
      inactiveThumbColor: style.inactiveThumbColor,
      inactiveTrackColor: style.inactiveColor,
    );
  }
}

/// Switch variants supported by [AppSwitchButton]
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
