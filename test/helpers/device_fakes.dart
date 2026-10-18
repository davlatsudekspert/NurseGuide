import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/device/device.dart';

/// Ekranni yoqiq ushlash chaqiruvlarini yozib boradi.
class RecordingScreenAwake implements ScreenAwake {
  final calls = <bool>[];

  @override
  Future<void> set({required bool on}) async => calls.add(on);
}

/// Qurilma qismlarini soxtasi bilan almashtiradi (test oxirida tiklanadi).
({RecordingScreenAwake awake}) installDeviceFakes() {
  final awake = RecordingScreenAwake();
  final old = AppDevice.screenAwake;
  AppDevice.screenAwake = awake;
  addTearDown(() => AppDevice.screenAwake = old);
  return (awake: awake);
}
