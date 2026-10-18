import 'package:flutter/foundation.dart';

/// Kontent sxemasi versiyasi. Paket `min_schema` dan katta bo'lsa rad
/// etiladi (eski ilova yangi formatni noto'g'ri o'qimasligi uchun).
const int kSupportedContentSchema = 1;

/// Uch tildagi matn. Tarjima yo'q bo'lsa inglizchaga, keyin istalgan
/// mavjud tilga qaytadi — bo'sh joy ko'rsatilmaydi.
@immutable
class LocalizedText {
  const LocalizedText(this.values);

  /// Paketdagi har bir matn uch tilda bo'lishi shart: bo'sh yoki yo'q til
  /// foydalanuvchiga bo'sh joy bo'lib ko'rinardi.
  factory LocalizedText.fromJson(Object? json) {
    if (json is! Map) throw const FormatException('localized text expected');
    final values = <String, String>{};
    for (final e in json.entries) {
      final v = e.value;
      if (e.key is! String || v is! String) {
        throw const FormatException('localized text: string values expected');
      }
      values[e.key as String] = v;
    }
    for (final lang in requiredLanguages) {
      if ((values[lang] ?? '').trim().isEmpty) {
        throw FormatException('localized text without "$lang": $values');
      }
    }
    return LocalizedText(values);
  }

  static const requiredLanguages = ['uz', 'ru', 'en'];

  final Map<String, String> values;

  /// So'ralgan til, bo'lmasa (yoki bo'sh bo'lsa) inglizcha, keyin istalgani.
  String of(String lang) {
    String? usable(String? v) => v == null || v.trim().isEmpty ? null : v;
    return usable(values[lang]) ??
        usable(values['en']) ??
        values.values.map(usable).nonNulls.firstOrNull ??
        '';
  }

  Iterable<String> get all => values.values;
}

/// Karta mazmuni qay darajada tayyor.
enum ContentState {
  /// Faqat nom/guruh/tuzilma. Klinik matn yo'q.
  structureOnly,

  /// Manbaga bog'langan o'quv namunasi; mustaqil tekshiruvdan o'tmagan.
  sourcedSample,

  /// Tekshirilgan va nashrga tayyor.
  reviewed;

  static ContentState parse(String raw) => switch (raw) {
    'structure_only' => structureOnly,
    'sourced_sample' => sourcedSample,
    'reviewed' => reviewed,
    _ => throw FormatException('unknown content_state: $raw'),
  };
}

enum ReviewState {
  pending,
  approved,
  rejected;

  static ReviewState parse(String raw) => ReviewState.values.firstWhere(
    (s) => s.name == raw,
    orElse: () => throw FormatException('unknown review state: $raw'),
  );
}

@immutable
class ContentSource {
  const ContentSource({
    required this.id,
    required this.kind,
    required this.title,
    required this.publisher,
    required this.reuseRights,
    this.url,
    this.accessed,
    this.libraryItemId,
    this.sourceDate,
    this.jurisdiction,
    this.note,
  });

  factory ContentSource.fromJson(Map<String, Object?> json) {
    final source = ContentSource(
      id: json['id']! as String,
      kind: json['kind'] as String? ?? 'web',
      title: json['title']! as String,
      publisher: json['publisher']! as String,
      url: json['url'] as String?,
      accessed: json['accessed'] as String?,
      libraryItemId: json['library_item_id'] as String?,
      reuseRights: json['reuse_rights']! as String,
      sourceDate: json['source_date'] as String?,
      jurisdiction: json['jurisdiction'] as String?,
      note: json['note'] as String?,
    );
    if (source.kind == 'web' &&
        (source.url == null || source.accessed == null)) {
      throw FormatException('${source.id}: web source needs url and accessed');
    }
    // Faqat iqtibos qilinadigan kitob (mualliflik huquqi amal qiladi):
    // kutubxonaga qo'yilmaydi, shuning uchun kutubxona elementi shart emas,
    // lekin bibliografiya (sarlavha, nashriyot) va izoh majburiy.
    if (source.isCitationOnlyBook) {
      if ((source.note ?? '').trim().isEmpty || source.url != null) {
        throw FormatException('${source.id}: citation-only book needs note');
      }
      return source;
    }
    if (source.kind != 'web' && source.libraryItemId == null) {
      throw FormatException('${source.id}: ${source.kind} needs library item');
    }
    return source;
  }

