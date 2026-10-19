import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

/// Variant B: "Tiniq shisha" — qo'lda chizilgan 3D ko'rinishdagi shisha
/// obyektlar. Yagona yorug'lik manbai yuqori-chapda; soyalar teal rangli.
enum LgArt { syringe, droplet, stethoscope, heart, clipboard, book, cap, bell }

const _teal = Color(0xFF0F4C5C);
const _teal2 = Color(0xFF1B6B6B);
const _mint = Color(0xFF7FD1B9);
const _champ1 = Color(0xFFFFF3D4);
const _champ2 = Color(0xFFD6BC84);
const _champ3 = Color(0xFF9A8350);

/// Erkin turuvchi obyekt (100x100 koordinata tizimida chiziladi).
class LgObject extends StatelessWidget {
  const LgObject(this.art, {super.key, this.size = 64, this.shadow = true});

  final LgArt art;
  final double size;
  final bool shadow;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _ObjPainter(art, shadow)),
  );
}

/// Shisha "gavhar" plitka ichidagi obyekt.
class LgArtTile extends StatelessWidget {
  const LgArtTile(this.art, {super.key, this.size = 64, this.dark = false});

  final LgArt art;
  final double size;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final r = size * 0.32;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF2C8C8A), Color(0xFF0F4C5C)]
              : const [Color(0xFFFFFFFF), Color(0xFFD5F1E8), Color(0xFFA9E0CF)],
          stops: dark ? null : const [0, 0.55, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: _teal.withValues(alpha: 0.22),
            blurRadius: size * 0.34,
            offset: Offset(0, size * 0.16),
          ),
          BoxShadow(
            color: _teal.withValues(alpha: 0.10),
            blurRadius: 3,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: CustomPaint(
        foregroundPainter: _TileRim(r),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: size * 0.02),
            child: LgObject(art, size: size * 0.80, shadow: false),
          ),
        ),
      ),
    );
  }
}

class _TileRim extends CustomPainter {
  _TileRim(this.r);
  final double r;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rr = RRect.fromRectAndRadius(rect.deflate(0.8), Radius.circular(r));
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..shader = _lg(
          rect.topLeft,
          rect.bottomRight,
          [
            Colors.white.withValues(alpha: 0.95),
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.55),
          ],
          [0, 0.55, 1],
        ),
    );
    // Yuqori ichki yorug'lik (shisha qirrasi).
    final hl = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.14,
        3,
        size.width * 0.72,
        size.height * 0.30,
      ),
      Radius.circular(r * 0.8),
    );
    canvas.drawRRect(
      hl,
      Paint()
        ..shader = _lg(hl.outerRect.topCenter, hl.outerRect.bottomCenter, [
          Colors.white.withValues(alpha: 0.65),
          Colors.white.withValues(alpha: 0),
        ]),
    );
  }

  @override
  bool shouldRepaint(_TileRim old) => false;
}

class _ObjPainter extends CustomPainter {
  _ObjPainter(this.art, this.shadow);
  final LgArt art;
  final bool shadow;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / 100);
    switch (art) {
      case LgArt.syringe:
        _syringe(canvas, shadow);
      case LgArt.droplet:
        _droplet(canvas, shadow);
      case LgArt.stethoscope:
        _stethoscope(canvas, shadow);
      case LgArt.heart:
        _heart(canvas, shadow);
      case LgArt.clipboard:
        _clipboard(canvas, shadow);
      case LgArt.book:
        _book(canvas, shadow);
      case LgArt.cap:
        _cap(canvas, shadow);
      case LgArt.bell:
        _bell(canvas, shadow);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ObjPainter old) => old.art != art || old.shadow != shadow;
}

// --- yordamchilar ----------------------------------------------------------

List<double>? _even(List<Color> c, List<double>? s) =>
    s ??
    (c.length > 2
        ? [for (var i = 0; i < c.length; i++) i / (c.length - 1)]
        : null);

