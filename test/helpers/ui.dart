import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/l10n/gen/app_localizations_en.dart';
import 'package:nurseguide/l10n/gen/app_localizations_ru.dart';
import 'package:nurseguide/l10n/gen/app_localizations_uz.dart';

import 'harness.dart';

final uz = AppLocalizationsUz();
final ru = AppLocalizationsRu();
final en = AppLocalizationsEn();

/// Asosiy (vertikal) scroll — gorizontal chip qatorlari emas.
final verticalScrollable = find.byWidgetPredicate(
  (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
);

/// Ro'yxat dangasa quriladi — element ko'rinadigan joyga scroll qilinadi.
Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  if (finder.hitTestable().evaluate().isNotEmpty) return;
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      250,
      scrollable: verticalScrollable.hitTestable().first,
    );
  } else {
    await tester.ensureVisible(finder.first);
  }
  await tester.pumpAndSettle();
}

/// Pastki menyu tab nomlari (uz/ru/en) → tab indeksi.
final navIndexByLabel = <String, int>{
  for (final l in [uz, ru, en]) ...{
    l.navHome: 0,
    l.navProcedures: 1,
    l.navWorkplace: 2,
    l.navLibrary: 3,
    l.navLearn: 4,
  },
};

/// Matnli elementni topib (kerak bo'lsa scroll qilib) bosadi.
///
/// Pastki menyu tabi bo'lsa — kalit orqali: sahifa pastga scroll qilinganda
/// menyu ixcham bo'lib, nomlarini yashiradi (ikonka bosiladi).
Future<void> tapText(WidgetTester tester, String text) async {
  final navIndex = navIndexByLabel[text];
  if (navIndex != null && find.text(text).evaluate().length == 1) {
    await tapNavTab(tester, navIndex);
    return;
  }
  final all = find.text(text);
  await scrollTo(tester, all);
  await tester.tap(all.hitTestable().first);
  await tester.pumpAndSettle();
}
