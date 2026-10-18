import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/design/widgets/collapse_hysteresis.dart';

void main() {
  group('CollapseHysteresis', () {
    // maxScrollExtent katta: ixchamlashgandan keyin ham scroll qilinadi.
    bool step(CollapseHysteresis h, double pixels, double delta) => h.onScroll(
      pixels: pixels,
      delta: delta,
      maxScrollExtent: 2000,
      collapsibleExtent: 120,
    );

    test('collapses only after 14 px in one direction', () {
      final h = CollapseHysteresis();
      expect(step(h, 20, 6), isFalse);
      expect(step(h, 27, 7), isFalse); // jami 13 px
      expect(h.collapsed, isFalse);
      expect(step(h, 28, 1), isTrue); // jami 14 px
      expect(h.collapsed, isTrue);
    });

    test('expands after 14 px back; small jitter does not toggle', () {
      final h = CollapseHysteresis();
      step(h, 100, 30);
      expect(h.collapsed, isTrue);
      // Tebranish: ±5 px — holat o'zgarmaydi.
      for (var i = 0; i < 10; i++) {
        step(h, 95, -5);
        step(h, 100, 5);
      }
      expect(h.collapsed, isTrue);
      step(h, 90, -10);
      expect(h.collapsed, isTrue);
      expect(step(h, 85, -5), isTrue); // jami 15 px teskari
      expect(h.collapsed, isFalse);
    });

    test('direction change resets accumulated distance', () {
      final h = CollapseHysteresis();
      step(h, 30, 10);
      step(h, 25, -5);
      expect(step(h, 35, 10), isFalse); // 10 < 14 — yangi yo'nalishda
      expect(h.collapsed, isFalse);
    });

    test('always expanded at the top', () {
      final h = CollapseHysteresis();
      step(h, 200, 40);
      expect(h.collapsed, isTrue);
      expect(
        h.onScroll(
          pixels: 0,
          delta: -2,
          maxScrollExtent: 2000,
          collapsibleExtent: 120,
        ),
        isTrue,
      );
      expect(h.collapsed, isFalse);
    });

    test('does not collapse short content (prevents oscillation)', () {
      final h = CollapseHysteresis();
      // Kontent 100 px dan oshmaydi, sarlavha 120 px: ixchamlashsa scroll
      // qilinmay qoladi — demak ixchamlashtirilmaydi.
      h.onScroll(
        pixels: 60,
        delta: 60,
        maxScrollExtent: 100,
        collapsibleExtent: 120,
      );
      expect(h.collapsed, isFalse);
    });

    // iPhone xatosi (2026-10-18): ro'yxat oxiridagi bounce teskari scroll
    // deb sanalib, sarlavha kengayar va kontent pastga tushib ketardi.
    test('overscroll and bounce-back at the end are ignored', () {
      final h = CollapseHysteresis();
      step(h, 100, 30);
      expect(h.collapsed, isTrue);
      // Oxirgacha (2000) va undan 150 px o'tib — chegaradan tashqari.
      expect(step(h, 2150, 200), isFalse);
      // Bounce: 2150 → 2000 orqaga, katta manfiy deltalar.
      for (final p in [2120.0, 2080.0, 2040.0, 2010.0, 2000.0]) {
        expect(step(h, p, p - (p + 30)), isFalse);
      }
      expect(h.collapsed, isTrue);
      // Ro'yxat ichida haqiqiy teskari scroll — kengayadi.
      step(h, 1990, -10);
      expect(step(h, 1985, -5), isTrue);
      expect(h.collapsed, isFalse);
    });

    test('overscroll at the top (negative pixels) keeps it expanded', () {
      final h = CollapseHysteresis();
      expect(step(h, -40, -40), isFalse);
      expect(step(h, -10, 30), isFalse);
      expect(h.collapsed, isFalse);
    });

    test('does not collapse when the shrunk extent would cut the offset', () {
      final h = CollapseHysteresis();
      // max 300, sarlavha 120 → yig'ilsa max 180; offset 250 > 180:
      // pozitsiya chegaradan chiqib, fizika uni orqaga qaytarardi.
      h.onScroll(
        pixels: 250,
        delta: 30,
        maxScrollExtent: 300,
        collapsibleExtent: 120,
      );
      expect(h.collapsed, isFalse);
      // Yuqoriroqda — yig'iladi.
      final h2 = CollapseHysteresis();
      h2.onScroll(
        pixels: 150,
        delta: 30,
        maxScrollExtent: 300,
        collapsibleExtent: 120,
      );
      expect(h2.collapsed, isTrue);
    });

    test('NaN input is ignored', () {
      final h = CollapseHysteresis();
      expect(step(h, double.nan, 50), isFalse);
      expect(step(h, 50, double.nan), isFalse);
      expect(h.collapsed, isFalse);
    });

    test('threshold must stay within 12–16 px', () {
      expect(() => CollapseHysteresis(threshold: 8), throwsAssertionError);
      expect(() => CollapseHysteresis(threshold: 20), throwsAssertionError);
    });
  });

  group('parseDecimal', () {});
}
