// Foydalanuvchi sifatida yurib chiqish (faqat NG_WALK=1): haqiqiy kontent
// bilan asosiy bo'limlar va obuna holatlari rasmga olinadi.
//   NG_WALK=1 flutter test --update-goldens test/audit/user_walk_test.dart
// Natija: /tmp/ng_walk/<senariy>/<nom>.png
import 'dart:io' show Platform;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/features/billing/billing_plan.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final _on = Platform.environment['NG_WALK'] == '1';

String _slug(String r) => r.replaceAll(RegExp('[^a-zA-Z0-9]+'), '_');

Future<void> _shot(WidgetTester tester, String dir, String name) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 60)),
  );
  await tester.pumpAndSettle(const Duration(milliseconds: 300));
  await expectLater(
    find.byType(MaterialApp).first,
    matchesGoldenFile('../../../../../tmp/ng_walk/$dir/$name.png'),
  );
}

const _sections = <String>[
  '/home',
  '/procedures',
  '/procedures/teri_ichiga_inyeksiya',
  '/workplace',
  '/library',
  '/library/glossary',
  '/library/dmed',
  '/library/literature',
  '/learn',
  '/learn/daily',
  '/learn/toifa',
  '/learn/toifa/test',
  '/learn/toifa/practice',
  '/learn/toifa/oral',
  '/learn/toifa/oral/q/bl-h-1-01-4',
  '/learn/exam',
  '/learn/classes',
  '/profile',
  '/profile/role',
  '/profile/privacy',
  '/terms',
];

void main() {
  setUpAll(loadAppFonts);

  for (final lang in [AppLanguage.uz, AppLanguage.ru, AppLanguage.en]) {
    testWidgets('bo‘limlar ${lang.name}', (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        language: lang,
      );
      await pumpApp(tester, s, size: const Size(390, 844));
      for (final r in _sections) {
        await goTo(tester, r);
        await _shot(tester, 'sections_${lang.name}', _slug(r));
      }
    }, skip: !_on);
  }

  testWidgets('obuna: bepul foydalanuvchi', (tester) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
      billingEnabled: true,
    );
    await pumpApp(tester, s, size: const Size(390, 844));
    await goTo(tester, '/home');
    await _shot(tester, 'billing', '1_home_free');
    await goTo(tester, '/learn/toifa/test');
    await _shot(tester, 'billing', '2_paywall_redirect');
    await goTo(tester, '/library/dmed');
    await _shot(tester, 'billing', '3_dmed_paywall');
    await goTo(tester, '/learn/daily');
    await _shot(tester, 'billing', '4_daily_free_open');
    await goTo(tester, '/profile');
    await _shot(tester, 'billing', '5_profile_subscription_row');
    await goTo(tester, '/profile/role');
    await _shot(tester, 'billing', '6_role_teacher_locked');
    await goTo(tester, '/learn/classes/join');
    await _shot(tester, 'billing', '7_class_join_free_for_students');
  }, skip: !_on);

  testWidgets('obuna: sinov va Pro', (tester) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
      billingEnabled: true,
    );
    await pumpApp(tester, s, size: const Size(390, 844));
    s.billing.applyTrial(DateTime.now().add(const Duration(days: 21)));
    await goTo(tester, '/learn/toifa/test');
    await _shot(tester, 'billing_trial', '1_test_open_in_trial');
    await goTo(tester, '/library/dmed');
    await _shot(tester, 'billing_trial', '2_dmed_open_in_trial');
    await goTo(tester, '/learn/classes/new');
    await _shot(tester, 'billing_trial', '3_teacher_page_paywall_in_trial');
    s.billing.applyGrant('specialist', null);
    await goTo(tester, '/learn/classes/new');
    await _shot(tester, 'billing_trial', '4_teacher_page_with_pro');
    expect(s.billing.tier, BillingTier.specialist);
  }, skip: !_on);

  for (final tier in ['student', 'teacher', 'specialist']) {
    testWidgets('obuna: $tier tarifi', (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        billingEnabled: true,
      );
      await pumpApp(tester, s, size: const Size(390, 844));
      s.billing.applyGrant(tier, null);
      await goTo(tester, '/profile');
      await _shot(tester, 'tier_$tier', '1_profile');
      await goTo(tester, '/learn/toifa/test');
      await _shot(tester, 'tier_$tier', '2_toifa_test');
      await goTo(tester, '/library/dmed');
      await _shot(tester, 'tier_$tier', '3_dmed');
      await goTo(tester, '/learn/classes/new');
      await _shot(tester, 'tier_$tier', '4_teacher_page');
    }, skip: !_on);
  }
}
