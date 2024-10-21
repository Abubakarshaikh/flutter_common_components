import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonIconTextButtonButtonExample extends StatefulWidget {
  const CommonIconTextButtonButtonExample({
    super.key,
  });

  @override
  State<CommonIconTextButtonButtonExample> createState() =>
      _CommonIconTextButtonButtonExampleState();
}

class _CommonIconTextButtonButtonExampleState
    extends State<CommonIconTextButtonButtonExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Icon Text Button"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          IconTextButton(
            icon: Icons.abc,
            text: "Test",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          IconTextButton(
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
