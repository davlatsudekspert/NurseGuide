// Ma'ruza taqdimotlari katalogi (assets/lectures/index_v2.json + decks/*.json):
// har deck ilova parserida o'qiladi, oxirgi slayd — "Adabiyotlar", id'lar indeks
// bilan mos; qidiruv darajalari va ajratib ko'rsatish.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/content/text_normalize.dart';

import '../helpers/fixtures.dart';

DeckCatalog _real() => DeckCatalog.parse(fixtureCatalog());

void main() {
  final catalog = _real();

  group('indeks va decklar', () {
    // 13 MiB: vizual shablonlar va litsenziyali fotolar ~0.5 MB qo'shdi
    // 16 MiB (D-67): M9 ning 45 ta amaliy kuni decklari ~2.8 MB qo'shdi
    // (tool/slides/test_export_app_decks.py SIZE_BUDGET bilan bir xil).
    test('hajm: yangi assetlar 16 MB dan oshmaydi', () {
      var bytes = File('assets/lectures/index_v2.json').lengthSync();
      for (final f in Directory('assets/lectures/decks').listSync()) {
        if (f is File) bytes += f.lengthSync();
      }
      expect(bytes, lessThan(16 * 1024 * 1024));
    });

    test(
      'kalit so‘zlar normallashtirilgan va sarlavhalarni o‘z ichiga oladi',
      () {
        for (final e in catalog.decks) {
          expect(normalizeForSearch(e.keywords), e.keywords, reason: e.id);
          for (final l in e.languages) {
            expect(
              e.keywords,
              contains(normalizeForSearch(e.titles[l]!)),
              reason: '${e.id}.$l',
            );
          }
        }
      },
    );
  });

  group('DeckEntry', () {});

  group('qidiruv ballari (sintetik katalog)', () {
    // Ball darajalari: to'liq sarlavha > boshi > so'z boshi > ichida >
    // slayd sarlavhasi > faqat kalit so'z.
    Map<String, Object?> deck(
      String id,
      String title, {
      List<List<Object>> runs = const [],
      String kw = '',
    }) => {
      'id': id,
      'kind': 'day',
      'm': 1,
      'd': 1,
      'topics': ['$id-P'],
      't': {'uz': title},
      'n': {'uz': 5},
      'l': ['uz'],
      'st': {'uz': runs},
      'kw': kw.isEmpty ? normalizeForSearch(title) : kw,
    };
    final synthetic = DeckCatalog.parse(
      jsonEncode({
        'modules': [
          {'n': 1, 'id': 'M1', 'uz': 'Modul'},
        ],
        'decks': [
          deck('keyword', 'Boshqa mavzu', kw: 'boshqa mavzu | temir'),
          deck(
            'slide',
            'Anemiyalar',
            runs: [
              ['Temir tanqisligi', 2, 3],
            ],
            kw: 'anemiyalar | temir tanqisligi',
          ),
          deck('contains', 'Antitemir sinamasi'),
          deck('word', 'Kamqonlikda temir'),
          deck('prefix', 'Temir almashinuvi'),
          deck('exact', 'Temir'),
        ],
      }),
    );
    final search = DeckSearch(synthetic);

    test('tartib: exact > prefix > word > contains > slide > keyword', () {
      final hits = search.search('temir', lang: 'uz');
      expect(
        [for (final h in hits) h.entry.id],
        ['exact', 'prefix', 'word', 'contains', 'slide', 'keyword'],
      );
      expect(hits.first.score, greaterThan(DeckScore.titlePrefix));
      expect(hits[1].score, greaterThanOrEqualTo(DeckScore.titlePrefix));
      expect(hits.last.score, DeckScore.keyword);
      final slide = hits.firstWhere((h) => h.entry.id == 'slide');
      expect(slide.matchedSlides, 3);
      expect(slide.firstSlide, 2);
      expect(slide.slides.single.title, 'Temir tanqisligi');
    });

    test('bir nechta so‘z: hammasi bo‘lishi shart (AND)', () {
      final ids = [
        for (final h in search.search('temir tanqisligi', lang: 'uz'))
          h.entry.id,
      ];
      expect(ids, ['slide']);
      expect(search.search('temir yo‘q so‘z', lang: 'uz'), isEmpty);
    });

    test('bo‘sh so‘rov: filtrga mos hammasi, katalog tartibida', () {
      final all = search.search('  ', lang: 'uz');
      expect(
        [for (final h in all) h.entry.id],
        ['keyword', 'slide', 'contains', 'word', 'prefix', 'exact'],
      );
      expect(all.every((h) => h.matchedSlides == 0), isTrue);
    });
  });

  group('qidiruv (fixture katalog)', () {
    final cat = DeckCatalog.parse(fixtureCatalog());
    final search = DeckSearch(cat);

    test('katalog o‘qiladi: modul, deck, mavzu bog‘lanishi', () {
      expect(cat.modules.single.titles['uz'], 'Birinchi modul');
      expect(cat.byId('d001')!.title('en'), 'First topic');
      expect(cat.byTopic('t001-L')!.id, 'd001');
      expect(cat.inModule(1).map((d) => d.id), ['d001']);
      expect(cat.protocols, isEmpty);
    });

    test('sarlavha va slayd sarlavhasi bo‘yicha topadi', () {
      expect(search.search('birinchi', lang: 'uz').map((h) => h.entry.id), [
        'd001',
      ]);
      final slide = search.search('asosiy tushunchalar', lang: 'uz');
      expect(slide.single.entry.id, 'd001');
      expect(slide.single.firstSlide, 2);
      expect(search.search('yo‘qqa chiqmaydi', lang: 'uz'), isEmpty);
    });

    test('apostrof va kirill so‘rov farq qilmaydi', () {
      final a = search.search('yo\'q', lang: 'uz');
      final b = search.search('yo‘q', lang: 'uz');
      expect(a.length, b.length);
      expect(
        search.search('асосий тушунчалар', lang: 'uz').map((h) => h.entry.id),
        ['d001'],
      );
    });

    test('filtr: modul, til', () {
      expect(
        search
            .search('', lang: 'uz', filter: const DeckFilter(module: 2))
            .length,
        0,
      );
      expect(
        search
            .search(
              '',
              lang: 'uz',
              filter: const DeckFilter(lang: 'ru'),
            )
            .length,
        0,
      );
    });
  });

  group('highlightRanges', () {
    test('apostroflar tushiriladi, indekslar asl matnda', () {
      const t = 'O‘zbekistonda klinik hamshiralik';
      final r = highlightRanges(t, DeckQuery("o'zbekiston"));
      expect(r, hasLength(1));
      expect(t.substring(r.single.$1, r.single.$2), 'O‘zbekiston');
    });

    test('bir nechta so‘z, birlashtirish va katta/kichik harf', () {
      const t = 'Temir tanqisligi anemiyasi';
      final r = highlightRanges(t, DeckQuery('TEMIR tanq'));
      expect([for (final x in r) t.substring(x.$1, x.$2)], ['Temir', 'tanq']);
      final merged = highlightRanges('abcabc', DeckQuery('abc bca'));
      expect(merged, [(0, 6)]);
    });

    test('kirill so‘rov lotin matnni ajratadi (translit)', () {
      const t = 'Qon bosimini o‘lchash qoidalari';
      final r = highlightRanges(t, DeckQuery('босим'));
      expect([for (final x in r) t.substring(x.$1, x.$2)], ['bosim']);
    });

    test('ё → е va bo‘sh so‘rov', () {
      expect(highlightRanges('Всё хорошо', DeckQuery('все')).map((x) => x.$2), [
        3,
      ]);
      expect(highlightRanges('abc', DeckQuery('  ')), isEmpty);
    });
  });
}
