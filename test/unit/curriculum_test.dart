import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/classroom/classroom_local.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/classroom/topic_questions.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

import '../helpers/fixtures.dart';

/// Faqat berilgan fayllarni “asset” sifatida beradi.
class _MapBundle extends CachingAssetBundle {
  _MapBundle(this.files);

  final Map<String, String> files;

  @override
  Future<ByteData> load(String key) async {
    final f = files[key];
    if (f == null) throw StateError('missing $key');
    return ByteData.sublistView(utf8.encode(f));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('curriculum.json o‘quvchisi', () {
    final cur = Curriculum.parse(fixtureCurriculum());

    test('modul → mavzu; kun tartibi', () {
      expect(cur.name.of('uz'), 'Namuna dastur (test)');
      expect(cur.modules.map((m) => m.id), ['M1']);
      expect(cur.topics.map((t) => t.id), ['t001-L', 't001-P']);
      expect(cur.modules.first.title.of('ru'), 'RU Birinchi modul');
    });

    test('mavzu maydonlari va havolalar', () {
      final t = cur.topic('t001-L')!;
      expect(t.order, 1);
      expect(t.week, 1);
      expect(t.hours, 2);
      expect(t.type, CurriculumTopicType.lecture);
      expect(t.title.of('en'), 'First topic');
      expect(t.title.of('ru'), t.title.of('uz'), reason: 'tarjima yo‘q');
      expect(t.date, isNull);
      expect(t.links.quizTopics, ['basics']);
      expect(t.links.protocols, ['d001']);
      expect(t.links.toifaTopic, 'fundamentals');
      expect(t.oralCandidates, ['o-1', 'o-2']);
      expect(t.testCandidates, hasLength(12));
      expect(t.packQuizCandidates, hasLength(6));
      expect(t.derivedQuizCandidates, ['dv1']);
      expect(cur.moduleOf(t)!.id, 'M1');
      expect(cur.topic('t001-P')!.type, CurriculumTopicType.practical);
    });

    test('takror mavzu id si — xato; modullar yo‘q — xato', () {
      expect(
        () => Curriculum.fromJson({
          'modules': [
            {
              'id': 'M1',
              'topics': [
                {'id': 'a', 'n': 1},
                {'id': 'a', 'n': 2},
              ],
            },
          ],
        }),
        throwsFormatException,
      );
      expect(() => Curriculum.fromJson({}), throwsFormatException);
    });

    test('sana bo‘lmasa — tartib raqami', () {
      final c = Curriculum.fromJson({
        'modules': [
          {
            'id': 'M1',
            'title_uz': 'X',
            'topics': [
              {'id': 'a', 'title_uz': 'A'},
              {'id': 'b', 'title_uz': 'B'},
            ],
          },
        ],
      });
      expect(c.topics.map((t) => t.order), [1, 2]);
    });
  });

  test('kun tartibi → sana: yakshanba o‘tkaziladi', () {
    final mon = DateTime(2026, 1, 5); // dushanba
    expect(studyDayDate(mon, 1), DateTime(2026, 1, 5));
    expect(studyDayDate(mon, 6), DateTime(2026, 1, 10)); // shanba
    expect(studyDayDate(mon, 7), DateTime(2026, 1, 12)); // dushanba
    expect(studyDayDate(DateTime(2026, 1, 4), 1), DateTime(2026, 1, 5));
  });

  group('yuklovchi', () {
    test('asset yo‘q — null, controller “missing”', () async {
      final bundle = _MapBundle({});
      expect(await CurriculumLoader.load(bundle), isNull);
      final c = CurriculumController(bundle: bundle);
      await c.ensureLoaded();
      expect(c.state, CurriculumState.missing);
      expect(c.curriculum, isNull);
      final none = CurriculumController();
      await none.ensureLoaded();
      expect(none.state, CurriculumState.missing);
    });

    test('asset bor — o‘qiladi; buzilgan — error', () async {
      final ok = CurriculumController(
        bundle: _MapBundle({CurriculumLoader.assetPath: fixtureCurriculum()}),
      );
      await ok.ensureLoaded();
      expect(ok.state, CurriculumState.ready);
      expect(ok.curriculum!.topics, hasLength(2));
      final bad = CurriculumController(
        bundle: _MapBundle({CurriculumLoader.assetPath: '{"modules": 1}'}),
      );
      await bad.ensureLoaded();
      expect(bad.state, CurriculumState.error);
    });
  });

  group('nomzod savollar', () {
    final pack = ContentPack.fromJson(fixturePack());
    final bank = ToifaBank.fromJson(
      (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
      (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
    );
    final cur = Curriculum.parse(fixtureCurriculum());

    test('test: curriculum ro‘yxati (toifa), bitta kalitli', () {
      final qs = testCandidates(cur.topic('t001-L')!, pack, bank);
      expect(qs.map((q) => q.id), containsAll(['t-1', 't-2', 'b1']));
      expect(qs.every((q) => q.correct.length == 1), isTrue);
    });

    test('ro‘yxat bo‘lmasa — havolalar bo‘yicha (paket mavzusi)', () {
      final qs = testCandidates(cur.topic('t001-P')!, pack, bank);
      expect(qs.map((q) => q.id), containsAll(['s1', 's2', 's3']));
    });

    test('og‘zaki: ro‘yxat yoki toifa mavzusi', () {
      expect(oralCandidates(cur.topic('t001-L')!, bank).map((q) => q.id), [
        'o-1',
        'o-2',
      ]);
      expect(oralCandidates(cur.topic('t001-L')!, null), isEmpty);
      expect(oralCandidates(cur.topic('t001-P')!, bank), isEmpty);
    });

    test('aralash bank: paket va toifa savoli bitta manbada', () {
      final s = ClassQuestionSource.of(pack, bank);
      expect(s.question('t-1'), isNotNull);
      expect(s.question('b1'), isNotNull);
      expect(identical(ClassQuestionSource.of(pack, bank), s), isTrue);
    });
  });

  test('ustoz qurilmasidagi ma’lumot saqlanadi va tiklanadi', () async {
    final store = MemoryKeyValueStore();
    final a = ClassroomLocal(store);
    await a.setStartDate('g1', DateTime(2026, 1, 5, 13));
    await a.setLocalName('g1', 'u1', '  Aliyev Anvar ');
    await a.setAsked('g1', 't001-L', 'o-1', value: true);
    await a.setGrade('g1', 't001-L', 'o-1', 'u1', OralGrade.partial);
    final b = ClassroomLocal(store);
    expect(b.startDate('g1'), DateTime(2026, 1, 5));
    expect(b.localName('g1', 'u1'), 'Aliyev Anvar');
    expect(b.asked('g1', 't001-L', 'o-1'), isTrue);
    expect(b.askedCount('g1', 't001-L'), 1);
    expect(b.grade('g1', 't001-L', 'o-1', 'u1'), OralGrade.partial);
    await b.setLocalName('g1', 'u1', '');
    await b.setGrade('g1', 't001-L', 'o-1', 'u1', null);
    expect(ClassroomLocal(store).localName('g1', 'u1'), isNull);
    expect(ClassroomLocal(store).grades('g1', 't001-L', 'o-1'), isEmpty);
    expect(StoreKeys.all, contains(StoreKeys.classroomLocal));
  });
}
