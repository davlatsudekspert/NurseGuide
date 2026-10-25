# NurseGuide Pro — obuna rejasi

Qaror: bepul (Free) + pullik (Pro) obuna. Reklama yo'q.

## 30 kunlik bepul sinov (ilova/server boshqaradi, do'kon sinovi YO'Q)

Do'konning sinov taklifi (intro offer / free trial) ishlatilmaydi: u faqat
Apple ID/Google hisobi bo'yicha va bitta telefondan har xil hisoblar bilan
aylanib o'tiladi. Sinovni server beradi:

- Sinov tugashi = `min(hisob ochilgan vaqt, qurilma birinchi ko'rilgan vaqt) + 30 kun`
  (`GET /v1/me` → `trial.until`).
- Bitta telefondan yangi emailga qayta sinov berilmaydi; eski emailni yangi
  telefonda ishlatib ham bo'lmaydi.
- Qurilma id: iOS identifierForVendor, Android ANDROID_ID — serverda HMAC
  (ochiq saqlanmaydi, javobga chiqmaydi). Cheklov: telefon zavod sozlamasiga
  qaytarilsa yoki iOS'da shu ishlab chiqaruvchining barcha ilovalari o'chirilsa
  id o'zgaradi.
- Sinov davrida ochiladi: o'rganish (testlar, mashq, imtihon, og'zaki) va DMED.
  Guruhlar (ustoz) sinovga kirmaydi.

## Ustoz roli

Talaba profilini ustozga o'tkaza olmaydi: rol tanlashda "Ustoz" faqat Ustoz yoki
Mutaxassis rejasi bo'lsa ochiladi (billing yoqilganda). Serverda:
`LG_TEACHER_REQUIRES_PRO=1` bo'lsa `POST /v1/me/teacher` admin bergan
Ustoz/Mutaxassis Pro'sini talab qiladi. Do'kon xaridini serverda tasdiqlash
(kvitansiya tekshiruvi) tayyor bo'lgach yoqiladi — hozircha xarid faqat
qurilmada tekshiriladi, shuning uchun bu bayroq o'chiq.

## Narxlar (USD, App Store / Google Play narx pog'onalari)

| Reja | Oylik | Yillik | Kim uchun | Product ID |
|---|---|---|---|---|
| Talaba | 1.49 | 9.99 | kollej/institut talabasi | `uz.nurseguide.app.student.monthly` / `.yearly` |
| Ustoz | 2.49 | 24.99 | o'qituvchi: guruhlar, natijalar | `uz.nurseguide.app.teacher.monthly` / `.yearly` |
| Mutaxassis | 3.49 | 34.99 | ishlayotgan hamshira, toifa imtihoni | `uz.nurseguide.app.pro.monthly` / `.yearly` |

Yillik reja ≈ 44–72% arzon (oylikka nisbatan). Yuqori reja pastkisining hamma
imkoniyatini o'z ichiga oladi: Talaba < Ustoz (+guruhlar) < Mutaxassis (+DMED, atamalar). Mintaqaviy narxlar (UZS va
boshqalar) do'konda avtomatik narx pog'onasidan olinadi.

## Nima bepul, nima Pro

