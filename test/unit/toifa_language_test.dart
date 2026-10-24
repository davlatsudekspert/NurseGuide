import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';

Map<String, Object?> _json(String name) =>
    (jsonDecode(File('assets/toifa/$name').readAsStringSync()) as Map)
        .cast<String, Object?>();

void main() {
  final bank = ToifaBank.fromJson(_json('tests.json'), _json('oral.json'));

  test(
    'tarjimasi yo‘q yangi yo‘nalishlar inglizcha interfeysda ko‘rinmaydi',
    () {
      final uz = bank.forLanguage('uz');
      final ru = bank.forLanguage('ru');
      final en = bank.forLanguage('en');
      expect(identical(uz, bank), isTrue);
      expect(ru.tests.length, uz.tests.length);
      expect(en.tests.length, lessThan(uz.tests.length));
      expect(en.tests.where((q) => q.bank == 'akusherlik'), isEmpty);
      expect(en.tests.where((q) => q.bank == 'rentgen_laborant'), isEmpty);
      expect(uz.tests.where((q) => q.bank == 'akusherlik'), isNotEmpty);
    },
  );

  test('avvalgi (rasmiy) savollar hamma tilda qoladi', () {
    final en = bank.forLanguage('en');
    final official = bank.tests.where((q) => q.langs == null).length;
    expect(en.tests.length, official);
    for (final b in ['hamshiralik', 'oliy_hamshiralik', 'patronaj']) {
      expect(en.tests.where((q) => q.bank == b), isNotEmpty, reason: b);
    }
  });

  test('inglizchada ham tarixdagi savol id bo‘yicha topiladi', () {
    final q = bank.tests.firstWhere((q) => q.bank == 'akusherlik');
    expect(bank.forLanguage('en').test(q.id), isNull);
    expect(bank.test(q.id), isNotNull);
  });
}
