import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/brand.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';

void main() {
  setUpAll(loadAppFonts);

  // Tab ildizida kengaytirilgan holatda sarlavha yonida KATTA logotip va
  // yuqori panelda brend nomi; scroll qilinganda sarlavha yig'iladi va
  // logotip yuqorida kichik holda sarlavha yonida qoladi.
  Finder brandText() => find.text('NurseGuide');
  Finder logos() => find.byType(LgLogoMark);
  double largest() => logos()
      .evaluate()
      .map((e) => (e.widget as LgLogoMark).size)
      .fold<double>(0, (a, b) => a > b ? a : b);

  testWidgets('header: big logo beside the title shrinks when collapsed', (
    tester,
  ) async {
    final s = await makeServices(tester, language: AppLanguage.en);
    await pumpApp(tester, s, size: const Size(390, 844));
    await goTo(tester, '/learn');
    expect(brandText(), findsOneWidget);
    expect(largest(), greaterThanOrEqualTo(60), reason: 'big logo expanded');

    await tester.drag(find.byType(ListView).last, const Offset(0, -80));
    await tester.pumpAndSettle();
    expect(brandText(), findsNothing, reason: 'collapsed after scrolling down');
    expect(
      logos().evaluate().any((e) => (e.widget as LgLogoMark).size <= 44),
      isTrue,
      reason: 'small logo remains in the top bar',
    );

    // Tepaga qaytilganda kengayadi.
    await tester.drag(find.byType(ListView).last, const Offset(0, 400));
    await tester.pumpAndSettle();
    expect(brandText(), findsOneWidget);
  });
}
