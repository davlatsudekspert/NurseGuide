import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/core/backend/backend_models.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

const _tall = Size(390, 1600);

/// Internet uzilishini taqlid qiladi (javob yuborishda).
class _FlakyBackend extends FakeBackend {
  bool offline = false;

  @override
  Future<GroupSubmission> submitAssignment(
    String assignmentId,
    List<int> answers, {
    List<String>? questionIds,
  }) async {
    if (offline) throw const BackendException(BackendFailure.network);
    return super.submitAssignment(
      assignmentId,
      answers,
      questionIds: questionIds,
    );
  }
}

Future<void> _signIn(WidgetTester tester, AppServices s, String email) async {
  await s.auth.signOut();
  await s.auth.requestCode(email);
  await s.auth.verifyCode(FakeBackend.otpCode);
  await tester.pumpAndSettle();
}

Future<void> _finish(WidgetTester tester, AppLocalizations l) async {
  await tapScroll(tester, l.examFinish);
  await tester.tap(find.text(l.examFinish).hitTestable().last);
  await tester.pumpAndSettle();
}

/// Ustoz guruh va topshiriqni server orqali tayyorlaydi.
Future<({String gid, String aid, String code})> _prepare(
  WidgetTester tester,
  AppServices s,
  FakeBackend b, {
  int? minutes,
  DateTime? due,
}) async {
  await _signIn(tester, s, 'teacher@example.com');
  await b.registerTeacher();
  final g = await b.createGroup('Anatomiya');
  final qs = s.content.pack!.quiz.take(3).toList();
  final aid = await b.createAssignment(
    groupId: g.id,
    title: 'Topshiriq 1',
    questionIds: [for (final q in qs) q.id],
    correctIndexes: [for (final q in qs) q.correctIndex],
    timeLimitMinutes: minutes,
    dueAt: due,
  );
  return (gid: g.id, aid: aid, code: g.joinCode!);
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('hisobsiz: kirish taklifi; guruh amallari ko‘rsatilmaydi', (
    tester,
  ) async {
    final s = await makeServices(guest: true, tester, backend: FakeBackend());
    await pumpApp(tester, s);
    await goTo(tester, '/learn/classes');
    expect(find.text(uz.classesSignInTitle), findsOneWidget);
    expect(find.text(uz.classesCreate), findsNothing);
    await goTo(tester, '/learn/classes/join');
    expect(find.text(uz.classesJoinSignInTitle), findsOneWidget);
    expect(find.text(uz.classesJoinAction), findsNothing);
  });

  testWidgets('internet yo‘q: javoblar qurilmada, keyin qayta yuboriladi', (
    tester,
  ) async {
    final b = _FlakyBackend();
    final s = await makeServices(guest: true, tester, backend: b);
    await pumpApp(tester, s, size: _tall);
    final t = await _prepare(tester, s, b, minutes: 15);
    await _signIn(tester, s, 'student@example.com');
    await b.joinGroup(t.code, displayName: 'Talaba');
    await goTo(tester, '/learn/classes/g/${t.gid}/a/${t.aid}');
    await tapScroll(tester, uz.classesStart);
    final run = s.exams.assignmentSession(t.aid, b.userId)!;
    await answerCurrent(tester, s, run, correct: true);
    b.offline = true;
    await _finish(tester, uz);
    expect(find.text(uz.classesPendingTitle), findsOneWidget);
    expect(s.exams.assignmentSession(t.aid, b.userId)!.finished, isTrue);
    expect(await b.submissions(t.aid), isEmpty);

    b.offline = false;
    await tapScroll(tester, uz.classesResend);
    expect(find.text(uz.classesServerScore), findsOneWidget);
    expect((await b.submissions(t.aid)).single.score, 1);
  });

  testWidgets('vaqt tugasa javoblar o‘zi yuboriladi', (tester) async {
    final b = FakeBackend();
    final s = await makeServices(guest: true, tester, backend: b);
    var now = DateTime.utc(2026, 10, 9, 9);
    s.exams.now = () => now;
    b.groupClock = () => now;
    await pumpApp(tester, s, size: _tall);
    final t = await _prepare(tester, s, b, minutes: 5);
    await _signIn(tester, s, 'student@example.com');
    await b.joinGroup(t.code, displayName: 'Talaba');
    await goTo(tester, '/learn/classes/g/${t.gid}/a/${t.aid}');
    await tapScroll(tester, uz.classesStart);
    final run = s.exams.assignmentSession(t.aid, b.userId)!;
    await answerCurrent(tester, s, run, correct: true);
    now = now.add(const Duration(minutes: 5, seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    final sub = (await b.submissions(t.aid)).single;
    expect((sub.score, sub.total), (1, 3));
    expect(find.text(uz.classesServerScore), findsOneWidget);
  });

  testWidgets('muddat o‘tgan topshiriq boshlanmaydi', (tester) async {
    final b = FakeBackend();
    final s = await makeServices(guest: true, tester, backend: b);
    var now = DateTime.now().toUtc();
    s.exams.now = () => now;
    b.groupClock = () => now;
    await pumpApp(tester, s, size: _tall);
    final t = await _prepare(
      tester,
      s,
      b,
      due: now.add(const Duration(hours: 1)),
    );
    await _signIn(tester, s, 'student@example.com');
    await b.joinGroup(t.code, displayName: 'Talaba');
    now = now.add(const Duration(hours: 2));
    await goTo(tester, '/learn/classes/g/${t.gid}');
    expect(find.text(uz.classesStatusOverdue), findsOneWidget);
    await goTo(tester, '/learn/classes/g/${t.gid}/a/${t.aid}');
    expect(find.text(uz.classesOverdueTitle), findsOneWidget);
    expect(find.text(uz.classesStart), findsNothing);
  });

  testWidgets('ustoz talabani chiqaradi; talaba guruhdan chiqadi', (
    tester,
  ) async {
    final b = FakeBackend();
    final s = await makeServices(guest: true, tester, backend: b);
    await pumpApp(tester, s, size: _tall);
    final t = await _prepare(tester, s, b);
    for (final (email, name) in [
      ('s1@example.com', 'Birinchi T.'),
      ('s2@example.com', 'Ikkinchi T.'),
    ]) {
      await _signIn(tester, s, email);
      await b.joinGroup(t.code, displayName: name);
    }
    // Ikkinchi talaba o'zi chiqadi.
    await goTo(tester, '/learn/classes/g/${t.gid}');
    await tapScroll(tester, uz.classesLeave);
    await tester.tap(find.text(uz.classesLeaveAction).last);
    await tester.pumpAndSettle();
    expect(await b.myGroups(), isEmpty);

    await _signIn(tester, s, 'teacher@example.com');
    await goTo(tester, '/learn/classes/g/${t.gid}');
    expect(find.text('Birinchi T.'), findsOneWidget);
    expect(find.text('Ikkinchi T.'), findsNothing);
    await tester.tap(find.byTooltip(uz.classesRemove));
    await tester.pumpAndSettle();
    expect(find.text(uz.classesRemoveTitle('Birinchi T.')), findsOneWidget);
    await tester.tap(find.text(uz.classesRemoveAction).last);
    await tester.pumpAndSettle();
    expect(find.text('Birinchi T.'), findsNothing);
    expect(find.text(uz.classesNoStudents), findsOneWidget);
  });

  // Guruh ekranlari (ma'lumot bilan) — tor ekran/katta shrift/qorong'i.
  for (final lang in AppLanguage.values) {
    for (final (width, scale, theme) in [
      (320.0, 2.0, ThemeMode.light),
      (390.0, 1.0, ThemeMode.dark),
      (430.0, 1.35, ThemeMode.light),
    ]) {
      testWidgets('classes layout: ${lang.name} ${width.toInt()} ×$scale '
          '${theme.name}', (tester) async {
        final b = FakeBackend();
        final s = await makeServices(
          guest: true,
          tester,
          backend: b,
          language: lang,
          themeMode: theme,
        );
        await pumpApp(tester, s, size: Size(width, 3200), textScale: scale);
        final t = await _prepare(
          tester,
          s,
          b,
          minutes: 20,
          due: DateTime.now().add(const Duration(days: 3)),
        );
        final key = [
          for (final id in (await b.assignments(t.gid)).single.questionIds)
            s.content.pack!.quiz.firstWhere((q) => q.id == id).correctIndex,
        ];
        await _signIn(tester, s, 'student@example.com');
        await b.joinGroup(t.code, displayName: 'Aliyev Anvar Akmalovich');
        await b.startAssignment(t.aid);
        await b.submitAssignment(t.aid, [key[0], -1, (key[2] + 1) % 3]);
        final student = b.userId!;
        Future<void> visit(List<String> routes) async {
          for (final r in routes) {
            await goTo(tester, r);
            expect(tester.takeException(), isNull, reason: r);
          }
        }

        await visit([
          '/learn/classes',
          '/learn/classes/join',
          '/learn/classes/g/${t.gid}',
          '/learn/classes/g/${t.gid}/a/${t.aid}',
        ]);
        await _signIn(tester, s, 'teacher@example.com');
        await visit([
          '/learn/classes',
          '/learn/classes/new',
          '/learn/classes/g/${t.gid}',
          '/learn/classes/g/${t.gid}/assign',
          '/learn/classes/g/${t.gid}/a/${t.aid}',
          '/learn/classes/g/${t.gid}/a/${t.aid}/s/$student',
        ]);
      });
    }
  }
}
