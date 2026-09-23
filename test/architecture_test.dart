import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// Enforces the layering rules:
///
/// * a component may import only Dart/Flutter/third-party packages and files
///   inside its own folder — never another component, the theme layer or the
///   foundation layer;
/// * `foundation/` never imports `theme/` or `components/`;
/// * `theme/` never imports `components/`.
void main() {
  final srcDir = Directory(p.join('lib', 'src'));
  final importPattern = RegExp(
    r'''^\s*(?:import|export|part)\s+['"]([^'"]+)['"]''',
    multiLine: true,
  );

  Iterable<File> dartFiles(String relativeDir) =>
      Directory(p.join(srcDir.path, relativeDir))
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'));

  /// Resolves every package-internal import of [file] to a path under lib/.
  List<String> internalImports(File file) {
    final imports = <String>[];
    for (final match in importPattern.allMatches(file.readAsStringSync())) {
      final uri = match.group(1)!;
      if (uri.startsWith('dart:')) continue;
      if (uri.startsWith('package:flutter_common_components/')) {
        imports.add(
          p.normalize(
            p.join(
              'lib',
              uri.substring('package:flutter_common_components/'.length),
            ),
          ),
        );
      } else if (!uri.startsWith('package:')) {
        imports.add(p.normalize(p.join(p.dirname(file.path), uri)));
      }
    }
    return imports;
  }

  test('components only import files from their own folder', () {
    final componentsRoot = p.join(srcDir.path, 'components');
    final violations = <String>[];

    for (final file in dartFiles('components')) {
      final ownFolder = p.dirname(file.path);
      for (final target in internalImports(file)) {
        if (!p.isWithin(ownFolder, target)) {
          violations.add(
            '${p.relative(file.path, from: componentsRoot)} -> $target',
          );
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('foundation depends on nothing else in the package', () {
    final violations = <String>[
      for (final file in dartFiles('foundation'))
        for (final target in internalImports(file))
          if (!p.isWithin(p.join(srcDir.path, 'foundation'), target))
            '${file.path} -> $target',
    ];

    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('theme never depends on components', () {
    final violations = <String>[
      for (final file in dartFiles('theme'))
        for (final target in internalImports(file))
          if (p.isWithin(p.join(srcDir.path, 'components'), target))
            '${file.path} -> $target',
    ];

    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
