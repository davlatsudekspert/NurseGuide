// Eski versiyani to'xtatish: app-config.json bo'yicha; xatoda ilova ishlayveradi.
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nurseguide/core/update/update_gate.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

Widget _app(Widget child) => MaterialApp(
  locale: const Locale('en'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: child,
);

void main() {
  test('konfiguratsiya: to‘g‘ri, noto‘g‘ri va bo‘sh', () {
    const ok =
        '{"android":{"min_build":70,"url":"https://x.uz/a"},"ios":{"min_build":9}}';
    final a = parseUpdateConfig(ok, android: true)!;
    expect(a.minBuild, 70);
    expect(a.url, 'https://x.uz/a');
    expect(parseUpdateConfig(ok, android: false)!.url, isNull);
    expect(a.blocks(69), isTrue);
    expect(a.blocks(70), isFalse);
    expect(a.blocks(0), isFalse); // debug/test: build raqami yo'q
    expect(parseUpdateConfig('xato', android: true), isNull);
    expect(
      parseUpdateConfig('{"android":{"min_build":"7"}}', android: true),
      isNull,
    );
    expect(
      parseUpdateConfig(
        '{"android":{"min_build":5,"url":"http://x"}}',
        android: true,
      )!.url,
      isNull,
    );
  });

  testWidgets('eskirgan versiya to‘xtatiladi', (tester) async {
    await tester.pumpWidget(
      _app(
        UpdateGate(
          build: 66,
          fetch: () async => const UpdateRequirement(70, 'https://x.uz/a'),
          child: const Text('ilova'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('update-required')), findsOneWidget);
    expect(find.text('ilova'), findsNothing);
  });

  testWidgets('yangi versiya, xato va build=0 da ilova ishlaydi', (
    tester,
  ) async {
    for (final (build, fetch) in <(int, UpdateFetcher)>[
      (70, () async => const UpdateRequirement(70, null)),
      (66, () async => null), // tarmoq xatosi
      (0, () async => const UpdateRequirement(999, null)),
    ]) {
      await tester.pumpWidget(
        _app(
          UpdateGate(
            key: UniqueKey(),
            build: build,
            fetch: fetch,
            child: const Text('ilova'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('ilova'), findsOneWidget, reason: 'build $build');
    }
  });
}
