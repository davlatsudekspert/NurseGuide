/// Sessiya tokenlari saqlanadigan joy. Ilovada — Keychain/Keystore
/// (`SecureApiSessionStore`); testlarda — xotira.
abstract interface class SessionStore {
  Future<String?> read();
  Future<void> write(String value);
  Future<void> delete();
}

class MemorySessionStore implements SessionStore {
  String? value;
  @override
  Future<String?> read() async => value;
  @override
  Future<void> write(String v) async => value = v;
  @override
  Future<void> delete() async => value = null;
}
