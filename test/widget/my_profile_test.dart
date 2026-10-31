// «Mening profilim»: rasm (header ham), ish joyi, ijtimoiy ikonlar, saqlash.
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/features/profile/profile_card.dart';
import 'package:nurseguide/l10n/gen/app_localizations.dart';

import '../helpers/harness.dart';

final uz = lookupAppLocalizations(const Locale('uz'));

// 1x1 PNG
final _png = Uint8List.fromList(const [
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  72,
  68,
  82,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  8,
  6,
  0,
  0,
  0,
  31,
  21,
  196,
  137,
  0,
  0,
  0,
  13,
  73,
  68,
  65,
  84,
  120,
  156,
  99,
  248,
  255,
  255,
  63,
  0,
  5,
  254,
  2,
  254,
  167,
  53,
  129,
  132,
  0,
  0,
  0,
  0,
  73,
  69,
  78,
  68,
  174,
  66,
  96,
  130,
]);

class _Photos implements ProfilePhotoStorage {
  Uint8List? data;
  @override
  Future<Uint8List?> read() async => data;
  @override
  Future<void> write(Uint8List b) async => data = b;
  @override
  Future<void> delete() async => data = null;
}

class _Picker implements ProfilePhotoPicker {
  @override
  Future<Uint8List?> pick() async => _png;
}

void main() {
  setUpAll(loadAppFonts);

  test(
    'havola normallashtiriladi: nom, @nom, o‘z domeni; begona domen rad',
    () {
      expect(
        SocialNetwork.instagram.normalize('@ali_nurse'),
        'https://instagram.com/ali_nurse',
      );
      expect(SocialNetwork.telegram.normalize('ali'), 'https://t.me/ali');
      expect(
        SocialNetwork.youtube.normalize('ali'),
        'https://youtube.com/@ali',
      );
      expect(
        SocialNetwork.instagram.normalize('https://www.instagram.com/ali/'),
        'https://www.instagram.com/ali/',
      );
      expect(
        SocialNetwork.instagram.normalize('http://instagram.com/ali'),
        'https://instagram.com/ali',
      );
      expect(SocialNetwork.instagram.normalize('  '), '');
      expect(SocialNetwork.instagram.normalize('https://evil.com/ali'), isNull);
      expect(SocialNetwork.instagram.normalize('javascript:alert(1)'), isNull);
      expect(SocialNetwork.telegram.normalize('a b'), isNull);
    },
  );

  testWidgets('rasm, ish joyi va ikonlar: saqlanadi va profilda ko‘rinadi', (
    tester,
  ) async {
    final photos = _Photos();
    final s = await makeServices(
      tester,
      profilePhotos: photos,
      profilePicker: _Picker(),
    );
    await pumpApp(tester, s, size: const Size(390, 2400));
    await goTo(tester, '/profile/me');
    await tester.tap(find.byKey(const ValueKey('my-photo-pick')));
    await tester.pumpAndSettle();
    expect(s.profileCard.photo, isNotNull);
    expect(photos.data, isNotNull);
    await tester.enterText(find.byKey(const ValueKey('my-name')), 'Dilnoza');
    await tester.enterText(
      find.byKey(const ValueKey('my-workplace')),
      '3-shahar poliklinikasi',
    );
    await tester.enterText(
      find.byKey(const ValueKey('my-social-instagram')),
      '@dilnoza_nurse',
    );
    await tester.enterText(
      find.byKey(const ValueKey('my-social-telegram')),
      'https://evil.com/x',
    );
    await tester.tap(find.byKey(const ValueKey('my-save')));
    await tester.pumpAndSettle();
    // Begona domen — xato, hech narsa saqlanmadi.
    expect(find.text(uz.profileLinkInvalid('Telegram')), findsOneWidget);
    expect(s.profileCard.name, isEmpty);
    await tester.enterText(
      find.byKey(const ValueKey('my-social-telegram')),
      '',
    );
    await tester.tap(find.byKey(const ValueKey('my-save')));
    await tester.pumpAndSettle();
    expect(s.profileCard.name, 'Dilnoza');
    expect(s.profileCard.workplace, '3-shahar poliklinikasi');
    expect(s.profileCard.networks, [SocialNetwork.instagram]);
    await goTo(tester, '/profile');
    expect(find.byKey(const ValueKey('social-instagram')), findsOneWidget);
    expect(find.textContaining('Dilnoza'), findsWidgets);
    // Rasmni olib tashlash.
    await goTo(tester, '/profile/me');
    await tester.tap(find.byKey(const ValueKey('my-photo-remove')));
    await tester.pumpAndSettle();
    expect(s.profileCard.photo, isNull);
    expect(photos.data, isNull);
    expect(tester.takeException(), isNull);
  });
}