ui.Shader _lg(Offset a, Offset b, List<Color> colors, [List<double>? stops]) =>
    ui.Gradient.linear(a, b, colors, _even(colors, stops));

ui.Shader _rg(Offset c, double r, List<Color> colors, [List<double>? stops]) =>
    ui.Gradient.radial(c, r, colors, _even(colors, stops));

Paint _lin(Offset a, Offset b, List<Color> colors, [List<double>? stops]) =>
    Paint()..shader = _lg(a, b, colors, stops);

Paint _rad(Offset c, double r, List<Color> colors, [List<double>? stops]) =>
    Paint()..shader = _rg(c, r, colors, stops);

void _floor(
  Canvas c,
  double cx,
  double cy,
  double rx,
  double ry, {
  double alpha = 0.26,
}) {
  c.drawOval(
    Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
    Paint()
      ..color = _teal.withValues(alpha: alpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.5),
  );
}

RRect _rr(double x, double y, double w, double h, double r) =>
    RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(r));

void _glow(Canvas c, Path p, Color color, double width, double blur) {
  c.drawPath(
    p,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur),
  );
}

void _stroke(Canvas c, Path p, Color color, double width) {
  c.drawPath(
    p,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color,
  );
}

// --- obyektlar -------------------------------------------------------------

void _syringe(Canvas c, bool shadow) {
  if (shadow) {
    c
      ..save()
      ..translate(58, 66)
      ..rotate(-math.pi / 4);
    _floor(c, 0, 0, 44, 6, alpha: 0.22);
    c.restore();
  }
  c
    ..save()
    ..translate(50, 50)
    ..rotate(-math.pi / 4);
  // igna
  c.drawLine(
    const Offset(-47, 0),
    const Offset(-30, 0),
    _lin(const Offset(-47, -2), const Offset(-47, 2), [
        const Color(0xFFFFFFFF),
        const Color(0xFF8FA8AA),
      ])
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round,
  );
  // nasadka
  c.drawRRect(
    _rr(-32, -4.5, 8, 9, 2),
    _lin(const Offset(0, -4.5), const Offset(0, 4.5), [_teal2, _teal]),
  );
  // shisha silindr (orqa)
  final barrel = _rr(-25, -11, 48, 22, 6);
  c.drawRRect(
    barrel,
    _lin(const Offset(0, -11), const Offset(0, 11), [
      Colors.white.withValues(alpha: 0.96),
      const Color(0xFFCDEFE4).withValues(alpha: 0.8),
      _mint.withValues(alpha: 0.75),
    ]),
  );
  // suyuqlik
  final liquid = _rr(-23, -7.5, 31, 15, 4.5);
  c.drawRRect(
    liquid,
    _lin(const Offset(0, -7.5), const Offset(0, 7.5), [
      const Color(0xFFBDF3DF),
      const Color(0xFF4CC4A0),
      const Color(0xFF1B8A78),
    ]),
  );
  c.drawRRect(
    _rr(-21.5, -6, 28, 2.6, 1.3),
    Paint()..color = Colors.white.withValues(alpha: 0.55),
  );
  // darajalar
  final tick = Paint()
    ..color = _teal.withValues(alpha: 0.55)
    ..strokeWidth = 0.9
    ..strokeCap = StrokeCap.round;
  for (var i = 0; i < 5; i++) {
    final x = -14.0 + i * 8;
    c.drawLine(Offset(x, 11), Offset(x, i.isEven ? 7.2 : 8.8), tick);
  }
  // shisha qirrasi + yorug'lik
  c.drawRRect(
    barrel,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..shader = _lg(const Offset(-25, -11), const Offset(23, 11), [
        Colors.white,
        Colors.white.withValues(alpha: 0.25),
        Colors.white.withValues(alpha: 0.8),
      ]),
  );
  c.drawRRect(
    _rr(-22, -10, 40, 2.6, 1.3),
    Paint()..color = Colors.white.withValues(alpha: 0.75),
  );
  // flanets
  c.drawRRect(
    _rr(21, -15, 4.2, 30, 2),
    _lin(const Offset(21, 0), const Offset(25, 0), [_champ1, _champ3]),
  );
  // shток
  c.drawRRect(
    _rr(25, -2.4, 15, 4.8, 2.4),
    _lin(const Offset(0, -2.4), const Offset(0, 2.4), [
      Colors.white,
      const Color(0xFFA9BDBE),
    ]),
  );
  // bosish diski
  c.drawRRect(
    _rr(39, -11, 5.4, 22, 2.7),
    _lin(
      const Offset(39, 0),
      const Offset(44.4, 0),
      [_champ1, _champ2, _champ3],
      [0, 0.5, 1],
    ),
  );
  c.restore();
}

