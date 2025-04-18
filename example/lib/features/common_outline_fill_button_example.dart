import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonOutlineFillButtonExample extends StatefulWidget {
  const CommonOutlineFillButtonExample({
    super.key,
  });

  @override
  State<CommonOutlineFillButtonExample> createState() =>
      _CommonOutlineFillButtonExampleState();
}

class _CommonOutlineFillButtonExampleState
    extends State<CommonOutlineFillButtonExample> {
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
          OutlineFillButton(
            text: "Test",
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          OutlineFillButton(
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
