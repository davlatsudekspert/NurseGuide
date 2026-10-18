// Ilova konfiguratsiyasi: domen, manzillar, paket nomi, sessiya kaliti, env
// nomlari (LG_*) — native va server tomoni bilan kelishilgan qiymatlar.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/backend/cloudflare_backend.dart';
import 'package:nurseguide/core/contact.dart';
import 'package:nurseguide/features/classroom/invite_link.dart';

void main() {
  test('aloqa va havolalar', () {
    expect(Contact.email, 'nurseguide@nfcstore.uz');
    expect(Contact.privacyPolicyUrl, 'https://nurseguide.nfcstore.uz/privacy/');
    expect(Contact.termsUrl, 'https://nurseguide.nfcstore.uz/terms/');
    expect(inviteHost, 'nurseguide.nfcstore.uz');
    expect(
      Contact.mailto(subject: Contact.subjectQuestion).toString(),
      startsWith('mailto:nurseguide@nfcstore.uz?subject='),
    );
  });

  test('API: standart manzil sozlangan, LG_API_URL nomi saqlangan', () {
    expect(
      ApiConfig.defaultUrl,
      'https://nurseguide-api.davlatsudekspert.workers.dev',
    );
    expect(ApiConfig.fromEnvironment.isConfigured, isTrue);
    expect(
      ApiConfig.fromEnvironment.resolve('/v1/health').toString(),
      endsWith('/v1/health'),
    );
    expect(const ApiConfig(url: '').isConfigured, isFalse);
    expect(const ApiConfig(url: 'http://x.uz').isConfigured, isFalse);
    final src = File('lib/core/backend/cloudflare_backend.dart')
        .readAsStringSync();
    expect(src, contains("String.fromEnvironment('LG_API_URL'"));
  });

  test('sessiya kaliti, Android paketi, bildirishnoma ikonkasi', () {
    expect(
      File('lib/core/backend/cloudflare_backend.dart').readAsStringSync(),
      contains("'nurseguide.api.session'"),
    );
    expect(
      File('lib/features/classroom/qr_scanner.dart').readAsStringSync(),
      contains("'uz.nurseguide.app'"),
    );
    expect(
      File('lib/features/daily/daily_reminder.dart').readAsStringSync(),
      contains('@drawable/ic_stat_notification'),
    );
  });

  test('taklif havolasi sxemasi: nurseguide://app/j', () {
    final router = File('lib/app/router.dart').readAsStringSync();
    expect(router, contains('nurseguide://app/j'));
    expect(
      File('lib/features/classroom/invite_link.dart').readAsStringSync(),
      contains('nurseguide://app/j'),
    );
  });

  test('o‘chirilgan konfiguratsiyalar qaytmagan: Supabase, hamkor reklamasi, mikrofon kanali', () {
    final bad = <String>[];
    for (final f in Directory(
      'lib',
    ).listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart') || f.path.contains('/l10n/gen/')) continue;
      final t = f.readAsStringSync();
      for (final w in [
        'LG_SUPABASE',
        'LG_PARTNER_ADS',
        '/speech',
        'supabase',
      ]) {
        if (t.contains(w)) bad.add('$w ${f.path}');
      }
    }
    expect(bad, isEmpty, reason: bad.join('\n'));
    expect(
      File('pubspec.yaml').readAsStringSync().contains('supabase'),
      isFalse,
    );
  });

  test('hisobni o‘chirish yo‘li: Profil → Maxfiylik va ma’lumotlar → Hisobni o‘chirish', () {
    final profile = File('lib/features/profile/profile_screens.dart')
        .readAsStringSync();
    expect(profile, contains("'/profile/privacy'"));
    expect(profile, contains('class PrivacyScreen'));
    expect(profile, contains('_confirmDeleteAccount'));
    expect(profile, contains('accountDeleteTitle'));
  });
}
