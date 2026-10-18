// Sozlamalar: til (uz/ru/en), mavzu (Klassik/Ivory), rejim (tizim/kunduzgi/
// tungi), matn o'lchami, tovush va tebranish, kunlik eslatma vaqti.
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/harness.dart';
import '../helpers/ui.dart';

void main() {
  setUpAll(loadAppFonts);

  test('matn o‘lchami, tovush va tebranish saqlanadi va tiklanadi', () async {
    final store = MemoryKeyValueStore();
    final a = SettingsController(store, systemLocales: const []);
    expect(a.fontSize, FontSize.normal);
    expect(a.sounds, isTrue);
    expect(a.haptics, isTrue);
    await a.setFontSize(FontSize.xlarge);
    await a.setSounds(false);
    await a.setHaptics(false);
    final b = SettingsController(store, systemLocales: const []);
    expect(b.fontSize, FontSize.xlarge);
    expect(b.sounds, isFalse);
    expect(b.haptics, isFalse);
    expect(FontSize.values.map((f) => f.factor), [0.9, 1.0, 1.15, 1.3]);
    b.resetToDefaults(const []);
    expect(b.fontSize, FontSize.normal);
    expect(b.sounds && b.haptics, isTrue);
  });

  test(
    'klassik standart, ivory bor; rol server qiymatlari bilan saqlanadi',
    () async {
      final store = MemoryKeyValueStore();
      expect(
        SettingsController(store, systemLocales: const []).appTheme,
        LgThemeId.classic,
      );
      expect(LgThemeId.values, [LgThemeId.classic, LgThemeId.ivory]);
      await store.setString(StoreKeys.role, 'hamshira');
      expect(
        SettingsController(store, systemLocales: const []).role,
        AppRole.nurse,
      );
      await store.setString(StoreKeys.role, 'ustoz');
      expect(
        SettingsController(store, systemLocales: const []).role,
        AppRole.teacher,
      );
    },
  );

  testWidgets('profil: matn o‘lchami ilovaga ta’sir qiladi', (tester) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s, size: const Size(390, 2400));
    await goTo(tester, '/profile');
    double scale() =>
        MediaQuery.textScalerOf(tester.element(find.byType(Scaffold).first))
            .scale(10) /
        10;
    expect(scale(), closeTo(1.0, 0.001));
    await tester.tap(find.text(uz.fontSizeXLarge));
    await tester.pumpAndSettle();
    expect(s.settings.fontSize, FontSize.xlarge);
    expect(scale(), closeTo(1.3, 0.001));
    await tester.tap(find.text(uz.fontSizeSmall));
    await tester.pumpAndSettle();
    expect(scale(), closeTo(0.9, 0.001));
    expect(tester.takeException(), isNull);
  });

  testWidgets('profil: tovush/tebranish, mavzu, rejim, eslatma bo‘limlari', (
    tester,
  ) async {
    final s = await makeServices(tester);
    await pumpApp(tester, s, size: const Size(390, 2600));
    await goTo(tester, '/profile');
    for (final t in [
      uz.profileLanguage,
      uz.profileAppearance,
      uz.profileFontSize,
      uz.profileFeedback,
      uz.dailyReminderSetting,
      uz.themeSystem,
      uz.themeLight,
      uz.themeDark,
    ]) {
      expect(find.text(t), findsWidgets, reason: t);
    }
    // Tebranish va tovush o'chirgichlari.
    await tester.ensureVisible(find.byKey(const ValueKey('profile-haptics')));
    await tester.tap(find.byKey(const ValueKey('profile-haptics')));
    await tester.pumpAndSettle();
    expect(s.settings.haptics, isFalse);
    await tester.tap(find.byKey(const ValueKey('profile-sounds')));
    await tester.pumpAndSettle();
    expect(s.settings.sounds, isFalse);
    // Rejim: tungi.
    await tester.tap(find.text(uz.themeDark));
    await tester.pumpAndSettle();
    expect(s.settings.themeMode, ThemeMode.dark);
    // Til.
    await tester.tap(find.text('Русский'));
    await tester.pumpAndSettle();
    expect(s.settings.language, AppLanguage.ru);
    expect(find.text(ru.profileFontSize), findsOneWidget);
  });

  testWidgets(
    'mavzu: Klassik va Ivory, kunduzgi va tungi — ikkalasi ishlaydi',
    (tester) async {
      for (final id in LgThemeId.values) {
        for (final b in [Brightness.light, Brightness.dark]) {
          final s = await makeServices(
            tester,
            appTheme: id,
            themeMode: b == Brightness.light ? ThemeMode.light : ThemeMode.dark,
          );
          await pumpApp(tester, s, size: const Size(390, 1200));
          for (final p in ['/home', '/learn', '/library', '/profile']) {
            await goTo(tester, p);
            expect(tester.takeException(), isNull, reason: '$id $b $p');
          }
        }
      }
    },
  );
}
