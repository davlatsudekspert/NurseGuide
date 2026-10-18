// Ustoz: taqdimotdan “Guruhga topshirish” (mavjud topshiriq mexanizmi,
// soxta server bilan) — guruhlar, savollar soni, muddat, javoblar qachon
// ko'rinadi; talaba Bosh sahifada testni muddati bilan ko'radi, topshiradi;
// “muddat tugagach” — javoblar yopiq; ustoz natijasi: taqsimot va eng qiyin
// savollar (slayd havolasi bilan).
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/core/backend/backend_models.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/classroom/topic_test.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/device_fakes.dart';
import '../helpers/fixtures.dart';
import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));
const _tall = Size(390, 2400);
const _deck = 'd001';

Future<void> _signIn(WidgetTester tester, AppServices s, String email) async {
  await s.auth.signOut();
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
  await tester.pumpAndSettle();
}

Future<void> _tapKey(WidgetTester tester, String key) async {
  final f = find.byKey(ValueKey(key));
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  // E2E (docs/E2E_CLASSROOM_2026-10-18.md): deckdan berilgan testni ustoz
  // topshiriq sahifasidan yakunlay olmasdi; boshlamagan talabaga yakunlangan
  // test “Boshlash” bilan ko'rinardi; qurilma soati oldinda bo'lsa javoblar
  // server yopiq desa ham lokal kalitdan ochilardi.
  testWidgets('ustoz testni yakunlaydi; yakunlangan test va javoblar holati', (
    tester,
  ) async {
    installDeviceFakes();
    final b = FakeBackend();
    final s = await makeServices(tester, backend: b, role: AppRole.teacher);
    await pumpApp(tester, s, size: _tall);
    await _signIn(tester, s, 'teacher@example.com');
    await b.registerTeacher();
    final g = await b.createGroup('Hamshiralik A');
    final c = (await tester.runAsync(() => DeckCatalog.load(testBundle)))!;
    final pool = deckQuestionPool(
      c.byId(_deck)!,
      s.curriculum.curriculum,
      s.content.pack,
      s.toifa.bank,
    ).take(3).toList();
    final due = b.groupClock().add(const Duration(days: 3));
    final aid = await b.createAssignment(
      groupId: g.id,
      title: 'Mavzu testi',
      questionIds: [for (final q in pool) q.id],
      correctIndexes: [for (final q in pool) q.correct.single],
      dueAt: due,
      dayId: 't001-L',
      deckId: _deck,
      revealAfterDue: true,
    );
    await _signIn(tester, s, 'late@example.com');
    await b.joinGroup(g.joinCode!);
    await _signIn(tester, s, 'student@example.com');
    await b.joinGroup(g.joinCode!);
    await b.startAssignment(aid);
    await b.submitAssignment(aid, [for (final q in pool) q.correct.single]);
    final page = '/learn/classes/g/${g.id}/a/$aid';
    final later0 = uz.topicTestAnswersLater('#').split('(').first.trim();

    // Qurilma soati muddatdan o'tgan, server esa hali yopiq (correct: null)
    // — javoblar ochilmaydi.
    final realNow = s.exams.now;
    s.exams.now = () => due.add(const Duration(hours: 1));
    await goTo(tester, page);
    expect(find.textContaining(later0), findsOneWidget);
    expect(find.text(uz.examAnalysis), findsNothing);
    s.exams.now = realNow;

    // Ustoz: “Testni yakunlash” (tasdiq bilan).
    await _signIn(tester, s, 'teacher@example.com');
    await goTo(tester, page);
    expect(find.byKey(const ValueKey('assignment-closed')), findsNothing);
    await _tapKey(tester, 'assignment-close');
    expect(find.text(uz.classroomTestFinishTitle), findsOneWidget);
    await tester.tap(find.text(uz.classroomTestFinish).hitTestable().last);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('assignment-closed')), findsOneWidget);
    expect(find.byKey(const ValueKey('assignment-close')), findsNothing);
    expect((await b.assignments(g.id)).single.closed, isTrue);

    // Boshlamagan talaba: “Test yakunlandi”, “Boshlash” yo'q; ro'yxatda ham.
    await _signIn(tester, s, 'late@example.com');
    await goTo(tester, page);
    expect(find.byKey(const ValueKey('assignment-closed')), findsOneWidget);
    expect(find.text(uz.classesStart), findsNothing);
    await expectLater(b.startAssignment(aid), throwsA(isA<BackendException>()));
    await goTo(tester, '/learn/classes/g/${g.id}');
    expect(find.text(uz.classroomStatusTestDone), findsOneWidget);
    expect(find.text(uz.classesStatusNew), findsNothing);

    // Topshirgan talaba: yakunlangach javoblar tahlili ochiq.
    await _signIn(tester, s, 'student@example.com');
    await goTo(tester, page);
    expect(find.text(uz.examAnalysis), findsOneWidget);
    expect(find.textContaining(later0), findsNothing);
  });

  testWidgets('guruh yo‘q — guruh ochish taklifi', (tester) async {
    installDeviceFakes();
    final b = FakeBackend();
    final s = await makeServices(tester, backend: b, role: AppRole.teacher);
    await pumpApp(tester, s, size: _tall);
    await _signIn(tester, s, 'teacher@example.com');
    await goTo(tester, '/learn/lecture/test/$_deck/assign');
    expect(find.text(uz.topicTestNoGroups), findsOneWidget);
    expect(find.text(uz.topicTestCreateGroup), findsOneWidget);
  });
}
