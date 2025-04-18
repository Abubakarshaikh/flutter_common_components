import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  /// Private constructor - forces use of factory constructors
  const CommonTextField._({
    super.key,
    required this.variant,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.helperText,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.customStyle,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.enabled = true,
    this.showCursor,
    this.autofillHints,
    this.borderRadius,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.filled,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.textAlignVertical,
    this.onEditingComplete,
    this.onTapOutside,
  });

  // Basic properties
  final TextFieldVariant variant;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final String? errorText;

  // Decoration properties
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;

  // Text properties
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextFieldStyle? customStyle;

  // Advanced properties
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool? showCursor;
  final Iterable<String>? autofillHints;
  final double? borderRadius;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final TextAlign textAlign;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  /// Factory constructor for standard text field
  factory CommonTextField.standard({
    Key? key,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    String? suffixText,
    int? maxLines = 1,
    int? minLines,
    bool autofocus = false,
    bool autocorrect = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool? showCursor,
    Iterable<String>? autofillHints,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: TextFieldVariant.standard,
      controller: controller,
      keyboardType: keyboardType,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixText: prefixText,
      suffixText: suffixText,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      showCursor: showCursor,
      autofillHints: autofillHints,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for outlined text field
  factory CommonTextField.outlined({
    Key? key,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    String? suffixText,
    int? maxLines = 1,
    int? minLines,
    bool autofocus = false,
    bool autocorrect = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool? showCursor,
    Iterable<String>? autofillHints,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: TextFieldVariant.outlined,
      controller: controller,
      keyboardType: keyboardType,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixText: prefixText,
      suffixText: suffixText,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      showCursor: showCursor,
      autofillHints: autofillHints,
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: filled,
      fillColor: fillColor,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for filled text field
  factory CommonTextField.filled({
    Key? key,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    String? suffixText,
    int? maxLines = 1,
    int? minLines,
    bool autofocus = false,
    bool autocorrect = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool? showCursor,
    Iterable<String>? autofillHints,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    TextAlign textAlign = TextAlign.start,
    Color? cursorColor,
    TextAlignVertical? textAlignVertical,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: TextFieldVariant.filled,
      controller: controller,
      keyboardType: keyboardType,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixText: prefixText,
      suffixText: suffixText,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      showCursor: showCursor,
      autofillHints: autofillHints,
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: true,
      fillColor: fillColor,
      textAlign: textAlign,
      cursorColor: cursorColor,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for password field
  factory CommonTextField.password({
    Key? key,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    Iterable<String>? autofillHints,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    TextAlign textAlign = TextAlign.start,
    TextFieldVariant variant = TextFieldVariant.standard,
    Color? cursorColor,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: variant,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      obscureText: true,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      autofillHints: autofillHints ?? const [AutofillHints.password],
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: filled,
      fillColor: fillColor,
      textAlign: textAlign,
      cursorColor: cursorColor,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for search field
  factory CommonTextField.search({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int? maxLength,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction = TextInputAction.search,
    bool enabled = true,
    bool? showCursor,
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: TextFieldVariant.search,
      controller: controller,
      keyboardType: TextInputType.text,
      hintText: hintText ?? 'Search',
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      prefixIcon: prefixIcon ?? const Icon(Icons.search),
      suffixIcon: suffixIcon,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      showCursor: showCursor,
      filled: true,
      borderRadius: borderRadius ?? 24.0, // Rounded search field by default
      contentPadding: contentPadding,
      fillColor: fillColor,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for multiline text field
  factory CommonTextField.multiline({
    Key? key,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int maxLines = 5,
    int? minLines = 3,
    bool autofocus = false,
    bool autocorrect = true,
    TextCapitalization textCapitalization = TextCapitalization.sentences,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction = TextInputAction.newline,
    bool enabled = true,
    bool? showCursor,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical = TextAlignVertical.top,
    TextFieldVariant variant = TextFieldVariant.outlined,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: variant,
      controller: controller,
      keyboardType: TextInputType.multiline,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      showCursor: showCursor,
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding ?? const EdgeInsets.all(16),
      filled: filled,
      fillColor: fillColor,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for phone number field with formatting
  factory CommonTextField.phone({
    Key? key,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool autofocus = false,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    TextFieldVariant variant = TextFieldVariant.standard,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: variant,
      controller: controller,
      keyboardType: TextInputType.phone,
      labelText: labelText ?? 'Phone',
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
            // Add specific phone formatters here like:
            // PhoneNumberTextInputFormatter(), // Implement your custom formatter
          ],
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon ?? const Icon(Icons.phone),
      suffixIcon: suffixIcon,
      autofocus: autofocus,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      autofillHints: const [AutofillHints.telephoneNumber],
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: filled,
      fillColor: fillColor,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for email field
  factory CommonTextField.email({
    Key? key,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool autofocus = false,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    TextFieldVariant variant = TextFieldVariant.standard,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: variant,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      labelText: labelText ?? 'Email',
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon ?? const Icon(Icons.email),
      suffixIcon: suffixIcon,
      autofocus: autofocus,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      autofillHints: const [AutofillHints.email],
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: filled,
      fillColor: fillColor,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  /// Factory constructor for number field
  factory CommonTextField.number({
    Key? key,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    String? helperText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    void Function(String)? onChanged,
    bool readOnly = false,
    void Function()? onTap,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool autofocus = false,
    TextStyle? style,
    TextFieldStyle? customStyle,
    void Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    double? borderRadius,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool? filled,
    Color? fillColor,
    bool allowDecimal = false,
    bool allowNegative = false,
    TextFieldVariant variant = TextFieldVariant.standard,
    void Function()? onEditingComplete,
    void Function(PointerDownEvent)? onTapOutside,
  }) {
    return CommonTextField._(
      key: key,
      variant: variant,
      controller: controller,
      keyboardType: allowDecimal
          ? const TextInputType.numberWithOptions(decimal: true, signed: true)
          : TextInputType.number,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      inputFormatters: inputFormatters ??
          [
            if (!allowDecimal) FilteringTextInputFormatter.digitsOnly,
            if (allowDecimal && !allowNegative)
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            if (allowDecimal && allowNegative)
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$')),
          ],
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      autofocus: autofocus,
      style: style,
      customStyle: customStyle,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      enabled: enabled,
      borderRadius: borderRadius,
      floatingLabelBehavior: floatingLabelBehavior,
      contentPadding: contentPadding,
      filled: filled,
      fillColor: fillColor,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
    );
  }

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool _obscured;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get effective style based on platform and variant
    final effectiveStyle = _getEffectiveStyle(context);

    // Handle platform-specific implementation
    if (Platform.isIOS) {
      return _buildCupertinoTextField(effectiveStyle);
    } else {
      return _buildMaterialTextField(effectiveStyle);
    }
  }

  TextFieldStyle _getEffectiveStyle(BuildContext context) {
    final theme = Theme.of(context);

    // Start with default style based on variant and platform
    TextFieldStyle defaultStyle;

    // Get the primary color based on platform
    final primaryColor =
        Platform.isIOS ? CupertinoColors.systemBlue : theme.primaryColor;

    switch (widget.variant) {
      case TextFieldVariant.standard:
        defaultStyle = TextFieldStyle(
          borderRadius: Platform.isIOS ? 8.0 : 4.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: false,
          cursorColor: primaryColor,
          textStyle: theme.textTheme.bodyMedium,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderColor:
              Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
          focusedBorderColor: primaryColor,
          errorBorderColor: Colors.red,
          fillColor: Colors.transparent,
          iconColor: theme.iconTheme.color,
          placeholderStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderWidth: 1.0,
          focusedBorderWidth: 2.0,
        );
        break;
      case TextFieldVariant.outlined:
        defaultStyle = TextFieldStyle(
          borderRadius: Platform.isIOS ? 8.0 : 4.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: false,
          cursorColor: primaryColor,
          textStyle: theme.textTheme.bodyMedium,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderColor:
              Platform.isIOS ? CupertinoColors.systemGrey : Colors.grey,
          focusedBorderColor: primaryColor,
          errorBorderColor: Colors.red,
          fillColor: Colors.transparent,
          iconColor: theme.iconTheme.color,
          placeholderStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderWidth: 1.0,
          focusedBorderWidth: 2.0,
        );
        break;
      case TextFieldVariant.filled:
        defaultStyle = TextFieldStyle(
          borderRadius: Platform.isIOS ? 8.0 : 4.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          cursorColor: primaryColor,
          textStyle: theme.textTheme.bodyMedium,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderColor: Colors.transparent,
          focusedBorderColor: primaryColor,
          errorBorderColor: Colors.red,
          fillColor:
              Platform.isIOS ? CupertinoColors.systemGrey6 : Colors.grey[200],
          iconColor: theme.iconTheme.color,
          placeholderStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderWidth: 0.0,
          focusedBorderWidth: 1.0,
        );
        break;
      case TextFieldVariant.search:
        defaultStyle = TextFieldStyle(
          borderRadius: 24.0, // Rounded corners for search
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          cursorColor: primaryColor,
          textStyle: theme.textTheme.bodyMedium,
          borderColor: Colors.transparent,
          focusedBorderColor: primaryColor,
          errorBorderColor: Colors.red,
          fillColor:
              Platform.isIOS ? CupertinoColors.systemGrey6 : Colors.grey[200],
          iconColor: theme.iconTheme.color,
          placeholderStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
          ),
          borderWidth: 0.0,
          focusedBorderWidth: 0.0,
        );
        break;
    }

    // Apply custom style if provided
    return widget.customStyle != null
        ? _mergeStyles(defaultStyle, widget.customStyle!)
        : defaultStyle;
  }

  TextFieldStyle _mergeStyles(TextFieldStyle base, TextFieldStyle override) {
    return base.copyWith(
      borderRadius: override.borderRadius,
      contentPadding: override.contentPadding,
      floatingLabelBehavior: override.floatingLabelBehavior,
      filled: override.filled,
      fillColor: override.fillColor,
      textStyle: override.textStyle,
      labelStyle: override.labelStyle,
      helperStyle: override.helperStyle,
      errorStyle: override.errorStyle,
      placeholderStyle: override.placeholderStyle,
      borderColor: override.borderColor,
      focusedBorderColor: override.focusedBorderColor,
      errorBorderColor: override.errorBorderColor,
      cursorColor: override.cursorColor,
      iconColor: override.iconColor,
      borderWidth: override.borderWidth,
      focusedBorderWidth: override.focusedBorderWidth,
    );
  }

  Widget _buildCupertinoTextField(TextFieldStyle style) {
    // Build a Cupertino-styled text field for iOS
    final CupertinoTextField field = CupertinoTextField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: BoxDecoration(
        color: style.filled == true ? style.fillColor : null,
        borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
        border: Border.all(
          color: widget.errorText != null
              ? style.errorBorderColor ?? CupertinoColors.systemRed
              : style.borderColor ?? CupertinoColors.systemGrey,
          width: style.borderWidth ?? 1.0,
        ),
      ),
      padding: style.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      placeholder: widget.hintText,
      placeholderStyle: style.placeholderStyle,
      prefix: widget.prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.prefixIcon,
            )
          : widget.prefixText != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.prefixText!),
                )
              : null,
      suffix: widget.obscureText
          ? GestureDetector(
              onTap: _toggleObscured,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  _obscured ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                  color: style.iconColor,
                ),
              ),
            )
          : widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: widget.suffixIcon,
                )
              : widget.suffixText != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(widget.suffixText!),
                    )
                  : null,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      autocorrect: widget.autocorrect,
      textCapitalization: widget.textCapitalization,
      style: style.textStyle,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      autofocus: widget.autofocus,
      showCursor: widget.showCursor,
      cursorColor: style.cursorColor,
      textAlign: widget.textAlign,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      onEditingComplete: widget.onEditingComplete,
    );

    // Add error text if provided
    if (widget.errorText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          field,
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.errorText!,
              style: style.errorStyle ??
                  const TextStyle(
                      color: CupertinoColors.systemRed, fontSize: 12),
            ),
          ),
        ],
      );
    }

    // Add label if provided
    if (widget.labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: style.labelStyle,
            ),
          ),
          field,
          if (widget.helperText != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 4.0),
              child: Text(
                widget.helperText!,
                style: style.helperStyle ??
                    const TextStyle(
                        color: CupertinoColors.systemGrey, fontSize: 12),
              ),
            ),
        ],
      );
    }

    return field;
  }

  Widget _buildMaterialTextField(TextFieldStyle style) {
    // Build a Material-styled text field for Android
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: style.iconColor,
                ),
                onPressed: _toggleObscured,
              )
            : widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        contentPadding: style.contentPadding,
        filled: style.filled,
        fillColor: style.fillColor,
        errorStyle: style.errorStyle,
        labelStyle: style.labelStyle,
        hintStyle: style.placeholderStyle,
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? style.floatingLabelBehavior,
        border: _buildBorder(style),
        enabledBorder: _buildBorder(style),
        focusedBorder: _buildFocusedBorder(style),
        errorBorder: _buildErrorBorder(style),
        focusedErrorBorder: _buildErrorBorder(style),
      ),
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      maxLength: widget.maxLength,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      autocorrect: widget.autocorrect,
      textCapitalization: widget.textCapitalization,
      style: style.textStyle,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      autofocus: widget.autofocus,
      showCursor: widget.showCursor,
      cursorColor: style.cursorColor,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: widget.onTapOutside,
    );
  }

  InputBorder _buildBorder(TextFieldStyle style) {
    final radius =
        BorderRadius.circular(widget.borderRadius ?? style.borderRadius ?? 4.0);

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.borderColor ?? Colors.grey,
            width: style.borderWidth ?? 1.0,
          ),
        );
      case TextFieldVariant.filled:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        );
      case TextFieldVariant.search:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        );
      case TextFieldVariant.standard:
      default:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: style.borderColor ?? Colors.grey,
            width: style.borderWidth ?? 1.0,
          ),
        );
    }
  }

  InputBorder _buildFocusedBorder(TextFieldStyle style) {
    final radius =
        BorderRadius.circular(widget.borderRadius ?? style.borderRadius ?? 4.0);

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.focusedBorderColor ?? Colors.blue,
            width: style.focusedBorderWidth ?? 2.0,
          ),
        );
      case TextFieldVariant.filled:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.focusedBorderColor ?? Colors.blue,
            width: style.focusedBorderWidth ?? 1.0,
          ),
        );
      case TextFieldVariant.search:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.focusedBorderColor ?? Colors.blue,
            width: style.focusedBorderWidth ?? 0.0,
          ),
        );
      case TextFieldVariant.standard:
      default:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: style.focusedBorderColor ?? Colors.blue,
            width: style.focusedBorderWidth ?? 2.0,
          ),
        );
    }
  }

  InputBorder _buildErrorBorder(TextFieldStyle style) {
    final radius =
        BorderRadius.circular(widget.borderRadius ?? style.borderRadius ?? 4.0);

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.errorBorderColor ?? Colors.red,
            width: style.focusedBorderWidth ?? 2.0,
          ),
        );
      case TextFieldVariant.filled:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.errorBorderColor ?? Colors.red,
            width: style.focusedBorderWidth ?? 1.0,
          ),
        );
      case TextFieldVariant.search:
        return OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: style.errorBorderColor ?? Colors.red,
            width: style.focusedBorderWidth ?? 1.0,
          ),
        );
      case TextFieldVariant.standard:
      default:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: style.errorBorderColor ?? Colors.red,
            width: style.focusedBorderWidth ?? 2.0,
          ),
        );
    }
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
}

