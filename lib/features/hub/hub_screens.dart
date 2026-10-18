import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/widgets/lg_page.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';

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

/// Ish joyi tabi (o'rtadagi katta tugma). Kontent 4-bosqichda keladi.
class WorkplaceScreen extends StatelessWidget {
  const WorkplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return LgPage(
      title: l.workTitle,
      subtitle: l.workSub,
      showBrand: true,
      children: [
        LgStateView(
          key: const ValueKey('workplace-empty'),
          kind: StateKind.empty,
          title: l.workEmptyTitle,
          message: l.workEmptyBody,
          actionLabel: l.hubGoLearn,
          onAction: () => context.go('/learn'),
        ),
      ],
    );
  }
}
