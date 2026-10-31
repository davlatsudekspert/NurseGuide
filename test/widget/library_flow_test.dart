import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/widgets/lg_widgets.dart';
import 'package:nurseguide/features/library/library_screens.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/library_fixtures.dart';

final _uz = lookupAppLocalizations(const Locale('uz'));

Future<void> _tap(WidgetTester tester, Finder f) async {
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

Future<void> _tapText(WidgetTester tester, String text) =>
    _tap(tester, find.text(text).hitTestable().last);

void main() {
  setUpAll(loadAppFonts);

  testWidgets('library: search entry is hidden while the catalog is empty', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    await goTo(tester, '/library');
    expect(find.text(_uz.libSearchEntry), findsNothing);
  });

  testWidgets(
    'library: sections shell is glossary · DMED · literature · saved · sources',
    (tester) async {
      final s = await makeServices(tester);
      await pumpApp(tester, s);
      await goTo(tester, '/library');
      expect(find.text(_uz.glossaryTitle), findsOneWidget);
      expect(find.text(_uz.dmedTitle), findsOneWidget);
      expect(find.text(_uz.litTitle), findsOneWidget);
      expect(find.text(_uz.featureSaved), findsOneWidget);
      expect(find.text(_uz.libSources), findsOneWidget);
      expect(find.byType(LgRow), findsNWidgets(5));
    },
  );

  testWidgets('DMED: filter by group, search, reveal answer', (tester) async {
    final s = await makeServices(tester, bundle: rootBundle);
    await pumpApp(tester, s, size: const Size(390, 3000));
    await goTo(tester, '/library/dmed');
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    expect(find.text(_uz.dmedCount(150)), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('dmed-group-tugruq')));
    expect(find.text(_uz.dmedCount(2)), findsOneWidget);
    const first = ValueKey('dmed-dmed-064');
    expect(find.byKey(first), findsOneWidget);
    expect(find.text('Tizim tomonidan avtomatik.'), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('dmed-toggle-dmed-065')));
    expect(find.text('Tizim tomonidan avtomatik.'), findsOneWidget);
    expect(find.text(_uz.dmedHide), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('dmed-group-all')));
    await tester.enterText(
      find.byKey(const ValueKey('dmed-search')),
      'epikriz',
    );
    await tester.pumpAndSettle();
    expect(find.text(_uz.dmedCount(150)), findsNothing);
    expect(find.textContaining('Manba: DMED'), findsWidgets);
  });

  testWidgets('save a material and find it under Saved; remove again', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: LibraryTestBundle());
    await pumpApp(tester, s, size: const Size(390, 2000));
    await goTo(tester, '/library/saved');
    expect(find.text(_uz.savedEmptyTitle), findsOneWidget);

    await goTo(tester, '/library/books/item/$testPdfItemId');
    await _tap(tester, find.byKey(const ValueKey('library-save')));
    expect(s.bookmarks.contains(testPdfItemId), isTrue);
    expect(find.text(_uz.actionUnsave), findsOneWidget);

    await goTo(tester, '/library/saved');
    expect(find.text(_uz.savedEmptyTitle), findsNothing);
    expect(find.byType(LibraryItemCard), findsOneWidget);

    await goTo(tester, '/library/books/item/$testPdfItemId');
    await _tap(tester, find.byKey(const ValueKey('library-save')));
    expect(s.bookmarks.contains(testPdfItemId), isFalse);
  });

  testWidgets('each material says what happens; pending cannot be opened', (
    tester,
  ) async {
    final s = await makeServices(tester, bundle: LibraryTestBundle());
    await pumpApp(tester, s, size: const Size(390, 2000));

    await goTo(tester, '/library/books/item/$pendingItemId');
    expect(find.text(_uz.libOpenPending), findsOneWidget);
    expect(find.text(_uz.libOpenPendingHint), findsOneWidget);
    expect(find.text(_uz.libItemRead), findsNothing);
    expect(find.text(_uz.libOpenSource), findsNothing);
    final cannot = find.widgetWithText(InkWell, _uz.libItemCannotOpen);
    expect(tester.widget<InkWell>(cannot).onTap, isNull);

    await goTo(tester, '/library/books/item/$downloadItemId');
    expect(find.text(_uz.libOpenDownload), findsOneWidget);
    expect(find.text(_uz.libDownloadUnavailable), findsOneWidget);

    await goTo(tester, '/library/books/item/$personalItemId');
    expect(find.text(_uz.libOpenRecordHint), findsOneWidget);
    expect(find.textContaining(_uz.rightsPersonal), findsOneWidget);

    await goTo(tester, '/library/books/item/$testPdfItemId');
    expect(find.text(_uz.libOpenInApp), findsOneWidget);
    expect(find.text(_uz.libOpenInAppHint), findsOneWidget);
    expect(find.text(_uz.libItemRead), findsOneWidget);

    // Katalogda ham: kutilayotgan material “mavjud” deb ko'rsatilmaydi.
    await goTo(tester, '/library/books');
    await _tapText(tester, _uz.libFilterType);
    await _tapText(tester, _uz.libOpenPending);
    expect(find.byType(LibraryItemCard), findsOneWidget);
    expect(find.text('Kutilayotgan sinov kitobi'), findsOneWidget);
  });

  testWidgets('adabiyotlar: kartalar, hisob va tayangan materiallar', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s, size: const Size(390, 3200));
    await goTo(tester, '/library/literature');
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    // Faqat ochiq xorijiy manbalar: mahalliy darslik, rasmiy hujjat va o'quv
    // to'plamlari bo'limlari ko'rinmaydi.
    expect(find.text(_uz.litTextbooks), findsNothing);
    expect(find.text(_uz.litOfficial), findsNothing);
    expect(find.text(_uz.litOther), findsNothing);
    expect(find.byKey(const ValueKey('lit-inomov2007')), findsNothing);
    expect(find.byKey(const ValueKey('lit-ahmedova2015')), findsNothing);
    // Hisob avtomatik: "0 ta" kabi bo'sh qatorlar yo'q.
    expect(find.textContaining(' 0 '), findsNothing);
  });
}
