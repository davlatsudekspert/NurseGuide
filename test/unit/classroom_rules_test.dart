import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/backend/backend_models.dart';
import 'package:nurseguide/core/backend/app_backend.dart';

import '../helpers/fake_backend.dart';

/// Test serveridagi ustoz/mavzu qoidalari
/// `supabase/tests/30_teacher_topics.sql` bilan bir xil bo'lishi kerak —
/// UI testlari shunga tayanadi. Kontrakt (backend interfeysi) shu qoidalar.
Future<void> _as(FakeBackend b, String email) async {
  await b.signOut();
  await b.requestCode(email);
  await b.verifyCode(email, FakeBackend.otpCode);
}

Matcher _fails(BackendFailure f) =>
    throwsA(isA<BackendException>().having((e) => e.failure, 'failure', f));

void main() {
  late FakeBackend b;
  late DateTime now;

  setUp(() {
    b = FakeBackend();
    now = DateTime.utc(2026, 10, 10, 9);
    b.groupClock = () => now;
  });

  test('server ulanmagan: hamma yangi amal — unavailable', () async {
    const u = UnconfiguredBackend();
    for (final run in <Future<Object?> Function()>[
      u.registerTeacher,
      () => u.groupTopics('g'),
      () => u.openTopic('g', 't'),
      () => u.markTopicStage('g', 't', TopicStage.lecture),
      () => u.startTopicTest(
        groupId: 'g',
        topicId: 't',
        title: 'Test',
        questionIds: const ['q'],
        correctIndexes: const [0],
      ),
      () => u.finishTopicTest('g', 't'),
      () => u.setMyAlias('g', null),
    ]) {
      await expectLater(run(), _fails(BackendFailure.unavailable));
    }
  });

  test(
    'taxallus yoki tartib raqami; talaba boshqa talabani ko‘rmaydi',
    () async {
      await _as(b, 'teacher@example.com');
      await b.registerTeacher();
      final g = await b.createGroup('KLD ixtisoslashtirish');
      await _as(b, 's1@example.com');
      await b.joinGroup(g.joinCode!);
      await expectLater(
        b.joinGroup(g.joinCode!, displayName: 'X'),
        completion(g.id),
        reason: 'qayta qo‘shilish o‘zgartirmaydi',
      );
      await _as(b, 's2@example.com');
      await b.joinGroup(g.joinCode!, displayName: '  Yulduz ');
      final seen = await b.groupMembers(g.id);
      expect(seen, hasLength(2), reason: 'o‘zi va ustoz');
      expect(seen.where((m) => !m.isTeacher).single.alias, 'Yulduz');
      expect(seen.where((m) => !m.isTeacher).single.seatNo, 2);
      await b.setMyAlias(g.id, null);
      expect(
        (await b.groupMembers(g.id)).where((m) => !m.isTeacher).single.alias,
        isNull,
      );
      await expectLater(
        b.joinGroup(g.joinCode!, displayName: 'Y'),
        completion(g.id),
      );

      await _as(b, 'teacher@example.com');
      final all = await b.groupMembers(g.id);
      expect(all, hasLength(3));
      expect(all.where((m) => !m.isTeacher).map((m) => m.seatNo), [1, 2]);
      expect(all.where((m) => !m.isTeacher).first.alias, isNull);
    },
  );
}
