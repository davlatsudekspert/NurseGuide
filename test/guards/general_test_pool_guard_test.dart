// Qorovul: “Umumiy test berish” — har manbaning (toifa, ma'ruza modullari va
// kunlari, analizlar) har bir tanlanadigan mavzusi hovuzidagi savol id lari
// ustoz, talaba, katta ekran va natijalar ishlatadigan indeksda
// (classQuestionIndex) topilishi va server kaliti (`correct.single`)
// variantlar ichida bo'lishi shart. Haqiqiy asset'lar bilan.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/classroom/general_test.dart';
import 'package:nurseguide/features/classroom/topic_questions.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/learn/exam_question.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart' show Locale;

import '../helpers/server_rules.dart';

import '../helpers/fixtures.dart';

void main() {
  final cur = Curriculum.parse(fixtureCurriculum());
  final pack = ContentPack.fromJson(fixturePack());
  final bank = ToifaBank.fromJson(
    (jsonDecode(fixtureToifaTests()) as Map).cast<String, Object?>(),
    (jsonDecode(fixtureToifaOral()) as Map).cast<String, Object?>(),
  );
  final catalog = GeneralCatalog.of(cur, pack, bank);
  final index = classQuestionIndex(pack, bank);
  final server = ServerRules.load();

  test('har manba mavzusi: id indeksda, server kaliti oralig‘ida', () {
    final problems = <String>[];
    void check(String where, List<ExamQuestion> qs) {
      if (qs.isEmpty) problems.add('$where: bo‘sh');
      final ids = <String>{};
      for (final q in qs) {
        if (!ids.add(q.id)) problems.add('$where: takror ${q.id}');
        final hit = index[q.id];
        if (hit == null) {
          problems.add('$where: indeksda yo‘q ${q.id}');
          continue;
        }
        if (hit.correct.length != 1) {
          problems.add('$where: bitta javob emas ${q.id}');
          continue;
        }
        if (!server.idRe.hasMatch(q.id)) problems.add('$where: id ${q.id}');
        final k = hit.correct.single;
        if (k < 0 || k >= hit.optionCount || k > server.maxKey) {
          problems.add('$where: kalit $k oraliqda emas ${q.id}');
        }
        // Indeksdagi savol — xuddi shu kalit (ustoz yuborgan = server).
        if (q.correct.single != k) problems.add('$where: kalit farqi ${q.id}');
      }
    }

    for (final s in GeneralSource.values) {
      for (final t in catalog.topicsOf(s)) {
        check(t.key, t.questions);
      }
    }
    for (final m in catalog.modules) {
      check(m.key, m.questions);
    }
    // “Hammasini tanlash” har manbada va hammasi birga.
    for (final s in GeneralSource.values) {
      final keys = {for (final t in catalog.topicsOf(s)) t.key};
      check('all:${s.name}', generalPool(catalog.strata(keys)));
    }
    check(
      'all',
      generalPool(catalog.strata({for (final t in catalog.all) t.key})),
    );
    expect(problems, isEmpty);
  });

  test(
    'standart sarlavha (uz/ru/en) server chegarasida — har manba va hammasi',
    () {
      final problems = <String>[];
      final sets = <String, Set<String>>{
        for (final t in catalog.all) t.key: {t.key},
        for (final s in GeneralSource.values)
          'all:${s.name}': {for (final t in catalog.topicsOf(s)) t.key},
        'all': {for (final t in catalog.all) t.key},
        'mix': {
          ...catalog.toifa.take(4).map((t) => t.key),
          for (final d in catalog.modules.last.days.take(3)) d.key,
          ...catalog.packGroups.take(2).map((t) => t.key),
        },
      };
      for (final lang in ['uz', 'ru', 'en']) {
        final l = lookupAppLocalizations(Locale(lang));
        for (final e in sets.entries) {
          final t = generalTestTitle(l, lang, catalog, e.value);
          if (t.trim().length < 3 || t.length > server.titleMax) {
            problems.add('${e.key}/$lang: ${t.length}');
          }
        }
      }
      expect(problems, isEmpty);
    },
  );
}
