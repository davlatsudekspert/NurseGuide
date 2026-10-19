import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import '../helpers/harness.dart';

final _uz = lookupAppLocalizations(const Locale('uz'));

Future<void> _settle(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 80)),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('test: yo‘nalish tanlanadi, savollar soni o‘zgaradi', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: rootBundle);
    await pumpApp(tester, s, size: const Size(390, 3000));
    await goTo(tester, '/learn/toifa/test');
    await _settle(tester);
    final bank = s.toifa.bank!;
    final all = bank.scorable.length;
    final patronage = bank.scorable.where((q) => q.bank == 'patronaj').length;
    expect(patronage, lessThan(all));
    // Ish joyida yo'nalish tanlanmagan — hammasi.
    expect(find.text(_uz.toifaFormatStep1(50, all)), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('toifa-scope-patronaj')));
    await tester.pumpAndSettle();
    expect(find.text(_uz.toifaFormatStep1(50, patronage)), findsOneWidget);
    expect(s.toifa.scopeFor(null), 'patronaj');

    await tester.tap(find.byKey(const ValueKey('toifa-scope-all')));
    await tester.pumpAndSettle();
    expect(find.text(_uz.toifaFormatStep1(50, all)), findsOneWidget);
  });

  testWidgets('test: boshlang‘ich doira — Ish joyidagi yo‘nalish', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: rootBundle);
    await s.settings.setWorkDirection(WorkDirection.nursing);
    await pumpApp(tester, s, size: const Size(390, 3000));
    await goTo(tester, '/learn/toifa/test');
    await _settle(tester);
    final n = s.toifa.bank!.scorable
        .where((q) => q.bank == 'hamshiralik')
        .length;
    expect(find.text(_uz.toifaFormatStep1(50, n)), findsOneWidget);
    // DMED yo'nalishida test banki yo'q — hammasi.
    await s.settings.setWorkDirection(WorkDirection.dmed);
    expect(s.toifa.scopeFor(null), isNull);
  });

  testWidgets('mashq ro‘yxati: tanlangan yo‘nalish savollarini sanaydi', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: rootBundle);
    await pumpApp(tester, s, size: const Size(390, 3000));
    await goTo(tester, '/learn/toifa/practice');
    await _settle(tester);
    await tester.tap(find.byKey(const ValueKey('toifa-scope-patronaj')));
    await tester.pumpAndSettle();
    final n = s.toifa.bank!.scorable.where((q) => q.bank == 'patronaj').length;
    expect(find.text(_uz.quizQuestionCount(n)), findsWidgets);
  });
}
