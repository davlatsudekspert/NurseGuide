import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

/// Qabul tekshiruvi (UI darajasi): ikki test hisob (A, B) va alohida admin.
/// Server qoidalari `supabase/tests/10_acceptance.sql` da haqiqiy Postgres'da
/// alohida tekshiriladi; bu yerda ilova shu qoidalarga to'g'ri javob
/// berishini ko'ramiz.
const _a = 'tester.a@example.com';

final _l = lookupAppLocalizations(const Locale('uz'));

Future<void> _signIn(WidgetTester tester, AppServices s, String email) async {
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
  await tester.pumpAndSettle();
}

String _loc(WidgetTester tester) => routerOf(tester).state.matchedLocation;

/// Profil → “Yordam va aloqa” (D-69 Q6). Profil uzun (Birliklar qatori) —
/// qator ro'yxatda pastroqda.
Future<void> _openHelp(WidgetTester tester) async {
  final f = find.byKey(const ValueKey('profile-help'));
  await tester.scrollUntilVisible(
    f,
    300,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

Future<void> _tapText(WidgetTester tester, String text) async {
  final f = find.text(text).last;
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('sozlanmagan build: murojaat “server ulanmagan” deydi', (
    tester,
  ) async {
    final services = await makeServices(tester);
    await pumpApp(tester, services);
    await goTo(tester, '/profile');
    expect(find.text(_l.adminTitle), findsNothing);
    // Yagona “Yordam va aloqa” kirishi (D-69 Q6) — ichida ikki yo'l.
    await _openHelp(tester);
    expect(_loc(tester), '/profile/help');
    expect(
      find.text('${_l.supportSub} · ${_l.notAvailableYet}'),
      findsOneWidget,
    );
    expect(find.text(_l.contactRowTitle), findsOneWidget);
    await _tapText(tester, _l.supportTitle);
    expect(find.text(_l.supportUnavailableTitle), findsOneWidget);
    expect(find.text(_l.supportNew), findsNothing);
  });

  testWidgets('mehmon: murojaat uchun kirish so‘raladi', (tester) async {
    final services = await makeServices(tester, backend: FakeBackend());
    await pumpApp(tester, services);
    await goTo(tester, '/profile/support');
    expect(find.text(_l.supportSignInTitle), findsOneWidget);
    await goTo(tester, '/profile/admin');
    expect(find.text(_l.supportSignInTitle), findsOneWidget);
    expect(find.text(_l.adminStats), findsNothing);
  });

  testWidgets('server sessiyani bekor qilsa — mehmon rejimiga qaytadi', (
    tester,
  ) async {
    final backend = FakeBackend();
    final services = await makeServices(tester, backend: backend);
    await pumpApp(tester, services);
    await _signIn(tester, services, _a);
    expect(services.auth.hasAccount, isTrue);
    backend.revokeSession();
    await tester.pumpAndSettle();
    expect(services.auth.hasAccount, isFalse);
    expect(services.access.access.adminAccount, isFalse);
  });
}
