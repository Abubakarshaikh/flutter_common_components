import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonTextFieldExample extends StatelessWidget {
  const CommonTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Display Components',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CommonTextField.standard(),
            const SizedBox(height: 12),
            CommonTextField.standard(),
          ],
        ),
      ),
    );
  }
}
