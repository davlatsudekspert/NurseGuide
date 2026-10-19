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

  testWidgets('library search entry opens the catalog with the keyboard', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    await goTo(tester, '/library');
    await _tapText(tester, _uz.libSearchEntry);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.focusNode!.hasFocus, isTrue);
  });

  testWidgets(
    'library: sections shell is glossary · books · saved · sources only',
    (tester) async {
      final s = await makeServices(tester);
      await pumpApp(tester, s);
      await goTo(tester, '/library');
      expect(find.text(_uz.glossaryTitle), findsOneWidget);
      expect(find.text(_uz.libBooks), findsOneWidget);
      expect(find.text(_uz.featureSaved), findsOneWidget);
      expect(find.text(_uz.libSources), findsOneWidget);
      expect(find.byType(LgRow), findsNWidgets(4));
    },
  );

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
}
