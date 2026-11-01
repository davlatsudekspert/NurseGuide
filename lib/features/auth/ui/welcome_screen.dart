import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/app_scope.dart';
import '../../../app/widgets/lg_page.dart';
import '../../../design/brand.dart';
import '../../../design/tokens.dart';
import '../../../design/widgets/lg_widgets.dart';
import '../../../l10n/gen/app_localizations.dart';

export '../../../design/brand.dart' show kHeroImage;

/// Kirish va welcome ekranlaridagi katta brend belgisi (yozuvsiz — yozuv
/// sahifada matn sifatida). Yumaloq burchakli; kunduzgi rejimda yumshoq soya.
///
/// [halo] — welcome ekranida: belgi orqasida yumshoq radial nur (soft →
/// fon) va mayin kirish (xiradan, 0.92 → 1 masshtab). Reduced motion'da
/// animatsiyasiz.
class LgLogoHero extends StatelessWidget {
  const LgLogoHero({
    super.key,
    this.size = 120,
    this.halo = false,
    this.animate = true,
  });

  final double size;
  final bool halo;

  /// Halo bilan kirish animatsiyasi (ekranning o'z animatsiyasi bo'lsa — false).
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final p = LgPalette.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    Widget mark = LgLogoMark(size: size, shadow: !dark);
    if (halo) {
      final glow = size * 2.1;
      mark = SizedBox(
        width: glow,
        height: size * 1.45,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: glow,
              height: glow,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.alphaBlend(p.brand.withValues(alpha: 0.10), p.soft),
                    p.soft.withValues(alpha: 0),
                  ],
                  stops: const [0.3, 1],
                ),
              ),
            ),
            mark,
          ],
        ),
      );
      if (animate && !LgMotion.reduced(context)) {
        mark = TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: LgMotion.enter * 1.5,
          curve: LgMotion.curve,
          builder: (context, t, child) => Opacity(
            opacity: t,
            child: Transform.scale(scale: 0.92 + 0.08 * t, child: child),
          ),
          child: mark,
        );
      }
    }
    return ExcludeSemantics(child: Center(child: mark));
  }
}

/// Tanishtiruv: 3 ta surish mumkin bo'lgan slayd (rasm + qisqa matn).
class _Showcase extends StatefulWidget {
  const _Showcase();

  @override
  State<_Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<_Showcase> {
  final _pc = PageController();
  Timer? _timer;
  int _i = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    // Harakatni kamaytirish yoqilgan bo'lsa — o'zi aylanmaydi.
    if (!MediaQuery.disableAnimationsOf(context)) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted || !_pc.hasClients) return;
        _pc.animateToPage(
          (_i + 1) % 3,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = LgPalette.of(context);
    final text = Theme.of(context).textTheme;
    final slides = [
      ('onb_1', l.onbSlide1Title, l.onbSlide1Body),
      ('onb_2', l.onbSlide2Title, l.onbSlide2Body),
      ('onb_3', l.onbSlide3Title, l.onbSlide3Body),
    ];
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView(
            key: const ValueKey('welcome-showcase'),
            controller: _pc,
            onPageChanged: (v) => setState(() => _i = v),
            children: [
              for (final (img, title, body) in slides)
                Column(
                  children: [
                    Expanded(
                      child: ExcludeSemantics(
                        child: Image.asset(
                          'assets/images/art/$img.webp',
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: text.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      body,
                      style: text.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var k = 0; k < 3; k++)
              Container(
                width: k == _i ? 22 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: k == _i ? p.brand : p.outline,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final services = context.services;
    return LgPage(
      title: l.welcomeTitle,
      subtitle: l.welcomeSubtitle,
      eyebrow: l.welcomeEyebrow,
      showBrand: true,
      showProfile: false,
      leadingHero: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: LgLogoHero(size: 88, halo: true),
      ),
      children: [
        const LgFadeIn(delay: 0.05, child: _Showcase()),
        const SizedBox(height: 16),
        LgFadeIn(
          delay: 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LgButton(
                label: l.welcomeGetStarted,
                onPressed: () => context.push('/welcome/auth'),
              ),
              const SizedBox(height: 10),
              LgButton.secondary(
                label: l.welcomeGuest,
                onPressed: () async {
                  await services.auth.continueAsGuest();
                  if (context.mounted) await context.push('/welcome/role');
                },
              ),
              const SizedBox(height: 4),
              LgButton.link(
                label: l.welcomeSignIn,
                onPressed: () => context.push('/welcome/auth'),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LgSpace.sm),
                child: Text(
                  l.welcomeGuestNote,
                  textAlign: TextAlign.center,
                  style: text.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
