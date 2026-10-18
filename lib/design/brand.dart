import 'package:material_ui/material_ui.dart';

/// NurseGuide logotipi. Manba: `assets/brand/nurseguide_icon_1024_attached.png`;
/// ilovada ishlatiladigani har tomondan 40 px kesilib 1024 ga qayta
/// masshtablangan nusxa ([kBrandLogo1024] va kichiklari). Yumaloq burchaklar
/// ilovada [LgLogoMark] bilan beriladi.
const kBrandLogo1024 = 'assets/brand/nurseguide_logo_1024.png';
const kBrandLogo512 = 'assets/brand/nurseguide_logo_512.png';
const kBrandLogo256 = 'assets/brand/nurseguide_logo_256.png';

/// Umumiy "hero" fon rasmi (teal to'lqinlar).
const kHeroImage = AssetImage('assets/images/hero.webp');

/// Logotip: yumaloq burchakli kvadrat. Burchak radiusi o'lchamga nisbatan.
class LgLogoMark extends StatelessWidget {
  const LgLogoMark({super.key, this.size = 42, this.shadow = false});

  final double size;

  /// Yumshoq soya (katta belgi, kunduzgi fon).
  final bool shadow;

  static String assetFor(double size) => size <= 64
      ? kBrandLogo256
      : size <= 160
      ? kBrandLogo512
      : kBrandLogo1024;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * 0.22);
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: shadow
              ? const [
                  BoxShadow(
                    color: Color(0x290F4C5C),
                    blurRadius: 28,
                    offset: Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Image.asset(
            assetFor(size),
            width: size,
            height: size,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
    );
  }
}
