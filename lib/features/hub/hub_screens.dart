import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../daily/daily_picker.dart';
import '../reference/reference_screens.dart' show DmedTodayCard;
import '../daily/daily_screens.dart' show DailyCard;
import '../daily/daily_streak.dart' show dateOfDay;
import '../settings/settings_controller.dart' show WorkDirection;
import '../toifa/toifa_bank.dart' show ToifaBank, toifaTestPool;

export '../reference/reference_screens.dart' show ProceduresScreen;

/// Ish joyi tabi (o'rtadagi katta tugma): ish yo'nalishi va unga moslangan
/// kunlik savollar. Kalkulyatorlar va ma'lumotnoma keyingi qadamda keladi.
/// Asosiy yo'nalishlar doim ko'rinadi; qo'shimchalari — faqat shu tilda
/// savoli bor bo'lsa (tarjimasiz yo'nalish inglizcha interfeysda yashirin).
const _baseDirections = {
  WorkDirection.nursing,
  WorkDirection.higher,
  WorkDirection.patronage,
  WorkDirection.dmed,
};

bool _directionShown(WorkDirection d, ToifaBank? bank) =>
    _baseDirections.contains(d) ||
    (bank != null && toifaTestPool(bank, scope: d.bank).isNotEmpty);

class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  static String directionLabel(AppLocalizations l, WorkDirection d) =>
      switch (d) {
        WorkDirection.nursing => l.workDirNursing,
        WorkDirection.higher => l.workDirHigher,
        WorkDirection.patronage => l.workDirPatronage,
        WorkDirection.obstetrics => l.workDirObstetrics,
        WorkDirection.radiology => l.workDirRadiology,
        WorkDirection.dmed => l.workDirDmed,
      };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final services = context.services;
    return ListenableBuilder(
      listenable: Listenable.merge([
        services.settings,
        services.daily,
        services.toifa,
      ]),
      builder: (context, _) {
        unawaited(services.toifa.ensureLoaded());
        final bank = services.toifa.bank;
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
                  if (_directionShown(d, bank))
                    LgChoiceChip(
                      key: ValueKey('work-dir-${d.bank}'),
                      label: directionLabel(l, d),
                      selected: d == direction,
                      onTap: () => services.settings.setWorkDirection(d),
                    ),
              ],
            ),
            if (direction != null)
              LgNotice(switch (kind) {
                _ when direction == WorkDirection.dmed => l.workTodayDmed,
                DailyKind.own => l.workTodayOwn,
                DailyKind.general => l.workTodayGeneral,
                DailyKind.mixed => l.workTodayMixed,
              }, kind: NoticeKind.info),
            if (direction == WorkDirection.dmed) const DmedTodayCard(),
            const DailyCard(),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l.workPlan,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            LgRow(
              key: const ValueKey('work-dmed'),
              title: l.dmedTitle,
              subtitle: l.dmedSub,
              icon: Icons.local_hospital_outlined,
              onTap: () => context.push('/library/dmed'),
              divider: false,
            ),
            LgSectionTitle(l.workVitalsTitle),
            LgPanel(
              key: const ValueKey('work-vitals'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _VitalRow(l.workVitalTemp, '36–37 °C'),
                  _VitalRow(l.workVitalPulse, '60–80 · ${l.workVitalPerMin}'),
                  _VitalRow(l.workVitalResp, '16–20 · ${l.workVitalPerMin}'),
                  const SizedBox(height: 8),
                  Text(
                    l.workVitalSource,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VitalRow extends StatelessWidget {
  const _VitalRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: text.bodyLarge)),
          Text(value, style: text.titleMedium),
        ],
      ),
    );
  }
}
