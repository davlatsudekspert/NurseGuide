import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/tokens.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../content/content_model.dart';
import '../content/ui/content_widgets.dart';
import '../content/ui/source_widgets.dart' show SourceTile;
import 'library_catalog.dart';
import 'library_filters.dart';
import 'library_widgets.dart';

/// Kutubxona bo'limlari (qobiq): kitoblar, saqlanganlar, manbalar.
enum LibrarySection { glossary, dmed, literature, books, saved, sources }

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([services.settings, services.content]),
      builder: (context, _) {
        final l = AppLocalizations.of(context);
        final uiLang = Localizations.localeOf(context).languageCode;
        // Faqat interfeys tilida mavjud materiallar sanaladi.
        final count = services.content.pack?.library
            .where((i) => libraryItemAvailableIn(i, uiLang))
            .length;
        // Katalog bo'sh bo'lsa "0 ta manba" qatori ko'rsatilmaydi.
        final sourcesCount = services.content.pack?.sources.length ?? 0;
        final sections = [
          for (final s in LibrarySection.values)
            if ((s != LibrarySection.books || (count ?? 0) > 0) &&
                (s != LibrarySection.sources || sourcesCount > 0))
              s,
        ];
        return LgPage(
          title: l.libTitle,
          subtitle: l.libSubtitle,
          showBrand: true,
          children: [
            const _ContinueReadingCard(),
            if ((count ?? 0) > 0)
              _SearchEntry(
                label: l.libSearchEntry,
                onTap: () => context.push('/library/books?search=1'),
              ),
            for (final (i, s) in sections.indexed)
              _SectionRow(
                section: s,
                count: count,
                last: i == sections.length - 1,
              ),
          ],
        );
      },
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.section,
    required this.count,
    required this.last,
  });

  final LibrarySection section;

  /// Katalogdagi materiallar soni (paket yuklangan bo'lsa).
  final int? count;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final (
      String title,
      String sub,
      IconData icon,
      String path,
    ) = switch (section) {
      LibrarySection.glossary => (
        l.glossaryTitle,
        l.glossarySub,
        Icons.spellcheck_rounded,
        '/library/glossary',
      ),
      LibrarySection.dmed => (
        l.dmedTitle,
        l.dmedSub,
        Icons.local_hospital_outlined,
        '/library/dmed',
      ),
      LibrarySection.literature => (
        l.litTitle,
        l.litSub,
        Icons.menu_book_rounded,
        '/library/literature',
      ),
      LibrarySection.books => (
        l.libBooks,
        count == null ? l.libBooksSub : l.libBooksCount(count!),
        Icons.menu_book_outlined,
        '/library/books',
      ),
      LibrarySection.saved => (
        l.featureSaved,
        l.libSavedSub,
        Icons.bookmark_outline,
        '/library/saved',
      ),
      LibrarySection.sources => (
        l.libSources,
        l.libSourcesSub,
        Icons.fact_check_outlined,
        '/library/sources',
      ),
    };
    return LgRow(
      title: title,
      subtitle: sub,
      icon: icon,
      onTap: () => context.push(path),
      divider: !last,
    );
  }
}

