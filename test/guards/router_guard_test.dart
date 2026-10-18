// Qorovul: router. Har bir marshrutning ekrani bor (builder/redirect) va har
// bir marshrutga ilovadan yo'l bor (kodda shu manzilga o'tadigan joy); har
// bir `*Screen` sinfi marshrutga yoki boshqa ekranga ulangan (yetim ekran yo'q).
import 'dart:io';

import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nurseguide/app/router.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import 'guard_utils.dart';

/// Kodda manzil bilan emas, tashqaridan (deep link, redirect) ochiladigan
/// marshrutlar — sababi bilan.
const _externalEntry = {
  '/welcome': 'onboarding: redirect (router.dart) shu yerga olib keladi',
  '/welcome/language': 'onboarding: birinchi ishga tushirishda redirect',
  '/home': 'pastki menyu tabi (tab ildizi)',
  '/procedures': 'pastki menyu tabi (tab ildizi)',
  '/workplace': 'pastki menyu tabi (tab ildizi)',
  '/library': 'pastki menyu tabi (tab ildizi)',
  '/learn': 'pastki menyu tabi (tab ildizi)',
};

class _R {
  _R(this.pattern, this.route);
  final String pattern;
  final GoRoute route;
}

void _collect(List<RouteBase> routes, String base, List<_R> out) {
  for (final r in routes) {
    if (r is GoRoute) {
      final p = r.path.startsWith('/')
          ? r.path
          : '${base == '/' ? '' : base}/${r.path}';
      out.add(_R(p, r));
      _collect(r.routes, p, out);
    } else if (r is StatefulShellRoute) {
      for (final b in r.branches) {
        _collect(b.routes, base, out);
      }
    } else {
      _collect(r.routes, base, out);
    }
  }
}

List<String> _segments(String p) => [
  for (final s in p.split('/'))
    if (s.isNotEmpty) s,
];

bool _isParam(String s) => s.startsWith(':') || s == '~';

bool _matches(List<String> a, List<String> b) {
  if (b.isNotEmpty && b.first.startsWith('tail:')) {
    final tail = [
      b.first.substring(5),
      ...b.skip(1),
    ].where((x) => x.isNotEmpty).toList();
    if (tail.length >= a.length) return false;
    return _matches(a.sublist(a.length - tail.length), tail);
  }
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i] && !_isParam(a[i]) && !_isParam(b[i])) return false;
  }
  return true;
}

/// Kodda uchraydigan yo'l o'xshash satrlar (o'zgaruvchilar `$#` bilan
/// almashtirilgan; ma'lum `const x = '/...'` qiymatlari ochilgan).
Set<String> _navigationLiterals() {
  final files = [
    for (final f in filesUnder(
      'lib',
      where: (p) =>
          p.endsWith('.dart') &&
          !p.contains('/l10n/gen/') &&
          !p.endsWith('app/router.dart'),
    ))
      f.readAsStringSync(),
  ];
  final consts = <String, String>{};
  final constRe = RegExp(r'''const\s+(\w+)\s*=\s*['"](/[^'"]*)['"]''');
  for (final t in files) {
    for (final m in constRe.allMatches(t)) {
      consts[m.group(1)!] = m.group(2)!;
    }
  }
  final out = <String>{};
  final litRe = RegExp(r'''['"]((?:\$\{?\w+\}?|/)[^'"\s]*)['"]''');
  for (final t in files) {
    for (final m in litRe.allMatches(t)) {
      var s = m.group(1)!;
      s = s.replaceAllMapped(RegExp(r'\$\{(\w+)\}|\$(\w+)'), (x) {
        final name = x.group(1) ?? x.group(2)!;
        return consts[name] ?? '~';
      });
      // Murakkab ifodali ${...} qolgan bo'lsa ham bitta segment sifatida.
      s = s.replaceAll(RegExp(r'\$\{[^}]*\}'), '~');
      s = s.split('?').first.split('#').first;
      // O'zgaruvchi bilan boshlansa (`$base/plan`) — faqat dum segmentlari
      // taqqoslanadi (`tail:` belgisi).
      if (s.startsWith('~/') &&
          s.length > 2 &&
          !s.substring(2).startsWith('~')) {
        out.add('tail:${s.substring(2)}');
      } else if (s.startsWith('/') && s.length > 1) {
        out.add(s);
      }
    }
  }
  return out;
}

