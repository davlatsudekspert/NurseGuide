// Qorovul (guard) testlari: o'quv imkoniyatlari.
//
// Toifa formatlari (D-60), ma'ruza taqdimotlari (D-59, D-65), mavzu testi
// qamrovi (har dekali mavzuda ≥ 10 tekshirilgan savol). Jadval: docs/GUARDS.md.
//
// Taqdimotlar yoki o'quv dasturi o'zgarsa (masalan, yangi modul decklari),
// bu testlar faqat "kamaymasin / buzilmasin" deb tekshiradi: son ko'paysa
// o'tadi; yangi dekali mavzuda 10 tadan kam savol bo'lsa — yiqiladi
// (yoki savollar qo'shiladi, yoki istisno sababi bilan shu yerga yoziladi).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/classroom/lecture_canvas.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/classroom/topic_test.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';
import 'package:nurseguide/features/toifa/toifa_daily.dart';

import '../helpers/fixtures.dart';

Map<String, Object?> _json(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, Object?>();

/// Mavzu testi 10 savoldan kam bo'lishi mumkin bo'lgan decklar — sababi bilan
/// (hozircha istisno yo'q; yangi istisno sababi bilan shu yerga yoziladi).
const _topicTestExceptions = <String>{};

void main() {
  group('Toifa (D-60)', () {
    test('rasmiy formatlar: test 50 savol, bilet 5 savol', () {
      expect(ToifaFormat.testSize, 50);
      expect(ToifaFormat.ticketSize, 5);
      expect(ToifaGoal.defaultQuestions, 50);
      expect(ToifaGoal.tickets, 1);
      expect(ToifaGoal.options, [20, 50, 100]);
    });

    test('mashq rejimi bor: har javobdan keyin darhol to‘g‘ri/xato', () {
      expect(ToifaTestMode.values.map((m) => m.name), ['exam', 'practice']);
      expect(ToifaTestMode.tryParse('practice'), ToifaTestMode.practice);
      expect(ToifaTestMode.tryParse(null), ToifaTestMode.exam);
      final d = ToifaDrill(
        id: 'g',
        ids: const ['a', 'b'],
        keys: const [1, 2],
        startedAt: DateTime(2026, 10, 18),
      );
      d.answers[0] = 0; // xato javob — darhol aniqlanadi
      expect(d.isAnswered(0), isTrue);
      expect(d.isCorrect(0), isFalse);
      d.answers[1] = 2;
      expect(d.isCorrect(1), isTrue);
      expect(d.wrongIndexes, [0]);
    });
  });

  group('Ma’ruza taqdimotlari (D-59, D-65)', () {
    final _ = DeckCatalog.parse(fixtureCatalog());

    test('16:9 kanvas — 1280×720', () {
      expect(SlideCanvasMetrics.width, 1280);
      expect(SlideCanvasMetrics.height, 720);
      expect(SlideCanvasMetrics.width / SlideCanvasMetrics.height, 16 / 9);
    });

    test(
      'to‘liq ekran: gorizontal holat so‘rovi (uch tilda) va eslab qolish',
      () {
        for (final lang in ['uz', 'ru', 'en']) {
          final arb = _json('lib/l10n/app_$lang.arb');
          for (final k in [
            'lectureRotateTitle',
            'lectureRotateBody',
            'lectureOrientationAsk',
            'lectureOrientationLandscape',
            'lectureOrientationKeep',
          ]) {
            expect(arb[k], isA<String>(), reason: '$lang $k');
          }
        }
        final present = File('lib/features/classroom/lecture_present.dart')
            .readAsStringSync();
        expect(present, contains("ValueKey('lecture-rotate-dialog')"));
        expect(present, contains('l.lectureRotateTitle'));
        expect(
          File('lib/core/storage/kv_store.dart').readAsStringSync(),
          contains("lectureOrientation = 'lecture.orientation'"),
        );
      },
    );
  });

  group('mavzu testi qamrovi', () {
    final cur = Curriculum.parse(fixtureCurriculum());
    final pack = ContentPack.fromJson(fixturePack());
    final bank = ToifaBank.fromJson(
      (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
      (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
    );
    final catalog = DeckCatalog.parse(fixtureCatalog());

    test('har dekali mavzu: ≥ $kTopicTestSize ta tekshirilgan savol '
        '(hujjatlangan istisnolardan tashqari)', () {
      expect(kTopicTestSize, 10);
      final low = <String>[];
      for (final t in cur.topics) {
        final deck = catalog.byTopic(t.id);
        if (deck == null || _topicTestExceptions.contains(deck.id)) continue;
        final n = verifiedTopicQuestions(t, pack, bank).length;
        if (n < kTopicTestSize) low.add('${t.id} (${deck.id}): $n');
      }
      expect(low, isEmpty);
    });

    test('kunlik decklarning test hovuzi ≥ 10; protokollar mavzusiz '
        '(test tugmasi yo‘q)', () {
      for (final d in catalog.decks) {
        if (d.kind == DeckKind.protocol) {
          expect(d.topics, isEmpty, reason: d.id);
          expect(
            deckTestState(d, deckQuestionPool(d, cur, pack, bank)),
            DeckTestState.hidden,
            reason: d.id,
          );
          continue;
        }
        if (_topicTestExceptions.contains(d.id)) continue;
        expect(
          deckQuestionPool(d, cur, pack, bank).length,
          greaterThanOrEqualTo(kTopicTestSize),
          reason: d.id,
        );
      }
    });

    test('istisnolar hali haqiqiy (eskirgan istisno qolmasin)', () {
      for (final id in _topicTestExceptions) {
        final d = catalog.byId(id);
        expect(d, isNotNull, reason: id);
        expect(
          deckQuestionPool(d!, cur, pack, bank).length,
          lessThan(kTopicTestSize),
          reason: '$id endi to‘liq — istisnoni olib tashlang',
        );
      }
    });
  });
}
