import 'package:flutter/material.dart';

const _kDefaultOptionsTitle = 'Select Option';

/// One segment of an [AppFilterChip.grouped].
class FilterItem {
  final String label;
  final String selectedValue;
  final IconData icon;
  final VoidCallback? onTap;
  final List<String>? options;
  final Function(String)? onOptionSelected;
  final String Function(String)? formatOption;
  final bool isActive;
  final bool showDropdownIcon;
  final double? maxWidth;

  const FilterItem({
    required this.label,
    required this.selectedValue,
    required this.icon,
    this.onTap,
    this.options,
    this.onOptionSelected,
    this.formatOption,
    this.isActive = false,
    this.showDropdownIcon = false,
    this.maxWidth,
  });
}

/// A pill-shaped filter chip showing an icon and [label] (or
/// [selectedValue] when [isActive]).
///
/// When [options] and [onOptionSelected] are provided, tapping opens a modal
/// bottom sheet listing the options. [AppFilterChip.grouped] renders several
/// [FilterItem]s in one pill separated by pipes.
class AppFilterChip extends StatelessWidget {
  // ============================================================================
  // CONSTANTS
  // ============================================================================
  static const double _singleFilterPadding = 16.0;
  static const double _groupedFilterPadding = 14.0;
  static const double _iconSize = 16.0;
  static const double _borderRadius = 20.0;
  static const double _singleFilterBorderRadius = 20.0;
  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const double _shadowBlurRadius = 6.0;
  static const double _shadowOffset = 2.0;

  // ============================================================================
  // VARIABLES
  // ============================================================================
  final String? label;
  final String? selectedValue;
  final IconData? icon;
  final VoidCallback? onTap;
  final List<String>? options;
  final Function(String)? onOptionSelected;
  final String Function(String)? formatOption;
  final bool isActive;
  final bool useAnimatedContainer;
  final bool showDropdownIcon;
  final double? maxWidth;
  final bool showBorder;
  final bool showBorderWhenActive;
  final EdgeInsets? padding;

  /// Background of the grouped pill. Defaults to [ColorScheme.surface] at
  /// 40% opacity.
  final Color? backgroundColor;

  /// Border of the grouped pill. Defaults to [ColorScheme.onSurface] at 15%
  /// opacity.
  final Color? borderColor;
  final List<FilterItem>? filters;

  /// Title of the options bottom sheet.
  final String optionsTitle;

  // ============================================================================
  // CONSTRUCTOR
  // ============================================================================
  const AppFilterChip({
    super.key,
    this.label,
    this.selectedValue,
    this.icon,
    this.onTap,
    this.options,
    this.onOptionSelected,
    this.formatOption,
    this.isActive = false,
    this.useAnimatedContainer = false,
    this.showDropdownIcon = false,
    this.maxWidth,
    this.showBorder = true,
    this.showBorderWhenActive = true,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.optionsTitle = _kDefaultOptionsTitle,
  }) : filters = null;

  const AppFilterChip.grouped({
    super.key,
    required this.filters,
    this.useAnimatedContainer = false,
    this.showBorder = true,
    this.showBorderWhenActive = true,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.optionsTitle = _kDefaultOptionsTitle,
  }) : label = null,
       selectedValue = null,
       icon = null,
       onTap = null,
       options = null,
       onOptionSelected = null,
       formatOption = null,
       isActive = false,
       showDropdownIcon = false,
       maxWidth = null;

  // ============================================================================
  // LOGIC METHODS
  // ============================================================================
  bool _isGrouped() => filters != null;

  bool _shouldShowBorder(bool isGrouped, bool isActive) {
    if (isGrouped) {
      return showBorder;
    }
    if (isActive) {
      return showBorderWhenActive;
    }
    return showBorder;
  }

  String _getFilterDisplayText(FilterItem filter) {
    if (filter.formatOption != null && filter.isActive) {
      return filter.formatOption!(filter.selectedValue);
    }
    return filter.isActive ? filter.selectedValue : filter.label;
  }

  String _getDisplayText() {
    if (formatOption != null && isActive) {
      return formatOption!(selectedValue ?? '');
    }
    return (isActive ? selectedValue : label) ?? '';
  }

  Color _foregroundColor(ColorScheme scheme, bool active, double alpha) {
    if (useAnimatedContainer && active) return scheme.primary;
    if (useAnimatedContainer) return scheme.onSurface.withValues(alpha: alpha);
    return scheme.onSurface;
  }

