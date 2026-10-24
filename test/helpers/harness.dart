import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:nurseguide/features/billing/billing_controller.dart';
import 'package:nurseguide/app/app.dart';
import 'package:nurseguide/app/app_scope.dart';
import 'package:nurseguide/app/widgets/lg_page.dart';
import 'package:nurseguide/features/reference/reference_data.dart';
import 'package:nurseguide/core/backend/app_backend.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/auth/otp_auth.dart';
import 'package:nurseguide/features/auth/social_auth.dart';
import 'package:nurseguide/features/classroom/lecture_catalog.dart';
import 'package:nurseguide/features/classroom/lecture_decks.dart';
import 'package:nurseguide/features/classroom/qr_scanner.dart';
import 'package:nurseguide/features/daily/daily_reminder.dart';
import 'package:nurseguide/features/settings/settings_controller.dart';
import 'package:nurseguide/features/share/result_share.dart';
import 'package:nurseguide/main.dart';
import 'package:material_ui/material_ui.dart';

import 'daily_fakes.dart';
import 'fixtures.dart';
import 'fake_qr_scanner.dart';

/// Haqiqiy Manrope, Fraunces, Inter va Material Icons shriftlarini yuklaydi: overflow
/// tekshiruvi test shriftida (har harf = kvadrat) emas, ilovadagi kabi
/// matn kengligida o'tadi.
Future<void> loadAppFonts() async {
  Future<ByteData> file(String path) async =>
      ByteData.sublistView(File(path).readAsBytesSync());
  final inter = FontLoader('Inter');
  for (final w in [400, 500, 600, 700]) {
    inter.addFont(file('assets/fonts/Inter-$w.ttf'));
  }
  await inter.load();
  // "Tiniq shisha": Manrope (matn) va Fraunces (sarlavha).
  await (FontLoader(
    'Manrope',
  )..addFont(file('assets/fonts/Manrope.ttf'))).load();
  await (FontLoader(
    'Fraunces',
  )..addFont(file('assets/fonts/Fraunces.ttf'))).load();
  // Ivory mavzusining sarlavha shriftlari (D-64).
  await (FontLoader(
    'InstrumentSerif',
  )..addFont(file('assets/fonts/InstrumentSerif-Regular.ttf'))).load();
  await (FontLoader(
    'PlayfairDisplay',
  )..addFont(file('assets/fonts/PlayfairDisplay-Variable.ttf'))).load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
  await icons.load();
}

/// Test uchun servislar: xotiradagi ombor, tasdiqlangan kontent yuklangan.
Future<AppServices> makeServices(
  WidgetTester tester, {
  MemoryKeyValueStore? store,
  OtpAuthAdapter? otpAdapter,
  AppLanguage language = AppLanguage.uz,
  AppRole? role = AppRole.nurse,
  bool onboarded = true,
  bool guest = false,
  // Mavjud testlar /welcome'dan boshlanadi; til tanlash ekrani alohida sinaladi.
  bool languageChosen = true,
  ThemeMode themeMode = ThemeMode.light,
  // Ilova mavzusi (D-64): berilmasa — ombordagi (yangi omborda Klassik).
  LgThemeId? appTheme,
  AssetBundle? bundle,
  http.Client? httpClient,
  AppBackend? backend,
  ReminderScheduler? reminderScheduler,
  ResultSharer? sharer,
  DateTime Function()? clock,
  // Google / Apple kirish tugmalari (soxta provayderlar; berilmasa — yo'q).
  SocialAuthService? socialAuth,
  // Ilova ichidagi QR skaner (berilmasa — soxta, Android kabi "qo'llanadi").
  QrScanner? qrScanner,
  // false — toifa banki oldindan yuklanmaydi (ilova sovuq ochilgandek:
  // bank faqat kerakli sahifa so'raganda yuklanadi).
  bool loadToifa = true,
  // Obuna (Pro) yoqilgan holatni sinash: berilmasa — o'chiq (hamma ochiq).
  bool billingEnabled = false,
}) async {
  final s = store ?? MemoryKeyValueStore();
  final services = createServices(
    store: s,
    bundle: bundle ?? testBundle,
    systemLocales: [language.locale],
    // Server berilsa — kirish uning OTP'si orqali (haqiqiy oqim kabi).
    otpAdapter:
        otpAdapter ??
        (backend == null ? DemoOtpAdapter(releaseBuild: false) : null),
    // Sinov muhiti: haqiqiy tarmoq yo'q (server berilmasa — ulanmagan).
    backend: backend ?? const UnconfiguredBackend(),
    // Haqiqiy bildirishnoma/ulashish plaginlari testda yo'q.
    reminderScheduler: reminderScheduler ?? FakeReminderScheduler(),
    sharer: sharer ?? FakeResultSharer(),
    clock: clock,
    socialAuth: socialAuth ?? SocialAuthService.none(),
    qrScanner: qrScanner ?? FakeQrScanner(),
    billing: billingEnabled
        ? BillingController(store: s, enabled: true, now: clock)
        : null,
  );
  if (languageChosen) {
    await services.settings.chooseLanguage(language);
  } else {
    await services.settings.setLanguage(language);
  }
  await services.settings.setThemeMode(themeMode);
  if (appTheme != null) await services.settings.setAppTheme(appTheme);
  if (role != null) await services.settings.setRole(role);
  if (onboarded) {
    // Standart: ro'yxatdan o'tgan foydalanuvchi (mehmon bo'limlari cheklangan);
    // mehmon holati — `guest: true`.
    if (guest) {
      await services.auth.continueAsGuest();
    } else {
      services.auth.debugSignIn('test@example.com');
    }
    await services.settings.completeOnboarding();
  }
  await tester.runAsync(services.content.load);
  if (loadToifa) await tester.runAsync(services.toifa.ensureLoaded);
  // O'quv dasturi asset'i (bundle'da bo'lmasa — “qo'shilmagan” holati).
  await tester.runAsync(services.curriculum.ensureLoaded);
  // Tayyor taqdimotlar (Ma'ruza rejimi) — keshga oldindan.
  await tester.runAsync(
    () => LectureDecks.all(services.curriculum.bundle ?? rootBundle),
  );
  // Barcha taqdimotlar katalogi (Ma'ruza ro'yxati va qidiruv).
  await tester.runAsync(
    () => DeckCatalog.load(services.curriculum.bundle ?? rootBundle),
  );
  // Muolajalar va atamalar lug'ati (Manipulyatsiyalar, Kutubxona).
  await tester.runAsync(
    () => ReferenceData.load(services.curriculum.bundle ?? rootBundle),
  );
  return services;
}

