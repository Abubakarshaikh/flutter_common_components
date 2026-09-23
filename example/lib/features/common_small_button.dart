import 'package:flutter/material.dart';
import 'package:flutter_common_components/buttons.dart';

class CommonSmallButtonExample extends StatelessWidget {
  const CommonSmallButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Small Button")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SmallButton(
            onPressed: () {},
            icon: const Icon(Icons.home_work_outlined),
          ),
          const SizedBox(height: 12),
          SmallButton(
            type: SmallButtonType.filled,
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 12),
          SmallButton(
            isLoading: true,
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 12),
          const SmallButton(
            onPressed: null,
            icon: Icon(Icons.home),
          ),
          const SizedBox(height: 12),
          SmallButton(
            type: SmallButtonType.icon,
            tooltip: "Play",
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
