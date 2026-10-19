import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../features/admin/admin_console_screens.dart';
import '../features/auth/ui/account_required_screen.dart';
import '../features/admin/admin_screens.dart';
import '../features/auth/ui/auth_screens.dart';
import '../features/auth/ui/language_picker_screen.dart';
import '../features/auth/ui/role_screen.dart';
import '../features/auth/ui/welcome_screen.dart';
import '../features/classroom/board_screen.dart';
import '../features/classroom/classroom_screens.dart';
import '../features/classroom/general_test_screen.dart';
import '../features/classroom/lecture_screens.dart';
import '../features/classroom/topic_test_screens.dart';
import '../features/daily/daily_screens.dart';
import '../features/home/home_screen.dart';
import '../features/hub/hub_screens.dart';
import '../features/reference/reference_screens.dart';
import '../features/learn/classes_screens.dart';
import '../features/learn/exam_screens.dart';
import '../features/learn/learn_screens.dart';
import '../features/library/library_item_screen.dart';
import '../features/library/library_screens.dart';
import '../features/library/pdf_reader_screen.dart';
import '../features/profile/contact_screen.dart';
import '../features/profile/help_screen.dart';
import '../features/profile/profile_screens.dart';
import '../features/settings/settings_controller.dart';
import '../features/settings/theme_screen.dart';
import '../features/support/support_screens.dart';
import '../features/toifa/toifa_bank.dart';
import '../features/toifa/toifa_screens.dart';
import 'app_scope.dart';
import 'shell.dart';

/// Yo'llar xaritasi.
///
/// Onboarding: (birinchi marta) /welcome/language → /welcome → /welcome/auth → /welcome/auth/otp → /welcome/role.
/// Tablar: /home, /procedures, /workplace, /library, /learn — har biri o'z stacki bilan.
/// Ichki sahifalar o'z tabining stekida ochiladi, shunda "orqaga"
/// foydalanuvchini kelgan joyiga qaytaradi.
/// Ro'yxatdan o'tmagan (mehmon) foydalanuvchiga yopiq bo'limlar: O'rganish
/// (test, mashq, kunlik savol), muolaja tafsilotlari, atamalar, adabiyot
/// tafsilotlari, saqlanganlar. Guruhlar (`/learn/classes`) o'z kirish
/// taklifini ([ClassesGate]) ko'rsatadi, shuning uchun bu yerda emas.
bool needsAccount(String loc) {
  if (loc.startsWith('/learn/classes')) return false;
  return loc == '/learn' ||
      loc.startsWith('/learn/') ||
      loc.startsWith('/procedures/') ||
      loc == '/library/glossary' ||
      loc.startsWith('/library/literature/') ||
      loc == '/library/saved';
}

