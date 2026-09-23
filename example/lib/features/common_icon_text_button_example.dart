import 'package:flutter/material.dart';
import 'package:flutter_common_components/buttons.dart';

class CommonIconTextButtonButtonExample extends StatelessWidget {
  const CommonIconTextButtonButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Icon Text Button")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          IconTextButton(
            icon: const Icon(Icons.abc),
            text: "Test",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          const IconTextButton(
            text: "Disabled",
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
