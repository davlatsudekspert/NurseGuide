import 'package:shared_preferences/shared_preferences.dart';

/// Maxfiy bo'lmagan lokal holat uchun kichik kalit-qiymat ombori.
///
/// UI va domen qatlamlari `shared_preferences` ga to'g'ridan-to'g'ri
/// bog'lanmaydi: testlarda [MemoryKeyValueStore], ilovada
/// [PrefsKeyValueStore] beriladi. Token va boshqa sirlar bu yerga
/// yozilmaydi (keyingi bosqich: flutter_secure_storage).
abstract interface class KeyValueStore {
  String? getString(String key);
  List<String>? getStringList(String key);
  bool? getBool(String key);
  Future<void> setString(String key, String value);
  Future<void> setStringList(String key, List<String> value);
  Future<void> setBool(String key, bool value);
  Future<void> remove(String key);
  Future<void> clear();
}

/// Ilova ishlatadigan barcha kalitlar — bitta joyda.
abstract final class StoreKeys {
  static const language = 'settings.language';
  static const themeMode = 'settings.theme';

  /// Ilova mavzusi (`classic` / `ivory`) — D-64.
  static const appTheme = 'settings.appTheme';
  static const fontSize = 'settings.fontSize';
  static const sounds = 'settings.sounds';
  static const haptics = 'settings.haptics';
  static const role = 'settings.role';

  /// Ish yo'nalishi (savol banki): kunlik savollar shunga moslanadi.
  static const workDirection = 'settings.workDirection';
  static const onboarded = 'settings.onboarded';

  /// Obuna darajasi va amal qilish muddati (do'kon hodisalaridan).
  static const billingTier = 'billing.tier';
  static const billingUntil = 'billing.until';
  static const billingTrial = 'billing.trial';
  static const billingGrantTier = 'billing.grantTier';
  static const billingGrantUntil = 'billing.grantUntil';
  static const billingTeacher = 'billing.teacher';
  static const languageChosen = 'settings.languageChosen';
  static const session = 'auth.session';
  static const bookmarks = 'content.bookmarks';
  static const quizProgress = 'quiz.progress';
  static const examActive = 'exam.active';
  static const examHistory = 'exam.history';
  static const examAssignments = 'exam.assignments';

  /// Kutubxona PDF lari: oxirgi sahifa va xatcho'plar.
  static const libraryReading = 'library.reading';

  /// Toifa imtihoniga tayyorgarlik: toifa, og'zaki baholar, bilet, test
  /// sozlamalari.
  static const toifaCategory = 'toifa.category';
  static const toifaOral = 'toifa.oral';
  static const toifaTicket = 'toifa.ticket';
  static const toifaTestSettings = 'toifa.testSettings';

  /// Toifa: kunlik mashg'ulot hisobi (mahalliy sana bo'yicha) va maqsad,
  /// og'zaki savollar Leitner qutilari, mashq rejimidagi tugallanmagan test va
  /// "ertaga davom etish" eslatmasi — faqat shu qurilmada.
  static const toifaDaily = 'toifa.daily';
  static const toifaLeitner = 'toifa.leitner';
  static const toifaDrill = 'toifa.drill';
  static const toifaReminder = 'toifa.reminder';

  /// Kunlik savol: bugungi to'plam, ketma-ketlik (kunlar, urug'), eslatma.
  static const dailyToday = 'daily.today';
  static const dailyStreak = 'daily.streak';
  static const dailyReminder = 'daily.reminder';

  /// Guruh darslari — FAQAT ustoz qurilmasida (serverga yuborilmaydi):
  /// boshlanish sanasi, talabalarning lokal belgilari (real ism bo'lishi
  /// mumkin), og'zaki savol-javob belgilari va baholari.
  static const classroomLocal = 'classroom.local';

  /// Mavzu testlari (taqdimot oxirida): boshlangan test, oxirgi urinish va
  /// natijalar tarixi — faqat shu qurilmada.
  static const topicTests = 'classroom.topicTests';

  /// Ma'ruza taqdimotida ekran holati tanlovi (`landscape` / `keep`; yo'q —
  /// har safar so'raladi) — faqat shu qurilmada.
  static const lectureOrientation = 'lecture.orientation';

  /// Bosh sahifadagi “Davom ettirish”: oxirgi ochilgan taqdimot, mavzu testi
  /// yoki bo'lim (`kind:id`) — faqat shu qurilmada (D-69 Q3).
  static const homeResume = 'home.resume';

  static const all = <String>{
    language,
    themeMode,
    appTheme,
    fontSize,
    sounds,
    haptics,
    role,
    workDirection,
    onboarded,
    languageChosen,
    session,
    bookmarks,
    quizProgress,
    examActive,
    examHistory,
    examAssignments,
    libraryReading,
    toifaCategory,
    toifaOral,
    toifaTicket,
    toifaTestSettings,
    toifaDaily,
    toifaLeitner,
    toifaDrill,
    toifaReminder,
    dailyToday,
    dailyStreak,
    dailyReminder,
    classroomLocal,
    topicTests,
    lectureOrientation,
    homeResume,
    billingTier,
    billingUntil,
    billingTrial,
    billingGrantTier,
    billingGrantUntil,
    billingTeacher,
  };
}

class PrefsKeyValueStore implements KeyValueStore {
  PrefsKeyValueStore._(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static Future<PrefsKeyValueStore> open() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: StoreKeys.all,
      ),
    );
    return PrefsKeyValueStore._(prefs);
  }

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  @override
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();
}

/// Testlar uchun xotiradagi ombor. [PrefsKeyValueStore] kabi faqat
/// [StoreKeys.all] dagi kalitlarni qabul qiladi — ro'yxatga qo'shilmagan
/// kalit testda darhol xato beradi (ilovada esa saqlanmay qolardi).
class MemoryKeyValueStore implements KeyValueStore {
  MemoryKeyValueStore([Map<String, Object>? initial]) : _data = {...?initial};

  final Map<String, Object> _data;

  void _check(String key) {
    if (!StoreKeys.all.contains(key)) {
      throw ArgumentError.value(key, 'key', 'not in StoreKeys.all');
    }
  }

  Map<String, Object> get snapshot => Map.unmodifiable(_data);

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  List<String>? getStringList(String key) =>
      (_data[key] as List<String>?)?.toList();

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  Future<void> setString(String key, String value) async {
    _check(key);
    _data[key] = value;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _check(key);
    _data[key] = List<String>.of(value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    _check(key);
    _data[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _check(key);
    _data.remove(key);
  }

  @override
  Future<void> clear() async => _data.clear();
}