Path _dropPath() {
  final p = Path()
    ..moveTo(50, 7)
    ..cubicTo(60, 26, 78, 42, 78, 62)
    ..arcTo(
      Rect.fromCircle(center: const Offset(50, 62), radius: 28),
      0,
      math.pi,
      false,
    )
    ..cubicTo(22, 42, 40, 26, 50, 7)
    ..close();
  return p;
}

void _droplet(Canvas c, bool shadow) {
  if (shadow) _floor(c, 50, 92, 24, 4.5);
  final p = _dropPath();
  c.drawPath(
    p,
    _rad(
      const Offset(40, 44),
      62,
      [
        const Color(0xFFEFFFF9),
        const Color(0xFF9DE3CD),
        const Color(0xFF2E9C93),
        const Color(0xFF0F4C5C),
      ],
      [0, 0.3, 0.7, 1],
    ),
  );
  // pastki yorug'lik (kaustika)
  c.save();
  c.clipPath(p);
  c.drawOval(
    Rect.fromCenter(center: const Offset(58, 80), width: 34, height: 16),
    Paint()
      ..color = const Color(0xFFB8F5E0).withValues(alpha: 0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
  );
  c.restore();
  // qirra
  c.drawPath(
    p,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = _lg(
        const Offset(20, 10),
        const Offset(80, 90),
        [
          Colors.white.withValues(alpha: 0.95),
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.4),
        ],
        [0, 0.6, 1],
      ),
  );
  // ko'zgu
  c.save();
  c.translate(37, 54);
  c.rotate(-0.55);
  c.drawOval(
    Rect.fromCenter(center: Offset.zero, width: 9, height: 20),
    Paint()..color = Colors.white.withValues(alpha: 0.78),
  );
  c.restore();
  c.drawCircle(
    const Offset(34, 73),
    2.2,
    Paint()..color = Colors.white.withValues(alpha: 0.6),
  );
}

void _stethoscope(Canvas c, bool shadow) {
  if (shadow) _floor(c, 52, 93, 30, 4.5);
  final left = Path()
    ..moveTo(30, 14)
    ..cubicTo(22, 42, 36, 60, 50, 66);
  final right = Path()
    ..moveTo(70, 14)
    ..cubicTo(78, 42, 64, 60, 50, 66);
  final stem = Path()
    ..moveTo(50, 66)
    ..cubicTo(52, 82, 68, 86, 75, 74);
  for (final p in [left, right, stem]) {
    _glow(c, p.shift(const Offset(0, 3)), _teal.withValues(alpha: 0.28), 6, 3);
    _stroke(c, p, const Color(0xFF2BA189), 7);
    _stroke(c, p, const Color(0xFF7FD1B9), 5.2);
    _stroke(
      c,
      p.shift(const Offset(-1.2, -1.2)),
      Colors.white.withValues(alpha: 0.6),
      1.6,
    );
  }
  // quloq uchliklari
  for (final x in [30.0, 70.0]) {
    c.drawRRect(
      _rr(x - 3, 11, 6, 6, 2),
      _lin(Offset(x - 3, 0), Offset(x + 3, 0), [_champ1, _champ3]),
    );
    c.drawOval(
      Rect.fromCenter(center: Offset(x, 8), width: 10, height: 8),
      _rad(Offset(x - 2, 6), 8, [Colors.white, _mint, _teal2], [0, 0.5, 1]),
    );
  }
  // ko'krak qismi
  const cc = Offset(76, 74);
  c.drawCircle(
    cc.translate(0, 3),
    13,
    Paint()
      ..color = _teal.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
  );
  c.drawCircle(
    cc,
    13,
    _rad(cc.translate(-4, -5), 22, [_champ1, _champ2, _champ3], [0, 0.55, 1]),
  );
  c.drawCircle(
    cc,
    8.2,
    _rad(
      cc.translate(-2, -3),
      12,
      [const Color(0xFFC4F2E3), _teal2, _teal],
      [0, 0.6, 1],
    ),
  );
  c.drawCircle(
    cc.translate(-3, -3.5),
    2,
    Paint()..color = Colors.white.withValues(alpha: 0.85),
  );
}

