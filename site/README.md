# NurseGuide sayti (statik)

App Store, Google Play va Google OAuth uchun ochiq sahifalar. Oddiy HTML + CSS: JavaScript yo‘q
(yagona istisno — `j/`, quyida), tashqi so‘rov yo‘q (shrift — tizimniki), telefonda moslashadi,
yorug‘/qorong‘i mavzu qurilma sozlamasiga ko‘ra (`prefers-color-scheme`). Hamma matnlar
uch tilda (uz / ru / en) — sahifa ichida `#uz`, `#ru`, `#en` bo‘limlari.

| Fayl | Nima |
|---|---|
| `index.html` | Bosh sahifa: NurseGuide nima, “o‘quv va ma’lumotnoma ilovasi” ogohlantirishi, havolalar, aloqa |
| `privacy/index.html` | Maxfiylik siyosati (kuchga kirgan sana 2026-10-18) |
| `terms/index.html` | Foydalanish shartlari (tibbiy cheklov, manbalar) |
| `delete-account/index.html` | Hisobni o‘chirish: ilovada (Profil → Maxfiylik va ma’lumotlar → Hisobni o‘chirish) va email orqali (30 kun) — Apple 5.1.1(v) |
| `j/index.html` | Guruh taklifi QR havolasi (`j/?c=KOD&a=TEST`): kod katta harfda va “Ilovada ochish” (`nurseguide://app/j?...`). Kichik ichki skript faqat `?c=`/`?a=` ni o‘qiydi — tashqi so‘rov yo‘q, hech narsa saqlanmaydi |
| `style.css` | Umumiy uslub (to‘q firuza palitrasi) |
| `logo.png` | Ilova belgisi, 192 px |
| `robots.txt` | Qidiruv tizimlariga ruxsat |

Sahifalar qo‘lda yoziladi (generator yo‘q). Matnni o‘zgartirsangiz uchala tilni birga yangilang;
ilovada yo‘q narsani yozmang. Huquqiy sahifalarni e’lon qilishdan oldin egasi ko‘rib chiqadi:
`docs/LEGAL_REVIEW.md`.

## Joylash

Manzil — egasining domeni ostida: **`https://nurseguide.nfcstore.uz/`** (Cloudflare Pages,
*Build output directory* = `site`, yoki `site/` ichidagi fayllarni yuklash).

| Sahifa | Manzil | Qayerga beriladi |
|---|---|---|
| Bosh sahifa | `https://nurseguide.nfcstore.uz/` | Google OAuth → *Application home page*; App Store → *Support URL* |
| Maxfiylik siyosati | `https://nurseguide.nfcstore.uz/privacy/` | Google OAuth, App Store Connect *Privacy Policy URL*, Play Console *Privacy policy* |
| Foydalanish shartlari | `https://nurseguide.nfcstore.uz/terms/` | App Store *EULA / Terms* (ixtiyoriy), ilova ichidagi havola |
| Hisobni o‘chirish | `https://nurseguide.nfcstore.uz/delete-account/` | Play Console → Data safety → *Delete account URL* |
| Taklif | `https://nurseguide.nfcstore.uz/j/?c=KOD` | Ustoz QR kodi |

Manzil oxiridagi `/` muhim: do‘kon maydonlariga doim sleshli manzilni yozing.

## Ilova havolalari (universal / app links)

Android manifestida `https://nurseguide.nfcstore.uz/j` uchun `autoVerify` havolasi bor, lekin
tekshiruv fayli (`/.well-known/assetlinks.json`) saytda HALI YO‘Q: u uchun release imzo
sertifikatining SHA-256 barmoq izi kerak (Play App Signing bo‘lsa — Play Console → App integrity).
Fayl qo‘shilmaguncha havola oddiy brauzerda ochiladi va “Ilovada ochish” tugmasi
(`nurseguide://app/j`) ishlaydi. iOS’da universal link yoqilmagan (Associated Domains
imkoniyati va `apple-app-site-association` kerak bo‘lardi) — taklif faqat sahifadagi tugma va
QR skaner orqali ishlaydi.
