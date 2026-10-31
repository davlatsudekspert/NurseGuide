// NurseGuide tanishtiruv roliklari uchun HAQIQIY ilova kadrlari (uz/ru/en).
// Faqat NG_VIDEO=1 bo'lganda ishlaydi:
//   NG_VIDEO=1 flutter test --update-goldens test/video_walk/video_walk_test.dart
// Natija: /tmp/ng_video/frames/<til>/<nom>.png (1290x2796, iPhone 6.9").
import 'dart:io' show Platform;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final _on = Platform.environment['NG_VIDEO'] == '1';

Future<void> _signIn(AppServices s, String email) async {
  await s.auth.signOut();
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
}

const _screens = <(String, String, WorkDirection?)>[
  ('01_home', '/home', null),
  ('02_hub', '/learn/toifa', null),
  ('03_test_setup', '/learn/toifa/test', null),
  ('04_question', '/learn/toifa/test', null),
  ('05_answered', '/learn/toifa/test', null),
  ('06_oral_plan', '/learn/toifa/oral', null),
  ('07_procedure', '/procedures/teri_ichiga_inyeksiya', null),
  ('08_workplace', '/workplace', WorkDirection.nursing),
  ('09_sources', '/library/literature', null),
  ('10_group_results', '/learn/classes', null),
  ('11_daily', '/learn/daily', null),
  ('12_profile', '/profile', null),
];

void main() {
  setUpAll(loadAppFonts);
  for (final lang in [AppLanguage.uz, AppLanguage.ru, AppLanguage.en]) {
    final l = lookupAppLocalizations(lang.locale);
    for (final (name, route0, direction) in _screens) {
      testWidgets('${lang.name} $name', (tester) async {
        final b = FakeBackend();
        final s = await makeServices(
          tester,
          bundle: rootBundle,
          role: name == '10_group_results' ? AppRole.teacher : AppRole.nurse,
          backend: b,
          language: lang,
        );
        if (direction != null) await s.settings.setWorkDirection(direction);
        await pumpApp(
          tester,
          s,
          size: const Size(430, 932),
          ratio: 3,
          notch: false,
        );
        tester.view.padding = const FakeViewPadding(
          top: 59 * 3,
          bottom: 34 * 3,
        );
        var route = route0;
        if (name == '10_group_results') {
          // Ustoz guruhi: 5 savollik topshiriq, 3 talaba natijasi.
          await _signIn(s, 'teacher@example.com');
          await b.registerTeacher();
          final g = await b.createGroup('Hamshiralik ishi — 2-kurs');
          final qs = s.toifa.bank!.scorable
              .where((q) => q.bank == 'hamshiralik')
              .take(5)
              .toList();
          final aid = await b.createAssignment(
            groupId: g.id,
            title: 'Infeksion nazorat — nazorat testi',
            questionIds: [for (final q in qs) q.id],
            correctIndexes: [for (final q in qs) q.key.first],
            timeLimitMinutes: 20,
          );
          final answers = [for (final q in qs) q.key.first];
          final plans = <(String, String, List<int>)>[
            ('s1@example.com', 'Aziza K.', answers),
            (
              's2@example.com',
              'Dilnoza R.',
              [
                answers[0],
                answers[1],
                (answers[2] + 1) % 3,
                answers[3],
                answers[4],
              ],
            ),
            (
              's3@example.com',
              'Sardor T.',
              [
                answers[0],
                (answers[1] + 1) % 3,
                (answers[2] + 1) % 3,
                answers[3],
                -1,
              ],
            ),
          ];
          for (final (email, nick, ans) in plans) {
            await _signIn(s, email);
            await b.joinGroup(g.joinCode!, displayName: nick);
            await b.startAssignment(aid);
            await b.submitAssignment(aid, ans);
          }
          await _signIn(s, 'teacher@example.com');
          route = '/learn/classes/g/${g.id}/a/$aid';
        }
        await goTo(tester, route);
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 120)),
        );
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        if (name == '04_question' || name == '05_answered') {
          await tester.ensureVisible(
            find.byKey(const ValueKey('toifa-mode-practice')),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const ValueKey('toifa-mode-practice')));
          await tester.pumpAndSettle();
          await tapScroll(tester, l.toifaDrillStart);
          if (name == '05_answered') {
            await tester.tap(find.text('B').first);
            await tester.pumpAndSettle(const Duration(milliseconds: 300));
          }
        }
        if (name == '06_oral_plan') {
          await goTo(tester, '/learn/toifa/oral/q/bl-h-2-05-1');
          await tester.pumpAndSettle(const Duration(milliseconds: 300));
          await tapScroll(tester, l.toifaShowPlan);
        }
        await tester.runAsync(() async {
          for (final e in find.byType(Image).evaluate().toList()) {
            await precacheImage((e.widget as Image).image, e);
          }
        });
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await expectLater(
          find.byType(MaterialApp).first,
          matchesGoldenFile(
            '../../../../../tmp/ng_video/frames/${lang.name}/$name.png',
          ),
        );
      }, skip: !_on);
    }
  }
}
