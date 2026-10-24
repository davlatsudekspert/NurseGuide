import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/auth/ui/role_screen.dart';

import '../helpers/fake_backend.dart';
import '../helpers/harness.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('obuna yoqilgan: talaba ustoz rolini tanlay olmaydi', (
    tester,
  ) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
      billingEnabled: true,
    );
    await pumpApp(tester, s);
    await goTo(tester, '/profile/role');
    final teacher = tester.widget<RoleCard>(find.byType(RoleCard).last);
    expect(teacher.locked, isTrue);
    expect(find.byKey(const ValueKey('role-teacher-note')), findsOneWidget);
  });

  testWidgets(
    'Ustoz rejasi (yoki admin bergan Pro) bo‘lsa — ustoz roli ochiq',
    (tester) async {
      final s = await makeServices(
        tester,
        bundle: rootBundle,
        backend: FakeBackend(),
        billingEnabled: true,
      );
      s.billing.applyGrant('teacher', null);
      await pumpApp(tester, s);
      await goTo(tester, '/profile/role');
      final teacher = tester.widget<RoleCard>(find.byType(RoleCard).last);
      expect(teacher.locked, isFalse);
    },
  );

  testWidgets('obuna o‘chiq: ustoz roli oldingidek ochiq', (tester) async {
    final s = await makeServices(
      tester,
      bundle: rootBundle,
      backend: FakeBackend(),
    );
    await pumpApp(tester, s);
    await goTo(tester, '/profile/role');
    expect(tester.widget<RoleCard>(find.byType(RoleCard).last).locked, isFalse);
  });
}
