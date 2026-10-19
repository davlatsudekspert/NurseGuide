// Haqiqiy ilova ekranlari — iPhone 390x844 @3x (tool: flutter test --update-goldens
// test/screenshots). Maket emas: haqiqiy marshrutlar va haqiqiy savol banki.
import 'dart:io' show Platform;

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

// Faqat NG_SCREENSHOTS=1 bo'lganda ishlaydi (oddiy `flutter test` va CI'da o'tkazib yuboriladi):
//   NG_SCREENSHOTS=1 flutter test --update-goldens test/screenshots
final _on = Platform.environment['NG_SCREENSHOTS'] == '1';

void main() {
  setUpAll(loadAppFonts);

  Future<void> shot(
    WidgetTester tester,
    String name,
    String route, {
    AppRole role = AppRole.nurse,
    bool dark = false,
    double scale = 1,
    Size size = const Size(390, 844),
  }) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      role: role,
      backend: FakeBackend(),
      language: AppLanguage.uz,
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    );
    await pumpApp(
      tester,
      s,
      size: size,
      textScale: scale,
      platformBrightness: dark ? Brightness.dark : Brightness.light,
    );
    await goTo(tester, route);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 80)),
    );
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
    // Rasmlar testda asinxron yuklanadi: avval keshga olamiz.
    await tester.runAsync(() async {
      for (final e in find.byType(Image).evaluate().toList()) {
        await precacheImage((e.widget as Image).image, e);
      }
    });
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
    await expectLater(
      find.byType(MaterialApp).first,
      matchesGoldenFile('goldens/$name.png'),
    );
  }

  final screens = <(String, String, AppRole)>[
    ('01_home_nurse', '/home', AppRole.nurse),
    ('02_procedures', '/procedures', AppRole.nurse),
    ('03_workplace', '/workplace', AppRole.nurse),
    ('04_library', '/library', AppRole.nurse),
    ('05_learn', '/learn', AppRole.nurse),
    ('06_toifa', '/learn/toifa', AppRole.nurse),
    ('07_toifa_test', '/learn/toifa/test', AppRole.nurse),
    ('08_toifa_oral', '/learn/toifa/oral', AppRole.nurse),
    ('09_profile', '/profile', AppRole.nurse),
    ('10_theme', '/profile/theme', AppRole.nurse),
    ('11_home_student', '/home', AppRole.student),
    ('12_home_teacher', '/home', AppRole.teacher),
    ('13_classes_teacher', '/learn/classes', AppRole.teacher),
    ('14_procedure', '/procedures/teri_ichiga_inyeksiya', AppRole.nurse),
    ('15_glossary', '/library/glossary', AppRole.nurse),
    ('16_literature', '/library/literature', AppRole.nurse),
  ];
  for (final (name, route, role) in screens) {
    testWidgets(
      'light $name',
      (t) => shot(t, 'light_$name', route, role: role),
      skip: !_on,
    );
  }
  for (final (name, route, role) in [...screens.take(9), ...screens.skip(13)]) {
    testWidgets(
      'dark $name',
      (t) => shot(t, 'dark_$name', route, role: role, dark: true),
      skip: !_on,
    );
  }
  testWidgets(
    'small android 360x640 x1.3 home',
    (t) =>
        shot(t, 'small_home', '/home', scale: 1.3, size: const Size(360, 640)),
    skip: !_on,
  );
}