  /// Kitob faqat manba sifatida keltiriladi (matn/rasm ko'chirilmaydi).
  bool get isCitationOnlyBook =>
      kind == 'book' && reuseRights == 'citation_only' && libraryItemId == null;

  final String id;

  /// `web` yoki kutubxona elementi turi (`book`, `manual`, `method`...).
  final String kind;
  final String title;
  final String publisher;

  /// Veb-manbalar uchun majburiy.
  final String? url;

  /// Veb-manba ko'rilgan sana, ISO (YYYY-MM-DD).
  final String? accessed;

  /// Kitob/qo'llanma bo'lsa — [LibraryItem.id].
  final String? libraryItemId;
  final String reuseRights;

  /// Manba sahifasining o'z sanasi (yangilangan/ko'rib chiqilgan).
  final String? sourceDate;

  /// Qaysi mamlakat/tizim tavsiyasi (masalan, US).
  final String? jurisdiction;
  final String? note;
}

/// Manbaga aniq havola: qaysi manba, qaysi sahifa(lar), qaysi bo'lim.
///
/// JSON da ikki ko'rinishda yoziladi:
/// * `"refs": [{"source_id": "...", "pages": "45–47", "locator": "..."}]`
///   — kitob va qo'llanmalar uchun (sahifa raqami bilan);
/// * eski qisqa shakl: `"source_ids": [...]` + ixtiyoriy `"locator"`.
@immutable
class SourceRef {
  const SourceRef(this.sourceId, {this.pages, this.locator});

  factory SourceRef.fromJson(Map<String, Object?> json) => SourceRef(
    json['source_id']! as String,
    pages: json['pages'] as String?,
    locator: json['locator'] as String?,
  );

  final String sourceId;

  /// Kitob/qo'llanmadagi sahifa yoki oraliq ("45", "45–47").
  final String? pages;

  /// Bo'lim nomi yoki veb-sahifadagi sarlavha.
  final String? locator;

  static List<SourceRef> listFromJson(Map<String, Object?> json) {
    final refs = json['refs'];
    if (refs is List) {
      return [
        for (final r in refs)
          SourceRef.fromJson((r as Map).cast<String, Object?>()),
      ];
    }
    final ids = _strings(json['source_ids'], 'source_ids');
    return [
      for (final id in ids)
        SourceRef(
          id,
          pages: json['pages'] as String?,
          locator: json['locator'] as String?,
        ),
    ];
  }
}

@immutable
class QuizTopic {
  const QuizTopic({required this.id, required this.names});

  factory QuizTopic.fromJson(Map<String, Object?> json) => QuizTopic(
    id: json['id']! as String,
    names: LocalizedText.fromJson(json['names']),
  );

  final String id;
  final LocalizedText names;
}

@immutable
class QuizOption {
  const QuizOption({required this.text, required this.explanation});

  factory QuizOption.fromJson(Map<String, Object?> json) => QuizOption(
    text: LocalizedText.fromJson(json['text']),
    explanation: LocalizedText.fromJson(json['explanation']),
  );

  final LocalizedText text;

  /// Nega bu javob to'g'ri yoki noto'g'ri — har bir variant uchun.
  final LocalizedText explanation;
}

@immutable
class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.basis,
    required this.refs,
    required this.reviewState,
    this.topicIds = const [],
    this.provenance,
  });

  factory QuizQuestion.fromJson(Map<String, Object?> json) {
    final options = [
      for (final o in json['options']! as List)
        QuizOption.fromJson((o as Map).cast<String, Object?>()),
    ];
    final correct = json['correct_index']! as int;
    if (correct < 0 || correct >= options.length) {
      throw FormatException('correct_index out of range in ${json['id']}');
    }
    return QuizQuestion(
      id: json['id']! as String,
      prompt: LocalizedText.fromJson(json['prompt']),
      options: options,
      correctIndex: correct,
      basis: LocalizedText.fromJson(json['basis']),
      refs: SourceRef.listFromJson(json),
      reviewState: ReviewState.parse(json['review_state'] as String),
      topicIds: _strings(json['topic_ids'], 'topic_ids'),
      provenance: json['provenance'] as String?,
    );
  }

  final String id;
  final LocalizedText prompt;
  final List<QuizOption> options;
  final int correctIndex;

  /// Javob nimaga asoslangani (manba yoki ta'rifdan keltirib chiqarish).
  final LocalizedText basis;

  /// Manba va sahifa. Tasdiqlangan savolda kamida bittasi bo'lishi shart.
  final List<SourceRef> refs;

  /// Tasdiqlanmagan savol — «tekshirilmoqda» deb belgilanadi.
  final ReviewState reviewState;

  /// Bog'liq dars mavzulari.
  final List<String> topicIds;

  /// Kelib chiqishi: `derived` — deck slaydidagi manbali gapdan olingan
  /// mavzu testi savoli (faqat curriculum `derived_quiz_ids` orqali
  /// ishlatiladi, umumiy mashq ro'yxatlariga kirmaydi).
  final String? provenance;

  List<String> get sourceIds => [for (final r in refs) r.sourceId];

  bool get isUnverified => reviewState != ReviewState.approved;

  bool get isDerived => provenance == 'derived';
}

