import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonSmallButtonExample extends StatefulWidget {
  const CommonSmallButtonExample({
    super.key,
  });

  @override
  State<CommonSmallButtonExample> createState() =>
      _CommonSmallButtonExampleState();
}

class _CommonSmallButtonExampleState extends State<CommonSmallButtonExample> {
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
          SmallButton(
            onPressed: () {},
            icon: Icons.home_work_outlined,
          ),
          const SizedBox(height: 12),
          SmallButton(
            onPressed: () {},
            icon: Icons.arrow_back,
          ),
          const SizedBox(height: 12),
          SmallButton(
            state: ButtonStateModel.loading,
            onPressed: () {},
            icon: Icons.arrow_back,
          ),
          const SizedBox(height: 12),
          SmallButton(
            state: ButtonStateModel.disabled,
            onPressed: () {},
            icon: Icons.home,
          ),
          const SizedBox(height: 12),
          SmallButton(
            state: ButtonStateModel.pressed,
            onPressed: () {},
            icon: Icons.play_arrow,
          ),
          const SizedBox(height: 12),
          SmallButton(
            tooltip: "Press",
            state: ButtonStateModel.pressed,
            onPressed: () {},
            icon: Icons.play_arrow,
          ),
        ],
      ),
    );
  }
}
