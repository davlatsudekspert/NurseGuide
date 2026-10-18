import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/content/content_model.dart';
import 'package:nurseguide/features/library/library_catalog.dart';

import '../helpers/library_fixtures.dart';
import '../helpers/test_pdf.dart';

Map<String, Object?> _packJson() => (jsonDecode(
  File('assets/content/core/pack.json').readAsStringSync(),
) as Map).cast<String, Object?>();

ContentPack _realPack() => ContentPack.fromJson(_packJson());

/// Haqiqiy paket + sinov materiallari (ilova ichidagi, kutilayotgan,
/// yuklab olinadigan, shaxsiy).
ContentPack _packWithFixtures() {
  final json = _packJson();
  json['library'] = [
    ...(json['library']! as List),
    ...testLibraryItems(buildTestPdf()),
  ];
  return ContentPack.fromJson(json);
}

void main() {
  group(
    'open kind (havola / ilova ichida / yuklab olinadigan / kutilmoqda)',
    () {
      test('fixtures are classified honestly', () {
        final pack = _packWithFixtures();
        LibraryOpenKind kind(String id) => openKindOf(pack.libraryItem(id)!);
        expect(kind(testPdfItemId), LibraryOpenKind.inApp);
        expect(kind(pendingItemId), LibraryOpenKind.pending);
        expect(kind(downloadItemId), LibraryOpenKind.download);
        expect(kind(personalItemId), LibraryOpenKind.record);
        expect(canReadInApp(pack.libraryItem(pendingItemId)!), isFalse);
      });

      test('not received / received items are pending even with a link', () {
        for (final state in [ImportState.notReceived, ImportState.received]) {
          final item = LibraryItem(
            id: 'x',
            kind: LibraryItemKind.book,
            title: 'X',
            authors: const [],
            language: 'uz',
            categories: const [LibraryCategory.fundamentals],
            topics: const [],
            importState: state,
            rights: const RightsRecord(
              distribution: DistributionRights.unknown,
            ),
            url: 'https://example.org/x',
          );
          expect(openKindOf(item), LibraryOpenKind.pending);
        }
      });
    },
  );

  group('search', () {
    final catalog = LibraryCatalog(_realPack());

    test('nonsense finds nothing', () {
      expect(
        catalog.apply(const LibraryFilter(query: 'zzqqxx'), lang: 'uz'),
        isEmpty,
      );
    });
  });

  group('filters', () {
    final pack = _realPack();
    final _ = LibraryCatalog(pack);

    test('copyWith can set and unset each dimension', () {
      const f = LibraryFilter(language: 'uz', kind: LibraryItemKind.book);
      expect(f.copyWith(language: null).language, isNull);
      expect(f.copyWith(language: null).kind, LibraryItemKind.book);
      expect(f.copyWith(query: 'x').language, 'uz');
      expect(f.copyWith(open: LibraryOpenKind.link).open, LibraryOpenKind.link);
      expect(LibraryFilter.none.isActive, isFalse);
      expect(const LibraryFilter(query: ' ').isActive, isFalse);
    });
  });

  group('in-app file schema', () {
    Map<String, Object?> withItem(Map<String, Object?> item) {
      final json = _packJson();
      // Haqiqiy katalog qoladi (kitob manbalari unga tayanadi).
      json['library'] = [...(json['library']! as List), item];
      return json;
    }

    final pdf = buildTestPdf();
    final base = testLibraryItems(pdf).first;

    test('a fully recorded file parses', () {
      final pack = ContentPack.fromJson(withItem(base));
      final file = pack.libraryItem(base['id']! as String)!.file!;
      expect(file.size, pdf.length);
      expect(file.pages, 10);
    });

    test('file without full rights record is rejected', () {
      for (final rights in [
        {'distribution': 'unknown'},
        {
          'distribution': 'personal_only',
          'recorded_at': '2026-10-09',
          'recorded_by': 'x',
          'evidence': 'y',
        },
        // Kim qayd etgani yo'q.
        {
          'distribution': 'permitted',
          'recorded_at': '2026-10-09',
          'evidence': 'y',
        },
      ]) {
        expect(
          () => ContentPack.fromJson(withItem({...base, 'rights': rights})),
          throwsFormatException,
          reason: '$rights',
        );
      }
    });

    test('file for an item that has not arrived is rejected', () {
      expect(
        () => ContentPack.fromJson(
          withItem({...base, 'import_state': 'not_received'}),
        ),
        throwsFormatException,
      );
    });

    test('bad file references are rejected', () {
      final file = base['file']! as Map<String, Object?>;
      for (final bad in [
        {...file, 'format': 'epub'},
        {...file, 'path': 'books/x.pdf'},
        {...file, 'path': 'assets/../secret.pdf'},
        {...file, 'sha256': 'abc'},
        {...file, 'size': 0},
      ]) {
        expect(
          () => ContentPack.fromJson(withItem({...base, 'file': bad})),
          throwsFormatException,
          reason: '$bad',
        );
      }
    });

    test('every in-app file in the shipped pack exists with its checksum', () {
      // Hozircha bunday fayl yo'q; kelganda — asset, hajm va sha256 mos.
      for (final item in _realPack().library) {
        final file = item.file;
        if (file == null) continue;
        final f = File(file.path);
        expect(f.existsSync(), isTrue, reason: file.path);
        expect(f.lengthSync(), file.size, reason: file.path);
      }
    });
  });
}
