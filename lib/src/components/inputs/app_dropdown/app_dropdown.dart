import 'package:flutter/material.dart';

import 'app_dropdown_theme.dart';

const _kDefaultBorderWidth = 1.0;
const _kDefaultUnderlineHeight = 2.0;
const _kDefaultDisabledOpacity = 0.2;
const _kDefaultExternalMargin = EdgeInsets.zero;
const _kDefaultScrollThreshold = 200.0;
const _kDefaultScrollbarThickness = 6.0;
const _kDefaultScrollbarRadius = 10.0;
const _kDefaultItemsPerChunk = 60;
const _kDefaultPlaceholderText = 'Select Option';
const _kDefaultMultiPlaceholderText = 'Select Options';
const _kDefaultMultiSelectionText = ' selected';
const _kDefaultLoadingDelay = Duration(milliseconds: 60);

/// Visual variant of [AppDropdown] / [MultiSelectDropdown].
///
/// `null` colors fall back to [AppDropdownStyle].
sealed class DropdownVariant {
  const DropdownVariant();
}

class DefaultDropdown extends DropdownVariant {
  const DefaultDropdown();
}

class OutlineDropdown extends DropdownVariant {
  final Color? borderColor;
  final double borderWidth;

  const OutlineDropdown({
    this.borderColor,
    this.borderWidth = _kDefaultBorderWidth,
  });
}

class FilledDropdown extends DropdownVariant {
  final Color? fillColor;

  const FilledDropdown({this.fillColor});
}

class UnderlinedDropdown extends DropdownVariant {
  final Color? lineColor;
  final double lineHeight;

  const UnderlinedDropdown({
    this.lineColor,
    this.lineHeight = _kDefaultUnderlineHeight,
  });
}

/// Colors and decoration resolved for one [DropdownVariant].
class _ResolvedVariant {
  const _ResolvedVariant({
    required this.decoration,
    required this.disabledColor,
    required this.arrowColor,
  });

  final BoxDecoration decoration;
  final Color disabledColor;
  final Color arrowColor;

  factory _ResolvedVariant.from(
    DropdownVariant variant,
    AppDropdownStyle style, {
    required bool isEnabled,
    Color? disableColor,
  }) {
    final radius = BorderRadius.circular(style.borderRadius!);
    switch (variant) {
      case DefaultDropdown():
        final border = style.borderColor!;
        final disabled =
            disableColor ??
            border.withValues(alpha: _kDefaultDisabledOpacity);
        return _ResolvedVariant(
          disabledColor: disabled,
          arrowColor: style.iconColor!,
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: radius,
            border: Border.all(
              color: isEnabled ? border.withValues(alpha: 0.3) : disabled,
            ),
          ),
        );
      case OutlineDropdown(:final borderColor, :final borderWidth):
        final border = borderColor ?? style.borderColor!;
        final disabled =
            disableColor ??
            border.withValues(alpha: _kDefaultDisabledOpacity);
        return _ResolvedVariant(
          disabledColor: disabled,
          arrowColor: border,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: radius,
            border: Border.all(
              color: isEnabled ? border : disabled,
              width: borderWidth,
            ),
          ),
        );
      case FilledDropdown(:final fillColor):
        final fill = fillColor ?? style.fillColor!;
        return _ResolvedVariant(
          disabledColor:
              disableColor ?? fill.withValues(alpha: _kDefaultDisabledOpacity),
          arrowColor: fill,
          decoration: BoxDecoration(
            color: isEnabled ? fill : fill.withValues(alpha: 0.5),
            borderRadius: radius,
          ),
        );
      case UnderlinedDropdown(:final lineColor, :final lineHeight):
        final line = lineColor ?? style.lineColor!;
        final disabled =
            disableColor ?? line.withValues(alpha: _kDefaultDisabledOpacity);
        return _ResolvedVariant(
          disabledColor: disabled,
          arrowColor: line,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isEnabled ? line : disabled,
                width: lineHeight,
              ),
            ),
          ),
        );
    }
  }
}

ThemeData _scrollbarTheme(BuildContext context, AppDropdownStyle style) {
  return Theme.of(context).copyWith(
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        style.accentColor!.withValues(alpha: 0.5),
      ),
      thickness: WidgetStateProperty.all(_kDefaultScrollbarThickness),
      radius: const Radius.circular(_kDefaultScrollbarRadius),
    ),
  );
}

