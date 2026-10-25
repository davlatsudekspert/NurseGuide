# Obunani yoqish va chiqarish — 3 qadam (tartib bilan)

Hozir build'larda obuna (Free/Pro) O'CHIQ: hamma narsa ochiq. Quyidagi 3 qadam
tugagach yoqiladi va yangi build chiqariladi.

## 1-qadam. Do'konda 6 ta obuna mahsulotini yaratish

`docs/store/SUBSCRIPTIONS_PROMPT.md` ichidagi matnni brauzer yordamchisiga
bering (App Store Connect va Google Play). U mahsulotlarni yaratadi, ilovani
yubormaydi. Tayyor bo'lgach "mahsulotlar tayyor" deng.

## 2-qadam. Serverni yangilash va yoqish sanasini belgilash

GitHub → repo `NurseGuide` → Settings → Secrets and variables → Actions →
**Variables** → New repository variable:

| Nomi | Qiymati |
|---|---|
| `NG_BILLING_ENABLED` | `true` |
| `LG_BILLING_LAUNCH` | chiqarish sanasi, masalan `2026-11-01T00:00:00Z` |

So'ng Actions → NurseGuide CI → Run workflow → rejim `deploy_api`.
(Bu serverga 30 kunlik sinov, admin Pro va muddat o'zgarishlarini yuklaydi.)

## 3-qadam. Yangi build va tekshiruvchi hisob

1. Actions → Run workflow → `testflight` (iOS) va `play_internal` (Android).
2. Admin panel (davlatsudekspert@gmail.com bilan kiring) → "Pro obunalar" →
   Apple/Google tekshiruvchi emailiga **Mutaxassis**, muddat bo'sh (muddatsiz).
3. TestFlight'da sinab ko'ring, "hammasi joyida" deng — App Store'ga yuborish
   ko'rsatmasini beraman.

Eslatma: egasi (davlatsudekspert@gmail.com) serverda avtomatik Mutaxassis,
muddatsiz — alohida Pro berish shart emas.
