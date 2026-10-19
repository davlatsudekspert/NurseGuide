// Mehmon (hisobsiz) foydalanuvchi: faqat tanishuv — bosh sahifa, muolajalar
// va kutubxona ro'yxatlari. Test, mashq, kunlik savol, muolaja tafsiloti,
// atamalar, adabiyot tafsiloti — ro'yxatdan o'tishni so'raydi; kirgach
// dastlab so'ralgan sahifa o'zi ochiladi.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/router.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));
const _gate = ValueKey('account-required');

void main() {
  setUpAll(loadAppFonts);

  test('needsAccount: yopiq va ochiq yo‘llar', () {
    for (final p in [
      '/learn',
      '/learn/daily',
      '/learn/toifa/test',
      '/procedures/tozalovchi_huqna',
      '/library/glossary',
      '/library/literature/inomov2007',
      '/library/saved',
    ]) {
      expect(needsAccount(p), isTrue, reason: p);
    }
    for (final p in [
      '/home',
      '/procedures',
      '/workplace',
      '/library',
      '/library/literature',
      '/profile',
      '/profile/auth',
      '/learn/classes',
      '/learn/classes/join',
    ]) {
      expect(needsAccount(p), isFalse, reason: p);
    }
  });

  for (final path in [
    '/learn/daily',
    '/learn/toifa/test',
    '/procedures/tozalovchi_huqna',
    '/library/glossary',
  ]) {
    testWidgets('mehmon $path: ro‘yxatdan o‘tish so‘raladi', (tester) async {
      final s = await makeServices(tester, guest: true);
      await pumpApp(tester, s);
      await goTo(tester, path);
      expect(find.byKey(_gate), findsOneWidget);
      expect(find.text(uz.accountRequiredCta), findsOneWidget);
    });
  }

  testWidgets('mehmon: bosh sahifa va muolajalar ro‘yxati ochiq', (
    tester,
  ) async {
    final s = await makeServices(tester, guest: true);
    await pumpApp(tester, s);
    for (final path in ['/home', '/procedures', '/library']) {
      await goTo(tester, path);
      expect(find.byKey(_gate), findsNothing, reason: path);
    }
  });

  testWidgets('kirgach dastlab so‘ralgan sahifa ochiladi', (tester) async {
    final s = await makeServices(tester, guest: true);
    await pumpApp(tester, s);
    await goTo(tester, '/learn/daily');
    expect(find.byKey(_gate), findsOneWidget);
    s.auth.debugSignIn('hamshira@example.com');
    await tester.pumpAndSettle();
    expect(routerOf(tester).state.uri.path, '/learn/daily');
    expect(find.byKey(_gate), findsNothing);
  });

  testWidgets('ro‘yxatdan o‘tgan foydalanuvchiga hammasi ochiq', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    for (final path in ['/learn', '/learn/daily', '/library/glossary']) {
      await goTo(tester, path);
      expect(find.byKey(_gate), findsNothing, reason: path);
    }
  });
}
