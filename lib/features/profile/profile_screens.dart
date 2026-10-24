import 'dart:ui' show PlatformDispatcher;

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../app/widgets/links.dart';
import '../../core/contact.dart';
import '../../design/widgets/lg_widgets.dart';
import '../daily/daily_screens.dart' show DailyReminderSettings;
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_controller.dart';
import '../auth/social_auth.dart';
import '../auth/ui/role_screen.dart';
import '../settings/settings_controller.dart';
import '../settings/theme_screen.dart' show LgThemeIdL10n;
import '../support/support_screens.dart';

enum _SignOut { keepData, deleteData }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _nativeLanguage = {
    AppLanguage.uz: 'O‘zbekcha',
    AppLanguage.ru: 'Русский',
    AppLanguage.en: 'English',
  };

  /// Hisobli foydalanuvchi: chiqishdan oldin shu qurilmadagi ma'lumotni
  /// ham o'chirish tanlovi (keyingi foydalanuvchi oldingisining natijalari
  /// va xatcho'plarini ko'rmasligi uchun). Mehmon uchun bu “boshidan
  /// sozlash” — ma'lumot o'sha odamniki, o'chirilmaydi.
  Future<void> _signOut(BuildContext context) async {
    final services = context.services;
    if (services.auth.hasAccount) {
      final l = AppLocalizations.of(context);
      final choice = await showDialog<_SignOut>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l.profileSignOutTitle),
          content: Text(l.profileSignOutBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l.actionCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_SignOut.deleteData),
              child: Text(l.profileSignOutDelete),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_SignOut.keepData),
              child: Text(l.profileSignOut),
            ),
          ],
        ),
      );
      if (choice == null) return;
      if (choice == _SignOut.deleteData) {
        await services.deleteLocalData(PlatformDispatcher.instance.locales);
        await services.settings.resetOnboarding();
        return;
      }
    }
    await services.auth.signOut();
    await services.settings.resetOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final services = context.services;
    final settings = services.settings;
    final auth = services.auth;
    final access = services.access;
    return ListenableBuilder(
      listenable: Listenable.merge([settings, auth, access]),
      builder: (context, _) {
        final l = AppLocalizations.of(context);
        final text = Theme.of(context).textTheme;
        final session = auth.session;
        final (String tag, String title, String subtitle) = switch (session) {
          EmailSession(:final email, isDemo: true) => (
            l.profileDemoSession,
            email,
            settings.effectiveRole.title(l),
          ),
          EmailSession(:final email) => (
            l.authEmailLabel,
            email,
            settings.effectiveRole.title(l),
          ),
          _ => (l.profileGuest, l.profileGuestLocal, l.profileGuestSub),
        };
        return LgPage(
          title: l.profileTitle,
          showProfile: false,
          children: [
            LgPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LgTag(tag),
                  const SizedBox(height: 12),
                  Text(title, style: text.titleLarge),
                  const SizedBox(height: 4),
                  Text(subtitle, style: text.bodyMedium),
                  if (!auth.hasAccount) ...[
                    const SizedBox(height: 14),
                    LgButton.secondary(
                      label: l.profileSignIn,
                      icon: Icons.mail_outline_rounded,
                      onPressed: () => context.push('/profile/auth'),
                    ),
                  ],
                ],
              ),
            ),
            LgRow(
              title: l.profileRole,
              subtitle:
                  '${settings.effectiveRole.title(l)} · ${l.profileRoleSub}',
              icon: settings.effectiveRole.icon,
              onTap: () => context.push('/profile/role'),
              divider: false,
            ),
            LgSectionTitle(l.profileLanguage),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final lang in AppLanguage.values)
                  LgChoiceChip(
                    label: _nativeLanguage[lang]!,
                    selected: settings.language == lang,
                    onTap: () => settings.setLanguage(lang),
                  ),
              ],
            ),
            LgSectionTitle(l.profileFontSize),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (size, label) in [
                  (FontSize.small, l.fontSizeSmall),
                  (FontSize.normal, l.fontSizeNormal),
                  (FontSize.large, l.fontSizeLarge),
                  (FontSize.xlarge, l.fontSizeXLarge),
                ])
                  LgChoiceChip(
                    label: label,
                    selected: settings.fontSize == size,
                    onTap: () => settings.setFontSize(size),
                  ),
              ],
            ),
            LgSectionTitle(l.profileAppearance),
            LgRow(
              key: const ValueKey('profile-theme-row'),
              title: l.themeTitle,
              subtitle: '${settings.appTheme.title(l)} · ${l.themeRowSub}',
              icon: Icons.palette_outlined,
              onTap: () => context.push('/profile/theme'),
              divider: false,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (mode, label) in [
                  (ThemeMode.system, l.themeSystem),
                  (ThemeMode.light, l.themeLight),
                  (ThemeMode.dark, l.themeDark),
                ])
                  LgChoiceChip(
                    label: label,
                    selected: settings.themeMode == mode,
                    onTap: () => settings.setThemeMode(mode),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            LgSectionTitle(l.profileFeedback),
            SwitchListTile.adaptive(
              key: const ValueKey('profile-haptics'),
              contentPadding: EdgeInsets.zero,
              title: Text(l.profileHaptics),
              value: settings.haptics,
              onChanged: settings.setHaptics,
            ),
            SwitchListTile.adaptive(
              key: const ValueKey('profile-sounds'),
              contentPadding: EdgeInsets.zero,
              title: Text(l.profileSounds),
              value: settings.sounds,
              onChanged: settings.setSounds,
            ),
            LgSectionTitle(l.dailyReminderSetting),
            const DailyReminderSettings(),
            const SizedBox(height: 18),
            // Yagona “Yordam va aloqa” (D-69 Q6): ichida ilova ichidagi
            // yozishma va email/shikoyat. Serverga bog'liq emas — doim
            // ko'rinadi (email yo'li doim ishlaydi).
            LgRow(
              key: const ValueKey('profile-help'),
              title: l.helpTitle,
              subtitle: l.helpSub,
              icon: Icons.support_agent_outlined,
              trailing: access.unreadReplies > 0
                  ? LgTag(
                      l.supportUnreadCount(access.unreadReplies),
                      tone: LgTone.brand,
                    )
                  : null,
              onTap: () => context.push('/profile/help'),
            ),
            // Faqat server admin hisobi deb tasdiqlagan foydalanuvchiga
            // ko'rinadi; ichkarida yana 2FA va har RPC'da tekshiruv bor.
            if (access.access.adminAccount || access.access.panelAdmin)
              LgRow(
                title: l.adminTitle,
                subtitle: l.adminSub,
                icon: Icons.admin_panel_settings_outlined,
                onTap: () => context.push('/profile/admin'),
              ),
            if (AppScope.of(context).billing.enabled)
              LgRow(
                key: const ValueKey('profile-subscription'),
                title: l.paywallProfileRow,
                subtitle: l.paywallTitle,
                icon: Icons.workspace_premium_outlined,
                onTap: () => context.push('/paywall'),
              ),
            LgRow(
              title: l.profilePrivacy,
              subtitle: l.profilePrivacySub,
              icon: Icons.shield_outlined,
              onTap: () => context.push('/profile/privacy'),
              divider: false,
            ),
            const SizedBox(height: 18),
            LgButton.secondary(
              label: auth.hasAccount ? l.profileSignOut : l.profileRestartSetup,
              icon: auth.hasAccount
                  ? Icons.logout_rounded
                  : Icons.restart_alt_rounded,
              onPressed: () => _signOut(context),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                l.profileVersion(services.config.appVersion),
                style: text.bodySmall,
              ),
            ),
            if (services.config.showDebugBadge)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: LgTag(l.debugBuildBadge, tone: LgTone.warning),
                ),
              ),
          ],
        );
      },
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final services = context.services;
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.privacyDeleteConfirmTitle),
        content: Text(l.privacyDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.actionDelete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await services.deleteLocalData(PlatformDispatcher.instance.locales);
    // Til tizim tiliga qaytdi: xabar ham shu (yangi) tilda chiqadi.
    final after = lookupAppLocalizations(services.settings.language.locale);
    messenger.showSnackBar(SnackBar(content: Text(after.privacyDeleted)));
  }

  /// Serverdagi hisobni o'chirish (Edge Function, service role faqat
  /// serverda). Muvaffaqiyatdan keyin qurilmadagi ma'lumot ham tozalanadi.
  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final services = context.services;
    final messenger = ScaffoldMessenger.of(context);
    final backend = services.backend;
    final social = services.auth.social;
    final socialBackend = social.backend;
    final apple = social.provider(SocialProvider.apple);
    // Apple (App Store 5.1.1(v)): hisob Apple bilan bog'langan bo'lsa, o'chirishda
    // Apple tokeni bekor qilinadi — buning uchun Apple'dan yangi tasdiq olinadi.
    var appleLinked = false;
    if (socialBackend != null && apple != null && apple.isSupported) {
      try {
        appleLinked = (await socialBackend.linkedProviders()).contains(
          SocialProvider.apple,
        );
      } on Object {
        appleLinked = false;
      }
    }
    if (!context.mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.accountDeleteTitle),
        content: Text(
          [
            l.accountDeleteBody,
            if (appleLinked) l.accountDeleteAppleNote,
          ].join('\n\n'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l.actionDelete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    String? appleCode;
    if (appleLinked) {
      try {
        final credential = await apple!.authenticate();
        if (credential == null) {
          // Foydalanuvchi Apple tasdig'ini bekor qildi: hech narsa o'chirilmaydi.
          messenger.showSnackBar(
            SnackBar(content: Text(l.accountDeleteAppleCancelled)),
          );
          return;
        }
        appleCode = credential.authorizationCode;
      } on Object {
        // Apple oynasi ochilmadi: hisobni o'chirish to'silmaydi (server
        // bekor qilish o'tkazib yuborilganini jurnalga yozadi).
        appleCode = null;
      }
    }
    try {
      if (socialBackend != null) {
        await socialBackend.deleteAccountWithApple(appleCode);
      } else {
        await backend.deleteAccount();
      }
    } on Object catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(backendErrorText(e, l))));
      return;
    }
    await services.deleteLocalData(PlatformDispatcher.instance.locales);
    await services.settings.resetOnboarding();
    messenger.showSnackBar(SnackBar(content: Text(l.accountDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final services = context.services;
    final hasServerAccount =
        services.backend.isConfigured && services.backend.hasSession;
    return LgPage(
      title: l.privacyTitle,
      showProfile: false,
      children: [
        Text(
          services.backend.isConfigured ? l.privacyBody : l.privacyBodyLocal,
          style: text.bodyLarge,
        ),
        const SizedBox(height: 12),
        LgRow(
          title: l.privacyTerms,
          subtitle: l.privacyTermsSub,
          icon: Icons.description_outlined,
          onTap: () => context.push('/terms'),
        ),
        // Maxfiylik siyosatining o'zi (sayt) — audit 2026-10-18 (tablar).
        LgRow(
          key: const ValueKey('privacy-policy-link'),
          title: l.contactPrivacyPolicy,
          subtitle: l.contactPrivacyNote,
          icon: Icons.shield_outlined,
          onTap: () => openExternalLink(context, Contact.privacyPolicyUrl),
        ),
        LgRow(
          title: l.privacyDeleteLocal,
          subtitle: l.privacyDeleteLocalSub,
          icon: Icons.delete_outline_rounded,
          onTap: () => _confirmDelete(context),
          divider: hasServerAccount,
        ),
        if (hasServerAccount)
          LgRow(
            title: l.accountDelete,
            subtitle: l.accountDeleteSub,
            icon: Icons.person_remove_outlined,
            onTap: () => _confirmDeleteAccount(context),
            divider: false,
          ),
      ],
    );
  }
}
