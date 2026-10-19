// Qorovul (do'kon talabi, Apple 2.1): ilovada «tugallanmagan» ko'rsatadigan
// va'da-so'zlar yo'q — "keyingi yangilanishda", "tez orada", "coming soon"
// va shu ma'nodagilar. Tekshiriladi: ARB (uz/ru/en) va ilovaga kiradigan
// JSON kontent (assets/). Tayyor bo'lmagan bo'lim tayyor bo'lguncha yashirin
// turadi — ekranda va'da yozilmaydi.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final _promises = RegExp(
  [
    r'keyingi\s+(yangilanish|versiya|nashr)',
    r'kelgusi\s+(yangilanish|versiya)',
    r'tez\s+(orada|kunda)',
    r'yaqin\s+(orada|kunlarda)',
    r'tayyorlanmoqda',
    r'coming\s+soon',
    r'(?<![\p{L}])soon(?![\p{L}])',
    r'(next|later|future)\s+(update|version|release)',
    r'being\s+(prepared|developed)',
    r'under\s+construction',
    r'(?<![\p{L}])скоро(?![\p{L}])',
    r'в\s+следующ\p{L}+\s+(обновлени|верси)',
    r'в\s+ближайшее\s+время',
  ].join('|'),
  caseSensitive: false,
  unicode: true,
);

List<String> _strings(Object? v) => switch (v) {
  final String s => [s],
  final List<Object?> l => [for (final e in l) ..._strings(e)],
  final Map<Object?, Object?> m => [for (final e in m.values) ..._strings(e)],
  _ => const [],
};

void main() {
  test('ARB: va’da-so‘z yo‘q (uz, ru, en)', () {
    final bad = <String>[];
    for (final l in ['uz', 'ru', 'en']) {
      final arb =
          jsonDecode(File('lib/l10n/app_$l.arb').readAsStringSync()) as Map;
      for (final e in arb.entries) {
        if ((e.key as String).startsWith('@')) continue;
        final m = _promises.firstMatch('${e.value}');
        if (m != null) bad.add('$l ${e.key}: «${m.group(0)}»');
      }
    }
    expect(bad, isEmpty, reason: bad.take(10).join('\n'));
  });

  test('assets/ JSON kontent: va’da-so‘z yo‘q', () {
    final bad = <String>[];
    for (final f in Directory('assets').listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.json')) continue;
      final text = f.readAsStringSync();
      if (!_promises.hasMatch(text)) continue;
      for (final s in _strings(jsonDecode(text))) {
        final m = _promises.firstMatch(s);
        if (m != null) bad.add('${f.path}: «${m.group(0)}»');
      }
    }
    expect(bad, isEmpty, reason: bad.take(10).join('\n'));
  });

  test('qorovul o‘zi ishlaydi', () {
    for (final s in [
      'Keyingi yangilanishda: kalkulyatorlar',
      'Tez orada',
      'Coming soon',
      'Questions are coming soon',
      'В следующем обновлении',
      'Вопросы скоро появятся',
    ]) {
      expect(_promises.hasMatch(s), isTrue, reason: s);
    }
    expect(_promises.hasMatch('Skorost, tezkor yordam'), isFalse);
    expect(_promises.hasMatch('скорость пульса'), isFalse);
  });
}
