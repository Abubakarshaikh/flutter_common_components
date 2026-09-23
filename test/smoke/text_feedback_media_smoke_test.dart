import 'package:flutter/material.dart';
import 'package:flutter_common_components/src/components/feedback/app_banner/app_banner.dart';
import 'package:flutter_common_components/src/components/feedback/app_empty_state/app_empty_state.dart';
import 'package:flutter_common_components/src/components/feedback/connection_banner/connection_banner.dart';
import 'package:flutter_common_components/src/components/feedback/connection_banner/connection_banner_theme.dart';
import 'package:flutter_common_components/src/components/feedback/empty_document_state/empty_document_state.dart';
import 'package:flutter_common_components/src/components/feedback/last_updated_by_badge/last_updated_by_badge.dart';
import 'package:flutter_common_components/src/components/media/app_icon/app_icon.dart';
import 'package:flutter_common_components/src/components/text/app_typography/app_typography.dart';
import 'package:flutter_common_components/src/components/text/tertiary_container_text/tertiary_container_text.dart';
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
    'AppTypography default': const AppTypography('Hello'),
    'AppTypography null text': const AppTypography(null),
    'AppTypography.titleLarge': AppTypography.titleLarge(
      'Title',
      fontWeight: FontWeight.w600,
      color: Colors.red,
    ),
    'AppTypography.bodySmall truncated': AppTypography.bodySmall(
      'A long description that gets cut',
      maxLines: 1,
      maxLength: 10,
      textAlign: TextAlign.start,
    ),
    'AppTypography.titleMediumPlus': AppTypography.titleMediumPlus('Plus'),
    'AppTypography.bodyXLarge no scaleUp': AppTypography.bodyXLarge(
      'XL',
      scaleUp: false,
    ),
    'AppTypography.labelSmall features': AppTypography.labelSmall(
      '123',
      fontFeatures: const [FontFeature.tabularFigures()],
    ),
    'TertiaryContainerText': const TertiaryContainerText(text: 'Section'),
    'AppBanner': AppBanner(
      message: 'Heads up',
      color: Colors.blue,
      leadingIcon: Icons.info_outline,
      trailingWidget: const Icon(Icons.close),
      onTap: () {},
    ),
    'AppBanner expanded trailing': const AppBanner(
      message: 'Heads up',
      color: Colors.blue,
      expandTrailingWidget: true,
      trailingWidget: Text('Action'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    'AppBanner.standard': const AppBanner.standard(
      message: 'Inspection mode',
      color: Colors.teal,
    ),
    'AppBanner.subscription': const AppBanner.subscription(
      message: 'View only',
    ),
    'ConnectionBanner offline': const ConnectionBanner(),
    'ConnectionBanner restored': const ConnectionBanner(isRestored: true),
    'ConnectionBanner styled': const ConnectionBanner(
      style: ConnectionBannerTheme(offlineColor: Colors.red),
      offlineMessage: 'Offline',
    ),
    'AppEmptyState minimal': const AppEmptyState(title: 'Nothing here'),
    'AppEmptyState full': AppEmptyState(
      title: 'No items',
      description: 'Create one to get started',
      actionLabel: 'Create',
      onActionPressed: () {},
    ),
    'AppEmptyState no icon': const AppEmptyState(
      title: 'Empty',
      showIcon: false,
    ),
    'EmptyDocumentState': EmptyDocumentState(
      icon: Icons.description_outlined,
      title: 'No documents',
      description: 'Add your first document',
      buttonText: 'Create',
      onCreatePressed: () {},
    ),
    'LastUpdatedByBadge': const LastUpdatedByBadge(
      text: '3rd March 2026 09:45:12 by Jane',
    ),
    'LastUpdatedByBadge null': const LastUpdatedByBadge(text: null),
    'LastUpdatedByBadge.fromDate': LastUpdatedByBadge.fromDate(
      DateTime(2026, 3, 3, 9, 45, 12),
      name: 'Jane',
    ),
    'AppIcon IconData': const AppIcon(Icons.home),
    'AppIcon background': const AppIcon(
      Icons.check,
      enableBackground: true,
      backgroundShape: BackgroundShape.roundedSquare,
    ),
    'AppIcon null': const AppIcon(null),
    'AppIcon unsupported type': const AppIcon(42, scaleOnLargeScreens: false),
  };

  for (final entry in cases.entries) {
    testWidgets('${entry.key} renders without setup', (tester) async {
      await pumpBare(tester, entry.value);
      expect(tester.takeException(), isNull);
    });
  }

  test('LastUpdatedByBadge.formatLastUpdatedBy', () {
    final date = DateTime(2026, 3, 1, 9, 5, 7);
    expect(
      LastUpdatedByBadge.formatLastUpdatedBy(date, name: 'Jane'),
      '1st March 2026 09:05:07 by Jane',
    );
    expect(
      LastUpdatedByBadge.formatLastUpdatedBy(
        DateTime(2026, 3, 12),
        showTime: false,
      ),
      '12th March 2026',
    );
  });

  testWidgets('AppTypography resolves from the theme text scale', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 30)),
        ),
        home: Scaffold(
          body: AppTypography.titleLarge('T', scaleUp: false, maxLength: 5),
        ),
      ),
    );
    final text = tester.widget<Text>(find.text('T'));
    expect(text.style?.fontSize, 30);
    expect(text.textAlign, TextAlign.center);
  });

  testWidgets('ConnectionBannerTheme extension overrides the fallback', (
    tester,
  ) async {
    const color = Color(0xFF123456);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [ConnectionBannerTheme(offlineColor: color)],
        ),
        home: const Scaffold(body: ConnectionBanner()),
      ),
    );
    final icon = tester.widget<Icon>(find.byIcon(Icons.wifi_off_rounded));
    expect(icon.color, color);
  });
}
