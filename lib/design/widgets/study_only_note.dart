import 'package:material_ui/material_ui.dart';

import '../../l10n/gen/app_localizations.dart';

/// O'quv materiali ekanini eslatuvchi qisqa yozuv (davolash yo'riqnomasi emas).
class StudyOnlyNote extends StatelessWidget {
  const StudyOnlyNote({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        AppLocalizations.of(context).studyOnlyNote,
        key: const ValueKey('study-only-note'),
        style: text.bodySmall,
      ),
    );
  }
}
