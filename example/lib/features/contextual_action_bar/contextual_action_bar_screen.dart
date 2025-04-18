import 'package:flutter/material.dart';
import 'package:flutter_common_components_example/features/contextual_action_bar/contextual_action_bar.dart';

// Example with list of items
class ContextualActionBarScreen extends StatefulWidget {
  const ContextualActionBarScreen({super.key});

  @override
  State<ContextualActionBarScreen> createState() =>
      _ContextualActionBarScreenState();
}

class _ContextualActionBarScreenState extends State<ContextualActionBarScreen> {
  // Create a selection controller for your item type
  final SelectionController<String> _selectionController =
      SelectionController<String>();

  // Example list of items
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  void dispose() {
    _selectionController.dispose(); // Don't forget to dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define your contextual actions
    final List<ContextualAction<String>> actions = [
      ContextualAction<String>(
        icon: Icons.edit,
        title: 'edit',
        isEnabled: (items) =>
            items.length == 1, // Only enable for single selection
        onPressed: (items, context) {
          // Handle edit action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Editing ${items.first}')),
          );
          _selectionController.exitSelectionMode();
        },
      ),
      ContextualAction<String>(
        icon: Icons.delete,
        title: 'delete',
        color: Colors.red,
        onPressed: (items, context) {
          // Handle delete action
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('delete_confirmation_title'),
              content: Text(items.length == 1
                  ? 'delete_confirmation'
                  : 'delete_multiple_confirmation'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deleted ${items.length} items')),
                    );
                    _selectionController.exitSelectionMode();
                  },
                  child: const Text('delete'),
                ),
              ],
            ),
          );
        },
      ),
      ContextualAction<String>(
        icon: Icons.share,
        title: 'share',
        onPressed: (items, context) {
          // Handle share action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sharing ${items.length} items')),
          );
          _selectionController.exitSelectionMode();
        },
      ),
    ];

    return SelectionAwareScaffold(
      controller: _selectionController,
      appBar: ContextualActionBar<String>(
        controller: _selectionController,
        normalTitle: 'items',
        actions: actions,
        normalBackgroundColor: Theme.of(context).colorScheme.secondary,
        contextualBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return AnimatedBuilder(
            animation: _selectionController,
            builder: (context, child) {
              final isSelected = _selectionController.isSelected(item);
              return ListTile(
                title: Text(item),
                selected: isSelected,
                selectedTileColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                leading: _selectionController.isSelectionMode
                    ? Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          if (value == true) {
                            _selectionController.selectItem(item);
                          } else {
                            _selectionController.deselectItem(item);
                          }
                        },
                      )
                    : const Icon(Icons.article),
                onTap: () {
                  if (_selectionController.isSelectionMode) {
                    // In selection mode, toggle selection
                    _selectionController.toggleSelection(item);
                  } else {
                    // Not in selection mode, handle normal tap
                    // For example, navigate to details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on $item')),
                    );
                  }
                },
                onLongPress: () {
                  // Long press to enter selection mode and select the item
                  if (!_selectionController.isSelectionMode) {
                    _selectionController.toggleSelection(item);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Example with custom data model
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final SelectionController<Product> _selectionController =
      SelectionController<Product>();

  final List<Product> products = [
    Product(id: '1', name: 'Product 1', price: 10.99),
    Product(id: '2', name: 'Product 2', price: 19.99),
    Product(id: '3', name: 'Product 3', price: 5.99),
  ];

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionAwareScaffold(
      controller: _selectionController,
      appBar: ContextualActionBar<Product>(
        controller: _selectionController,
        normalTitle: 'products',
        actions: [
          ContextualAction<Product>(
            icon: Icons.edit,
            title: 'edit',
            isEnabled: (items) => items.length == 1,
            onPressed: (items, context) {
              // Edit action
            },
          ),
          ContextualAction<Product>(
            icon: Icons.delete,
            title: 'delete',
            color: Colors.red,
            onPressed: (items, context) {
              // Delete action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return AnimatedBuilder(
            animation: _selectionController,
            builder: (context, child) {
              final isSelected = _selectionController.isSelected(product);
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                selected: isSelected,
                onTap: () {
                  if (_selectionController.isSelectionMode) {
                    _selectionController.toggleSelection(product);
                  } else {
                    // Normal tap action
                  }
                },
                onLongPress: () {
                  if (!_selectionController.isSelectionMode) {
                    _selectionController.toggleSelection(product);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