/// Telefon kabi ekran: o'lcham (logik px), safe area, shrift masshtabi,
/// tizim mavzusi, reduced motion.
Future<void> pumpApp(
  WidgetTester tester,
  AppServices services, {
  Size size = const Size(390, 844),
  double textScale = 1,
  Brightness platformBrightness = Brightness.light,
  bool reduceMotion = false,
  bool notch = true,
  double ratio = 3.0,
}) async {
  tester.view.devicePixelRatio = ratio;
  tester.view.physicalSize = size * ratio;
  if (notch) {
    tester.view.padding = FakeViewPadding(top: 47 * ratio, bottom: 34 * ratio);
  }
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  tester.platformDispatcher.platformBrightnessTestValue = platformBrightness;
  if (reduceMotion) {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
  }
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAllTestValues);
  await tester.pumpWidget(NurseGuideApp(services: services));
  await tester.pumpAndSettle();
}

/// Joriy routerni olish (ko'rinib turgan sahifa orqali). To'liq ekranli
/// sahifalarda (LgPage'siz) — Scaffold orqali.
GoRouter routerOf(WidgetTester tester) {
  final page = find.byType(LgPage);
  return GoRouter.of(
    tester.element(
      page.evaluate().isNotEmpty ? page.first : find.byType(Scaffold).last,
    ),
  );
}

/// Pastki menyuning [index]-tabini bosadi (0 Bosh, 1 Manipulyatsiyalar, 2 Ish joyi,
/// 3 Kutubxona, 4 O'rganish). Menyu pastga scroll qilinganda ixcham bo'lib
/// nomlarini yashiradi — shuning uchun matn orqali emas, kalit orqali.
Future<void> tapNavTab(WidgetTester tester, int index) async {
  await tester.tap(find.byKey(ValueKey('nav-tab-$index')));
  await tester.pumpAndSettle();
}

Future<void> goTo(WidgetTester tester, String location) async {
  routerOf(tester).go(location);
  await tester.pumpAndSettle();
}

/// Lokalizatsiya obyektini joriy til bo'yicha olish.
T l10n<T>(WidgetTester tester, T Function(BuildContext) read) =>
    read(tester.element(find.byType(LgPage).first));

/// Kontent paketini buzib beradigan asset bundle (xato holatini sinash).
class TamperingBundle extends CachingAssetBundle {
  TamperingBundle(this._inner);

  final AssetBundle _inner;

  @override
  Future<ByteData> load(String key) async {
    final data = await _inner.load(key);
    if (!key.endsWith('core/pack.json')) return data;
    final bytes = Uint8List.fromList(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    );
    bytes[42] ^= 0x01;
    return ByteData.sublistView(bytes);
  }
}

/// Paket JSON'ini o'zgartirib, manifestni (size + sha256) mos ravishda
/// qayta hisoblaydigan bundle — tekshiruvdan o'tadigan, lekin boshqacha
/// kontentli paket (masalan, “faqat tuzilma” kartasini ko'rsatish uchun).
class PatchedPackBundle extends CachingAssetBundle {
  PatchedPackBundle(this._inner, this._patch);

  final AssetBundle _inner;
  final void Function(Map<String, Object?> pack) _patch;
  Uint8List? _pack;

  Future<Uint8List> _patchedPack() async {
    if (_pack != null) return _pack!;
    final raw = await _inner.loadString('assets/content/core/pack.json');
    final json = jsonDecode(raw) as Map<String, Object?>;
    _patch(json);
    return _pack = Uint8List.fromList(utf8.encode(jsonEncode(json)));
  }

  @override
  Future<ByteData> load(String key) async {
    if (key.endsWith('core/pack.json')) {
      return ByteData.sublistView(await _patchedPack());
    }
    if (key.endsWith('core/manifest.json')) {
      final bytes = await _patchedPack();
      final manifest =
          jsonDecode(await _inner.loadString(key)) as Map<String, Object?>;
      manifest['files'] = [
        {
          'path': 'pack.json',
          'size': bytes.length,
          'sha256': sha256.convert(bytes).toString(),
        },
      ];
      return ByteData.sublistView(
        Uint8List.fromList(utf8.encode(jsonEncode(manifest))),
      );
    }
    return _inner.load(key);
  }
}
