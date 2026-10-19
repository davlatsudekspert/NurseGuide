import 'dart:convert';

import 'package:flutter/services.dart';

/// Darslik asosida tuzilgan qadam-baqadam muolaja (Manipulyatsiyalar).
/// Hammasi `assets/content/reference/procedures.json` dan; har bir muolajada
/// manba va PDF betlari ko'rsatiladi.
class ProcedureDef {
  const ProcedureDef({
    required this.id,
    required this.title,
    required this.group,
    required this.goal,
    required this.indications,
    required this.contraindications,
    required this.equipment,
    required this.steps,
    required this.checklist,
    required this.risks,
    required this.source,
    required this.pages,
  });

  factory ProcedureDef.fromJson(Map<String, Object?> j) {
    List<String> strings(Object? v) => [
      for (final e in (v as List? ?? const [])) e as String,
    ];
    return ProcedureDef(
      id: j['id']! as String,
      title: j['title']! as String,
      group: j['group']! as String,
      goal: j['goal'] as String? ?? '',
      indications: strings(j['indications']),
      contraindications: strings(j['contraindications']),
      equipment: strings(j['equipment']),
      steps: [
        for (final s in (j['steps']! as List)) (s as Map)['text']! as String,
      ],
      checklist: strings(j['checklist']),
      risks: strings(j['risks']),
      source: j['source']! as String,
      pages: [for (final p in (j['pages'] as List? ?? const [])) p as int],
    );
  }

  final String id;
  final String title;
  final String group;
  final String goal;
  final List<String> indications;
  final List<String> contraindications;
  final List<String> equipment;
  final List<String> steps;
  final List<String> checklist;
  final List<String> risks;
  final String source;
  final List<int> pages;
}

/// Darslikda aniq ta'rifi berilgan atama.
class GlossaryTerm {
  const GlossaryTerm({
    required this.term,
    required this.definition,
    required this.source,
    required this.page,
  });

  factory GlossaryTerm.fromJson(Map<String, Object?> j) => GlossaryTerm(
    term: j['term']! as String,
    definition: j['definition']! as String,
    source: j['source']! as String,
    page: j['page']! as int,
  );

  final String term;
  final String definition;
  final String source;
  final int page;
}

/// DMED tizimida ishlash bo'yicha bitta savol-javob kartasi.
class DmedCard {
  const DmedCard({
    required this.id,
    required this.group,
    required this.question,
    required this.answer,
    required this.source,
  });

  factory DmedCard.fromJson(Map<String, Object?> j) => DmedCard(
    id: j['id']! as String,
    group: j['group']! as String,
    question: j['q']! as String,
    answer: j['a']! as String,
    source: j['source']! as String,
  );

  final String id;

  /// [DmedGroup.id].
  final String group;
  final String question;
  final String answer;
  final String source;
}

class DmedGroup {
  const DmedGroup(this.id, this.title);

  final String id;
  final String title;
}

/// Adabiyotlar ro'yxatidagi bitta manba (kitob, rasmiy hujjat, ochiq manba).
/// [match] — savol/muolaja/atama `source` matnida uchraydigan satrlar:
/// shu orqali material manbaga avtomatik biriktiriladi.
class LiteratureEntry {
  const LiteratureEntry({
    required this.id,
    required this.group,
    required this.author,
    required this.year,
    required this.title,
    required this.publisher,
    required this.match,
    this.license,
    this.url,
    this.main = false,
  });

  factory LiteratureEntry.fromJson(Map<String, Object?> j) => LiteratureEntry(
    id: j['id']! as String,
    group: j['group']! as String,
    author: j['author'] as String? ?? '',
    year: j['year'] as int?,
    title: j['title']! as String,
    publisher: j['publisher'] as String? ?? '',
    match: [for (final m in (j['match']! as List)) m as String],
    license: j['license'] as String?,
    url: j['url'] as String?,
    main: j['role'] == 'main',
  );

  final String id;

  /// `textbooks` | `official` | `open` | `other`.
  final String group;
  final String author;
  final int? year;
  final String title;
  final String publisher;
  final List<String> match;
  final String? license;
  final String? url;
  final bool main;

  bool matches(String source) => match.any(source.contains);
}

/// Manbasi ko'rsatilgan test savoli (Adabiyotlar hisobi uchun).
class SourcedQuestion {
  const SourcedQuestion({
    required this.id,
    required this.text,
    required this.source,
    required this.topic,
  });

  final String id;
  final String text;
  final String source;

  /// Mavzu nomi (o'zbekcha).
  final String topic;
}

/// Bitta manbaga tayangan materiallar (avtomatik hisob).
class LiteratureUsage {
  LiteratureUsage(this.entry);

