import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/contact.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

/// “Aloqa va shikoyat” ekrani: serversiz ochiladi, manzil bitta
/// konstantadan, nusxalash, mailto havolalari, tor ekran/katta shrift.

const _urlChannel = MethodChannel('plugins.flutter.io/url_launcher');

/// Soxta clipboard va url_launcher kanali. [launchResult] — `launch`
/// javobi (false → pochta ilovasi yo'q; null → platforma xatosi).
class _Fakes {
  _Fakes(WidgetTester tester, {bool? launchResult = true}) {
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        clip = (call.arguments as Map)['text'] as String?;
      }
      return null;
    });
    messenger.setMockMethodCallHandler(_urlChannel, (call) async {
      if (call.method == 'launch') {
        launched.add((call.arguments as Map)['url'] as String);
        if (launchResult == null) {
          throw PlatformException(code: 'ACTIVITY_NOT_FOUND');
        }
        return launchResult;
      }
      return false;
    });
    addTearDown(() {
      messenger.setMockMethodCallHandler(SystemChannels.platform, null);
      messenger.setMockMethodCallHandler(_urlChannel, null);
    });
  }

  String? clip;
  final launched = <String>[];
}

Future<void> _openContact(
  WidgetTester tester, {
  AppLanguage lang = AppLanguage.uz,
  Size size = const Size(390, 3200),
  double textScale = 1,
  FakeBackend? backend,
}) async {
  final s = await makeServices(tester, language: lang, backend: backend);
  await pumpApp(tester, s, size: size, textScale: textScale);
  await goTo(tester, '/profile/contact');
}

AppLocalizations _l(WidgetTester tester) =>
    AppLocalizations.of(tester.element(find.byType(Scaffold).last));

void main() {
  setUpAll(loadAppFonts);

  group('Contact.mailto', () {
    test('subject and body are percent-encoded (no "+")', () {
      final u = Contact.mailto(
        subject: Contact.subjectQuestion,
        body: 'Salom\nIlova: NurseGuide 0.1.0',
      );
      expect(u.scheme, 'mailto');
      expect(u.path, Contact.email);
      final raw = u.toString();
      expect(
        raw,
        startsWith('mailto:${Contact.email}?subject=NurseGuide%3A%20savol'),
      );
      expect(raw, isNot(contains('+')));
      expect(raw, contains('%0A'));
      expect(u.queryParameters['subject'], 'NurseGuide: savol/taklif');
      expect(u.queryParameters['body'], 'Salom\nIlova: NurseGuide 0.1.0');
    });
  });

  testWidgets('reachable from Profile without a server', (tester) async {
    _Fakes(tester);
    final s = await makeServices(tester, language: AppLanguage.en);
    await pumpApp(tester, s, size: const Size(390, 3200));
    await goTo(tester, '/profile');
    final l = _l(tester);
    expect(s.backend.isConfigured, isFalse);
    // D-68 Q6: Profil → “Yordam va aloqa” → email/shikoyat.
    expect(find.text(l.contactRowTitle), findsNothing);
    await tester.tap(find.text(l.helpTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l.contactRowTitle));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('contact-email')), findsOneWidget);
  });

  // Audit 2026-10-18 (tablar): ro'yxatdan o'tishda "shartlar va maxfiylik
  // siyosatini qabul qilaman" belgisi bor, lekin "Foydalanish shartlari" va
  // Profil → "Maxfiylik va ma'lumotlar" sahifalarida siyosatning o'ziga
  // havola yo'q edi (faqat "Aloqa" ichida).
  for (final (route, key) in [
    ('/profile/privacy', 'privacy-policy-link'),
    ('/terms', 'terms-privacy-link'),
  ]) {
    testWidgets('audit: $route links to the privacy policy', (tester) async {
      final fakes = _Fakes(tester);
      final s = await makeServices(tester, language: AppLanguage.ru);
      await pumpApp(tester, s, size: const Size(360, 640), textScale: 1.3);
      await goTo(tester, route);
      final row = find.byKey(ValueKey(key));
      await tester.scrollUntilVisible(row, 200);
      await tester.pumpAndSettle();
      expect(find.text(_l(tester).contactPrivacyPolicy), findsOneWidget);
      await tester.tap(row);
      await tester.pumpAndSettle();
      expect(fakes.launched, [Contact.privacyPolicyUrl]);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('copy button puts the email on the clipboard', (tester) async {
    final f = _Fakes(tester);
    await _openContact(tester);
    await tester.tap(find.byKey(const ValueKey('contact-copy')));
    await tester.pumpAndSettle();
    expect(f.clip, Contact.email);
    expect(find.text(_l(tester).contactCopied), findsOneWidget);
  });

  for (final result in [false, null]) {
    testWidgets('no mail app (${result ?? 'platform error'}) → copies', (
      tester,
    ) async {
      final f = _Fakes(tester, launchResult: result);
      await _openContact(tester);
      await tester.tap(find.byKey(const ValueKey('contact-mail-question')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(f.clip, Contact.email);
      expect(find.text(_l(tester).contactNoMailApp), findsOneWidget);
    });
  }

  testWidgets('store build: no partner form link even with a server', (
    tester,
  ) async {
    _Fakes(tester);
    await _openContact(tester, backend: FakeBackend());
    expect(find.byKey(const ValueKey('contact-partner-link')), findsNothing);
  });
}
