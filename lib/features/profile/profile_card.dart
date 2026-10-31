// ignore_for_file: prefer_initializing_formals
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/storage/kv_store.dart';

/// Ijtimoiy tarmoqlar (foydalanuvchi o'zi qo'shsa).
enum SocialNetwork {
  instagram('Instagram', 'https://instagram.com/', 'instagram.com'),
  telegram('Telegram', 'https://t.me/', 't.me'),
  facebook('Facebook', 'https://facebook.com/', 'facebook.com'),
  youtube('YouTube', 'https://youtube.com/@', 'youtube.com'),
  tiktok('TikTok', 'https://tiktok.com/@', 'tiktok.com');

  const SocialNetwork(this.label, this.base, this.host);

  final String label;
  final String base;
  final String host;

  String get key => 'profile.social.$name';

  /// Kiritilgan nom (`@ali`, `ali`) yoki havoladan to'liq https manzil.
  /// Havola faqat shu tarmoqning o'z domenida bo'lsa qabul qilinadi; bo'sh
  /// kiritish — `''` (o'chirish); noto'g'ri — `null`.
  String? normalize(String input) {
    final t = input.trim();
    if (t.isEmpty) return '';
    if (t.contains(RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*:'))) {
      final u = Uri.tryParse(t);
      if (u == null ||
          u.scheme != 'https' && u.scheme != 'http' ||
          !(u.host == host || u.host == 'www.$host')) {
        return null;
      }
      return u.replace(scheme: 'https').toString();
    }
    final h = t.replaceFirst(RegExp(r'^@'), '');
    if (!RegExp(r'^[A-Za-z0-9._-]{2,60}$').hasMatch(h)) return null;
    return '$base$h';
  }
}

/// Profil rasmi: qurilmadagi fayl (test/veb — xotira).
abstract class ProfilePhotoStorage {
  Future<Uint8List?> read();
  Future<void> write(Uint8List bytes);
  Future<void> delete();
}

class DeviceProfilePhotoStorage implements ProfilePhotoStorage {
  const DeviceProfilePhotoStorage();

  Future<File> _file() async => File(
    '${(await getApplicationSupportDirectory()).path}/profile_photo.jpg',
  );

  @override
  Future<Uint8List?> read() async {
    try {
      final f = await _file();
      return await f.exists() ? await f.readAsBytes() : null;
    } on Object {
      return null; // plagin yo'q (test/veb)
    }
  }

  @override
  Future<void> write(Uint8List bytes) async {
    try {
      await (await _file()).writeAsBytes(bytes, flush: true);
    } on Object {
      // yozilmasa — rasm shu seansda ko'rinadi, xolos
    }
  }

  @override
  Future<void> delete() async {
    try {
      final f = await _file();
      if (await f.exists()) await f.delete();
    } on Object {
      // yo'q
    }
  }
}

abstract class ProfilePhotoPicker {
  Future<Uint8List?> pick();
}

class GalleryProfilePhotoPicker implements ProfilePhotoPicker {
  const GalleryProfilePhotoPicker();

  @override
  Future<Uint8List?> pick() async {
    final f = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    return f?.readAsBytes();
  }
}

/// «Mening profilim»: rasm, ish joyi va ijtimoiy tarmoqlar — ixtiyoriy,
/// FAQAT shu qurilmada saqlanadi (serverga yuborilmaydi).
class ProfileCardController extends ChangeNotifier {
  ProfileCardController(
    this._store, {
    ProfilePhotoStorage photos = const DeviceProfilePhotoStorage(),
    ProfilePhotoPicker picker = const GalleryProfilePhotoPicker(),
  }) : _photos = photos,
       _picker = picker {
    unawaited(_loadPhoto());
  }

  final KeyValueStore _store;
  final ProfilePhotoStorage _photos;
  final ProfilePhotoPicker _picker;
  Uint8List? _photo;

  Uint8List? get photo => _photo;

  String get name => _store.getString(StoreKeys.profileName) ?? '';
  String get workplace => _store.getString(StoreKeys.profileWorkplace) ?? '';
  String get position => _store.getString(StoreKeys.profilePosition) ?? '';
  String get city => _store.getString(StoreKeys.profileCity) ?? '';

  /// Saqlangan to'liq havola (yo'q — bo'sh).
  String link(SocialNetwork n) => _store.getString(n.key) ?? '';

  List<SocialNetwork> get networks => [
    for (final n in SocialNetwork.values)
      if (link(n).isNotEmpty) n,
  ];

  bool get isEmpty =>
      _photo == null &&
      name.isEmpty &&
      workplace.isEmpty &&
      position.isEmpty &&
      city.isEmpty &&
      networks.isEmpty;

  Future<void> _loadPhoto() async {
    final b = await _photos.read();
    if (b != null) {
      _photo = b;
      notifyListeners();
    }
  }

  /// Galereyadan rasm tanlaydi; bekor qilinsa `false`.
  Future<bool> pickPhoto() async {
    final b = await _picker.pick();
    if (b == null) return false;
    await setPhoto(b);
    return true;
  }

  Future<void> setPhoto(Uint8List bytes) async {
    _photo = bytes;
    notifyListeners();
    await _photos.write(bytes);
  }

  Future<void> removePhoto() async {
    _photo = null;
    notifyListeners();
    await _photos.delete();
  }

  /// Matn maydonlari va havolalarni saqlaydi (bo'sh qiymat — o'chiradi).
  Future<void> save({
    required String name,
    required String workplace,
    required String position,
    required String city,
    required Map<SocialNetwork, String> links,
  }) async {
    await _store.setString(StoreKeys.profileName, name.trim());
    await _store.setString(StoreKeys.profileWorkplace, workplace.trim());
    await _store.setString(StoreKeys.profilePosition, position.trim());
    await _store.setString(StoreKeys.profileCity, city.trim());
    for (final e in links.entries) {
      await _store.setString(e.key.key, e.value);
    }
    notifyListeners();
  }

  /// Hamma profil ma'lumotlarini o'chiradi (chiqish/hisobni o'chirish).
  Future<void> clear() async {
    for (final k in [
      StoreKeys.profileName,
      StoreKeys.profileWorkplace,
      StoreKeys.profilePosition,
      StoreKeys.profileCity,
      for (final n in SocialNetwork.values) n.key,
    ]) {
      await _store.setString(k, '');
    }
    await removePhoto();
  }
}
