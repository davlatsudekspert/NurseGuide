import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'core/device/device_identity.dart';
import 'features/billing/billing_controller.dart';
import 'app/app_scope.dart';
import 'core/backend/access_controller.dart';
import 'core/backend/cloudflare_backend.dart';
import 'core/backend/app_backend.dart';
import 'core/storage/kv_store.dart';
import 'features/auth/auth_controller.dart';
import 'features/auth/otp_auth.dart';
import 'features/auth/social_auth.dart';
import 'features/classroom/classroom_local.dart';
import 'features/classroom/curriculum.dart';
import 'features/classroom/qr_scanner.dart';
import 'features/classroom/topic_test.dart';
import 'features/content/content_controller.dart';
import 'features/daily/daily_controller.dart';
import 'features/daily/daily_reminder.dart';
import 'features/learn/exam_controller.dart';
import 'features/learn/quiz_progress.dart';
import 'features/library/reading_controller.dart';
import 'features/settings/settings_controller.dart';
import 'features/share/result_share.dart';
import 'features/toifa/toifa_controller.dart';

// 1.0.0 — birinchi do'kon versiyasi (TestFlight → App Store).
const _appVersion = '1.0.0';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final services = createServices(
    store: await PrefsKeyValueStore.open(),
    bundle: rootBundle,
    systemLocales: PlatformDispatcher.instance.locales,
  );
  // Qurilmadagi sessiya (bo'lsa) — Keychain'dan bir zumda o'qiladi.
  await services.backend.restoreSession().timeout(
    const Duration(seconds: 3),
    onTimeout: () {},
  );
  await services.auth.reconcileWithBackend();
  unawaited(services.refreshAccess());
  // Kontent fonda yuklanadi; ekranlar loading/error holatini ko'rsatadi.
  unawaited(services.content.load());
  // O'quv dasturi (asset bo'lmasa — “qo'shilmagan”, ma'ruza qatori yo'q).
  unawaited(services.curriculum.ensureLoaded());
  // Kunlik eslatma yoqilgan bo'lsa — keyingi kunlar rejasi yangilanadi.
  unawaited(services.reminders.sync());
  unawaited(services.reminders.syncToifa());
  runApp(NurseGuideApp(services: services));
}

/// Servislarni yig'ish — testlar ham shu funksiyadan foydalanadi.
AppServices createServices({
  required KeyValueStore store,
  required AssetBundle bundle,
  required Iterable<Locale> systemLocales,
  OtpAuthAdapter? otpAdapter,
  AppBackend? backend,
  ReminderScheduler? reminderScheduler,
  ResultSharer? sharer,
  DateTime Function()? clock,
  Curriculum? curriculum,
  SocialAuthService? socialAuth,
  QrScanner? qrScanner,
  BillingController? billing,
}) {
  const config = AppConfig(appVersion: _appVersion, showDebugBadge: kDebugMode);
  final server = backend ?? _defaultBackend();
  final settings = SettingsController(store, systemLocales: systemLocales);
  final daily = DailyController(store, clock: clock);
  final toifa = ToifaController(store, bundle: bundle, clock: clock)
    ..useLanguage(settings.language.name);
  return AppServices(
    config: config,
    store: store,
    settings: settings,
    // Server sozlangan bo'lsa — haqiqiy email OTP; aks holda debug'da demo,
    // release'da “ulanmagan”.
    auth: AuthController(
      store,
      otpAdapter ?? (server.isConfigured ? server : createOtpAdapter()),
      backend: server,
      // Google / Apple: faqat Cloudflare serveri va --dart-define sozlamasi
      // bilan; aks holda tugmalar umuman ko'rinmaydi (D-56).
      social:
          socialAuth ??
          SocialAuthService.fromEnvironment(
            backend: server,
            appleAndroidRedirect: server is CloudflareAppBackend
                ? server.config.resolve('/v1/auth/apple/callback')
                : null,
          ),
    ),
    content: ContentController(bundle: bundle),
    bookmarks: BookmarksController(store),
    quizProgress: QuizProgressController(store),
    exams: ExamController(store),
    reading: ReadingController(store, bundle: bundle),
    backend: server,
    access: AccessController(server),
    toifa: toifa,
    daily: daily,
    reminders: ReminderController(
      store,
      reminderScheduler ?? LocalReminderScheduler(),
      daily: daily,
      settings: settings,
      toifa: toifa,
    ),
    sharer: sharer ?? const SystemResultSharer(),
    curriculum: CurriculumController(bundle: bundle, curriculum: curriculum),
    classroom: ClassroomLocal(store),
    topicTests: TopicTestController(store, clock: clock),
    billing: billing ?? BillingController(store: store, now: clock),
    qrScanner: qrScanner ?? const MobileQrScanner(),
  )..watchAccess();
}

/// Server: `LG_API_URL` (Cloudflare Worker; berilmasa — standart manzil)
/// bo'lsa — u; aks holda “server ulanmagan”.
AppBackend _defaultBackend() {
  const api = ApiConfig.fromEnvironment;
  return api.isConfigured
      // Qurilma identifikatori faqat obuna yoqilganda (bepul sinov uchun) yuboriladi.
      ? CloudflareAppBackend(
          api,
          device: kBillingEnabled ? DeviceIdentity() : null,
        )
      : const UnconfiguredBackend();
}
