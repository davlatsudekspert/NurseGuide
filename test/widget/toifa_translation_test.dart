import 'package:flutter_test/flutter_test.dart';
import 'package:nurseguide/core/storage/kv_store.dart';
import 'package:nurseguide/features/toifa/toifa_bank.dart';
import 'package:nurseguide/features/toifa/toifa_controller.dart';

import '../helpers/fixtures.dart';

Future<ToifaBank> _bank() async {
  final c = ToifaController(MemoryKeyValueStore(), bundle: testBundle);
  await c.ensureLoaded();
  return c.bank!;
}

void main() {
  group('tarjima ma’lumotlari', () {
    test('ru/en prompt tarjimani, uz — asl matnni qaytaradi', () async {
      final q = (await _bank()).tests.first;
      expect(q.prompt('ru'), q.translations['ru']!.text);
      expect(q.prompt('en'), q.translations['en']!.text);
      expect(q.prompt('uz'), q.text);
      expect(q.option(0, 'en'), q.translations['en']!.options[0]);
      expect(q.option(0, 'uz'), q.options[0]);
      expect(q.hasTranslation('ru'), true);
      expect(q.hasTranslation('uz'), false);
    });
  });
}
