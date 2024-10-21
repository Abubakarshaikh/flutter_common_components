import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    required this.appBarTitle,
    super.key,
    this.body,
    this.actions,
  });
  final Widget? body;
  final String appBarTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        actions: actions,
      ),
      body: body,
    );
  }
}
