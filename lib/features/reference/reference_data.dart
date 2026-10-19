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

/// Ma'lumotnoma kontenti (muolajalar + lug'at). Bir marta yuklanadi.
class ReferenceData {
  const ReferenceData({required this.procedures, required this.glossary});

  final List<ProcedureDef> procedures;
  final List<GlossaryTerm> glossary;

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
    return ReferenceData(
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
