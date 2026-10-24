import 'package:material_ui/material_ui.dart';

import '../../l10n/gen/app_localizations.dart';
import '../tokens.dart';

/// Toifa va test sahifalari tagida yumshoq yozuv: savollar o'quv materiali,
/// imtihonda aynan shular tushishiga kafolat yo'q.
class NoGuaranteeNote extends StatelessWidget {
  const NoGuaranteeNote({super.key});

  @override
  Widget build(BuildContext context) {
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Container(
        key: const ValueKey('toifa-no-guarantee'),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: p.soft,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.menu_book_outlined, size: 18, color: p.sub),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppLocalizations.of(context).toifaNoGuarantee,
                style: text.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