/// A dropdown that lets the user pick several [items], each with a checkbox.
///
/// The menu is shown in an [Overlay] below the field; [onItemsSelected] fires
/// on every toggle with the full current selection.
class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String placeholder;
  final Function(List<T>) onItemsSelected;
  final String Function(T)? itemLabel;
  final bool isEnabled;
  final Widget Function(T, bool)? itemBuilder;

  /// Overrides the decoration derived from [variant].
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry margin;
  final Color? dropDownColor;
  final Color? textColor;
  final Color? checkboxColor;
  final Color? selectedItemColor;

  /// Appended to the selection count, e.g. `3 selected`.
  final String selectionSuffix;
  final DropdownVariant variant;

  /// Per-instance overrides on top of the ambient [AppDropdownStyle].
  final AppDropdownStyle? style;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    this.placeholder = _kDefaultMultiPlaceholderText,
    required this.onItemsSelected,
    this.itemLabel,
    this.itemBuilder,
    this.isEnabled = true,
    this.dropDownColor,
    this.textColor,
    this.checkboxColor,
    this.selectedItemColor,
    this.decoration,
    this.margin = _kDefaultExternalMargin,
    this.selectionSuffix = _kDefaultMultiSelectionText,
    this.variant = const DefaultDropdown(),
    this.style,
  });

  factory MultiSelectDropdown.outline({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = _kDefaultMultiPlaceholderText,
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    Color? borderColor,
    double borderWidth = _kDefaultBorderWidth,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
    String selectionSuffix = _kDefaultMultiSelectionText,
    AppDropdownStyle? style,
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
      selectionSuffix: selectionSuffix,
      style: style,
      variant: OutlineDropdown(
        borderColor: borderColor,
        borderWidth: borderWidth,
      ),
    );
  }

  factory MultiSelectDropdown.filled({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = _kDefaultMultiPlaceholderText,
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? fillColor,
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
    String selectionSuffix = _kDefaultMultiSelectionText,
    AppDropdownStyle? style,
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
      selectionSuffix: selectionSuffix,
      style: style,
      variant: FilledDropdown(fillColor: fillColor),
    );
  }

  factory MultiSelectDropdown.underlined({
    Key? key,
    required List<T> items,
    required List<T> selectedItems,
    String placeholder = _kDefaultMultiPlaceholderText,
    required Function(List<T>) onItemsSelected,
    String Function(T)? itemLabel,
    Widget Function(T, bool)? itemBuilder,
    bool isEnabled = true,
    Color? lineColor,
    double lineHeight = _kDefaultUnderlineHeight,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? textColor,
    Color? checkboxColor,
    Color? selectedItemColor,
    Color? dropDownColor,
    String selectionSuffix = _kDefaultMultiSelectionText,
    AppDropdownStyle? style,
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
      selectionSuffix: selectionSuffix,
      style: style,
      variant: UnderlinedDropdown(lineColor: lineColor, lineHeight: lineHeight),
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

  void _removeOverlay() {
    _overlayEntry
      ?..remove()
      ..dispose();
    _overlayEntry = null;
  }

  void _openDropdown() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final style = AppDropdownStyle.of(context).merge(widget.style);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(style.borderRadius!),
            color: widget.dropDownColor ?? style.menuColor,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: style.menuMaxHeight!,
                minWidth: size.width,
              ),
              child: Theme(
                data: _scrollbarTheme(context, style),
                child: Scrollbar(
                  controller: _scrollController,
                  child: StatefulBuilder(
                    builder: (context, setInnerState) {
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) => _buildMenuItem(
                          context,
                          style,
                          widget.items[index],
                          setInnerState,
                        ),
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

  Widget _buildMenuItem(
    BuildContext context,
    AppDropdownStyle style,
    T item,
    StateSetter setInnerState,
  ) {
    final isSelected = _selectedItems.contains(item);
    final accent = widget.checkboxColor ?? style.accentColor!;

    void setSelected(bool selected) {
      setInnerState(() {
        if (selected) {
          if (!_selectedItems.contains(item)) _selectedItems.add(item);
        } else {
          _selectedItems.remove(item);
        }
      });
      setState(() {});
      widget.onItemsSelected(_selectedItems);
    }

    return InkWell(
      onTap: widget.isEnabled ? () => setSelected(!isSelected) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isSelected,
                fillColor: WidgetStateProperty.resolveWith(
                  (states) =>
                      states.contains(WidgetState.selected) ? accent : null,
                ),
                checkColor: style.checkColor,
                onChanged: widget.isEnabled
                    ? (bool? value) => setSelected(value == true)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: widget.itemBuilder != null
                  ? widget.itemBuilder!(item, isSelected)
                  : Text(
                      widget.itemLabel?.call(item) ?? item.toString(),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isSelected
                            ? widget.selectedItemColor ?? style.accentColor
                            : widget.textColor ?? style.textColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _closeDropdown() {
    _removeOverlay();
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = AppDropdownStyle.of(context).merge(widget.style);
    final resolved = _ResolvedVariant.from(
      widget.variant,
      style,
      isEnabled: widget.isEnabled,
    );
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: widget.textColor ?? style.textColor,
    );
    final radius = BorderRadius.circular(style.borderRadius!);

    final field = Container(
      margin: widget.margin,
      padding: style.padding,
      height: style.height,
      decoration: widget.decoration ?? resolved.decoration,
      child: Row(
        children: [
          Expanded(
            child: Text(
              _selectedItems.isEmpty
                  ? widget.placeholder
                  : '${_selectedItems.length}${widget.selectionSuffix}',
              style: textStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Icon(
            _isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: widget.isEnabled
                ? style.iconColor
                : style.disabledIconColor,
          ),
        ],
      ),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.isEnabled
          ? InkWell(borderRadius: radius, onTap: _toggleDropdown, child: field)
          : field,
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _scrollController.dispose();
    super.dispose();
  }
}

/// A single-select dropdown built on [DropdownButton].
///
/// Menu items are created lazily in chunks of [itemsPerChunk].
class AppDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String placeholder;
  final Function(T?)? onChanged;
  final String Function(T)? itemLabel;
  final bool isEnabled;
  final int itemsPerChunk;
  final Widget Function(T)? itemBuilder;

  /// Overrides the decoration derived from [variant].
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry margin;
  final Color? dropDownColor;
  final Color? textColor;
  final Color? arrowDownIconColor;

  /// Text, arrow and border color while disabled.
  final Color? disableColor;
  final DropdownVariant variant;

  /// Per-instance overrides on top of the ambient [AppDropdownStyle].
  final AppDropdownStyle? style;

  const AppDropdown._({
    super.key,
    required this.items,
    this.value,
    this.placeholder = _kDefaultPlaceholderText,
    this.onChanged,
    this.itemLabel,
    this.itemBuilder,
    this.isEnabled = true,
    this.itemsPerChunk = _kDefaultItemsPerChunk,
    this.dropDownColor,
    this.textColor,
    this.arrowDownIconColor,
    this.disableColor,
    required this.margin,
    this.decoration,
    required this.variant,
    this.style,
  });

  factory AppDropdown({
    Key? key,
    required List<T> items,
    T? value,
    String placeholder = _kDefaultPlaceholderText,
    Function(T?)? onChanged,
    String Function(T)? itemLabel,
    Widget Function(T)? itemBuilder,
    bool isEnabled = true,
    int itemsPerChunk = _kDefaultItemsPerChunk,
    BoxDecoration? decoration,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? textColor,
    Color? dropDownColor,
    Color? arrowDownIconColor,
    Color? disableColor,
    AppDropdownStyle? style,
  }) {
    return AppDropdown._(
      key: key,
      items: items,
      value: value,
      placeholder: placeholder,
      onChanged: onChanged,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      itemsPerChunk: itemsPerChunk,
      margin: margin,
      dropDownColor: dropDownColor,
      textColor: textColor,
      arrowDownIconColor: arrowDownIconColor,
      disableColor: disableColor,
      decoration: decoration,
      variant: const DefaultDropdown(),
      style: style,
    );
  }

  factory AppDropdown.outline({
    Key? key,
    required List<T> items,
    T? value,
    String placeholder = _kDefaultPlaceholderText,
    Function(T?)? onChanged,
    String Function(T)? itemLabel,
    Widget Function(T)? itemBuilder,
    bool isEnabled = true,
    int itemsPerChunk = _kDefaultItemsPerChunk,
    Color? borderColor,
    Color? dropDownColor,
    double borderWidth = _kDefaultBorderWidth,
    Color? textColor,
    Color? arrowDownIconColor,
    Color? disableColor,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    AppDropdownStyle? style,
  }) {
    return AppDropdown._(
      key: key,
      items: items,
      value: value,
      placeholder: placeholder,
      onChanged: onChanged,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      itemsPerChunk: itemsPerChunk,
      margin: margin,
      dropDownColor: dropDownColor,
      textColor: textColor,
      arrowDownIconColor: arrowDownIconColor,
      disableColor: disableColor,
      variant: OutlineDropdown(
        borderColor: borderColor,
        borderWidth: borderWidth,
      ),
      style: style,
    );
  }

  factory AppDropdown.filled({
    Key? key,
    required List<T> items,
    T? value,
    String placeholder = _kDefaultPlaceholderText,
    Function(T?)? onChanged,
    String Function(T)? itemLabel,
    Widget Function(T)? itemBuilder,
    bool isEnabled = true,
    int itemsPerChunk = _kDefaultItemsPerChunk,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? fillColor,
    Color? arrowDownIconColor,
    Color? disableColor,
    AppDropdownStyle? style,
  }) {
    return AppDropdown._(
      key: key,
      items: items,
      value: value,
      placeholder: placeholder,
      onChanged: onChanged,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      itemsPerChunk: itemsPerChunk,
      margin: margin,
      arrowDownIconColor: arrowDownIconColor,
      disableColor: disableColor,
      variant: FilledDropdown(fillColor: fillColor),
      style: style,
    );
  }

  factory AppDropdown.underlined({
    Key? key,
    required List<T> items,
    T? value,
    String placeholder = _kDefaultPlaceholderText,
    Function(T?)? onChanged,
    String Function(T)? itemLabel,
    Widget Function(T)? itemBuilder,
    bool isEnabled = true,
    int itemsPerChunk = _kDefaultItemsPerChunk,
    Color? lineColor,
    double lineHeight = _kDefaultUnderlineHeight,
    EdgeInsetsGeometry margin = _kDefaultExternalMargin,
    Color? arrowDownIconColor,
    Color? disableColor,
    AppDropdownStyle? style,
  }) {
    return AppDropdown._(
      key: key,
      margin: margin,
      items: items,
      value: value,
      placeholder: placeholder,
      onChanged: onChanged,
      itemLabel: itemLabel,
      itemBuilder: itemBuilder,
      isEnabled: isEnabled,
      itemsPerChunk: itemsPerChunk,
      arrowDownIconColor: arrowDownIconColor,
      disableColor: disableColor,
      variant: UnderlinedDropdown(lineColor: lineColor, lineHeight: lineHeight),
      style: style,
    );
  }

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  List<T> _loadedItems = [];
  late ScrollController _scrollController;
  int _currentChunkIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadInitialChunk();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _currentChunkIndex = 0;
      _loadInitialChunk();
    }
  }

  void _loadInitialChunk() {
    final endIndex = widget.itemsPerChunk.clamp(0, widget.items.length);
    _loadedItems = widget.items.sublist(0, endIndex);
  }

  List<DropdownMenuItem<T>> _createMenuItems(
    List<T> items,
    TextStyle? textStyle,
  ) {
    return items.map((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: widget.itemBuilder != null
            ? widget.itemBuilder!(item)
            : Text(
                widget.itemLabel?.call(item) ?? item.toString(),
                style: textStyle?.copyWith(color: widget.textColor),
                textAlign: TextAlign.left,
              ),
      );
    }).toList();
  }

  void _onScroll() {
    if (!_isLoading &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                _kDefaultScrollThreshold) {
      _loadNextChunk();
    }
  }

  Future<void> _loadNextChunk() async {
    if (_isLoading || widget.items.isEmpty) return;

    final startIndex = (_currentChunkIndex + 1) * widget.itemsPerChunk;
    if (startIndex >= widget.items.length) return;

    setState(() {
      _isLoading = true;
    });

    final endIndex = (startIndex + widget.itemsPerChunk).clamp(
      0,
      widget.items.length,
    );

    await Future<void>.delayed(_kDefaultLoadingDelay);

    if (mounted) {
      setState(() {
        _loadedItems = [
          ..._loadedItems,
          ...widget.items.sublist(startIndex, endIndex),
        ];
        _currentChunkIndex++;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = AppDropdownStyle.of(context).merge(widget.style);
    final resolved = _ResolvedVariant.from(
      widget.variant,
      style,
      isEnabled: widget.isEnabled,
      disableColor: widget.disableColor,
    );
    final textTheme = Theme.of(context).textTheme;
    final foreground = widget.isEnabled
        ? (widget.textColor ?? style.textColor)
        : widget.disableColor ?? style.disabledIconColor;

    return Container(
      margin: widget.margin,
      padding: style.padding,
      height: style.height,
      decoration: widget.decoration ?? resolved.decoration,
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: _scrollbarTheme(context, style),
          child: Scrollbar(
            controller: _scrollController,
            child: DropdownButton<T>(
              value: widget.value,
              hint: Text(
                widget.placeholder,
                style: textTheme.bodyLarge?.copyWith(color: foreground),
                textAlign: TextAlign.left,
              ),
              style: textTheme.bodyLarge?.copyWith(color: foreground),
              menuMaxHeight: style.menuMaxHeight,
              dropdownColor: widget.dropDownColor ?? style.menuColor,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: widget.isEnabled
                    ? widget.arrowDownIconColor ?? resolved.arrowColor
                    : widget.disableColor ?? style.disabledIconColor,
              ),
              items: _createMenuItems(_loadedItems, textTheme.bodyLarge),
              onChanged: widget.isEnabled ? widget.onChanged : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
