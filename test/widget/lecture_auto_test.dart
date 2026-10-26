// Slayd ko'rish: «Avto / Qo'lda» varaqlash — taymer, pauza, oxirida to'xtash,
// ekrandan chiqqanda taymer yo'qligi, saqlangan tanlov, kichik ekran/katta shrift.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import 'package:nurseguide/features/classroom/lecture_catalog.dart';

import '../helpers/device_fakes.dart';
import '../helpers/fixtures.dart';
import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));
const _deckRoute = '/learn/lecture/deck/d001';

int _current(WidgetTester tester) {
  final re = RegExp(r'^(\d+) / (\d+)$');
  for (final t in tester.widgetList<Text>(find.byType(Text))) {
    final m = re.firstMatch(t.data ?? '');
    if (m != null) return int.parse(m.group(1)!);
  }
  throw StateError('slayd hisoblagichi topilmadi');
}

int _total(WidgetTester tester) {
  final re = RegExp(r'^(\d+) / (\d+)$');
  for (final t in tester.widgetList<Text>(find.byType(Text))) {
    final m = re.firstMatch(t.data ?? '');
    if (m != null) return int.parse(m.group(2)!);
  }
  throw StateError('slayd hisoblagichi topilmadi');
}

Finder _key(String k) => find.byKey(ValueKey(k));

Future<void> _tap(WidgetTester tester, Finder f) async {
  await tester.ensureVisible(f);
  await tester.pump();
  await tester.tap(f);
  await tester.pump();
}

Future<AppServicesBundle> _open(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double textScale = 1,
  Brightness brightness = Brightness.light,
  Map<String, String> store = const {},
}) async {
  final fakes = installDeviceFakes();
  final s = await makeServices(tester);
  for (final e in store.entries) {
    await s.store.setString(e.key, e.value);
  }
  await pumpApp(
    tester,
    s,
    size: size,
    textScale: textScale,
    platformBrightness: brightness,
  );
  // Katalog va deck oldindan yuklanadi (haqiqiy asinxron ishlar uchun).
  await tester.runAsync(() async {
    final c = await DeckCatalog.load(testBundle);
    final e = c.byId('d001')!;
    await DeckCatalog.loadDeck(testBundle, e, e.resolveLang('uz'));
  });
  await goTo(tester, _deckRoute);
  return AppServicesBundle(s.store, fakes.awake);
}

class AppServicesBundle {
  AppServicesBundle(this.store, this.awake);
  final KeyValueStore store;
  final RecordingScreenAwake awake;
}

