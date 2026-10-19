import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/daily/daily_picker.dart';
import 'package:nurseguide/features/daily/daily_screens.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

Map<String, Object?> _json(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, Object?>();

void main() {
  late ToifaBank bank;
  late ToifaQuestionSource source;

  setUpAll(() {
    bank = ToifaBank.fromJson(
      _json('assets/toifa/tests.json'),
      _json('assets/toifa/oral.json'),
    );
    source = ToifaQuestionSource(bank);
  });

  test('hafta: 4 kun o‘z yo‘nalishi, 2 kun umumiy, yakshanba aralash', () {
    final kinds = [for (var d = 1; d <= 7; d++) dailyKindFor(d)];
    expect(kinds.where((k) => k == DailyKind.own), hasLength(4));
    expect(kinds.where((k) => k == DailyKind.general), hasLength(2));
    expect(kinds.where((k) => k == DailyKind.mixed), hasLength(1));
    expect(dailyKindFor(DateTime.monday), DailyKind.own);
    expect(dailyKindFor(DateTime.thursday), DailyKind.own);
    expect(dailyKindFor(DateTime.friday), DailyKind.general);
    expect(dailyKindFor(DateTime.sunday), DailyKind.mixed);
  });

  test('yo‘nalish tanlanmagan — butun bank (eski xulq)', () {
    final pool = dailyPoolFor(source);
    expect(pool.priority, isEmpty);
    expect(pool.others, isNotEmpty);
  });

  // DMED — test banki yo'q yo'nalish: alohida testda.
  for (final d in WorkDirection.values.where((d) => d != WorkDirection.dmed)) {
    test(
      '${d.bank}: o‘z kunida faqat o‘z banki, umumiy kunida umumiy mavzular',
      () {
        final own = dailyPoolFor(source, direction: d, kind: DailyKind.own);
        expect(own.priority, isNotEmpty);
        expect(own.others, isEmpty);
        for (final id in own.priority) {
          expect(bank.test(id)!.bank, d.bank, reason: id);
        }

        final general = dailyPoolFor(
          source,
          direction: d,
          kind: DailyKind.general,
        );
        expect(general.priority, isNotEmpty);
        for (final id in general.priority) {
          expect(kGeneralTopics, contains(bank.test(id)!.topic), reason: id);
        }

        final mixed = dailyPoolFor(source, direction: d, kind: DailyKind.mixed);
        expect(mixed.priority, own.priority);
        expect(mixed.others, general.priority);
      },
    );

    test('${d.bank}: kunlik 5 savol, o‘z kunida hammasi o‘z bankidan', () {
      final pool = dailyPoolFor(source, direction: d, kind: DailyKind.own);
      for (var day = 0; day < 14; day++) {
        final ids = pickDaily(
          priority: pool.priority,
          others: pool.others,
          day: day,
          seed: 7,
        );
        expect(ids, hasLength(kDailySize));
        expect(ids.toSet(), hasLength(kDailySize));
        for (final id in ids) {
          expect(bank.test(id)!.bank, d.bank);
        }
      }
    });
  }

  test(
    'dmed: kunlik test hovuzi o‘z banki bo‘sh bo‘lgani uchun umumiyga o‘tadi',
    () {
      for (final k in DailyKind.values) {
        final pool = dailyPoolFor(
          source,
          direction: WorkDirection.dmed,
          kind: k,
        );
        final ids = [...pool.priority, ...pool.others];
        expect(ids, isNotEmpty, reason: k.name);
        for (final id in ids) {
          expect(kGeneralTopics, contains(bank.test(id)!.topic), reason: id);
        }
      }
    },
  );

  test(
    'manba id yo‘nalish va tur bo‘yicha farqlanadi (to‘plam yangilanadi)',
    () {
      final a = dailyPoolFor(
        source,
        direction: WorkDirection.nursing,
        kind: DailyKind.own,
      ).sourceId;
      final b = dailyPoolFor(
        source,
        direction: WorkDirection.higher,
        kind: DailyKind.own,
      ).sourceId;
      final c = dailyPoolFor(
        source,
        direction: WorkDirection.nursing,
        kind: DailyKind.general,
      ).sourceId;
      expect({a, b, c}, hasLength(3));
    },
  );
}
