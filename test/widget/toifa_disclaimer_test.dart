import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('toifa sahifalari tagida «kafolat yo‘q» yozuvi bor', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
    );
    await pumpApp(tester, s);
    for (final r in [
      '/learn/toifa',
      '/learn/toifa/test',
      '/learn/toifa/practice',
    ]) {
      await goTo(tester, r);
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('toifa-no-guarantee')),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        find.byKey(const ValueKey('toifa-no-guarantee')),
        findsOneWidget,
        reason: r,
      );
    }
  });
}
