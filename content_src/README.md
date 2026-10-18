# content_src — ilovaga kirmaydigan manba va tekshiruv izi
- raw/bank_138_original_cyrillic.json — Oliy hamshiralik bankining ASL kirill matni (tekshirish uchun). Ilova faqat lotin matnni ishlatadi.
- raw/bank_*.json — banklarning lotin ko'rinishi (kalitsiz), parse_flag bilan.
- verification/ — har bir savol uchun manba tekshiruvi natijalari (jsonl), fayl kalitlari, final_status.json.
- oral/ — og'zaki mavzular (SSV ro'yxati) va ularga topilgan javoblar.
- tools/ — parserlar, kirill→lotin o'girish (test_translit.py), kalit siyosati (apply_policy.py), yakuniy JSON yig'ish.
Eslatma: bu katalog ilova paketiga kirmaydi (pubspec assets'da yo'q).