void main() {
  late List<_R> routes;

  setUpAll(() {
    final settings = SettingsController(
      MemoryKeyValueStore(),
      systemLocales: const [],
    );
    final router = buildRouter(settings, refresh: ValueNotifier(0));
    routes = [];
    _collect(router.configuration.routes, '', routes);
  });

  test('marshrutlar yig‘ildi (bo‘sh emas, takror yo‘l yo‘q)', () {
    expect(routes.length, greaterThan(40));
    final seen = <String>{};
    final dup = [
      for (final r in routes)
        if (!seen.add(r.pattern)) r.pattern,
    ];
    expect(dup, isEmpty);
  });

  test('har bir marshrutning ekrani bor (builder yoki redirect)', () {
    final bad = [
      for (final r in routes)
        if (r.route.builder == null &&
            r.route.pageBuilder == null &&
            r.route.redirect == null)
          r.pattern,
    ];
    expect(bad, isEmpty);
  });

  test('har bir marshrutga ilovadan yo‘l bor', () {
    final lits = [
      for (final l in _navigationLiterals())
        l.startsWith('tail:')
            ? [
                'tail:${_segments(l.substring(5)).first}',
                ..._segments(l.substring(5)).skip(1),
              ]
            : _segments(l),
    ];
    final orphan = [
      for (final r in routes)
        if (!_externalEntry.containsKey(r.pattern) &&
            !lits.any((l) => _matches(_segments(r.pattern), l)))
          r.pattern,
    ];
    expect(
      orphan,
      isEmpty,
      reason: 'ulanmagan marshrutlar:\n${orphan.join('\n')}',
    );
  });

  test('istisno ro‘yxati dolzarb (har biri haqiqiy marshrut)', () {
    final patterns = {for (final r in routes) r.pattern};
    for (final e in _externalEntry.keys) {
      expect(patterns, contains(e), reason: e);
    }
  });

  test('onboarding va 5 tab marshrutlari bor', () {
    final patterns = {for (final r in routes) r.pattern};
    expect(
      patterns,
      containsAll([
        '/welcome',
        '/welcome/language',
        '/welcome/auth',
        '/welcome/auth/otp',
        '/welcome/role',
        '/home',
        '/procedures',
        '/workplace',
        '/library',
        '/learn',
        '/profile',
      ]),
    );
  });

  test('har bir *Screen sinfi marshrutga yoki boshqa ekranga ulangan', () {
    final sources = {
      for (final f in filesUnder(
        'lib',
        where: (p) => p.endsWith('.dart') && !p.contains('/l10n/gen/'),
      ))
        f.path: f.readAsStringSync(),
    };
    final decl = RegExp(r'^class (\w+Screen) extends ', multiLine: true);
    final unused = <String>[];
    for (final e in sources.entries) {
      for (final m in decl.allMatches(e.value)) {
        final name = m.group(1)!;
        final call = RegExp('\\b$name\\(');
        var calls = 0;
        for (final s in sources.values) {
          calls += call.allMatches(s).length;
        }
        // Birinchisi — o'z konstruktori e'loni.
        if (calls <= 1) unused.add('$name (${e.key})');
      }
    }
    expect(unused, isEmpty, reason: 'yetim ekranlar:\n${unused.join('\n')}');
  });

  test('router.dart: har bir import qilingan ekran fayli ishlatiladi', () {
    final src = File('lib/app/router.dart').readAsStringSync();
    for (final m in RegExp(
      r"^import '([^']+)';",
      multiLine: true,
    ).allMatches(src)) {
      final path = m.group(1)!;
      if (path.startsWith('package:')) continue;
      final file = File('lib/app/$path');
      expect(file.existsSync(), isTrue, reason: path);
    }
  });
}
