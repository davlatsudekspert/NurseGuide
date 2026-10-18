import 'package:wakelock_plus/wakelock_plus.dart';

/// Ekranni yoqiq ushlash (taqdimot va "Katta ekran").
abstract class ScreenAwake {
  Future<void> set({required bool on});
}

class WakelockScreenAwake implements ScreenAwake {
  const WakelockScreenAwake();

  @override
  Future<void> set({required bool on}) async {
    try {
      await WakelockPlus.toggle(enable: on);
    } on Object {
      // Plagin yo'q (test/veb) — ekran tizim sozlamasiga ko'ra o'chadi.
    }
  }
}

/// Qurilma bilan bog'liq qismlar — testlarda almashtiriladi.
abstract final class AppDevice {
  static ScreenAwake screenAwake = const WakelockScreenAwake();
}
