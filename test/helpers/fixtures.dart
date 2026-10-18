import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' show FlutterError;
import 'package:flutter/services.dart';

/// Test kontenti: ilovada hech qanday haqiqiy savol yo'q (placeholder), shuning
/// uchun oqimlarni sinash uchun kichik to'plam shu yerda yig'iladi. Matnlar
/// ataylab betaraf — hech qayerda ilova bilan birga yuborilmaydi.

Map<String, String> lt(String uz) => {'uz': uz, 'ru': 'RU $uz', 'en': 'EN $uz'};

/// Mashq savollari: 2 mavzu × 3 savol, 2 ta mavzusiz, 1 ta deck matnidan.
Map<String, Object?> fixturePack() {
  Map<String, Object?> q(
    String id,
    List<String> topics,
    int correct, {
    bool derived = false,
  }) => {
    'id': id,
    'prompt': lt('Savol $id'),
    'options': [
      for (var i = 0; i < 4; i++)
        {'text': lt('Variant $i ($id)'), 'explanation': lt('Izoh $i ($id)')},
    ],
    'correct_index': correct,
    'basis': lt('Asos $id'),
    'refs': [
      {'source_id': 'src-1', 'pages': '1'},
    ],
    'review_state': 'approved',
    'topic_ids': topics,
    if (derived) 'provenance': 'derived',
  };
  return {
    'pack_id': 'core',
    'schema_version': 1,
    'content_version': '0.0.0-test',
    'groups': [
      {'id': 'basics', 'names': lt('Asoslar')},
      {'id': 'safety', 'names': lt('Xavfsizlik')},
    ],
    'sources': [
      {
        'id': 'src-1',
        'kind': 'web',
        'title': 'Test manbasi',
        'publisher': 'Test',
        'url': 'https://example.org/source',
        'accessed': '2026-10-01',
        'reuse_rights': 'citation_only',
      },
    ],
    'quiz': [
      for (var i = 1; i <= 3; i++) q('b$i', ['basics'], i % 4),
      for (var i = 1; i <= 3; i++) q('s$i', ['safety'], (i + 1) % 4),
      q('g1', const [], 0),
      q('g2', const [], 1),
      q('dv1', ['basics'], 2, derived: true),
    ],
    'library': <Object?>[],
    'lessons': <Object?>[],
  };
}

/// Toifa banki (test): 2 mavzu × 6 savol; oral: har toifada 6 savol.
String fixtureToifaTests() {
  final qs = <Map<String, Object?>>[];
  var n = 0;
  for (final t in ['fundamentals', 'safety']) {
    for (var i = 1; i <= 6; i++) {
      n++;
      qs.add({
        'id': 't-$n',
        'n': n,
        'q': 'Test savoli $n',
        'options': ['A$n', 'B$n', 'C$n', 'D$n'],
        'key': [n % 4],
        'topic': t,
        'verdict': 'ok',
        'checked': '2026-10-01',
        'status': 'official',
        'source': 'Test ro‘yxati',
        'explanation': 'Izoh $n',
        'tr': {
          'ru': {
            'q': 'Вопрос $n',
            'options': ['А$n', 'Б$n', 'В$n', 'Г$n'],
          },
          'en': {
            'q': 'Question $n',
            'options': ['A$n', 'B$n', 'C$n', 'D$n'],
          },
        },
      });
    }
  }
  return jsonEncode({
    'version': 1,
    'topics': ['fundamentals', 'safety'],
    'topic_names': {
      'fundamentals': {'uz': 'Asoslar', 'ru': 'Основы', 'en': 'Fundamentals'},
      'safety': {'uz': 'Xavfsizlik', 'ru': 'Безопасность', 'en': 'Safety'},
    },
    'questions': qs,
  });
}

String fixtureToifaOral() {
  final qs = <Map<String, Object?>>[];
  for (var i = 1; i <= 12; i++) {
    qs.add({
      'id': 'o-$i',
      'q': 'Og‘zaki savol $i',
      'categories': i <= 6 ? ['3-2', '1'] : ['1', 'oliy'],
      'topic': i.isEven ? 'safety' : 'fundamentals',
      'status': 'verified',
      'source': 'Test manbasi',
      'plan': ['Reja $i-1', 'Reja $i-2'],
      'checked': '2026-10-01',
    });
  }
  // `oliy` toifasi uchun yetarli savol: 6 ta (7..12) + 6 ta ulashilgan.
  for (var i = 13; i <= 17; i++) {
    qs.add({
      'id': 'o-$i',
      'q': 'Og‘zaki savol $i',
      'categories': ['oliy', '3-2'],
      'topic': 'safety',
      'status': 'verified',
      'plan': ['Reja $i-1'],
    });
  }
  return jsonEncode({
    'version': 1,
    'audit_checked_at': '2026-10-01',
    'questions': qs,
    'tickets': [
      {
        'id': 'b-1',
        'n': 1,
        'categories': ['1'],
        'questions': ['o-1', 'o-2', 'o-3', 'o-4', 'o-5'],
      },
    ],
  });
}

