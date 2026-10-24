# Qarorlar (NurseGuide)

NurseGuide — LabGuide’ning singil ilovasi: bir xil muhandislik asosi (Flutter + Cloudflare Worker/D1),
lekin boshqa mahsulot (hamshiralik imtihoniga tayyorgarlik) va boshqa kontent. Bu faylda
**NurseGuide qarorlari** (N-xx) va LabGuide’dan **o‘zgarishsiz meros bo‘lgan muhandislik
qarorlari** (D-xx, ID lari kod izohlari va testlarda ishlatilgani uchun saqlangan) qisqa yozilgan.
LabGuide’ning tibbiy-laboratoriya kontent qarorlari (D-11…D-40, D-45…D-55, D-59…D-61, D-65, D-67…D-69)
bu yerga ko‘chirilmagan — ular NurseGuide’ga tegishli emas. Yangi qaror: eng pastga N-xx qo‘shing,
unga mos qorovul testini `docs/GUARDS.md` jadvaliga yozing.

## NurseGuide qarorlari

### N-01. Identifikatorlar (2026-10-18)
- Ilova nomi **NurseGuide**; bundle ID / applicationId **`uz.nurseguide.app`** (Android namespace,
  iOS `PRODUCT_BUNDLE_IDENTIFIER`, test targetlari `uz.nurseguide.app.RunnerTests`).
- Domen **`nurseguide.nfcstore.uz`** (statik sayt: `site/`); aloqa **nurseguide@nfcstore.uz**.
- Taklif havolasi: `https://nurseguide.nfcstore.uz/j/?c=KOD[&a=TEST]` va ilova sxemasi
  `nurseguide://app/j?c=KOD[&a=TEST]` (Android’da `https://…/j` app link ham e’lon qilingan).
- Cloudflare: Worker `nurseguide-api`, D1 `nurseguide-db` (id — secret `CLOUDFLARE_D1_DATABASE_ID`, repoda yo‘q).

### N-02. Serverning qisqartirilgan hajmi (2026-10-18)
Faqat: hisob/OTP/sessiyalar, ustoz–talaba (guruhlar, topshiriqlar, natijalar), “Taklif va yordam”,
ilova ichidagi shikoyatlar, admin/rollar (admin paneli, adminlar boshqaruvi, TOTP). **Olib tashlandi:**
hamjamiyat (savol-javob, tarjima, mutaxassis tasdig‘i), hamkorlar, entitlements/Pro/plan, reviewer
roli, content_reviews, Workers AI. Migratsiyalar bo‘sh bazada tartib bilan qo‘llanadi
(`cloudflare/migrations/0001…0009`). Supabase (`supabase/`) butunlay olib tashlandi.

### N-03. Profil rollari: `hamshira` | `talaba` | `ustoz` (2026-10-18)
`users.role` CHECK va server validatsiyasi shu uchta qiymat (standart `talaba`). Rol — foydalanuvchi
tanlovi (ko‘rinish uchun). **Ustozlik serverda tasdiqlanadi:** guruh ochish faqat `POST /v1/me/teacher`
bilan ro‘yxatdan o‘tgan hisobga (`teacher_accounts`); `ustoz` roli o‘zi hech narsa bermaydi.
Guruhdagi `member_role` (`teacher`/`student`) — alohida, ichki tushuncha va o‘zgarmagan.

### N-04. Reklama yo‘q, to‘lov yo‘q, kuzatuv yo‘q (2026-10-18)
Ilovada reklama, to‘lov/obuna, analitika va kuzatuv SDK’lari yo‘q; serverda billing yo‘llari yo‘q va
`/v1/me` tarif bermaydi (qorovul: `cloudflare/test/guards.test.ts`). Maxfiylik siyosati shu bilan mos.

### N-05. Tibbiy cheklov (2026-10-18)
NurseGuide — o‘quv va ma’lumotnoma ilovasi: rasmiy buyruqlar, klinik protokollar va klinik mulohazaning
o‘rnini bosmaydi; har bir ma’lumot ostida manba ko‘rsatiladi. Matn sayt (bosh sahifa, shartlar) va
ilovada bir xil ma’noda bo‘lishi shart. Sahifalarda “qoralama/draft” so‘zlari taqiqlangan
(`.github/scripts/check_site.py`).

### N-06. Huquqiy matnlar egasi ko‘rigidan o‘tadi (2026-10-18)
Maxfiylik siyosati va foydalanish shartlari to‘liq yozilgan (uz/ru/en), lekin e’londan oldin egasi
(yurist) ko‘rib chiqadi: `docs/LEGAL_REVIEW.md` (sahifalarda bunday belgi yo‘q).

### N-07. Sayt statik va qo‘lda yoziladi (2026-10-18)
`site/` — oddiy HTML/CSS, generator yo‘q; yagona skript — `j/` sahifasida. Tekshiruv:
`.github/scripts/check_site.py` (CI `tests` job’ida).

## Meros qolgan muhandislik qarorlari (LabGuide’dan)

