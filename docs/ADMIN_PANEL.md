# Admin panel (egasi uchun)

**Kim kira oladi:** faqat `ADMIN_EMAILS` (GitHub secret → Worker secret) ro'yxatidagi email.
Ro'yxat bo'sh bo'lsa — standart egasi `davlatsudekspert@gmail.com`.

**Qanday kiriladi:** admin panel faqat **email kodi** bilan ochilgan sessiyaga beriladi
(Apple/Google bilan kirilgan sessiyaga berilmaydi, xavfsizlik uchun). Profil → *Email orqali kirish*
→ yuqoridagi email → kod → (birinchi marta) TOTP o'rnatish. Shundan keyin Profil'da "Admin panel" chiqadi.

**Ko'rsatkichlar** (Admin panel → Ko'rsatkichlar):
- ro'yxatdan o'tganlar soni, bugun / 7 kun / 30 kun yangi, hozir onlayn, faol (1/7/30 kun);
- **platformalar:** iPhone (iOS) va Android bo'yicha foydalanuvchilar soni;
- **ro'yxatdan o'tish usuli:** Apple / Google / email kodi;
- rollar (hamshira / talaba / ustoz), tillar, 14 kunlik yangi hisoblar grafigi;
- guruhlar, ustozlar, talabalar, topshiriqlar, natijalar, shikoyatlar va murojaatlar.

**Maxfiylik:** platforma uchun faqat `ios` yoki `android` belgisi saqlanadi (qurilma modeli, IP,
reklama identifikatori yo'q). Email ochiq saqlanmaydi (HMAC + niqoblangan ko'rinish).

Eslatma: ilova hozircha to'liq bepul; "premium" — panelning sifatli ko'rinishi, pullik funksiya emas.
