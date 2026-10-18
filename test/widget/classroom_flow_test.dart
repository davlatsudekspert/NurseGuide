import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/features/classroom/curriculum.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

const _tall = Size(390, 2400);

Future<void> _signIn(WidgetTester tester, AppServices s, String email) async {
  await s.auth.signOut();
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('o‘quv dasturi yo‘q: “qo‘shilmagan” deb ko‘rsatiladi', (
    tester,
  ) async {
    final b = FakeBackend();
    // Endi ilovada haqiqiy dastur asset'i bor — bu yerda u yo'q holat
    // sun'iy yaratiladi (masalan, eski yoki qisqartirilgan build).
    final s = await makeServices(
      tester,
      backend: b,
      role: AppRole.teacher,
      bundle: _WithoutCurriculum(),
    );
    await pumpApp(tester, s, size: _tall);
    // Ma'ruza ro'yxati (tayyor decklar katalogi) o'quv dasturiga bog'liq emas
    // (D-68 Q1: dastur mavzulari bo'limi olib tashlandi) — guruh rejasi esa
    // halol "qo'shilmagan" holatini ko'rsatadi.
    await _signIn(tester, s, 'teacher@example.com');
    await b.registerTeacher();
    final g = await b.createGroup('KLD');
    await goTo(tester, '/learn/classes/g/${g.id}/plan');
    expect(find.text(uz.classroomNoCurriculumTitle), findsOneWidget);
  });
}

/// Ilova asset'lari, faqat o'quv dasturi fayli yo'q.
class _WithoutCurriculum extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) {
    if (key == CurriculumLoader.assetPath) {
      throw FlutterError('Unable to load asset: $key');
    }
    return rootBundle.load(key);
  }
}
