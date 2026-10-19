// Foydalanuvchi yo'li, HAQIQIY savollar ro'yxati (880 ta): toifa mashq rejimida
// 50 savolning hammasi ekrandan javoblanadi (oddiy va kichik ekranda), natija
// ko'rinadi; istisno yoki overflow bo'lmasligi shart.
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final uz = lookupAppLocalizations(const Locale('uz'));
final _ios = TargetPlatformVariant.only(TargetPlatform.iOS);

Future<void> _walk(
  WidgetTester tester,
  Size size,
  double scale,
  int seed,
) async {
  final s = await makeServices(tester, bundle: rootBundle);
  s.toifa.random = Random(seed);
  await pumpApp(tester, s, size: size, textScale: scale);
  await goTo(tester, '/learn/toifa/test');
  await tester.tap(find.byKey(const ValueKey('toifa-mode-practice')));
  await tester.pumpAndSettle();
  await tapScroll(tester, uz.toifaDrillStart);
  var answered = 0;
  while (s.toifa.activeDrill != null && answered < 60) {
    final d = s.toifa.activeDrill!;
    final q = s.toifa.bank!.test(d.ids[d.index])!;
    // Har xil variant: savol raqamiga qarab.
    final idx = answered % q.optionCount;
    await tapScroll(tester, q.option(idx, 'uz'));
    expect(tester.takeException(), isNull, reason: '${q.id} (javob)');
    final last = d.index == d.ids.length - 1;
    await tapScroll(tester, last ? uz.quizFinish : uz.quizNext);
    expect(tester.takeException(), isNull, reason: '${q.id} (keyingi)');
    answered++;
  }
  expect(answered, 50);
  expect(tester.takeException(), isNull);
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('haqiqiy ro‘yxat: mashq 50 savol, iPhone 390×844', (
    tester,
  ) async {
    await _walk(tester, const Size(390, 844), 1, 11);
  }, variant: _ios);

  testWidgets('haqiqiy ro‘yxat: mashq 50 savol, kichik 360×640 ×1.3', (
    tester,
  ) async {
    await _walk(tester, const Size(360, 640), 1.3, 12);
  }, variant: _ios);
}