Path _heartPath() => Path()
  ..moveTo(50, 86)
  ..cubicTo(14, 60, 8, 34, 26, 22)
  ..cubicTo(38, 14, 48, 22, 50, 30)
  ..cubicTo(52, 22, 62, 14, 74, 22)
  ..cubicTo(92, 34, 86, 60, 50, 86)
  ..close();

void _heart(Canvas c, bool shadow) {
  if (shadow) _floor(c, 50, 93, 24, 4);
  final p = _heartPath();
  c.drawPath(
    p,
    _rad(
      const Offset(36, 34),
      70,
      [
        const Color(0xFFE6FFF7),
        const Color(0xFF8FDCC5),
        const Color(0xFF1F8A85),
        const Color(0xFF0F4C5C),
      ],
      [0, 0.3, 0.72, 1],
    ),
  );
  c.save();
  c.clipPath(p);
  c.drawOval(
    Rect.fromCenter(center: const Offset(60, 78), width: 40, height: 16),
    Paint()
      ..color = const Color(0xFFB8F5E0).withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
  );
  c.restore();
  c.drawPath(
    p,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..shader = _lg(
        const Offset(10, 15),
        const Offset(90, 88),
        [
          Colors.white.withValues(alpha: 0.95),
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.35),
        ],
        [0, 0.6, 1],
      ),
  );
  c.save();
  c.translate(30, 30);
  c.rotate(-0.7);
  c.drawOval(
    Rect.fromCenter(center: Offset.zero, width: 20, height: 8),
    Paint()..color = Colors.white.withValues(alpha: 0.6),
  );
  c.restore();
  // EKG
  final e = Path()
    ..moveTo(12, 54)
    ..lineTo(33, 54)
    ..lineTo(40, 43)
    ..lineTo(49, 70)
    ..lineTo(58, 34)
    ..lineTo(64, 54)
    ..lineTo(88, 54);
  _glow(c, e, const Color(0xFFFF4D5A).withValues(alpha: 0.75), 6, 3.2);
  _stroke(c, e, const Color(0xFFFF6470), 2.8);
  _stroke(c, e, const Color(0xFFFFE3E3), 1.0);
}

