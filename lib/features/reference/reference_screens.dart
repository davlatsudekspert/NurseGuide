import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/links.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/glass_art.dart';
import '../../design/tokens.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../daily/daily_picker.dart';
import 'reference_data.dart';

String _lang(BuildContext context) =>
    Localizations.localeOf(context).languageCode;

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

/// Bitta qisqa eslatma: manba + (inglizchada) qadamlar o'zbekcha ekani.
String _procNote(AppLocalizations l, String lang) =>
    lang == 'en' ? l.procNoteUzText : l.procSourceNote;

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
            final lang = Localizations.localeOf(context).languageCode;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LgNotice(_procNote(l, lang), kind: NoticeKind.info),
                for (final g in groups) ...[
                  LgSectionTitle(
                    data.procedures
                        .firstWhere((p) => p.group == g)
                        .groupIn(lang),
                  ),
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
    final lang = Localizations.localeOf(context).languageCode;
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
          semanticLabel:
              '${def.titleIn(lang)}. ${l.procStepsCount(def.steps.length)}',
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
                        Text(def.titleIn(lang), style: text.titleMedium),
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
        final lang = Localizations.localeOf(context).languageCode;
        final goal = def.goalIn(lang);
        final indications = def.indicationsIn(lang);
        final contra = def.contraindicationsIn(lang);
        final equipment = def.equipmentIn(lang);
        final checklist = def.checklistIn(lang);
        final risks = def.risksIn(lang);
        return LgPage(
          title: def.titleIn(lang),
          subtitle: def.groupIn(lang),
          children: [
            LgNotice(_procNote(l, lang), kind: NoticeKind.info),
            if (goal.isNotEmpty) ...[
              LgSectionTitle(l.procGoal),
              Text(goal, style: text.bodyLarge),
            ],
            if (indications.isNotEmpty) ...[
              LgSectionTitle(l.procIndications),
              _Bullets(indications),
            ],
            if (contra.isNotEmpty) ...[
              LgSectionTitle(l.procContra),
              _Bullets(contra),
            ],
            if (equipment.isNotEmpty) ...[
              LgSectionTitle(l.procEquipment),
              _Bullets(equipment),
            ],
            LgSectionTitle(l.procSteps),
            LgSteps(def.stepsFor(lang)),
            if (checklist.isNotEmpty) ...[
              LgSectionTitle(l.procChecklist),
              _Checklist(key: ValueKey('check-$id'), items: checklist),
            ],
            if (risks.isNotEmpty) ...[
              LgSectionTitle(l.procRisks),
              _Bullets(risks),
            ],
            const SizedBox(height: 16),
            Text(localizedSource(def.source, lang), style: text.bodySmall),
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
                        Text('«${t.definition}»', style: text.bodyLarge),
                        const SizedBox(height: 8),
                        Text(
                          localizedSource(t.source, _lang(context)),
                          style: text.bodySmall,
                        ),
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

/// DMED tizimida ishlash bo'yicha savol-javob kartalari: guruh bo'yicha
/// saralanadi, qidiriladi; javob bosilganda ochiladi.
class DmedScreen extends StatefulWidget {
  const DmedScreen({super.key});

  @override
  State<DmedScreen> createState() => _DmedScreenState();
}

class _DmedScreenState extends State<DmedScreen> {
  String _query = '';
  String? _group;
  final _open = <String>{};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return LgPage(
      title: l.dmedTitle,
      subtitle: l.dmedSub,
      children: [
        FutureBuilder<ReferenceData>(
          future: ReferenceData.load(_bundle(context)),
          builder: (context, snap) {
            final data = snap.data;
            if (data == null) return const SizedBox(height: 120);
            final q = _query.trim().toLowerCase();
            final cards = [
              for (final c in data.dmed)
                if ((_group == null || c.group == _group) &&
                    (q.isEmpty ||
                        c.question.toLowerCase().contains(q) ||
                        c.answer.toLowerCase().contains(q)))
                  c,
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _uzbekNote(context),
                LgNotice(l.dmedNote, kind: NoticeKind.info),
                LgField(
                  key: const ValueKey('dmed-search'),
                  label: l.dmedSearch,
                  onChanged: (v) => setState(() => _query = v),
                ),
                // Bitta qatorda yon tomonga suriladi: 18 ta guruh ekranni
                // egallab, savollarni pastga itarib yubormasin.
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      for (final (id, title) in [
                        (null, l.dmedAllGroups),
                        for (final g in data.dmedGroups) (g.id, g.title),
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: LgChoiceChip(
                            key: ValueKey('dmed-group-${id ?? 'all'}'),
                            label: title,
                            selected: _group == id,
                            onTap: () => setState(() => _group = id),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(l.dmedCount(cards.length), style: text.bodySmall),
                ),
                if (cards.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(l.glossaryNothing, style: text.bodyMedium),
                  ),
                for (final c in cards)
                  LgPanel(
                    key: ValueKey('dmed-${c.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.question, style: text.titleMedium),
                        const SizedBox(height: 8),
                        if (_open.contains(c.id)) ...[
                          Text(c.answer, style: text.bodyLarge),
                          if (c.note != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              c.note!,
                              key: ValueKey('dmed-note-${c.id}'),
                              style: text.bodySmall!.copyWith(
                                color: LgPalette.of(context).amber,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                        ],
                        Align(
                          alignment: Alignment.centerLeft,
                          child: LgButton.secondary(
                            key: ValueKey('dmed-toggle-${c.id}'),
                            label: _open.contains(c.id)
                                ? l.dmedHide
                                : l.dmedShow,
                            onPressed: () => setState(() {
                              if (!_open.remove(c.id)) _open.add(c.id);
                            }),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizedSource(c.source, _lang(context)),
                          style: text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Ish joyi: DMED yo'nalishi tanlanganda bugungi 5 ta savol-javob (kunga
/// qarab aylanadi); javob bosilganda ochiladi.
class DmedTodayCard extends StatefulWidget {
  const DmedTodayCard({super.key});

  @override
  State<DmedTodayCard> createState() => _DmedTodayCardState();
}

class _DmedTodayCardState extends State<DmedTodayCard> {
  final _open = <String>{};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final day = context.services.daily.today;
    return FutureBuilder<ReferenceData>(
      future: ReferenceData.load(_bundle(context)),
      builder: (context, snap) {
        final data = snap.data;
        if (data == null) return const SizedBox(height: 24);
        final byId = {for (final c in data.dmed) c.id: c};
        final ids = pickDaily(
          priority: byId.keys,
          others: const [],
          day: day,
          seed: 17,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LgSectionTitle(l.dmedTodayTitle),
            for (final id in ids)
              LgPanel(
                key: ValueKey('dmed-today-$id'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(byId[id]!.question, style: text.titleMedium),
                    const SizedBox(height: 8),
                    if (_open.contains(id)) ...[
                      Text(byId[id]!.answer, style: text.bodyLarge),
                      if (byId[id]!.note != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          byId[id]!.note!,
                          style: text.bodySmall!.copyWith(
                            color: LgPalette.of(context).amber,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        localizedSource(byId[id]!.source, _lang(context)),
                        style: text.bodySmall,
                      ),
                      const SizedBox(height: 8),
                    ],
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LgButton.secondary(
                        key: ValueKey('dmed-today-toggle-$id'),
                        label: _open.contains(id) ? l.dmedHide : l.dmedShow,
                        onPressed: () => setState(() {
                          if (!_open.remove(id)) _open.add(id);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            LgButton.secondary(
              key: const ValueKey('dmed-all'),
              label: l.dmedAll,
              icon: Icons.local_hospital_outlined,
              onPressed: () => context.push('/library/dmed'),
            ),
          ],
        );
      },
    );
  }
}

/// Adabiyotlar: kitob, rasmiy hujjat va ochiq manbalar — har birining ostida
/// ilovadagi nechta savol/muolaja/atama unga tayanishi (avtomatik hisob).
class LiteratureScreen extends StatelessWidget {
  const LiteratureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return LgPage(
      title: l.litTitle,
      subtitle: l.litSub,
      children: [
        FutureBuilder<ReferenceData>(
          future: ReferenceData.load(_bundle(context)),
          builder: (context, snap) {
            final data = snap.data;
            if (data == null) return const SizedBox(height: 120);
            final usage = data.usage();
            final groups = [
              ('textbooks', l.litTextbooks),
              ('official', l.litOfficial),
              ('open', l.litOpen),
              ('other', l.litOther),
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _uzbekNote(context),
                LgNotice(l.litNote, kind: NoticeKind.info),
                for (final (id, label) in groups)
                  if (usage.any((u) => u.entry.group == id)) ...[
                    LgSectionTitle(label),
                    for (final u in usage.where((u) => u.entry.group == id))
                      _LiteratureCard(usage: u),
                  ],
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _LiteratureCard extends StatelessWidget {
  const _LiteratureCard({required this.usage});

  final LiteratureUsage usage;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    final e = usage.entry;
    final who = [
      if (e.author.isNotEmpty) e.author,
      if (e.year != null) '${e.year}',
    ].join(', ');
    final topics = usage.topics(l.procTitle, l.glossaryTitle, 'DMED');
    final relies = [
      if (usage.questions.isNotEmpty) l.litQuestionsN(usage.questions.length),
      if (usage.procedures.isNotEmpty)
        l.litProceduresN(usage.procedures.length),
      if (usage.terms.isNotEmpty) l.litTermsN(usage.terms.length),
      if (usage.cards.isNotEmpty) l.litCardsN(usage.cards.length),
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LgRadius.card),
          boxShadow: LgShadow.card(context),
        ),
        child: LgPressable(
          key: ValueKey('lit-${e.id}'),
          onTap: () => context.push('/library/literature/${e.id}'),
          color: p.paper,
          border: LgShadow.rim(context),
          borderRadius: BorderRadius.circular(LgRadius.card),
          semanticLabel: '${e.title}. $relies',
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(e.title, style: text.titleMedium)),
                      if (e.main) LgTag(l.litMainBadge),
                    ],
                  ),
                  if (who.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(who, style: text.bodyMedium),
                  ],
                  if (e.publisher.isNotEmpty)
                    Text(e.publisher, style: text.bodySmall),
                  const SizedBox(height: 10),
                  Text(
                    '${l.litRelies}: $relies',
                    style: text.bodyMedium!.copyWith(
                      color: p.ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (topics.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${l.litTopics}: ${topics.join(', ')}',
                      style: text.bodySmall,
                    ),
                  ],
                  if (e.license != null || e.url != null) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (e.license != null)
                          LgTag('${l.litLicense}: ${e.license}'),
                        if (e.url != null)
                          LgTag(
                            e.url!
                                .replaceFirst('https://', '')
                                .split('/')
                                .first,
                            icon: Icons.open_in_new_rounded,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bitta manbaga tayangan savollar, muolajalar va atamalar ro'yxati.
class LiteratureDetailScreen extends StatelessWidget {
  const LiteratureDetailScreen({super.key, required this.id});

  final String id;

  static const _maxQuestions = 80;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return FutureBuilder<ReferenceData>(
      future: ReferenceData.load(_bundle(context)),
      builder: (context, snap) {
        final data = snap.data;
        if (data == null) return LgPage(title: l.litTitle, children: const []);
        final usage = data.usage().where((u) => u.entry.id == id).firstOrNull;
        if (usage == null) {
          return LgPage(
            title: l.litTitle,
            children: [
              LgStateView(
                kind: StateKind.empty,
                title: l.litTitle,
                message: l.litDetailEmpty,
              ),
            ],
          );
        }
        final e = usage.entry;
        final shown = usage.questions.take(_maxQuestions).toList();
        return LgPage(
          title: e.title,
          subtitle: [
            if (e.author.isNotEmpty) e.author,
            if (e.year != null) '${e.year}',
          ].join(', '),
          children: [
            _uzbekNote(context),
            if (e.url != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: LgButton.secondary(
                  key: const ValueKey('lit-open'),
                  label: l.litOpenLink,
                  icon: Icons.open_in_new_rounded,
                  onPressed: () => openExternalLink(context, e.url!),
                ),
              ),
            if (e.license != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LgTag('${l.litLicense}: ${e.license}'),
              ),
            if (usage.procedures.isNotEmpty) ...[
              LgSectionTitle(l.procTitle),
              for (final p in usage.procedures)
                LgRow(
                  title: p.title,
                  subtitle: l.procStepsCount(p.steps.length),
                  icon: Icons.checklist_rounded,
                  onTap: () => context.push('/procedures/${p.id}'),
                ),
            ],
            if (usage.terms.isNotEmpty) ...[
              LgSectionTitle(l.glossaryTitle),
              Text(
                usage.terms.map((t) => t.term).join(' · '),
                style: text.bodyLarge,
              ),
            ],
            if (usage.cards.isNotEmpty)
              LgRow(
                key: const ValueKey('lit-dmed-open'),
                title: l.dmedTitle,
                subtitle: l.litCardsN(usage.cards.length),
                icon: Icons.local_hospital_outlined,
                onTap: () => context.push('/library/dmed'),
              ),
            if (usage.questions.isNotEmpty) ...[
              LgSectionTitle(l.litQuestionsN(usage.questions.length)),
              for (final q in shown)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(q.text, style: text.bodyMedium),
                ),
              if (usage.questions.length > shown.length)
                Text(
                  l.litMore(usage.questions.length - shown.length),
                  style: text.bodySmall,
                ),
            ],
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