  final LiteratureEntry entry;
  final questions = <SourcedQuestion>[];
  final procedures = <ProcedureDef>[];
  final terms = <GlossaryTerm>[];
  final cards = <DmedCard>[];

  int get total =>
      questions.length + procedures.length + terms.length + cards.length;

  /// Savollar mavzulari (soni bo'yicha kamayish tartibida) + bo'limlar.
  List<String> topics(
    String proceduresLabel,
    String glossaryLabel, [
    String dmedLabel = 'DMED',
  ]) {
    final counts = <String, int>{};
    for (final q in questions) {
      counts[q.topic] = (counts[q.topic] ?? 0) + 1;
    }
    final sorted = counts.keys.toList()
      ..sort((a, b) => counts[b]!.compareTo(counts[a]!));
    return [
      ...sorted.take(4),
      if (procedures.isNotEmpty) proceduresLabel,
      if (terms.isNotEmpty) glossaryLabel,
      if (cards.isNotEmpty) dmedLabel,
    ];
  }
}

/// Ma'lumotnoma kontenti (muolajalar + lug'at + adabiyotlar). Bir marta
/// yuklanadi.
class ReferenceData {
  const ReferenceData({
    required this.procedures,
    required this.glossary,
    required this.literature,
    required this.questions,
    this.dmedGroups = const [],
    this.dmed = const [],
  });

  final List<DmedGroup> dmedGroups;
  final List<DmedCard> dmed;
  final List<ProcedureDef> procedures;
  final List<GlossaryTerm> glossary;
  final List<LiteratureEntry> literature;
  final List<SourcedQuestion> questions;

  /// Manba matniga mos birinchi adabiyot yozuvi (yo'q bo'lsa null).
  LiteratureEntry? entryFor(String source) {
    for (final e in literature) {
      if (e.matches(source)) return e;
    }
    return null;
  }

  /// Har bir manba uchun tayangan materiallar; faqat bo'sh bo'lmaganlar,
  /// ro'yxat tartibida.
  List<LiteratureUsage> usage() {
    final map = {for (final e in literature) e.id: LiteratureUsage(e)};
    for (final q in questions) {
      map[entryFor(q.source)?.id]?.questions.add(q);
    }
    for (final p in procedures) {
      map[entryFor(p.source)?.id]?.procedures.add(p);
    }
    for (final t in glossary) {
      map[entryFor(t.source)?.id]?.terms.add(t);
    }
    for (final c in dmed) {
      map[entryFor(c.source)?.id]?.cards.add(c);
    }
    return [
      for (final e in literature)
        if (map[e.id]!.total > 0) map[e.id]!,
    ];
  }

  ProcedureDef? procedure(String id) {
    for (final p in procedures) {
      if (p.id == id) return p;
    }
    return null;
  }

  static const _dir = 'assets/content/reference';
  static final Map<AssetBundle, Future<ReferenceData>> _cache = {};

  static Future<ReferenceData> load(AssetBundle bundle) =>
      _cache.putIfAbsent(bundle, () => _read(bundle));

  static Future<ReferenceData> _read(AssetBundle bundle) async {
    Future<Map<String, Object?>> json(String name) async =>
        (jsonDecode(await bundle.loadString('$_dir/$name')) as Map)
            .cast<String, Object?>();
    final p = await json('procedures.json');
    final g = await json('glossary.json');
    final l = await json('literature.json');
    final dm = await json('dmed.json');
    final t = (jsonDecode(
      await bundle.loadString('assets/toifa/tests.json'),
    ) as Map).cast<String, Object?>();
    final names = {
      for (final e in ((t['topic_names'] as Map?) ?? const {}).entries)
        e.key as String: ((e.value as Map)['uz'] as String?) ?? e.key as String,
    };
    return ReferenceData(
      dmedGroups: [
        for (final e in (dm['groups']! as List))
          DmedGroup((e as Map)['id']! as String, e['title']! as String),
      ],
      dmed: [
        for (final e in (dm['cards']! as List))
          DmedCard.fromJson((e as Map).cast<String, Object?>()),
      ],
      literature: [
        for (final e in (l['entries']! as List))
          LiteratureEntry.fromJson((e as Map).cast<String, Object?>()),
      ],
      questions: [
        for (final e in (t['questions']! as List))
          SourcedQuestion(
            id: (e as Map)['id']! as String,
            text: e['q']! as String,
            source: e['source'] as String? ?? '',
            topic: names[e['topic']] ?? e['topic']! as String,
          ),
      ],
      procedures: [
        for (final e in (p['procedures']! as List))
          ProcedureDef.fromJson((e as Map).cast<String, Object?>()),
      ],
      glossary: [
        for (final e in (g['terms']! as List))
          GlossaryTerm.fromJson((e as Map).cast<String, Object?>()),
      ],
    );
  }
}