### D-41. Server — Cloudflare Workers + D1, email kodi — Resend
Supabase o‘rniga Cloudflare Workers + D1 (bepul tarif). Email serverda ochiq saqlanmaydi (HMAC +
niqoblangan ko‘rinish); OTP va sessiya tokenlari faqat hash holida. Admin — faqat maxfiy
`ADMIN_EMAILS`/`LG_ADMIN_EMAILS` + OTP tasdig‘i yoki qo‘lda; adminlar boshqaruvi TOTP (aal2) bilan.
A’zo ismi so‘ralmaydi: taxallus yoki “Talaba NN”; talaba a’zolar ro‘yxatida faqat ustozni va o‘zini ko‘radi.
Batafsil: `docs/BACKEND_CLOUDFLARE.md`. NurseGuide’da email jo‘natuvchi domeni — `nfcstore.uz`.

### D-44. Adminlar boshqaruvi: egasi ilovadan admin qo‘shadi/oladi
- **Super admin** = maxfiy `LG_ADMIN_EMAILS` dagi email(lar). Faqat u admin qo‘shadi/oladi; qo‘shilgan admin
  boshqa adminni qo‘sha olmaydi. Super adminni API orqali olib tashlab bo‘lmaydi.
- Vakolatni **faqat server** beradi; hech kim o‘zini admin qila olmaydi; har admin amali **TOTP (aal2)**.
- D1 `admin_grants` (migratsiya `0005`): email faqat HMAC + niqob, kim qo‘shgan/olgan — HMAC(user_id);
  audit `admin_grant_added/removed`; olib tashlash mavjud sessiyalarda darhol amal qiladi.
  Limitlar: qo‘shish soatiga 10, olish 20, faol qo‘shilgan admin ≤ 20.
- Ochiq: hisobini o‘chirgan admin shu email bilan qayta ro‘yxatdan o‘tsa, grant qolgani uchun yana admin
  bo‘ladi (egasi ilovada olib tashlaydi).

### D-56. Google va Apple bilan kirish
Email-kod kirishi yoniga ixtiyoriy “Google bilan kirish” va “Apple bilan kirish” (Apple 4.8). Mehmon rejimi
va hisobni o‘chirish (5.1.1(v)) o‘zgarmaydi. Bitta email = bitta hisob. ID token faqat **serverda**
tekshiriladi (`cloudflare/src/social.ts`: imzo, `iss`, `aud`, `exp`, `email_verified`, nonce, bir martalik
belgi); provayder tokenlari saqlanmaydi; ism/rasm saqlanmaydi. Apple’da hisobni o‘chirishda token bekor
qilinadi (revoke). Tugma faqat platforma, build va server sozlangan bo‘lsa ko‘rinadi. Apple entitlement
IPA’ga faqat `LG_APPLE_SIGNIN=true` bo‘lganda qo‘shiladi. Egasi qadamlari: `docs/AUTH_SOCIAL_LOGIN.md`.
NurseGuide’da Apple `aud` standarti `uz.nurseguide.app`; Google/Apple client ID lar **yangi**.

### D-63. Egasi admin panelida hisobni email bo‘yicha o‘chirish
Emailda kelgan o‘chirish so‘rovlari uchun (maxfiylik siyosati: 30 kun ichida): `POST /v1/admin/accounts/delete
{email, confirm_user_id}` — aniq email (HMAC) + panel topgan hisob id si mos bo‘lishi shart; o‘zini va adminni
o‘chirib bo‘lmaydi; o‘chirish foydalanuvchi o‘zi o‘chirgandagi yo‘l bilan bir xil (`deleteUserData`); audit
`account_deleted_by_admin`. Sayt: `site/delete-account/`.

### D-66. Variantli mavzu testi: “Har bir talabaga boshqa savollar”
Topshiriqda savollar hovuzi va `per_student`; talaba to‘plami saqlanmaydi — `SHA-256("<topshiriq id>:<user id>:<savol id>")`
bo‘yicha deterministik tanlanadi (server `cloudflare/src/variants.ts` ↔ Dart `variant_draw.dart`, umumiy vektorlar
`cloudflare/test/variant_vectors.json`). Natijalar savol bo‘yicha faqat savol tushgan talabalar orasida hisoblanadi.

### N-08. O‘rta tibbiyot laborantlari NurseGuide’da; vrach-laborantlar LabGuide’da (2026-10-24)
NurseGuide — o‘rta tibbiyot xodimlari (hamshira, akusher, davolash ishi, rentgen laborant va boshqa
mutaxassisliklar) uchun. Vrach-laborantlar uchun LabGuide alohida ilova. Shu sababli «laborant»
so‘zi NurseGuide’da taqiqlanmaydi (yo‘nalish nomi); `no_lab_content_guard_test` qolgan
laboratoriya atamalarini (sitologiya, spermogramma, analizator va h.k.) kod/ARB’da taqiqlashda
davom etadi. Savollar `tmbm.ssv.uz` dagi rasmiy ro‘yxatlar va Drive’dagi to‘plamlardan keladi;
har bir yo‘nalish faqat kontenti (javobli savollar) bo‘lganda ko‘rinadi.
