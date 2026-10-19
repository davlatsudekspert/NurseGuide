// Do'kon talabi (Apple 2.1): tayyor bo'lmagan bo'limlar ko'rinmaydi.
// Haqiqiy asset'lar bilan: kontent paketida mashq savollari yo'q, ma'ruza
// katalogi bo'sh, javobsiz og'zaki savollar bankka kirmaydi.
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import '../helpers/harness.dart';

final _uz = lookupAppLocalizations(const Locale('uz'));

void main() {
  setUpAll(loadAppFonts);

  for (final role in AppRole.values) {
    testWidgets('O‘rganish (${role.name}): bo‘sh bo‘limlar yashirin', (
      tester,
    ) async {
      final s = await makeServices(tester, bundle: rootBundle, role: role);
      await pumpApp(tester, s, size: const Size(390, 1600));
      await goTo(tester, '/learn');
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 80)),
      );
      await tester.pumpAndSettle();
      for (final t in [
        _uz.learnQuiz,
        _uz.learnExam,
        _uz.lectureListTitle,
        _uz.learnHeroCta,
      ]) {
        expect(find.text(t), findsNothing, reason: '${role.name}: $t');
      }
    });
    testWidgets('Bosh sahifa (${role.name}): bo‘sh bo‘limlarga kirish yo‘q', (
      tester,
    ) async {
      final s = await makeServices(tester, bundle: rootBundle, role: role);
      await pumpApp(tester, s, size: const Size(390, 1600));
      await goTo(tester, '/home');
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 80)),
      );
      await tester.pumpAndSettle();
      for (final t in [
        _uz.featureLessons,
        _uz.featureTests,
        _uz.featureExam,
        _uz.lectureTitle,
      ]) {
        expect(find.text(t), findsNothing, reason: '${role.name}: $t');
      }
    });
  }

  testWidgets('og‘zaki bank: faqat javobi va manbasi bor savollar', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: rootBundle);
    await pumpApp(tester, s);
    final bank = s.toifa.bank!;
    expect(bank.oral, isNotEmpty);
    for (final q in bank.oral) {
      expect(q.plan, isNotEmpty, reason: q.id);
      expect(q.held, isNull, reason: q.id);
      expect(q.literature.isNotEmpty || (q.source ?? '').isNotEmpty, isTrue);
    }
    // Ushlab turilgan savol biletga ham kirmaydi.
    final ids = {for (final q in bank.oral) q.id};
    for (final t in bank.tickets) {
      expect(t.questionIds.every(ids.contains), isTrue, reason: t.id);
    }
  });
}
