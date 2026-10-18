# Qorovul (guard) testlari

Maqsad: qabul qilingan qarorlar (`docs/DECISIONS.md`) va topshirilgan ishlar o‘zgarib/buzilib qolmasin.
Test yiqilsa — yo qaror ataylab o‘zgargan (DECISIONS ga yangi qaror va test yangilanadi), yo regressiya
(tuzatiladi).

## Qatlamlar

| Qatlam | Joyi | Ishga tushirish |
|---|---|---|
| Server (Worker) | `cloudflare/test/*.test.ts` (qorovul: `guards.test.ts`, `security.test.ts`, `health.test.ts`) | `cd cloudflare && npm ci && npm run typecheck && npm test` |
| Sayt | `.github/scripts/check_site.py` | `python3 .github/scripts/check_site.py` |
| Ilova (Dart) | `test/` (qorovul testlari — Dart agenti hujjati: `docs/ENGINE_PORT_NOTES.md`) | `flutter analyze && flutter test` |
| CI fayli | `.github/workflows/ci.yml` | `actionlint .github/workflows/ci.yml`; `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml'))"` |

## CI

`.github/workflows/ci.yml` (har push va PR da `main`, shuningdek `build`, `testflight`, `play_internal`):
- **`tests`**: `check_site.py` (+ `tool/` dagi Python testlari — papka bo‘lsagina), `flutter analyze`, `flutter test`.
  Android va iOS buildlari `needs: tests`.
- **`worker`**: `npm run typecheck` va `npm test` (`play_listing` dan boshqa barcha rejimlarda; `deploy_api` shunga bog‘liq).

`docs/**` va `*.md` o‘zgarishlari CI ni ishga tushirmaydi (`paths-ignore`).

## Server qorovullari (qaror → test)

| Qaror / ish | Qorovul |
|---|---|
| N-04: Pro/to‘lov/obuna yo‘llari yo‘q; `/v1/me` `plan` bermaydi | `guards.test.ts :: Pro / to‘lov / obuna yo‘llari yo‘q`, `/v1/me tarifni (plan) bermaydi` |
| N-02: olib tashlangan modullar (hamjamiyat, hamkorlar, reviewer, stublar) — 404 | `security.test.ts :: olib tashlangan yo‘llar … 404`; `adminconsole.test.ts :: community` yo‘q |
| N-03: rollar `hamshira/talaba/ustoz`; eski qiymatlar rad; ustoz roli guruh ochishga yetmaydi | `roles.test.ts`, `contract.test.ts :: ro‘yxatsiz guruh ochib bo‘lmaydi`, `auth.test.ts` |
| `/v1/health` ochiq, secretsiz ishlaydi, faqat GET | `health.test.ts` |
| Hisobni o‘chirish (Apple 5.1.1(v)) va admin email bo‘yicha o‘chirishi (D-63) | `guards.test.ts :: egasi qarorlari bilan qo‘shilgan yo‘llar mavjud`; `adminconsole.test.ts :: hisobni email bo‘yicha o‘chirish` |
| ADMIN_EMAILS bo‘sh — egasi emaili (fallback) | `guards.test.ts :: ikkala secret bo‘sh — egasi emaili`, `ADMIN_EMAILS ustun, keyin LG_ADMIN_EMAILS` |
| Adminlar boshqaruvi (D-44) | `admins.test.ts` |
| Google/Apple kirish (D-56) | `social.test.ts` (soxta RSA kalitlar bilan) |
| Variantli test (D-66) | `variants.test.ts` (umumiy vektorlar `variant_vectors.json`) |
| Email OTP matni NurseGuide, jo‘natuvchi `nurseguide@nfcstore.uz` | `email.test.ts`, `security.test.ts :: Brevo` |
| Taxallus so‘z filtri | `guards.test.ts :: so‘z filtri`, `moderation.test.ts` |
| SQL faqat parametrli (qiymat satr birlashtirish yo‘q) | `security.test.ts :: manba kodida SQL …` |
| Sessiya/OTP/limitlar, CORS (`https://nurseguide.nfcstore.uz`), xato tafsiloti | `auth.test.ts`, `security.test.ts` |
| Ustoz–talaba qoidalari (begona guruh, kalit, ball serverda, vaqt) | `contract.test.ts`, `groups.test.ts` |
| Murojaatlar va shikoyatlar | `support.test.ts`, `complaints.test.ts` |

## Sayt qorovuli (`check_site.py`)

Taqiqlangan so‘zlar (qoralama/draft, eski brend), tashqi resurs yo‘q, `<script>` faqat `j/` da, ichki havolalar
va `#bo‘limlar` mavjud, huquqiy sahifalarda uz/ru/en bo‘limlari, sana 2026-10-18 va `nurseguide@nfcstore.uz`.

## Ilova (Dart) qorovullari

Dart qatlami va uning jadvali ilova kodi bilan birga yuritiladi (`test/guards/`); bu yerga faqat
server/CI/sayt qatlamlari yozilgan. Yangi Dart qorovuli qo‘shilsa, shu jadvalga qator qo‘shing.
