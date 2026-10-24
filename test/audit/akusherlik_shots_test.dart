// Akusherlik yo'nalishi rasmlari (faqat NG_AK_SHOTS=1): natija /tmp/ng_ak/*.png
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final _on = Platform.environment['NG_AK_SHOTS'] == '1';

Future<void> _shot(WidgetTester t, String name) async {
  await t.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 60)),
  );
  await t.pumpAndSettle(const Duration(milliseconds: 300));
  await expectLater(
    find.byType(MaterialApp).first,
    matchesGoldenFile('../../../../../tmp/ng_ak/$name.png'),
  );
}

void main() {
  setUpAll(loadAppFonts);
  testWidgets('akusherlik', (tester) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
    );
    s.toifa.random = Random(3);
    await pumpApp(tester, s, size: const Size(390, 844));
    await goTo(tester, '/workplace');
    await _shot(tester, '1_workplace_directions');
    await goTo(tester, '/learn/toifa/test');
    await _shot(tester, '2_toifa_scope_chips');
    await tester.tap(find.byKey(const ValueKey('toifa-scope-akusherlik')));
    await tester.pumpAndSettle();
    await _shot(tester, '3_akusherlik_selected');
    await goTo(tester, '/learn/toifa/practice');
    await tester.tap(find.byKey(const ValueKey('toifa-scope-akusherlik')));
    await tester.pumpAndSettle();
    await _shot(tester, '4_practice_akusherlik');
  }, skip: !_on);
}
