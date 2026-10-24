// Qorovul: NurseGuide'da laboratoriya (LabGuide) kontenti YO'Q. lib/, assets/,
// l10n (ARB), test/, tool/ va content_src/ da laboratoriyaga xos atamalar
// uchramaydi (katta-kichik harf farq qilmaydi). Hamshiralikda ham ishlatiladigan
// so'zlar ataylab ro'yxatga kiritilmagan (masalan, «glyukometriya» — qon
// qandini o'lchash hamshira manipulyatsiyasi; «tahlil» — umumiy so'z;
// «differensial tashxis» — klinik atama). Ro'yxat 4-bosqichda kontent
// kelganda kengaytirilmaydi, aksincha: yangi lab so'zi paydo bo'lsa test
// yiqiladi.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'guard_utils.dart';

final _labTerms = RegExp(
  [
    r'leyko\w*formula',
    r'leukoformula',
    r'laborator',
    r'laboratory',
    r'laboratori',
    r'лаборатор',
    r'спермограмм',
    r'spermogram',
    r'sitolog',
    r'cytolog',
    r'цитолог',
    r'gistolog',
    r'histolog',
    r'гистолог',
    r'siydik',
    r'urinalys',
    r'моч[аеиу]\b',
    r'koagulogram',
    r'coagulogram',
    r'коагулограмм',
    r'koprolog',
    r'coprolog',
    r'копролог',
    r'qon guruh',
    r'bloodgroup',
    r'blood group',
    r'группа крови',
    r'bloodmorph',
    r'mikroskop',
    r'microscop',
    r'микроскоп',
    r'kalibr',
    r'calibrat',
    r'калибров',
    r'analit(?!ik)',
    r'analyte',
    r'аналит(?!ик|ич)',
    r'biokim',
    r'biochem',
    r'биохим',
    r'gematolog',
    r'hematolog',
    r'гематолог',
    r'kreatinin',
    r'creatinine',
    r'креатинин',
    r'reagent',
    r'reaktiv',
    r'реагент',
    r'\bQC\b',
    r'\bIFU\b',
    r'\bLab\b',
    r'labguide',
    r'лабгайд',
    r'immunoassay',
    r'analizator',
    r'анализатор',
  ].join('|'),
  caseSensitive: false,
  unicode: true,
);

// assets/toifa, assets/content/reference va content_src — hamshiralik kontenti: ularda «siydik», «laboratoriya»
// kabi so'zlar klinik ma'noda uchraydi. Ularga lab kontenti kirmasligi bank
// manbalari (faqat hamshiralik banklari) bilan ta'minlanadi.
bool _scanned(String p) =>
    !p.contains('assets/toifa/') &&
    !p.contains('assets/content/reference/') &&
    !p.contains('content_src/') &&
    !p.contains('/l10n/gen/') &&
    !p.endsWith('no_lab_content_guard_test.dart') &&
    !p.endsWith('brand_guard_test.dart') &&
    !p.endsWith('.png') &&
    !p.endsWith('.jpg') &&
    !p.endsWith('.webp') &&
    !p.endsWith('.ttf') &&
    !p.endsWith('.txt') &&
    !p.endsWith('.gitkeep');

void main() {
  test(
    'lib, assets, ARB, test, tool, content_src: laboratoriya atamalari yo‘q',
    () {
      final hits = <String>[];
      for (final root in ['lib', 'assets', 'test', 'tool', 'content_src']) {
        for (final f in filesUnder(root, where: _scanned)) {
          final text = f.readAsStringSync();
          for (final m in _labTerms.allMatches(text)) {
            final line = text.substring(0, m.start).split('\n').length;
            hits.add('${f.path}:$line «${m.group(0)}»');
            break;
          }
        }
      }
      expect(hits, isEmpty, reason: hits.take(20).join('\n'));
    },
  );

  test('guard o‘zi ishlaydi: lab atamalari topiladi', () {
    for (final w in [
      'Leykoformula',
      'Klinik laboratoriya',
      'Spermogramma',
      'Qon guruhi',
      'Mikroskopiya',
      'Kalibrlash',
      'Analit kartasi',
      'QC jurnali',
      'Группа крови',
    ]) {
      expect(_labTerms.hasMatch(w), isTrue, reason: w);
    }
    for (final ok in [
      'Qon bosimini o‘lchash',
      'Inyeksiya texnikasi',
      'Glyukometriya',
      'Xatolar tahlili',
      'Differensial tashxis',
      'Ish joyi',
      'Подкожная инъекция',
    ]) {
      expect(_labTerms.hasMatch(ok), isFalse, reason: ok);
    }
  });

  test('assets/ da lab kontent papkalari yo‘q', () {
    for (final d in [
      'differential',
      'cytology',
      'spermogram',
      'bloodgroup',
      'histology',
      'urinalysis',
      'bloodmorph',
      'coagulogram',
      'coprology',
      'microscopy',
      'instruments',
      'lectures/d001',
      'curriculum',
    ]) {
      expect(Directory('assets/$d').existsSync(), isFalse, reason: d);
    }
  });
}