Bepul (hisob bilan): bosh sahifa, manipulyatsiyalar (ro'yxat va bosqichlar),
kutubxona/adabiyotlar ro'yxati, kunlik 5 ta savol.

Talaba va undan yuqori (yoki sinov davrida): toifa testlari, mashq, imtihon rejimi, og'zaki
biletlar, natijalar tarixi va xatolar, saqlanganlar.

Ustoz (qo'shimcha): guruhlar, ustoz natijalari, guruh testlari.

Mutaxassis (qo'shimcha; sinov davrida ham): DMED savol-javoblari, atamalar lug'ati.

Admin istalgan emailga qo'lda Pro berishi mumkin (admin panel).

## Qoidalar (App Store 3.1.2 / Google Payments)

- Obuna ekranida: reja nomi, narx, davr, 30 kunlik sinov sharti (qurilma/hisob
  bo'yicha bir martalik), avtomatik yangilanish, bekor qilish yo'li, Foydalanish shartlari va Maxfiylik havolalari.
- "Xaridni tiklash" (Restore) tugmasi bor.
- Bepul rejim ishlaydi: Pro bo'limlar yopiq, lekin ilova ochiladi.
- Sog'liq deklaratsiyasi o'zgarmaydi: o'quv ilovasi, davolash yo'riqnomasi emas.

## Yoqish tartibi

Billing kodi `--dart-define=NG_BILLING_ENABLED=true` bilan yoqiladi (CI
o'zgaruvchisi `NG_BILLING_ENABLED`). Standart holatda o'chiq: do'konda
mahsulotlar yaratilmaguncha hech narsa yopilmaydi.

1. App Store Connect → Subscriptions: bitta "NurseGuide Pro" guruhi, 6 obuna
   (3 daraja × 2 davr), **sinov taklifi YO'Q** (sinovni server beradi).
   Daraja tartibi guruh ichida: Mutaxassis > Ustoz > Talaba (yuqoriga o'tish — upgrade).
2. Google Play → Monetize → Subscriptions: **6 ta alohida obuna** (iOS bilan bir xil
   ID), har birida bitta base plan; sinov offeri YO'Q. (Bitta obunada 2 base plan
   qilinmaydi: kod mahsulotni ID bo'yicha topadi.)
3. Server: `LG_BILLING_LAUNCH` = yoqilish sanasi (ISO, masalan `2026-12-01T00:00:00Z`).
   Shu sanadan oldin ochilgan hisoblar ham yoqilish kunidan 30 kun sinov oladi
   (mavjud foydalanuvchilar birinchi kuniyoq to'siqqa duch kelmasin).
4. Apple/Google reviewer va demo hisob: admin panel → "Pro obunalar" dan
   reviewer emailiga **Mutaxassis**, muddatsiz Pro bering (sinov muddatiga
   bog'lanib qolmaydi). Review izohiga shu hisobni yozing.
5. Huquqiy matnlar: `python3 -I tool/apply_billing_legal.py` (ilova shartlari/maxfiylik
   va sayt `privacy`/`terms` ni obuna, sinov va qurilma id matnlari bilan almashtiradi;
   manba `docs/legal_billing/`), so'ng `flutter gen-l10n`. Bu matnlar obuna bilan
   BIRGA chiqishi kerak. Qurilma identifikatori faqat billing yoqilganda yuboriladi.
6. Do'kon maxfiylik shakllari: App Store "App Privacy" → Device ID (App
   Functionality, hisobga bog'lanmagan, kuzatuv uchun emas); Play "Data safety" →
   Device or other IDs (App functionality). Ilova matnlari va sayt (`site/privacy`,
   `site/terms`) shunga mos yangilangan.
7. CI: repo variables `NG_BILLING_ENABLED=true` va `LG_BILLING_LAUNCH` (deploy_api shuni serverga beradi), yangi TestFlight build (qadamlar: `docs/store/LAUNCH_STEPS.md`); sandbox
   (TestFlight) va license-tester orqali sinash.
8. Keyin: server tomonda kvitansiya tekshiruvi (App Store Server API / Play
   Developer API); shundan so'ng `LG_TEACHER_REQUIRES_PRO=1`.

## Ma'lum cheklovlar

- Xarid muddati qurilmada hisoblanadi (iOS: xarid sanasi + davr; Android: egalik
  qilinayotgan obuna ishga tushganda tiklanadi). Aniq muddat — server kvitansiya
  tekshiruvidan keyin.
- `X-Device-Id` sarlavhasi tasdiqlanmaydi (App Attest / Play Integrity yo'q):
  o'zgartirilgan mijoz har safar yangi id bilan sinovni aylanib o'tishi mumkin;
  bir hisobdan sutkada 5 tadan ortiq yangi qurilma yozilmaydi.
- Avvaldan ro'yxatdan o'tgan ustozlar sinov davrida guruhlarini saqlaydi;
  sinovdan keyin Ustoz/Mutaxassis rejasi kerak.
- Admin bergan Pro emailga bog'lanadi: Apple "Hide My Email" yoki boshqa
  Google email bilan kirgan foydalanuvchi shu emailga mos kelmaydi.
- `/learn/classes` da faqat ustoz sahifalari (yaratish, reja, topshiriq,
  natijalar) obunani talab qiladi; qo'shilish va talaba sahifalari bepul.
