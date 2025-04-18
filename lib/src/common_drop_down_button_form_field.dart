import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

/// A cross-platform dropdown widget that adapts to iOS and Android platforms
/// Provides multiple dropdown variants with platform-specific styling
/// Follows composition-over-inheritance principle with DropdownStyle

/// A platform-adaptive dropdown widget with multiple style variants
///
/// CommonDropdown provides a unified API for creating dropdowns that adapt to
/// the current platform (iOS or Android) with appropriate styling and behavior.
/// It supports multiple visual variants through factory constructors.
///
/// Usage examples:
/// ```dart
/// // Basic dropdown
/// CommonDropdown<String>.basic(
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   value: selectedValue,
///   labelText: 'Select an option',
///   onChanged: (value) => setState(() => selectedValue = value),
///   itemBuilder: (item) => DropdownMenuItem(
///     value: item,
///     child: Text(item),
///   ),
/// )
///
/// // Outlined dropdown
/// CommonDropdown<int>.outlined(
///   items: [1, 2, 3, 4, 5],
///   value: selectedNumber,
///   labelText: 'Select a number',
///   onChanged: (value) => setState(() => selectedNumber = value),
///   itemBuilder: (item) => DropdownMenuItem(
///     value: item,
///     child: Text('Number $item'),
///   ),
/// )
/// ```
class CommonDropdown<T> extends StatelessWidget {
  /// Private constructor - forces use of factory constructors
  const CommonDropdown._({
    required this.items,
    required this.value,
    required this.itemBuilder,
    required this.variant,
    this.labelText,
    this.hintText,
    this.validator,
    this.onChanged,
    this.style,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffix,
    this.errorText,
  });

  // Dropdown properties
  final List<T> items;
  final T? value;
  final DropdownMenuItem<T> Function(T) itemBuilder;
  final DropdownVariant variant;
  final String? labelText;
  final String? hintText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final DropdownStyle? style;
  final bool isEnabled;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? errorText;

