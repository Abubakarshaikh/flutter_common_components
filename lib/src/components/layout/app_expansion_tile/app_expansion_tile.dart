import 'package:flutter/material.dart';

const Duration _kToggleDuration = Duration(milliseconds: 200);

/// Shared expand/collapse animation for the tile.
const AnimationStyle _kExpansionAnimation = AnimationStyle(
  duration: _kToggleDuration,
  curve: Curves.easeIn,
);

/// An [ExpansionTile] with rounded corners, an animated trailing chevron and
/// optional custom collapsed / expanded trailing widgets.
///
/// Colors default to the ambient [ColorScheme]: [backgroundColor] and
/// [collapsedBackgroundColor] to `surface`, title and icons to `onSurface`.
class AppExpansionTile extends StatefulWidget {
  static const double _kDefaultBorderRadius = 8.0;

  final String title;
  final List<Widget> children;
  final Widget? leading;
  final EdgeInsetsGeometry? childrenPadding;
  final bool showTrailingIcon;
  final Widget? trailing;
  final Widget? expandedTrailing;
  final Color? titleColor;
  final FontWeight titleFontWeight;
  final TextAlign titleTextAlign;
  final ValueChanged<bool>? onExpansionChanged;
  final bool initiallyExpanded;
  final bool dense;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final bool enabled;
  final Widget? titleWidget;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final bool showBorderRadius;
  final double borderRadiusValue;
  final CrossAxisAlignment expandedCrossAxisAlignment;
  final Alignment? expandedAlignment;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final ExpansibleController? controller;
  final bool maintainState;

  const AppExpansionTile({
    super.key,
    this.title = '',
    required this.children,
    this.leading,
    this.childrenPadding,
    this.showTrailingIcon = true,
    this.trailing,
    this.expandedTrailing,
    this.titleColor,
    this.titleFontWeight = FontWeight.w500,
    this.titleTextAlign = TextAlign.start,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.dense = false,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.enabled = true,
    this.titleWidget,
    this.iconColor,
    this.collapsedIconColor,
    this.showBorderRadius = true,
    this.borderRadiusValue = _kDefaultBorderRadius,
    this.expandedCrossAxisAlignment = CrossAxisAlignment.start,
    this.expandedAlignment,
    this.borderColor,
    this.boxShadow,
    this.controller,
    this.maintainState = true,
  });

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile> {
  late bool _isExpanded;

  /// Drives [ExpansionTile] when no external [AppExpansionTile.controller] is
  /// supplied. External controllers are owned by the caller.
  ExpansibleController? _internalController;

  ExpansibleController get _effectiveController =>
      widget.controller ?? _internalController!;

  bool get _usesExternalController => widget.controller != null;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    if (!_usesExternalController) {
      _internalController = ExpansibleController();
    }
  }

  @override
  void didUpdateWidget(AppExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_usesExternalController) return;
    if (oldWidget.initiallyExpanded == widget.initiallyExpanded) return;
    final bool newDesired = widget.initiallyExpanded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (newDesired) {
        if (!_effectiveController.isExpanded) {
          _effectiveController.expand();
        }
      } else {
        if (_effectiveController.isExpanded) {
          _effectiveController.collapse();
        }
      }
    });
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  ShapeBorder? _createShapeBorder() {
    if (widget.showBorderRadius) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadiusValue),
        ),
        side: widget.borderColor != null
            ? BorderSide(color: widget.borderColor!)
            : BorderSide.none,
      );
    }

    if (widget.borderColor != null) {
      return RoundedRectangleBorder(
        side: BorderSide(color: widget.borderColor!),
      );
    }

    return null;
  }

  Widget _buildExpansionTile(ColorScheme scheme) {
    return ExpansionTile(
      controller: _effectiveController,
      expansionAnimationStyle: _kExpansionAnimation,
      title:
          widget.titleWidget ??
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: widget.titleFontWeight,
              color: widget.titleColor ?? scheme.onSurface,
            ),
            textAlign: widget.titleTextAlign,
            textWidthBasis: TextWidthBasis.parent,
          ),
      expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
      maintainState: widget.maintainState,
      collapsedIconColor: widget.collapsedIconColor ?? scheme.onSurface,
      iconColor: widget.iconColor ?? scheme.onSurface,
      leading: widget.leading,
      dense: widget.dense,
      childrenPadding: widget.childrenPadding,
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
        widget.onExpansionChanged?.call(expanded);
      },
      enabled: widget.enabled,
      backgroundColor: widget.backgroundColor ?? scheme.surface,
      collapsedBackgroundColor:
          widget.collapsedBackgroundColor ?? scheme.surface,
      shape: _createShapeBorder(),
      collapsedShape: _createShapeBorder(),
      trailing: _buildTrailing(scheme),
      expandedAlignment: widget.expandedAlignment,
      children: widget.children,
    );
  }

  Widget? _buildTrailing(ColorScheme scheme) {
    if (!widget.showTrailingIcon) return null;

    final double iconSize = IconTheme.of(context).size ?? 24.0;
    final Color iconColor =
        widget.collapsedIconColor ?? widget.iconColor ?? scheme.onSurface;

    if (widget.trailing != null || widget.expandedTrailing != null) {
      final Widget collapsedChild = widget.trailing ?? widget.expandedTrailing!;
      final Widget expandedChild = widget.expandedTrailing ?? widget.trailing!;

      return AnimatedSwitcher(
        duration: _kToggleDuration,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeIn,
        child: _isExpanded
            ? KeyedSubtree(
                key: const ValueKey('expanded_trailing'),
                child: expandedChild,
              )
            : KeyedSubtree(
                key: const ValueKey('collapsed_trailing'),
                child: collapsedChild,
              ),
      );
    }

    return AnimatedRotation(
      turns: _isExpanded ? 0.5 : 0.0,
      duration: _kToggleDuration,
      curve: Curves.easeIn,
      child: Icon(Icons.expand_more, size: iconSize, color: iconColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(boxShadow: widget.boxShadow),
      child: _buildExpansionTile(scheme),
    );
  }
}
