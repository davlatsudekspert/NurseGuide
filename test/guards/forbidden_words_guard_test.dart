// Qorovul: foydalanuvchi ko'radigan matnlarda va asset JSON'da taqiqlangan
// so'zlar yo'q: "Draft" (barcha registr, so'z sifatida), "Qoralama"
// (qoralama), ruscha "черновик". Tekshiriladi: ARB (uz/ru/en), asset JSON
// (qiymatlar HAM `status` maydoni), Dart satr literallari (izohlar emas).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'guard_utils.dart';

final _forbidden = RegExp(
  r'\bdraft(s)?\b|qoralama|(?<![\p{L}])черновик',
  caseSensitive: false,
  unicode: true,
);

void main() {
  test('ARB matnlarida taqiqlangan so‘z yo‘q (uz/ru/en)', () {
    final bad = <String>[];
    for (final l in ['uz', 'ru', 'en']) {
      final arb = (jsonDecode(
        File('lib/l10n/app_$l.arb').readAsStringSync(),
      ) as Map).cast<String, Object?>();
      for (final e in arb.entries) {
        if (e.key.startsWith('@')) continue;
        final v = e.value;
        if (v is String && _forbidden.hasMatch(v)) bad.add('$l ${e.key}');
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test('asset JSON qiymatlarida taqiqlangan so‘z yo‘q (status: draft ham)', () {
    final bad = <String>[];
    for (final f in assetJsonFiles()) {
      for (final s in jsonStrings(readJson(f))) {
        if (_forbidden.hasMatch(s.text)) bad.add('${f.path} ${s.path}');
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test('Dart satr literallarida taqiqlangan so‘z yo‘q', () {
    final bad = <String>[];
    final literal = RegExp(r'''(['"])((?:\\.|(?!\1).)*)\1''');
    for (final f in filesUnder(
      'lib',
      where: (p) => p.endsWith('.dart') && !p.contains('/l10n/gen/'),
    )) {
      final lines = f.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.trimLeft().startsWith('//')) continue;
        for (final m in literal.allMatches(line)) {
          if (_forbidden.hasMatch(m.group(2)!)) bad.add('${f.path}:${i + 1}');
        }
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test('guard o‘zi ishlaydi', () {
    for (final w in ['Draft', 'draft', 'Qoralama', 'qoralamaga', 'Черновик']) {
      expect(_forbidden.hasMatch(w), isTrue, reason: w);
    }
    expect(_forbidden.hasMatch('drafting table'), isFalse);
    expect(_forbidden.hasMatch('Tekshirilmoqda'), isFalse);
  });
}