/// Kutubxona elementi turkumlari (domla materiallarini saralash uchun).
enum LibraryCategory {
  fundamentals('fundamentals'),
  clinicalNursing('clinical_nursing'),
  procedures('procedures'),
  pharmacology('pharmacology'),
  exams('exams');

  const LibraryCategory(this.key);
  final String key;

  static LibraryCategory parse(String raw) => values.firstWhere(
    (c) => c.key == raw,
    orElse: () => throw FormatException('unknown category: $raw'),
  );
}

enum LibraryItemKind {
  book,
  manual,
  method,
  guideline,
  article,
  questionSet,
  website;

  static LibraryItemKind parse(String raw) => switch (raw) {
    'book' => book,
    'manual' => manual,
    'method' => method,
    'guideline' => guideline,
    'article' => article,
    'question_set' => questionSet,
    'website' => website,
    _ => throw FormatException('unknown library kind: $raw'),
  };
}

/// Material qaysi bosqichda. Fayl kelmaguncha `notReceived`: bunday
/// elementdan iqtibos keltirib bo'lmaydi.
enum ImportState {
  notReceived('not_received'),
  received('received'),
  cataloged('cataloged'),
  linked('linked'),
  reviewed('reviewed');

  const ImportState(this.key);
  final String key;

  /// Ichidagi ma'lumotga manba sifatida tayanish mumkinmi.
  bool get citable => index >= ImportState.cataloged.index;

  static ImportState parse(String raw) => values.firstWhere(
    (s) => s.key == raw,
    orElse: () => throw FormatException('unknown import_state: $raw'),
  );
}

enum DistributionRights {
  unknown('unknown'),
  personalOnly('personal_only'),
  permitted('permitted'),
  denied('denied');

  const DistributionRights(this.key);
  final String key;

  static DistributionRights parse(String raw) => values.firstWhere(
    (r) => r.key == raw,
    orElse: () => throw FormatException('unknown distribution: $raw'),
  );
}

/// Material qanday olinadi (katalogda ko'rsatiladi).
enum LibraryAccess {
  /// Ochiq litsenziya (CC BY, CC BY-SA, CC BY-NC, jamoat mulki) — havola
  /// orqali; to'liq matn paketi baribir alohida qayd talab qiladi.
  openLicence('open_licence'),

  /// Onlayn bepul o'qiladi, lekin ochiq litsenziya yo'q — faqat havola.
  freeToRead('free_to_read'),

  /// Erkin onlayn emas (bosma/pullik) — faqat bibliografik yozuv.
  catalogOnly('catalog_only');

  const LibraryAccess(this.key);
  final String key;

  static LibraryAccess parse(String raw) => values.firstWhere(
    (a) => a.key == raw,
    orElse: () => throw FormatException('unknown access: $raw'),
  );
}

/// Tarqatish huquqi qaydi: kim, qachon, qanday dalil bilan.
@immutable
class RightsRecord {
  const RightsRecord({
    required this.distribution,
    this.recordedAt,
    this.recordedBy,
    this.evidence,
    this.note,
  });

  factory RightsRecord.fromJson(Map<String, Object?>? json) => RightsRecord(
    distribution: DistributionRights.parse(
      json?['distribution'] as String? ?? 'unknown',
    ),
    recordedAt: json?['recorded_at'] as String?,
    recordedBy: json?['recorded_by'] as String?,
    evidence: json?['evidence'] as String?,
    note: json?['note'] as String?,
  );