/// Uses composition pattern to configure text field appearance
class TextFieldStyle {
  /// Border radius for rounded corners
  final double? borderRadius;

  /// Content padding inside the field
  final EdgeInsetsGeometry? contentPadding;

  /// How the label should behave when focused
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Whether the field should have a filled background
  final bool? filled;

  /// Background fill color
  final Color? fillColor;

  /// Default text style for input
  final TextStyle? textStyle;

  /// Style for label text
  final TextStyle? labelStyle;

  /// Style for helper text
  final TextStyle? helperStyle;

  /// Style for error text
  final TextStyle? errorStyle;

  /// Style for placeholder/hint text
  final TextStyle? placeholderStyle;

  /// Border color in normal state
  final Color? borderColor;

  /// Border color when focused
  final Color? focusedBorderColor;

  /// Border color when error
  final Color? errorBorderColor;

  /// Color for cursor
  final Color? cursorColor;

  /// Color for icons
  final Color? iconColor;

  /// Border width
  final double? borderWidth;

  /// Focused border width
  final double? focusedBorderWidth;

  const TextFieldStyle({
    this.borderRadius,
    this.contentPadding,
    this.floatingLabelBehavior,
    this.filled,
    this.fillColor,
    this.textStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.placeholderStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.cursorColor,
    this.iconColor,
    this.borderWidth,
    this.focusedBorderWidth,
  });

  TextFieldStyle copyWith({
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    FloatingLabelBehavior? floatingLabelBehavior,
    bool? filled,
    Color? fillColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextStyle? placeholderStyle,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? cursorColor,
    Color? iconColor,
    double? borderWidth,
    double? focusedBorderWidth,
  }) {
    return TextFieldStyle(
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      floatingLabelBehavior:
          floatingLabelBehavior ?? this.floatingLabelBehavior,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      cursorColor: cursorColor ?? this.cursorColor,
      iconColor: iconColor ?? this.iconColor,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
    );
  }
}

/// Text field variants supported by CommonTextField
enum TextFieldVariant {
  /// Standard text field with underline
  standard,

  /// Outlined text field with border
  outlined,

  /// Filled text field with background color
  filled,

  /// Search field with rounded corners
  search,
}
