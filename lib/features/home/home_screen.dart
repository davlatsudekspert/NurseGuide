import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/shell.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/glass_art.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/ui/role_screen.dart';
import '../auth/ui/welcome_screen.dart';
import '../classroom/general_test_screen.dart' show generalTestLocation;
import '../classroom/lecture_catalog.dart';
import '../classroom/topic_test_screens.dart' show AssignedTestsCard;
import '../daily/daily_screens.dart';
import '../settings/settings_controller.dart';
import '../toifa/toifa_screens.dart';
import '../toifa/toifa_today.dart' show ToifaTodayCard;
import 'resume_history.dart';

/// Bosh sahifadagi bitta tezkor amal.
class HomeAction {
  const HomeAction(this.label, this.icon, this.location, this.caption);

  final String label;
  final IconData icon;

  /// Kartadagi bir qatorli izoh: ichida nima borligini aytadi.
  final String caption;

  /// `openInTab` bilan ochiladi: tegishli tab o'z stacki bilan tanlanadi.
  final String location;

  /// "Tiniq shisha" mavzusidagi 3D belgi (manzil bo'yicha).
  LgArt get art => switch (location) {
    '/procedures' => LgArt.syringe,
    '/workplace' => LgArt.stethoscope,
    '/library/saved' => LgArt.book,
    '/learn/lecture' => LgArt.clipboard,
    '/learn/quiz' => LgArt.droplet,
    '/learn/exam' => LgArt.clipboard,
    '/learn/classes' => LgArt.book,
    _ => location.startsWith('/toifa') ? LgArt.cap : LgArt.heart,
  };
}

/// Rolga mos bosh sahifa tarkibi. Rol faqat ustuvorlikni o'zgartiradi —
/// kontent va ruxsatlar hamma uchun bir xil.
///
/// * hamshira — toifa + manipulyatsiyalar;
/// * talaba — darslar + testlar;
/// * ustoz — guruhlar.
class RoleHome {
  const RoleHome({
    required this.heroTitle,
    required this.heroBody,
    required this.heroCta,
    required this.heroLocation,
    required this.actions,
  });

  final String heroTitle;
  final String heroBody;

  /// Hero tugmasi: oxirgi ochilgan narsa bo'lmasa — rolning boshlang'ich
  /// amali. Tarix bo'lsa — “Davom ettirish”.
  final String heroCta;
  final String heroLocation;
  final List<HomeAction> actions;

  static RoleHome of(AppRole role, AppLocalizations l, {bool toifa = true}) =>
      switch (role) {
        AppRole.nurse => RoleHome(
          heroTitle: l.homeHeroNurseTitle,
          heroBody: l.homeHeroNurseBody,
          heroCta: toifa ? l.homeHeroNurseCta : l.homeHeroStudentCta,
          heroLocation: toifa ? toifaBase : '/learn/daily',
          actions: [
            if (toifa)
              HomeAction(
                l.toifaTitle,
                Icons.workspace_premium_outlined,
                toifaBase,
                l.homeTileToifa,
              ),
            HomeAction(
              l.navProcedures,
              Icons.vaccines_outlined,
              '/procedures',
              l.homeTileProcedures,
            ),
            HomeAction(
              l.navWorkplace,
              Icons.work_outline_rounded,
              '/workplace',
              l.homeTileWorkplace,
            ),
            HomeAction(
              l.featureSaved,
              Icons.bookmark_outline,
              '/library/saved',
              l.homeTileSaved,
            ),
          ],
        ),
        AppRole.student => RoleHome(
          heroTitle: l.homeHeroStudentTitle,
          heroBody: l.homeHeroStudentBody,
          heroCta: l.homeHeroStudentCta,
          heroLocation: '/learn/daily',
          actions: [
            HomeAction(
              l.featureLessons,
              Icons.co_present_outlined,
              '/learn/lecture',
              l.homeTileLessons,
            ),
            HomeAction(
              l.featureTests,
              Icons.quiz_outlined,
              '/learn/quiz',
              l.homeTileTests,
            ),
            HomeAction(
              l.featureExam,
              Icons.timer_outlined,
              '/learn/exam',
              l.homeTileExam,
            ),
            HomeAction(
              l.featureClasses,
              Icons.groups_outlined,
              '/learn/classes',
              l.homeTileClasses,
            ),
          ],
        ),
        AppRole.teacher => RoleHome(
          heroTitle: l.homeHeroTeacherTitle,
          heroBody: l.homeHeroTeacherBody,
          heroCta: l.homeHeroTeacherCta,
          heroLocation: '/learn/classes',
          actions: [
            HomeAction(
              l.featureClasses,
              Icons.groups_outlined,
              '/learn/classes',
              l.homeTileClasses,
            ),
            HomeAction(
              l.classesGiveGeneralTest,
              Icons.add_task_rounded,
              generalTestLocation,
              l.generalTestSub,
            ),
            // Ma'ruza rejimi (D-45/47).
            HomeAction(
              l.lectureTitle,
              Icons.slideshow_rounded,
              '/learn/lecture',
              l.homeTileLecture,
            ),
            HomeAction(
              l.featureSaved,
              Icons.bookmark_outline,
              '/library/saved',
              l.homeTileSaved,
            ),
          ],
        ),
      };
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.services.settings;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final l = AppLocalizations.of(context);
        final role = settings.effectiveRole;
        final toifa = toifaVisible(context);
        final config = RoleHome.of(role, l, toifa: toifa);
        return LgPage(
          // Rol almashganda sarlavha holati ham yangidan boshlanadi.
          key: ValueKey(role),
          title: l.homeTitle,
          eyebrow: role.title(l),
          showBrand: true,
          compactTitle: true,
          children: [
            // Asosiy "ilgak": bugungi 5 ta savol — eng tepada, bitta katta tugma.
            const DailyCard(),
            // Oxirgi ochilgan joydan davom etish (tarix bo'lsa).
            _HomeHero(config: config, role: role),
            // Rolning tezkor kartalari.
            LgTwoColumnGrid(
              children: [
                for (var i = 0; i < config.actions.length; i++)
                  LgFadeIn(
                    delay: i * 0.08,
                    child: LgTile(
                      title: config.actions[i].label,
                      caption: config.actions[i].caption,
                      icon: config.actions[i].icon,
                      art: config.actions[i].art,
                      highlighted: i == 0,
                      onTap: () => openInTab(
                        context,
                        config.actions[i].location,
                        exact: true,
                      ),
                    ),
                  ),
              ],
            ),
            // Talabaga guruhda berilgan testlar (muddati bilan).
            const AssignedTestsCard(),
            // Toifa: hamshira uchun kirish kartasi, ochilgach — "Bugun".
            if (toifa) _ToifaHomeSlot(nurse: role == AppRole.nurse),
          ],
        );
      },
    );
  }
}

