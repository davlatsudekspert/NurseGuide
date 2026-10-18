import 'package:material_ui/material_ui.dart';

/// NurseGuide asosiy ranglari (teal).
abstract final class LgBrand {
  /// Asosiy: chuqur teal.
  static const primary = Color(0xFF0F4C5C);

  /// Ikkinchi: yashil-teal.
  static const second = Color(0xFF1B6B6B);

  /// Aksent: yalpiz (tunda asosiy rang sifatida ham ishlatiladi).
  static const mint = Color(0xFF7FD1B9);
}

/// NurseGuide rang tokenlari. Kunduzgi: iliq fil suyagi fon va kartalar +
/// teal; tungi: chuqur teal-qora + yalpiz aksent. Ivory mavzusi
/// ([ivoryLight], [ivoryDark]) — `themes.dart` dagi reestrda (D-64).
@immutable
class LgPalette extends ThemeExtension<LgPalette> {
  const LgPalette({
    required this.bg,
    required this.paper,
    required this.ink,
    required this.sub,
    required this.line,
    required this.outline,
    required this.brand,
    required this.onBrand,
    required this.soft,
    required this.amber,
    required this.amberBg,
    required this.danger,
    required this.shadow,
    required this.accent,
    required this.accentInk,
  });

  /// Ekran foni.
  final Color bg;

  /// Karta/panel foni.
  final Color paper;

  /// Asosiy matn.
  final Color ink;

  /// Ikkinchi darajali matn.
  final Color sub;

  /// Ajratuvchi chiziq (kam ishlatiladi).
  final Color line;

  /// Boshqaruv elementlari chegarasi (maydon, ikkinchi darajali tugma,
  /// tanlanmagan chip, radio) — fon va panelga nisbatan kamida 3:1
  /// (WCAG 1.4.11).
  final Color outline;

  /// Aksent: kunduzi teal, tunda yalpiz.
  final Color brand;

  /// Aksent ustidagi matn.
  final Color onBrand;

  /// Yumshoq aksent foni (chip, tanlangan holat, hero).
  final Color soft;

  /// Ogohlantirish matni.
  final Color amber;

  /// Ogohlantirish foni.
  final Color amberBg;

  /// Xato matni.
  final Color danger;

  /// Soyalar uchun asosiy rang (shaffofligi alohida beriladi).
  final Color shadow;

  /// Dekorativ aksent (Ivory'da oltin): ingichka halqa, nuqta, chiziq.
  /// Matn uchun EMAS — kunduzgi fonda kontrasti 3:1 dan past bo'lishi mumkin.
  final Color accent;

  /// Aksent rangidagi kichik matn (eyebrow): fon/panel/soft ustida ≥ 4,5:1.
  final Color accentInk;

  static const light = LgPalette(
    bg: Color(0xFFF3F1EC),
    paper: Color(0xFFFCFBF8),
    ink: Color(0xFF1A1917),
    sub: Color(0xFF5B5750),
    line: Color(0xFFE5E1D8),
    outline: Color(0xFF857F75),
    brand: LgBrand.primary,
    onBrand: Color(0xFFF6FAF8),
    soft: Color(0xFFDDEBE8),
    amber: Color(0xFF7B4D0B),
    amberBg: Color(0xFFF8EDDA),
    danger: Color(0xFF9A2B1F),
    shadow: LgBrand.primary,
    accent: LgBrand.second,
    accentInk: LgBrand.second,
  );

  static const dark = LgPalette(
    bg: Color(0xFF0C1719),
    paper: Color(0xFF14262A),
    ink: Color(0xFFECF1EE),
    sub: Color(0xFFA9BDB8),
    line: Color(0xFF25393C),
    outline: Color(0xFF628079),
    brand: LgBrand.mint,
    onBrand: Color(0xFF0A2C2E),
    soft: Color(0xFF1B3A3D),
    amber: Color(0xFFF0C586),
    amberBg: Color(0xFF3F3324),
    danger: Color(0xFFFFB4A6),
    shadow: Color(0xFF000000),
    accent: LgBrand.mint,
    accentInk: LgBrand.mint,
  );

  /// Ivory (D-64): fil suyagi fon, oq-iliq kartalar va qora matn (iliq
  /// Ivory ranglari), asosiy rang — NurseGuide teal, aksent — yalpiz.
  static const ivoryLight = LgPalette(
    bg: Color(0xFFF3F1EC),
    paper: Color(0xFFFCFBF8),
    ink: Color(0xFF141414),
    sub: Color(0xFF5F5B54),
    line: Color(0xFFE5E1D8),
    outline: Color(0xFF8A847A),
    brand: LgBrand.primary,
    onBrand: Color(0xFFF6FAF8),
    soft: Color(0xFFEAE6DD),
    amber: Color(0xFF7B4D0B),
    amberBg: Color(0xFFF8EDDA),
    danger: Color(0xFF9A2B1F),
    shadow: Color(0xFF3A332A),
    accent: LgBrand.mint,
    accentInk: LgBrand.second,
  );

  /// Ivory tungi: ko'mir/siyoh fon, ivory matn, yalpiz asosiy rang.
  static const ivoryDark = LgPalette(
    bg: Color(0xFF0F1116),
    paper: Color(0xFF1A1C22),
    ink: Color(0xFFF2EEE5),
    sub: Color(0xFFB4AEA3),
    line: Color(0xFF2B2E35),
    outline: Color(0xFF75706A),
    brand: LgBrand.mint,
    onBrand: Color(0xFF0A2C2E),
    soft: Color(0xFF272A31),
    amber: Color(0xFFF0C586),
    amberBg: Color(0xFF3A3226),
    danger: Color(0xFFFFB4A6),
    shadow: Color(0xFF000000),
    accent: LgBrand.mint,
    accentInk: Color(0xFF9FDCC8),
  );

