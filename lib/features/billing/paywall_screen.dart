import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';
import '../../app/widgets/lg_page.dart';
import '../../design/widgets/lg_widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'billing_controller.dart';
import 'billing_plan.dart';

/// Obuna ekrani: 3 daraja × oylik/yillik, 30 kun bepul sinov, tiklash va
/// shartlar (App Store 3.1.2).
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key, this.from});

  final String? from;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  BillingPeriod _period = BillingPeriod.yearly;
  BillingController? _billing;

  /// Kirish ochilgach (xarid, tiklash, sinov yoki server bergan Pro) —
  /// foydalanuvchi so'ragan sahifaga qaytadi.
  void _maybeReturn() {
    final from = widget.from;
    final billing = AppScope.of(context).billing;
    if (from != null && from.startsWith('/') && billing.allows(from)) {
      context.go(from);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _billing = AppScope.of(context).billing..addListener(_maybeReturn);
      _maybeReturn();
    });
  }

  @override
  void dispose() {
    _billing?.removeListener(_maybeReturn);
    super.dispose();
  }

  String _name(AppLocalizations l, BillingTier t) => switch (t) {
    BillingTier.student => l.planStudent,
    BillingTier.specialist => l.planSpecialist,
    BillingTier.teacher => l.planTeacher,
    BillingTier.free => '',
  };

  String _desc(AppLocalizations l, BillingTier t) => switch (t) {
    BillingTier.student => l.planStudentDesc,
    BillingTier.specialist => l.planSpecialistDesc,
    BillingTier.teacher => l.planTeacherDesc,
    BillingTier.free => '',
  };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final billing = AppScope.of(context).billing;
    return ListenableBuilder(
      listenable: billing,
      builder: (context, _) {
        final active = billing.tier != BillingTier.free;
        return LgPage(
          title: l.paywallTitle,
          showBrand: true,
          children: [
            Text(l.paywallLead),
            const SizedBox(height: 8),
            if (!active) ...[
              Text(l.paywallTrial),
              const SizedBox(height: 12),
            ],
            if (billing.trialUntil case final until?) ...[
              Text(
                l.paywallTrialActive(
                  DateFormat.yMMMd(Localizations.localeOf(context).toString())
                      .format(until),
                ),
                key: const ValueKey('paywall-trial'),
              ),
              const SizedBox(height: 12),
            ],
            if (active) ...[
              Text(l.paywallActive, key: const ValueKey('paywall-active')),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                for (final p in BillingPeriod.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: LgChoiceChip(
                      label: _capital(p == BillingPeriod.monthly
                          ? l.periodMonthly
                          : l.periodYearly),
                      selected: _period == p,
                      onTap: () => setState(() => _period = p),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            for (final plan in BillingPlan.all.where(
              (p) => p.period == _period,
            ))
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LgRow(
                  key: ValueKey('plan-${plan.productId}'),
                  icon: Icons.workspace_premium_outlined,
                  title: plan.tier == billing.tier
                      ? '${_name(l, plan.tier)} · ${l.paywallCurrentPlan}'
                      : _name(l, plan.tier),
                  subtitle: _desc(l, plan.tier),
                  trailing: Text(
                    '${billing.products[plan.productId]?.price ?? plan.fallbackUsd}'
                    ' ${plan.period == BillingPeriod.monthly ? l.periodMonthly : l.periodYearly}',
                  ),
                  onTap: billing.busy ? null : () => billing.buy(plan),
                ),
              ),
            if (!billing.storeReady) Text(l.paywallUnavailable),
            if (billing.error != null) Text(l.paywallError),
            const SizedBox(height: 8),
            LgButton.secondary(
              label: l.paywallRestore,
              onPressed: billing.busy
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      await billing.restore();
                      await Future<void>.delayed(const Duration(seconds: 2));
                      messenger
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              billing.tier != BillingTier.free
                                  ? l.paywallRestored
                                  : l.paywallNothingToRestore,
                            ),
                          ),
                        );
                    },
            ),
            const SizedBox(height: 12),
            Text(l.paywallFreeNote),
            const SizedBox(height: 8),
            Text(l.paywallLegal),
            Row(
              children: [
                TextButton(
                  onPressed: () => context.push('/terms'),
                  child: Text(l.paywallTerms),
                ),
                TextButton(
                  onPressed: () => context.push('/profile/privacy'),
                  child: Text(l.paywallPrivacy),
                ),
              ],
            ),
            LgButton.secondary(
              label: l.paywallBack,
              onPressed: () => context.go('/home'),
            ),
          ],
        );
      },
    );
  }
}

String _capital(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
