// 2-xato (iPhone): Smart Punctuation ' ni ’ ga aylantiradi — taxallus va
// qidiruvda ’ ‘ ʻ ʼ ` ´ barchasi oddiy ' ga keltiriladi (server bilan bir xil).
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/invite_link.dart';
import 'package:nurseguide/features/content/text_normalize.dart';

void main() {
  const variants = ['’', '‘', 'ʻ', 'ʼ', '`', '´'];

  test('taxallus: barcha apostrof turlari oddiy \' ga aylanadi', () {
    for (final a in variants) {
      expect(
        normalizeNickname('G${a}ayrat'),
        "G'ayrat",
        reason: 'U+${a.codeUnitAt(0).toRadixString(16)}',
      );
      expect(normalizeNickname('O${a}tkir  '), "O'tkir");
    }
  });

  test('taxallus: iPhone apostrofi bilan ism server qoidasidan o‘tadi', () {
    for (final a in variants) {
      expect(nicknameAllowed('G${a}ayrat'), isTrue, reason: a);
      expect(nicknameAllowed('Ma${a}ruf'), isTrue, reason: a);
    }
    expect(nicknameAllowed(''), isTrue, reason: 'bo‘sh — tartib raqami');
  });

  test('taxallus: emoji, belgi bilan boshlanish va juda uzun rad etiladi', () {
    for (final bad in ['😀', '!ali', '-ali', "'ali", 'a', 'x' * 40]) {
      expect(nicknameAllowed(bad), isFalse, reason: bad);
    }
  });

  test('qidiruv: apostrof variantlari farq qilmaydi', () {
    final a = normalizeForSearch('Oʻzbekiston');
    for (final v in variants) {
      expect(normalizeForSearch('O${v}zbekiston'), a);
    }
    expect(normalizeForSearch("O'zbekiston"), a);
  });
}
