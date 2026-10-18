import 'package:material_ui/material_ui.dart';

import '../../../app/app_scope.dart';
import '../../../app/widgets/links.dart';
import '../../../design/tokens.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../content_model.dart';

/// Manba: raqam, nashriyot, sarlavha, sanalar, yurisdiksiya. Veb-manba
/// havolasini ochish yoki nusxalash mumkin; kitob/qo'llanma uchun
/// mualliflar, yil va til ko'rsatiladi.
class SourceTile extends StatelessWidget {
  const SourceTile({super.key, required this.index, required this.source});

  final int index;
  final ContentSource source;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    final item = source.libraryItemId == null
        ? null
        : context.services.content.pack?.libraryItem(source.libraryItemId!);
    final meta = [
      if (item != null) ...[
        if (item.authors.isNotEmpty) item.authors.join(', '),
        if (item.year != null) '${item.year}',
        item.language.toUpperCase(),
      ],
      if (source.accessed != null) l.sourceAccessed(source.accessed!),
      ?source.sourceDate,
      ?source.jurisdiction,
    ].join(' · ');
    final url = source.url;
    final title = Text(
      '[$index] ${source.publisher} · ${source.title}',
      // Iqtibos — mazmundan "balandroq" ko'rinmasin: 14 px, oddiy matn
      // rangi; havola ekanini o'ngdagi ikonka aytadi.
      style: text.bodyMedium!.copyWith(color: p.ink, height: 1.45),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (url == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: title,
            )
          else
            InkWell(
              onTap: () => openExternalLink(context, url),
              onLongPress: () => copyLink(context, url),
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: kMinTap),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: title),
                      const SizedBox(width: 6),
                      Icon(Icons.open_in_new_rounded, size: 18, color: p.brand),
                    ],
                  ),
                ),
              ),
            ),
          if (meta.isNotEmpty) Text(meta, style: text.bodySmall),
          if (source.note != null) Text(source.note!, style: text.bodySmall),
          Text(
            source.isCitationOnlyBook
                ? l.sourceReuseCitationOnly
                : item == null
                ? l.sourceReuseRightsVerify
                : rightsLabel(item.rights.distribution, l),
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}

String rightsLabel(DistributionRights r, AppLocalizations l) => switch (r) {
  DistributionRights.unknown => l.rightsUnknown,
  DistributionRights.personalOnly => l.rightsPersonal,
  DistributionRights.permitted => l.rightsPermitted,
  DistributionRights.denied => l.rightsDenied,
};
