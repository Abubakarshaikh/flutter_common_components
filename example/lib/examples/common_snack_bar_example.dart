import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';

class CommonSnackbarExample extends StatefulWidget {
  const CommonSnackbarExample({
    super.key,
  });

  @override
  State<CommonSnackbarExample> createState() => _CommonSnackbarExampleState();
}

class _CommonSnackbarExampleState extends State<CommonSnackbarExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snackbar"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const CommonSnackBar().build(context) as SnackBar,
              );
            },
            child: const Text('Simple'),
          ),
        ],
      ),
    );
  }
}
