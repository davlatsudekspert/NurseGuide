// Ilova HAQIQIY placeholder kontent bilan (bo'sh savol banki, bo'sh paket,
// katalogsiz) ishga tushganda barcha bo'limlar yiqilmaydi va halol bo'sh
// holat ko'rsatadi — 4-bosqichgacha ilova shu holatda yuboriladi.
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show Size, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';
import '../helpers/ui.dart';

void main() {
  setUpAll(loadAppFonts);

  const pages = [
    '/home',
    '/procedures',
    '/workplace',
    '/library',
    '/library/books',
    '/library/saved',
    '/library/sources',
    '/learn',
    '/learn/quiz',
    '/learn/daily',
    '/learn/exam',
    '/learn/toifa',
    '/learn/toifa/test',
    '/learn/toifa/practice',
    '/learn/toifa/oral',
    '/learn/toifa/mistakes',
    '/learn/toifa/progress',
    '/learn/lecture',
    '/learn/classes',
    '/profile',
    '/profile/theme',
    '/profile/privacy',
    '/profile/help',
    '/profile/contact',
  ];

  for (final role in AppRole.values) {
    testWidgets(
      'placeholder kontent: barcha sahifalar ochiladi (${role.name})',
      (tester) async {
        // rootBundle — haqiqiy assets/ (bo'sh placeholder'lar).
        final s = await makeServices(
          tester,
          bundle: rootBundle,
          role: role,
          backend: FakeBackend(),
          language: AppLanguage.uz,
        );
        await pumpApp(tester, s, size: const Size(390, 1200));
        for (final p in pages) {
          await goTo(tester, p);
          expect(tester.takeException(), isNull, reason: '$p ${role.name}');
        }
      },
    );
  }

  testWidgets('toifa bo‘limi haqiqiy bankda bo‘sh holat ko‘rsatmaydi', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      role: AppRole.nurse,
    );
    await pumpApp(tester, s, size: const Size(390, 1200));
    await goTo(tester, '/learn/toifa');
    expect(find.byKey(const ValueKey('toifa-empty')), findsNothing);
    expect(find.text(uz.toifaEmptyTitle), findsNothing);
  });

  testWidgets(
    'kontent: toifa banki yuklangan (1957 test, 86 og‘zaki, 14 bilet), paket bo‘sh',
    (tester) async {
      final s = await makeServices(tester, bundle: rootBundle);
      expect(s.content.pack, isNotNull);
      expect(s.content.pack!.quiz, isEmpty);
      expect(s.toifa.bank, isNotNull);
      expect(s.toifa.bank!.tests.length, 1957);
      expect(s.toifa.bank!.oral.length, 86);
      expect(s.toifa.bank!.tickets.length, 14);
    },
  );
}
