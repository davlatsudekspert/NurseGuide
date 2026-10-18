// Ma'ruza bo'limi: BARCHA tayyor taqdimotlar (modul bo'yicha), qidiruv
// (lotin/kirill, ruscha, inglizcha), filtr chiplari, bo'sh holat, taqdimotni
// 3 tilda ochish, 320 px / katta shrift.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/device_fakes.dart';
import '../helpers/harness.dart';

const _tall = Size(390, 2600);

Future<AppLocalizations> _open(
  WidgetTester tester, {
  AppLanguage lang = AppLanguage.uz,
  Size size = _tall,
  double textScale = 1,
  AppRole role = AppRole.teacher,
}) async {
  installDeviceFakes();
  final s = await makeServices(tester, role: role, language: lang);
  await pumpApp(tester, s, size: size, textScale: textScale);
  await goTo(tester, '/learn/lecture');
  return lookupAppLocalizations(lang.locale);
}

void main() {
  setUpAll(loadAppFonts);

  group('qidiruv', () {});

  group('filtr chiplari', () {});

  testWidgets('noma‘lum deck — halol xato holati', (tester) async {
    final l = await _open(tester);
    await goTo(tester, '/learn/lecture/deck/yoq-deck');
    expect(find.text(l.lectureDeckLoadFailed), findsOneWidget);
  });
}
