import 'package:flutter/material.dart';
import 'package:flutter_common_components/flutter_common_components.dart';
import 'package:flutter_common_components_example/features/buttons/common_buttons_example.dart';
import 'package:flutter_common_components_example/features/common_gradient_fill_button_example.dart';
import 'package:flutter_common_components_example/features/common_icon_text_button_example.dart';
import 'package:flutter_common_components_example/features/common_outline_fill_button_example.dart';
import 'package:flutter_common_components_example/features/common_small_button.dart';
import 'package:flutter_common_components_example/features/snack_bar/common_snack_bar_example.dart';
import 'package:flutter_common_components_example/features/text_field/common_text_field_example.dart';
import 'package:flutter_common_components_example/features/contextual_action_bar/contextual_action_bar_screen.dart';
import 'package:flutter_common_components_example/features/modalsheets/google_tasks_modal_sheet.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(),
        extensions: [
          WidgetToolkitTheme.light(),
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(),
        extensions: [
          WidgetToolkitTheme.dark(),
        ],
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plugin example app',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          CustomElevatedButton(
            onPressed: () {},
            title: "Input Chip",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonTextFieldExample(),
                ),
              );
            },
            title: "Text Field",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonSnackbarExample(),
                ),
              );
            },
            title: "Snackbar",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonSmallButtonExample(),
                ),
              );
            },
            title: "Small Button",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonOutlineFillButtonExample(),
                ),
              );
            },
            title: "Outline Fill Button",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonGradientFillButtonExample(),
                ),
              );
            },
            title: "Gradient Fill Button",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CommonIconTextButtonButtonExample(),
                ),
              );
            },
            title: "Icon Text Button",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GoogleTasksModalSheet(),
                ),
              );
            },
            title: "Google Tasks ModalSheet",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContextualActionBarScreen(),
                ),
              );
            },
            title: "Contextual Action Bar",
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonButtonsExample(),
                ),
              );
            },
            title: "Common Button",
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
        ),
      ),
    );
  }
}
