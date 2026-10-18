# NurseGuide

Hamshiralik imtihoniga tayyorgarlik va ma’lumotnoma ilovasi (iOS/Android, Flutter). Interfeys tillari:
o‘zbekcha, ruscha, inglizcha. Rollar: hamshira, talaba, ustoz. Har bir o‘quv ma’lumoti va test savoli
ostida manbasi ko‘rsatiladi. Ilova **o‘quv va ma’lumotnoma vositasi**: rasmiy buyruqlar, klinik protokollar va
klinik mulohazaning o‘rnini bosmaydi. Reklama yo‘q, to‘lov yo‘q, kuzatuv SDK’lari yo‘q.

NurseGuide muhandislik asosi (Flutter, Cloudflare Worker + D1, CI) singil laboratoriya ilovasi bilan
bir xil; mahsulot va kontent alohida.

| | |
|---|---|
| Bundle ID / applicationId | `uz.nurseguide.app` |
| Sayt | https://nurseguide.nfcstore.uz/ (maxfiylik `/privacy/`, shartlar `/terms/`, hisobni o‘chirish `/delete-account/`, taklif `/j/`) |
| API | Cloudflare Worker `nurseguide-api`, D1 `nurseguide-db` |
| Aloqa | nurseguide@nfcstore.uz |

## Tuzilma

```
lib/ test/ assets/ content_src/ tool/ pubspec.yaml   — Flutter ilovasi va kontent (docs/ENGINE_PORT_NOTES.md)
android/ ios/        — native loyihalar (`uz.nurseguide.app`, ikonkalar, ruxsatlar, Sign in with Apple entitlement)
cloudflare/          — API: Worker (src/), D1 migratsiyalari (migrations/), vitest testlari (test/), wrangler.toml
site/                — statik sayt (uz/ru/en): bosh sahifa, maxfiylik, shartlar, hisobni o‘chirish, taklif sahifasi
.github/workflows/   — ci.yml (testlar, Android/iOS buildlari, TestFlight, Google Play, server deploy)
.github/scripts/     — check_site.py (sayt qorovuli)
docs/                — muhandislik hujjatlari (quyida) va do‘kon ikonkalari (docs/store/)
```

## Ishga tushirish

```bash
# Ilova
flutter pub get
flutter analyze && flutter test
flutter run
flutter build apk --debug

# Server (Node 20+)
cd cloudflare
npm ci
npm run typecheck && npm test        # workerd + lokal D1, tarmoq kerak emas
npx wrangler dev -c dev/wrangler.local.toml   # lokal sinov Worker (xat o‘rniga GET /__outbox)

# Sayt qorovuli
python3 .github/scripts/check_site.py
```

Ilova serverga build vaqtidagi `--dart-define=LG_API_URL=https://…` orqali ulanadi (CI uni beradi).
Google/Apple kirish identifikatorlari ham `--dart-define` bilan (`LG_GOOGLE_CLIENT_ID`,
`LG_GOOGLE_IOS_CLIENT_ID`, `LG_APPLE_SIGNIN`, `LG_APPLE_SERVICE_ID`).

## CI va deploy (GitHub Actions → “NurseGuide CI” → Run workflow → `mode`)

| mode | Nima qiladi |
|---|---|
| `build` (standart; `main` ga push/PR) | sayt qorovuli, `flutter analyze` + `flutter test`, Worker testlari, Android sinov APK, imzosiz iOS build |
| `testflight` | yuqoridagi + imzolangan IPA va TestFlight’ga yuklash (ichki guruhlar; review/reliz YO‘Q). `apple_setup=true` — bundle ID va profilni API orqali yaratadi |
| `play_internal` | testlar + release imzoli AAB va Google Play `internal` trekiga yuklash (`play_status`: draft \| completed) |
| `deploy_api` | FAQAT server: Worker testlari → D1 migratsiyalari (`nurseguide-db`) → `nurseguide-api` deploy → Worker secretlari → `/v1/health` |
| `play_listing` | do‘kon sahifasi rasmlari (faqat `tool/store/play_listing_images.py` bo‘lsa) |

Hech narsa o‘z-o‘zidan deploy/nashr qilinmaydi. Kerakli secret/variable’lar ro‘yxati: [docs/SECRETS_TABLE.md](docs/SECRETS_TABLE.md).

## Hujjatlar

- [docs/BACKEND_CLOUDFLARE.md](docs/BACKEND_CLOUDFLARE.md) — server arxitekturasi, endpointlar, xavfsizlik, egasi qadamlari
- [docs/SECRETS_TABLE.md](docs/SECRETS_TABLE.md) — GitHub secret/variable’lar
- [docs/AUTH_SOCIAL_LOGIN.md](docs/AUTH_SOCIAL_LOGIN.md) — Google va Apple bilan kirish
- [docs/ADMIN_PANEL_GUIDE.md](docs/ADMIN_PANEL_GUIDE.md) — admin panel egasi uchun
- [docs/IOS_TESTFLIGHT.md](docs/IOS_TESTFLIGHT.md) — Mac’siz iOS build va TestFlight
- [docs/GUARDS.md](docs/GUARDS.md) — qorovul testlari; [docs/DECISIONS.md](docs/DECISIONS.md) — qarorlar
- [docs/LEGAL_REVIEW.md](docs/LEGAL_REVIEW.md) — huquqiy matnlarni e’londan oldin ko‘rib chiqish
- `docs/ENGINE_PORT_NOTES.md` — ilova dvigateli: nima saqlandi/olib tashlandi, marshrutlar, qarorlar (Dart tomoni)
