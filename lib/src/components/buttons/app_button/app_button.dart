import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_button_theme.dart';

/// A button widget with multiple style variants, exposed through named
/// constructors.
///
/// Disabled when `onPressed` is `null`; shows a spinner in place of the label
/// when `isLoading`. Colors, radius, padding and typography default to
/// [AppButtonTheme] (derived from the ambient [ColorScheme]) and can be
/// tweaked per instance with an [AppButtonStyle].
///
/// ```dart
/// AppButton.primary(text: 'Save', onPressed: save);
/// AppButton.outline(text: 'Cancel', onPressed: cancel, fullWidth: false);
/// AppButton.circularIcon(icon: Icons.add, onPressed: add);
/// AppButton.textWithIcon(text: 'Edit', icon: Icons.edit, onPressed: edit);
/// ```
class AppButton extends StatelessWidget {
  /// Private constructor - forces use of factory constructors
  const AppButton._({
    super.key,
    required this.text,
    required this.onPressed,
    required this.variant,
    this.isLoading = false,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
    this.style,
    this.fullWidth = true,
    this.dismissKeyboard = true,
    double outlineWidth = 1.0,
  }) : _outlineWidth = outlineWidth;

  // Button properties
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final double? height;
  final AppButtonStyle? style;
  final bool fullWidth;
  final bool dismissKeyboard;

  /// Stroke width used when the outline color falls back to the theme.
  final double _outlineWidth;

