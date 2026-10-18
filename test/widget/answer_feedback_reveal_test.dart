// Audit 2026-10-18 (tablar, docs/AUDIT_2026-10-18_TABS.md):
// kichik telefonda (360×640, ×1.3, iOS fizikasi) javob bosilgach
// "To'g'ri / xato" izohi ekrandan pastda qolardi — foydalanuvchi natijani
// ko'rmasdi va har savolda qo'lda surishi kerak edi. Endi izoh avtomatik
// ko'rinadigan joyga suriladi; katta ekranda ro'yxat qimirlamaydi.
// (Toifa mashqi — boshqa agent doirasida; bu yerda tegilmagan.)
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/widgets/reveal_on_mount.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

const _small = Size(360, 640);

/// Kunlik savollar sanaga bog'liq — test har kuni bir xil to'plamda.
DateTime _dailyAt = DateTime(2026, 10, 18, 10, 30);

final _ios = TargetPlatformVariant.only(TargetPlatform.iOS);

/// Izoh (RevealOnMount) boshi ekranning ko'rinadigan qismida — suzuvchi
/// menyudan yuqorida.
void _expectFeedbackVisible(WidgetTester tester, Size size) {
  final f = find.byType(RevealOnMount);
  expect(f, findsOneWidget);
  final top = tester.getTopLeft(f).dy;
  expect(top, greaterThan(47), reason: 'sarlavha ostida emas');
  expect(
    top + 48,
    lessThanOrEqualTo(size.height - 34 - RevealOnMount.bottomReserve),
    reason: 'izoh menyu ostida yoki ekrandan pastda qoldi',
  );
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('kunlik savollar: javobdan keyin izoh ko‘rinadi (360×640 ×1.3)', (
    tester,
  ) async {
    final s = await makeServices(tester, clock: () => _dailyAt);
    await pumpApp(tester, s, size: _small, textScale: 1.3);
    await goTo(tester, '/learn/daily');
    await tapScroll(tester, 'A');
    _expectFeedbackVisible(tester, _small);
  }, variant: _ios);
}
