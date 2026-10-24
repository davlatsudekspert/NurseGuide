import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../core/backend/access_controller.dart';
import '../core/backend/admin_console.dart';
import '../core/backend/admin_team.dart';
import '../core/backend/app_backend.dart';
import '../core/storage/kv_store.dart';
import '../features/auth/auth_controller.dart';
import '../features/billing/billing_controller.dart';
import '../features/classroom/classroom_local.dart';
import '../features/classroom/curriculum.dart';
import '../features/classroom/qr_scanner.dart';
import '../features/classroom/topic_test.dart';
import '../features/content/content_controller.dart';
import '../features/daily/daily_controller.dart';
import '../features/daily/daily_reminder.dart';
import '../features/home/resume_history.dart';
import '../features/learn/exam_controller.dart';
import '../features/learn/quiz_progress.dart';
import '../features/library/reading_controller.dart';
import '../features/settings/settings_controller.dart';
import '../features/share/result_share.dart';
import '../features/toifa/toifa_controller.dart';

/// Build va siyosat sozlamalari. Biznes qarorlari (masalan, qurilmalar
/// soni) kodga qotirilmaydi — shu yerda, keyin remote config'dan keladi.
@immutable
class AppConfig {
  const AppConfig({
    required this.appVersion,
    required this.showDebugBadge,
    this.maxActiveDevicesProposal = 2,
  });

  final String appVersion;

  /// Debug buildda demo adapterlar ishlayotganini ko'rsatish.
  final bool showDebugBadge;

  /// Taklif: 1 hisob / 2 faol qurilma. Hali qat'iy qaror emas.
  final int maxActiveDevicesProposal;
}

/// Ilova bo'ylab umumiy servislar. Har biri o'z holatini ChangeNotifier
/// orqali e'lon qiladi; widgetlar kerakli controllerni tinglaydi.
class AppServices {
  AppServices({
    required this.config,
    required this.store,
    required this.settings,
    required this.auth,
    required this.content,
    required this.bookmarks,
    required this.quizProgress,
    required this.exams,
    required this.reading,
    required this.backend,
    required this.access,
    required this.toifa,
    required this.daily,
    required this.reminders,
    required this.sharer,
    required this.curriculum,
    required this.classroom,
    required this.topicTests,
    required this.billing,
    this.qrScanner = const MobileQrScanner(),
  });

  final AppConfig config;
  final KeyValueStore store;
  final SettingsController settings;
  final AuthController auth;
  final ContentController content;

  /// Obuna darajasi (billing o'chiq bo'lsa — hamma bo'lim ochiq).
  final BillingController billing;
  final BookmarksController bookmarks;
  final QuizProgressController quizProgress;

  /// Imtihon rejimi: davom etayotgan imtihon va natijalar tarixi.
  final ExamController exams;

  /// Kutubxona PDF lari: oxirgi sahifa, xatcho'plar, faylni tekshirib ochish.
  final ReadingController reading;

  /// Server (sozlanmagan buildda — [UnconfiguredBackend]).
  final AppBackend backend;
  final AccessController access;

  /// Toifa imtihoniga tayyorgarlik (faqat O'zbekiston foydalanuvchilariga).
  final ToifaController toifa;

  /// Kunlik 5 ta savol va ketma-ketlik (faqat qurilmada).
  final DailyController daily;

  /// Kunlik lokal eslatma (standart o'chiq).
  final ReminderController reminders;

  /// Natija kartochkasini tizim oynasi orqali ulashish.
  final ResultSharer sharer;

  /// O'quv dasturi (`curriculum.json`; asset bo'lmasa — “qo'shilmagan”).
  final CurriculumController curriculum;

  /// Ustoz qurilmasidagi dars ma'lumotlari (serverga yuborilmaydi).
  final ClassroomLocal classroom;

  /// Mavzu testlari (taqdimot oxirida): tugallanmagan test va natijalar (qurilmada).
  final TopicTestController topicTests;

  /// Ilova ichidagi QR skaner (D-68; testlarda — soxta skaner).
  final QrScanner qrScanner;

  /// Adminlar boshqaruvi (D-44) — server bu imkoniyatga ega bo'lsa
  /// (hozircha faqat Cloudflare). Aks holda bo'lim ko'rinmaydi.
  AdminTeamBackend? get adminTeam =>
      backend is AdminTeamBackend ? backend as AdminTeamBackend : null;

  /// Egasi admin paneli (foydalanuvchilar, shikoyatlar) — faqat Cloudflare.
  AdminConsoleBackend? get adminConsole =>
      backend is AdminConsoleBackend ? backend as AdminConsoleBackend : null;

  /// Ilova ichidan shikoyat yuborish (Aloqa va shikoyat) — server bo'lsa.
  ComplaintsBackend? get complaints =>
      backend is ComplaintsBackend ? backend as ComplaintsBackend : null;

  /// Server vakolatlari va o'qilmagan javoblarni yangilash. Rol hali
  /// tanlanmagan bo'lsa profil yozilmaydi (taxminiy rol sanalmasin).
  Future<void> refreshAccess() => access.refresh(
    role: settings.role?.wire,
    language: settings.language.name,
  );

  /// Kirish/chiqish va rol/til o'zgarishini kuzatadi.
  void watchAccess() {
    var signedIn = auth.hasAccount;
    var role = settings.role;
    var language = settings.language;
    // Admin bergan Pro (server `/v1/me`) — billing darajasiga qo'shiladi.
    access.addListener(
      () => billing.applyGrant(access.access.proTier, access.access.proUntil),
    );
    auth.addListener(() {
      if (auth.hasAccount == signedIn) return;
      signedIn = auth.hasAccount;
      if (signedIn) {
        unawaited(refreshAccess());
      } else {
        access.clear();
        // Ustoz roli faqat hisobli foydalanuvchiga: chiqishda talabaga qaytadi.
        if (settings.role == AppRole.teacher) {
          unawaited(settings.setRole(AppRole.student));
        }
      }
    });
    settings.addListener(() {
      if (settings.role == role && settings.language == language) return;
      role = settings.role;
      language = settings.language;
      access.profileChanged();
      if (auth.hasAccount) unawaited(refreshAccess());
    });
  }

  /// "Lokal ma'lumotlarni o'chirish": omborni tozalaydi va xotiradagi
  /// holatni boshlang'ichga qaytaradi.
  Future<void> deleteLocalData(Iterable<Locale> systemLocales) async {
    await store.clear();
    await auth.signOut();
    access.clear();
    bookmarks.resetInMemory();
    quizProgress.resetInMemory();
    exams.resetInMemory();
    reading.resetInMemory();
    toifa.resetInMemory();
    daily.resetInMemory();
    classroom.resetInMemory();
    topicTests.resetInMemory();
    ResumeHistory.of(store).resetInMemory();
    await reminders.reset();
    settings.resetToDefaults(systemLocales);
  }
}

class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.services, required super.child});

  final AppServices services;

  static AppServices of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!.services;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => services != oldWidget.services;
}

extension AppScopeX on BuildContext {
  AppServices get services => AppScope.of(this);
}
