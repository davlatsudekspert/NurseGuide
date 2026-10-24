import 'package:material_ui/material_ui.dart';

import '../../core/storage/kv_store.dart';
import '../../design/themes.dart';

export '../../design/themes.dart' show LgThemeId;

/// Foydalanuvchi tanlagan yo'nalish. Bu faqat UI afzalligi: hech qanday
/// ruxsat bermaydi (haqiqiy vakolat serverda tekshiriladi).
///
/// * [nurse] — ishlayotgan hamshira (toifa, manipulyatsiyalar);
/// * [student] — kollej talabasi (darslar, testlar);
/// * [teacher] — ustoz (guruhlar). Faqat hisobli va server tasdiqlagan.
enum AppRole {
  nurse('hamshira'),
  student('talaba'),
  teacher('ustoz');

  const AppRole(this.wire);

  /// Serverga yuboriladigan (va undan keladigan) qiymat.
  final String wire;

  /// Server qiymati (yoki ingliz nomi) → rol.
  static AppRole? tryWire(String? raw) {
    switch (raw) {
      case 'nurse':
        return AppRole.nurse;
      case 'student':
        return AppRole.student;
      case 'teacher':
        return AppRole.teacher;
    }
    for (final r in values) {
      if (r.wire == raw) return r;
    }
    return null;
  }
}

/// Ish yo'nalishi: kunlik savollar shu bankdan olinadi. [bank] — savollar
/// bankidagi `bank` qiymati.
enum WorkDirection {
  nursing('hamshiralik'),
  higher('oliy_hamshiralik'),
  patronage('patronaj'),

  /// Akusherlik ishi (o'rta tibbiyot xodimlari): test banki `akusherlik`.
  obstetrics('akusherlik'),

  /// Rentgen laborant (o'rta tibbiyot xodimlari): test banki `rentgen_laborant`.
  radiology('rentgen_laborant'),

  /// DMED tizimida ishlash: savol-javob kartalari (test banki yo'q, kunlik
  /// test umumiy savollardan).
  dmed('dmed');

  const WorkDirection(this.bank);

  final String bank;

  static WorkDirection? tryBank(String? raw) {
    for (final d in values) {
      if (d.bank == raw) return d;
    }
    return null;
  }
}

/// Qo'llab-quvvatlanadigan interfeys tillari.
enum AppLanguage {
  uz,
  ru,
  en;

  Locale get locale => Locale(name);

  String get shortLabel => name.toUpperCase();

  static AppLanguage? tryParse(String? code) {
    for (final l in values) {
      if (l.name == code) return l;
    }
    return null;
  }

  /// Tizim tili qo'llab-quvvatlansa — o'sha, aks holda o'zbekcha.
  static AppLanguage fromSystem(Iterable<Locale> systemLocales) {
    for (final locale in systemLocales) {
      final match = tryParse(locale.languageCode);
      if (match != null) return match;
    }
    return AppLanguage.uz;
  }
}

/// Matn o'lchami (tizim matn masshtabiga qo'shimcha ko'paytirgich).
enum FontSize {
  small(0.9),
  normal(1.0),
  large(1.15),
  xlarge(1.3);

  const FontSize(this.factor);
  final double factor;

  static FontSize? tryParse(String? code) {
    for (final f in values) {
      if (f.name == code) return f;
    }
    return null;
  }
}

class SettingsController extends ChangeNotifier {
  SettingsController(this._store, {required Iterable<Locale> systemLocales})
    : _language =
          AppLanguage.tryParse(_store.getString(StoreKeys.language)) ??
          AppLanguage.fromSystem(systemLocales),
      _fontSize =
          FontSize.tryParse(_store.getString(StoreKeys.fontSize)) ??
          FontSize.normal,
      _sounds = _store.getBool(StoreKeys.sounds) ?? true,
      _haptics = _store.getBool(StoreKeys.haptics) ?? true,
      _themeMode = _parseTheme(_store.getString(StoreKeys.themeMode)),
      _appTheme =
          LgThemeId.tryParse(_store.getString(StoreKeys.appTheme)) ??
          LgThemeId.classic,
      _role = _parseRole(_store.getString(StoreKeys.role)),
      _direction = WorkDirection.tryBank(
        _store.getString(StoreKeys.workDirection),
      ),
      _onboarded = _store.getBool(StoreKeys.onboarded) ?? false,
      // Migratsiya: onboarding tugatgan foydalanuvchi tilni tanlagan deb
      // hisoblanadi — eski o'rnatmalarda til tanlash ekrani chiqmaydi.
      _languageChosen =
          (_store.getBool(StoreKeys.languageChosen) ?? false) ||
          (_store.getBool(StoreKeys.onboarded) ?? false);

  final KeyValueStore _store;