/// Bosh sahifa hero kartasi (D-69 Q3): “Davom ettirish” — oxirgi ochilgan
/// taqdimot, mavzu testi yoki bo'lim (shu qurilma tarixi); tarix bo'lmasa —
/// rolning boshlang'ich amali: talaba — kunlik savollar, ustoz — guruhlar,
/// hamshira — toifa tayyorgarligi (toifa ko'rinsa).
class _HomeHero extends StatelessWidget {
  const _HomeHero({required this.config, required this.role});

  final RoleHome config;
  final AppRole role;

  @override
  Widget build(BuildContext context) {
    final services = context.services;
    final history = ResumeHistory.of(services.store);
    final bundle = services.curriculum.bundle ?? rootBundle;
    return ListenableBuilder(
      listenable: history,
      builder: (context, _) {
        final last = history.last;
        if (last == null || !last.fullScreen) return _card(context, last, null);
        return FutureBuilder<DeckCatalog>(
          future: DeckCatalog.load(bundle),
          initialData: DeckCatalog.peek(bundle),
          builder: (context, snap) => _card(context, last, snap.data),
        );
      },
    );
  }

  Widget _card(BuildContext context, ResumeEntry? last, DeckCatalog? catalog) {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    // Toifa bo'limi yopiq foydalanuvchiga toifa yozuvi ko'rsatilmaydi.
    final usable =
        last != null &&
        !(last.kind == ResumeKind.section &&
            last.id == 'toifa' &&
            !toifaVisible(context));
    final title = usable ? resumeTitle(last, l, lang, catalog) : null;
    final location = usable ? last.location : null;
    if (title != null && location != null) {
      final fullScreen = last!.fullScreen;
      return LgHeroCard(
        compact: true,
        image: kHeroImage,
        title: config.heroTitle,
        body: l.homeResumeBody(title),
        action: LgButton(
          key: const ValueKey('home-hero-cta'),
          label: l.homeResumeCta,
          icon: Icons.play_arrow_rounded,
          // Bo'lim — o'z tabida, ichkaridagi ochiq sahifasi bilan
          // (stek tiklanadi); taqdimot va test — to'liq ekran.
          onPressed: () => fullScreen
              ? context.push(location)
              : openInTab(context, location),
        ),
      );
    }
    // Hamshira: boshlang'ich amal (toifa) tezkor kartada allaqachon bor —
    // bir xil narsani ikki marta ko'rsatmaymiz.
    if (role == AppRole.nurse) return const SizedBox.shrink();
    return LgHeroCard(
      compact: true,
      image: kHeroImage,
      title: config.heroTitle,
      body: config.heroBody,
      action: LgButton(
        key: const ValueKey('home-hero-cta'),
        label: config.heroCta,
        onPressed: () => openInTab(context, config.heroLocation),
      ),
    );
  }
}

/// Bosh sahifadagi toifa kartasi: bo'lim hali ochilmagan hamshiraga —
/// kirish kartasi; ochilgan bo'lsa (har qanday rol) — "Bugun" kartasi.
class _ToifaHomeSlot extends StatelessWidget {
  const _ToifaHomeSlot({required this.nurse});

  final bool nurse;

  @override
  Widget build(BuildContext context) {
    final toifa = context.services.toifa;
    return ListenableBuilder(
      listenable: toifa,
      builder: (context, _) => toifa.opened
          ? const ToifaTodayCard(compact: true)
          : nurse
          ? const ToifaEntryCard(compact: true)
          : const SizedBox.shrink(),
    );
  }
}
