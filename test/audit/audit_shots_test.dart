// Audit rasmlari (faqat NG_AUDIT_SHOTS=1): asosiy ekranlar ko'rinishi.
//   NG_AUDIT_SHOTS=1 flutter test --update-goldens test/audit/audit_shots_test.dart
// Natija: /tmp/ng_shots/<konfiguratsiya>/<marshrut>.png (golden yo'li nisbiy).
import 'dart:io' show Platform;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final _on = Platform.environment['NG_AUDIT_SHOTS'] == '1';

const _routes = <String>[
  '/home',
  '/procedures',
  '/procedures/teri_ichiga_inyeksiya',
  '/procedures/vena_ichiga_inyeksiya',
  '/workplace',
  '/library',
  '/library/glossary',
  '/library/dmed',
  '/library/literature',
  '/library/literature/inomov2007',
  '/learn',
  '/learn/daily',
  '/learn/toifa',
  '/learn/toifa/test',
  '/learn/toifa/practice',
  '/learn/toifa/oral',
  '/learn/toifa/progress',
  '/learn/classes',
  '/profile',
  '/profile/privacy',
  '/terms',
];

class _C {
  const _C(this.name, this.lang, this.dark, this.size, this.scale, this.routes);
  final String name;
  final AppLanguage lang;
  final bool dark;
  final Size size;
  final double scale;
  final List<String> routes;
}

const _keyRoutes = <String>[
  '/home',
  '/procedures',
  '/procedures/teri_ichiga_inyeksiya',
  '/workplace',
  '/library',
  '/learn',
  '/learn/toifa/test',
  '/profile',
];

final _cs = <_C>[
  _C(
    'uz_light_iphone',
    AppLanguage.uz,
    false,
    const Size(390, 844),
    1,
    _routes,
  ),
  _C(
    'ru_light_iphone',
    AppLanguage.ru,
    false,
    const Size(390, 844),
    1,
    _routes,
  ),
  _C(
    'en_light_iphone',
    AppLanguage.en,
    false,
    const Size(390, 844),
    1,
    _routes,
  ),
  _C(
    'uz_dark_iphone',
    AppLanguage.uz,
    true,
    const Size(390, 844),
    1,
    _keyRoutes,
  ),
  _C(
    'uz_light_android13',
    AppLanguage.uz,
    false,
    const Size(360, 640),
    1.3,
    _keyRoutes,
  ),
  _C(
    'ru_dark_android13',
    AppLanguage.ru,
    true,
    const Size(360, 640),
    1.3,
    _keyRoutes,
  ),
];

void main() {
  setUpAll(loadAppFonts);
  for (final c in _cs) {
    testWidgets('shots ${c.name}', (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        language: c.lang,
        themeMode: c.dark ? ThemeMode.dark : ThemeMode.light,
      );
      await pumpApp(
        tester,
        s,
        size: c.size,
        textScale: c.scale,
        platformBrightness: c.dark ? Brightness.dark : Brightness.light,
      );
      for (final r in c.routes) {
        await goTo(tester, r);
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 60)),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await expectLater(
          find.byType(MaterialApp).first,
          matchesGoldenFile(
            '../../../../../tmp/ng_shots/${c.name}/${r.replaceAll(RegExp('[^a-zA-Z0-9]+'), '_')}.png',
          ),
        );
      }
    }, skip: !_on);
  }
}