  static LgPalette of(BuildContext context) =>
      Theme.of(context).extension<LgPalette>()!;

  @override
  LgPalette copyWith({
    Color? bg,
    Color? paper,
    Color? ink,
    Color? sub,
    Color? line,
    Color? outline,
    Color? brand,
    Color? onBrand,
    Color? soft,
    Color? amber,
    Color? amberBg,
    Color? danger,
    Color? shadow,
    Color? accent,
    Color? accentInk,
  }) {
    return LgPalette(
      bg: bg ?? this.bg,
      paper: paper ?? this.paper,
      ink: ink ?? this.ink,
      sub: sub ?? this.sub,
      line: line ?? this.line,
      outline: outline ?? this.outline,
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      soft: soft ?? this.soft,
      amber: amber ?? this.amber,
      amberBg: amberBg ?? this.amberBg,
      danger: danger ?? this.danger,
      shadow: shadow ?? this.shadow,
      accent: accent ?? this.accent,
      accentInk: accentInk ?? this.accentInk,
    );
  }

  @override
  LgPalette lerp(ThemeExtension<LgPalette>? other, double t) {
    if (other is! LgPalette) return this;
    return LgPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      sub: Color.lerp(sub, other.sub, t)!,
      line: Color.lerp(line, other.line, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
      soft: Color.lerp(soft, other.soft, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberBg: Color.lerp(amberBg, other.amberBg, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
    );
  }
}

/// Burchak radiuslari. 2026-10 "mayin" yangilanishi: hammasi biroz
/// kattaroq va yumshoqroq (avval 27 / 23 / 18 / 14) — docs/DESIGN_REVIEW_2026-10-17.md.
abstract final class LgRadius {
  static const double hero = 30;
  static const double card = 26;
  static const double button = 20;
  static const double chip = 16;
  static const double field = 16;
  static const double tag = 20;

  /// Ogohlantirish/ma'lumot bloki, ichki kichik rasm.
  static const double notice = 18;
}

/// Yumshoq, qatlamli soyalar: qattiq chegara o'rniga sirtni fondan
/// ajratadi. Ikki qatlam — keng "ambient" (juda xira) va yaqin "key"
/// (kontur beradi). Tungi rejimda soya ko'rinmaydi — sirt rangining o'zi
/// ajratadi, shuning uchun bo'sh ro'yxat qaytadi.
abstract final class LgShadow {
  static bool _dark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Karta/panel (paper) uchun.
  static List<BoxShadow> card(BuildContext context) {
    if (_dark(context)) return const [];
    final c = LgPalette.of(context).shadow;
    return [
      BoxShadow(
        color: c.withValues(alpha: 0.045),
        blurRadius: 28,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: c.withValues(alpha: 0.03),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ];
  }

  /// Ko'tarilgan element (asosiy tugma, hero karta).
  static List<BoxShadow> raised(BuildContext context) {
    if (_dark(context)) return const [];
    final c = LgPalette.of(context).shadow;
    return [
      BoxShadow(
        color: c.withValues(alpha: 0.10),
        blurRadius: 22,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: c.withValues(alpha: 0.05),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }
}

/// Bo'shliqlar. Telefon gutteri 24, tor ekranda (<=360) 18.
abstract final class LgSpace {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;

  static double gutter(double width) => width <= 360 ? 18 : 24;

  /// Planshetda kontent juda kengayib ketmasligi uchun.
  static const double maxContentWidth = 640;
}

/// Pastki menyuning "muzlatilgan shisha" (frosted glass) bo'yoqlari.
///
/// Sirt yarim shaffof, orqasi [blurSigma] bilan xiralashtiriladi. Shaffoflik
/// shunday tanlanganki, eng yomon fon (sof qora yoki sof oq kontent) ustida
/// ham `ink` va `brand` ranglari kamida 4,5:1 kontrast beradi
/// (test/widget/bottom_nav_test.dart tekshiradi). OS "kontrastni oshirish"ni
/// so'rasa — shaffoflik o'chadi, sirt qattiq ([solid]).
abstract final class LgGlass {
  static const double blurSigma = 22;

  static double surfaceAlpha(Brightness brightness) =>
      brightness == Brightness.dark ? 0.8 : 0.84;

  static Color surface(
    LgPalette p,
    Brightness brightness, {
    bool solid = false,
  }) => solid ? p.paper : p.paper.withValues(alpha: surfaceAlpha(brightness));

  /// Yupqa chegara: shishaning qirrasi; qattiq rejimda — aniq `outline`.
  static Color border(LgPalette p, {bool solid = false}) =>
      solid ? p.outline : p.ink.withValues(alpha: 0.14);
}

/// Harakat davomiyliklari. Reduced motion yoqilganda hammasi nolga tushadi.
/// Mayin harakat: 200–300 ms, ease-out egri chizig'i.
abstract final class LgMotion {
  static const press = Duration(milliseconds: 180);
  static const page = Duration(milliseconds: 260);
  static const header = Duration(milliseconds: 200);

  /// Ekranga kirish (fade + kichik ko'tarilish) animatsiyasi.
  static const enter = Duration(milliseconds: 320);

  /// Bosilganda sirt shuncha kichrayadi.
  static const pressScale = 0.97;

  /// Umumiy egri chiziq: tez boshlanib, yumshoq to'xtaydi.
  static const curve = Curves.easeOutCubic;

  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  static Duration of(BuildContext context, Duration d) =>
      reduced(context) ? Duration.zero : d;
}

/// Minimal bosiladigan maydon (Apple HIG 44pt / Material 48dp — 44 dan kam emas).
const double kMinTap = 44;
