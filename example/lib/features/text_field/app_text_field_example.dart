import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class AppTextFieldExample extends StatefulWidget {
  const AppTextFieldExample({super.key});

  @override
  State<AppTextFieldExample> createState() => _AppTextFieldExampleState();
}

class _AppTextFieldExampleState extends State<AppTextFieldExample> {
  final _searchController = TextEditingController();
  static const _counter = RemainingCharCounter();
  static const _remarksLimit = 60;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Fields')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          FieldWrapper(
            title: 'Name',
            showAsterisk: true,
            child: AppTextField.text(
              hint: 'Jane Doe',
              validation: (v) => (v ?? '').isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 12),
          FieldWrapper(
            title: 'Email',
            layout: FieldTitleLayout.inline,
            child: AppTextField.email(hint: 'jane@example.com'),
          ),
          const SizedBox(height: 12),
          AppTextField.search(
            controller: _searchController,
            hint: 'Search',
            prefixWidget: const Icon(Icons.search),
            suffixIcon: TextFieldClearButton(
              controller: _searchController,
              onCleared: _searchController.clear,
            ),
          ),
          const SizedBox(height: 12),
          FormFieldLabel(
            label: 'Fridge temperature',
            left: 0,
            right: 0,
            child: SubmitOnFocusLost(
              onFocusLost: () {},
              child: AppTextField.temperature(
                hint: '0.0',
                suffixIcon: const CelsiusSuffix(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FieldWrapper(
            title: 'Remarks',
            description: 'Anything worth noting for the next shift.',
            child: AppTextField.multiline(
              hint: 'Remarks',
              maxLength: _remarksLimit,
              buildCounter: _counter.call,
              inputFormatters: _counter.formatters(
                context,
                maxLength: _remarksLimit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
