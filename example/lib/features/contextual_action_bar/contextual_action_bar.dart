import 'package:flutter/material.dart';

/// A controller to manage selection state for contextual actions
class SelectionController<T> extends ChangeNotifier {
  bool _isSelectionMode = false;
  final List<T> _selectedItems = [];

  /// Whether selection mode is currently active
  bool get isSelectionMode => _isSelectionMode;

  /// Currently selected items
  List<T> get selectedItems => List.unmodifiable(_selectedItems);

  /// Number of currently selected items
  int get selectedCount => _selectedItems.length;

  /// Whether any items are currently selected
  bool get hasSelection => _selectedItems.isNotEmpty;

  /// Whether only a single item is selected
  bool get isSingleSelection => _selectedItems.length == 1;

  /// Enter selection mode
  void enterSelectionMode() {
    if (!_isSelectionMode) {
      _isSelectionMode = true;
      notifyListeners();
    }
  }

  /// Exit selection mode and clear selections
  void exitSelectionMode() {
    if (_isSelectionMode) {
      _isSelectionMode = false;
      _selectedItems.clear();
      notifyListeners();
    }
  }

  /// Toggle selection mode
  void toggleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    if (!_isSelectionMode) {
      _selectedItems.clear();
    }
    notifyListeners();
  }

  /// Toggle selection of an item
  void toggleSelection(T item) {
    if (!_isSelectionMode) {
      _isSelectionMode = true;
      _selectedItems.add(item);
    } else {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
        if (_selectedItems.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedItems.add(item);
      }
    }
    notifyListeners();
  }

  /// Select an item
  void selectItem(T item) {
    if (!_isSelectionMode) {
      _isSelectionMode = true;
    }
    if (!_selectedItems.contains(item)) {
      _selectedItems.add(item);
      notifyListeners();
    }
  }

  /// Deselect an item
  void deselectItem(T item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      if (_selectedItems.isEmpty) {
        _isSelectionMode = false;
      }
      notifyListeners();
    }
  }

  /// Clear all selections but stay in selection mode
  void clearSelections() {
    if (_selectedItems.isNotEmpty) {
      _selectedItems.clear();
      notifyListeners();
    }
  }

  /// Check if an item is selected
  bool isSelected(T item) {
    return _selectedItems.contains(item);
  }
}

/// A callback for when an action is selected from the contextual action bar
typedef ContextualActionCallback<T> = void Function(
  List<T> selectedItems,
  BuildContext context,
);

/// An action definition for the contextual action bar
class ContextualAction<T> {
  /// Icon to display
  final IconData icon;

  /// Title for the action (shown on larger screens or as tooltip)
  final String title;

  /// Callback when the action is pressed
  final ContextualActionCallback<T> onPressed;

  /// Optional condition to enable/disable the action
  final bool Function(List<T> selectedItems)? isEnabled;

  /// Optional color for the action
  final Color? color;

  ContextualAction({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isEnabled,
    this.color,
  });

  /// Check if this action should be enabled for the current selection
  bool shouldBeEnabled(List<T> selectedItems) {
    return isEnabled == null || isEnabled!(selectedItems);
  }
}

/// Reusable contextual action bar that can be used throughout the app
class ContextualActionBar<T> extends StatelessWidget
    implements PreferredSizeWidget {
  /// Controller managing the selection state
  final SelectionController<T> controller;

  /// Title to display in normal mode
  final String normalTitle;

  /// Actions to show in the contextual action bar
  final List<ContextualAction<T>> actions;

  /// Optional leading widget for normal mode
  final Widget? normalLeading;

  /// Optional actions for normal mode
  final List<Widget>? normalActions;

  /// Color for the normal app bar
  final Color? normalBackgroundColor;

  /// Color for the contextual app bar
  final Color? contextualBackgroundColor;

  /// Optional callback when exiting selection mode
  final VoidCallback? onExitSelectionMode;

  /// Whether to show a selection counter in the title
  final bool showSelectionCounter;

  /// Custom title builder for selection mode
  final Widget Function(BuildContext context, int count)? selectionTitleBuilder;

  @override
  final Size preferredSize;

  ContextualActionBar({
    super.key,
    required this.controller,
    required this.normalTitle,
    required this.actions,
    this.normalLeading,
    this.normalActions,
    this.normalBackgroundColor,
    this.contextualBackgroundColor,
    this.onExitSelectionMode,
    this.showSelectionCounter = true,
    this.selectionTitleBuilder,
    double toolbarHeight = kToolbarHeight,
  }) : preferredSize = Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return controller.isSelectionMode
            ? _buildContextualAppBar(context)
            : _buildNormalAppBar(context);
      },
    );
  }

  /// Build the normal app bar
  PreferredSizeWidget _buildNormalAppBar(BuildContext context) {
    return AppBar(
      title: Text(normalTitle),
      leading: normalLeading,
      actions: normalActions,
      backgroundColor: normalBackgroundColor,
    );
  }

  /// Build the contextual action bar
  PreferredSizeWidget _buildContextualAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          contextualBackgroundColor ?? Theme.of(context).colorScheme.primary,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          controller.exitSelectionMode();
          onExitSelectionMode?.call();
        },
      ),
      title: selectionTitleBuilder != null
          ? selectionTitleBuilder!(context, controller.selectedCount)
          : showSelectionCounter
              ? Text('${controller.selectedCount} selected')
              : const Text('Selected'),
      actions: actions
          .map((action) => IconButton(
                icon: Icon(action.icon, color: action.color),
                tooltip: action.title,
                onPressed: action.shouldBeEnabled(controller.selectedItems)
                    ? () => action.onPressed(controller.selectedItems, context)
                    : null,
              ))
          .toList(),
    );
  }
}

/// Wrapper widget to handle back button presses during selection mode
class SelectionAwareScaffold<T> extends StatelessWidget {
  /// Selection controller
  final SelectionController<T> controller;

  /// App bar to display (usually a ContextualActionBar)
  final PreferredSizeWidget appBar;

  /// Scaffold body
  final Widget body;

  /// Optional floating action button
  final Widget? floatingActionButton;

  /// Background color for the scaffold
  final Color? backgroundColor;

  /// Whether to resize to avoid the bottom inset
  final bool? resizeToAvoidBottomInset;

  /// Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Optional drawer
  final Widget? drawer;

  const SelectionAwareScaffold({
    super.key,
    required this.controller,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isSelectionMode) {
          controller.exitSelectionMode();
          return false;
        }
        return true;
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton:
                controller.isSelectionMode ? null : floatingActionButton,
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomNavigationBar: bottomNavigationBar,
            drawer: drawer,
          );
        },
      ),
    );
  }
}
