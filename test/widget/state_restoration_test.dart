import 'package:flutter/widgets.dart' show Size;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/harness.dart';
import '../helpers/ui.dart';

void main() {
  setUpAll(loadAppFonts);

  // Tizim ilovani fonda yopib, qayta ochganda (process death) foydalanuvchi
  // turgan joyiga qaytadi — tab va ichki sahifa tiklanadi.
  testWidgets('open page and tab survive a restart with restoration', (
    tester,
  ) async {
    final s = await makeServices(tester, language: AppLanguage.en);
    await pumpApp(tester, s, size: const Size(390, 1600));
    await goTo(tester, '/learn/exam');
    expect(find.text(en.learnExam), findsWidgets);

    await tester.restartAndRestore();
    await tester.pumpAndSettle();
    expect(find.text(en.learnExam), findsWidgets);
    // Orqaga — o'sha tabning oldingi sahifasi (stek tiklangan).
    await tester.tap(find.byTooltip(en.actionBack));
    await tester.pumpAndSettle();
    expect(find.text(en.learnTitle), findsWidgets);
  });
}
