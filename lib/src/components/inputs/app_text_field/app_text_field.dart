import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import 'app_text_field_theme.dart';

/// Main public widget for app text field.
///
/// Title layout belongs on FieldWrapper. Pass [maxLength],
/// [buildCounter], and [inputFormatters] from the caller when a
/// remaining-character counter is needed:
/// `RemainingCharCounter().formatters(context, maxLength: ...)`.
///
/// Prefer a named variant:
/// * [AppTextField.text] — starts one line tall (name, title, city).
/// * [AppTextField.email] — an email address.
/// * [AppTextField.phone] — a phone number.
/// * [AppTextField.search] — a search query.
/// * [AppTextField.temperature] — a temperature value.
/// * [AppTextField.time] — a time in HH:MM.
/// * [AppTextField.multiline] — starts several lines tall (description,
///   remarks).
///
/// Long text always wraps and the field grows vertically. It never
/// scrolls sideways. Pass [maxLines] only to cap height.
///
/// Colors, radius, padding and font sizes come from [AppTextFieldTheme]
/// (per-instance [style], then the ambient `ThemeData.extensions`, then the
/// [ColorScheme]). Explicit params such as [borderColor] win over all.
///
/// ```dart
/// AppTextField.text(
///   controller: nameController,
///   hint: 'Name',
///   validation: (v) => (v ?? '').isEmpty ? 'Required' : null,
/// )
/// ```
class AppTextField extends StatelessWidget {
  final String? hint, suffixString;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validation;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon, prefixWidget;
  final int? minLines;
  final int? maxLines;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool enabled, read, autofocus;

  final Color? textColor;
  final Color? hintColor;
  final double? fontSize;
  final double? hintFontSize;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final Color? fillColor;
  final bool? filled;
  final bool showBorder;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? border;
  final BoxConstraints? prefixIconConstraints;
  final Color? cursorColor;
  final int errorMaxLines;
  final TextStyle? errorStyle;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;

  /// Per-instance style; merged over the ambient [AppTextFieldTheme].
  final AppTextFieldTheme? style;

  const AppTextField({
    super.key,
    this.hint,
    this.onTap,
    this.onTapOutside,
    this.prefixWidget,
    this.onChanged,
    this.controller,
    this.validation,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
    this.enabled = true,
    this.autofocus = false,
    this.textInputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.read = false,
    this.focusNode,
    this.suffixString,
    this.textColor,
    this.hintColor,
    this.fontSize,
    this.hintFontSize,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.filled,
    this.showBorder = true,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.border,
    this.prefixIconConstraints,
    this.cursorColor,
    this.errorMaxLines = 3,
    this.errorStyle,
    this.maxLength,
    this.buildCounter,
    this.style,
  });

