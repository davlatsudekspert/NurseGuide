import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/app_scope.dart';
import '../../../app/widgets/lg_page.dart';
import '../../../design/tokens.dart';
import '../../../design/widgets/lg_widgets.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../settings/settings_controller.dart';

extension AppRoleText on AppRole {
  String title(AppLocalizations l) => switch (this) {
    AppRole.nurse => l.roleNurse,
    AppRole.student => l.roleStudent,
    AppRole.teacher => l.roleTeacher,
  };

  String description(AppLocalizations l) => switch (this) {
    AppRole.nurse => l.roleNurseDesc,
    AppRole.student => l.roleStudentDesc,
    AppRole.teacher => l.roleTeacherDesc,
  };

  IconData get icon => switch (this) {
    AppRole.nurse => Icons.badge_outlined,
    AppRole.student => Icons.school_outlined,
    AppRole.teacher => Icons.co_present_outlined,
  };
}

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key, required this.onboarding});

  /// Onboardingda "Davom etish" bosh sahifaga olib boradi; profildan
  /// ochilganda tanlov saqlanib, oldingi ekranga qaytadi.
  final bool onboarding;

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  late AppRole _selected = context.services.settings.effectiveRole;

  bool _busy = false;
  bool _teacherFailed = false;

  /// Ustoz roli — faqat hisobli (email/Google/Apple) foydalanuvchiga va
  /// faqat server tasdiqlagandan keyin (D-42: o'z-o'zini ro'yxatdan o'tkazish,
  /// huquq — faqat o'z guruhlari). Mehmon uchun karta qulflangan.
  bool get _teacherAvailable {
    final s = context.services;
    return s.backend.isConfigured && s.auth.hasAccount && _teacherPlan;
  }

  /// Ustoz (guruhlar) obunasi bor (billing o'chiq bo'lsa — doim). Talaba
  /// o'z profilini ustozga o'tkaza olmaydi.
  bool get _teacherPlan =>
      context.services.billing.allows('/learn/classes/new');

  Future<void> _continue() async {
    final services = context.services;
    final settings = services.settings;
    if (_selected == AppRole.teacher) {
      if (!_teacherAvailable) return;
      setState(() {
        _busy = true;
        _teacherFailed = false;
      });
      var confirmed = services.access.access.teacher;
      try {
        if (!confirmed) {
          await services.backend.registerTeacher();
          await services.refreshAccess();
          confirmed = services.access.access.teacher;
        }
      } on Object {
        confirmed = false;
      }
      if (!mounted) return;
      setState(() {
        _busy = false;
        _teacherFailed = !confirmed;
      });
      // Server tasdiqlamasa — rol o'zgarmaydi.
      if (!confirmed) return;
    }
    await settings.setRole(_selected);
    if (widget.onboarding) {
      // Router redirect onboarding tugagach /home ga olib o'tadi.
      await settings.completeOnboarding();
    } else if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return LgPage(
      title: l.rolesTitle,
      subtitle: l.rolesSubtitle,
      showProfile: false,
      children: [
        for (final role in AppRole.values)
          RoleCard(
            role: role,
            selected: role == _selected,
            locked: role == AppRole.teacher && !_teacherAvailable,
            onTap: () => setState(() {
              _selected = role;
              _teacherFailed = false;
            }),
          ),
        if (!_teacherAvailable)
          LgNotice(
            context.services.auth.hasAccount && !_teacherPlan
                ? l.rolesTeacherNeedsPlan
                : l.rolesTeacherSignInNote,
            key: const ValueKey('role-teacher-note'),
            kind: NoticeKind.info,
          )
        else if (_selected == AppRole.teacher)
          LgNotice(
            _teacherFailed ? l.rolesTeacherFailed : l.rolesTeacherRegisterNote,
            key: const ValueKey('role-teacher-note'),
            kind: _teacherFailed ? NoticeKind.warning : NoticeKind.info,
          ),
        LgNotice(l.rolesNote, kind: NoticeKind.info),
        const SizedBox(height: 8),
        LgButton(
          key: const ValueKey('role-continue'),
          label: l.actionContinue,
          busy: _busy,
          onPressed: _continue,
        ),
      ],
    );
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.role,
    required this.selected,
    required this.onTap,
    this.locked = false,
  });

  final AppRole role;
  final bool selected;
  final VoidCallback onTap;

  /// Qulflangan karta (masalan, mehmon uchun “Ustoz”): tanlanmaydi.
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? p.brand : Colors.transparent,
            width: 2,
          ),
        ),
        child: LgPressable(
          onTap: locked ? null : onTap,
          selected: selected && !locked,
          color: selected && !locked ? p.soft : p.paper,
          borderRadius: BorderRadius.circular(18),
          semanticLabel:
              '${role.title(l)}. ${locked ? l.rolesTeacherLocked : role.description(l)}',
          child: ExcludeSemantics(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: selected ? p.paper : p.soft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(role.icon, color: p.brand, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(role.title(l), style: text.titleMedium),
                        const SizedBox(height: 3),
                        Text(
                          locked ? l.rolesTeacherLocked : role.description(l),
                          style: text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    locked
                        ? Icons.lock_outline_rounded
                        : selected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected && !locked ? p.brand : p.outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
