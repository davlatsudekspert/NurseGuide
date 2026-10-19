// Egasi admin paneli (Cloudflare): ADMIN_EMAILS + email kodi (TOTP siz),
// ko'rsatkichlar, ilova shikoyatlari, hamjamiyat shikoyatlari,
// foydalanuvchilar (rol, to'xtatish), jurnal; Aloqa va shikoyat shakli.
// Vakolat faqat soxta server (FakeAdminConsoleBackend) bergan holda.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/core/backend/admin_console.dart';
import 'package:nurseguide/core/backend/backend_models.dart';
import 'package:nurseguide/design/widgets/lg_widgets.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

const _owner = 'owner@example.org';
const _user = 'student.one@example.com';

AppLocalizations _l(AppLanguage lang) => lookupAppLocalizations(lang.locale);

Future<void> _tap(WidgetTester tester, Finder f) async {
  await tester.scrollUntilVisible(
    f,
    300,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

Future<void> _see(WidgetTester tester, Finder f) => tester.scrollUntilVisible(
  f,
  300,
  scrollable: find.byType(Scrollable).first,
);

Future<AppServices> _setup(
  WidgetTester tester,
  FakeAdminConsoleBackend server, {
  AppLanguage language = AppLanguage.uz,
  Size size = const Size(390, 844),
  double textScale = 1,
}) async {
  final s = await makeServices(
    guest: true,
    tester,
    language: language,
    backend: server,
  );
  await pumpApp(tester, s, size: size, textScale: textScale);
  return s;
}

Future<void> _signIn(WidgetTester tester, AppServices s, String email) async {
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
  await s.refreshAccess();
  await tester.pumpAndSettle();
}

/// Oddiy foydalanuvchi ro'yxatdan o'tgan va bitta shikoyat yuborgan.
Future<FakeAdminConsoleBackend> _seeded() async {
  final server = FakeAdminConsoleBackend(adminEmails: const {_owner});
  await server.requestCode(_user);
  await server.verifyCode(_user, FakeBackend.otpCode);
  await server.submitComplaint(
    kind: ComplaintKind.inappropriate,
    body: 'Savolda haqoratli so‘zlar bor',
    targetRef: 'community:question:q1',
  );
  await server.signOut();
  return server;
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('holatlar: yuklanmoqda → xato (qayta urinish) → bo‘sh', (
    tester,
  ) async {
    final l = _l(AppLanguage.uz);
    final server = FakeAdminConsoleBackend(adminEmails: const {_owner});
    final s = await _setup(tester, server);
    await _signIn(tester, s, _owner);
    server.hold = Completer<void>();
    routerOf(tester).go('/profile/admin/complaints');
    await tester.pump();
    await tester.pump();
    // Sarlavhasiz yuklanish — spinner emas, kontur (skeleton).
    expect(find.byType(LgSkeleton), findsWidgets);
    server.failNext = const BackendException(BackendFailure.network);
    server.hold!.complete();
    server.hold = null;
    await tester.pumpAndSettle();
    expect(find.text(l.errNetwork), findsOneWidget);
    await _tap(tester, find.text(l.actionRetry));
    expect(find.text(l.admComplaintsEmpty), findsOneWidget);
  });

  group('Aloqa va shikoyat: ilova ichidagi shakl', () {
    testWidgets('mehmon va hisobli yuboradi; 6-chisi — soatiga 5 ta xabari', (
      tester,
    ) async {
      final l = _l(AppLanguage.uz);
      final server = FakeAdminConsoleBackend(adminEmails: const {_owner});
      final s = await _setup(tester, server);
      await goTo(tester, '/profile/contact?ref=card:hemoglobin');
      expect(find.byKey(const ValueKey('complaint-form')), findsOneWidget);
      expect(find.text(l.complaintAnonNote), findsOneWidget);
      expect(find.text(l.complaintTarget('card:hemoglobin')), findsOneWidget);
      final field = find.descendant(
        of: find.byKey(const ValueKey('complaint-text')),
        matching: find.byType(TextField),
      );
      await _see(tester, field);
      await tester.enterText(field, 'abc');
      await _tap(tester, find.byKey(const ValueKey('complaint-send')));
      expect(find.text(l.complaintTooShort), findsOneWidget);
      expect(server.complaints, isEmpty);
      await _tap(tester, find.byKey(const ValueKey('complaint-kind-bug')));
      for (var i = 0; i < 5; i++) {
        await tester.enterText(field, 'Kalkulyator xato hisobladi $i');
        await _tap(tester, find.byKey(const ValueKey('complaint-send')));
        expect(find.text(l.complaintSent), findsOneWidget);
      }
      expect(server.complaints, hasLength(5));
      expect(server.complaints.first.anonymous, isTrue);
      expect(server.complaints.first.kind, ComplaintKind.bug);
      expect(server.complaints.first.targetRef, 'card:hemoglobin');
      await tester.enterText(field, 'Oltinchi xabar matni');
      await _tap(tester, find.byKey(const ValueKey('complaint-send')));
      expect(find.text(l.complaintRateLimited(30)), findsOneWidget);
      expect(server.complaints, hasLength(5));

      await _signIn(tester, s, _user);
      await goTo(tester, '/profile');
      await goTo(tester, '/profile/contact');
      expect(find.text(l.complaintAnonNote), findsNothing);
      await _see(tester, field);
      await tester.enterText(field, 'Hisobim bilan yuborilgan shikoyat');
      await _tap(tester, find.byKey(const ValueKey('complaint-send')));
      expect(server.complaints.first.anonymous, isFalse);
      // mailto zaxira yo'li ham joyida.
      await _see(tester, find.byKey(const ValueKey('contact-mail-report')));
    });

    testWidgets('server sozlanmagan build — faqat mailto (shakl yo‘q)', (
      tester,
    ) async {
      final s = await makeServices(guest: true, tester);
      await pumpApp(tester, s);
      await goTo(tester, '/profile/contact');
      expect(find.byKey(const ValueKey('complaint-form')), findsNothing);
      await _see(tester, find.byKey(const ValueKey('contact-mail-report')));
    });
  });

  testWidgets('320 px va 1.3x: panel ekranlari uz/ru/en da toshmaydi', (
    tester,
  ) async {
    for (final lang in AppLanguage.values) {
      final server = await _seeded();
      final s = await _setup(
        tester,
        server,
        language: lang,
        size: const Size(320, 3200),
        textScale: 1.3,
      );
      await _signIn(tester, s, _owner);
      final userId = (await server.adminAccounts(email: _user))
          .rows
          .single
          .userId;
      final complaintId = server.complaints.single.id;
      for (final route in [
        '/profile/admin',
        '/profile/admin/stats',
        '/profile/admin/complaints',
        '/profile/admin/complaints/$complaintId',
        '/profile/admin/reports',
        '/profile/admin/users',
        '/profile/admin/users/$userId',
        '/profile/admin/audit',
        '/profile/admin/inbox',
        '/profile/contact',
      ]) {
        await goTo(tester, route);
        expect(tester.takeException(), isNull, reason: '$lang $route');
      }
      await tester.pumpWidget(const SizedBox());
    }
  });
}
