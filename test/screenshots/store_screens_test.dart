// App Store skrinshotlari (o'zbekcha interfeys, haqiqiy marshrutlar va haqiqiy
// savol banki): iPhone 6.9" (1290×2796) va iPad 13" (2064×2752), har biri 7 ta.
// Faqat NG_STORE_SHOTS=1 bo'lganda ishlaydi:
//   NG_STORE_SHOTS=1 flutter test --update-goldens test/screenshots/store_screens_test.dart
// Natija: docs/store/screenshots/{iphone_6_9,ipad_13}/NN_nom.png
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

final _on = Platform.environment['NG_STORE_SHOTS'] == '1';
final _uz = lookupAppLocalizations(const Locale('uz'));

class _Device {
  const _Device(this.dir, this.logical, this.ratio, this.top, this.bottom);

  final String dir;
  final Size logical;
  final double ratio;
  final double top;
  final double bottom;
}

const _devices = [
  _Device('iphone_6_9', Size(430, 932), 3, 59, 34),
  _Device('ipad_13', Size(1032, 1376), 2, 24, 20),
];

/// (fayl nomi, marshrut, ish yo'nalishi)
const _screens = <(String, String, WorkDirection?)>[
  ('01_home', '/home', null),
  ('02_procedure_steps', '/procedures/teri_ichiga_inyeksiya', null),
  ('03_toifa_test_question', '/learn/toifa/test', null),
  ('04_oral_ticket', '/learn/toifa/oral', null),
  ('05_workplace', '/workplace', WorkDirection.nursing),
  ('06_literature', '/library/literature', null),
  ('07_teacher_results', '/learn/classes', null),
];

Future<void> _signIn(AppServices s, String email) async {
  await s.auth.signOut();
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
}

void main() {
  setUpAll(loadAppFonts);

  for (final d in _devices) {
    for (final (name, route0, direction) in _screens) {
      testWidgets('${d.dir} $name', (tester) async {
        final b = FakeBackend();
        final s = await makeServices(
          tester,
          bundle: rootBundle,
          role: name == '07_teacher_results' ? AppRole.teacher : AppRole.nurse,
          backend: b,
          language: AppLanguage.uz,
        );
        if (direction != null) await s.settings.setWorkDirection(direction);
        await pumpApp(tester, s, size: d.logical, ratio: d.ratio, notch: false);
        tester.view.padding = FakeViewPadding(
          top: d.top * d.ratio,
          bottom: d.bottom * d.ratio,
        );
        var route = route0;
        if (name == '07_teacher_results') {
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
        if (name == '03_toifa_test_question') {
          await tester.ensureVisible(
            find.byKey(const ValueKey('toifa-mode-practice')),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(const ValueKey('toifa-mode-practice')));
          await tester.pumpAndSettle();
          await tapScroll(tester, _uz.toifaDrillStart);
        }
        if (name == '04_oral_ticket') {
          const qid = 'bl-h-2-05-1';
          await goTo(tester, '/learn/toifa/oral/q/$qid');
          await tester.pumpAndSettle(const Duration(milliseconds: 300));
          await tapScroll(tester, _uz.toifaShowPlan);
        }
        await tester.runAsync(() async {
          for (final e in find.byType(Image).evaluate().toList()) {
            await precacheImage((e.widget as Image).image, e);
          }
        });
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
        await expectLater(
          find.byType(MaterialApp).first,
          matchesGoldenFile('../../docs/store/screenshots/${d.dir}/$name.png'),
        );
      }, skip: !_on);
    }
  }
}