  // Factory constructor for basic dropdown
  factory CommonDropdown.basic({
    required List<T> items,
    required T? value,
    required DropdownMenuItem<T> Function(T) itemBuilder,
    String? labelText,
    String? hintText,
    String? Function(T?)? validator,
    void Function(T?)? onChanged,
    DropdownStyle? style,
    bool isEnabled = true,
    Widget? prefixIcon,
    Widget? suffix,
    String? errorText,
  }) {
    return CommonDropdown._(
      items: items,
      value: value,
      itemBuilder: itemBuilder,
      variant: DropdownVariant.basic,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      onChanged: onChanged,
      style: style?.copyWith(
            backgroundColor: Colors.transparent,
            borderRadius: 8.0,
          ) ??
          const DropdownStyle(
            backgroundColor: Colors.transparent,
            borderRadius: 8.0,
          ),
      isEnabled: isEnabled,
      prefixIcon: prefixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  // Factory constructor for outlined dropdown
  factory CommonDropdown.outlined({
    required List<T> items,
    required T? value,
    required DropdownMenuItem<T> Function(T) itemBuilder,
    String? labelText,
    String? hintText,
    String? Function(T?)? validator,
    void Function(T?)? onChanged,
    Color? borderColor,
    double borderWidth = 1.0,
    DropdownStyle? style,
    bool isEnabled = true,
    Widget? prefixIcon,
    Widget? suffix,
    String? errorText,
  }) {
    return CommonDropdown._(
      items: items,
      value: value,
      itemBuilder: itemBuilder,
      variant: DropdownVariant.outlined,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      onChanged: onChanged,
      style: style?.copyWith(
            backgroundColor: Colors.transparent,
            border: BorderSide(
              color: borderColor ?? Colors.grey,
              width: borderWidth,
            ),
            borderRadius: 8.0,
          ) ??
          DropdownStyle(
            backgroundColor: Colors.transparent,
            border: BorderSide(
              color: borderColor ?? Colors.grey,
              width: borderWidth,
            ),
            borderRadius: 8.0,
          ),
      isEnabled: isEnabled,
      prefixIcon: prefixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  // Factory constructor for filled dropdown
  factory CommonDropdown.filled({
    required List<T> items,
    required T? value,
    required DropdownMenuItem<T> Function(T) itemBuilder,
    String? labelText,
    String? hintText,
    String? Function(T?)? validator,
    void Function(T?)? onChanged,
    Color? fillColor,
    DropdownStyle? style,
    bool isEnabled = true,
    Widget? prefixIcon,
    Widget? suffix,
    String? errorText,
  }) {
    return CommonDropdown._(
      items: items,
      value: value,
      itemBuilder: itemBuilder,
      variant: DropdownVariant.filled,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      onChanged: onChanged,
      style: style?.copyWith(
            backgroundColor: fillColor ?? Colors.grey[200],
            borderRadius: 8.0,
          ) ??
          DropdownStyle(
            backgroundColor: fillColor ?? Colors.grey[200],
            borderRadius: 8.0,
          ),
      isEnabled: isEnabled,
      prefixIcon: prefixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  // Factory constructor for underlined dropdown
  factory CommonDropdown.underlined({
    required List<T> items,
    required T? value,
    required DropdownMenuItem<T> Function(T) itemBuilder,
    String? labelText,
    String? hintText,
    String? Function(T?)? validator,
    void Function(T?)? onChanged,
    Color? lineColor,
    double lineWidth = 1.0,
    DropdownStyle? style,
    bool isEnabled = true,
    Widget? prefixIcon,
    Widget? suffix,
    String? errorText,
  }) {
    return CommonDropdown._(
      items: items,
      value: value,
      itemBuilder: itemBuilder,
      variant: DropdownVariant.underlined,
      labelText: labelText,
      hintText: hintText,
      validator: validator,
      onChanged: onChanged,
      style: style?.copyWith(
            backgroundColor: Colors.transparent,
            underlineColor: lineColor ?? Colors.grey,
            underlineWidth: lineWidth,
          ) ??
          DropdownStyle(
            backgroundColor: Colors.transparent,
            underlineColor: lineColor ?? Colors.grey,
            underlineWidth: lineWidth,
          ),
      isEnabled: isEnabled,
      prefixIcon: prefixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveStyle = _getEffectiveStyle(context);

    // Platform-specific dropdown implementation
    if (Platform.isIOS) {
      return _buildCupertinoDropdown(context, effectiveStyle);
    } else {
      return _buildMaterialDropdown(context, effectiveStyle);
    }
  }

  DropdownStyle _getEffectiveStyle(BuildContext context) {
    final theme = Theme.of(context);

    // Start with default style based on variant and platform
    DropdownStyle defaultStyle;

    // Get the primary color based on platform
    final primaryColor =
        Platform.isIOS ? CupertinoColors.systemBlue : theme.primaryColor;

    switch (variant) {
      case DropdownVariant.basic:
        defaultStyle = DropdownStyle(
          backgroundColor: Colors.transparent,
          textColor: Platform.isIOS
              ? CupertinoColors.label
              : theme.textTheme.bodyLarge?.color,
          labelColor: Platform.isIOS
              ? CupertinoColors.secondaryLabel
              : theme.inputDecorationTheme.labelStyle?.color ?? theme.hintColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          textStyle: theme.textTheme.bodyLarge,
          labelStyle: theme.textTheme.bodySmall,
          animationDuration: const Duration(milliseconds: 200),
        );
        break;
      case DropdownVariant.outlined:
        defaultStyle = DropdownStyle(
          backgroundColor: Colors.transparent,
          textColor: Platform.isIOS
              ? CupertinoColors.label
              : theme.textTheme.bodyLarge?.color,
          labelColor: Platform.isIOS
              ? CupertinoColors.secondaryLabel
              : theme.inputDecorationTheme.labelStyle?.color ?? theme.hintColor,
          border: BorderSide(
            color: Platform.isIOS
                ? CupertinoColors.systemGrey3
                : theme.dividerColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          textStyle: theme.textTheme.bodyLarge,
          labelStyle: theme.textTheme.bodySmall,
          animationDuration: const Duration(milliseconds: 200),
        );
        break;
      case DropdownVariant.filled:
        defaultStyle = DropdownStyle(
          backgroundColor:
              Platform.isIOS ? CupertinoColors.systemGrey6 : Colors.grey[200],
          textColor: Platform.isIOS
              ? CupertinoColors.label
              : theme.textTheme.bodyLarge?.color,
          labelColor: Platform.isIOS
              ? CupertinoColors.secondaryLabel
              : theme.inputDecorationTheme.labelStyle?.color ?? theme.hintColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          borderRadius: Platform.isIOS ? 10.0 : 8.0,
          textStyle: theme.textTheme.bodyLarge,
          labelStyle: theme.textTheme.bodySmall,
          animationDuration: const Duration(milliseconds: 200),
        );
        break;
      case DropdownVariant.underlined:
        defaultStyle = DropdownStyle(
          backgroundColor: Colors.transparent,
          textColor: Platform.isIOS
              ? CupertinoColors.label
              : theme.textTheme.bodyLarge?.color,
          labelColor: Platform.isIOS
              ? CupertinoColors.secondaryLabel
              : theme.inputDecorationTheme.labelStyle?.color ?? theme.hintColor,
          underlineColor:
              Platform.isIOS ? CupertinoColors.systemGrey3 : theme.dividerColor,
          underlineWidth: 1.0,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          textStyle: theme.textTheme.bodyLarge,
          labelStyle: theme.textTheme.bodySmall,
          animationDuration: const Duration(milliseconds: 200),
        );
        break;
    }

    // Apply custom style if provided
    final customizedStyle =
        style != null ? _mergeStyles(defaultStyle, style!) : defaultStyle;

    // Apply disabled style if dropdown is disabled
    if (!isEnabled) {
      return customizedStyle.copyWith(
        textColor:
            Platform.isIOS ? CupertinoColors.inactiveGray : theme.disabledColor,
        backgroundColor: customizedStyle.backgroundColor?.withOpacity(0.7),
      );
    }

    return customizedStyle;
  }

  DropdownStyle _mergeStyles(DropdownStyle base, DropdownStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      textColor: override.textColor,
      labelColor: override.labelColor,
      hintColor: override.hintColor,
      errorColor: override.errorColor,
      padding: override.padding,
      borderRadius: override.borderRadius,
      border: override.border,
      underlineColor: override.underlineColor,
      underlineWidth: override.underlineWidth,
      margin: override.margin,
      textStyle: override.textStyle,
      labelStyle: override.labelStyle,
      animationDuration: override.animationDuration,
    );
  }

  Widget _buildMaterialDropdown(BuildContext context, DropdownStyle style) {
    InputDecoration getDecoration() {
      switch (variant) {
        case DropdownVariant.basic:
          return InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffix: suffix,
            errorText: errorText,
            labelStyle: TextStyle(
              color: style.labelColor,
              fontSize: style.labelStyle?.fontSize,
              fontWeight: style.labelStyle?.fontWeight,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: style.padding,
          );

        case DropdownVariant.outlined:
          return InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffix: suffix,
            errorText: errorText,
            labelStyle: TextStyle(
              color: style.labelColor,
              fontSize: style.labelStyle?.fontSize,
              fontWeight: style.labelStyle?.fontWeight,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: style.border ?? BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: style.border ?? BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: style.border != null
                  ? BorderSide(
                      color: style.border!.color,
                      width: style.border!.width * 1.5,
                    )
                  : BorderSide.none,
            ),
            filled: false,
            contentPadding: style.padding,
          );

        case DropdownVariant.filled:
          return InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffix: suffix,
            errorText: errorText,
            labelStyle: TextStyle(
              color: style.labelColor,
              fontSize: style.labelStyle?.fontSize,
              fontWeight: style.labelStyle?.fontWeight,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: style.backgroundColor,
            contentPadding: style.padding,
          );

        case DropdownVariant.underlined:
          return InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffix: suffix,
            errorText: errorText,
            labelStyle: TextStyle(
              color: style.labelColor,
              fontSize: style.labelStyle?.fontSize,
              fontWeight: style.labelStyle?.fontWeight,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: style.underlineColor ?? Colors.grey,
                width: style.underlineWidth ?? 1.0,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: style.underlineColor ?? Colors.grey,
                width: style.underlineWidth ?? 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: style.underlineColor ?? Colors.grey,
                width: (style.underlineWidth ?? 1.0) * 1.5,
              ),
            ),
            filled: false,
            contentPadding: style.padding,
          );
      }
    }

    return DropdownButtonFormField<T>(
      value: value,
      items: items.map(itemBuilder).toList(),
      onChanged: isEnabled ? onChanged : null,
      decoration: getDecoration(),
      validator: validator,
      style: TextStyle(
        color: style.textColor,
        fontSize: style.textStyle?.fontSize,
        fontWeight: style.textStyle?.fontWeight,
      ),
      dropdownColor: style.backgroundColor,
      icon: Icon(
        Icons.arrow_drop_down,
        color: isEnabled
            ? style.textColor?.withOpacity(0.8)
            : style.textColor?.withOpacity(0.4),
      ),
      elevation: 3,
      isDense: false,
    );
  }

  Widget _buildCupertinoDropdown(BuildContext context, DropdownStyle style) {
    // Note: Flutter doesn't provide a native CupertinoPicker in dropdown form
    // We can create a custom solution that uses CupertinoPicker in a modal

    // For the display part, we create a tappable field that looks like an input
    return GestureDetector(
      onTap: !isEnabled
          ? null
          : () {
              // Show a CupertinoPicker in modal
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 250,
                    padding: const EdgeInsets.only(top: 6.0),
                    color:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    child: Column(
                      children: [
                        // Button bar
                        SizedBox(
                          height: 44,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: const Text('Done'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                        // Divider
                        const Divider(height: 0),
                        // Picker
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 40,
                            onSelectedItemChanged: (index) {
                              if (onChanged != null) {
                                onChanged!(items[index]);
                              }
                            },
                            scrollController: FixedExtentScrollController(
                              initialItem:
                                  value != null ? items.indexOf(value as T) : 0,
                            ),
                            children: items.map((item) {
                              // We create a copy of the DropdownMenuItem's child
                              // to display in the picker
                              final menuItem = itemBuilder(item);
                              return Center(
                                child: menuItem.child,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
      child: _buildCupertinoField(context, style),
    );
  }

  Widget _buildCupertinoField(BuildContext context, DropdownStyle style) {
    Widget buildContent() {
      // Display the current value, or hint, or empty
      Widget child;
      if (value != null) {
        // Find the matching dropdown item
        final selectedItem = items.firstWhere(
          (item) => item == value,
          orElse: () => items.first,
        );

        // Get the dropdownMenuItem for this item
        final menuItem = itemBuilder(selectedItem);

        // Use the child of that menuItem as our content
        child = menuItem.child ?? Text(value.toString());
      } else if (hintText != null) {
        child = Text(
          hintText!,
          style: TextStyle(
            color: style.hintColor ?? CupertinoColors.placeholderText,
            fontSize: style.textStyle?.fontSize,
          ),
        );
      } else {
        child = const SizedBox.shrink();
      }

      return Padding(
        padding: style.padding ??
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Expanded(child: child),
            suffix ??
                Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: isEnabled
                      ? CupertinoColors.systemGrey
                      : CupertinoColors.systemGrey4,
                ),
          ],
        ),
      );
    }

    Widget buildLabel() {
      if (labelText == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          labelText!,
          style: TextStyle(
            color: style.labelColor,
            fontSize: style.labelStyle?.fontSize ?? 14,
            fontWeight: style.labelStyle?.fontWeight,
          ),
        ),
      );
    }

    Widget buildError() {
      if (errorText == null) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          errorText!,
          style: TextStyle(
            color: style.errorColor ?? CupertinoColors.destructiveRed,
            fontSize: 12,
          ),
        ),
      );
    }

    // Build the field based on variant
    Widget field;
    switch (variant) {
      case DropdownVariant.basic:
        field = buildContent();
        break;

      case DropdownVariant.outlined:
        field = Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: style.border?.color ?? CupertinoColors.systemGrey4,
              width: style.border?.width ?? 1.0,
            ),
            borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
          ),
          child: buildContent(),
        );
        break;

      case DropdownVariant.filled:
        field = Container(
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(style.borderRadius ?? 8.0),
          ),
          child: buildContent(),
        );
        break;

      case DropdownVariant.underlined:
        field = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildContent(),
            Container(
              height: style.underlineWidth ?? 1.0,
              color: style.underlineColor ?? CupertinoColors.systemGrey4,
            ),
          ],
        );
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildLabel(),
        field,
        buildError(),
      ],
    );
  }
}

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String placeholder;
  final Function(List<T>) onItemsSelected;
  final String Function(T)? itemLabel;
  final bool isEnabled;
  final Widget Function(T, bool)? itemBuilder;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry margin;
  final Color? dropDownColor;
  final Color? textColor;
  final Color? checkboxColor;
  final Color? selectedItemColor;

  MultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    this.placeholder = 'Select Options',
    required this.onItemsSelected,
    this.itemLabel,
    this.itemBuilder,
    this.isEnabled = true,
    this.dropDownColor,
    this.textColor,
    this.checkboxColor,
    this.selectedItemColor,
    BoxDecoration? decoration,
    this.margin = const EdgeInsets.all(0),
  }) : decoration = decoration ??
            BoxDecoration(
              color:
                  isEnabled ? const Color(0xFF2A2A2A) : const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isEnabled
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
              ),
            );

  factory MultiSelectDropdown.outline({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = 'Select Options',
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    Color borderColor = Colors.blue,
    double borderWidth = 1.0,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0),
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
  }) {
    return MultiSelectDropdown(
      key: key,
      items: items,
      selectedItems: selectedItems,
      placeholder: placeholder,
      onItemsSelected: onItemsSelected,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      margin: margin,
      textColor: textColor,
      checkboxColor: checkboxColor,
      selectedItemColor: selectedItemColor,
      dropDownColor: dropDownColor,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEnabled ? borderColor : Colors.grey.withOpacity(0.2),
          width: borderWidth,
        ),
      ),
    );
  }

  factory MultiSelectDropdown.filled({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = 'Select Options',
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0),
    Color fillColor = const Color(0xFF3A3A3A),
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
  }) {
    return MultiSelectDropdown(
      key: key,
      items: items,
      selectedItems: selectedItems,
      placeholder: placeholder,
      onItemsSelected: onItemsSelected,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      margin: margin,
      textColor: textColor,
      checkboxColor: checkboxColor,
      selectedItemColor: selectedItemColor,
      dropDownColor: dropDownColor,
      decoration: BoxDecoration(
        color: isEnabled ? fillColor : fillColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  factory MultiSelectDropdown.underlined({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = 'Select Options',
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    Color lineColor = Colors.blue,
    double lineHeight = 2.0,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0),
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
  }) {
    return MultiSelectDropdown(
      key: key,
      items: items,
      selectedItems: selectedItems,
      placeholder: placeholder,
      onItemsSelected: onItemsSelected,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      margin: margin,
      textColor: textColor,
      checkboxColor: checkboxColor,
      selectedItemColor: selectedItemColor,
      dropDownColor: dropDownColor,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isEnabled ? lineColor : Colors.grey.withOpacity(0.2),
            width: lineHeight,
          ),
        ),
      ),
    );
  }

  @override
  State<MultiSelectDropdown<T>> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late List<T> _selectedItems;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(MultiSelectDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItems != widget.selectedItems) {
      _selectedItems = List.from(widget.selectedItems);
    }
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            color: widget.dropDownColor ?? const Color(0xFF2A2A2A),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
                minWidth: size.width,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all(
                      Colors.blue.withOpacity(0.5),
                    ),
                    thickness: WidgetStateProperty.all(6.0),
                    radius: const Radius.circular(10),
                  ),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  child: StatefulBuilder(
                    builder: (context, setInnerState) {
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = _selectedItems.contains(item);

                          return InkWell(
                            onTap: widget.isEnabled
                                ? () {
                                    setInnerState(() {
                                      if (isSelected) {
                                        _selectedItems.remove(item);
                                      } else {
                                        _selectedItems.add(item);
                                      }
                                    });

                                    // Also update parent state
                                    setState(() {});

                                    // Notify callback immediately
                                    widget.onItemsSelected(_selectedItems);
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: isSelected,
                                      activeColor:
                                          widget.checkboxColor ?? Colors.blue,
                                      checkColor: Colors.white,
                                      onChanged: widget.isEnabled
                                          ? (bool? value) {
                                              setInnerState(() {
                                                if (value == true) {
                                                  if (!_selectedItems
                                                      .contains(item)) {
                                                    _selectedItems.add(item);
                                                  }
                                                } else {
                                                  _selectedItems.remove(item);
                                                }
                                              });

                                              // Also update parent state
                                              setState(() {});

                                              // Notify callback immediately
                                              widget.onItemsSelected(
                                                  _selectedItems);
                                            }
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: widget.itemBuilder != null
                                        ? widget.itemBuilder!(item, isSelected)
                                        : AppText.l1(
                                            widget.itemLabel?.call(item) ??
                                                item.toString(),
                                            color: isSelected
                                                ? widget.selectedItemColor ??
                                                    Colors.blue
                                                : widget.textColor ??
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.isEnabled ? _toggleDropdown : null,
        child: Container(
          margin: widget.margin,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          decoration: widget.decoration,
          child: Row(
            children: [
              Expanded(
                child: _selectedItems.isEmpty
                    ? AppText.l1(
                        widget.placeholder,
                        color: widget.textColor ??
                            Theme.of(context).colorScheme.onPrimary,
                        textAlign: TextAlign.left,
                      )
                    : AppText.l1(
                        '${_selectedItems.length} selected',
                        color: widget.textColor ??
                            Theme.of(context).colorScheme.onPrimary,
                        textAlign: TextAlign.left,
                      ),
              ),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: widget.isEnabled ? Colors.blue : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _scrollController.dispose();
    super.dispose();
  }
}

/// Dropdown variants supported by CommonDropdown
enum DropdownVariant {
  /// Basic dropdown without borders or background
  basic,

  /// Dropdown with an outline border
  outlined,

  /// Dropdown with a background fill
  filled,

  /// Dropdown with an underline
  underlined,
}

/// Styling configuration for CommonDropdown
/// Uses composition pattern to configure dropdown appearance
class DropdownStyle {
  /// Background color of the dropdown
  final Color? backgroundColor;

  /// Color for text
  final Color? textColor;

  /// Color for the label
  final Color? labelColor;

  /// Color for hint text
  final Color? hintColor;

  /// Color for error messages
  final Color? errorColor;

  /// Padding inside the dropdown
  final EdgeInsets? padding;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Border styling for outlined dropdowns
  final BorderSide? border;

  /// Color for underlined dropdowns
  final Color? underlineColor;

  /// Width for underlined dropdowns
  final double? underlineWidth;

  /// Margin around the dropdown
  final EdgeInsets? margin;

  /// Text style for dropdown text
  final TextStyle? textStyle;

  /// Text style for dropdown label
  final TextStyle? labelStyle;

  /// Duration for animations
  final Duration? animationDuration;

  const DropdownStyle({
    this.backgroundColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.errorColor,
    this.padding,
    this.borderRadius,
    this.border,
    this.underlineColor,
    this.underlineWidth,
    this.margin,
    this.textStyle,
    this.labelStyle,
    this.animationDuration,
  });

  DropdownStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? labelColor,
    Color? hintColor,
    Color? errorColor,
    EdgeInsets? padding,
    double? borderRadius,
    BorderSide? border,
    Color? underlineColor,
    double? underlineWidth,
    EdgeInsets? margin,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    Duration? animationDuration,
  }) {
    return DropdownStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      labelColor: labelColor ?? this.labelColor,
      hintColor: hintColor ?? this.hintColor,
      errorColor: errorColor ?? this.errorColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      underlineColor: underlineColor ?? this.underlineColor,
      underlineWidth: underlineWidth ?? this.underlineWidth,
      margin: margin ?? this.margin,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