  // Factory constructor for primary button
  factory AppButton.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool elevated = true,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        elevation: elevated ? 2.0 : 0.0,
      ),
      variant: ButtonVariant.primary,
    );
  }

  // Factory constructor for secondary button
  factory AppButton.secondary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool outlined = false,
    Color? customColor,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: customColor,
        border: outlined && customColor != null
            ? BorderSide(color: customColor)
            : null,
      ),
      variant: outlined
          ? ButtonVariant.outlinedSecondary
          : ButtonVariant.secondary,
    );
  }

  // Factory constructor for outline button
  factory AppButton.outline({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    double borderWidth = 1.0,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      outlineWidth: borderWidth,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: textColor,
        border: borderColor != null
            ? BorderSide(color: borderColor, width: borderWidth)
            : null,
      ),
      variant: ButtonVariant.outline,
    );
  }

  // Factory constructor for simple icon button
  factory AppButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    IconData? icon,
    Widget? customIcon,
    Color? iconColor,
    double size = 20.0,
    bool isLoading = false,
    AppButtonStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: '',
      onPressed: onPressed,
      isLoading: isLoading,
      prefix:
          customIcon ??
          (icon != null ? Icon(icon, size: size, color: iconColor) : null),
      fullWidth: false,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: iconColor,
        iconSize: size,
        iconData: icon,
        padding: const EdgeInsets.all(8.0),
      ),
      variant: ButtonVariant.textBasic,
    );
  }

  // Factory constructor for circular icon button
  factory AppButton.circularIcon({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    Color? iconColor,
    Color? borderColor,
    double size = 40,
    bool isLoading = false,
    AppButtonStyle? style,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: '',
      onPressed: onPressed,
      isLoading: isLoading,
      width: size,
      height: size,
      fullWidth: false,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: iconColor,
        border: BorderSide(color: borderColor ?? Colors.transparent),
        borderRadius: size / 2,
        iconSize: size * 0.5,
        iconData: icon,
      ),
      variant: ButtonVariant.circularIcon,
    );
  }

  // Factory constructor for basic text button
  factory AppButton.text({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    Color? textColor,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(textColor: textColor),
      variant: ButtonVariant.textBasic,
    );
  }

  // Factory constructor for text button with icon
  factory AppButton.textWithIcon({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    required IconData icon,
    bool iconLeading = true,
    Color? textColor,
    Color? iconColor,
    double? iconSize,
    bool isLoading = false,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    final iconWidget = Icon(icon, size: iconSize ?? 24, color: iconColor);
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: iconLeading ? iconWidget : null,
      suffix: !iconLeading ? iconWidget : null,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: textColor,
        iconSize: iconSize,
      ),
      variant: ButtonVariant.textWithIcon,
    );
  }

  // Factory constructor for underlined text button
  factory AppButton.textUnderlined({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    Color? textColor,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      // Keep the text style inherited from the theme and apply the underline
      // at render time (see `ButtonVariant.textUnderlined` handling).
      style: (style ?? const AppButtonStyle()).copyWith(textColor: textColor),
      variant: ButtonVariant.textUnderlined,
    );
  }

  // Factory constructor for colored text button
  factory AppButton.textColored({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    required Color textColor,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    double? width,
    double? height,
    AppButtonStyle? style,
    bool fullWidth = true,
    bool dismissKeyboard = true,
  }) {
    return AppButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      prefix: prefix,
      suffix: suffix,
      width: width,
      height: height,
      fullWidth: fullWidth,
      dismissKeyboard: dismissKeyboard,
      style: (style ?? const AppButtonStyle()).copyWith(
        textColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      variant: ButtonVariant.textColored,
    );
  }

  VoidCallback? _createPressedCallback() {
    if (onPressed == null) return null;

    return () {
      if (dismissKeyboard) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      onPressed!();
    };
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = _isTabletFormFactor(context);
    final buttonTheme = AppButtonTheme.of(context);

    final isDisabled = onPressed == null;
    final effectiveStyle = _getEffectiveStyle(
      context,
      buttonTheme,
      isDisabled,
      isTablet,
    );

    final pressedCallback = _createPressedCallback();

    Widget buttonChild;

    // Special handling for circular icon button
    if (variant == ButtonVariant.circularIcon) {
      buttonChild = isLoading
          ? _loader(context, effectiveStyle)
          : Icon(
              effectiveStyle.iconData ?? Icons.add,
              color: effectiveStyle.textColor,
              size: effectiveStyle.iconSize ?? 24,
            );
    }
    // Standard handling for text-based buttons
    else {
      final constrainLabelWidth =
          fullWidth || width != null || effectiveStyle.width != null;

      Widget label({required bool expanded}) {
        final labelText = Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          textScaler: MediaQuery.textScalerOf(context),
          textWidthBasis: TextWidthBasis.parent,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: effectiveStyle.textColor,
            fontSize: effectiveStyle.textStyle?.fontSize,
            fontWeight: effectiveStyle.textStyle?.fontWeight ?? FontWeight.w600,
            height: effectiveStyle.textStyle?.height,
            letterSpacing: effectiveStyle.textStyle?.letterSpacing,
          ),
        );
        return expanded ? Expanded(child: labelText) : labelText;
      }

      buttonChild = Row(
        mainAxisSize: constrainLabelWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
          if (isLoading)
            _loader(context, effectiveStyle)
          else if (text.isNotEmpty)
            label(expanded: constrainLabelWidth),
          if (suffix != null) ...[const SizedBox(width: 8), suffix!],
        ],
      );
    }

    final effectiveWidth = fullWidth && width == null
        ? double.infinity
        : width ?? effectiveStyle.width;
    final duration =
        effectiveStyle.animationDuration ??
        buttonTheme.animationDuration ??
        const Duration(milliseconds: 200);

    final button = _buildMaterialButton(
      context,
      buttonTheme,
      effectiveStyle,
      buttonChild,
      pressedCallback,
    );

    final container = effectiveWidth != null
        ? AnimatedContainer(
            duration: duration,
            width: effectiveWidth,
            height: height ?? effectiveStyle.height,
            child: button,
          )
        : IntrinsicWidth(
            child: AnimatedContainer(
              duration: duration,
              height: height ?? effectiveStyle.height,
              child: button,
            ),
          );
    if (effectiveStyle.margin != null) {
      return Padding(padding: effectiveStyle.margin!, child: container);
    }

    return container;
  }

  Widget _loader(BuildContext context, AppButtonStyle style) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          style.textColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  AppButtonStyle _getEffectiveStyle(
    BuildContext context,
    AppButtonTheme buttonTheme,
    bool isDisabled,
    bool isTablet,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final fontSize = isTablet
        ? buttonTheme.tabletFontSize
        : buttonTheme.fontSize;
    final radius = buttonTheme.borderRadius;
    final padding = buttonTheme.padding;
    final textPadding = buttonTheme.textPadding;
    final duration = buttonTheme.animationDuration;
    final outlineBorder = BorderSide(
      color: buttonTheme.outlineBorderColor!,
      width: _outlineWidth,
    );

    // Start with default style based on variant
    final AppButtonStyle defaultStyle;

    switch (variant) {
      case ButtonVariant.primary:
        defaultStyle = AppButtonStyle(
          backgroundColor: buttonTheme.primaryBackgroundColor,
          textColor: buttonTheme.primaryForegroundColor,
          elevation: 2.0,
          padding: padding,
          borderRadius: radius,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            letterSpacing: 1.5,
            height: 1.2,
          ),
          animationDuration: duration,
        );
      case ButtonVariant.secondary:
      case ButtonVariant.outlinedSecondary:
        defaultStyle = AppButtonStyle(
          backgroundColor: variant == ButtonVariant.secondary
              ? buttonTheme.secondaryBackgroundColor
              : Colors.transparent,
          textColor: buttonTheme.secondaryForegroundColor,
          border: variant == ButtonVariant.outlinedSecondary
              ? outlineBorder
              : null,
          padding: padding,
          borderRadius: radius,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            height: 1.2,
          ),
          animationDuration: duration,
        );
      case ButtonVariant.outline:
        // Match [ButtonVariant.primary] metrics (padding, radius, typography);
        // only fill vs stroked appearance differs.
        defaultStyle = AppButtonStyle(
          backgroundColor: Colors.transparent,
          textColor: buttonTheme.outlineForegroundColor,
          border: outlineBorder,
          padding: padding,
          borderRadius: radius,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            letterSpacing: 1.5,
            height: 1.2,
          ),
          animationDuration: duration,
        );
      case ButtonVariant.circularIcon:
        defaultStyle = AppButtonStyle(
          backgroundColor: buttonTheme.circularIconBackgroundColor,
          textColor: buttonTheme.circularIconForegroundColor,
          border: BorderSide(color: buttonTheme.circularIconBorderColor!),
          width: isTablet ? 48.0 : 40.0,
          height: isTablet ? 48.0 : 40.0,
          borderRadius: isTablet ? 24.0 : 20.0,
          iconSize: isTablet ? 24.0 : 20.0,
          animationDuration: duration,
        );
      case ButtonVariant.textBasic:
      case ButtonVariant.textColored:
        defaultStyle = AppButtonStyle(
          backgroundColor: Colors.transparent,
          textColor: buttonTheme.textForegroundColor,
          padding: textPadding,
          textStyle: textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            height: 1.2,
          ),
          animationDuration: duration,
        );
      case ButtonVariant.textWithIcon:
        defaultStyle = AppButtonStyle(
          backgroundColor: Colors.transparent,
          textColor: buttonTheme.textForegroundColor,
          padding: textPadding,
          textStyle: textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            height: 1.2,
          ),
          iconSize: isTablet ? 20.0 : 16.0,
          animationDuration: duration,
        );
      case ButtonVariant.textUnderlined:
        defaultStyle = AppButtonStyle(
          backgroundColor: Colors.transparent,
          textColor: buttonTheme.textForegroundColor,
          padding: textPadding,
          textStyle: textTheme.bodyMedium?.copyWith(
            decoration: TextDecoration.underline,
            fontSize: fontSize,
            height: 1.2,
          ),
          animationDuration: duration,
        );
    }

    // Apply custom style if provided
    final customizedStyle = style != null
        ? _mergeStyles(defaultStyle, style!)
        : defaultStyle;

    // Apply disabled style if button is disabled
    if (isDisabled) {
      final hasFill =
          variant == ButtonVariant.primary ||
          variant == ButtonVariant.secondary ||
          variant == ButtonVariant.circularIcon;
      return customizedStyle.copyWith(
        backgroundColor: hasFill ? buttonTheme.disabledBackgroundColor : null,
        textColor: buttonTheme.disabledForegroundColor,
        elevation: 0,
      );
    }

    return customizedStyle;
  }

  AppButtonStyle _mergeStyles(AppButtonStyle base, AppButtonStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      textColor: override.textColor,
      elevation: override.elevation,
      padding: override.padding,
      borderRadius: override.borderRadius,
      border: override.border,
      margin: override.margin,
      width: override.width,
      height: override.height,
      textStyle: override.textStyle,
      iconSize: override.iconSize,
      animationDuration: override.animationDuration,
      shadow: override.shadow,
      disabled: override.disabled,
      iconData: override.iconData,
    );
  }

  Widget _buildMaterialButton(
    BuildContext context,
    AppButtonTheme buttonTheme,
    AppButtonStyle style,
    Widget child,
    VoidCallback? pressedCallback,
  ) {
    // Create full width container for material buttons if needed
    final buttonChild = fullWidth && variant != ButtonVariant.circularIcon
        ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: child,
          )
        : child;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
    );
    final minimumSize = fullWidth ? const Size(double.infinity, 0) : null;

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: pressedCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.textColor,
            disabledBackgroundColor: buttonTheme.disabledBackgroundColor,
            disabledForegroundColor: buttonTheme.disabledForegroundColor,
            elevation: style.elevation,
            shadowColor: style.shadow?.color,
            padding: style.padding,
            shape: shape,
            textStyle: style.textStyle,
            minimumSize: minimumSize,
          ),
          child: buttonChild,
        );

      case ButtonVariant.outlinedSecondary:
      case ButtonVariant.outline:
        final EdgeInsetsGeometry outlinePadding =
            style.padding ??
            buttonTheme.padding ??
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);
        return OutlinedButton(
          onPressed: pressedCallback,
          style:
              OutlinedButton.styleFrom(
                backgroundColor: style.backgroundColor,
                foregroundColor: style.textColor,
                disabledForegroundColor: buttonTheme.disabledForegroundColor,
                side: style.border,
                padding: outlinePadding,
                shape: shape,
                textStyle: style.textStyle,
                minimumSize: minimumSize,
              ).copyWith(
                padding: WidgetStateProperty.all(outlinePadding),
                backgroundColor: style.backgroundColor != null
                    ? WidgetStateProperty.all(style.backgroundColor)
                    : null,
              ),
          child: buttonChild,
        );

      case ButtonVariant.secondary:
        // Match primary's ElevatedButton layout so height/padding behave the
        // same; TextButton uses different default metrics even with the same
        // explicit padding.
        return ElevatedButton(
          onPressed: pressedCallback,
          style: ElevatedButton.styleFrom(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.textColor,
            disabledBackgroundColor: buttonTheme.disabledBackgroundColor,
            disabledForegroundColor: buttonTheme.disabledForegroundColor,
            elevation: 0,
            shadowColor: Colors.transparent,
            padding: style.padding,
            shape: shape,
            textStyle: style.textStyle,
            minimumSize: minimumSize,
          ),
          child: buttonChild,
        );

      case ButtonVariant.circularIcon:
        return Container(
          width: style.width ?? 40,
          height: style.height ?? 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: style.backgroundColor,
            border: style.border != null
                ? Border.fromBorderSide(style.border!)
                : null,
          ),
          child: Center(
            child: isLoading
                ? child
                : IconButton(
                    icon: child,
                    onPressed: pressedCallback,
                    iconSize: style.iconSize ?? 20.0,
                    padding: EdgeInsets.zero,
                  ),
          ),
        );

      case ButtonVariant.textBasic:
      case ButtonVariant.textWithIcon:
      case ButtonVariant.textColored:
        return TextButton(
          onPressed: pressedCallback,
          style: TextButton.styleFrom(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.textColor,
            disabledForegroundColor: buttonTheme.disabledForegroundColor,
            padding: style.padding,
            textStyle: style.textStyle,
            minimumSize: minimumSize,
          ),
          child: buttonChild,
        );

      case ButtonVariant.textUnderlined:
        return TextButton(
          onPressed: pressedCallback,
          style: TextButton.styleFrom(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.textColor,
            disabledForegroundColor: buttonTheme.disabledForegroundColor,
            padding: style.padding,
            textStyle:
                style.textStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ) ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
            minimumSize: minimumSize,
          ),
          child: buttonChild,
        );
    }
  }
}

