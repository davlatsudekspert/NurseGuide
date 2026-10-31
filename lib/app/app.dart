import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../core/update/update_gate.dart';
import '../design/theme.dart';
import '../features/daily/daily_screens.dart';
import '../features/home/resume_history.dart';
import '../features/settings/settings_controller.dart';
import '../features/toifa/toifa_screens.dart' show toifaBase;
import '../l10n/gen/app_localizations.dart';
import 'app_scope.dart';
import 'router.dart';

class NurseGuideApp extends StatefulWidget {
  const NurseGuideApp({super.key, required this.services});

  final AppServices services;

  @override
  State<NurseGuideApp> createState() => _NurseGuideAppState();
}

class _NurseGuideAppState extends State<NurseGuideApp> {
  late GoRouter _router;
  late bool _wasOnboarded;

  /// Sahifa almashganda oldingi sahifaning xabari (SnackBar) yangi sahifani
  /// yopib turmasin.
  final _messenger = GlobalKey<ScaffoldMessengerState>();
  String? _location;
  late final OnboardingChanges _onboarding = OnboardingChanges(_settings);
  late final Listenable _routerRefresh = Listenable.merge([
    _onboarding,
    widget.services.auth,
    // Billing o'chiq bo'lsa yo'l hech qachon o'zgarmaydi: routerni bejiz yangilamaymiz.
    if (widget.services.billing.enabled) widget.services.billing,
  ]);

  SettingsController get _settings => widget.services.settings;

  GoRouter _build() => buildRouter(
    _settings,
    refresh: _routerRefresh,
    hasAccount: () => widget.services.auth.hasAccount,
    billingAllows: widget.services.billing.allows,
  );

  @override
  void initState() {
    super.initState();
    _router = _build();
    _router.routeInformationProvider.addListener(_onRoute);
    _wasOnboarded = _settings.onboarded;
    widget.services.billing.start();
    _settings.addListener(_onSettings);
    widget.services.reminders.addListener(_onReminder);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onReminder());
  }

  /// Eslatma bildirishnomasi bosilgan — kunlik savol ochiladi.
  void _onReminder() {
    if (!mounted || !_settings.onboarded) return;
    if (widget.services.reminders.takeOpenRequest()) {
      openDailyFromReminder(_router);
    }
    // Toifa eslatmasi — toifa bo'limi (bo'lim yopiq bo'lsa, router o'zi
    // O'rganishga qaytaradi).
    if (widget.services.reminders.takeToifaOpenRequest()) {
      _router.go(toifaBase);
    }
  }

  /// Chiqish yoki lokal ma'lumotlar o'chirilganda tab stacklari ham
  /// tozalanadi: router qaytadan quriladi.
  void _onSettings() {
    final onboarded = _settings.onboarded;
    if (_wasOnboarded && !onboarded) {
      final old = _router..routeInformationProvider.removeListener(_onRoute);
      setState(() => _router = _build());
      _router.routeInformationProvider.addListener(_onRoute);
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
    _wasOnboarded = onboarded;
  }

  void _onRoute() {
    final uri = _router.routeInformationProvider.value.uri;
    final location = uri.path;
    // Bosh sahifadagi “Davom ettirish” uchun oxirgi taqdimot/test/bo'lim.
    if (_settings.onboarded) {
      ResumeHistory.of(widget.services.store).note(uri);
    }
    if (_location != null && location != _location) {
      _messenger.currentState?.hideCurrentSnackBar();
    }
    _location = location;
  }

  @override
  void dispose() {
    _router.routeInformationProvider.removeListener(_onRoute);
    _settings.removeListener(_onSettings);
    widget.services.reminders.removeListener(_onReminder);
    _router.dispose();
    _onboarding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      services: widget.services,
      child: ListenableBuilder(
        listenable: _settings,
        builder: (context, _) => MaterialApp.router(
          restorationScopeId: 'app',
          onGenerateTitle: (_) => 'NurseGuide',
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          scaffoldMessengerKey: _messenger,
          theme: buildLgTheme(
            Brightness.light,
            theme: _settings.appTheme,
            cyrillic: _settings.language == AppLanguage.ru,
          ),
          darkTheme: buildLgTheme(
            Brightness.dark,
            theme: _settings.appTheme,
            cyrillic: _settings.language == AppLanguage.ru,
          ),
          themeMode: _settings.themeMode,
          // Matn o'lchami sozlamasi: tizim masshtabiga ko'paytiriladi.
          builder: (context, child) {
            // Eski versiya (saytdagi app-config.json bo'yicha) to'xtatiladi.
            final gated = UpdateGate(child: child!);
            final factor = _settings.fontSize.factor;
            if (factor == 1.0) return gated;
            final mq = MediaQuery.of(context);
            return MediaQuery(
              data: mq.copyWith(
                textScaler: _ScaledTextScaler(mq.textScaler, factor),
              ),
              child: gated,
            );
          },
          // Mavzu almashganda ranglar silliq o'tadi (D-64).
          // Reduced motion — darhol.
          themeAnimationDuration:
              WidgetsBinding
                  .instance
                  .platformDispatcher
                  .accessibilityFeatures
                  .disableAnimations
              ? Duration.zero
              : const Duration(milliseconds: 360),
          themeAnimationCurve: Curves.easeOutCubic,
          locale: _settings.language.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
        ),
      ),
    );
  }
}

/// Tizim matn masshtabini qo'shimcha [factor] ga ko'paytiradi.
class _ScaledTextScaler extends TextScaler {
  const _ScaledTextScaler(this.base, this.factor);

  final TextScaler base;
  final double factor;

  @override
  double scale(double fontSize) => base.scale(fontSize) * factor;

  @override
  double get textScaleFactor => scale(1);

  @override
  bool operator ==(Object other) =>
      other is _ScaledTextScaler &&
      other.base == base &&
      other.factor == factor;

  @override
  int get hashCode => Object.hash(base, factor);
}
