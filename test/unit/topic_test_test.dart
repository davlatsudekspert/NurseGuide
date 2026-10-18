// Mavzu testi: savollar tanlovi (faqat tekshirilgan, takrorlanmaydigan
// variantlar, urug' bilan deterministik), natija hisobi, qoralama va tarix,
// savol → slayd moslash.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/classroom/topic_test.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/learn/exam_question.dart';
import 'package:nurseguide/features/learn/exam_session.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

import '../helpers/fixtures.dart';

ToifaTestQuestion _toifa(
  String id, {
  KeyVerdict verdict = KeyVerdict.ok,
  bool unverified = false,
  List<String> options = const ['alfa', 'beta', 'gamma', 'delta'],
  Set<int> key = const {1},
  String? held,
  String text = 'Savol matni',
}) => ToifaTestQuestion(
  id: id,
  number: 1,
  text: text,
  options: options,
  key: key,
  topic: 'anemias',
  keyCheck: KeyCheck(verdict: verdict, unverified: unverified),
  held: held,
);

PackExamQuestion _pack(
  String id, {
  bool refs = true,
  List<String> options = const ['bir', 'ikki', 'uch'],
  List<String> topics = const [],
  String prompt = 'Paket savoli',
}) {
  Map<String, String> t(String s) => {'uz': s, 'ru': '$s ru', 'en': '$s en'};
  return PackExamQuestion(
    QuizQuestion.fromJson({
      'id': id,
      'prompt': t(prompt),
      'options': [
        for (final o in options) {'text': t(o), 'explanation': t('izoh $o')},
      ],
      'correct_index': 0,
      'basis': t('asos'),
      'review_state': 'pending',
      'topic_ids': topics,
      'source_ids': refs ? ['who-2011'] : <String>[],
    }),
    topics,
  );
}

DeckEntry _deck({
  String id = 'dx',
  List<String> topics = const ['t1'],
  List<(String, int)> runs = const [],
}) => DeckEntry(
  id: id,
  kind: DeckKind.day,
  titles: const {'uz': 'Deck'},
  slideCounts: {'uz': runs.length + 1},
  languages: const ['uz'],
  runs: {
    'uz': [for (final (t, i) in runs) SlideRun(t, i, 1)],
  },
  keywords: '',
  topics: topics,
);