/// Button variants supported by [AppButton]
enum ButtonVariant {
  /// Elevated primary action button
  primary,

  /// Low-emphasis secondary button
  secondary,

  /// Secondary button with an outline
  outlinedSecondary,

  /// Outlined button style
  outline,

  /// Circular icon button (uses IconButton underneath)
  circularIcon,

  /// Basic text button
  textBasic,

  /// Text button with an icon
  textWithIcon,

  /// Underlined text button
  textUnderlined,

  /// Text button with custom color
  textColored,
}

/// Per-instance styling overrides for [AppButton].
///
/// Non-null fields win over the variant defaults from [AppButtonTheme].
class AppButtonStyle {
  /// Background color of the button
  final Color? backgroundColor;

  /// Color for text and icons
  final Color? textColor;

  /// Elevation for Material buttons
  final double? elevation;

  /// Padding inside the button
  final EdgeInsets? padding;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Border styling for outlined buttons
  final BorderSide? border;

  /// Margin around the button
  final EdgeInsets? margin;

  /// Explicit width of the button
  final double? width;

  /// Explicit height of the button
  final double? height;

  /// Text style for button text
  final TextStyle? textStyle;

  /// Size for icons
  final double? iconSize;

  /// Duration for animations
  final Duration? animationDuration;

  /// Custom shadow styling (its color is used as the elevation shadow color)
  final BoxShadow? shadow;

