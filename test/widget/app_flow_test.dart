// NurseGuide asosiy oqimlari: onboarding (til → welcome → mehmon → rol),
// uch rol va ularning bosh sahifasi, 5 tabli pastki menyu, Manipulyatsiyalar
// va Ish joyi bo'sh holatlari, Ustoz roli faqat hisobli foydalanuvchiga.
import 'package:flutter/widgets.dart' show Size, ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/widgets/lg_widgets.dart';
import 'package:nurseguide/features/auth/ui/role_screen.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';
import '../helpers/ui.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('onboarding: til → welcome → mehmon → rol → bosh sahifa', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      onboarded: false,
      languageChosen: false,
      role: null,
      language: AppLanguage.uz,
    );
    await pumpApp(tester, s);
    await tapText(tester, 'O‘zbekcha');
    expect(find.text(uz.welcomeGuest), findsOneWidget);
    await tapText(tester, uz.welcomeGuest);
    // Rol: uchta karta (Hamshira, Talaba, Ustoz).
    expect(find.byType(RoleCard), findsNWidgets(3));
    expect(find.text(uz.roleNurse), findsOneWidget);
    expect(find.text(uz.roleStudent), findsOneWidget);
    expect(find.text(uz.roleTeacher), findsOneWidget);
    await tester.tap(find.text(uz.roleNurse));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('role-continue')));
    await tester.pumpAndSettle();
    expect(s.settings.onboarded, isTrue);
    expect(s.settings.role, AppRole.nurse);
    expect(routerOf(tester).state.uri.path, '/home');
  });

  testWidgets('ustoz roli mehmon uchun qulflangan; davom etib bo‘lmaydi', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      onboarded: false,
      role: null,
      backend: FakeBackend(),
    );
    await pumpApp(tester, s);
    await goTo(tester, '/welcome/role');
    expect(find.text(uz.rolesTeacherLocked), findsOneWidget);
    expect(find.byKey(const ValueKey('role-teacher-note')), findsOneWidget);
    await tester.tap(find.text(uz.roleTeacher));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('role-continue')));
    await tester.pumpAndSettle();
    // Qulflangan karta tanlanmaydi: davom etilsa — boshlang'ich Hamshira.
    expect(s.settings.role, AppRole.nurse);
    expect(s.settings.role, isNot(AppRole.teacher));
  });

  testWidgets('ustoz roli hisobli foydalanuvchida server tasdiqlagach', (
    tester,
  ) async {
    final b = FakeBackend();
    final s = await makeServices(
      tester,
      onboarded: false,
      role: null,
      backend: b,
    );
    await pumpApp(tester, s);
    await s.auth.requestCode('teacher@example.com');
    await s.auth.verifyCode(FakeBackend.otpCode);
    await goTo(tester, '/welcome/role');
    expect(find.text(uz.rolesTeacherLocked), findsNothing);
    await tester.tap(find.text(uz.roleTeacher));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('role-continue')));
    await tester.pumpAndSettle();
    expect(s.settings.role, AppRole.teacher);
    expect(s.access.access.teacher, isTrue);

    // Chiqqach — ustoz roli talabaga qaytadi (faqat hisobli foydalanuvchi).
    await s.auth.signOut();
    await tester.pumpAndSettle();
    expect(s.settings.role, AppRole.student);
  });

  for (final (role, tiles) in [
    (AppRole.nurse, ['toifa', 'procedures', 'workplace']),
    (AppRole.student, ['lessons', 'tests']),
    (AppRole.teacher, ['groups']),
  ]) {
    testWidgets('bosh sahifa: ${role.name} kartalari', (tester) async {
      final s = await makeServices(tester, role: role);
      await pumpApp(tester, s, size: const Size(390, 1400));
      await goTo(tester, '/home');
      final titles = {
        'toifa': uz.toifaTitle,
        'procedures': uz.navProcedures,
        'workplace': uz.navWorkplace,
        'lessons': uz.featureLessons,
        'tests': uz.featureTests,
        'groups': uz.featureClasses,
      };
      for (final t in tiles) {
        expect(find.text(titles[t]!), findsWidgets, reason: '$role $t');
      }
      // Boshqa rolning kartasi yo'q.
      if (role == AppRole.teacher) {
        expect(find.text(uz.navProcedures), findsOneWidget); // faqat menyuda
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('pastki menyu: 5 tab, o‘rtadagisi — Ish joyi (katta tugma)', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    final labels = [
      uz.navHome,
      uz.navProcedures,
      uz.navWorkplace,
      uz.navLibrary,
      uz.navLearn,
    ];
    expect(labels, [
      'Bosh sahifa',
      'Manipulyatsiyalar',
      'Ish joyi',
      'Kutubxona',
      'O‘rganish',
    ]);
    for (var i = 0; i < 5; i++) {
      expect(find.byKey(ValueKey('nav-tab-$i')), findsOneWidget, reason: '$i');
    }
    // O'rtadagi tab — dumaloq, panel ustidan chiqib turadi.
    final circle = tester.getRect(
      find.byKey(const ValueKey('nav-center-circle')),
    );
    final pill = tester.getRect(find.byKey(const ValueKey('nav-pill')));
    expect(circle.top, lessThan(pill.top));
    expect(circle.width, greaterThanOrEqualTo(50));
    final paths = ['/home', '/procedures', '/workplace', '/library', '/learn'];
    for (var i = 0; i < 5; i++) {
      await tapNavTab(tester, i);
      expect(routerOf(tester).state.uri.path, paths[i]);
    }
  });

  testWidgets('Manipulyatsiyalar va Ish joyi — halol bo‘sh holat', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s);
    await tapNavTab(tester, 1);
    expect(find.byKey(const ValueKey('procedures-empty')), findsOneWidget);
    expect(find.byType(LgStateView), findsOneWidget);
    expect(find.text(uz.procEmptyTitle), findsOneWidget);
    await tapNavTab(tester, 2);
    expect(find.byKey(const ValueKey('workplace-empty')), findsOneWidget);
    expect(find.text(uz.workEmptyTitle), findsOneWidget);
    // O'rganishga o'tish tugmasi ishlaydi.
    await tester.tap(find.text(uz.hubGoLearn));
    await tester.pumpAndSettle();
    expect(routerOf(tester).state.uri.path, '/learn');
  });

  testWidgets('3 til: tab nomlari tarjima qilingan', (tester) async {
    for (final l in [AppLanguage.uz, AppLanguage.ru, AppLanguage.en]) {
      final s = await makeServices(tester, language: l);
      await pumpApp(tester, s);
      final strings = {'uz': uz, 'ru': ru, 'en': en}[l.name]!;
      for (final label in [strings.navProcedures, strings.navWorkplace]) {
        expect(find.text(label), findsWidgets, reason: '${l.name} $label');
      }
    }
  });
}