  /// Starts one line tall (name, title, city). Long text wraps and the
  /// field grows vertically instead of scrolling sideways.
  factory AppTextField.text({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    String? suffixString,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      suffixString: suffixString,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Email address. Uses the email keyboard.
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Phone number. Uses the phone keyboard.
  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputType: TextInputType.phone,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Search field. Uses the search keyboard action.
  factory AppTextField.search({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputAction: TextInputAction.search,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Temperature. Uses a signed decimal keyboard.
  factory AppTextField.temperature({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Time in HH:MM. Uses a numeric keyboard.
  factory AppTextField.time({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      textInputType: const TextInputType.numberWithOptions(decimal: false),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
      minLines: 1,
    );
  }

  /// Description or remarks. Empty state is already several lines tall
  /// and the field keeps growing as text wraps.
  factory AppTextField.multiline({
    Key? key,
    TextEditingController? controller,
    String? hint,
    String? Function(String?)? validation,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    TapRegionCallback? onTapOutside,
    int minLines = 3,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    Widget? prefixWidget,
    String? suffixString,
    bool enabled = true,
    bool read = false,
    bool autofocus = false,
    FocusNode? focusNode,
    Color? textColor,
    Color? hintColor,
    double? fontSize,
    double? hintFontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.start,
    Color? fillColor,
    bool? filled,
    bool showBorder = true,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? disabledBorder,
    OutlineInputBorder? border,
    BoxConstraints? prefixIconConstraints,
    int? maxLength,
    InputCounterWidgetBuilder? buildCounter,
    AppTextFieldTheme? style,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hint: hint,
      validation: validation,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      minLines: minLines,
      textInputType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      suffixString: suffixString,
      enabled: enabled,
      read: read,
      autofocus: autofocus,
      focusNode: focusNode,
      textColor: textColor,
      hintColor: hintColor,
      fontSize: fontSize,
      hintFontSize: hintFontSize,
      fontWeight: fontWeight,
      textAlign: textAlign,
      fillColor: fillColor,
      filled: filled,
      showBorder: showBorder,
      borderColor: borderColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
      border: border,
      prefixIconConstraints: prefixIconConstraints,
      maxLength: maxLength,
      buildCounter: buildCounter,
      style: style,
    );
  }

  TextStyle? _inputTextStyle(TextTheme textTheme, AppTextFieldTheme theme) =>
      textTheme.bodyMedium?.copyWith(
        color: textColor ?? theme.textColor,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? theme.fontSize,
      );

  InputBorder _resolveBorder(InputBorder? custom, InputBorder fallback) {
    return custom ?? fallback;
  }

  /// Wrap and grow unless the caller set an explicit [maxLines] cap.
  /// [maxLines] of 1 is the only way to get sideways scrolling.
  int? get _effectiveMaxLines => maxLines;

  /// Single-line-starting fields keep a text keyboard so Return does not
  /// insert a newline. Taller fields get the multiline keyboard.
  TextInputType get _effectiveKeyboardType {
    if (textInputType != null) return textInputType!;
    final tallerThanOneLine = minLines != null && minLines! > 1;
    return tallerThanOneLine ? TextInputType.multiline : TextInputType.text;
  }

  InputDecoration _createInputDecoration(
    TextTheme textTheme,
    AppTextFieldTheme theme,
  ) {
    final borderColor =
        this.borderColor ?? theme.borderColor ?? Colors.transparent;
    final errorColor = theme.errorColor;
    final borderRadius = BorderRadius.circular(
      this.borderRadius ?? theme.borderRadius ?? 12,
    );
    final fallbackBorder = showBorder
        ? OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: borderColor),
            borderRadius: borderRadius,
          )
        : InputBorder.none;
    final fallbackErrorBorder = showBorder
        ? OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: errorColor ?? Colors.transparent,
            ),
            borderRadius: borderRadius,
          )
        : InputBorder.none;

    return InputDecoration(
      contentPadding:
          contentPadding ??
          theme.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      filled: filled ?? true,
      fillColor: fillColor ?? theme.fillColor,
      errorStyle:
          errorStyle ??
          textTheme.labelSmall?.copyWith(color: errorColor, fontSize: 12),
      hintText: hint,
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: hintColor ?? theme.hintColor,
        fontWeight: FontWeight.w400,
        fontSize: hintFontSize ?? theme.hintFontSize,
      ),
      errorMaxLines: errorMaxLines,
      prefixIconConstraints: prefixIconConstraints,
      prefixIcon: prefixWidget,
      suffixIcon: suffixIcon,
      suffixText: suffixString,
      errorBorder: fallbackErrorBorder,
      enabledBorder: _resolveBorder(enabledBorder, fallbackBorder),
      focusedBorder: _resolveBorder(focusedBorder, fallbackBorder),
      disabledBorder: _resolveBorder(disabledBorder, fallbackBorder),
      border: _resolveBorder(border, fallbackBorder),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTextFieldTheme.of(context).merge(style);
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      buildCounter: buildCounter,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: read,
      autofocus: autofocus,
      onChanged: onChanged,
      textAlign: textAlign,
      onTap: onTap,
      onTapOutside: onTapOutside,
      style: _inputTextStyle(textTheme, theme),
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: _effectiveKeyboardType,
      textCapitalization: textCapitalization,
      cursorColor: cursorColor ?? theme.cursorColor,
      validator: validation,
      inputFormatters: inputFormatters,
      maxLines: _effectiveMaxLines,
      minLines: minLines,
      decoration: _createInputDecoration(textTheme, theme),
    );
  }
}
