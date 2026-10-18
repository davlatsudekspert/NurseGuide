// Qorovul: pubspec.yaml dagi har bir asset va shrift yo'li mavjud; `assets/`
// ichida ro'yxatga olinmagan, lekin kodda ishlatilgan fayl yo'q.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'guard_utils.dart';

/// `flutter:` bo'limidagi `- assets/...` yo'llari va `asset:` qiymatlari.
({List<String> assets, List<String> fonts}) _pubspecPaths() {
  final text = File('pubspec.yaml').readAsStringSync();
  final assets = [
    for (final m in RegExp(
      r'^\s+- (assets/[^\s#]+)\s*$',
      multiLine: true,
    ).allMatches(text))
      m.group(1)!,
  ];
  final fonts = [
    for (final m in RegExp(
      r'^\s+- asset: (\S+)\s*$',
      multiLine: true,
    ).allMatches(text))
      m.group(1)!,
  ];
  return (assets: assets, fonts: fonts);
}

/// Ixtiyoriy asset'lar: kod ularning yo'qligiga bardoshli (halol “qo'shilmagan”
/// holati) — pubspec ro'yxatida ham, diskda ham bo'lishi shart emas.
const _optionalAssets = {'assets/curriculum/curriculum.json'};

void main() {
  test('pubspec: har bir asset yo‘li (papka yoki fayl) mavjud', () {
    final p = _pubspecPaths();
    expect(p.assets, isNotEmpty);
    final missing = [
      for (final a in p.assets)
        if (a.endsWith('/')
            ? !Directory(a).existsSync()
            : !File(a).existsSync())
          a,
    ];
    expect(missing, isEmpty, reason: 'yo‘q: $missing');
  });

  test('pubspec: har bir shrift fayli mavjud', () {
    final p = _pubspecPaths();
    expect(p.fonts, isNotEmpty);
    final missing = [
      for (final f in p.fonts)
        if (!File(f).existsSync()) f,
    ];
    expect(missing, isEmpty, reason: 'yo‘q: $missing');
  });

  test('pubspec: papka assetlari bo‘sh emas (kamida bitta fayl)', () {
    final p = _pubspecPaths();
    final empty = [
      for (final a in p.assets.where((a) => a.endsWith('/')))
        if (Directory(a).listSync().whereType<File>().isEmpty) a,
    ];
    expect(empty, isEmpty, reason: 'bo‘sh papka: $empty');
  });

  test('kodda keltirilgan `assets/...` fayllari mavjud', () {
    final ref = RegExp(r'''['"](assets/[A-Za-z0-9_\-./]+\.[a-z0-9]+)['"]''');
    final missing = <String>[];
    for (final f in filesUnder(
      'lib',
      where: (p) => p.endsWith('.dart') && !p.contains('/l10n/gen/'),
    )) {
      for (final m in ref.allMatches(f.readAsStringSync())) {
        final path = m.group(1)!;
        // `$id`, `${...}` bilan yig'iladigan yo'llar bu yerda uchramaydi.
        if (_optionalAssets.contains(path)) continue;
        if (!File(path).existsSync()) missing.add('$path (${f.path})');
      }
    }
    expect(missing, isEmpty, reason: missing.join('\n'));
  });

  test('logotip: kesilgan 1024 nusxa va manba bor, 1024×1024 PNG', () {
    for (final name in [
      'assets/brand/nurseguide_icon_1024_attached.png',
      'assets/brand/nurseguide_logo_1024.png',
    ]) {
      final bytes = File(name).readAsBytesSync();
      // PNG imzosi + IHDR (kenglik, balandlik).
      expect(bytes.sublist(0, 8), [137, 80, 78, 71, 13, 10, 26, 10]);
      final b = bytes.buffer.asByteData();
      expect(b.getUint32(16), 1024, reason: '$name eni');
      expect(b.getUint32(20), 1024, reason: '$name bo‘yi');
    }
  });
}