/// Taqdimotlar katalogi: bitta kun decki (3 slayd, uz).
String fixtureCatalog() => jsonEncode({
  'schema': 2,
  'modules': [
    {
      'n': 1,
      'id': 'M1',
      'uz': 'Birinchi modul',
      'ru': 'Модуль',
      'en': 'Module',
    },
  ],
  'decks': [
    {
      'id': 'd001',
      'kind': 'day',
      'm': 1,
      'w': 1,
      'd': 1,
      'topics': ['t001-L'],
      't': {'uz': 'Birinchi mavzu', 'ru': 'Первая тема', 'en': 'First topic'},
      'n': {'uz': 3},
      'l': ['uz'],
      'st': {
        'uz': [
          ['Birinchi mavzu', 1, 1],
          ['Asosiy tushunchalar', 2, 1],
          ['Yakun', 3, 1],
        ],
      },
      'kw': 'birinchi mavzu | asosiy tushunchalar | yakun',
    },
  ],
});

String fixtureDeck() => jsonEncode({
  'schema': 1,
  'topics': ['t001-L'],
  'lang': 'uz',
  'status': 'sourced',
  'title': 'Birinchi mavzu',
  'slides': [
    {
      'title': 'Birinchi mavzu',
      'bullets': ['Kirish'],
    },
    {
      'title': 'Asosiy tushunchalar',
      'bullets': ['Birinchi band', 'Ikkinchi band'],
    },
    {
      'title': 'Yakun',
      'bullets': ['Xulosa'],
    },
  ],
});

String fixtureCurriculum() => jsonEncode({
  'program': {'name': 'Namuna dastur (test)'},
  'modules': [
    {
      'id': 'M1',
      'title': lt('Birinchi modul'),
      'topics': [
        {
          'id': 't001-L',
          'n': 1,
          'week': 1,
          'hours': 2,
          'type': 'lecture',
          'title': {'uz': 'Birinchi mavzu', 'en': 'First topic'},
          'links': {
            'quiz_topics': ['basics'],
            'protocols': ['d001'],
            'toifa_topic': 'fundamentals',
          },
          'goals': ['Maqsad'],
          'key_points': ['Asosiy fikr'],
          'oral_candidates': ['o-1', 'o-2'],
          'test_candidates': {
            'ids': [for (var i = 1; i <= 12; i++) 't-$i'],
            'pack_quiz_ids': ['b1', 'b2', 'b3', 's1', 's2', 's3'],
            'derived_quiz_ids': ['dv1'],
          },
        },
        {
          'id': 't001-P',
          'n': 1,
          'type': 'practical',
          'title': {'uz': 'Amaliyot'},
          'links': {
            'quiz_topics': ['safety'],
          },
        },
      ],
    },
  ],
});

/// Haqiqiy asset'lar ustidan test kontenti bilan qoplangan bundle. Paket
/// o'zgarganda manifest (size + sha256) qayta hisoblanadi.
class FixtureBundle extends CachingAssetBundle {
  FixtureBundle(
    this._inner, {
    Map<String, Object?>? pack,
    Map<String, String> overrides = const {},
  }) : _overrides = {
         'assets/toifa/tests.json': fixtureToifaTests(),
         'assets/toifa/oral.json': fixtureToifaOral(),
         'assets/lectures/index.json': '{"decks":[]}',
         'assets/lectures/index_v2.json': fixtureCatalog(),
         'assets/lectures/decks/d001.uz.json': fixtureDeck(),
         'assets/curriculum/curriculum.json': fixtureCurriculum(),
         ...overrides,
       },
       _pack = Uint8List.fromList(
         utf8.encode(jsonEncode(pack ?? fixturePack())),
       );

  final AssetBundle _inner;
  final Map<String, String> _overrides;
  final Uint8List _pack;

  @override
  Future<ByteData> load(String key) async {
    if (key == 'assets/content/core/pack.json') {
      return ByteData.sublistView(_pack);
    }
    if (key == 'assets/content/core/manifest.json') {
      return ByteData.sublistView(
        Uint8List.fromList(
          utf8.encode(
            jsonEncode({
              'pack_id': 'core',
              'version': '0.0.0-test',
              'min_schema': 1,
              'languages': ['uz', 'ru', 'en'],
              'licence': 'test',
              'files': [
                {
                  'path': 'pack.json',
                  'size': _pack.length,
                  'sha256': sha256.convert(_pack).toString(),
                },
              ],
            }),
          ),
        ),
      );
    }
    final o = _overrides[key];
    if (o != null) {
      return ByteData.sublistView(Uint8List.fromList(utf8.encode(o)));
    }
    if (key.startsWith('assets/lectures/') ||
        key.startsWith('assets/curriculum/') ||
        key.startsWith('assets/toifa/')) {
      throw FlutterError('Unable to load asset: "$key".');
    }
    return _inner.load(key);
  }
}

/// Hamma testlar uchun umumiy bundle (kesh umumiy bo'lsin).
final testBundle = FixtureBundle(rootBundle);
