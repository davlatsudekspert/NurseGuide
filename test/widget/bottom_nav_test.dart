import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/app/widgets/lg_page.dart';
import 'package:nurseguide/design/tokens.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/l10n/gen/app_localizations_en.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';

final en = AppLocalizationsEn();

const _pill = ValueKey('nav-pill');

/// Pastki menyu: yarim shaffof (frosted glass), scroll bilan ixchamlashadi,
/// o'rtadagi Ish joyi tugmasi ko'tarilgan, kontent menyu ostida qolmaydi.
void main() {
  setUpAll(loadAppFonts);

  Finder tab(int i) => find.byKey(ValueKey('nav-tab-$i'));
  double pillHeight(WidgetTester t) => t.getSize(find.byKey(_pill)).height;
  Rect pillRect(WidgetTester t) => t.getRect(find.byKey(_pill));

  /// Nom ixcham holatda yashirin: shaffof va qirqib tashlangan.
  bool labelHidden(WidgetTester t, String label) {
    final text = find.text(label);
    final opacity = t.widget<Opacity>(
      find.ancestor(of: text, matching: find.byType(Opacity)).first,
    );
    final clip = t.getSize(
      find.ancestor(of: text, matching: find.byType(ClipRect)).first,
    );
    return opacity.opacity == 0 && clip.height == 0;
  }

  Finder pageScrollable() => find
      .descendant(
        of: find.byType(LgPage).last,
        matching: find.byType(Scrollable),
      )
      .first;

  Future<void> scrollBy(WidgetTester t, double dy, {bool settle = true}) async {
    await t.drag(pageScrollable(), Offset(0, dy));
    if (settle) await t.pumpAndSettle();
  }

  /// Aniq [dy] px siljitish: barmoq ro'yxatning chap chetidagi bo'sh
  /// (padding) yo'lagiga tushadi, shuning uchun uning ustida boshqa bosish
  /// (InkWell/tugma) yo'q va jest darhol qabul qilinadi — yetkazilgan
  /// siljish aynan [dy]. `WidgetTester.drag` esa kontentga bog'liq: barmoq
  /// kartaga tushsa, birinchi ~18 px (slop) yutiladi, bo'sh joyga tushsa
  /// to'liq yetkaziladi (Bosh sahifa tartibi o'zgarganda test shu sababli
  /// buzilgan edi).
  Future<void> scrollExact(WidgetTester t, double dy) async {
    final r = t.getRect(pageScrollable());
    final g = await t.startGesture(Offset(r.left + 4, r.center.dy));
    await g.moveBy(Offset(0, dy));
    await g.up();
    await t.pumpAndSettle();
  }

  Future<void> boot(
    WidgetTester t, {
    Size size = const Size(390, 844),
    double textScale = 1,
    bool reduceMotion = false,
    ThemeMode theme = ThemeMode.light,
    String route = '/home',
  }) async {
    final s = await makeServices(t, language: AppLanguage.en, themeMode: theme);
    await pumpApp(
      t,
      s,
      size: size,
      textScale: textScale,
      reduceMotion: reduceMotion,
    );
    if (route != '/home') await goTo(t, route);
  }

  // ---------------------------------------------------------------- shisha
  double luminance(Color c) => c.computeLuminance();
  double contrast(Color a, Color b) {
    final la = luminance(a), lb = luminance(b);
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  /// Shisha sirti [backdrop] ustida qanday ko'rinadi (alfa-aralashtirish).
  Color over(Color surface, Color backdrop) =>
      Color.alphaBlend(surface, backdrop);

  for (final (name, p, brightness) in [
    ('light', LgPalette.light, Brightness.light),
    ('dark', LgPalette.dark, Brightness.dark),
    ('ivory light', LgPalette.ivoryLight, Brightness.light),
    ('ivory dark', LgPalette.ivoryDark, Brightness.dark),
  ]) {
    test(
      'glass keeps ≥ 4.5:1 text/icon contrast over any backdrop ($name)',
      () {
        final surface = LgGlass.surface(p, brightness);
        expect(surface.a, lessThan(1), reason: 'translucent');
        // Eng yomon fonlar: sof qora va sof oq kontent (xiralashtirishdan keyin
        // ham o'rtacha rang shu oraliqda).
        for (final backdrop in [Colors.black, Colors.white]) {
          final glass = over(surface, backdrop);
          for (final (label, fg) in [
            ('unselected (ink)', p.ink),
            ('selected (brand)', p.brand),
          ]) {
            expect(
              contrast(fg, glass),
              greaterThanOrEqualTo(4.5),
              reason: '$name $label over $backdrop',
            );
          }
        }
        // Tanlangan tabdagi yumshoq fon ustida ham.
        expect(contrast(p.brand, p.soft), greaterThanOrEqualTo(4.5));
        // Ish joyi: brend doira ustida ikonka.
        expect(contrast(p.onBrand, p.brand), greaterThanOrEqualTo(4.5));
      },
    );
  }

  testWidgets('frosted glass: blur, translucent fill, thin border', (
    tester,
  ) async {
    await boot(tester);
    final blur = tester.widget<BackdropFilter>(
      find.descendant(
        of: find.byKey(_pill),
        matching: find.byType(BackdropFilter),
      ),
    );
    expect(blur.enabled, isTrue);
    final box = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byKey(_pill),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    final deco = box.decoration as BoxDecoration;
    expect(deco.color!.a, lessThan(1));
    expect(deco.border, isNotNull);
  });

  testWidgets('content scrolls underneath the bar (body extends behind it)', (
    tester,
  ) async {
    await boot(tester);
    // Ro'yxat ko'rinish oynasi ekranning pastigacha cho'zilgan.
    final list = tester.getRect(find.byType(ListView).last);
    expect(list.bottom, closeTo(844, 0.5));
    expect(pillRect(tester).bottom, lessThan(844));
  });

  testWidgets('high contrast / no transparency: solid surface, no blur', (
    tester,
  ) async {
    final s = await makeServices(tester, language: AppLanguage.en);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(highContrast: true);
    await pumpApp(tester, s);
    final blur = tester.widget<BackdropFilter>(
      find.descendant(
        of: find.byKey(_pill),
        matching: find.byType(BackdropFilter),
      ),
    );
    expect(blur.enabled, isFalse);
    final deco =
        tester
                .widget<DecoratedBox>(
                  find
                      .descendant(
                        of: find.byKey(_pill),
                        matching: find.byType(DecoratedBox),
                      )
                      .first,
                )
                .decoration
            as BoxDecoration;
    expect(deco.color!.a, 1);
  });

  // --------------------------------------------------------------- ixchamlik

  testWidgets('hysteresis: small moves and wobble do not flip the bar', (
    tester,
  ) async {
    await boot(tester);
    final expanded = pillHeight(tester);
    // Chegaradan (14 px) kichik surish — holat o'zgarmaydi.
    await scrollExact(tester, -10);
    expect(pillHeight(tester), expanded, reason: '< threshold');
    // Aniq pastga surish — ixcham.
    await scrollExact(tester, -200);
    final compact = pillHeight(tester);
    expect(compact, lessThan(expanded));
    // Ixcham holatda mayda teskari harakat qaytarmaydi.
    await scrollExact(tester, 8);
    expect(pillHeight(tester), compact);
    await scrollExact(tester, -8);
    expect(pillHeight(tester), compact);
    // Aniq yuqoriga surish — yana kengayadi (ro'yxat o'rtasida).
    await scrollExact(tester, 40);
    expect(pillHeight(tester), expanded);
    // Kengaygan holatda barmoq 7 px pastga/7 px yuqoriga tebranadi —
    // holat o'zgarmaydi.
    for (var i = 0; i < 4; i++) {
      await scrollExact(tester, -7);
      await scrollExact(tester, 7);
    }
    expect(pillHeight(tester), expanded);
  });

  testWidgets('animated by default, instant under reduced motion', (
    tester,
  ) async {
    await boot(tester);
    final expanded = pillHeight(tester);
    await tester.drag(pageScrollable(), const Offset(0, -500));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 60));
    final mid = pillHeight(tester);
    expect(mid, lessThan(expanded));
    expect(mid, greaterThan(48), reason: 'still animating');
    await tester.pumpAndSettle();
    expect(pillHeight(tester), 48);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('reduced motion: state is correct without any animation', (
    tester,
  ) async {
    await boot(tester, reduceMotion: true);
    final expanded = pillHeight(tester);
    await tester.drag(pageScrollable(), const Offset(0, -500));
    // Bir kadr — animatsiyasiz darhol ixcham.
    await tester.pump();
    expect(pillHeight(tester), 48);
    expect(labelHidden(tester, en.navHome), isTrue);
    await tester.drag(pageScrollable(), const Offset(0, 120));
    await tester.pump();
    expect(pillHeight(tester), expanded);
  });

  // -------------------------------------------------------------- a11y
  testWidgets('tap targets ≥ 44 px and semantics labels in both states', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await boot(tester);
    for (final compact in [false, true]) {
      if (compact) await scrollBy(tester, -500);
      for (var i = 0; i < 5; i++) {
        final size = tester.getSize(tab(i));
        expect(size.width, greaterThanOrEqualTo(44), reason: 'tab $i w');
        expect(size.height, greaterThanOrEqualTo(44), reason: 'tab $i h');
      }
      for (final label in [
        en.navHome,
        en.navProcedures,
        en.navWorkplace,
        en.navLibrary,
        en.navLearn,
      ]) {
        expect(
          find.semantics.byLabel(label),
          findsOne,
          reason: '$label compact=$compact',
        );
      }
      expect(
        tester.getSemantics(find.bySemanticsLabel(en.navWorkplace).first),
        isSemantics(label: en.navWorkplace, isButton: true, hasTapAction: true),
      );
    }
    // Ixcham holatda ham TalkBack orqali tab almashadi.
    tester.semantics.tap(find.semantics.byLabel(en.navLibrary));
    await tester.pumpAndSettle();
    expect(routerOf(tester).state.matchedLocation, '/library');
    expect(tester.getSemantics(tab(3)), isSemantics(isSelected: true));
    handle.dispose();
  });

  testWidgets(
    'transparent area above the compact pill passes touches through',
    (tester) async {
      await boot(tester);
      await scrollBy(tester, -500);
      final pill = pillRect(tester);
      // Panel ustidagi ajratilgan (shaffof) joy — kontent bosiladi.
      final hit = tester.hitTestOnBinding(Offset(30, pill.top - 20));
      final names = hit.path.map((e) => e.target.runtimeType.toString());
      expect(names.any((n) => n.contains('InkResponse')), isFalse);
      expect(hit.path.any((e) => e.target is RenderBackdropFilter), isFalse);
    },
  );
}
