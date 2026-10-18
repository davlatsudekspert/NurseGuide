import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/learn_helpers.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

const _tall = Size(390, 2400);

void main() {
  setUpAll(loadAppFonts);

  testWidgets('og‘zaki bilet: o‘ylash taymeri, reja, asosiy so‘zlar, baho, '
      'yakunda takrorlash ro‘yxati', (tester) async {
    final s = await makeServices(tester);
    s.toifa.random = Random(11);
    await s.toifa.setCategory(ToifaCategory.second);
    await pumpApp(tester, s, size: _tall);
    await goTo(tester, '/learn/toifa/oral');
    await tapScroll(tester, uz.toifaDrawTicket);
    // Yozish shart emas — tayyorlanish matni.
    expect(find.text(uz.toifaPrepHint), findsOne);
    await tapScroll(tester, uz.toifaShowPlans);
    final ratings = [
      OralRating.knew,
      OralRating.unknown,
      OralRating.partial,
      OralRating.knew,
      OralRating.knew,
    ];
    for (final (i, r) in ratings.indexed) {
      expect(find.text(uz.toifaThinkHint), findsOne);
      expect(find.text(uz.toifaPlanPending), findsNothing, reason: 'yopiq');
      if (i == 0) {
        // Ixtiyoriy 3 daqiqalik taymer — to'xtatsa bo'ladi.
        await tester.tap(find.byKey(const ValueKey('toifa-think-start')));
        await tester.pump();
        expect(find.textContaining(uz.toifaThinkLeft('')), findsOne);
        await tester.pump(const Duration(seconds: 2));
        await tester.tap(find.byKey(const ValueKey('toifa-think-stop')));
        await tester.pumpAndSettle();
        expect(find.text(uz.toifaThinkTimer(3)), findsOne);
      }
      await tapScroll(tester, uz.toifaShowPlan);
      expect(find.text(uz.toifaPlanPending), findsOne);
      if (i == 0) {
        // Asosiy so'zlar ro'yxati (faqat reja/faktlar matnidan).
        await tester.ensureVisible(
          find.byKey(const ValueKey('toifa-checklist-switch')),
        );
        await tester.tap(find.byKey(const ValueKey('toifa-checklist-switch')));
        await tester.pumpAndSettle();
        expect(s.toifa.checklist, true);
        final q = s.toifa.bank!.oralQuestion(s.toifa.ticket!.currentId)!;
        final items = q.plan.length + q.reference.length + q.cutoffs.length;
        if (items > 0) {
          expect(find.text(uz.toifaChecklistCount(0, items)), findsOne);
          await tester.ensureVisible(find.byType(Checkbox).first);
          await tester.tap(find.byType(Checkbox).first);
          await tester.pumpAndSettle();
          expect(find.text(uz.toifaChecklistCount(1, items)), findsOne);
        }
      }
      await tapScroll(tester, r.label(uz));
    }
    final t = s.toifa.ticket!;
    expect(t.done, true);
    expect(find.text(uz.toifaTicketDone), findsOne);
    // Takrorlash: "Bilmadim" va "Qisman" — keyingi biletlarda birinchi.
    expect(find.text(uz.toifaRepeatTitle), findsOne);
    expect(find.text(uz.toifaRepeatNote), findsOne);
    expect(t.toRepeat.length, 2);
    // Bilet — kunlik maqsad; taklif ko'rinadi.
    expect(s.toifa.todayStats.tickets, 1);
    expect(find.text(uz.toifaOfferTitle), findsOne);
    // Keyingi biletda "Bilmadim" savoli bor.
    final unknown = t.ids.firstWhere(
      (id) => t.ratings[id] == OralRating.unknown,
    );
    await s.toifa.drawTicket(ToifaCategory.second);
    expect(s.toifa.ticket!.ids, contains(unknown));
  });
}
