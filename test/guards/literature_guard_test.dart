// Adabiyotlar qorovuli: har bir savol, muolaja va atamaning manbasi
// Adabiyotlar ro'yxatida bor (yetim manba yo'q); kitob matni ilovaga
// ko'chirilmagan (qisqa iqtibos va o'z so'z bilan, manba ostida).
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/reference/reference_data.dart';

Map<String, Object?> _json(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, Object?>();

int _words(String s) => s.trim().split(RegExp(r'\s+')).length;

void main() {
  late ReferenceData data;

  setUpAll(() async {
    final bundle = _FileBundle();
    data = await ReferenceData.load(bundle);
  });

  test('adabiyotlar ro‘yxati: id takrorlanmaydi, havolalar https', () {
    final ids = [for (final e in data.literature) e.id];
    expect(ids.toSet().length, ids.length);
    for (final e in data.literature) {
      expect(e.match, isNotEmpty, reason: e.id);
      expect(
        ['textbooks', 'official', 'open', 'other'],
        contains(e.group),
        reason: e.id,
      );
      if (e.url != null) expect(e.url, startsWith('https://'), reason: e.id);
    }
  });

  test('yetim manba yo‘q: savol, muolaja va atama manbasi ro‘yxatda', () {
    final orphans = <String>[
      for (final q in data.questions)
        if (data.entryFor(q.source) == null) 'savol ${q.id}: ${q.source}',
      for (final p in data.procedures)
        if (data.entryFor(p.source) == null) 'muolaja ${p.id}: ${p.source}',
      for (final t in data.glossary)
        if (data.entryFor(t.source) == null) 'atama ${t.term}: ${t.source}',
      for (final c in data.dmed)
        if (data.entryFor(c.source) == null) 'DMED ${c.id}: ${c.source}',
    ];
    expect(orphans, isEmpty, reason: orphans.take(5).join('\n'));
  });

  test('har bir material manbaga hisoblanadi (hisob yig‘indisi to‘g‘ri)', () {
    final usage = data.usage();
    final sum = usage.fold<int>(0, (a, u) => a + u.total);
    expect(
      sum,
      data.questions.length +
          data.procedures.length +
          data.glossary.length +
          data.dmed.length,
    );
    expect(usage.any((u) => u.total == 0), isFalse);
  });

  test('DMED kartalari: manba, guruh va kirill harfi yo‘q', () {
    final groups = {for (final g in data.dmedGroups) g.id};
    final ids = <String>{};
    expect(data.dmed, isNotEmpty);
    for (final c in data.dmed) {
      expect(ids.add(c.id), isTrue, reason: 'takror ${c.id}');
      expect(groups, contains(c.group), reason: c.id);
      expect(c.source, startsWith('Manba:'), reason: c.id);
      expect(c.question.trim(), isNotEmpty, reason: c.id);
      expect(c.answer.trim(), isNotEmpty, reason: c.id);
      expect(
        RegExp('[\\u0400-\\u04FF]').hasMatch('${c.question}${c.answer}'),
        isFalse,
        reason: c.id,
      );
    }
  });

  test('mualliflik huquqi: ilovada kitob matni ko‘chirilmagan', () {
    for (final t in data.glossary) {
      // Atama ta'rifi — qisqa (1–2 gap) iqtibos, manba bilan.
      expect(_words(t.definition), lessThanOrEqualTo(40), reason: t.term);
      expect(t.source, startsWith('Manba:'), reason: t.term);
      expect(t.page, greaterThan(0), reason: t.term);
    }
    for (final p in data.procedures) {
      for (final s in p.steps) {
        expect(_words(s), lessThanOrEqualTo(30), reason: p.id);
      }
      expect(p.source, startsWith('Manba:'), reason: p.id);
      expect(p.pages, isNotEmpty, reason: p.id);
    }
    // Shipped glossary'da kitobdan to'liq gap ("quote") maydoni yo'q.
    final raw = _json('assets/content/reference/glossary.json');
    for (final t in raw['terms']! as List) {
      expect((t as Map).containsKey('quote'), isFalse, reason: '${t['term']}');
    }
    // Ilova assetlarida PDF yo'q.
    final pdfs = Directory('assets')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.toLowerCase().endsWith('.pdf'))
        .map((f) => f.path)
        .toList();
    expect(pdfs, isEmpty, reason: '$pdfs');
  });
}

/// Fayl tizimidan o'qiydigan oddiy bundle (flutter test ichida rootBundle
/// ham ishlaydi, lekin bu qorovul sof birlik testi).
class _FileBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(File(key).readAsBytesSync());
}
