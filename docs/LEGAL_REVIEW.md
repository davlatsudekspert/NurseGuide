# Huquqiy matnlarni egasi ko‘rib chiqishi uchun (e’londan oldin)

Quyidagi sahifalar to‘liq yozilgan (uz/ru/en) va ilovaning hozirgi xatti-harakatiga moslab tuzilgan,
lekin **huquqiy maslahat emas**: e’londan, do‘kon formalarini to‘ldirishdan va Google OAuth’ni
“In production”ga o‘tkazishdan oldin egasi/yurist ko‘rib chiqsin. Sahifalarning o‘zida bunday belgi yo‘q.

| Sahifa | Fayl | Kuchga kirgan sana |
|---|---|---|
| Maxfiylik siyosati | `site/privacy/index.html` | 2026-10-18 |
| Foydalanish shartlari | `site/terms/index.html` | 2026-10-18 |
| Hisobni o‘chirish | `site/delete-account/index.html` | — |
| Bosh sahifa (tibbiy ogohlantirish) | `site/index.html` | — |

## Egasi hal qilishi kerak bo‘lgan savollar

1. **Operator nomi.** Matnlarda ma’lumotlarni “NurseGuide jamoasi” boshqaradi deyilgan. Yuridik shaxs/YaTT
   nomi va manzili ko‘rsatilishi kerakmi (O‘zbekiston shaxsiy ma’lumotlar qonuni, App Store/Play talablari)?
2. **Ma’lumotlarni mahalliylashtirish.** O‘zbekiston “Shaxsiy ma’lumotlar to‘g‘risida”gi qonuni fuqarolar
   ma’lumotlarini mamlakat hududidagi texnik vositalarda saqlashni talab qilishi mumkin. Server ma’lumotlari
   Cloudflare (D1) global tarmog‘ida; email esa serverda ochiq saqlanmaydi (HMAC + niqob), lekin hisob
   ma’lumotlari xorijda bo‘lishi mumkin. Sahifada ochiq aytilgan (12-bo‘lim). Yurist baholasin; kerak bo‘lsa
   ko‘chirish rejasi — `docs/BACKEND_CLOUDFLARE.md` oxirgi bo‘lim.
3. **Rozilik va yosh.** Siyosatda “16 yoshgacha mo‘ljallanmagan” deyilgan (14-bo‘lim). Mahalliy qonun va
   do‘kon yosh reytingi (Apple/Play savolnomalari) bilan mosligini tekshiring.
4. **Hisobsiz foydalanish.** Matnlarda “asosiy o‘quv imkoniyatlari hisobsiz ishlaydi, guruhlar va murojaatlar
   uchun hisob kerak” deyilgan. Ilovaning haqiqiy xatti-harakati (Dart agenti/ENGINE_PORT_NOTES) bilan tasdiqlang.
5. **Qurilmada qoladigan ma’lumotlar ro‘yxati** (o‘quv jarayoni, xatcho‘plar, qaydlar, mashq va imtihon
   natijalari, kunlik savol, eslatma): ilovada aynan shular borligini tasdiqlang; yo‘q narsani siyosatdan olib tashlang.
6. **Ruxsatlar.** Kamera (QR skaner), mahalliy bildirishnoma (eslatma), fotogalereyaga yozish (“Rasmni saqlash”)
   deyilgan. Mikrofon ishlatilmaydi (Android manifest va iOS Info.plist’dan olib tashlangan).
7. **Xizmat ko‘rsatuvchilar.** Cloudflare, Resend yoki Brevo (qaysi biri ishlatilsa), Google/Apple (ixtiyoriy).
   Haqiqiy provayderlar ro‘yxatini tasdiqlang; DPA/ishlov berish shartnomalari kerakmi — tekshiring.
8. **Saqlash muddatlari:** OTP 10 daqiqa, sessiya 60 kun, limit hisoblagichlari ≤ 1 sutka, xavfsizlik jurnali
   hisob o‘chirilgandan keyin ham (faqat ichki id), shikoyat matni hisobga bog‘lanmagan holda qoladi, D1 zaxira
   nusxalarida “cheklangan muddat”. Aniq muddatni (masalan, D1 Time Travel 30 kun) yozish kerakmi — hal qiling.
9. **Hisobni o‘chirish va 30 kun.** Ilovada o‘chirish darhol; email orqali so‘rovga 30 kun ichida javob.
   Muddat sizning amaldagi jarayoningizga mosmi?
10. **Shartlar.** Tibbiy cheklov matni (2-bo‘lim), javobgarlikni cheklash (9-bo‘lim), amaldagi qonun —
    O‘zbekiston Respublikasi (12-bo‘lim), “rasmiy davlat mahsuloti emas” ma’nosi (bosh sahifada aniq
    yozilmagan; kerak bo‘lsa qo‘shing). Manbalar har bir ma’lumot ostida ko‘rsatilishi ilovada bajarilishi shart.
11. **Foydalanuvchi kontenti.** Faqat taxallus va murojaat matni; so‘z filtri va admin ko‘rib chiqishi (24 soat
    maqsadi) Apple 1.2 uchun yetarlimi — App Review izohida tushuntiring.
12. **Do‘kon deklaratsiyalari** (App Privacy, Data safety) siyosat bilan bir xil bo‘lsin: Email Address, User ID,
    Other User Content (murojaatlar), Product Interaction (guruh natijalari) — hammasi “linked”, tracking emas.
    `ios/Runner/PrivacyInfo.xcprivacy` shu jadvalga mos.
13. **Elektron pochta manzili** `nurseguide@nfcstore.uz` ishlaydigan va kuzatiladigan bo‘lishi kerak (Apple/Play
    qo‘llab-quvvatlash emaili, o‘chirish so‘rovlari).