  /// Whether the button should appear disabled
  final bool? disabled;

  /// Icon data for icon buttons
  final IconData? iconData;

  const AppButtonStyle({
    this.backgroundColor,
    this.textColor,
    this.elevation,
    this.padding,
    this.borderRadius,
    this.border,
    this.margin,
    this.width,
    this.height,
    this.textStyle,
    this.iconSize,
    this.animationDuration,
    this.shadow,
    this.disabled,
    this.iconData,
  });

  AppButtonStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    EdgeInsets? padding,
    double? borderRadius,
    BorderSide? border,
    EdgeInsets? margin,
    double? width,
    double? height,
    TextStyle? textStyle,
    double? iconSize,
    Duration? animationDuration,
    BoxShadow? shadow,
    bool? disabled,
    IconData? iconData,
  }) {
    return AppButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      margin: margin ?? this.margin,
      width: width ?? this.width,
      height: height ?? this.height,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      animationDuration: animationDuration ?? this.animationDuration,
      shadow: shadow ?? this.shadow,
      disabled: disabled ?? this.disabled,
      iconData: iconData ?? this.iconData,
    );
  }
}

/// Tablet-sized chrome: the 600–950 logical-pixel bucket, plus large tablets
/// (shortest side ≤ 1024) that fall into the desktop bucket.
bool _isTabletFormFactor(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final classificationWidth =
      kIsWeb ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux
      ? size.width
      : size.shortestSide;
  if (classificationWidth >= 950) return size.shortestSide <= 1024;
  return classificationWidth >= 600;
}
