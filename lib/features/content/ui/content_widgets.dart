import 'package:material_ui/material_ui.dart';

import '../../../app/app_scope.dart';
import '../../../design/widgets/lg_widgets.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../content_controller.dart';
import '../content_model.dart';

/// Kontent paketi holatiga qarab: loading → spinner, failed → xato va
/// "qayta urinish", ready → [builder]. Tekshiruvdan o'tmagan ma'lumot hech
/// qachon ko'rsatilmaydi.
class ContentGate extends StatelessWidget {
  const ContentGate({super.key, required this.builder});

  final Widget Function(BuildContext context, ContentPack pack) builder;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final content = context.services.content;
    return ListenableBuilder(
      listenable: content,
      builder: (context, _) {
        final pack = content.pack;
        if (pack != null) return builder(context, pack);
        if (content.state == ContentLoadState.failed) {
          return LgStateView(
            kind: StateKind.error,
            title: l.contentErrorTitle,
            message: l.contentErrorBody,
            actionLabel: l.actionRetry,
            onAction: content.load,
          );
        }
        return LgStateView(kind: StateKind.loading, title: l.contentLoading);
      },
    );
  }
}
