// Topshiriq vaqti (3-xato): "daqiqa" (har talabaga vaqt chegarasi) va
// "necha kun ochiq" (muddat) — ikkita ALOHIDA maydon; sarlavha ≤ 120 belgi.
import 'package:material_ui/material_ui.dart' show SwitchListTile;
import 'package:flutter/widgets.dart' show Size, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/classroom/topic_questions.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/device_fakes.dart';
import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

const _tall = Size(390, 2600);

Future<void> _tapKey(WidgetTester tester, String key) async {
  final f = find.byKey(ValueKey(key));
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  test('sarlavha serverga sig‘adi: ≤ 120 belgi, “…” bilan qisqartiriladi', () {
    expect(kAssignmentTitleMax, 120);
    final long = 'A' * 300;
    final t = fitAssignmentTitle(long);
    expect(t.length, lessThanOrEqualTo(120));
    expect(t.endsWith('…'), isTrue);
    expect(fitAssignmentTitle('  Qisqa nom  '), 'Qisqa nom');
    expect(fitAssignmentTitle('B' * 120), 'B' * 120);
  });

  testWidgets('daqiqa va kun alohida: 7 daqiqa + 3 kun; vaqtsiz + 1 kun', (
    tester,
  ) async {
    installDeviceFakes();
    final b = FakeBackend();
    final s = await makeServices(tester, backend: b, role: AppRole.teacher);
    await pumpApp(tester, s, size: _tall);
    await s.auth.requestCode('teacher@example.com');
    await s.auth.verifyCode(FakeBackend.otpCode);
    await b.registerTeacher();
    final g = await b.createGroup('Guruh');

    Future<void> send() async {
      // Har safar yangi sahifa: bitta guruh avtomatik tanlanadi.
      await goTo(tester, '/home');
      await goTo(tester, '/learn/lecture/test/d001/assign');
      await tapScroll(tester, '5');
      final variant = find.byKey(const ValueKey('assign-variant'));
      if (tester.widget<SwitchListTile>(variant).value) {
        await _tapKey(tester, 'assign-variant');
      }
    }

    // 1) 7 daqiqa (kun tanlanmaydi — muddatsiz).
    await send();
    expect(find.byKey(const ValueKey('assign-limit-7')), findsNothing);
    await _tapKey(tester, 'assign-limit-10');
    await _tapKey(tester, 'assign-due-none');
    // Variantli rejim bu testga kerak emas.
    await _tapKey(tester, 'assign-send');
    var list = await b.assignments(g.id);
    expect(list, hasLength(1));
    expect(list.first.timeLimitMinutes, 10);
    expect(list.first.dueAt, isNull, reason: 'daqiqa tanlandi — muddat yo‘q');

    // 2) vaqtsiz + 3 kun ochiq.
    await send();
    await _tapKey(tester, 'assign-limit-none');
    await _tapKey(tester, 'assign-due-d3');
    await _tapKey(tester, 'assign-send');
    list = await b.assignments(g.id);
    expect(list, hasLength(2));
    final second = list.firstWhere((a) => a.timeLimitMinutes == null);
    expect(second.dueAt, isNotNull);
    final days = second.dueAt!.difference(DateTime.now()).inHours;
    expect(days, inInclusiveRange(48, 97), reason: '3 kun (kun oxirigacha)');

    // 3) ikkalasi birga.
    await send();
    await _tapKey(tester, 'assign-limit-10');
    await _tapKey(tester, 'assign-due-d1');
    await _tapKey(tester, 'assign-send');
    list = await b.assignments(g.id);
    final both = list.firstWhere(
      (a) => a.timeLimitMinutes == 10 && a.dueAt != null,
    );
    expect(
      both.dueAt!.difference(DateTime.now()).inHours,
      inInclusiveRange(1, 49),
    );

    // Sarlavha 120 dan oshmaydi.
    for (final a in list) {
      expect(a.title.length, lessThanOrEqualTo(120));
    }
  });
}