void _clipboard(Canvas c, bool shadow) {
  if (shadow) _floor(c, 52, 94, 26, 4);
  final board = _rr(20, 14, 60, 78, 11);
  c.drawRRect(
    board.shift(const Offset(0, 3)),
    Paint()
      ..color = _teal.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
  );
  c.drawRRect(
    board,
    _lin(
      const Offset(20, 14),
      const Offset(80, 92),
      [const Color(0xFF3AA79B), _teal2, _teal],
      [0, 0.5, 1],
    ),
  );
  c.drawRRect(
    board,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = _lg(
        const Offset(20, 14),
        const Offset(80, 92),
        [
          Colors.white.withValues(alpha: 0.9),
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.3),
        ],
        [0, 0.6, 1],
      ),
  );
  final paper = _rr(27, 25, 46, 60, 6);
  c.drawRRect(
    paper,
    _lin(const Offset(27, 25), const Offset(73, 85), [
      Colors.white,
      const Color(0xFFDDF3EC),
    ]),
  );
  for (var i = 0; i < 3; i++) {
    final y = 38.0 + i * 15;
    c.drawCircle(
      Offset(36, y),
      4.6,
      i < 2
          ? _rad(
              Offset(34.5, y - 1.5),
              7,
              [const Color(0xFFC8F5E6), _mint, _teal2],
              [0, 0.5, 1],
            )
          : (Paint()..color = const Color(0xFFCFE3DF)),
    );
    if (i < 2) {
      final ck = Path()
        ..moveTo(33.8, y)
        ..lineTo(35.6, y + 1.9)
        ..lineTo(38.6, y - 1.9);
      _stroke(c, ck, Colors.white, 1.3);
    }
    c.drawRRect(
      _rr(45, y - 2, 21, 4, 2),
      Paint()..color = const Color(0xFFBBD6D1),
    );
  }
  // qisqich
  c.drawRRect(
    _rr(36, 7, 28, 15, 6),
    _lin(
      const Offset(36, 7),
      const Offset(64, 22),
      [_champ1, _champ2, _champ3],
      [0, 0.5, 1],
    ),
  );
  c.drawRRect(
    _rr(43, 11.5, 14, 4, 2),
    Paint()..color = _champ3.withValues(alpha: 0.55),
  );
}

void _book(Canvas c, bool shadow) {
  if (shadow) _floor(c, 50, 90, 38, 5);
  Path page(bool left) {
    final p = Path()
      ..moveTo(50, 28)
      ..cubicTo(36, 19, 20, 20, 9, 25)
      ..lineTo(9, 72)
      ..cubicTo(20, 67, 36, 67, 50, 77)
      ..close();
    if (left) return p;
    return p.transform(
      (Matrix4.identity()
            ..translateByDouble(100, 0, 0, 1)
            ..scaleByDouble(-1, 1, 1, 1))
          .storage,
    );
  }

  final lp = page(true);
  final rp = page(false);
  // muqova
  for (final p in [lp, rp]) {
    c.drawPath(
      p.shift(const Offset(0, 5)),
      _lin(const Offset(0, 20), const Offset(0, 80), [_teal2, _teal]),
    );
  }
  c.drawPath(
    lp,
    _lin(const Offset(10, 25), const Offset(50, 77), [
      Colors.white,
      const Color(0xFFCDEFE4),
    ]),
  );
  c.drawPath(
    rp,
    _lin(const Offset(90, 25), const Offset(50, 77), [
      Colors.white,
      const Color(0xFFBFE9DC),
    ]),
  );
  for (final p in [lp, rp]) {
    c.drawPath(
      p,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.white.withValues(alpha: 0.9),
    );
  }
  // satrlar
  final line = Paint()
    ..color = _teal2.withValues(alpha: 0.28)
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round;
  for (var i = 0; i < 4; i++) {
    final y = 35.0 + i * 8;
    c.drawLine(Offset(17, y + 1.5), Offset(42, y + 4.5), line);
    c.drawLine(Offset(83, y + 1.5), Offset(58, y + 4.5), line);
  }
  c.drawLine(
    const Offset(50, 28),
    const Offset(50, 77),
    Paint()
      ..color = _teal.withValues(alpha: 0.5)
      ..strokeWidth = 1.4,
  );
  // belgi (xatcho'p)
  final rib = Path()
    ..moveTo(57, 30)
    ..lineTo(66, 33)
    ..lineTo(66, 54)
    ..lineTo(61.5, 50)
    ..lineTo(57, 54)
    ..close();
  c.drawPath(
    rib,
    _lin(
      const Offset(57, 30),
      const Offset(66, 54),
      [_champ1, _champ2, _champ3],
      [0, 0.5, 1],
    ),
  );
}