Future<void> _unmount(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('Qo‘lda — boshlang‘ich holat: slayd o‘zi o‘tmaydi', (
    tester,
  ) async {
    await _open(tester);
    expect(find.text(uz.lectureManual), findsOneWidget);
    expect(_current(tester), 1);
    await tester.pump(const Duration(seconds: 120));
    expect(_current(tester), 1);
    await _unmount(tester);
  });

  testWidgets(
    'Avto: 30 soniyada o‘tadi; tezlik 15 ga almashtirilsa tezlashadi',
    (tester) async {
      final o = await _open(tester);
      await _tap(tester, _key('lecture-auto-toggle'));
      expect(find.text(uz.lectureAuto), findsWidgets);
      expect(o.store.getString(StoreKeys.lectureAuto), '1');
      await tester.pump(const Duration(seconds: 29));
      expect(_current(tester), 1);
      await tester.pump(const Duration(seconds: 2));
      expect(_current(tester), 2);
      await _tap(tester, _key('lecture-auto-speed-15'));
      expect(o.store.getString(StoreKeys.lectureAutoSecs), '15');
      await tester.pump(const Duration(seconds: 16));
      expect(_current(tester), 3);
      await _unmount(tester);
    },
  );

  testWidgets('Pauza: slaydni bosish to‘xtatadi, qayta bosish davom ettiradi', (
    tester,
  ) async {
    await _open(tester);
    await _tap(tester, _key('lecture-auto-toggle'));
    await tester.tap(_key('lecture-slide-card'));
    await tester.pump();
    expect(_key('lecture-auto-paused'), findsOneWidget);
    expect(find.text(uz.lectureResume), findsOneWidget);
    await tester.pump(const Duration(seconds: 90));
    expect(_current(tester), 1);
    await tester.tap(_key('lecture-slide-card'));
    await tester.pump();
    expect(_key('lecture-auto-paused'), findsNothing);
    await tester.pump(const Duration(seconds: 31));
    expect(_current(tester), 2);
    await _unmount(tester);
  });

  testWidgets(
    'Qo‘lda varaqlash avtoni pauzaga qo‘yadi; «Davom etish» tugmasi',
    (tester) async {
      await _open(tester);
      await _tap(tester, _key('lecture-auto-toggle'));
      await _tap(tester, find.text(uz.lectureNext).last);
      expect(_current(tester), 2);
      expect(_key('lecture-auto-paused'), findsOneWidget);
      await tester.pump(const Duration(seconds: 90));
      expect(_current(tester), 2);
      await _tap(tester, _key('lecture-auto-pause'));
      await tester.pump(const Duration(seconds: 31));
      expect(_current(tester), 3);
      await _unmount(tester);
    },
  );

  testWidgets('Oxirgi slaydda to‘xtaydi, boshiga qaytmaydi, avto o‘chadi', (
    tester,
  ) async {
    await _open(tester);
    final n = _total(tester);
    await _tap(tester, _key('lecture-auto-toggle'));
    await _tap(tester, _key('lecture-auto-speed-15'));
    for (var k = 0; k < n + 2; k++) {
      await tester.pump(const Duration(seconds: 16));
    }
    expect(_current(tester), n);
    expect(find.text(uz.lectureManual), findsOneWidget);
    await tester.pump(const Duration(seconds: 120));
    expect(_current(tester), n);
    await _unmount(tester);
  });

  testWidgets('Ekrandan chiqilganda taymer qolmaydi; ekran uyg‘oq o‘chadi', (
    tester,
  ) async {
    final o = await _open(tester);
    await _tap(tester, _key('lecture-auto-toggle'));
    await goTo(tester, '/home');
    await tester.pump(const Duration(seconds: 1));
    expect(o.awake.calls.last, isFalse);
    await tester.pump(const Duration(seconds: 120));
    expect(tester.takeException(), isNull);
    await _unmount(tester);
  });

  testWidgets('Fonga o‘tganda avto pauzada, ekran uyg‘oq o‘chadi', (
    tester,
  ) async {
    final o = await _open(tester);
    await _tap(tester, _key('lecture-auto-toggle'));
    expect(o.awake.calls.last, isTrue);
    for (final st in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
    ]) {
      tester.binding.handleAppLifecycleStateChanged(st);
    }
    await tester.pump();
    expect(o.awake.calls.last, isFalse);
    expect(_key('lecture-auto-paused'), findsOneWidget);
    await tester.pump(const Duration(seconds: 90));
    expect(_current(tester), 1);
    for (final st in [
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed,
    ]) {
      tester.binding.handleAppLifecycleStateChanged(st);
    }
    await tester.pump();
    expect(o.awake.calls.last, isTrue);
    await _unmount(tester);
  });

  testWidgets('Tanlov saqlanadi: keyingi safar Avto va 60 soniya', (
    tester,
  ) async {
    await _open(
      tester,
      store: {StoreKeys.lectureAuto: '1', StoreKeys.lectureAutoSecs: '60'},
    );
    expect(find.text(uz.lectureAuto), findsWidgets);
    await tester.pump(const Duration(seconds: 59));
    expect(_current(tester), 1);
    await tester.pump(const Duration(seconds: 2));
    expect(_current(tester), 2);
    await _unmount(tester);
  });

  for (final c in [
    ('yotiq telefon', const Size(640, 360)),
    ('planshet', const Size(1000, 700)),
  ]) {
    testWidgets('Avto boshqaruvi: ${c.$1}', (tester) async {
      await _open(tester, size: c.$2);
      await _tap(tester, _key('lecture-auto-toggle'));
      expect(_key('lecture-auto-speed-30'), findsOneWidget);
      await tester.tap(
        _key('lecture-slide-card').evaluate().isEmpty
            ? find.byType(GestureDetector).first
            : _key('lecture-slide-card'),
      );
      await tester.pump(const Duration(seconds: 61));
      expect(tester.takeException(), isNull);
      await _unmount(tester);
    });
  }

  for (final c in [
    ('320 dp, 1.3x', const Size(320, 568), 1.3, Brightness.light),
    ('360 dp, 2.0x, qorong‘i', const Size(360, 640), 2.0, Brightness.dark),
  ]) {
    testWidgets('Toshib ketmaydi: ${c.$1}', (tester) async {
      await _open(tester, size: c.$2, textScale: c.$3, brightness: c.$4);
      await _tap(tester, _key('lecture-auto-toggle'));
      expect(tester.takeException(), isNull);
      for (final k in ['lecture-auto-toggle', 'lecture-auto-pause']) {
        final r = tester.getRect(_key(k));
        expect(r.height, greaterThanOrEqualTo(47.9), reason: k);
      }
      await _unmount(tester);
    });
  }
}
