# NurseGuide Pro — obuna rejasi

Qaror: bepul (Free) + pullik (Pro) obuna. Barcha obunalarda **30 kun bepul
sinov** (App Store "introductory offer: free, 1 month"; Google Play "free trial,
30 days"). Reklama yo'q.

## Narxlar (USD, App Store / Google Play narx pog'onalari)

| Reja | Oylik | Yillik | Kim uchun | Product ID |
|---|---|---|---|---|
| Talaba | 1.49 | 12.99 | kollej/institut talabasi | `uz.nurseguide.app.student.monthly` / `.yearly` |
| Mutaxassis | 2.99 | 24.99 | ishlayotgan hamshira, toifa imtihoni | `uz.nurseguide.app.pro.monthly` / `.yearly` |
| Ustoz | 4.99 | 39.99 | o'qituvchi: guruhlar, natijalar | `uz.nurseguide.app.teacher.monthly` / `.yearly` |

Yillik reja ≈ 27–33% arzon. Yuqori reja pastkisining hamma imkoniyatini
o'z ichiga oladi (Talaba < Mutaxassis < Ustoz). Mintaqaviy narxlar (UZS va
boshqalar) do'konda avtomatik narx pog'onasidan olinadi.

## Nima bepul, nima Pro

Bepul (hisob bilan): bosh sahifa, manipulyatsiyalar (ro'yxat va bosqichlar),
kutubxona/adabiyotlar ro'yxati, kunlik 5 ta savol.

Talaba va undan yuqori: toifa testlari, mashq, imtihon rejimi, og'zaki
biletlar, natijalar tarixi va xatolar, saqlanganlar.

Mutaxassis (qo'shimcha): "Ish joyi" — DMED savol-javoblari, atamalar lug'ati,
toifa bo'yicha yo'nalishlar.

Ustoz (qo'shimcha): guruhlar, ustoz natijalari, guruh testlari.

## Qoidalar (App Store 3.1.2 / Google Payments)

- Obuna ekranida: reja nomi, narx, davr, 30 kunlik sinov sharti, avtomatik
  yangilanish, bekor qilish yo'li, Foydalanish shartlari va Maxfiylik havolalari.
- "Xaridni tiklash" (Restore) tugmasi bor.
- Bepul rejim ishlaydi: Pro bo'limlar yopiq, lekin ilova ochiladi.
- Sog'liq deklaratsiyasi o'zgarmaydi: o'quv ilovasi, davolash yo'riqnomasi emas.

## Yoqish tartibi

Billing kodi `--dart-define=NG_BILLING_ENABLED=true` bilan yoqiladi (CI
o'zgaruvchisi `NG_BILLING_ENABLED`). Standart holatda o'chiq: do'konda
mahsulotlar yaratilmaguncha hech narsa yopilmaydi.

1. App Store Connect → Subscriptions: "NurseGuide Pro" guruhi, 3 daraja × 2
   davr, har biriga 30 kunlik bepul sinov (intro offer).
2. Google Play → Monetize → Subscriptions: 3 obuna, har birida 2 base plan
   (monthly/yearly) va 30 kunlik bepul sinov offeri.
3. CI: repo variable `NG_BILLING_ENABLED=true`, yangi TestFlight build.
4. Sandbox (TestFlight) va license-tester orqali sinash.
5. Keyin: server tomonda kvitansiya tekshiruvi (App Store Server API / Play
   Developer API), hozircha mijoz tomonida tekshiruv (StoreKit/Billing).
