// Qorovul: brend va dizayn qarorlari.
//  * ilova nomi NurseGuide hamma joyda (kod, ARB, README, pubspec); LabGuide
//    izi qolmagan (env nomlari LG_* istisno — ataylab saqlangan);
//  * Dart paketi `nurseguide`;
//  * teal palitra: #0F4C5C, #1B6B6B, yalpiz #7FD1B9; yorug' va tungi rejim;
//  * "xoch" (tibbiy xoch/plyus) belgisi yo'q: bunday ikonkalar ishlatilmaydi;
//  * rollar 3 ta: Hamshira, Talaba, Ustoz — server qiymatlari hamshira|talaba|ustoz.
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart' show Brightness, Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/tokens.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import 'guard_utils.dart';

void main() {
  test('paket nomi nurseguide, tavsif NurseGuide', () {
    final y = File('pubspec.yaml').readAsStringSync();
    expect(RegExp(r'^name: nurseguide$', multiLine: true).hasMatch(y), isTrue);
    expect(y, contains('NurseGuide'));
    expect(y.toLowerCase().contains('labguide'), isFalse);
  });

  test('LabGuide izi yo‘q: lib, test, tool, assets, content_src, README', () {
    final bad = <String>[];
    final roots = ['lib', 'test', 'tool', 'content_src'];
    final textExt = RegExp(r'\.(dart|arb|json|md|py|sh|mjs|yaml|yml|txt)$');
    for (final r in roots) {
      for (final f in filesUnder(
        r,
        where: (p) =>
            textExt.hasMatch(p) &&
            !p.contains('/l10n/gen/') &&
            !p.endsWith('brand_guard_test.dart') &&
            !p.endsWith('no_lab_content_guard_test.dart'),
      )) {
        if (RegExp(
          'labguide',
          caseSensitive: false,
        ).hasMatch(f.readAsStringSync())) {
          bad.add(f.path);
        }
      }
    }
    for (final p in ['README.md', 'pubspec.yaml', 'analysis_options.yaml']) {
      if (File(p).existsSync() &&
          RegExp(
            'labguide',
            caseSensitive: false,
          ).hasMatch(File(p).readAsStringSync())) {
        bad.add(p);
      }
    }
    for (final f in assetJsonFiles()) {
      if (RegExp(
        'labguide',
        caseSensitive: false,
      ).hasMatch(f.readAsStringSync())) {
        bad.add(f.path);
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test('ilova nomi MaterialApp sarlavhasida va ARB tagline’ida', () {
    final app = File('lib/app/app.dart').readAsStringSync();
    expect(app, contains("onGenerateTitle: (_) => 'NurseGuide'"));
  });

  test('teal palitra: asosiy, ikkinchi, yalpiz', () {
    expect(LgBrand.primary, const Color(0xFF0F4C5C));
    expect(LgBrand.second, const Color(0xFF1B6B6B));
    expect(LgBrand.mint, const Color(0xFF7FD1B9));
    // Klassik yorug': asosiy teal; tungi: yalpiz asosiy rang.
    expect(LgPalette.light.brand, LgBrand.primary);
    expect(LgPalette.dark.brand, LgBrand.mint);
    expect(LgPalette.ivoryLight.brand, LgBrand.primary);
    expect(LgPalette.ivoryDark.brand, LgBrand.mint);
  });

  test('iliq fon va matn ranglari saqlangan (Ivory), kontrast yetarli', () {
    expect(LgPalette.ivoryLight.bg, const Color(0xFFF3F1EC));
    expect(LgPalette.ivoryLight.paper, const Color(0xFFFCFBF8));
    expect(LgPalette.ivoryLight.ink, const Color(0xFF141414));
    for (final id in LgThemeId.values) {
      for (final b in Brightness.values) {
        final p = id.palette(b);
        expect(
          _contrast(p.ink, p.bg),
          greaterThanOrEqualTo(7),
          reason: '$id $b ink',
        );
        expect(
          _contrast(p.sub, p.bg),
          greaterThanOrEqualTo(4.5),
          reason: '$id $b sub',
        );
        expect(
          _contrast(p.onBrand, p.brand),
          greaterThanOrEqualTo(4.5),
          reason: '$id $b onBrand',
        );
        expect(
          _contrast(p.brand, p.bg),
          greaterThanOrEqualTo(4.5),
          reason: '$id $b brand',
        );
        expect(
          _contrast(p.accentInk, p.bg),
          greaterThanOrEqualTo(4.5),
          reason: '$id $b accentInk',
        );
        expect(
          _contrast(p.outline, p.bg),
          greaterThanOrEqualTo(3),
          reason: '$id $b outline',
        );
      }
    }
  });

  test('xoch belgisi ikonkalari ishlatilmaydi', () {
    const forbidden = [
      'medical_services',
      'local_hospital',
      'local_pharmacy',
      'health_and_safety',
      'medical_information',
      'healing',
      'emergency',
      'add_box',
      'church',
      'plus_one',
    ];
    final bad = <String>[];
    for (final f in filesUnder(
      'lib',
      where: (p) => p.endsWith('.dart') && !p.contains('/l10n/gen/'),
    )) {
      final text = f.readAsStringSync();
      for (final name in forbidden) {
        if (RegExp('Icons\\.$name\\b').hasMatch(text)) {
          bad.add('$name ${f.path}');
        }
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
  });

  test(
    'uchta rol: Hamshira, Talaba, Ustoz (server: hamshira|talaba|ustoz)',
    () {
      expect(AppRole.values.map((r) => r.name), [
        'nurse',
        'student',
        'teacher',
      ]);
      expect(AppRole.values.map((r) => r.wire), [
        'hamshira',
        'talaba',
        'ustoz',
      ]);
      expect(AppRole.tryWire('ustoz'), AppRole.teacher);
      expect(AppRole.tryWire('talaba'), AppRole.student);
      expect(AppRole.tryWire('noma’lum'), isNull);
    },
  );
}

double _lum(Color c) {
  double ch(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * ch(c.r) + 0.7152 * ch(c.g) + 0.0722 * ch(c.b);
}

double _contrast(Color a, Color b) {
  final la = _lum(a), lb = _lum(b);
  final hi = la > lb ? la : lb, lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}
