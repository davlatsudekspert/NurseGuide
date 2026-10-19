import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../daily/daily_picker.dart';
import '../daily/daily_screens.dart' show DailyCard;
import '../daily/daily_streak.dart' show dateOfDay;
import '../settings/settings_controller.dart' show WorkDirection;

/// Manipulyatsiyalar tabi. Kontent 4-bosqichda keladi; hozircha — to'g'ri
/// bo'sh holat (ishlayotgandek ko'rsatilmaydi).
class ProceduresScreen extends StatelessWidget {
  const ProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return LgPage(
      title: l.procTitle,
      subtitle: l.procSub,
      showBrand: true,
      children: [
        LgStateView(
          key: const ValueKey('procedures-empty'),
          kind: StateKind.empty,
          title: l.procEmptyTitle,
          message: l.procEmptyBody,
          actionLabel: l.hubGoLearn,
          onAction: () => context.go('/learn'),
        ),
      ],
    );
  }
}

/// Ish joyi tabi (o'rtadagi katta tugma): ish yo'nalishi va unga moslangan
/// kunlik savollar. Kalkulyatorlar va ma'lumotnoma keyingi qadamda keladi.
class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  static String directionLabel(AppLocalizations l, WorkDirection d) =>
      switch (d) {
        WorkDirection.nursing => l.workDirNursing,
        WorkDirection.higher => l.workDirHigher,
        WorkDirection.patronage => l.workDirPatronage,
      };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final services = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([services.settings, services.daily]),
      builder: (context, _) {
        final direction = services.settings.workDirection;
        final kind = dailyKindFor(dateOfDay(services.daily.today).weekday);
        return LgPage(
          title: l.workTitle,
          subtitle: l.workSub,
          showBrand: true,
          children: [
            LgSectionTitle(l.workDirTitle),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                direction == null ? l.workDirPick : l.workDirHint,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final d in WorkDirection.values)
                  LgChoiceChip(
                    key: ValueKey('work-dir-${d.bank}'),
                    label: directionLabel(l, d),
                    selected: d == direction,
                    onTap: () => services.settings.setWorkDirection(d),
                  ),
              ],
            ),
            if (direction != null)
              LgNotice(
                switch (kind) {
                  DailyKind.own => l.workTodayOwn,
                  DailyKind.general => l.workTodayGeneral,
                  DailyKind.mixed => l.workTodayMixed,
                },
                kind: NoticeKind.info,
              ),
            const DailyCard(),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l.workPlan,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            LgNotice(
              l.workEmptyBody,
              key: const ValueKey('workplace-empty'),
              kind: NoticeKind.info,
            ),
          ],
        );
      },
    );
  }
}
