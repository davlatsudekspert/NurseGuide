import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/learn/exam_session.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final uz = lookupAppLocalizations(const Locale('uz'));
final en = lookupAppLocalizations(const Locale('en'));

const _tall = Size(390, 1400);

/// Imtihonni UI orqali boshlash: mavzu (bo'lsa), soni va daqiqasi.
Future<ExamSession> _startExam(
  WidgetTester tester,
  AppServices s,
  AppLocalizations l, {
  String? topic,
  required int count,
  required int minutes,
}) async {
  await goTo(tester, '/learn/exam');
  if (topic != null) await tapScroll(tester, topic);
  await enterField(tester, l.examCount, '$count');
  await enterField(tester, l.examTime, '$minutes');
  await tapScroll(tester, l.examStart);
  return s.exams.active!;
}

Future<void> _finishViaDialog(WidgetTester tester, AppLocalizations l) async {
  await tapScroll(tester, l.examFinish);
  await tester.tap(find.text(l.examFinish).hitTestable().last);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('vaqt tugasa imtihon o‘zi yakunlanadi', (tester) async {
    final s = await makeServices(tester);
    var now = DateTime(2026, 10, 9, 9);
    s.exams.now = () => now;
    await pumpApp(tester, s, size: _tall);
    final exam = await _startExam(tester, s, uz, count: 4, minutes: 5);
    await answerCurrent(tester, s, exam, correct: true);
    expect(find.text('5:00'.padLeft(5, '0')), findsOneWidget);

    now = now.add(const Duration(minutes: 4, seconds: 30));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:30'), findsOneWidget);

    now = now.add(const Duration(minutes: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(uz.examTimedOut), findsOneWidget);
    final done = s.exams.history.single;
    expect(done.timedOut, isTrue);
    expect(done.finishedAt, exam.deadline);
    expect(done.correctCount, 1);
  });

  testWidgets('ilova qayta ochilsa — imtihon davom etadi yoki halol yakun', (
    tester,
  ) async {
    final store = MemoryKeyValueStore();
    final start = DateTime(2026, 10, 9, 9);
    var s = await makeServices(tester, store: store, language: AppLanguage.en);
    s.exams.now = () => start;
    await pumpApp(tester, s, size: _tall);
    final exam = await _startExam(tester, s, en, count: 5, minutes: 20);
    await answerCurrent(tester, s, exam, correct: true, lang: 'en');
    await tapScroll(tester, en.examNext);
    final firstAnswer = exam.answerAt(0);

    // Tizim ilovani yopdi; 5 daqiqadan keyin qayta ochildi.
    await tester.pumpWidget(const SizedBox());
    s = await makeServices(tester, store: store, language: AppLanguage.en);
    s.exams.now = () => start.add(const Duration(minutes: 5));
    await pumpApp(tester, s, size: _tall);
    await goTo(tester, '/learn');
    await tester.scrollUntilVisible(
      find.text(en.examActiveBody(1, 5, '15:00')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(en.examActiveBody(1, 5, '15:00')), findsOneWidget);
    await goTo(tester, '/learn/exam');
    expect(find.text(en.examActiveTitle.toUpperCase()), findsOneWidget);
    await tapScroll(tester, en.examResume);
    final resumed = s.exams.active!;
    expect(resumed.index, 1);
    expect(resumed.answerAt(0), firstAnswer);
    expect(find.text('15:00'), findsOneWidget);
    expect(find.text(en.examAnsweredOf(1, 5)), findsWidgets);

    // Yana yopildi va vaqt tugagach ochildi: halol “vaqt tugadi”.
    await tester.pumpWidget(const SizedBox());
    s = await makeServices(tester, store: store, language: AppLanguage.en);
    s.exams.now = () => start.add(const Duration(hours: 2));
    await pumpApp(tester, s, size: _tall);
    await goTo(tester, '/learn/exam');
    await tester.pumpAndSettle();
    expect(find.text(en.examSettled), findsOneWidget);
    expect(s.exams.active, isNull);
    final done = s.exams.history.single;
    expect(done.timedOut, isTrue);
    expect(done.spent(start), const Duration(minutes: 20));
    await tester.tap(find.text(en.examOpenResult));
    await tester.pumpAndSettle();
    expect(find.text(en.examTimedOut), findsOneWidget);
    expect(find.text(en.quizScore(1, 5)), findsOneWidget);
  });

  testWidgets('ochiq imtihon sahifasi tizim tiklashidan keyin qaytadi', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s, size: _tall);
    final exam = await _startExam(tester, s, uz, count: 3, minutes: 10);
    await answerCurrent(tester, s, exam, correct: false);
    await tester.restartAndRestore();
    await tester.pumpAndSettle();
    expect(find.text(uz.examAnsweredOf(1, 3)), findsOneWidget);
    expect(find.text(uz.examPrev), findsOneWidget);
  });

  testWidgets('imtihon ekranlari: bosiladigan maydonlar ≥ 44 px', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    await _startExam(tester, s, uz, count: 3, minutes: 10);
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await _finishViaDialog(tester, uz);
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  });

  // Imtihon ekranlari (faol imtihon va natija bilan) — tor ekran, katta
  // shrift, qorong'i mavzu: layout xatosi bo'lmasligi kerak.
  for (final lang in AppLanguage.values) {
    for (final (width, scale, theme) in [
      (320.0, 2.0, ThemeMode.light),
      (390.0, 1.0, ThemeMode.dark),
      (430.0, 1.35, ThemeMode.light),
    ]) {
      testWidgets('exam layout: ${lang.name} ${width.toInt()} ×$scale '
          '${theme.name}', (tester) async {
        final l = lookupAppLocalizations(lang.locale);
        final s = await makeServices(tester, language: lang, themeMode: theme);
        await pumpApp(tester, s, size: Size(width, 3200), textScale: scale);
        final exam = await _startExam(tester, s, l, count: 4, minutes: 10);
        expect(tester.takeException(), isNull);
        await answerCurrent(tester, s, exam, correct: false, lang: lang.name);
        // Tor ekranda tugma faqat belgi bilan — nomi semantikada.
        await tester.tap(find.bySemanticsLabel(l.examFlag));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await _finishViaDialog(tester, l);
        expect(tester.takeException(), isNull, reason: 'result');
        await tapScroll(tester, l.examFilterAll(4));
        expect(tester.takeException(), isNull, reason: 'all answers');
        await goTo(tester, '/learn/exam');
        expect(tester.takeException(), isNull, reason: 'setup + history');
      });
    }
  }
}
