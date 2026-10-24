import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

void main() {
  setUpAll(loadAppFonts);

  Future<void> open(WidgetTester tester, AppLanguage lang) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
      language: lang,
    );
    await pumpApp(tester, s);
    await goTo(tester, '/workplace');
    await tester.pumpAndSettle();
  }

  testWidgets('o‘zbekcha va ruscha: yangi yo‘nalishlar ko‘rinadi', (
    tester,
  ) async {
    for (final lang in [AppLanguage.uz, AppLanguage.ru]) {
      await open(tester, lang);
      expect(find.byKey(const ValueKey('work-dir-akusherlik')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('work-dir-rentgen_laborant')),
        findsOneWidget,
      );
    }
  });

  testWidgets('inglizcha: tarjimasiz yo‘nalishlar yashirin, asosiylar bor', (
    tester,
  ) async {
    await open(tester, AppLanguage.en);
    expect(find.byKey(const ValueKey('work-dir-akusherlik')), findsNothing);
    expect(
      find.byKey(const ValueKey('work-dir-rentgen_laborant')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('work-dir-hamshiralik')), findsOneWidget);
    expect(find.byKey(const ValueKey('work-dir-dmed')), findsOneWidget);
  });
}
