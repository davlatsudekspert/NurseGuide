import 'package:material_ui/material_ui.dart';

import '../../l10n/gen/app_localizations.dart';

/// Toifa va test sahifalari tagida kichik yozuv: savollar o'quv materiali,
/// imtihonda aynan shular tushishiga kafolat yo'q.
class NoGuaranteeNote extends StatelessWidget {
  const NoGuaranteeNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        AppLocalizations.of(context).toifaNoGuarantee,
        key: const ValueKey('toifa-no-guarantee'),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