  final DistributionRights distribution;
  final String? recordedAt;
  final String? recordedBy;

  /// Masalan, nashriyot xati yoki litsenziya havolasi.
  final String? evidence;
  final String? note;

  /// Umumiy kutubxonaga (hammaga yuklanadigan paket yoki ilova ichidagi
  /// fayl) qo'yish mumkinmi: to'liq qayd — ruxsat, sana, kim qayd etgani va
  /// dalil.
  bool get allowsSharedPack =>
      distribution == DistributionRights.permitted &&
      recordedAt != null &&
      recordedBy != null &&
      evidence != null;
}

/// Ilova bilan birga keladigan fayl (masalan, to'liq kitob PDF). Ochishdan
/// oldin hajmi va sha256 tekshiriladi.
@immutable
class LibraryFileRef {
  const LibraryFileRef({
    required this.path,
    required this.size,
    required this.sha256,
    this.format = 'pdf',
    this.pages,
  });

  factory LibraryFileRef.fromJson(Map<String, Object?> json) => LibraryFileRef(
    path: json['path']! as String,
    size: json['size']! as int,
    sha256: json['sha256']! as String,
    format: json['format'] as String? ?? 'pdf',
    pages: json['pages'] as int?,
  );

  /// Asset kaliti, masalan `assets/books/<id>.pdf`.
  final String path;
  final int size;
  final String sha256;

  /// Hozircha faqat `pdf`.
  final String format;

  /// Sahifalar soni (ma'lum bo'lsa — katalogda ko'rsatish uchun).
  final int? pages;
}

/// Alohida yuklanadigan oflayn paket (masalan, to'liq kitob).
@immutable
class FilePackRef {
  const FilePackRef({
    required this.packId,
    required this.version,
    required this.size,
    required this.sha256,
  });

  factory FilePackRef.fromJson(Map<String, Object?> json) => FilePackRef(
    packId: json['pack_id']! as String,
    version: json['version']! as String,
    size: json['size']! as int,
    sha256: json['sha256']! as String,
  );

  final String packId;
  final String version;
  final int size;
  final String sha256;
}

/// Kitob, qo'llanma, metodika, klinik tavsiya yoki test to'plami katalogi yozuvi.
@immutable
class LibraryItem {
  const LibraryItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.authors,
    required this.language,
    required this.categories,
    required this.topics,
    required this.importState,
    required this.rights,
    this.year,
    this.edition,
    this.publisher,
    this.isbn,
    this.providedBy,
    this.receivedAt,
    this.supersedes,
    this.filePack,
    this.file,
    this.url,
    this.licence,
    this.access = LibraryAccess.catalogOnly,
    this.accessed,
    this.note,
  });

  factory LibraryItem.fromJson(Map<String, Object?> json) => LibraryItem(
    id: json['id']! as String,
    kind: LibraryItemKind.parse(json['kind']! as String),
    title: json['title']! as String,
    authors: _strings(json['authors'], 'authors'),
    year: json['year'] as int?,
    edition: json['edition'] as String?,
    publisher: json['publisher'] as String?,
    isbn: json['isbn'] as String?,
    language: json['language']! as String,
    categories: [
      for (final c in json['categories']! as List)
        LibraryCategory.parse(c as String),
    ],
    topics: _strings(json['topics'], 'topics'),
    providedBy: json['provided_by'] as String?,
    receivedAt: json['received_at'] as String?,
    importState: ImportState.parse(json['import_state']! as String),
    rights: RightsRecord.fromJson(
      (json['rights'] as Map?)?.cast<String, Object?>(),
    ),
    supersedes: json['supersedes'] as String?,
    filePack: json['file_pack'] == null
        ? null
        : FilePackRef.fromJson(
            (json['file_pack']! as Map).cast<String, Object?>(),
          ),
    file: json['file'] == null
        ? null
        : LibraryFileRef.fromJson(
            (json['file']! as Map).cast<String, Object?>(),
          ),
    url: json['url'] as String?,
    licence: json['licence'] as String?,
    access: LibraryAccess.parse(json['access'] as String? ?? 'catalog_only'),
    accessed: json['accessed'] as String?,
    note: json['note'] == null ? null : LocalizedText.fromJson(json['note']),
  );

  final String id;
  final LibraryItemKind kind;
  final String title;
  final List<String> authors;
  final int? year;
  final String? edition;
  final String? publisher;
  final String? isbn;

  /// Asl til kodi (uz, ru, en...).
  final String language;
  final List<LibraryCategory> categories;

  /// Guruh yoki dars mavzusi id lari.
  final List<String> topics;

  /// Masalan, `teacher` (domla), `user`, `publisher`.
  final String? providedBy;
  final String? receivedAt;
  final ImportState importState;
  final RightsRecord rights;

  /// Shu materialning eski nashri (yangi/eski farqlarini kuzatish uchun).
  final String? supersedes;

  /// To'liq matn alohida oflayn paket sifatida (faqat ruxsat qayd etilgan
  /// bo'lsa).
  final FilePackRef? filePack;

  /// Ilova ichidagi fayl (ilova bilan birga keladi, o'quvchida ochiladi).
  /// Faqat to'liq tarqatish huquqi qayd etilgan bo'lsa.
  final LibraryFileRef? file;

  /// Rasmiy sahifa (o'qish yoki yozuvni ko'rish uchun).
  final String? url;

  /// Sahifada ko'rsatilgan litsenziya nomi (masalan, “CC BY 4.0”).
  final String? licence;
  final LibraryAccess access;

  /// Sahifa va litsenziya tekshirilgan sana.
  final String? accessed;

  /// Nega foydali — qisqa izoh (3 tilda).
  final LocalizedText? note;
}

