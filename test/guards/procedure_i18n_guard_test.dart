// Qorovul: manipulyatsiya nomlari, bo'lim sarlavhalari va ruscha qadamlar.
// en/ru interfeysda nom va sarlavha bo'sh yoki o'zbekcha qolmasin; ruscha
// matnda o'zbekcha so'z va ruscha maydonlarda lotin harflari ko'p bo'lmasin;
// har ro'yxatning elementlar soni asl bilan teng (1:1 tarjima).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final _cyr = RegExp('[Ѐ-ӿ]');
final _lat = RegExp('[A-Za-z]');
final _uz = RegExp(r"o[‘'’ʻ]|g[‘'’ʻ]|\b(uchun|qanday|bilan|inyeksiya|bemor)\b");

void main() {
  final raw = (jsonDecode(
    File('assets/content/reference/procedures.json').readAsStringSync(),
  ) as Map).cast<String, Object?>();
  final procs = [
    for (final p in raw['procedures']! as List)
      (p as Map).cast<String, Object?>(),
  ];
  final groupTr = (raw['group_tr']! as Map).cast<String, Object?>();

  test('bo‘lim sarlavhalari: uz/ru/en uchalasi bor', () {
    final groups = {for (final p in procs) p['group']! as String};
    for (final g in groups) {
      final t = (groupTr[g] as Map?)?.cast<String, Object?>();
      expect(t, isNotNull, reason: g);
      expect('${t!['ru']}', matches(_cyr), reason: 'ru $g');
      expect('${t['en']}'.trim(), isNotEmpty, reason: 'en $g');
      expect(t['en'], isNot(g), reason: 'en $g o‘zbekcha qolgan');
      expect(t['ru'], isNot(g), reason: 'ru $g o‘zbekcha qolgan');
    }
  });

  for (final p in procs) {
    test('${p['id']}: ru/en nom va ruscha qadamlar', () {
      final tr = (p['tr']! as Map).cast<String, Object?>();
      final ru = (tr['ru']! as Map).cast<String, Object?>();
      final en = (tr['en']! as Map).cast<String, Object?>();
      expect('${ru['title']}', matches(_cyr));
      expect('${en['title']}'.trim(), isNotEmpty);
      expect(en['title'], isNot(p['title']), reason: 'en nom o‘zbekcha');
      expect(_cyr.hasMatch('${en['title']}'), isFalse);
      for (final k in [
        'indications',
        'contraindications',
        'equipment',
        'checklist',
        'risks',
        'steps',
      ]) {
        final base = (p[k] as List? ?? const []);
        final tl = (ru[k] as List? ?? const []);
        expect(tl.length, base.length, reason: '$k soni');
        for (final e in tl) {
          final s = e is Map ? '${e['text']}' : '$e';
          expect(s, matches(_cyr), reason: '$k: $s');
          expect(
            _uz.hasMatch(s.toLowerCase()),
            isFalse,
            reason: '$k o‘zbekcha: $s',
          );
          // Lotin harflari: faqat "10x15 sm" kabi o'lchov / rim raqami.
          final lat = _lat.allMatches(s).length;
          expect(lat, lessThan(6), reason: '$k lotin: $s');
        }
      }
      expect('${ru['goal']}', matches(_cyr));
    });
  }
}
