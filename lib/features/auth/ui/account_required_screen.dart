import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/widgets/lg_page.dart';
import '../../../design/widgets/lg_widgets.dart';
import '../../../l10n/gen/app_localizations.dart';

/// Mehmon yopiq bo'limni ochmoqchi: ro'yxatdan o'tish kerak (Apple, Google yoki
/// email). Kirgach router o'zi dastlab so'ralgan sahifaga qaytaradi.
class AccountRequiredScreen extends StatelessWidget {
  const AccountRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return LgPage(
      title: l.accountRequiredTitle,
      showBrand: true,
      children: [
        LgStateView(
          key: const ValueKey('account-required'),
          kind: StateKind.empty,
          title: l.accountRequiredTitle,
          message: l.accountRequiredBody,
          actionLabel: l.accountRequiredCta,
          onAction: () => context.push('/profile/auth'),
          secondary: LgButton.secondary(
            label: l.accountRequiredHome,
            onPressed: () => context.go('/home'),
          ),
        ),
      ],
    );
  }
}
