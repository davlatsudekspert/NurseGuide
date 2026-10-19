// To'liq audit aylanishi (faqat NG_AUDIT=1 da): barcha ekranlar × 3 til ×
// yorug'/qorong'i × iPhone 390×844 / Android 360×640 (shrift 1.3x).
// Aniqlaydi: istisno (overflow), "0 ta", va'da-so'z, xom kalit, kirill/o'zbekcha
// aralashma. Natija: $NG_AUDIT_DIR/sweep_*.json (+ asosiy konfiguratsiya rasmlari).
//   NG_AUDIT=1 NG_AUDIT_DIR=/tmp/x flutter test test/audit/audit_sweep_test.dart
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/reference/reference_data.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final _on = Platform.environment['NG_AUDIT'] == '1';
final _dir = Platform.environment['NG_AUDIT_DIR'] ?? '/tmp/ng_audit';

final _zero = RegExp(r'(^|[^\d.,])0 ta(?![a-zA-Z‘’\x27])');
final _promise = RegExp(
  r'keyingi\s+(yangilanish|versiya)|tez\s+(orada|kunda)|coming\s+soon|'
  r'(next|later)\s+(update|version)|tayyorlanmoqda|в\s+следующ\S*\s+(обновлени|верси)|'
  r'(?<![\p{L}])скоро(?![\p{L}])',
  caseSensitive: false,
  unicode: true,
);
final _rawKey = RegExp(r'^[a-z]+(?:[A-Z][a-z0-9]+)+$');
final _cyr = RegExp('[Ѐ-ӿ]');
final _uzMarkers = RegExp(
  r"(o‘|g‘|oʻ|gʻ|o'|g')|\b(uchun|qanday|bo[‘']lim|bilan|savol(lar)?|ning|dagi|yo[‘']q)\b",
  caseSensitive: false,
);

const _base = <String>[
  '/home',
  '/procedures',
  '/workplace',
  '/library',
  '/library/saved',
  '/library/books',
  '/library/sources',
  '/library/glossary',
  '/library/dmed',
  '/library/literature',
  '/learn',
  '/learn/quiz',
  '/learn/daily',
  '/learn/exam',
  '/learn/toifa',
  '/learn/toifa/test',
  '/learn/toifa/practice',
  '/learn/toifa/practice/general',
  '/learn/toifa/oral',
  '/learn/toifa/mistakes',
  '/learn/toifa/progress',
  '/learn/classes',
  '/learn/classes/new',
  '/learn/classes/join',
  '/profile',
  '/profile/role',
  '/profile/theme',
  '/profile/privacy',
  '/profile/help',
  '/profile/contact',
  '/profile/support',
  '/profile/support/new',
  '/terms',
];

/// Rasm olinadigan asosiy ekranlar (boshqa konfiguratsiyalarda).
const _key = <String>[
  '/home',
  '/procedures',
  '/workplace',
  '/library',
  '/learn',
  '/learn/toifa',
  '/learn/toifa/test',
  '/profile',
];

class _Cfg {
  const _Cfg(this.name, this.lang, this.dark, this.size, this.scale);
  final String name;
  final AppLanguage lang;
  final bool dark;
  final Size size;
  final double scale;
}

const _iphone = Size(390, 844);
const _android = Size(360, 640);

final _cfgs = <_Cfg>[
  for (final l in AppLanguage.values)
    for (final dark in [false, true])
      for (final (dn, size, scale) in [
        ('iphone', _iphone, 1.0),
        ('android', _android, 1.3),
      ])
        _Cfg('${l.name}_${dark ? 'dark' : 'light'}_$dn', l, dark, size, scale),
];

void main() {
  setUpAll(loadAppFonts);
  Directory(_dir).createSync(recursive: true);

  for (final c in _cfgs) {
    testWidgets('audit ${c.name}', (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        language: c.lang,
        themeMode: c.dark ? ThemeMode.dark : ThemeMode.light,
      );
      await pumpApp(
        tester,
        s,
        size: c.size,
        textScale: c.scale,
        platformBrightness: c.dark ? Brightness.dark : Brightness.light,
      );
      final ref = await tester.runAsync(
        () => ReferenceData.load(s.curriculum.bundle ?? rootBundle),
      );
      final oral = s.toifa.bank?.oral.take(3).map((q) => q.id).toList() ?? [];
      final routes = [
        ..._base,
        for (final p in ref!.procedures) '/procedures/${p.id}',
        for (final u in ref.usage()) '/library/literature/${u.entry.id}',
        for (final id in oral) '/learn/toifa/oral/q/$id',
      ];
      final shoot = c.name == 'uz_light_iphone';
      final findings = <Map<String, Object?>>[];
      for (final route in routes) {
        await goTo(tester, route);
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 40)),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 200));
        final e = tester.takeException();
        void add(String kind, String detail) =>
            findings.add({'route': route, 'kind': kind, 'detail': detail});
        if (e != null) add('exception', e.toString().split('\n').first);
        final texts = <String>{
          for (final w in tester.widgetList<Text>(find.byType(Text)))
            (w.data ?? w.textSpan?.toPlainText() ?? '').trim(),
        }..removeWhere((t) => t.isEmpty);
        var uzCount = 0;
        for (final t in texts) {
          if (_zero.hasMatch(t)) add('zero-count', t);
          if (_promise.hasMatch(t)) add('promise', t);
          if (_rawKey.hasMatch(t)) add('raw-key', t);
          if (c.lang != AppLanguage.ru && _cyr.hasMatch(t)) add('cyrillic', t);
          if (c.lang == AppLanguage.uz && _cyr.hasMatch(t)) add('cyrillic', t);
          if (c.lang != AppLanguage.uz && _uzMarkers.hasMatch(t)) uzCount++;
        }
        if (uzCount > 0) {
          add(
            'uzbek-in-${c.lang.name}',
            '$uzCount ta matn: ${texts.where(_uzMarkers.hasMatch).take(4).join(' | ')}',
          );
        }
        if (shoot || _key.contains(route)) {
          final fname =
              '${c.name}__${route.replaceAll(RegExp('[^a-zA-Z0-9]+'), '_')}.png';
          await tester.runAsync(() async {
            final view = tester.binding.renderViews.first;
            final layer = view.debugLayer! as OffsetLayer;
            final img = await layer.toImage(
              Offset.zero & view.size,
              pixelRatio: 1.5,
            );
            final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
            File('$_dir/$fname').writeAsBytesSync(bytes!.buffer.asUint8List());
          });
        }
      }
      File(
        '$_dir/sweep_${c.name}.json',
      ).writeAsStringSync(const JsonEncoder.withIndent(' ').convert(findings));
    }, skip: !_on);
  }
}
