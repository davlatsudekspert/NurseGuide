import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

void main() {
  setUpAll(loadAppFonts);

  test('bo‘lim nomi uch tilda yangi', () {
    expect(
      lookupAppLocalizations(const Locale('uz')).toifaTitle,
      'Bilim va malakani baholash',
    );
    expect(
      lookupAppLocalizations(const Locale('ru')).toifaTitle,
      'Проверка знаний и компетенций',
    );
    expect(
      lookupAppLocalizations(const Locale('en')).toifaTitle,
      'Knowledge & Skills Assessment',
    );
  });

  testWidgets('bo‘lim sahifalarida kafolat/rasmiy emas ogohlantirishi yo‘q', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
    );
    await pumpApp(tester, s);
    for (final r in [
      '/learn/toifa',
      '/learn/toifa/test',
      '/learn/toifa/practice',
      '/learn/toifa/oral',
    ]) {
      await goTo(tester, r);
      expect(find.textContaining('kafolat'), findsNothing, reason: r);
      expect(find.textContaining('rasmiy javob emas'), findsNothing, reason: r);
      expect(find.textContaining('norasmiy'), findsNothing, reason: r);
    }
  });
}
