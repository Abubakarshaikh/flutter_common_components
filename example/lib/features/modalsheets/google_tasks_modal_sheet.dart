import 'package:flutter/material.dart';

class GoogleTasksModalSheet extends StatefulWidget {
  const GoogleTasksModalSheet({super.key});

  @override
  State<GoogleTasksModalSheet> createState() => _GoogleTasksModalSheetState();
}

class _GoogleTasksModalSheetState extends State<GoogleTasksModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Add this line
            backgroundColor: Colors.transparent,
            builder: (context) => const ModalSheet(),
          );
        },
      ),
    );
  }
}

class ModalSheet extends StatelessWidget {
  const ModalSheet({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: mediaQuery),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        children: const [
          Text("Add Data"),
          Icon(Icons.ad_units, size: 90),
          Icon(Icons.ad_units, size: 90),
          Icon(Icons.ad_units, size: 90),
          Icon(Icons.ad_units, size: 90),
          TextField(
            textAlign: TextAlign.justify,
            // autofocus: true,
            maxLines: null, // Important: allows multiple lines
            textInputAction:
                TextInputAction.newline, // Enables enter key for new lines
            keyboardType: TextInputType.multiline, // Enables multiline input
            decoration: InputDecoration(
              border: InputBorder.none, // Optional: removes the underline
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              hintText: 'Add your text here',
            ),
          ),
        ],
      ),
    );
  }
}
