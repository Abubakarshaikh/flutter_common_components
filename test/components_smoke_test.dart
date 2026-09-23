import 'package:flutter/material.dart';
import 'package:flutter_common_components/buttons.dart';
import 'package:flutter_common_components/feedback.dart';
import 'package:flutter_common_components/inputs.dart';
import 'package:flutter_common_components/text.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every component must render inside a bare [MaterialApp] — no theme
/// extensions, no package-level setup.
void main() {
  Future<void> pumpBare(WidgetTester tester, Widget child) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(width: 320, child: child)),
      ),
    ),
  );

  final cases = <String, Widget>{
    'GradientFillButton': GradientFillButton(text: 'Go', onPressed: () {}),
    'GradientFillButton disabled': const GradientFillButton(
      text: 'Go',
      onPressed: null,
    ),
    'GradientFillButton loading': GradientFillButton(
      text: 'Go',
      onPressed: () {},
      isLoading: true,
    ),
    'OutlineFillButton': OutlineFillButton(
      text: 'Go',
      onPressed: () {},
      leading: const Icon(Icons.add),
    ),
    'SmallButton filled': SmallButton(
      onPressed: () {},
      icon: const Icon(Icons.home),
      type: SmallButtonType.filled,
    ),
    'SmallButton outline': SmallButton(
      onPressed: () {},
      icon: const Icon(Icons.home),
    ),
    'SmallButton icon': SmallButton(
      onPressed: () {},
      icon: const Icon(Icons.home),
      type: SmallButtonType.icon,
      tooltip: 'Home',
    ),
    'IconTextButton': IconTextButton(
      text: 'Edit',
      onPressed: () {},
      icon: const Icon(Icons.edit),
    ),
    'CircleIconButton': CircleIconButton(onTap: () {}),
    'CommonInputChip': const CommonInputChip(
      label: 'Category',
      isSelected: true,
      count: 3,
    ),
    'Skeleton': const Skeleton(width: 40, height: 40),
    'SizedLoadingIndicator': const SizedLoadingIndicator.small(),
    'RichTextWidget': RichTextWidget(
      texts: [
        const BaseText(text: 'Read the '),
        BaseText.link(text: 'terms', onTapped: () {}),
      ],
    ),
  };

  for (final entry in cases.entries) {
    testWidgets('${entry.key} renders without setup', (tester) async {
      await pumpBare(tester, entry.value);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('ThemeExtension overrides the fallback', (tester) async {
    const color = Color(0xFF123456);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [IconTextButtonTheme(foregroundColor: color)],
        ),
        home: Scaffold(
          body: IconTextButton(text: 'Edit', onPressed: () {}),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Edit'));
    expect(text.style?.color, color);
  });

  testWidgets('per-instance style wins over ThemeExtension', (tester) async {
    const themeColor = Color(0xFF123456);
    const instanceColor = Color(0xFF654321);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [IconTextButtonTheme(foregroundColor: themeColor)],
        ),
        home: Scaffold(
          body: IconTextButton(
            text: 'Edit',
            onPressed: () {},
            style: const IconTextButtonTheme(foregroundColor: instanceColor),
          ),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Edit'));
    expect(text.style?.color, instanceColor);
  });
}
