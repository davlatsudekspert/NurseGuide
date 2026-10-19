import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../themes.dart';
import '../tokens.dart';

/// "Tiniq shisha" foni: iliq-yashil marvarid (tunda chuqur teal) ustida
/// yumshoq "aurora" dog'lari — mint, teal va shampan. Boshqa mavzularda
/// [child] o'zgarishsiz qaytariladi.
class LgBackdrop extends StatelessWidget {
  const LgBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!LgStyle.of(context).glass) return child;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(painter: _AuroraPainter(dark: dark)),
        ),
        child,
      ],
    );
  }
}

class _AuroraPainter extends CustomPainter {
  const _AuroraPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size s) {
    final top = dark ? const Color(0xFF082026) : const Color(0xFFF4F5EC);
    final bottom = dark ? const Color(0xFF05141A) : const Color(0xFFE4EEE8);
    canvas.drawRect(
      Offset.zero & s,
      Paint()
        ..shader = ui.Gradient.linear(Offset.zero, Offset(0, s.height), [
          top,
          bottom,
        ]),
    );
    void blob(Offset c, double r, Color col) => canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = ui.Gradient.radial(c, r, [col, col.withValues(alpha: 0)]),
    );
    final h = s.height;
    if (dark) {
      blob(Offset(s.width, 70), 320, LgBrand.mint.withValues(alpha: 0.16));
      blob(Offset(0, 380), 280, LgBrand.second.withValues(alpha: 0.30));
      blob(
        Offset(s.width * 0.95, h * 0.62),
        300,
        LgBrand.mint.withValues(alpha: 0.10),
      );
    } else {
      blob(
        Offset(s.width * 0.98, 70),
        330,
        LgBrand.mint.withValues(alpha: 0.5),
      );
      blob(Offset(0, 360), 280, LgBrand.second.withValues(alpha: 0.13));
      blob(
        Offset(s.width * 0.95, h * 0.58),
        300,
        LgBrand.mint.withValues(alpha: 0.28),
      );
      blob(
        Offset(s.width * 0.05, h * 0.9),
        280,
        LgBrand.champagne.withValues(alpha: 0.26),
      );
    }
  }

  @override
  bool shouldRepaint(_AuroraPainter old) => old.dark != dark;
}
