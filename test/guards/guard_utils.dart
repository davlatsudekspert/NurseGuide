import 'dart:convert';
import 'dart:io';

/// Repo ichidagi fayllar (ildizdan nisbiy yo'l bo'yicha).
Iterable<File> filesUnder(String dir, {bool Function(String path)? where}) =>
    Directory(dir).existsSync()
    ? Directory(dir)
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .where((f) => where == null || where(f.path))
    : const [];

/// `assets/` ichidagi barcha JSON fayllar.
List<File> assetJsonFiles() => [
  for (final f in filesUnder('assets', where: (p) => p.endsWith('.json'))) f,
];

typedef JsonString = ({String path, String text});

/// JSON daraxtidagi barcha matn qiymatlari (`a.b[2].c` ko'rinishidagi yo'l
/// bilan). [skipKey] true bo'lgan kalitlar ostidagi tarmoq o'tkazib yuboriladi.
Iterable<JsonString> jsonStrings(
  Object? node, {
  String path = '',
  bool Function(String key)? skipKey,
}) sync* {
  if (node is String) {
    yield (path: path, text: node);
  } else if (node is List) {
    for (var i = 0; i < node.length; i++) {
      yield* jsonStrings(node[i], path: '$path[$i]', skipKey: skipKey);
    }
  } else if (node is Map) {
    for (final e in node.entries) {
      final k = '${e.key}';
      if (skipKey != null && skipKey(k)) continue;
      yield* jsonStrings(
        e.value,
        path: path.isEmpty ? k : '$path.$k',
        skipKey: skipKey,
      );
    }
  }
}

Object? readJson(File f) => jsonDecode(f.readAsStringSync());

Map<String, Object?> readJsonMap(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, Object?>();

/// Kirill harflari (rus, o'zbek kirill va boshqa kirill belgilari).
final cyrillic = RegExp(r'[Ѐ-ӿԀ-ԯ]');
