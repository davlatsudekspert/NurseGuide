import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../core/backend/admin_console.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/otp_auth.dart' show isValidEmail, normalizeEmail;
import '../support/support_screens.dart' show SignedInGate;
import 'admin_console_screens.dart' show adminConsoleErrorText;
import 'admin_screens.dart' show AdminGate;

/// Admin istalgan emailga Pro beradi yoki olib tashlaydi (do'kon xaridiga
/// bog'liq emas). Faqat egasi admin paneli; har amal serverda qayta tekshiriladi.
class AdminProScreen extends StatefulWidget {
  const AdminProScreen({super.key});

  @override
  State<AdminProScreen> createState() => _AdminProScreenState();
}

class _AdminProScreenState extends State<AdminProScreen> {
  final _email = TextEditingController();
  final _days = TextEditingController();
  String _tier = 'student';
  bool _busy = false;
  String? _error;
  List<ProGrantRow> _grants = const [];

  AdminConsoleBackend? get _api => context.services.adminConsole;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _email.dispose();
    _days.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final g = await _api?.adminProGrants() ?? const <ProGrantRow>[];
      if (mounted) setState(() => _grants = g);
    } catch (e) {
      if (mounted) {
        setState(
          () => _error = adminConsoleErrorText(e, AppLocalizations.of(context)),
        );
      }
    }
  }

  Future<void> _run(Future<void> Function(AdminConsoleBackend api) act) async {
    final l = AppLocalizations.of(context);
    final email = normalizeEmail(_email.text);
    final raw = _days.text.trim();
    final days = raw.isEmpty ? null : int.tryParse(raw);
    final api = _api;
    if (api == null ||
        !isValidEmail(email) ||
        (raw.isNotEmpty && (days == null || days < 1))) {
      setState(() => _error = l.adminProInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await act(api);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l.adminProDone)));
      }
    } catch (e) {
      if (mounted) setState(() => _error = adminConsoleErrorText(e, l));
    }
    if (mounted) setState(() => _busy = false);
  }

  String _tierName(AppLocalizations l, String t) => switch (t) {
    'teacher' => l.planTeacher,
    'specialist' => l.planSpecialist,
    _ => l.planStudent,
  };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fmt = DateFormat.yMMMd(Localizations.localeOf(context).toString());
    return LgPage(
      title: l.adminPro,
      subtitle: l.adminProSub,
      children: [
        SignedInGate(
          child: AdminGate(
            panel: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LgField(
                  key: const ValueKey('pro-email'),
                  label: l.adminProEmail,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
                LgField(
                  key: const ValueKey('pro-days'),
                  label: l.adminProDays,
                  controller: _days,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final t in const ['student', 'teacher', 'specialist'])
                      LgChoiceChip(
                        key: ValueKey('pro-tier-$t'),
                        label: _tierName(l, t),
                        selected: _tier == t,
                        onTap: () => setState(() => _tier = t),
                      ),
                  ],
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, key: const ValueKey('pro-error')),
                  ),
                const SizedBox(height: 12),
                LgButton(
                  key: const ValueKey('pro-give'),
                  label: l.adminProGive,
                  busy: _busy,
                  onPressed: _busy
                      ? null
                      : () => _run(
                          (api) => api.adminGrantPro(
                            email: normalizeEmail(_email.text),
                            tier: _tier,
                            days: int.tryParse(_days.text.trim()),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                LgButton.secondary(
                  key: const ValueKey('pro-remove'),
                  label: l.adminProRemove,
                  onPressed: _busy
                      ? null
                      : () => _run(
                          (api) =>
                              api.adminRevokePro(normalizeEmail(_email.text)),
                        ),
                ),
                const SizedBox(height: 16),
                for (final g in _grants)
                  LgRow(
                    title: '${g.emailMasked} · ${_tierName(l, g.tier)}',
                    subtitle: g.until == null
                        ? l.adminProForever
                        : l.adminProUntil(fmt.format(g.until!)),
                    icon: Icons.workspace_premium_outlined,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
