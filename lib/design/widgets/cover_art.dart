import 'package:material_ui/material_ui.dart';

/// Bo'lim muqovasi: shaffof 3D rasm (assets/images/art/NOM.webp). Rasm
/// bo'lmasa yoki yuklanmasa — hech narsa ko'rsatilmaydi. Bezak: ekran o'qish
/// vositalaridan yashirin.
class CoverArt extends StatelessWidget {
  const CoverArt(this.name, {super.key, this.height = 150});

  final String name;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: ExcludeSemantics(
          child: Image.asset(
            'assets/images/art/$name.webp',
            height: height,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
