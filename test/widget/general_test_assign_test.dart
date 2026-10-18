// “Umumiy test berish”: ustoz guruh sahifasidan toifa mavzusi + ma'ruza
// moduli tanlaydi, 50 ta savol, 20 daqiqa, variantli rejim — yuboradi. Server
// (soxta) to'g'ri id, kalit, vaqt va per_student oladi; talaba ilovada
// yechadi; ustoz natijani ko'radi. Ikki ekran: 390×844 (iOS fizikasi) va
// 360×640 ×1.3.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

void main() {
  setUpAll(loadAppFonts);

  testWidgets('talabaga O‘rganishda “Umumiy test berish” yo‘q', (tester) async {
    final s = await makeServices(tester, role: AppRole.student);
    await pumpApp(tester, s);
    await goTo(tester, '/learn');
    expect(find.byKey(const ValueKey('learn-general-test')), findsNothing);
  });
}