void main() {
  late Curriculum cur;
  late ContentPack pack;
  late ToifaBank bank;
  late DeckCatalog catalog;

  setUpAll(() {
    cur = Curriculum.parse(fixtureCurriculum());
    pack = ContentPack.fromJson(fixturePack());
    bank = ToifaBank.fromJson(
      (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
      (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
    );
    catalog = DeckCatalog.parse(fixtureCatalog());
  });

  group('tekshirilgan savol', () {
    test('toifa: faqat kaliti ok, tasdiqlangan, chiqarilmagan', () {
      expect(isVerifiedTopicQuestion(_toifa('a')), isTrue);
      expect(
        isVerifiedTopicQuestion(_toifa('b', verdict: KeyVerdict.disputed)),
        isFalse,
      );
      expect(
        isVerifiedTopicQuestion(_toifa('c', verdict: KeyVerdict.ambiguous)),
        isFalse,
      );
      expect(isVerifiedTopicQuestion(_toifa('d', unverified: true)), isFalse);
      expect(
        isVerifiedTopicQuestion(_toifa('e', held: 'tekshirilmoqda')),
        isFalse,
      );
      expect(isVerifiedTopicQuestion(_toifa('f', key: const {})), isFalse);
    });

    test('paket: manbasi bor savol; manbasiz — yo‘q', () {
      expect(isVerifiedTopicQuestion(_pack('p1')), isTrue);
      expect(isVerifiedTopicQuestion(_pack('p2', refs: false)), isFalse);
    });

    test('takrorlanadigan variantli savol testga qo‘yilmaydi', () {
      final dup = _toifa('g', options: const ['alfa', 'Alfa', 'beta', 'gamma']);
      expect(hasUniqueOptions(dup), isFalse);
      expect(isVerifiedTopicQuestion(dup), isFalse);
      expect(
        isVerifiedTopicQuestion(_pack('p3', options: const ['x', 'y', 'x'])),
        isFalse,
      );
    });
  });

  group('deck hovuzi', () {
    test('deck — o‘z mavzulari (P va L) bo‘yicha takrorsiz birlashma', () {
      final d = catalog.byId('d001')!;
      final pool = deckQuestionPool(d, cur, pack, bank);
      final byTopic = {
        for (final t in d.topics)
          ...verifiedTopicQuestions(cur.topic(t)!, pack, bank).map((q) => q.id),
      };
      expect(pool.map((q) => q.id).toSet(), byTopic);
      expect(pool.length, byTopic.length);
      expect(deckTestState(d, pool), DeckTestState.ready);
    });

    test('3 tadan kam savol — “tayyorlanmoqda”', () {
      final d = _deck();
      expect(
        deckTestState(d, [_pack('a'), _pack('b')]),
        DeckTestState.preparing,
      );
      expect(
        deckTestState(d, [_pack('a'), _pack('b'), _pack('c')]),
        DeckTestState.ready,
      );
    });
  });

  group('tanlov', () {
    final pool = [
      for (var i = 0; i < 25; i++) _pack('q${i.toString().padLeft(2, '0')}'),
    ];

    test('bir xil urug‘ — bir xil test (kirish tartibidan qat‘i nazar)', () {
      final a = drawTopicTest(pool, seed: 42).map((q) => q.id).toList();
      final b = drawTopicTest(
        pool.reversed.toList(),
        seed: 42,
      ).map((q) => q.id).toList();
      expect(a, b);
      expect(a.length, kTopicTestSize);
      expect(a.toSet().length, a.length);
      final c = drawTopicTest(pool, seed: 43).map((q) => q.id).toList();
      expect(c, isNot(a));
    });

    test('savol kam bo‘lsa — boricha', () {
      expect(drawTopicTest(pool.take(4).toList(), seed: 1).length, 4);
      expect(drawTopicTest(pool, seed: 1, count: 30).length, 25);
    });

    test('sessiya: rasmiy savolda variant tartibi saqlanadi, paketda — urug‘ bilan', () {
      final qs = [
        _toifa('t1'),
        _pack('p1'),
        _pack('p2', options: const ['a', 'b', 'c', 'd']),
      ];
      ExamSession build(int seed) => buildTopicTestSession(
        id: 's',
        questions: qs,
        seed: seed,
        startedAt: DateTime(2026, 10, 17),
        title: 'T',
      );
      final s = build(7);
      expect(s.items.map((i) => i.questionId), ['t1', 'p1', 'p2']);
      expect(s.items[0].order, [0, 1, 2, 3]);
      expect(s.items[0].correct, [1]);
      expect(build(7).items[2].order, s.items[2].order);
      expect(s.sourceId, TopicTestController.sourceId);
    });
  });

  group('natija', () {
    ExamSession session() => buildTopicTestSession(
      id: 'x',
      questions: [_toifa('t1'), _pack('p1'), _pack('p2'), _pack('p3')],
      seed: 3,
      startedAt: DateTime(2026, 10, 17, 9),
      title: 'T',
    );

    void answer(ExamSession s, int i, {required bool correct}) {
      s.goTo(i);
      final item = s.current;
      final want = correct
          ? item.correct.single
          : item.order.firstWhere((o) => !item.correct.contains(o));
      s.choose(item.order.indexOf(want));
    }

    test('ball, xatolar va foiz', () {
      final s = session();
      answer(s, 0, correct: true);
      answer(s, 1, correct: false);
      answer(s, 2, correct: true);
      expect(s.correctCount, 2);
      expect(s.wrongCount, 1);
      expect(s.unansweredCount, 1);
      expect(s.mistakeIndexes, [1, 3]);
      expect(s.percent, 50);
    });

    test(
      'eng yaxshi natija — foiz bo‘yicha, xatolar ustida ishlash kirmaydi',
      () {
        final at = DateTime(2026);
        expect(bestResult(const []), isNull);
        final best = bestResult([
          TopicTestResult(correct: 6, total: 10, at: at),
          TopicTestResult(correct: 8, total: 10, at: at),
          TopicTestResult(correct: 3, total: 3, at: at, rework: true),
          TopicTestResult(correct: 4, total: 5, at: at),
        ]);
        expect((best!.correct, best.total), (8, 10));
      },
    );

    test('buzilgan yozuv ilovani yiqitmaydi', () {
      final store = MemoryKeyValueStore()
        ..setString(StoreKeys.topicTests, '{"drafts": {"a": 5}, "history": 3');
      final c = TopicTestController(store);
      expect(c.inProgress('a'), isNull);
    });
  });

  group('savol → slayd', () {
    final deck = _deck(
      runs: const [
        ('Dars maqsadi va rejasi', 1),
        ('Ferritin', 2),
        ('Ferritin', 3),
        ('Gemoglobin va eritrotsitlar', 4),
        ('Temir almashinuvi', 5),
        ('Manbalar', 6),
      ],
    );

    test('so‘zlar bo‘yicha (qo‘shimchalar bilan) moslik', () {
      final q = _toifa(
        't',
        text: 'Eritrotsitlarda gemoglobinning asosiy vazifasi:',
        options: const ['kislorod tashish', 'b', 'c', 'd'],
        key: const {0},
      );
      expect(matchSlide(q, deck, 'uz'), 4);
    });

    test('ishonchli moslik yo‘q yoki teng — null (deck boshi)', () {
      expect(
        matchSlide(_pack('n', prompt: 'Sterilizatsiya rejimi'), deck, 'uz'),
        isNull,
      );
      final tie = _toifa(
        'tie',
        text: 'Ferritin va temir',
        options: const ['x1', 'x2', 'x3', 'x4'],
      );
      expect(matchSlide(tie, deck, 'uz'), isNull);
      // Umumiy slaydlar (reja, manbalar) hech qachon tanlanmaydi.
      expect(
        matchSlide(_pack('m', prompt: 'Manbalar va dars rejasi'), deck, 'uz'),
        isNull,
      );
    });
  });
}
