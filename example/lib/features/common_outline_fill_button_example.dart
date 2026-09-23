import 'package:flutter/material.dart';
import 'package:flutter_common_components/buttons.dart';

class CommonOutlineFillButtonExample extends StatelessWidget {
  const CommonOutlineFillButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Outline Fill Button")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          OutlineFillButton(
            text: "Test",
            leading: const Icon(Icons.add),
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          const OutlineFillButton(
            text: "Disabled",
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
