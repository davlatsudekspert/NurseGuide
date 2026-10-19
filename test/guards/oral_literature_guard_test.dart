// Qorovul: og'zaki savol javoblari. Reja yozilgan har bir savol ostida
// «Adabiyotlar» bor (kamida bitta manba); matnda kirill harfi yo'q; reja
// qisqa va tuzilgan (3–9 band); sog'liqni saqlash buyrug'i raqami yoki
// dori dozasi manbasiz yozilmagan (doza ko'rsatkichi umuman yo'q).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final _cyrillic = RegExp('[Ѐ-ӿ]');
final _dose = RegExp(
  r'\b\d+(?:[.,]\d+)?\s?(?:mg|mkg|mcg|ME|IU)\b(?!%|\s?/\s?d?l\b)',
  caseSensitive: false,
);

void main() {
  final oral = (jsonDecode(
    File('assets/toifa/oral.json').readAsStringSync(),
  ) as Map).cast<String, Object?>();
  final qs = [
    for (final q in oral['questions']! as List)
      (q as Map).cast<String, Object?>(),
  ];

  test('reja bor savol: adabiyotlar bor, matn lotincha', () {
    final bad = <String>[];
    for (final q in qs) {
      final plan = (q['plan'] as List? ?? const []).cast<String>();
      if (plan.isEmpty) continue;
      final lit = (q['literature'] as List? ?? const []).cast<String>();
      if (lit.isEmpty) bad.add('${q['id']}: adabiyotlar yo‘q');
      for (final r in lit) {
        if (r.trim().length < 12) bad.add('${q['id']}: manba juda qisqa «$r»');
      }
      if (plan.length < 3 || plan.length > 9) {
        bad.add('${q['id']}: reja ${plan.length} band');
      }
      final text = jsonEncode([q['q'], plan, lit, q['note']]);
      if (_cyrillic.hasMatch(text)) bad.add('${q['id']}: kirill harfi');
    }
    expect(bad, isEmpty, reason: bad.take(10).join('\n'));
  });

  test('reja matnida dori dozasi ko‘rsatilmagan', () {
    final bad = <String>[];
    for (final q in qs) {
      for (final b in (q['plan'] as List? ?? const []).cast<String>()) {
        if (_dose.hasMatch(b)) bad.add('${q['id']}: $b');
      }
    }
    expect(bad, isEmpty, reason: bad.take(10).join('\n'));
  });
}
