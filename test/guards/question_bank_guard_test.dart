// Qorovul: savol banki (assets/toifa/tests.json + oral.json).
//
// Haqiqiy bank hali yo'q (placeholder: bo'sh ro'yxatlar) — bank bo'sh bo'lsa
// qoidalar bo'sh to'plamda bajariladi (vacuous). Bank kelganda shu testlar
// o'zi ishga tushadi. Qoidalar test fixture'ida va ataylab buzilgan
// nusxalarda ham sinaladi — qorovul ishlayotganiga ishonch hosil qilish uchun.
//
// Qoidalar: id lar takrorlanmaydi; javob kaliti variantlar oralig'ida; mavzu
// ro'yxatda; `status` ∈ official|verified|expert; takroriy savol matni yo'q;
// tarjima variantlari soni asl bilan teng; har bir ball hisoblanadigan savol
// UCH ekranda erishiladi: (1) test/imtihon hovuzi, (2) mavzu bo'yicha mashq,
// (3) guruh topshirig'i indeksi; biletlar mavjud og'zaki savollarga havola
// qiladi.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/topic_questions.dart';
import 'package:nurseguide/features/content/text_normalize.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

import '../helpers/fixtures.dart';
import 'guard_utils.dart';

const _statuses = {'official', 'verified', 'expert'};
const _verdicts = {'ok', 'disputed', 'ambiguous'};
const _categories = {'3-2', '1', 'oliy'};

typedef Json = Map<String, Object?>;

List<String> checkBank(Json tests, Json oral) {
  final problems = <String>[];
  void bad(String m) => problems.add(m);

  final topics = [...(tests['topics'] as List? ?? const []).cast<String>()];
  final questions = [
    for (final q in tests['questions'] as List? ?? const [])
      (q as Map).cast<String, Object?>(),
  ];
  final ids = <String>{};
  final numbers = <int>{};
  final texts = <String, String>{};
  for (final q in questions) {
    final id = '${q['id']}';
    if (!ids.add(id)) bad('test id takror: $id');
    final n = q['n'];
    if (n is! int || !numbers.add(n)) bad('test n takror/yo‘q: $id');
    final options = (q['options'] as List? ?? const []).cast<String>();
    if (options.length < 3 || options.length > 4) bad('variantlar soni: $id');
    if (options.map((o) => normalizeForSearch(o)).toSet().length !=
        options.length) {
      bad('takroriy variant: $id');
    }
    final key = (q['key'] as List? ?? const []).cast<int>();
    if (key.length > 1) bad('bittadan ko‘p kalit: $id');
    for (final k in key) {
      if (k < 0 || k >= options.length) bad('kalit oraliqdan tashqarida: $id');
    }
    if (!topics.contains(q['topic'])) bad('noma’lum mavzu: $id ${q['topic']}');
    if (q['status'] != null && !_statuses.contains(q['status'])) {
      bad('status noto‘g‘ri: $id ${q['status']}');
    }
    if (!_verdicts.contains(q['verdict'])) bad('verdict noto‘g‘ri: $id');
    final text = normalizeForSearch('${q['q']}');
    final prev = texts[text];
    if (prev != null) bad('takroriy savol matni: $id = $prev');
    texts[text] = id;
    final tr = (q['tr'] as Map?)?.cast<String, Object?>() ?? const {};
    for (final e in tr.entries) {
      final t = (e.value as Map).cast<String, Object?>();
      final to = (t['options'] as List? ?? const []);
      if (to.length != options.length) bad('tarjima variantlari: $id ${e.key}');
    }
  }
  final oralQs = [
    for (final q in oral['questions'] as List? ?? const [])
      (q as Map).cast<String, Object?>(),
  ];
  final oralIds = <String>{};
  for (final q in oralQs) {
    final id = '${q['id']}';
    if (!oralIds.add(id)) bad('og‘zaki id takror: $id');
    for (final c in (q['categories'] as List? ?? const []).cast<String>()) {
      if (!_categories.contains(c)) bad('noma’lum toifa: $id $c');
    }
    if (q['status'] != null && !_statuses.contains(q['status'])) {
      bad('og‘zaki status noto‘g‘ri: $id ${q['status']}');
    }
  }
  for (final t in oral['tickets'] as List? ?? const []) {
    final m = (t as Map).cast<String, Object?>();
    for (final id in (m['questions'] as List? ?? const []).cast<String>()) {
      if (!oralIds.contains(id)) bad('bilet ${m['id']}: noma’lum savol $id');
    }
  }
  if (problems.isNotEmpty) return problems;

  // Model bilan: yuklanadi va uch ekranda erishiladi.
  final ToifaBank bank;
  try {
    bank = ToifaBank.fromJson(tests, oral);
  } on Object catch (e) {
    return ['ToifaBank yuklanmadi: $e'];
  }
  final pool = {for (final q in toifaTestPool(bank)) q.id};
  final byTopic = {
    for (final t in bank.source.topics)
      for (final q in t.questions) q.id,
  };
  final classIndex = classQuestionIndex(null, bank);
  for (final q in bank.scorable) {
    if (!pool.contains(q.id)) bad('test hovuzida yo‘q: ${q.id}');
    if (!byTopic.contains(q.id)) bad('mavzu mashqida yo‘q: ${q.id}');
    if (!classIndex.containsKey(q.id)) bad('topshiriq indeksida yo‘q: ${q.id}');
  }
  return problems;
}

