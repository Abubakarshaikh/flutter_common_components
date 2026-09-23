import 'package:flutter/material.dart';
import 'package:flutter_common_components/buttons.dart';

class CommonGradientFillButtonExample extends StatelessWidget {
  const CommonGradientFillButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gradient Fill Button")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          GradientFillButton(
            text: "Continue",
            trailing: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          GradientFillButton(
            isLoading: true,
            areIconsClose: true,
            text: "Loading",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          const GradientFillButton(
            text: "Disabled",
            onPressed: null,
          ),
          const SizedBox(height: 12),
          GradientFillButton(
            text: "Custom style",
            onPressed: () {},
            style: const GradientFillButtonTheme(
              gradientStart: Colors.purple,
              gradientEnd: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
