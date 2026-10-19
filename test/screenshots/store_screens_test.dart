// App Store skrinshotlari (inglizcha interfeys, haqiqiy marshrutlar va haqiqiy
// savol banki): iPhone 6.9" (1290×2796) va iPad 13" (2064×2752), har biri 7 ta.
// Faqat NG_STORE_SHOTS=1 bo'lganda ishlaydi:
//   NG_STORE_SHOTS=1 flutter test --update-goldens test/screenshots/store_screens_test.dart
// Natija: docs/store/screenshots/{iphone_6_9,ipad_13}/NN_nom.png
import 'dart:io' show Platform;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final _on = Platform.environment['NG_STORE_SHOTS'] == '1';

class _Device {
  const _Device(this.dir, this.logical, this.ratio, this.top, this.bottom);

  final String dir;
  final Size logical;
  final double ratio;
  final double top;
  final double bottom;
}

const _devices = [
  _Device('iphone_6_9', Size(430, 932), 3, 59, 34),
  _Device('ipad_13', Size(1032, 1376), 2, 24, 20),
];

/// (fayl nomi, marshrut, ish yo'nalishi)
const _screens = <(String, String, WorkDirection?)>[
  ('01_home', '/home', null),
  ('02_procedures', '/procedures', null),
  ('03_procedure_steps', '/procedures/teri_ichiga_inyeksiya', null),
  ('04_workplace', '/workplace', WorkDirection.nursing),
  ('05_learn', '/learn', null),
  ('06_library', '/library', null),
  ('07_dmed', '/library/dmed', null),
];

void main() {
  setUpAll(loadAppFonts);

  for (final d in _devices) {
    for (final (name, route, direction) in _screens) {
      testWidgets('${d.dir} $name', (tester) async {
        final s = await makeServices(
          tester,
          bundle: rootBundle,
          role: AppRole.nurse,
          backend: FakeBackend(),
          language: AppLanguage.en,
        );
        if (direction != null) await s.settings.setWorkDirection(direction);
        await pumpApp(tester, s, size: d.logical, ratio: d.ratio, notch: false);
        tester.view.padding = FakeViewPadding(
          top: d.top * d.ratio,
          bottom: d.bottom * d.ratio,
        );
        await goTo(tester, route);
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 120)),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await tester.runAsync(() async {
          for (final e in find.byType(Image).evaluate().toList()) {
            await precacheImage((e.widget as Image).image, e);
          }
        });
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await expectLater(
          find.byType(MaterialApp).first,
          matchesGoldenFile('../../docs/store/screenshots/${d.dir}/$name.png'),
        );
      }, skip: !_on);
    }
  }
}
