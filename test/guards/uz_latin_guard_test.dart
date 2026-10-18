// Qorovul: o'zbekcha matnlar FAQAT lotin yozuvida (kirill harfi yo'q).
//
// Tekshiriladi:
//  * lib/l10n/app_uz.arb — barcha qiymatlar;
//  * assets/**.json — o'zbekcha matnlar: `ru`/`en`/`tr` (tarjima) kalitlari
//    ostidagi qismlar, `*_ru`/`*_en` kalitlar va `*.ru.json`/`*.en.json`
//    fayllari tashqarida qoladi (ruscha matn kirillda bo'lishi kerak).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'guard_utils.dart';

bool _translationKey(String k) =>
    k == 'ru' ||
    k == 'en' ||
    k == 'tr' ||
    k.endsWith('_ru') ||
    k.endsWith('_en') ||
    k.startsWith('ru_') ||
    k.startsWith('en_');

bool _translationFile(String p) =>
    p.endsWith('.ru.json') ||
    p.endsWith('.en.json') ||
    p.contains('_ru.json') ||
    p.contains('_en.json');

void main() {
  test('app_uz.arb: kirill harfi yo‘q', () {
    final arb = (jsonDecode(
      File('lib/l10n/app_uz.arb').readAsStringSync(),
    ) as Map).cast<String, Object?>();
    final bad = [
      for (final e in arb.entries)
        if (!e.key.startsWith('@') &&
            e.value is String &&
            cyrillic.hasMatch(e.value! as String))
          '${e.key}: ${e.value}',
    ];
    expect(bad, isEmpty, reason: bad.take(5).join('\n'));
  });

  test('assets/**.json: o‘zbekcha matnda kirill harfi yo‘q', () {
    final bad = <String>[];
    var strings = 0;
    for (final f in assetJsonFiles()) {
      if (_translationFile(f.path)) continue;
      for (final s in jsonStrings(readJson(f), skipKey: _translationKey)) {
        strings++;
        if (cyrillic.hasMatch(s.text)) bad.add('${f.path} ${s.path}');
      }
    }
    expect(bad, isEmpty, reason: '${bad.take(8).join('\n')}\n($strings matn)');
  });

  test('guard o‘zi ishlaydi: kirill topiladi, tarjima kaliti o‘tkaziladi', () {
    final sample = {
      'q': 'Savol',
      'bad': 'Савол',
      'tr': {'ru': 'Вопрос'},
      'ru': 'Вопрос',
      'title_ru': 'Заголовок',
    };
    final hits = [
      for (final s in jsonStrings(sample, skipKey: _translationKey))
        if (cyrillic.hasMatch(s.text)) s.path,
    ];
    expect(hits, ['bad']);
  });
}
