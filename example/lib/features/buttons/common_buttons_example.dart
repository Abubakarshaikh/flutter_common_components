import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';
import 'package:flutter_common_components_example/features/buttons/common_app_bar.dart';

class CommonButtonsExample extends StatelessWidget {
  const CommonButtonsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Common Buttons"),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        children: [
          CommonButton.primary(
            text: "Submit",
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          CommonButton.secondary(
            text: "Submit",
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          CommonButton.outline(
            text: "Submit",
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          CommonButton.circularIcon(
            // text: "Submit",
            icon: Icons.add,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          CommonButton.primary(
            text: "Submit",
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          CommonButton.outline(
            text: "Submit",
            prefix: Icon(
              Icons.add_circle_rounded,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