GoRouter buildRouter(
  SettingsController settings, {
  required Listenable refresh,
  bool Function()? hasAccount,
}) {
  final rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final tabMemory = TabMemory();

  /// Onboarding paytida ochilgan taklif havolasi (`/j?c=..`): onboarding
  /// tugagach qo'shilish ekrani ochiladi.
  String? pendingInvite;

  return GoRouter(
    navigatorKey: rootKey,
    // Holatni tiklash: tizim ilovani fonda yopsa, qaytganda tab steklari va
    // ochiq sahifalar tiklanadi.
    restorationScopeId: 'router',
    initialLocation: '/home',
    // Faqat onboarding holati o'zgarganda redirect qayta hisoblanadi. Til,
    // mavzu yoki rol o'zgarishi routerni yangilamaydi — aks holda kechikkan
    // yangilanish endigina yopilgan sahifani qaytarib qo'yishi mumkin.
    refreshListenable: refresh,
    redirect: (context, state) {
      // Taklif havolasi (QR → sayt → “Ilovada ochish”: nurseguide://app/j?c=..
      // yoki https://nurseguide.nfcstore.uz/j/?c=..&a=..) — qo'shilish ekrani.
      final path = state.uri.path;
      if (path == '/j' || path == '/j/') {
        final q = state.uri.queryParameters;
        final join = Uri(
          path: '/learn/classes/join',
          queryParameters: {'code': ?q['c'], 'a': ?q['a']},
        ).toString();
        if (settings.onboarded) return join;
        // Yangi o'rnatilgan ilova (ikkinchi telefon/hisob): taklif
        // onboarding tugaguncha eslab qolinadi — avval kod yo'qolib,
        // talaba bosh sahifaga tushib qolardi.
        pendingInvite = join;
      }
      final loc = state.matchedLocation;
      final inOnboarding = loc.startsWith('/welcome') || loc == '/terms';
      // Birinchi ishga tushirish: avval til tanlanadi, so'ng welcome.
      if (!settings.onboarded && !settings.languageChosen) {
        return loc == '/welcome/language' ? null : '/welcome/language';
      }
      if (!settings.onboarded && !inOnboarding) return '/welcome';
      if (settings.onboarded && loc.startsWith('/welcome')) {
        final invite = pendingInvite;
        pendingInvite = null;
        return invite ?? '/home';
      }
      if (settings.onboarded) {
        final signedIn = hasAccount?.call() ?? true;
        if (!signedIn && needsAccount(loc)) {
          return Uri(
            path: '/account-required',
            queryParameters: {'from': state.uri.toString()},
          ).toString();
        }
        // Kirgach — dastlab so'ralgan sahifaga qaytadi.
        if (signedIn && loc == '/account-required') {
          final from = state.uri.queryParameters['from'];
          return from != null && from.startsWith('/') ? from : '/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/account-required',
        builder: (context, state) => const AccountRequiredScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: 'language',
            builder: (context, state) => const LanguagePickerScreen(),
          ),
          GoRoute(
            path: 'auth',
            builder: (context, state) => const EmailScreen(),
            routes: [
              GoRoute(
                path: 'otp',
                builder: (context, state) => const OtpScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'role',
            builder: (context, state) => const RoleScreen(onboarding: true),
          ),
        ],
      ),
      GoRoute(path: '/terms', builder: (context, state) => const TermsScreen()),
      GoRoute(
        path: '/profile',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'role',
            builder: (context, state) => const RoleScreen(onboarding: false),
          ),
          // Mavzu tanlash (D-64).
          GoRoute(
            path: 'theme',
            builder: (context, state) => const ThemeScreen(),
          ),
          GoRoute(
            path: 'privacy',
            builder: (context, state) => const PrivacyScreen(),
          ),
          // Yordam va aloqa (D-69 Q6): ilova ichidagi yozishma va email —
          // bitta kirish. Ikkala manzil (`support`, `contact`) o'zgarmagan.
          GoRoute(
            path: 'help',
            builder: (context, state) => const HelpContactScreen(),
          ),
          // Aloqa va shikoyat: serversiz, doim ochiq (mailto).
          GoRoute(
            path: 'contact',
            builder: (context, state) =>
                ContactScreen(targetRef: state.uri.queryParameters['ref']),
          ),
          GoRoute(
            path: 'support',
            builder: (context, state) => const SupportListScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const NewSupportThreadScreen(),
              ),
              GoRoute(
                path: 'thread/:id',
                builder: (context, state) =>
                    SupportThreadScreen(threadId: state.pathParameters['id']!),
              ),
            ],
          ),
          // Har admin ekrani o'zini AdminGate bilan o'raydi (my_access + aal2);
          // yo'lni bilish hech narsa bermaydi — RPC'lar serverda tekshiradi.
          GoRoute(
            path: 'admin',
            builder: (context, state) => const AdminHomeScreen(),
            routes: [
              GoRoute(
                path: 'inbox',
                builder: (context, state) => const AdminInboxScreen(),
              ),
              GoRoute(
                path: 'thread/:id',
                builder: (context, state) =>
                    AdminThreadScreen(threadId: state.pathParameters['id']!),
              ),
              GoRoute(
                path: 'users',
                builder: (context, state) => const AdminUsersScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        AdminUserScreen(userId: state.pathParameters['id']!),
                  ),
                ],
              ),
              // Egasi admin paneli (Cloudflare): ko'rsatkichlar va shikoyatlar.
              GoRoute(
                path: 'stats',
                builder: (context, state) => const AdminStatsScreen(),
              ),
              GoRoute(
                path: 'complaints',
                builder: (context, state) => const AdminComplaintsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        AdminComplaintScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
              GoRoute(
                path: 'audit',
                builder: (context, state) => const AdminAuditScreen(),
              ),
              GoRoute(
                path: 'admins',
                builder: (context, state) => const AdminTeamScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'auth',
            builder: (context, state) => const EmailScreen(),
            routes: [
              GoRoute(
                path: 'otp',
                builder: (context, state) => const OtpScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'shell',
        builder: (context, state, shell) =>
            AppShell(shell: shell, memory: tabMemory, location: state.uri),
        branches: [
          StatefulShellBranch(
            restorationScopeId: 'tab-home',
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Manipulyatsiyalar — kontent 4-bosqichda; hozircha bo'sh holat.
          StatefulShellBranch(
            restorationScopeId: 'tab-procedures',
            routes: [
              GoRoute(
                path: '/procedures',
                builder: (context, state) => const ProceduresScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        ProcedureDetailScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          // Ish joyi (o'rtadagi katta tugma) — kontent 4-bosqichda.
          StatefulShellBranch(
            restorationScopeId: 'tab-workplace',
            routes: [
              GoRoute(
                path: '/workplace',
                builder: (context, state) => const WorkplaceScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'tab-library',
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
                routes: [
                  GoRoute(
                    path: 'saved',
                    builder: (context, state) => const SavedScreen(),
                  ),
                  GoRoute(
                    path: 'books',
                    builder: (context, state) => BooksScreen(
                      focusSearch: state.uri.queryParameters['search'] == '1',
                    ),
                    routes: [
                      GoRoute(
                        path: 'item/:id',
                        builder: (context, state) => LibraryItemScreen(
                          itemId: state.pathParameters['id']!,
                        ),
                        routes: [
                          // O'quvchi to'liq ekranda (pastki tablarsiz).
                          GoRoute(
                            path: 'read',
                            parentNavigatorKey: rootKey,
                            builder: (context, state) => PdfReaderScreen(
                              itemId: state.pathParameters['id']!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'sources',
                    builder: (context, state) => const SourcesScreen(),
                  ),
                  GoRoute(
                    path: 'glossary',
                    builder: (context, state) => const GlossaryScreen(),
                  ),
                  GoRoute(
                    path: 'literature',
                    builder: (context, state) => const LiteratureScreen(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => LiteratureDetailScreen(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'tab-learn',
            routes: [
              GoRoute(
                path: '/learn',
                builder: (context, state) => const LearnScreen(),
                routes: [
                  GoRoute(
                    path: 'quiz',
                    // `fresh` bo'lsa — har safar yangi holat (mavzu tanlash).
                    builder: (context, state) => QuizScreen(
                      key: ValueKey(state.uri.queryParameters['fresh']),
                    ),
                  ),
                  // Kunlik 5 ta savol (bosh sahifa kartasi va eslatmadan).
                  GoRoute(
                    path: 'daily',
                    builder: (context, state) => const DailyScreen(),
                  ),
                  // Imtihon: yechish — to'liq ekran (tablar yashiringan).
                  GoRoute(
                    path: 'exam',
                    builder: (context, state) => const ExamSetupScreen(),
                    routes: [
                      GoRoute(
                        path: 'run',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) => const ExamRunScreen(),
                      ),
                      GoRoute(
                        path: 'result/:id',
                        builder: (context, state) => ExamResultScreen(
                          resultId: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                  // Toifa imtihoniga tayyorgarlik — faqat O'zbekiston
                  // foydalanuvchilariga (til uz yoki mintaqa UZ), shifokor va
                  // talaba rolidan tashqari (D-40, D-60); boshqalar
                  // to'g'ridan-to'g'ri manzil bilan ham kira olmaydi.
                  GoRoute(
                    path: 'toifa',
                    redirect: (context, state) =>
                        toifaAvailable(
                          settings.language,
                          SchedulerBinding.instance.platformDispatcher.locales,
                          role: settings.role,
                        )
                        ? null
                        : '/learn',
                    builder: (context, state) => const ToifaHubScreen(),
                    routes: [
                      GoRoute(
                        path: 'test',
                        builder: (context, state) => const ToifaTestScreen(),
                        routes: [
                          GoRoute(
                            path: 'run',
                            parentNavigatorKey: rootKey,
                            builder: (context, state) =>
                                const ExamRunScreen(base: '$toifaBase/test'),
                          ),
                          // Mashq rejimi: xato darhol ko'rinadi (vaqtsiz).
                          GoRoute(
                            path: 'practice',
                            builder: (context, state) =>
                                const ToifaDrillScreen(),
                          ),
                          GoRoute(
                            path: 'result/:id',
                            builder: (context, state) => ExamResultScreen(
                              resultId: state.pathParameters['id']!,
                              base: '$toifaBase/test',
                            ),
                          ),
                        ],
                      ),
                      GoRoute(
                        path: 'practice',
                        builder: (context, state) =>
                            const ToifaPracticeListScreen(),
                        routes: [
                          GoRoute(
                            path: ':scope',
                            builder: (context, state) => ToifaPracticeScreen(
                              scope: state.pathParameters['scope']!,
                            ),
                          ),
                        ],
                      ),
                      GoRoute(
                        path: 'oral',
                        builder: (context, state) => const ToifaOralScreen(),
                        routes: [
                          GoRoute(
                            path: 'q/:id',
                            builder: (context, state) =>
                                ToifaOralQuestionScreen(
                                  id: state.pathParameters['id']!,
                                ),
                          ),
                        ],
                      ),
                      GoRoute(
                        path: 'mistakes',
                        builder: (context, state) =>
                            const ToifaMistakesScreen(),
                      ),
                      GoRoute(
                        path: 'progress',
                        builder: (context, state) =>
                            const ToifaProgressScreen(),
                      ),
                    ],
                  ),
                  // Guruhlar: har ekran ClassesGate bilan (server/hisob).
                  GoRoute(
                    path: 'classes',
                    builder: (context, state) => const ClassesScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        builder: (context, state) => const CreateGroupScreen(),
                      ),
                      // Umumiy test: bir nechta mavzudan, guruh(lar) tanlanadi.
                      GoRoute(
                        path: 'test',
                        builder: (context, state) => const GeneralTestScreen(),
                      ),
                      GoRoute(
                        path: 'join',
                        builder: (context, state) => JoinGroupScreen(
                          initialCode: state.uri.queryParameters['code'],
                          assignmentId: state.uri.queryParameters['a'],
                          autoJoin:
                              state.extra == JoinGroupScreen.autoJoinExtra,
                        ),
                      ),
                      GoRoute(
                        path: 'g/:gid',
                        builder: (context, state) =>
                            GroupScreen(groupId: state.pathParameters['gid']!),
                        routes: [
                          // O'quv dasturi: jadval va mavzu darslari.
                          GoRoute(
                            path: 'plan',
                            builder: (context, state) => GroupPlanScreen(
                              groupId: state.pathParameters['gid']!,
                            ),
                          ),
                          GoRoute(
                            path: 't/:tid',
                            builder: (context, state) => GroupTopicScreen(
                              groupId: state.pathParameters['gid']!,
                              topicId: state.pathParameters['tid']!,
                            ),
                            routes: [
                              GoRoute(
                                path: 'oral',
                                builder: (context, state) => TopicOralScreen(
                                  groupId: state.pathParameters['gid']!,
                                  topicId: state.pathParameters['tid']!,
                                ),
                              ),
                              GoRoute(
                                path: 'test',
                                builder: (context, state) =>
                                    TopicTestSetupScreen(
                                      groupId: state.pathParameters['gid']!,
                                      topicId: state.pathParameters['tid']!,
                                    ),
                              ),
                            ],
                          ),
                          // Umumiy test (shu guruh oldindan tanlangan).
                          GoRoute(
                            path: 'assign',
                            builder: (context, state) => GeneralTestScreen(
                              initialGroupId: state.pathParameters['gid']!,
                            ),
                          ),
                          // Guruh sahifasidan mavzu testi: mavzuni tanlash.
                          GoRoute(
                            path: 'topic-test',
                            builder: (context, state) => DeckTestPickerScreen(
                              groupId: state.pathParameters['gid']!,
                            ),
                          ),
                          GoRoute(
                            path: 'a/:aid',
                            builder: (context, state) => AssignmentScreen(
                              groupId: state.pathParameters['gid']!,
                              assignmentId: state.pathParameters['aid']!,
                            ),
                            routes: [
                              GoRoute(
                                path: 'run',
                                parentNavigatorKey: rootKey,
                                builder: (context, state) =>
                                    AssignmentRunScreen(
                                      groupId: state.pathParameters['gid']!,
                                      assignmentId:
                                          state.pathParameters['aid']!,
                                    ),
                              ),
                              // “Katta ekran” (proyektor): to'liq ekran.
                              GoRoute(
                                path: 'board',
                                parentNavigatorKey: rootKey,
                                builder: (context, state) =>
                                    AssignmentBoardScreen(
                                      groupId: state.pathParameters['gid']!,
                                      assignmentId:
                                          state.pathParameters['aid']!,
                                    ),
                              ),
                              GoRoute(
                                path: 's/:uid',
                                builder: (context, state) =>
                                    StudentResultScreen(
                                      groupId: state.pathParameters['gid']!,
                                      assignmentId:
                                          state.pathParameters['aid']!,
                                      userId: state.pathParameters['uid']!,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Ma'ruza (taqdimot) rejimi — serversiz; slaydlar to'liq
                  // ekranda (tablar yashiringan).
                  GoRoute(
                    path: 'lecture',
                    builder: (context, state) => const LectureListScreen(),
                    routes: [
                      // Mavzu testi (taqdimot oxirida) va ustoz uchun
                      // “Guruhga topshirish” — to'liq ekran (pleyerdan ham
                      // ochiladi).
                      GoRoute(
                        path: 'test/:deckId',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) => TopicTestScreen(
                          deckId: state.pathParameters['deckId']!,
                        ),
                        routes: [
                          GoRoute(
                            path: 'assign',
                            parentNavigatorKey: rootKey,
                            builder: (context, state) => AssignDeckTestScreen(
                              deckId: state.pathParameters['deckId']!,
                              initialGroupId: state.uri.queryParameters['g'],
                            ),
                            routes: [
                              // Guruhsiz ustoz: guruh shu yerda yaratiladi
                              // (root navigatorda — shell ichidagi
                              // /learn/classes/new ga push “duplicate page
                              // key” beradi), so'ng topshirishga qaytadi.
                              GoRoute(
                                path: 'group',
                                parentNavigatorKey: rootKey,
                                builder: (context, state) =>
                                    const CreateGroupScreen(popOnCreate: true),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Katalogdagi tayyor taqdimot (kun mavzusi yoki amaliy
                      // protokol): ?s=slayd indeksi, ?l=til (qidiruvda boshqa
                      // tildagi slayd tanlanganda).
                      GoRoute(
                        path: 'deck/:deckId',
                        parentNavigatorKey: rootKey,
                        builder: (context, state) => LectureScreen(
                          topicId: '',
                          deckId: state.pathParameters['deckId']!,
                          deckLang: state.uri.queryParameters['l'],
                          startSlide:
                              int.tryParse(
                                state.uri.queryParameters['s'] ?? '',
                              ) ??
                              0,
                        ),
                      ),
                      // Mavzu manzili (eski havolalar, guruh darsi): tayyor
                      // taqdimoti bo'lsa — o'sha deckka yo'naltiriladi
                      // (D-45, D-69); bo'lmasa avtomatik slaydlar.
                      GoRoute(
                        path: ':topicId',
                        parentNavigatorKey: rootKey,
                        redirect: (context, state) =>
                            resolveLectureTopicRedirect(
                              context.services.curriculum.bundle ?? rootBundle,
                              state.pathParameters['topicId']!,
                            ),
                        builder: (context, state) => LectureScreen(
                          topicId: state.pathParameters['topicId']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// [SettingsController] dan faqat `onboarded` va `languageChosen`
/// o'zgarishini uzatadi.
class OnboardingChanges extends ChangeNotifier {
  OnboardingChanges(this._settings)
    : _last = (_settings.onboarded, _settings.languageChosen) {
    _settings.addListener(_onSettings);
  }

  final SettingsController _settings;
  (bool, bool) _last;

  void _onSettings() {
    final now = (_settings.onboarded, _settings.languageChosen);
    if (now == _last) return;
    _last = now;
    notifyListeners();
  }

  @override
  void dispose() {
    _settings.removeListener(_onSettings);
    super.dispose();
  }
}
