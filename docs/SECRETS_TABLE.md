# GitHub secretlar va variable’lar (NurseGuide CI)

Settings → Secrets and variables → Actions. Nomlar LabGuide bilan **bir xil**; GitHub secretlari
repo bo‘yicha, shuning uchun “LabGuide bilan bir xil” = **qiymatni NurseGuide repo’siga ham kiriting**
(qiymatlar bu hujjatda va repoda yo‘q). Hammasi ixtiyoriy yoki “bo‘lmasa o‘tkazib yuboriladi”
(CI xatosiz, summary’da sababi yoziladi), faqat alohida aytilganlar bundan mustasno.

Belgilar: **NEW** — NurseGuide uchun yangi qiymat; **SAME** — LabGuide’dagi qiymat qayta ishlatiladi.

| name | type secret/var | used by (job) | new or same-as-LabGuide | notes |
|---|---|---|---|---|
| `CLOUDFLARE_API_TOKEN` | secret | `deploy_api` | SAME | Workers Scripts: Edit, D1: Edit, Account Settings: Read. Token hisobdagi hamma Workerni tahrirlay oladi; CI faqat `nurseguide-api` ni deploy qiladi |
| `CLOUDFLARE_ACCOUNT_ID` | secret | `deploy_api` | SAME | Bir xil Cloudflare hisobi |
| `CLOUDFLARE_D1_DATABASE_ID` | secret | `deploy_api` | **NEW** | `npx wrangler d1 create nurseguide-db` natijasidagi `database_id` (UUID). `wrangler.toml` da nol UUID; CI uni shu secretdan qo‘yadi. Yo‘q yoki UUID emas bo‘lsa — `deploy_api` o‘tkazib yuboriladi/xato beradi |
| `LG_SERVER_SECRET` | secret | `deploy_api` (Worker secreti) | **NEW** | `openssl rand -hex 32` (≥ 32 belgi). LabGuide’nikini ishlatmang. Yo‘qolsa — hisoblar topilmay qoladi |
| `LG_API_URL` | secret yoki var | `android`, `ios` (`--dart-define=LG_API_URL`) | **NEW** | Deploydan keyingi Worker URL, masalan `https://nurseguide-api.<subdomen>.workers.dev`. Berilmasa CI standarti: `https://nurseguide-api.davlatsudekspert.workers.dev` |
| `RESEND_API_KEY` | secret | `deploy_api` | SAME | Resend hisobi umumiy; NurseGuide jo‘natuvchi domeni `nfcstore.uz` Resend’da tasdiqlangan bo‘lishi kerak. `RESEND_API_KEY` yoki `BREVO_API_KEY` dan biri shart |
| `BREVO_API_KEY` | secret | `deploy_api` | SAME | Zaxira provayder (`EMAIL_PROVIDER=brevo`) |
| `LG_SENDER_EMAIL` | secret | `deploy_api` | SAME (qiymati NEW) | Ixtiyoriy. Bo‘lmasa standart `nurseguide@nfcstore.uz`. Brevo uchun shart va tasdiqlangan bo‘lishi kerak |
| `EMAIL_PROVIDER` | var | `deploy_api` | SAME | `resend` (standart) \| `brevo` |
| `ADMIN_EMAILS` | secret | `deploy_api` | SAME (qiymat) | Admin panel egasi emaillari (vergul bilan). Eski nom `LG_ADMIN_EMAILS` ham ishlaydi; ikkalasi ham bo‘lmasa kodda yozilgan egasi emaili |
| `LG_ADMIN_EMAILS` | secret | `deploy_api` | SAME (qiymat) | Eski nom (zaxira) |
| `GOOGLE_CLIENT_IDS` | secret | `deploy_api` | **NEW** | Google **Web** client ID (NurseGuide loyihasi); vergul bilan bir nechta. Yo‘q — Google kirishi o‘chiq |
| `APPLE_SIGNIN_TEAM_ID` | secret | `deploy_api` | SAME | Apple Team ID (jamoa bir xil) |
| `APPLE_SIGNIN_KEY_ID` | secret | `deploy_api` | **NEW** | `uz.nurseguide.app` Primary App ID bilan ro‘yxatdan o‘tgan Sign in with Apple kaliti |
| `APPLE_SIGNIN_PRIVATE_KEY` | secret | `deploy_api` | **NEW** | O‘sha kalitning `.p8` matni. TEAM_ID + KEY_ID + PRIVATE_KEY uchalasi bo‘lsa Apple yoqiladi |
| `APPLE_SIGNIN_CLIENT_ID` | secret | `deploy_api` | NEW (ixtiyoriy) | Bo‘sh qoldiring: standart `uz.nurseguide.app` |
| `APPLE_SIGNIN_SERVICE_ID` | secret | `deploy_api` | NEW (ixtiyoriy) | Faqat Android’da Apple kerak bo‘lsa (Services ID) |
| `LG_GOOGLE_CLIENT_ID` | var | `android`, `ios` | **NEW** | Google **Web** client ID (`GOOGLE_CLIENT_IDS` dagi bilan bir xil) |
| `LG_GOOGLE_IOS_CLIENT_ID` | var | `ios` (Info.plist qaytish sxemasi), `android` (dart-define) | **NEW** | Google **iOS** client ID, bundle `uz.nurseguide.app`; formati `NNN-xxx.apps.googleusercontent.com` |
| `LG_APPLE_SIGNIN` | var | `android`, `ios` | NEW (qiymat) | `true` — faqat App ID’da “Sign in with Apple” yoqilgach (`docs/AUTH_SOCIAL_LOGIN.md`) |
| `LG_APPLE_SERVICE_ID` | var | `android`, `ios` | NEW (ixtiyoriy) | Android’da Apple uchun Services ID |
| `ANDROID_KEYSTORE_BASE64` | secret | `android` (release imzo, `play_internal`) | **NEW** | NurseGuide **upload keystore** (`.jks`) base64; yangi keystore yarating — LabGuide’nikini ishlatmang |
| `ANDROID_KEYSTORE_PASSWORD` | secret | `android` | **NEW** | |
| `ANDROID_KEY_ALIAS` | secret | `android` | **NEW** | |
| `ANDROID_KEY_PASSWORD` | secret | `android` | **NEW** | To‘rttasi ham bo‘lmasa APK debug kalit bilan (faqat sinov), AAB yasalmaydi |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | secret | `android` (`play_internal`), `play_listing` | SAME | Bir xil service account; Play Console’da **yangi NurseGuide ilovasiga** ruxsat (Release / Ilova sahifasi) berilishi kerak. Birinchi AAB qo‘lda yuklanadi |
| `ASC_KEY_ID` | secret | `ios` | SAME | App Store Connect API kaliti (Admin) |
| `ASC_ISSUER_ID` | secret | `ios` | SAME | |
| `ASC_KEY_P8_BASE64` | secret | `ios` | SAME | `.p8` matni yoki base64 |
| `IOS_TEAM_ID` | secret | `ios` | SAME | Ixtiyoriy; bo‘lmasa bundle ID dan olinadi |
| `IOS_CERTIFICATE_P12_BASE64` | secret | `ios` (qo‘lda imzo) | SAME | Ixtiyoriy; bo‘lmasa Apple bulut imzosi |
| `IOS_CERTIFICATE_PASSWORD` | secret | `ios` (qo‘lda imzo) | SAME | Ixtiyoriy |

## Olib tashlangan (NurseGuide’da kerak emas)

`LG_SUPABASE_URL`, `LG_SUPABASE_KEY` (Supabase ishlatilmaydi), `LG_PARTNER_ADS` (hamkor reklamasi yo‘q).
LabGuide’dagi `ai_tasks.yml` workflow’i va uning AI secretlari ham olib tashlangan.

## Boshqa bir martalik narsalar (secret emas)

- App Store Connect’da **uz.nurseguide.app** bundle ID va ilova yozuvi (`apple_setup=true` bundle ID ni yaratadi; ilova yozuvini qo‘lda) — `docs/IOS_TESTFLIGHT.md`.
- Google Play Console’da yangi ilova (`uz.nurseguide.app`) va Android App Links uchun
  `https://nurseguide.nfcstore.uz/.well-known/assetlinks.json` (release/Play App Signing SHA-256 barmoq izi kerak;
  hozircha saytda yo‘q — `site/README.md`).
- Resend’da `nfcstore.uz` domeni (SPF/DKIM) — `docs/BACKEND_CLOUDFLARE.md`, 3-qadam.
- Cloudflare Pages (yoki boshqa statik hosting) uchun `nurseguide.nfcstore.uz` subdomeni → `site/`.