/// Qidiruv maydoniga o'xshash tugma: katalogni qidiruv fokusida ochadi.
class _SearchEntry extends StatelessWidget {
  const _SearchEntry({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: LgPressable(
        onTap: onTap,
        color: p.paper,
        semanticLabel: label,
        borderRadius: BorderRadius.circular(LgRadius.button),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 54),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(Icons.search_rounded, color: p.sub),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ExcludeSemantics(
                    child: Text(
                      label,
                      style: text.bodyLarge!.copyWith(color: p.sub),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Oxirgi ochilgan ilova ichidagi kitob (bo'lsa): bir bosishda o'sha
/// sahifadan davom etiladi.
class _ContinueReadingCard extends StatelessWidget {
  const _ContinueReadingCard();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final services = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([services.reading, services.content]),
      builder: (context, _) {
        final pack = services.content.pack;
        // Eng oxirgi o'qilgan va hali ham ilovada ochiladigan fayl.
        final uiLang = Localizations.localeOf(context).languageCode;
        final match = pack == null
            ? null
            : services.reading.recent
                  .map((e) => (e, pack.libraryItem(e.key)))
                  .where(
                    (x) =>
                        x.$2 != null &&
                        libraryItemAvailableIn(x.$2!, uiLang) &&
                        canReadInApp(x.$2!) &&
                        x.$2!.file!.sha256 == x.$1.value.fileSha,
                  )
                  .firstOrNull;
        if (match == null) return const SizedBox.shrink();
        final (last, item!) = match;
        return LgPanel(
          soft: true,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: LgRow(
            title: l.libContinueReading,
            subtitle:
                '${libraryShortTitle(item, max: 70)} · '
                '${l.readerPageLabel(last.value.lastPage)}',
            icon: Icons.auto_stories_outlined,
            divider: false,
            onTap: () => context.push('/library/books/item/${item.id}/read'),
          ),
        );
      },
    );
  }
}

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bookmarks = context.services.bookmarks;
    return LgPage(
      title: l.featureSaved,
      children: [
        ContentGate(
          builder: (context, pack) => ListenableBuilder(
            listenable: bookmarks,
            builder: (context, _) {
              final saved = [
                for (final id in bookmarks.ids.reversed) ?pack.libraryItem(id),
              ];
              if (saved.isEmpty) {
                return LgStateView(
                  kind: StateKind.empty,
                  title: l.savedEmptyTitle,
                  message: l.savedEmptyBody,
                  actionLabel: pack.library.isEmpty ? null : l.libBooks,
                  onAction: pack.library.isEmpty
                      ? null
                      : () => context.push('/library/books'),
                );
              }
              return Column(
                children: [
                  for (final item in saved) LibraryItemCard(item: item),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

String categoryLabel(LibraryCategory c, AppLocalizations l) => switch (c) {
  LibraryCategory.fundamentals => l.catFundamentals,
  LibraryCategory.clinicalNursing => l.catClinicalNursing,
  LibraryCategory.procedures => l.catProcedures,
  LibraryCategory.pharmacology => l.catPharmacology,
  LibraryCategory.exams => l.catExams,
};

String kindLabel(LibraryItemKind k, AppLocalizations l) => switch (k) {
  LibraryItemKind.book => l.kindBook,
  LibraryItemKind.manual => l.kindManual,
  LibraryItemKind.method => l.kindMethod,
  LibraryItemKind.guideline => l.kindGuideline,
  LibraryItemKind.article => l.kindArticle,
  LibraryItemKind.questionSet => l.kindQuestionSet,
  LibraryItemKind.website => l.kindWebsite,
};

/// Kitoblar, qo'llanmalar, metodikalar katalogi: qidiruv va til / mavzu /
/// tur filtrlari. Yangi adabiyot kontent paketiga `library` yozuvi sifatida
/// qo'shiladi — ilova kodi o'zgarmaydi.
class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key, this.focusSearch = false});

  /// Kutubxona bosh sahifasidagi qidiruvdan kelinganda — klaviatura ochiq.
  final bool focusSearch;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  final _searchKey = GlobalKey();
  LibraryFilter _filter = LibraryFilter.none;
  LibraryCatalog? _catalog;

  @override
  void initState() {
    super.initState();
    if (widget.focusSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _set(LibraryFilter f) => setState(() => _filter = f);

  void _clearAll() {
    _query.clear();
    _set(LibraryFilter.none);
    // Ro'yxat boshiga — qidiruv va filtrlar yana ko'rinsin.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = _searchKey.currentContext;
      if (target != null && target.mounted) {
        unawaited(
          Scrollable.ensureVisible(
            target,
            duration: LgMotion.of(context, LgMotion.page),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final lang = Localizations.localeOf(context).languageCode;
    return LgPage(
      title: l.libBooks,
      children: [
        LibrarySearchField(
          key: _searchKey,
          controller: _query,
          focusNode: _focus,
          label: l.libSearchLabel,
          hint: l.libSearchHint,
          onChanged: (v) => _set(_filter.copyWith(query: v)),
        ),
        ContentGate(
          builder: (context, pack) {
            if (pack.library.isEmpty) {
              return LgStateView(
                kind: StateKind.empty,
                title: l.booksEmptyTitle,
                message: l.booksEmptyBody,
              );
            }
            final catalog = _catalog?.pack == pack && _catalog?.lang == lang
                ? _catalog!
                : _catalog = LibraryCatalog(pack, lang: lang);
            final results = catalog.apply(_filter, lang: lang);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LibraryFilterBar(
                  catalog: catalog,
                  filter: _filter,
                  // Varaq tanlovi + maydondagi joriy so'z (varaq ochiq paytda
                  // o'zgargan bo'lsa ham eskisi qaytmaydi).
                  onChanged: (f) => _set(f.copyWith(query: _query.text)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          liveRegion: true,
                          child: Text(
                            l.libResultCount(
                              results.length,
                              catalog.items.length,
                            ),
                            style: text.bodySmall,
                          ),
                        ),
                      ),
                      if (_filter.isActive)
                        LgButton.link(
                          label: l.libClearFilters,
                          icon: Icons.close_rounded,
                          expand: false,
                          onPressed: _clearAll,
                        ),
                    ],
                  ),
                ),
                if (results.isEmpty)
                  LgStateView(
                    kind: StateKind.empty,
                    title: _filter.hasSelections
                        ? l.libFilteredEmptyTitle
                        : l.testsEmptyTitle,
                    message: _filter.hasSelections
                        ? l.libFilteredEmptyBody
                        : l.libQueryEmptyBody,
                    actionLabel: _filter.hasSelections
                        ? l.booksResetFilters
                        : l.testsClearSearch,
                    onAction: _clearAll,
                  )
                else
                  for (final item in results) LibraryItemCard(item: item),
                const SizedBox(height: 8),
                LgNotice(l.booksCatalogNote, kind: NoticeKind.info),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Katalog qatori: nomi, qisqa ma'lumot va “qanday ochiladi” belgisi.
/// Bosilganda material sahifasi ochiladi.
class LibraryItemCard extends StatelessWidget {
  const LibraryItemCard({super.key, required this.item});

  final LibraryItem item;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    final authors = item.authors.length > 2
        ? '${item.authors.take(2).join(', ')} …'
        : item.authors.join(', ');
    final meta = [
      kindLabel(item.kind, l),
      if (authors.isNotEmpty) authors,
      if (item.year != null) '${item.year}',
      item.language.toUpperCase(),
    ].join(' · ');
    final title = libraryShortTitle(item, max: 140);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: LgPressable(
        onTap: () => context.push('/library/books/item/${item.id}'),
        color: p.paper,
        borderRadius: BorderRadius.circular(LgRadius.card),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 12, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: text.titleMedium),
                    const SizedBox(height: 4),
                    Text(meta, style: text.bodySmall),
                    const SizedBox(height: 12),
                    OpenKindLine(item: item),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              ExcludeSemantics(
                child: Icon(Icons.chevron_right_rounded, color: p.sub),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kontent paketidagi manbalar ro'yxati (muallif, nashriyot, sana).
class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return LgPage(
      title: l.sourcesTitle,
      children: [
        Text(l.sourcesBody, style: text.bodyMedium),
        const SizedBox(height: 8),
        ContentGate(
          builder: (context, pack) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LgSectionTitle('${l.sourcesContent} (${pack.sources.length})'),
              LgPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < pack.sources.length; i++)
                      SourceTile(index: i + 1, source: pack.sources[i]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
