import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/glass_art.dart';
import '../../design/tokens.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'reference_data.dart';

AssetBundle _bundle(BuildContext context) =>
    context.services.curriculum.bundle ?? rootBundle;

LgArt _artFor(String group) {
  if (group.startsWith('Inyeksiya')) return LgArt.syringe;
  if (group.startsWith('Hayotiy')) return LgArt.heart;
  if (group.startsWith('Tozalash')) return LgArt.droplet;
  return LgArt.clipboard;
}

/// Ma'lumotnoma matni o'zbekcha: ru/en interfeysda shu haqda izoh.
Widget _uzbekNote(BuildContext context) {
  final lang = Localizations.localeOf(context).languageCode;
  if (lang == 'uz') return const SizedBox.shrink();
  return LgNotice(
    AppLocalizations.of(context).refUzbekOnly,
    kind: NoticeKind.info,
  );
}

/// Manipulyatsiyalar tabi: guruhlar bo'yicha muolajalar ro'yxati.
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
        FutureBuilder<ReferenceData>(
          future: ReferenceData.load(_bundle(context)),
          builder: (context, snap) {
            if (snap.hasError) {
              return LgStateView(
                key: const ValueKey('procedures-empty'),
                kind: StateKind.empty,
                title: l.procEmptyTitle,
                message: l.procEmptyBody,
              );
            }
            final data = snap.data;
            if (data == null) return const SizedBox(height: 120);
            final groups = <String>[];
            for (final p in data.procedures) {
              if (!groups.contains(p.group)) groups.add(p.group);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _uzbekNote(context),
                LgNotice(l.procSourceNote, kind: NoticeKind.info),
                for (final g in groups) ...[
                  LgSectionTitle(g),
                  for (final p in data.procedures.where((p) => p.group == g))
                    _ProcedureCard(def: p),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProcedureCard extends StatelessWidget {
  const _ProcedureCard({required this.def});

  final ProcedureDef def;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LgRadius.card),
          boxShadow: LgShadow.card(context),
        ),
        child: LgPressable(
          key: ValueKey('proc-${def.id}'),
          onTap: () => context.push('/procedures/${def.id}'),
          color: p.paper,
          border: LgShadow.rim(context),
          borderRadius: BorderRadius.circular(LgRadius.card),
          semanticLabel: '${def.title}. ${l.procStepsCount(def.steps.length)}',
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: LgArtTile(_artFor(def.group), size: 52, dark: dark),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(def.title, style: text.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          l.procStepsCount(def.steps.length),
                          style: text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                ExcludeSemantics(
                  child: Icon(Icons.chevron_right_rounded, color: p.sub),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bitta muolaja: maqsad, jihozlar, qadamlar, tekshiruv ro'yxati, xavflar, manba.
class ProcedureDetailScreen extends StatelessWidget {
  const ProcedureDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return FutureBuilder<ReferenceData>(
      future: ReferenceData.load(_bundle(context)),
      builder: (context, snap) {
        final def = snap.data?.procedure(id);
        if (snap.hasData && def == null || snap.hasError) {
          return LgPage(
            title: l.procTitle,
            children: [
              LgStateView(
                kind: StateKind.empty,
                title: l.procNotFound,
                message: l.procEmptyBody,
              ),
            ],
          );
        }
        if (def == null) return LgPage(title: l.procTitle, children: const []);
        final text = Theme.of(context).textTheme;
        return LgPage(
          title: def.title,
          subtitle: def.group,
          children: [
            _uzbekNote(context),
            LgNotice(l.procSourceNote, kind: NoticeKind.info),
            if (def.goal.isNotEmpty) ...[
              LgSectionTitle(l.procGoal),
              Text(def.goal, style: text.bodyLarge),
            ],
            if (def.indications.isNotEmpty) ...[
              LgSectionTitle(l.procIndications),
              _Bullets(def.indications),
            ],
            if (def.contraindications.isNotEmpty) ...[
              LgSectionTitle(l.procContra),
              _Bullets(def.contraindications),
            ],
            if (def.equipment.isNotEmpty) ...[
              LgSectionTitle(l.procEquipment),
              _Bullets(def.equipment),
            ],
            LgSectionTitle(l.procSteps),
            LgSteps(def.steps),
            if (def.checklist.isNotEmpty) ...[
              LgSectionTitle(l.procChecklist),
              _Checklist(key: ValueKey('check-$id'), items: def.checklist),
            ],
            if (def.risks.isNotEmpty) ...[
              LgSectionTitle(l.procRisks),
              _Bullets(def.risks),
            ],
            const SizedBox(height: 16),
            Text(def.source, style: text.bodySmall),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets(this.items);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final it in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9, right: 12),
                  child: ExcludeSemantics(
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: p.brand,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Text(it, style: text.bodyLarge)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Belgilash ro'yxati: faqat shu ekran ochiq turganda, hech narsa saqlanmaydi.
class _Checklist extends StatefulWidget {
  const _Checklist({super.key, required this.items});

  final List<String> items;

  @override
  State<_Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<_Checklist> {
  final _done = <int>{};

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final (i, it) in widget.items.indexed)
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(
              () => _done.contains(i) ? _done.remove(i) : _done.add(i),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: kMinTap),
              child: Row(
                children: [
                  Checkbox(
                    value: _done.contains(i),
                    onChanged: (v) =>
                        setState(() => v! ? _done.add(i) : _done.remove(i)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(it, style: text.bodyLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Atamalar lug'ati: qidiruv va darslikdagi aniq ta'riflar.
class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return LgPage(
      title: l.glossaryTitle,
      subtitle: l.glossarySub,
      children: [
        FutureBuilder<ReferenceData>(
          future: ReferenceData.load(_bundle(context)),
          builder: (context, snap) {
            final data = snap.data;
            if (data == null) return const SizedBox(height: 120);
            final q = _query.trim().toLowerCase();
            final terms = [
              for (final t in data.glossary)
                if (q.isEmpty ||
                    t.term.toLowerCase().contains(q) ||
                    t.definition.toLowerCase().contains(q))
                  t,
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _uzbekNote(context),
                LgField(
                  key: const ValueKey('glossary-search'),
                  label: l.glossarySearch,
                  onChanged: (v) => setState(() => _query = v),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l.glossaryCount(terms.length),
                    style: text.bodySmall,
                  ),
                ),
                if (terms.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(l.glossaryNothing, style: text.bodyMedium),
                  ),
                for (final t in terms)
                  LgPanel(
                    key: ValueKey('term-${t.term}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.term, style: text.titleMedium),
                        const SizedBox(height: 4),
                        Text(t.definition, style: text.bodyLarge),
                        const SizedBox(height: 8),
                        Text(t.source, style: text.bodySmall),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
