// Dizayn yangilanishi (docs/DESIGN_REVIEW_2026-10-17.md): welcome
// afzalliklari, bosh sahifa kartalaridagi ma'noli izohlar, holat
// illyustratsiyasi va skeleton, suzuvchi panel ustidagi bo'sh joy.
// Tor ekran (320 px) va katta shrift (1.3x) — uz/ru/en, overflow yo'q.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/theme.dart';
import 'package:nurseguide/design/widgets/lg_widgets.dart';
import 'package:nurseguide/features/toifa/toifa_screens.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';

AppLocalizations _l(AppLanguage lang) =>
    lookupAppLocalizations(Locale(lang.name));

void main() {
  setUpAll(loadAppFonts);

  // Taklif 6: Toifa kartasi Kunlik savol kartasi uslubida — qattiq chegara
  // yo'q, yumshoq soya (LgShadow); tunda soya o'rniga juda xira chet.
  for (final dark in [false, true]) {
    testWidgets(
      'toifa kirish kartasi: shisha qirra va soya (${dark ? 'tun' : 'kun'})',
      (tester) async {
        final s = await makeServices(
          tester,
          themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        );
        tester.platformDispatcher.localesTestValue = [const Locale('uz')];
        await pumpApp(tester, s, size: const Size(390, 2400));
        final box = find
            .descendant(
              of: find.byType(ToifaEntryCard),
              matching: find.byType(DecoratedBox),
            )
            .first;
        final d = tester.widget<DecoratedBox>(box).decoration as BoxDecoration;
        // "Tiniq shisha": yorug' qirra (rim) va yumshoq soya — kun va tunda.
        expect(d.border, isNotNull);
        expect(d.boxShadow, isNotEmpty);
        expect(tester.takeException(), isNull);
      },
    );
  }

  // Taklif 7: sarlavhali yuklanish (sinflar) — spinner o'rniga kontur, sarlavha
  // kichik izoh va screen reader yorlig'i sifatida.
  testWidgets('sarlavhali yuklanish — skeleton (izoh bilan)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildLgTheme(Brightness.light),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LgSkeleton(caption: _l(AppLanguage.en).classesLoading),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(_l(AppLanguage.en).classesLoading), findsOneWidget);
    expect(
      find.bySemanticsLabel(_l(AppLanguage.en).classesLoading),
      findsOneWidget,
    );
  });
}
