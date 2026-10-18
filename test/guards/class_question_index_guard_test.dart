// Qorovul: ustoz topshirgan mavzu testining har bir savoli ustoz, talaba va
// katta ekran ishlatadigan indeksda (classQuestionIndex) topilishi kerak.
// 2026-10-18: deck matnidan olingan (derived) savollar indeksga kirmay
// qolgan — ustoz “Talaba ko'rinishida sinash”da va talaba testda “savol
// ilovangizdagi to'plamda yo'q” xatosini ko'rgan.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/classroom/topic_questions.dart';
import 'package:nurseguide/features/classroom/topic_test.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

import '../helpers/fixtures.dart';

void main() {
  // (1-xato) Topshiriq savollari BITTA umumiy indeksdan, id bo'yicha
  // olinadi: indeks hamma savolni (paket — deck matnidan olinganlar bilan —
  // va toifa banki) o'z ichiga oladi; ekranlar boshqa yo'l bilan qidirmaydi.
  test('topshiriq ekranlari savolni faqat umumiy indeksdan qidiradi', () {
    const files = [
      'lib/features/learn/classes_screens.dart',
      'lib/features/classroom/board_screen.dart',
      'lib/features/classroom/topic_test_screens.dart',
      'lib/features/learn/exam_widgets.dart',
    ];
    for (final f in files) {
      final src = File(f).readAsStringSync();
      expect(
        src.contains('classQuestionIndex') ||
            src.contains('ClassQuestionSource'),
        isTrue,
        reason: f,
      );
      // Alohida (yarim) indeks yig'ish yo'q: paket yoki bankdan to'g'ridan-to'g'ri
      // topshiriq savoli qidirilmaydi.
      expect(
        src.contains('PackQuestionSource.of(pack).question('),
        isFalse,
        reason: f,
      );
      expect(RegExp(r'bank\??\.test\(').hasMatch(src), isFalse, reason: f);
    }
  });

  test('indeks: paket (derived ham) + toifa banki, takrorsiz', () {
    final pack = ContentPack.fromJson(fixturePack());
    final bank = ToifaBank.fromJson(
      (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
      (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
    );
    final index = classQuestionIndex(pack, bank);
    expect(index.length, pack.quiz.length + bank.scorable.length);
    expect(index.containsKey('dv1'), isTrue, reason: 'derived savol ham');
    expect(classQuestionIndex(pack, null).length, pack.quiz.length);
    expect(classQuestionIndex(null, bank).length, bank.scorable.length);
    expect(classQuestionIndex(null, null), isEmpty);
  });

  test('mavzu testi savollarining hammasi topshiriq indeksida bor', () {
    final cur = Curriculum.parse(fixtureCurriculum());
    final pack = ContentPack.fromJson(fixturePack());
    final bank = ToifaBank.fromJson(
      (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
      (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
    );
    final index = classQuestionIndex(pack, bank);
    var derived = 0;
    final missing = <String>[];
    for (final t in cur.topics) {
      final derivedIds = t.derivedQuizCandidates.toSet();
      for (final q in verifiedTopicQuestions(t, pack, bank)) {
        if (derivedIds.contains(q.id)) derived++;
        if (!index.containsKey(q.id)) missing.add('${t.id}: ${q.id}');
      }
    }
    expect(missing, isEmpty);
    // Derived savollar haqiqatan tekshirildi (bo'sh to'plam emas).
    expect(derived, greaterThan(0));
  });
}
