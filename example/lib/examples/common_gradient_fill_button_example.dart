import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonGradientFillButtonExample extends StatefulWidget {
  const CommonGradientFillButtonExample({
    super.key,
  });

  @override
  State<CommonGradientFillButtonExample> createState() =>
      _CommonGradientFillButtonExampleState();
}

class _CommonGradientFillButtonExampleState
    extends State<CommonGradientFillButtonExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Small Button"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          GradientFillButton(
            state: ButtonStateModel.loading,
            areIconsClose: true,
            text: "Test",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          GradientFillButton(
            state: ButtonStateModel.disabled,
            text: "Test",
            onPressed: () {},
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}