/// Dars mavzusi: savollar va manbalarni bog'laydi.
@immutable
class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.quizIds,
    required this.refs,
    required this.reviewState,
    this.groupId,
  });

  factory Lesson.fromJson(Map<String, Object?> json) => Lesson(
    id: json['id']! as String,
    title: LocalizedText.fromJson(json['title']),
    groupId: json['group'] as String?,
    quizIds: _strings(json['quiz_ids'], 'quiz_ids'),
    refs: SourceRef.listFromJson(json),
    reviewState: ReviewState.parse(
      json['review_state'] as String? ?? 'pending',
    ),
  );

  final String id;
  final LocalizedText title;
  final String? groupId;
  final List<String> quizIds;
  final List<SourceRef> refs;
  final ReviewState reviewState;
}

@immutable
class ContentPack {
  const ContentPack({
    required this.packId,
    required this.schemaVersion,
    required this.contentVersion,
    required this.groups,
    required this.sources,
    required this.quiz,
    this.library = const [],
    this.lessons = const [],
  });

  factory ContentPack.fromJson(Map<String, Object?> json) {
    final pack = ContentPack(
      packId: json['pack_id']! as String,
      schemaVersion: json['schema_version']! as int,
      contentVersion: json['content_version']! as String,
      groups: [
        for (final g in json['groups'] as List? ?? const [])
          QuizTopic.fromJson((g as Map).cast<String, Object?>()),
      ],
      sources: [
        for (final s in json['sources'] as List? ?? const [])
          ContentSource.fromJson((s as Map).cast<String, Object?>()),
      ],
      quiz: [
        for (final q in json['quiz'] as List? ?? const [])
          QuizQuestion.fromJson((q as Map).cast<String, Object?>()),
      ],
      library: [
        for (final i in json['library'] as List? ?? const [])
          LibraryItem.fromJson((i as Map).cast<String, Object?>()),
      ],
      lessons: [
        for (final i in json['lessons'] as List? ?? const [])
          Lesson.fromJson((i as Map).cast<String, Object?>()),
      ],
    );
    pack._validateReferences();
    return pack;
  }

  final String packId;
  final int schemaVersion;
  final String contentVersion;

  /// Mashq mavzulari (bo'limlar).
  final List<QuizTopic> groups;
  final List<ContentSource> sources;
  final List<QuizQuestion> quiz;

  /// Kitoblar, qo'llanmalar, metodikalar katalogi.
  final List<LibraryItem> library;

  /// Dars mavzulari (savol va manbalarni bog'laydi).
  final List<Lesson> lessons;

  LibraryItem? libraryItem(String id) =>
      library.where((i) => i.id == id).firstOrNull;

  ContentSource? source(String id) =>
      sources.where((s) => s.id == id).firstOrNull;

