  import 'dart:io' show Platform;

  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  /// A cross-platform button widget that adapts to iOS and Android platforms
  /// Provides multiple button variants with platform-specific styling
  /// Follows composition-over-inheritance principle with ButtonStyle

  /// A platform-adaptive button widget with multiple style variants
  ///
  /// CommonButton provides a unified API for creating buttons that adapt to
  /// the current platform (iOS or Android) with appropriate styling and behavior.
  /// It supports multiple visual variants through factory constructors.
  ///
  /// Usage examples:
  /// ```dart
  /// // Primary button
  /// CommonButton.primary(
  ///   text: 'Continue',
  ///   onPressed: () => print('Pressed!'),
  /// )
  ///
  /// // Circular icon button
  /// CommonButton.circularIcon(
  ///   icon: Icons.add,
  ///   onPressed: () => print('Add pressed'),
  /// )
  ///
  /// // Text button
  /// CommonButton.text(
  ///   text: 'Learn More',
  ///   onPressed: () => print('Learn more pressed'),
  /// )
  /// ```
  class CommonButton extends StatelessWidget {
    /// Private constructor - forces use of factory constructors
    const CommonButton._({
      required this.text,
      required this.onPressed,
      required this.variant,
      this.isLoading = false,
      this.prefix,
      this.suffix,
      this.width,
      this.height,
      this.style,
    });

    // Button properties
    final String text;
    final VoidCallback? onPressed;
    final ButtonVariant variant;
    final bool isLoading;
    final Widget? prefix;
    final Widget? suffix;
    final double? width;
    final double? height;
    final ButtonStyle? style;

    // Factory constructor for primary button
    factory CommonButton.primary({
      required String text,
      required VoidCallback? onPressed,
      bool isLoading = false,
      bool elevated = true,
      Color? backgroundColor,
      Widget? prefix,
      Widget? suffix,
      double? width,
      double? height,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: backgroundColor,
              elevation: elevated ? 2.0 : 0.0,
            ) ??
            ButtonStyle(
              backgroundColor: backgroundColor,
              elevation: elevated ? 2.0 : 0.0,
            ),
        variant: ButtonVariant.primary,
      );
    }

    // Factory constructor for secondary button
    factory CommonButton.secondary({
      required String text,
      required VoidCallback? onPressed,
      bool outlined = false,
      Color? customColor,
      bool isLoading = false,
      Widget? prefix,
      Widget? suffix,
      double? width,
      double? height,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: outlined ? Colors.transparent : Colors.grey[200],
              textColor: customColor,
              border:
                  outlined ? BorderSide(color: customColor ?? Colors.grey) : null,
            ) ??
            ButtonStyle(
              backgroundColor: outlined ? Colors.transparent : Colors.grey[200],
              textColor: customColor,
              border:
                  outlined ? BorderSide(color: customColor ?? Colors.grey) : null,
            ),
        variant:
            outlined ? ButtonVariant.outlinedSecondary : ButtonVariant.secondary,
      );
    }

    // Factory constructor for outline button
    factory CommonButton.outline({
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
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              border: BorderSide(
                  color: borderColor ?? Colors.grey, width: borderWidth),
            ) ??
            ButtonStyle(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              border: BorderSide(
                  color: borderColor ?? Colors.grey, width: borderWidth),
            ),
        variant: ButtonVariant.outline,
      );
    }

    // Factory constructor for circular icon button
    factory CommonButton.circularIcon({
      required IconData icon,
      required VoidCallback? onPressed,
      Color? backgroundColor,
      Color? iconColor,
      Color? borderColor,
      double size = 40,
      bool isLoading = false,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: '', // Icon button doesn't need text
        onPressed: onPressed,
        isLoading: isLoading,
        width: size,
        height: size,
        style: style?.copyWith(
              backgroundColor: backgroundColor,
              textColor: iconColor,
              border: BorderSide(color: borderColor ?? Colors.transparent),
              borderRadius: size / 2,
              iconSize: size * 0.5,
              iconData: icon,
            ) ??
            ButtonStyle(
              backgroundColor: backgroundColor,
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
    factory CommonButton.text({
      required String text,
      required VoidCallback? onPressed,
      Color? textColor,
      bool isLoading = false,
      Widget? prefix,
      Widget? suffix,
      double? width,
      double? height,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: Colors.transparent,
              textColor: textColor,
            ) ??
            ButtonStyle(
              backgroundColor: Colors.transparent,
              textColor: textColor,
            ),
        variant: ButtonVariant.textBasic,
      );
    }

    // Factory constructor for text button with icon
    factory CommonButton.textWithIcon({
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
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: iconLeading ? Icon(icon, size: iconSize, color: iconColor) : null,
        suffix:
            !iconLeading ? Icon(icon, size: iconSize, color: iconColor) : null,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              iconSize: iconSize,
            ) ??
            ButtonStyle(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              iconSize: iconSize,
            ),
        variant: ButtonVariant.textWithIcon,
      );
    }

    // Factory constructor for underlined text button
    factory CommonButton.textUnderlined({
      required String text,
      required VoidCallback? onPressed,
      Color? textColor,
      bool isLoading = false,
      Widget? prefix,
      Widget? suffix,
      double? width,
      double? height,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              textStyle: TextStyle(
                decoration: TextDecoration.underline,
                color: textColor,
              ),
            ) ??
            ButtonStyle(
              backgroundColor: Colors.transparent,
              textColor: textColor,
              textStyle: TextStyle(
                decoration: TextDecoration.underline,
                color: textColor,
              ),
            ),
        variant: ButtonVariant.textUnderlined,
      );
    }

    // Factory constructor for colored text button
    factory CommonButton.textColored({
      required String text,
      required VoidCallback? onPressed,
      required Color textColor,
      Color? backgroundColor,
      bool isLoading = false,
      Widget? prefix,
      Widget? suffix,
      double? width,
      double? height,
      ButtonStyle? style,
    }) {
      return CommonButton._(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
        prefix: prefix,
        suffix: suffix,
        width: width,
        height: height,
        style: style?.copyWith(
              backgroundColor: backgroundColor ?? Colors.transparent,
              textColor: textColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ) ??
            ButtonStyle(
              backgroundColor: backgroundColor ?? Colors.transparent,
              textColor: textColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
        variant: ButtonVariant.textColored,
      );
    }

    @override
    Widget build(BuildContext context) {
      final isDisabled = onPressed == null;
      final effectiveStyle = _getEffectiveStyle(context, isDisabled);

      Widget buttonChild;

      // Special handling for circular icon button
      if (variant == ButtonVariant.circularIcon) {
        buttonChild = isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveStyle.textColor ?? Colors.white,
                  ),
                ),
              )
            : Icon(
                style?.iconData ?? Icons.add,
                color: effectiveStyle.textColor,
                size: effectiveStyle.iconSize,
              );
      }
      // Standard handling for text-based buttons
      else {
        buttonChild = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) ...[
              prefix!,
              const SizedBox(width: 8),
            ],
            if (isLoading)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveStyle.textColor ?? Colors.white,
                  ),
                ),
              )
            else
              Text(
                text,
                style: effectiveStyle.textStyle,
              ),
            if (suffix != null) ...[
              const SizedBox(width: 8),
              suffix!,
            ],
          ],
        );
      }

      // Container to apply animations and sizing
      final container = AnimatedContainer(
        duration:
            effectiveStyle.animationDuration ?? const Duration(milliseconds: 200),
        width: width ?? effectiveStyle.width,
        height: height ?? effectiveStyle.height,
        child: _buildButtonByVariant(context, effectiveStyle, buttonChild),
      );

      // Apply margin if specified
      if (effectiveStyle.margin != null) {
        return Padding(
          padding: effectiveStyle.margin!,
          child: container,
        );
      }

      return container;
    }

    ButtonStyle _getEffectiveStyle(BuildContext context, bool isDisabled) {
      final theme = Theme.of(context);
      // Start with default style based on variant and platform
      ButtonStyle defaultStyle;

      // Get the primary color based on platform
      final primaryColor =
          Platform.isIOS ? CupertinoColors.systemBlue : theme.primaryColor;

      switch (variant) {
        case ButtonVariant.primary:
          defaultStyle = ButtonStyle(
            backgroundColor: primaryColor,
            textColor: Colors.white,
            elevation:
                Platform.isIOS ? 0.0 : 2.0, // iOS buttons don't have elevation
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            borderRadius: Platform.isIOS
                ? 10.0
                : 8.0, // iOS uses slightly more rounded corners
            textStyle: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.secondary:
        case ButtonVariant.outlinedSecondary:
          defaultStyle = ButtonStyle(
            backgroundColor: variant == ButtonVariant.secondary
                ? (Platform.isIOS
                    ? CupertinoColors.systemGrey5
                    : Colors.grey[200])
                : Colors.transparent,
            textColor: primaryColor,
            border: variant == ButtonVariant.outlinedSecondary
                ? BorderSide(color: primaryColor)
                : null,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            borderRadius: Platform.isIOS ? 10.0 : 8.0,
            textStyle: theme.textTheme.labelLarge,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.outline:
          defaultStyle = ButtonStyle(
            backgroundColor: Colors.transparent,
            textColor: primaryColor,
            border: BorderSide(color: primaryColor),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            borderRadius: Platform.isIOS ? 10.0 : 8.0,
            textStyle: theme.textTheme.labelLarge,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.circularIcon:
          defaultStyle = ButtonStyle(
            backgroundColor: Platform.isIOS
                ? CupertinoColors.systemGrey6
                : const Color(0xFF2A2A2A),
            textColor: Platform.isIOS ? primaryColor : Colors.white,
            border: BorderSide(
                color: Platform.isIOS
                    ? CupertinoColors.systemGrey2
                    : primaryColor.withOpacity(0.3)),
            width: 40.0,
            height: 40.0,
            borderRadius: 20.0,
            iconSize: 20.0,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.textBasic:
          defaultStyle = ButtonStyle(
            backgroundColor: Colors.transparent,
            textColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            textStyle: theme.textTheme.bodyMedium,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.textWithIcon:
          defaultStyle = ButtonStyle(
            backgroundColor: Colors.transparent,
            textColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            textStyle: theme.textTheme.bodyMedium,
            iconSize: 16.0,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.textUnderlined:
          defaultStyle = ButtonStyle(
            backgroundColor: Colors.transparent,
            textColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            textStyle: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
            ),
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
        case ButtonVariant.textColored:
          defaultStyle = ButtonStyle(
            backgroundColor: Colors.transparent,
            textColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            textStyle: theme.textTheme.bodyMedium,
            animationDuration: const Duration(milliseconds: 200),
          );
          break;
      }

      // Apply custom style if provided
      final customizedStyle =
          style != null ? _mergeStyles(defaultStyle, style!) : defaultStyle;

      // Apply disabled style if button is disabled (platform-specific)
      if (isDisabled) {
        return customizedStyle.copyWith(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemGrey5 : Colors.grey[300],
          textColor:
              Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey[600],
          elevation: 0,
        );
      }

      return customizedStyle;
    }

    ButtonStyle _mergeStyles(ButtonStyle base, ButtonStyle override) {
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

    Widget _buildButtonByVariant(
        BuildContext context, ButtonStyle style, Widget child) {
      // Use platform-specific widgets based on platform
      if (Platform.isIOS) {
        return _buildCupertinoButton(style, child);
      } else {
        return _buildMaterialButton(context, style, child);
      }
    }

    Widget _buildCupertinoButton(ButtonStyle style, Widget child) {
      switch (variant) {
        case ButtonVariant.primary:
          return CupertinoButton.filled(
            onPressed: onPressed,
            padding: style.padding,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 8),
            child: child,
          );

        case ButtonVariant.outlinedSecondary:
        case ButtonVariant.outline:
        case ButtonVariant.secondary:
          return CupertinoButton(
            onPressed: onPressed,
            padding: style.padding,
            color:
                variant == ButtonVariant.secondary ? style.backgroundColor : null,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 8),
            child: Container(
              decoration: (variant == ButtonVariant.outlinedSecondary ||
                      variant == ButtonVariant.outline)
                  ? BoxDecoration(
                      border: Border.all(
                        color: style.border?.color ?? CupertinoColors.systemBlue,
                        width: style.border?.width ?? 1.0,
                      ),
                      borderRadius:
                          BorderRadius.circular(style.borderRadius ?? 8),
                    )
                  : null,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: child,
            ),
          );

        case ButtonVariant.circularIcon:
          // Use CupertinoButton for iOS with circular decoration
          return CupertinoButton(
            onPressed: onPressed,
            padding: EdgeInsets.zero,
            child: Container(
              width: style.width ?? 40,
              height: style.height ?? 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: style.backgroundColor,
                border: Border.all(
                  color: (style.border?.color ?? Colors.transparent),
                  width: style.border?.width ?? 1.0,
                ),
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            style.textColor ?? Colors.white,
                          ),
                        ),
                      )
                    : Icon(
                        style.iconData ?? Icons.add,
                        color: style.textColor,
                        size: style.iconSize,
                      ),
              ),
            ),
          );

        case ButtonVariant.textBasic:
        case ButtonVariant.textWithIcon:
        case ButtonVariant.textColored:
          return CupertinoButton(
            onPressed: onPressed,
            padding: style.padding,
            child: child,
          );

        case ButtonVariant.textUnderlined:
          return CupertinoButton(
            onPressed: onPressed,
            padding: style.padding,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: style.textColor ?? CupertinoColors.systemBlue,
                    width: 1.0,
                  ),
                ),
              ),
              child: child,
            ),
          );
      }
    }

    Widget _buildMaterialButton(
        BuildContext context, ButtonStyle style, Widget child) {
      switch (variant) {
        case ButtonVariant.primary:
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: style.backgroundColor,
              foregroundColor: style.textColor,
              elevation: style.elevation,
              padding: style.padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(style.borderRadius ?? 8),
              ),
              textStyle: style.textStyle,
            ),
            child: child,
          );

        case ButtonVariant.outlinedSecondary:
        case ButtonVariant.outline:
          return OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: style.textColor,
              side: style.border,
              padding: style.padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(style.borderRadius ?? 8),
              ),
              textStyle: style.textStyle,
            ),
            child: child,
          );

        case ButtonVariant.circularIcon:
          // Use IconButton directly wrapped in a container for styling
          return Container(
            width: style.width ?? 40,
            height: style.height ?? 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: style.backgroundColor,
              border: Border.all(
                color: (style.border?.color ?? Colors.transparent),
                width: style.border?.width ?? 1.0,
              ),
            ),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          style.textColor ?? Colors.white,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      style.iconData ?? Icons.add,
                      color: style.textColor,
                      size: style.iconSize,
                    ),
                    onPressed: onPressed,
                    iconSize: style.iconSize ?? 20.0,
                    padding: EdgeInsets.zero,
                  ),
          );

        case ButtonVariant.secondary:
        case ButtonVariant.textBasic:
        case ButtonVariant.textWithIcon:
        case ButtonVariant.textColored:
          return TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: style.backgroundColor,
              foregroundColor: style.textColor,
              padding: style.padding,
              textStyle: style.textStyle,
            ),
            child: child,
          );

        case ButtonVariant.textUnderlined:
          return TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: style.backgroundColor,
              foregroundColor: style.textColor,
              padding: style.padding,
              textStyle: style.textStyle?.copyWith(
                    decoration: TextDecoration.underline,
                  ) ??
                  const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
            ),
            child: child,
          );
      }
    }
  }

  /// Button variants supported by CommonButton
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

  /// Styling configuration for CommonButton
  /// Uses composition pattern to configure button appearance
  class ButtonStyle {
    /// Background color of the button
    final Color? backgroundColor;

    /// Color for text and icons
    final Color? textColor;

    /// Elevation for Material buttons (ignored on iOS)
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

    /// Custom shadow styling
    final BoxShadow? shadow;

    /// Whether the button should appear disabled
    final bool? disabled;

    /// Icon data for icon buttons
    final IconData? iconData;

    const ButtonStyle({
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

    ButtonStyle copyWith({
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
      return ButtonStyle(
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