Json _real(String name) => File('assets/toifa/$name').existsSync()
    ? readJsonMap('assets/toifa/$name')
    : {'version': 1, 'topics': <Object?>[], 'questions': <Object?>[]};

void main() {
  group('haqiqiy bank (assets/toifa)', () {
    test('placeholder yoki haqiqiy bank qoidalarga mos', () {
      final problems = checkBank(_real('tests.json'), _real('oral.json'));
      expect(problems, isEmpty, reason: problems.take(10).join('\n'));
    });

    test('fayllar mavjud va version 1', () {
      for (final n in ['tests.json', 'oral.json']) {
        expect(File('assets/toifa/$n').existsSync(), isTrue, reason: n);
        expect(readJsonMap('assets/toifa/$n')['version'], 1);
      }
    });

    test('haqiqiy asset ilovaning bank yuklovchisidan o‘tadi', () {
      final bank = ToifaBank.fromJson(_real('tests.json'), _real('oral.json'));
      expect(bank.scorable.length, lessThanOrEqualTo(bank.tests.length));
    });
  });

  group('qorovul o‘zi ishlaydi (fixture)', () {
    Json tests() => (jsonDecode(fixtureToifaTests()) as Map).cast();
    Json oral() => (jsonDecode(fixtureToifaOral()) as Map).cast();

    List<Map<String, Object?>> qs(Json t) => [
      for (final q in t['questions']! as List) (q as Map).cast(),
    ];

    test('fixture toza (savollar bor — qoida haqiqatan tekshiriladi)', () {
      final t = tests();
      expect(qs(t).length, greaterThanOrEqualTo(10));
      expect(checkBank(t, oral()), isEmpty);
    });

    test('takroriy id topiladi', () {
      final t = tests();
      qs(t)[1]['id'] = qs(t)[0]['id'];
      expect(checkBank(t, oral()), anyElement(contains('takror')));
    });

    test('kalit oraliqdan tashqarida topiladi', () {
      final t = tests();
      qs(t)[0]['key'] = [9];
      expect(checkBank(t, oral()), anyElement(contains('oraliqdan')));
    });

    test('noto‘g‘ri status va mavzu topiladi', () {
      final t = tests();
      qs(t)[0]['status'] = 'draft';
      qs(t)[1]['topic'] = 'yo‘q';
      final p = checkBank(t, oral());
      expect(p, anyElement(contains('status')));
      expect(p, anyElement(contains('mavzu')));
    });

    test('takroriy savol matni topiladi', () {
      final t = tests();
      qs(t)[1]['q'] = qs(t)[0]['q'];
      expect(checkBank(t, oral()), anyElement(contains('takroriy')));
    });

    test('bir xil variantlar topiladi', () {
      final t = tests();
      final o = (qs(t)[0]['options']! as List).cast<String>();
      qs(t)[0]['options'] = [...o.take(o.length - 1), o.first];
      expect(checkBank(t, oral()), anyElement(contains('takroriy variant')));
    });

    test('bilet noma’lum savolga havola qilsa topiladi', () {
      final o = oral();
      ((o['tickets']! as List).first as Map)['questions'] = ['yo‘q'];
      expect(checkBank(tests(), o), anyElement(contains('bilet')));
    });

    test('tarjima variantlari soni mos kelmasa topiladi', () {
      final t = tests();
      final tr = (qs(t)[0]['tr']! as Map)['ru']! as Map;
      tr['options'] = ['faqat bitta'];
      expect(checkBank(t, oral()), anyElement(contains('tarjima')));
    });

    test('uch ekranda erishiladi: hovuz, mavzu, topshiriq indeksi', () {
      final bank = ToifaBank.fromJson(tests(), oral());
      expect(bank.scorable, hasLength(12));
      expect(toifaTestPool(bank), hasLength(12));
      expect(
        bank.source.topics
            .map((t) => t.questions.length)
            .fold(0, (a, b) => a + b),
        12,
      );
      expect(classQuestionIndex(null, bank), hasLength(12));
      // Mavzu nomi: `topic_names` dan.
      expect(bank.topicNames['safety']!['uz'], 'Xavfsizlik');
    });
  });
}