  QuizTopic? group(String id) => groups.where((g) => g.id == id).firstOrNull;

  /// Kontent yaxlitligi: har bir havola mavjud manbaga, har bir savol
  /// mavjud mavzuga bog'langan; id lar takrorlanmaydi.
  void _validateReferences() {
    Set<String> unique(Iterable<String> ids, String what) {
      final seen = <String>{};
      for (final id in ids) {
        if (!seen.add(id)) throw FormatException('duplicate $what id $id');
      }
      return seen;
    }

    final sourceIds = unique(sources.map((s) => s.id), 'source');
    final groupIds = unique(groups.map((g) => g.id), 'group');
    final quizIds = unique(quiz.map((q) => q.id), 'quiz');
    final lessonIds = unique(lessons.map((l) => l.id), 'lesson');
    for (final q in quiz) {
      for (final id in q.sourceIds) {
        if (!sourceIds.contains(id)) {
          throw FormatException('${q.id}: unknown source $id');
        }
      }
      if (!q.isUnverified && q.refs.isEmpty) {
        throw FormatException('${q.id}: approved question without source');
      }
      if (q.options.length < 2) {
        throw FormatException('${q.id}: needs at least two options');
      }
      for (final t in q.topicIds) {
        if (!groupIds.contains(t)) {
          throw FormatException('${q.id}: topic $t is not a group');
        }
      }
    }
    final libraryIds = unique(library.map((i) => i.id), 'library item');
    final topicIds = {...groupIds, ...lessonIds};
    for (final item in library) {
      if (item.categories.isEmpty) {
        throw FormatException('${item.id}: no category');
      }
      for (final t in item.topics) {
        if (!topicIds.contains(t)) {
          throw FormatException('${item.id}: unknown topic $t');
        }
      }
      if (item.supersedes != null && !libraryIds.contains(item.supersedes)) {
        throw FormatException(
          '${item.id}: unknown supersedes ${item.supersedes}',
        );
      }
      if (item.filePack != null && !item.rights.allowsSharedPack) {
        throw FormatException('${item.id}: file pack without recorded rights');
      }
      final file = item.file;
      if (file != null) {
        if (!item.rights.allowsSharedPack) {
          throw FormatException('${item.id}: in-app file without rights');
        }
        if (!item.importState.citable) {
          throw FormatException('${item.id}: in-app file for unprocessed item');
        }
        if (file.format != 'pdf') {
          throw FormatException(
            '${item.id}: unsupported format ${file.format}',
          );
        }
        if (!file.path.startsWith('assets/') ||
            file.path.contains('..') ||
            file.size <= 0 ||
            !RegExp(r'^[0-9a-f]{64}$').hasMatch(file.sha256)) {
          throw FormatException('${item.id}: bad in-app file reference');
        }
      }
      if (item.access == LibraryAccess.openLicence &&
          (item.licence == null || item.url == null || item.accessed == null)) {
        throw FormatException('${item.id}: open licence without evidence');
      }
      if (item.access == LibraryAccess.freeToRead && item.url == null) {
        throw FormatException('${item.id}: free-to-read item without url');
      }
    }
    for (final s in sources) {
      final itemId = s.libraryItemId;
      if (itemId == null) continue;
      final item = libraryItem(itemId);
      if (item == null) {
        throw FormatException('${s.id}: unknown library item $itemId');
      }
      if (!item.importState.citable) {
        throw FormatException(
          '${s.id}: cites ${item.id} (${item.importState.key})',
        );
      }
    }
    for (final lesson in lessons) {
      if (lesson.groupId != null && !groupIds.contains(lesson.groupId)) {
        throw FormatException('${lesson.id}: unknown group ${lesson.groupId}');
      }
      for (final q in lesson.quizIds) {
        if (!quizIds.contains(q)) {
          throw FormatException('${lesson.id}: unknown question $q');
        }
      }
      for (final r in lesson.refs) {
        if (!sourceIds.contains(r.sourceId)) {
          throw FormatException('${lesson.id}: unknown source ${r.sourceId}');
        }
      }
    }
  }
}

List<String> _strings(Object? raw, String field) {
  if (raw == null) return const [];
  if (raw is! List) throw FormatException('$field: expected a list');
  return List.unmodifiable([
    for (final v in raw)
      if (v is String) v else throw FormatException('$field: not a string: $v'),
  ]);
}
