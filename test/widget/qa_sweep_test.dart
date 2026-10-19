// QA aylanish testi: haqiqiy kontent (880 savol, muolajalar, lug'at,
// adabiyotlar) bilan barcha asosiy ekranlar 3 tilda, yorug'/qorong'i
// rejimda, oddiy va kichik ekranda (360x640, shrift 1.3x) ochiladi.
// Overflow, istisno yoki "xom" kalit (l10n) chiqsa test yiqiladi.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show Size;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Brightness, ThemeMode;
import 'package:nurseguide/features/reference/reference_data.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

const _baseRoutes = <String>[
  '/home',
  '/procedures',
  '/workplace',
  '/library',
  '/library/glossary',
  '/library/literature',
  '/library/saved',
  '/library/sources',
  '/learn',
  '/learn/daily',
  '/learn/toifa',
  '/learn/toifa/test',
  '/learn/toifa/oral',
  '/profile',
  '/profile/theme',
];

void main() {
  setUpAll(loadAppFonts);

  final configs = <(String, AppLanguage, bool, Size, double)>[
    ('uz light 390x844', AppLanguage.uz, false, const Size(390, 844), 1),
    ('ru dark 390x844', AppLanguage.ru, true, const Size(390, 844), 1),
    ('en light 360x640 x1.3', AppLanguage.en, false, const Size(360, 640), 1.3),
    ('uz dark 360x640 x1.3', AppLanguage.uz, true, const Size(360, 640), 1.3),
  ];

  for (final (name, lang, dark, size, scale) in configs) {
    testWidgets('QA aylanish: $name', (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        language: lang,
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      );
      await pumpApp(
        tester,
        s,
        size: size,
        textScale: scale,
        platformBrightness: dark ? Brightness.dark : Brightness.light,
      );
      final data = await tester.runAsync(
        () => ReferenceData.load(s.curriculum.bundle ?? rootBundle),
      );
      final routes = [
        ..._baseRoutes,
        for (final p in data!.procedures) '/procedures/${p.id}',
        for (final u in data.usage()) '/library/literature/${u.entry.id}',
      ];
      final problems = <String>[];
      for (final route in routes) {
        await goTo(tester, route);
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 30)),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        final e = tester.takeException();
        if (e != null)
          problems.add('$route → ${e.toString().split('\n').first}');
      }
      expect(problems, isEmpty, reason: problems.join('\n'));
    });
  }
}