  // ============================================================================
  // UI HELPER METHODS
  // ============================================================================
  Widget _buildGroupedFilter(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Widget container = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? scheme.surface.withValues(alpha: 0.4),
        border: _shouldShowBorder(_isGrouped(), false)
            ? Border.all(
                color: borderColor ?? scheme.onSurface.withValues(alpha: 0.15),
                width: 1,
              )
            : null,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: scheme.scrim.withValues(alpha: 0.03),
            blurRadius: _shadowBlurRadius,
            offset: const Offset(0, _shadowOffset),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildFilterWidgets(context),
      ),
    );

    if (useAnimatedContainer) {
      return AnimatedContainer(duration: _animationDuration, child: container);
    }

    return container;
  }

  Widget _buildSingleFilter(BuildContext context) {
    final Widget filterContainer = _buildFilterContainer(context);
    final radius = BorderRadius.circular(
      useAnimatedContainer ? _borderRadius : 8.0,
    );

    if (options != null && onOptionSelected != null) {
      return InkWell(
        onTap: () => _showOptionsModal(
          context,
          options!,
          onOptionSelected!,
          formatOption,
          selectedValue,
        ),
        borderRadius: radius,
        child: filterContainer,
      );
    }

    return InkWell(onTap: onTap, borderRadius: radius, child: filterContainer);
  }

  void _showOptionsModal(
    BuildContext context,
    List<String> optionList,
    Function(String) onSelected,
    String Function(String)? formatOption,
    String? currentSelectedValue,
  ) {
    int selectedIndex = 0;
    if (currentSelectedValue != null) {
      selectedIndex = optionList.indexOf(currentSelectedValue);
      if (selectedIndex == -1) selectedIndex = 0;
    }

    // Approximate item height (padding 16*2 + text size).
    final scrollController = ScrollController(
      initialScrollOffset: selectedIndex * 56.0,
    );
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      backgroundColor: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext modalContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    optionsTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: optionList.length,
                  itemBuilder: (context, index) {
                    final option = optionList[index];
                    final isSelected = option == currentSelectedValue;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(option);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? scheme.primary.withValues(alpha: 0.1)
                              : null,
                          border: Border(
                            bottom: index < optionList.length - 1
                                ? BorderSide(
                                    color: scheme.onSecondary.withValues(
                                      alpha: 0.1,
                                    ),
                                  )
                                : BorderSide.none,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                formatOption != null
                                    ? formatOption(option)
                                    : option,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? scheme.primary
                                      : scheme.onSurface,
                                ),
                              ),
                            ),
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.arrow_forward_ios,
                              size: isSelected ? 20 : 16,
                              color: isSelected
                                  ? scheme.primary
                                  : scheme.onSecondary.withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    ).whenComplete(scrollController.dispose);
  }

  List<Widget> _buildFilterWidgets(BuildContext context) {
    final List<Widget> widgets = [];

    for (int i = 0; i < filters!.length; i++) {
      final filter = filters![i];
      widgets.add(_buildSingleFilterInGroup(filter, context));

      if (i < filters!.length - 1) {
        widgets.add(_buildPipeSeparator(context));
      }
    }

    return widgets;
  }

  Widget _buildSingleFilterInGroup(FilterItem filter, BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final Widget content = _buildRow(
      theme: theme,
      icon: filter.icon,
      active: filter.isActive,
      maxWidth: filter.maxWidth,
      showDropdownIcon: filter.showDropdownIcon,
      text: _getFilterDisplayText(filter),
    );

    final Widget filterContainer = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _groupedFilterPadding,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: filter.isActive
            ? scheme.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: content,
    );

    if (filter.options != null && filter.onOptionSelected != null) {
      return InkWell(
        onTap: () => _showOptionsModal(
          context,
          filter.options!,
          filter.onOptionSelected!,
          filter.formatOption,
          filter.selectedValue,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
        child: filterContainer,
      );
    }

    return InkWell(
      onTap: filter.onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: filterContainer,
    );
  }

  Widget _buildPipeSeparator(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '|',
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w300,
          color: theme.colorScheme.onSurface.withValues(
            alpha: useAnimatedContainer ? 0.4 : 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterContainer(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final content = _buildRow(
      theme: theme,
      icon: icon,
      active: isActive,
      maxWidth: maxWidth,
      showDropdownIcon: showDropdownIcon,
      text: _getDisplayText(),
    );

    if (useAnimatedContainer) {
      return AnimatedContainer(
        duration: _animationDuration,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: _groupedFilterPadding,
              vertical: 8.5,
            ),
        decoration: BoxDecoration(
          color: isActive
              ? scheme.primary.withValues(alpha: 0.1)
              : scheme.surface.withValues(alpha: 0.4),
          border: _shouldShowBorder(false, isActive)
              ? Border.all(
                  color: isActive
                      ? scheme.primary.withValues(alpha: 0.3)
                      : scheme.onSurface.withValues(alpha: 0.15),
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: scheme.scrim.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: content,
      );
    }

    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: _singleFilterPadding,
            vertical: 10,
          ),
      decoration: BoxDecoration(
        border: _shouldShowBorder(false, isActive)
            ? Border.all(color: scheme.surface)
            : null,
        borderRadius: BorderRadius.circular(_singleFilterBorderRadius),
      ),
      child: content,
    );
  }

  Widget _buildRow({
    required ThemeData theme,
    required IconData? icon,
    required bool active,
    required double? maxWidth,
    required bool showDropdownIcon,
    required String text,
  }) {
    final scheme = theme.colorScheme;
    final Widget label = Text(
      text,
      overflow: TextOverflow.clip,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: _foregroundColor(scheme, active, 0.8),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: _iconSize,
          color: _foregroundColor(scheme, active, 0.7),
        ),
        SizedBox(width: useAnimatedContainer ? 6 : 8),
        if (maxWidth != null)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: label,
          )
        else
          label,
        if (showDropdownIcon) ...[
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            size: _iconSize,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
        ],
      ],
    );
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================
  @override
  Widget build(BuildContext context) {
    if (_isGrouped()) {
      return _buildGroupedFilter(context);
    }
    return _buildSingleFilter(context);
  }
}
