import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// Qurilmaning barqaror identifikatori — faqat bepul sinovni qurilma bo'yicha
/// bir martalik qilish uchun. Serverga yuboriladi, u yerda HMAC bilan
/// saqlanadi (ochiq emas). iOS: identifierForVendor; Android: ANDROID_ID.
/// Olib bo'lmasa — hech narsa yuborilmaydi (sinov berilmaydi).
class DeviceIdentity {
  DeviceIdentity({Future<String?> Function()? reader})
    : _reader = reader ?? _platformId;

  final Future<String?> Function() _reader;
  String? _cached;

  Future<String?> get() async {
    final c = _cached;
    if (c != null) return c;
    String? id;
    try {
      id = await _reader();
    } on Object {
      id = null;
    }
    final ok = id != null && RegExp(r'^[A-Za-z0-9._:-]{8,100}$').hasMatch(id);
    // Olib bo'lmasa — sarlavha yuborilmaydi (sinov berilmaydi, qurilma bo'yicha
    // yozuv ko'paymaydi).
    return ok ? _cached = 'ng-$id' : null;
  }

  static Future<String?> _platformId() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return (await DeviceInfoPlugin().iosInfo).identifierForVendor;
      case TargetPlatform.android:
        return const AndroidId().getId();
      default:
        return null;
    }
  }
}
