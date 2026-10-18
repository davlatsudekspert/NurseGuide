import 'package:material_ui/material_ui.dart';

import '../../l10n/gen/app_localizations.dart';
import '../toifa/toifa_screens.dart' show toifaBase;

/// Bosh sahifadagi “Davom ettirish” uchun bo'lim: oxirgi ochilgan tab
/// bo'limi (toifa, imtihon, mashq, guruhlar, ...).
class SearchSection {
  const SearchSection({
    required this.id,
    required this.route,
    required this.icon,
    required this.title,
  });

  final String id;

  /// `openInTab(..., exact: true)` bilan ochiladigan manzil.
  final String route;
  final IconData icon;
  final String Function(AppLocalizations l) title;
}

/// Bo'limlar ro'yxati.
const kSearchSections = <SearchSection>[
  SearchSection(
    id: 'toifa',
    route: toifaBase,
    icon: Icons.workspace_premium_outlined,
    title: _toifa,
  ),
  SearchSection(
    id: 'exam',
    route: '/learn/exam',
    icon: Icons.timer_outlined,
    title: _exam,
  ),
  SearchSection(
    id: 'quiz',
    route: '/learn/quiz',
    icon: Icons.quiz_outlined,
    title: _quiz,
  ),
  SearchSection(
    id: 'classes',
    route: '/learn/classes',
    icon: Icons.groups_outlined,
    title: _classes,
  ),
  SearchSection(
    id: 'procedures',
    route: '/procedures',
    icon: Icons.vaccines_outlined,
    title: _procedures,
  ),
  SearchSection(
    id: 'workplace',
    route: '/workplace',
    icon: Icons.work_outline_rounded,
    title: _workplace,
  ),
];

String _toifa(AppLocalizations l) => l.toifaTitle;
String _exam(AppLocalizations l) => l.featureExam;
String _quiz(AppLocalizations l) => l.learnQuiz;
String _classes(AppLocalizations l) => l.featureClasses;
String _procedures(AppLocalizations l) => l.navProcedures;
String _workplace(AppLocalizations l) => l.navWorkplace;
