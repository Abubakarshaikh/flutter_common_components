import 'package:flutter/material.dart';
import 'package:flutter_common_components/src/components/layout/app_card/app_card.dart';
import 'package:flutter_common_components/src/components/layout/app_card/app_card_theme.dart';
import 'package:flutter_common_components/src/components/layout/app_expansion_tile/app_expansion_tile.dart';
import 'package:flutter_common_components/src/components/layout/app_gap/app_gap.dart';
import 'package:flutter_common_components/src/components/layout/app_responsive_sizebox/app_responsive_sizebox.dart';
import 'package:flutter_common_components/src/components/layout/app_scaffold/app_scaffold.dart';
import 'package:flutter_common_components/src/components/layout/app_single_child_scroll_view/app_single_child_scroll_view.dart';
import 'package:flutter_common_components/src/components/layout/app_tablet_content_constraint/app_tablet_content_constraint.dart';
import 'package:flutter_common_components/src/components/layout/app_tile/app_tile.dart';
import 'package:flutter_common_components/src/components/layout/common_app_bar/common_app_bar.dart';
import 'package:flutter_common_components/src/components/layout/custom_container/custom_container.dart';
import 'package:flutter_common_components/src/components/layout/expandable_content/expandable_content.dart';
import 'package:flutter_common_components/src/components/layout/keyboard_dismiss_wrapper/keyboard_dismiss_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every layout component must render inside a bare [MaterialApp].
void main() {
  Future<void> pumpBare(WidgetTester tester, Widget child) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(width: 320, child: child)),
      ),
    ),
  );

  const longText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim '
      'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut '
      'aliquip ex ea commodo consequat.';

  final cases = <String, Widget>{
    'AppGap vertical': const AppGap.vertical(16),
    'AppGap with child': const AppGap(width: 24, height: 12, child: Text('x')),
    'AppGap square': const AppGap.square(8),
    'AppResponsiveSizeBox': const AppResponsiveSizeBox(
      widthFactor: 0.5,
      heightFactor: 0.1,
      alignment: Alignment.center,
      child: Text('Sized'),
    ),
    'KeyboardDismissWrapper': const KeyboardDismissWrapper(child: TextField()),
    'AppSingleChildScrollView default padding': const SizedBox(
      height: 200,
      child: AppSingleChildScrollView(child: Text(longText)),
    ),
    'AppSingleChildScrollView custom padding': const SizedBox(
      height: 200,
      child: AppSingleChildScrollView(
        padding: EdgeInsets.all(4),
        child: Text(longText),
      ),
    ),
    'AppTabletContentConstraint phone': const AppTabletContentConstraint(
      child: Text('Content'),
    ),
    'CommonContainer': const CommonContainer(child: Text('Boxed')),
    'CommonContainer colored': const CommonContainer(
      color: Colors.amber,
      margin: EdgeInsets.all(8),
      child: Text('Boxed'),
    ),
    'AppCard': AppCard(onTap: () {}, child: const Text('Card')),
    'AppCard outlined variant': const AppCard(
      variant: CardVariant.outlined,
      child: Text('Card'),
    ),
    'AppCard.custom': AppCard.custom(
      hasBorder: true,
      elevation: 4,
      borderRadius: 16,
      child: const Text('Custom'),
    ),
    'AppCard.flat': AppCard.flat(child: const Text('Flat')),
    'AppCard.outlined': AppCard.outlined(child: const Text('Outlined')),
    'AppCard.circular': AppCard.circular(
      hasBorder: true,
      elevation: 2,
      child: const Icon(Icons.person),
    ),
    'AppCard.transparent': AppCard.transparent(
      hasBorder: true,
      child: const Text('Clear'),
    ),
    'AppCard.elevated': AppCard.elevated(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: const Text('Elevated'),
    ),
    'ExpandableContent short': const ExpandableContent(child: Text('Short')),
    'ExpandableContent long': const ExpandableContent(
      maxLines: 1,
      child: Text(longText),
    ),
    'AppExpansionTile': const AppExpansionTile(
      title: 'Section',
      children: [Text('Child')],
    ),
    'AppExpansionTile custom trailing': const AppExpansionTile(
      title: 'Section',
      initiallyExpanded: true,
      trailing: Icon(Icons.add),
      expandedTrailing: Icon(Icons.remove),
      borderColor: Colors.grey,
      children: [Text('Child')],
    ),
    'AppTile': const AppTile(title: 'Title', subtitle: 'Subtitle'),
    'AppTile.navigation': AppTile.navigation(title: 'Go', onTap: () {}),
    'AppTile.action': AppTile.action(title: 'Add', onTap: () {}),
    'AppTile.sheetAction': AppTile.sheetAction(
      title: 'Share',
      icon: Icons.share,
      onTap: () {},
    ),
    'AppTile.sheetAction disabled': AppTile.sheetAction(
      title: 'Share',
      icon: Icons.share,
      enabled: false,
    ),
    'AppTile.info': AppTile.info(title: 'Info', subtitle: 'Details'),
    'AppTile.card': AppTile.card(title: 'Card', trailing: const Text('>')),
    'AppTile.custom': AppTile.custom(titleWidget: const Text('Custom')),
  };

  for (final entry in cases.entries) {
    testWidgets('${entry.key} renders without setup', (tester) async {
      await pumpBare(tester, entry.value);
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  }

  final appBars = <String, PreferredSizeWidget>{
    'CommonAppBar': const CommonAppBar(title: 'Home'),
    'CommonAppBar info': CommonAppBar(
      title: 'Reports',
      onInfoTap: () {},
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
    ),
    'CommonAppBar read more': const CommonAppBar(
      title: longText,
      titleReadMore: true,
      titleMaxLines: 1,
    ),
    'CommonAppBar contextual': CommonAppBar(
      title: '3 selected',
      enableContextualActionBar: true,
      onClosed: () {},
      onSelect: () {},
    ),
    'CommonAppBar titleWidget': const CommonAppBar(
      titleWidget: Text('Widget'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: SizedBox(height: 4),
      ),
    ),
  };

  for (final entry in appBars.entries) {
    testWidgets('${entry.key} renders without setup', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(appBar: entry.value, body: const SizedBox()),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('AppScaffold renders banner and body', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(
          appBar: CommonAppBar(title: 'Scaffold'),
          banner: Text('Banner'),
          body: Text('Body'),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Banner'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
  });

  testWidgets('AppScaffold guest mode renders body only', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(mode: AppScaffoldMode.guest, body: Text('Body')),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('AppTabletContentConstraint constrains on tablets', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1024, 768);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: AppTabletContentConstraint(
          child: SizedBox.expand(key: Key('content')),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byKey(const Key('content'))).width, 960);
  });

  testWidgets('ExpandableContent toggles when overflowing', (tester) async {
    await pumpBare(
      tester,
      const ExpandableContent(maxLines: 1, child: Text(longText)),
    );
    await tester.pump();
    expect(find.text('More Info'), findsOneWidget);
    await tester.tap(find.text('More Info'));
    await tester.pump();
    expect(find.text('Less Info'), findsOneWidget);
  });

  testWidgets('AppExpansionTile expands on tap', (tester) async {
    await pumpBare(
      tester,
      const AppExpansionTile(title: 'Section', children: [Text('Child')]),
    );
    await tester.tap(find.text('Section'));
    await tester.pumpAndSettle();
    expect(find.text('Child'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('CommonCardStyle ThemeExtension overrides defaults', (
    tester,
  ) async {
    const color = Color(0xFF123456);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [CommonCardStyle(backgroundColor: color)],
        ),
        home: const Scaffold(body: AppCard(child: Text('Themed'))),
      ),
    );
    final material = tester.widget<Material>(
      find
          .ancestor(of: find.text('Themed'), matching: find.byType(Material))
          .first,
    );
    expect(material.color, color);
  });
}