  AppLanguage _language;
  FontSize _fontSize;
  bool _sounds;
  bool _haptics;
  ThemeMode _themeMode;
  LgThemeId _appTheme;
  AppRole? _role;
  WorkDirection? _direction;
  bool _onboarded;
  bool _languageChosen;

  AppLanguage get language => _language;
  FontSize get fontSize => _fontSize;

  /// Javob/natija tovushlari (tizim bosish tovushi).
  bool get sounds => _sounds;

  /// Javob/natija tebranishi (haptik).
  bool get haptics => _haptics;
  ThemeMode get themeMode => _themeMode;

  /// Tanlangan mavzu (Klassik / Ivory) — D-64. Kunduzgi/tungi rejim
  /// ([themeMode]) undan mustaqil.
  LgThemeId get appTheme => _appTheme;

  /// Onboardingda hali tanlanmagan bo'lsa `null`.
  AppRole? get role => _role;

  /// Ish yo'nalishi; tanlanmagan bo'lsa `null` (kunlik savollar umumiy).
  WorkDirection? get workDirection => _direction;

  /// Bosh sahifa uchun: tanlanmagan bo'lsa hamshira ko'rinishi.
  AppRole get effectiveRole => _role ?? AppRole.nurse;

  /// Welcome → (mehmon yoki email) → rol oqimi yakunlanganmi.
  bool get onboarded => _onboarded;

  /// Birinchi ishga tushirishdagi til tanlash ekrani yakunlanganmi.
  bool get languageChosen => _languageChosen;

  /// Til tanlash ekranidan: tilni o'rnatadi va tanlov bajarilganini saqlaydi.
  Future<void> chooseLanguage(AppLanguage value) async {
    _languageChosen = true;
    final saved = setLanguage(value);
    // setLanguage til o'zgarmagan bo'lsa notify qilmaydi — router baribir
    // yangilanishi uchun alohida xabar beramiz.
    notifyListeners();
    await saved;
    await _store.setBool(StoreKeys.languageChosen, true);
  }

  Future<void> setLanguage(AppLanguage value) async {
    if (_language == value) return;
    _language = value;
    notifyListeners();
    await _store.setString(StoreKeys.language, value.name);
  }

  Future<void> setFontSize(FontSize value) async {
    if (_fontSize == value) return;
    _fontSize = value;
    notifyListeners();
    await _store.setString(StoreKeys.fontSize, value.name);
  }

  Future<void> setSounds(bool value) async {
    if (_sounds == value) return;
    _sounds = value;
    notifyListeners();
    await _store.setBool(StoreKeys.sounds, value);
  }

  Future<void> setHaptics(bool value) async {
    if (_haptics == value) return;
    _haptics = value;
    notifyListeners();
    await _store.setBool(StoreKeys.haptics, value);
  }

  Future<void> setThemeMode(ThemeMode value) async {
    if (_themeMode == value) return;
    _themeMode = value;
    notifyListeners();
    await _store.setString(StoreKeys.themeMode, value.name);
  }

  Future<void> setAppTheme(LgThemeId value) async {
    if (_appTheme == value) return;
    _appTheme = value;
    notifyListeners();
    await _store.setString(StoreKeys.appTheme, value.name);
  }

  Future<void> setRole(AppRole value) async {
    if (_role == value) return;
    _role = value;
    notifyListeners();
    await _store.setString(StoreKeys.role, value.wire);
  }

  Future<void> setWorkDirection(WorkDirection value) async {
    if (_direction == value) return;
    _direction = value;
    notifyListeners();
    await _store.setString(StoreKeys.workDirection, value.bank);
  }

  Future<void> completeOnboarding() async {
    if (_onboarded) return;
    _onboarded = true;
    _languageChosen = true;
    notifyListeners();
    await _store.setBool(StoreKeys.onboarded, true);
  }

  /// Chiqishda: welcome qayta ko'rsatiladi, til va mavzu saqlanadi.
  Future<void> resetOnboarding() async {
    _onboarded = false;
    notifyListeners();
    await _store.setBool(StoreKeys.onboarded, false);
  }

  /// Lokal ma'lumotlar o'chirilgandan keyin xotiradagi holatni tozalash.
  void resetToDefaults(Iterable<Locale> systemLocales) {
    _language = AppLanguage.fromSystem(systemLocales);
    _fontSize = FontSize.normal;
    _sounds = true;
    _haptics = true;
    _themeMode = ThemeMode.system;
    _appTheme = LgThemeId.classic;
    _role = null;
    _direction = null;
    _onboarded = false;
    _languageChosen = false;
    notifyListeners();
  }

  static ThemeMode _parseTheme(String? raw) => switch (raw) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  static AppRole? _parseRole(String? raw) {
    return AppRole.tryWire(raw);
  }
}
