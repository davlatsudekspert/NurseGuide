import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/app_scope.dart';

/// Javob/natija tovushi va tebranishi. Sozlamalarda ("Tovush va tebranish")
/// o'chirilishi mumkin; platforma imkoni bo'lmasa — jim e'tiborsiz.
abstract final class AppFeedback {
  /// Variant tanlandi.
  static void select(BuildContext context) {
    final s = context.services.settings;
    if (s.haptics) HapticFeedback.selectionClick().ignore();
    if (s.sounds) SystemSound.play(SystemSoundType.click).ignore();
  }

  /// Javob tekshirildi: to'g'ri — yengil, xato — o'rtacha tebranish.
  static void result(BuildContext context, {required bool correct}) {
    final s = context.services.settings;
    if (s.haptics) {
      (correct ? HapticFeedback.lightImpact() : HapticFeedback.mediumImpact())
          .ignore();
    }
    if (s.sounds && !correct) {
      SystemSound.play(SystemSoundType.alert).ignore();
    }
  }
}