void _cap(Canvas c, bool shadow) {
  if (shadow) _floor(c, 50, 88, 36, 5);
  final base = Path()
    ..moveTo(25, 50)
    ..lineTo(25, 68)
    ..cubicTo(25, 82, 75, 82, 75, 68)
    ..lineTo(75, 50)
    ..lineTo(50, 63)
    ..close();
  c.drawPath(
    base,
    _lin(const Offset(25, 50), const Offset(75, 82), [
      _teal2,
      const Color(0xFF0A3441),
    ]),
  );
  final top = Path()
    ..moveTo(50, 20)
    ..lineTo(95, 41)
    ..lineTo(50, 62)
    ..lineTo(5, 41)
    ..close();
  c.drawPath(
    top,
    _lin(
      const Offset(20, 20),
      const Offset(80, 62),
      [const Color(0xFF53BBA6), _teal2, _teal],
      [0, 0.5, 1],
    ),
  );
  c.drawPath(
    top,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeJoin = StrokeJoin.round
      ..shader = _lg(
        const Offset(5, 20),
        const Offset(95, 62),
        [
          Colors.white.withValues(alpha: 0.9),
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.3),
        ],
        [0, 0.6, 1],
      ),
  );
  final gl = Path()
    ..moveTo(50, 24)
    ..lineTo(76, 36)
    ..lineTo(50, 40)
    ..lineTo(24, 36)
    ..close();
  c.drawPath(gl, Paint()..color = Colors.white.withValues(alpha: 0.22));
  c.drawCircle(
    const Offset(50, 41),
    3,
    _rad(const Offset(49, 40), 4, [_champ1, _champ3]),
  );
  final cord = Path()
    ..moveTo(50, 41)
    ..lineTo(88, 46)
    ..lineTo(88, 66);
  _stroke(c, cord, _champ2, 1.8);
  c.drawRRect(
    _rr(84.8, 64, 6.4, 13, 3),
    _lin(
      const Offset(85, 64),
      const Offset(91, 77),
      [_champ1, _champ2, _champ3],
      [0, 0.5, 1],
    ),
  );
}

void _bell(Canvas c, bool shadow) {
  if (shadow) _floor(c, 50, 92, 24, 4);
  final body = Path()
    ..moveTo(26, 70)
    ..cubicTo(33, 62, 33, 50, 35, 42)
    ..cubicTo(38, 24, 62, 24, 65, 42)
    ..cubicTo(67, 50, 67, 62, 74, 70)
    ..close();
  c.drawPath(
    body,
    _rad(
      const Offset(42, 38),
      54,
      [const Color(0xFFEFFFF9), _mint, _teal2, _teal],
      [0, 0.35, 0.8, 1],
    ),
  );
  c.drawPath(
    body,
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = _lg(
        const Offset(25, 25),
        const Offset(75, 72),
        [
          Colors.white.withValues(alpha: 0.9),
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: 0.35),
        ],
        [0, 0.6, 1],
      ),
  );
  c.drawRRect(
    _rr(22, 68, 56, 8, 4),
    _lin(
      const Offset(22, 68),
      const Offset(78, 76),
      [_champ1, _champ2, _champ3],
      [0, 0.5, 1],
    ),
  );
  c.drawCircle(
    const Offset(50, 83),
    6.4,
    _rad(const Offset(48, 81), 9, [_champ1, _champ2, _champ3], [0, 0.55, 1]),
  );
  c.drawCircle(
    const Offset(50, 22),
    4,
    _rad(const Offset(49, 21), 6, [_champ1, _champ2, _champ3], [0, 0.55, 1]),
  );
  c.save();
  c.translate(41, 46);
  c.rotate(-0.25);
  c.drawOval(
    Rect.fromCenter(center: Offset.zero, width: 6, height: 18),
    Paint()..color = Colors.white.withValues(alpha: 0.6),
  );
  c.restore();
}
