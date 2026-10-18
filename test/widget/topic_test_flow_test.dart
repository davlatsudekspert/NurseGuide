// Mavzu testi (taqdimot oxirida): deckdan boshlash, javob va darhol izoh,
// chiqib qaytib davom ettirish, yakun, xatolar tahlili, “Slaydni ko'rish”,
// qayta topshirish, xatolarni takrorlash, ro'yxatdagi natija belgisi —
// uz/ru/en; “savollar tayyorlanmoqda”; 320 px / 1.3x.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/classroom/lecture_decks.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/device_fakes.dart';
import '../helpers/fixtures.dart';
import '../helpers/harness.dart';

const _tall = Size(390, 2600);
const _deck = 'd001';

Future<DeckCatalog> _catalog(WidgetTester tester) async =>
    (await tester.runAsync(() => DeckCatalog.load(testBundle)))!;

Future<LectureDeck> _preload(
  WidgetTester tester,
  String id,
  String lang,
) async {
  final c = await _catalog(tester);
  final e = c.byId(id)!;
  return (await tester.runAsync(
    () => DeckCatalog.loadDeck(testBundle, e, e.resolveLang(lang)),
  ))!;
}

Future<void> _tapKey(WidgetTester tester, String key) async {
  final f = find.byKey(ValueKey(key));
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('ustoz «Mavzu testi»ni bossa — avval talabalarga topshirish', (
    tester,
  ) async {
    installDeviceFakes();
    final s = await makeServices(tester, role: AppRole.teacher);
    await pumpApp(tester, s, size: _tall);
    await goTo(tester, '/learn/lecture');
    final badge = find.byKey(const ValueKey('deck-test-$_deck'));
    await tester.ensureVisible(badge);
    await tester.pumpAndSettle();
    await tester.tap(badge);
    await tester.pumpAndSettle();
    final assign = find.byKey(const ValueKey('deck-test-choice-assign'));
    final self = find.byKey(const ValueKey('deck-test-choice-self'));
    expect(assign, findsOneWidget);
    expect(self, findsOneWidget);
    expect(tester.getTopLeft(assign).dy, lessThan(tester.getTopLeft(self).dy));
    await tester.tap(self);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('topic-test-intro')), findsOneWidget);
  });

  testWidgets('ro‘yxatda uzoq bosish — amallar; menyudan test', (tester) async {
    installDeviceFakes();
    final l = lookupAppLocalizations(const Locale('uz'));
    final s = await makeServices(tester, role: AppRole.teacher);
    await pumpApp(tester, s, size: _tall);
    await goTo(tester, '/learn/lecture');
    final row = find.byKey(const ValueKey('deck-$_deck'));
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.longPress(row);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('deck-action-test')), findsOneWidget);
    expect(find.byKey(const ValueKey('deck-action-assign')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('deck-action-test')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('topic-test-intro')), findsOneWidget);
    expect(find.byKey(const ValueKey('topic-test-assign')), findsOneWidget);
    // Pleyer menyusi.
    await _preload(tester, _deck, 'uz');
    await goTo(tester, '/learn/lecture/deck/$_deck');
    await _tapKey(tester, 'lecture-test-menu');
    expect(find.text(l.topicTestAssign), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('lecture-menu-test')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('topic-test-intro')), findsOneWidget);
  });
}
