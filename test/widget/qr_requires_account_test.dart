// QR skanerlash va guruhga qo'shilish faqat ro'yxatdan o'tgan (hisobga kirgan)
// foydalanuvchiga: mehmon ("hisobsiz") rejimida skaner tugmasi ham, kod kiritish
// maydoni ham ko'rinmaydi — kirish taklifi chiqadi; kirgach hammasi ochiladi.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

Future<void> _signIn(WidgetTester tester, AppServices s) async {
  await s.auth.requestCode('talaba@example.com');
  await s.auth.verifyCode(FakeBackend.otpCode);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('mehmon: guruhlar ekranida skaner yo‘q, kirish taklifi bor', (
    tester,
  ) async {
    final s = await makeServices(tester, backend: FakeBackend());
    expect(s.auth.hasAccount, isFalse);
    await pumpApp(tester, s, size: const Size(390, 1400));
    await goTo(tester, '/learn/classes');
    expect(find.text(uz.classesSignInTitle), findsOneWidget);
    expect(find.text(uz.qrScanAction), findsNothing);
  });

  testWidgets('mehmon: taklif havolasi — kod maydoni emas, kirish taklifi', (
    tester,
  ) async {
    final s = await makeServices(tester, backend: FakeBackend());
    await pumpApp(tester, s, size: const Size(390, 1400));
    await goTo(tester, '/j?c=ABCD2345');
    expect(find.text(uz.classesJoinSignInTitle), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text(uz.qrScanAction), findsNothing);
  });

  testWidgets('hisobga kirgach: qo‘shilish ekranida QR skaner ochiladi', (
    tester,
  ) async {
    final s = await makeServices(tester, backend: FakeBackend());
    await pumpApp(tester, s, size: const Size(390, 1400));
    await _signIn(tester, s);
    expect(s.auth.hasAccount, isTrue);
    await goTo(tester, '/learn/classes/join');
    expect(find.text(uz.classesJoinSignInTitle), findsNothing);
    expect(find.text(uz.qrScanAction), findsWidgets);
  });
}
