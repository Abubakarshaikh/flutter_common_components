import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/app_char_limit_texts.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/app_text_field.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/app_text_field_theme.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/celsius_suffix.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/field_wrapper.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/remaining_char_counter.dart';
import 'package:flutter_common_components/src/components/inputs/app_text_field/text_field_clear_button.dart';
import 'package:flutter_common_components/src/components/inputs/form_field_label/form_field_label.dart';
import 'package:flutter_common_components/src/components/inputs/submit_on_focus_lost/submit_on_focus_lost.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpBare(WidgetTester tester, Widget child) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(width: 320, child: child)),
      ),
    ),
  );

  final filledController = TextEditingController(text: 'abc');
  final emptyController = TextEditingController();
  tearDownAll(() {
    filledController.dispose();
    emptyController.dispose();
  });

  final cases = <String, Widget>{
    'AppTextField': const AppTextField(hint: 'Hint'),
    'AppTextField.text': AppTextField.text(hint: 'Name', suffixString: 'kg'),
    'AppTextField.email': AppTextField.email(hint: 'Email'),
    'AppTextField.phone': AppTextField.phone(showBorder: false),
    'AppTextField.search': AppTextField.search(
      prefixWidget: const Icon(Icons.search),
    ),
    'AppTextField.temperature': AppTextField.temperature(
      suffixIcon: const CelsiusSuffix(),
    ),
    'AppTextField.time': AppTextField.time(enabled: false),
    'AppTextField.multiline': AppTextField.multiline(
      hint: 'Remarks',
      maxLength: 10,
      buildCounter: const RemainingCharCounter().call,
    ),
    'AppTextField style': AppTextField.text(
      style: const AppTextFieldTheme(borderColor: Colors.red, borderRadius: 4),
    ),
    'FieldWrapper stacked': FieldWrapper(
      title: 'Title',
      description: 'Description',
      showAsterisk: true,
      child: AppTextField.text(),
    ),
    'FieldWrapper inline in container': FieldWrapper(
      title: 'Title',
      layout: FieldTitleLayout.inline,
      wrapFieldInContainer: true,
      showAsterisk: true,
      child: AppTextField.text(showBorder: false),
    ),
    'FieldWrapper inlineVertical': FieldWrapper(
      title: 'Title',
      description: 'Description',
      layout: FieldTitleLayout.inlineVertical,
      child: AppTextField.text(),
    ),
    'TextFieldClearButton filled': TextFieldClearButton(
      controller: filledController,
      onCleared: () {},
    ),
    'TextFieldClearButton empty': TextFieldClearButton(
      controller: emptyController,
      onCleared: () {},
      whenEmpty: const Icon(Icons.calendar_today),
    ),
    'CelsiusSuffix': const CelsiusSuffix(),
    'FormFieldLabel': const FormFieldLabel(label: 'Label', child: Text('x')),
    'FormFieldLabel bordered': const FormFieldLabel(
      label: 'Label',
      showBorder: true,
      child: Text('x'),
    ),
    'SubmitOnFocusLost': SubmitOnFocusLost(
      onFocusLost: () {},
      child: AppTextField.text(),
    ),
  };

  for (final entry in cases.entries) {
    testWidgets('${entry.key} renders without setup', (tester) async {
      await pumpBare(tester, entry.value);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('RemainingCharCounter shows near the limit', (tester) async {
    await pumpBare(
      tester,
      AppTextField.text(
        controller: TextEditingController(text: '123456789'),
        maxLength: 10,
        buildCounter: const RemainingCharCounter().call,
      ),
    );
    expect(find.text('1 char remaining'), findsOneWidget);
  });

  testWidgets('limit formatter warns when typing past maxLength', (
    tester,
  ) async {
    String? reached;
    await pumpBare(
      tester,
      Builder(
        builder: (context) {
          final counter = RemainingCharCounter(
            onLimitReached: (_, message) => reached = message,
          );
          return AppTextField.text(
            maxLength: 3,
            inputFormatters: counter.formatters(
              context,
              maxLength: 3,
              additional: [LengthLimitingTextInputFormatter(3)],
            ),
          );
        },
      ),
    );
    await tester.enterText(find.byType(TextField), 'abcd');
    expect(reached, 'Character limit of 3 reached');
  });

  testWidgets('limit formatter falls back to a SnackBar', (tester) async {
    await pumpBare(
      tester,
      Builder(
        builder: (context) => AppTextField.text(
          inputFormatters: const RemainingCharCounter(
            texts: AppCharLimitTexts(),
          ).formatters(context, maxLength: 2),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('SubmitOnFocusLost fires only after focus is lost', (
    tester,
  ) async {
    var calls = 0;
    await pumpBare(
      tester,
      SubmitOnFocusLost(onFocusLost: () => calls++, child: AppTextField.text()),
    );
    expect(calls, 0);
    await tester.tap(find.byType(TextField));
    await tester.pump();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    expect(calls, 1);
  });

  testWidgets('AppTextFieldTheme extension overrides the fallback', (
    tester,
  ) async {
    const color = Color(0xFF123456);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [AppTextFieldTheme(cursorColor: color)],
        ),
        home: Scaffold(body: AppTextField.text()),
      ),
    );
    expect(tester.widget<TextField>(find.byType(TextField)).cursorColor, color);
  });
}
