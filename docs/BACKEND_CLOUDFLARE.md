# NurseGuide server — Cloudflare Workers + D1

Server **Cloudflare Workers + D1** bepul tarifida, email kodlari **Resend** orqali
(`nfcstore.uz` domeni; zaxira — Brevo, `EMAIL_PROVIDER=brevo`). NurseGuide serveri LabGuide
serverining qisqartirilgan nusxasi: hisoblar/OTP/sessiyalar, ustoz–talaba, murojaatlar va admin
paneli qoldi; **hamjamiyat, hamkorlar, to‘lov/huquqlar, reviewer va Workers AI olib tashlangan**.

> Holat: kod, testlar va CI tayyor. **Deploy qilinmagan** — buning uchun quyidagi
> “Egasi uchun qadamlar” kerak.

## Arxitektura

```
Flutter ilova ──HTTPS/JSON──▶ Worker `nurseguide-api` (cloudflare/src) ──▶ D1 `nurseguide-db`
   (lib/core/backend/                 │                                   (SQLite)
    cloudflare_backend.dart)          └──▶ Resend API (faqat kirish kodi xati; ixtiyoriy Brevo)
```

| Joy | Nima |
|---|---|
| `cloudflare/src/app.ts` | marshrutlar, umumiy xato ishlovi (ichki tafsilot chiqmaydi), CORS, kunlik tozalash (cron) |
| `cloudflare/src/auth.ts` | email OTP, sessiyalar, profil, admin TOTP, super admin tekshiruvi, hisobni o‘chirish |
| `cloudflare/src/social.ts` | Google / Apple bilan kirish (ixtiyoriy; `docs/AUTH_SOCIAL_LOGIN.md`) |
| `cloudflare/src/groups.ts` | guruhlar, a’zolik, mavzular, savol-javob belgilari, test sessiyalari, natijalar |
| `cloudflare/src/variants.ts` | variantli test: har talabaga hovuzdan deterministik to‘plam |
| `cloudflare/src/admins.ts` | adminlar boshqaruvi (D-44) |
| `cloudflare/src/adminconsole.ts` | egasi admin paneli: ko‘rsatkichlar, foydalanuvchilar, amallar tarixi |
| `cloudflare/src/complaints.ts`, `support.ts` | ilova ichidagi shikoyatlar (Apple 1.2) va “Taklif va yordam” |
| `cloudflare/src/moderation.ts` | taxallus uchun so‘z filtri (`cloudflare/data/abuse_words.json`) |
| `cloudflare/src/crypto.ts`, `jwt.ts`, `ratelimit.ts`, `email.ts` | HMAC/AES-GCM/TOTP (WebCrypto), ID token tekshiruvi, limitlar, Resend/Brevo |
| `cloudflare/migrations/` | `0001_auth`, `0002_classroom`, `0003_support`, `0004_teacher_topics`, `0005_admin_grants`, `0006_social_login`, `0007_admin_console`, `0008_assignment_deck`, `0009_assignment_variants` |
| `cloudflare/test/` | vitest + `@cloudflare/vitest-pool-workers` (haqiqiy workerd va lokal D1) |

Ilova serverni build vaqtida biladi: `--dart-define=LG_API_URL=https://…`
(CI standarti: `https://nurseguide-api.davlatsudekspert.workers.dev`).

## Endpointlar (`/v1`)

Javoblar JSON. Xato: `{"error": "<kod>", ...}`; HTTP holati: 400 noto‘g‘ri
ma’lumot, 401 sessiya yo‘q, 403 ruxsat yo‘q, 404 topilmadi (yoki begona guruh —
borligi ham bildirilmaydi), 409 holatga zid (masalan, ikkinchi topshirish),
413/415 tana, 429 limit (`retry_after` soniya),
503 server sozlanmagan, 500 `internal` (tafsilotsiz).

### Auth va hisob

| Metod va yo‘l | Kim | Nima |
|---|---|---|
| `GET /v1/health` | hamma | `{ok:true, api:1, service:'nurseguide-api'}` — sessiya va server secreti talab qilinmaydi |
| `POST /v1/auth/otp/request` `{email, language?}` | hamma | 6 raqamli kod email orqali (til `language`, standart uz); `{retry_after:60, valid_for:600}` |
| `POST /v1/auth/otp/verify` `{email, code}` | hamma | `{token, user_id, expires_at}` (sessiya 60 kun) |
| `GET /v1/auth/providers` | hamma | `{google, apple, apple_web}` — qaysi kirish usullari sozlangan (ilova tugmani shunga qarab ko‘rsatadi; D-56) |
| `POST /v1/auth/google` `{id_token, nonce}` | hamma | Google ID token serverda tekshiriladi; `{token, user_id, expires_at, new_user, linked, provider, email, email_masked}`. Sozlama yo‘q — `503 not_configured` |
| `POST /v1/auth/apple` `{id_token, nonce}` | hamma | xuddi shunday, Apple uchun |
| `POST /v1/auth/apple/callback` | Apple (form POST) | faqat Android veb-oqimi (`APPLE_SIGNIN_SERVICE_ID` bo‘lsa): natijani ilovaga `intent://` bilan qaytaradi |
| `POST /v1/auth/logout` | sessiya | joriy tokenni bekor qiladi |
| `POST /v1/auth/logout-all` | sessiya | hamma qurilmalardan chiqish |
| `GET /v1/me` | sessiya | `{user_id, role, language, admin_account, aal, admin, super_admin, panel_admin, teacher, identities}` (`super_admin` — email `ADMIN_EMAILS` da; `panel_admin` — egasi admin paneli: email kodi bilan kirgan va emaili `ADMIN_EMAILS` da; `identities` — bog‘langan `google`/`apple`) |
| `POST /v1/me/teacher` | sessiya | ustoz sifatida ro‘yxat (`registerTeacher`) |
| `PUT /v1/me/profile` `{role?, language?}` | sessiya | rol: `hamshira` / `talaba` / `ustoz` (boshqasi — 400; standart `talaba`) |
| `DELETE /v1/me` `{apple_authorization_code?}` | sessiya | hisob va unga bog‘liq hamma narsa o‘chadi. Apple bilan bog‘langan va `APPLE_SIGNIN_*` sozlangan bo‘lsa — kod almashtirilib Apple tokeni bekor qilinadi (saqlanmaydi); kod/sozlama yo‘q bo‘lsa ham hisob o‘chadi, natija `audit_log` da |
| `GET /v1/auth/mfa` | admin hisobi | TOTP holati |
| `POST /v1/auth/mfa/enroll` | admin hisobi, faktor hali yo‘q | TOTP kalit va `otpauth://` URI |
| `POST /v1/auth/mfa/verify` `{code}` | admin hisobi | sessiya `aal2` bo‘ladi |

### Google / Apple bilan kirish (D-56) — `cloudflare/src/social.ts`

Email-kod kirishi yoniga ikkinchi usul; mehmon rejimi o‘zgarmaydi. Batafsil egasi
qadamlari: `docs/AUTH_SOCIAL_LOGIN.md`.

- **Token tekshiruvi serverda:** imzo (provayder JWKS: Google `…/oauth2/v3/certs`,
  Apple `…/auth/keys`; faqat RS256, `kid` bo‘yicha; `cache-control` muddatiga
  keshlanadi, noma‘lum `kid` bo‘lsa 5 daqiqada ko‘pi bilan bir marta qayta
  yuklanadi — kalit almashtirishni qo‘llaydi; yuklab bo‘lmasa eski kesh), `iss`,
  `aud` (Google: `GOOGLE_CLIENT_IDS` ro‘yxati; Apple: `uz.nurseguide.app`
  (+ ixtiyoriy Services ID)), `exp`/`iat`/`nbf` (±60 s), `email_verified`,
  **nonce** (ilova provayderga `sha256(xom nonce)` beradi, serverga xomini
  yuboradi; token `nonce` i shunga teng bo‘lishi shart).
- **Takroriy ishlatishga qarshi:** `auth_replay` jadvali — `sha256(provider|sub|iat|exp|nonce)`
  token muddatigacha (kunlik cron tozalaydi). Token yoki nonce saqlanmaydi.
- **Bitta email = bitta hisob:** birinchi kirishda tasdiqlangan email mavjud
  hisob emailiga (HMAC) teng bo‘lsa — o‘sha hisobga bog‘lanadi (`linked:true`),
  dublikat yaratilmaydi; aks holda yangi hisob. Keyingi kirishlar provayder `sub`
  i bo‘yicha (`auth_identities`) — Apple private relay emaili yoki email o‘zgarsa
  ham hisob o‘sha. Tasdiqlanmagan email — `403 email_not_verified`, email yo‘q
  (birinchi kirishda) — `400 email_required`.
- **Admin:** bu yo‘l bilan admin vakolati BERILMAYDI (faqat email kodi); ro‘yxatdan
  chiqqan adminning vakolati esa olinadi. Sessiya `aal1`.
- **Limit:** IP bo‘yicha 10 daqiqada 60 urinish (`social-ip`).
- **Xatolar (401 `invalid_token`):** `token_expired`, `nonce_mismatch`,
  `replayed_token`; JWKS yetib bo‘lmasa `502 provider_unavailable`.
- **Apple revoke:** hisob o‘chirilganda ilova Apple’dan yangi `authorizationCode`
  oladi → server uni `/auth/token` da almashtiradi (`client_secret` — ES256 JWT,
  `.p8` kalit bilan) → olingan refresh token darhol `/auth/revoke` ga beriladi.
  `sub` mos kelmasa bekor qilinmaydi. Hech narsa saqlanmaydi.

Secretlar (hammasi ixtiyoriy; yo‘q bo‘lsa shu usul `503 not_configured`):
`GOOGLE_CLIENT_IDS`; `APPLE_SIGNIN_TEAM_ID` + `APPLE_SIGNIN_KEY_ID` +
`APPLE_SIGNIN_PRIVATE_KEY` (uchalasi birga — Apple yoqiladi);
`APPLE_SIGNIN_CLIENT_ID` (standart `APPLE_BUNDLE_ID`/`uz.nurseguide.app`),
`APPLE_SIGNIN_SERVICE_ID` (Android uchun).


### Ustoz–talaba

Kontrakt — ilovadagi backend interfeysi (`lib/core/backend/`); Worker testlari:
`cloudflare/test/contract.test.ts` va `groups.test.ts` (har qoida uchun alohida tekshiruv).
Jadvalda chap ustun — ilova interfeysidagi metod nomi (Dart agenti bilan kelishilgan).

| Ilova metodi | Metod va yo‘l | Kim | Nima / xato → `BackendFailure` |
|---|---|---|---|
| `registerTeacher()` | `POST /v1/me/teacher` | sessiya (= email kodi tasdiqlangan hisob) | ustoz sifatida ro‘yxat; qayta chaqirish xato emas; admin bermaydi. Sessiyasiz — `unauthorized` |
| `myAccess()` | `GET /v1/me` | sessiya | `teacher` maydoni qo‘shildi |
| `myGroups()` | `GET /v1/groups` | sessiya | mening guruhlarim; kod faqat ustozga |
| `createGroup(name, displayName:)` | `POST /v1/groups` `{name, display_name?}` | ro‘yxatdan o‘tgan ustoz | nom 3–80; ≤ 10 guruh (`429 limit_groups` → `rateLimited`); ustoz emas — `403` → `forbidden` (profil roli `teacher` yetmaydi) |
| `joinGroup(code, displayName:)` | `POST /v1/groups/join` `{code, display_name?}` | sessiya | qayta qo‘shilish hech narsani o‘zgartirmaydi (taxallus ham); noto‘g‘ri kod — `notFound`; ≤ 200 a’zo (`429 group_full` → `rateLimited`); kod taxmini limiti → `rateLimited`; taxallus guruhda yagona (katta-kichik farqsiz, `409 nickname_taken`) va so‘kinish filtri (`400 abusive_language`) — `setMyAlias` da ham; `GET /v1/groups` da `my_nickname` (yangi guruhda oldindan to‘ldirish) |
| `setMyAlias(g, alias)` | `PUT /v1/groups/:g/alias` `{alias}` | a’zo | taxallus 2–24 (bo‘sh/null — tartib raqami); begona guruh `404` → `forbidden` |
| `leaveGroup(g)` | `POST /v1/groups/:g/leave` | talaba | a’zo emas (`404`) — xato emas; ustoz — `400` → `invalid` |
| `groupMembers(g)` | `GET /v1/groups/:g/members` | a’zo | `{user_id, member_role, display_name (faqat taxallus yoki null), seat_no (talaba raqami, ustozda null), label, joined_at}`; talaba — o‘zi va ustoz; begona — `404` → `[]` |
| `removeMember(g, u)` | `DELETE /v1/groups/:g/members/:u` | ustoz | ustozni emas; `404 member_not_found` — xato emas; begona — `forbidden` |
| `groupTopics(g)` | `GET /v1/groups/:g/topics` | a’zo | `{group_id, topic_id, opened_at, lecture_done_at, oral_done_at, test_assignment_id, open, closed_at}`; yopilgani ilovada ko‘rinmaydi; begona — `[]` |
| `openTopic(g, t)` | `PUT /v1/groups/:g/topics/:t` | guruh egasi-ustoz | qayta — o‘zgarmaydi; id `^[A-Za-z0-9][A-Za-z0-9_.:-]{0,79}$` (aks holda `invalid`); ≤ 300 mavzu (`429 limit_topics`); talaba `403`, begona `404` → `forbidden` |
| `markTopicStage(g, t, stage)` | `POST /v1/groups/:g/topics/:t/stage` `{stage: lecture\|oral}` | ustoz | mavzu ochiladi; vaqt bir marta yoziladi; boshqa stage — `invalid` |
| `startTopicTest(...)` | `POST /v1/groups/:g/topics/:t/test` `{title, question_ids, correct_indexes, time_limit_minutes?}` | ustoz | topshiriq yaratiladi va ochiladi (`topic_id`); mavzuga **bitta** test — ikkinchisi `409 test_exists` → `invalid` (tekshiruv va yozuv bitta tranzaksiyada) |
| `finishTopicTest(g, t)` | `POST /v1/groups/:g/topics/:t/finish` | ustoz | `status=closed`, `due_at=hozir`; yangi urinish yo‘q; testi yo‘q — `404 no_test` → `notFound`; begona — `forbidden` |
| `assignments(g)` | `GET /v1/groups/:g/assignments` | a’zo | `topic_id`, `deck_id`, `reveal`, `per_student`, `pool_topics` bilan; kalit yo‘q; boshlanmagan sessiyani faqat ustoz ko‘radi; begona — `[]` |
| `createAssignment(...)` | `POST /v1/groups/:g/assignments` `{title, question_ids, correct_indexes, day_id?, deck_id?, reveal?, due_at?, time_limit_minutes?, start?}` | ustoz | sarlavha 3–120, savollar 1–50, vaqt 1–180; `start:false` — qoralama; `deck_id` — taqdimot (mavzu id qoidasi, 1–80); `reveal`: `now` (standart) yoki `after_due` (muddat shart); **variantli test (D-66)**: `per_student` 1–50 — `question_ids` endi hovuz (takrorsiz, ≤ 100, kamida 2 × `per_student`, aks holda `400 invalid_per_student`), `correct_indexes` — butun hovuz kaliti; `pool_topics?` — hovuz bilan parallel mavzu id lari (muvozanat uchun; `400 invalid_pool_topics`). Jadvaldagi mavzu testi (`/topics/:t/test`) variantli bo‘lmaydi |
| `startAssignment(a)` | `POST /v1/assignments/:a/start` | talaba | boshlanish vaqti (bir marta) + `server_now` + `question_ids` (variantli testda shu talabaning to‘plami, oddiyda `null`); yakunlangan/muddati o‘tgan — `409` → `invalid`; talaba emas — `forbidden` |
| `submitAssignment(a, answers, questionIds?)` | `POST /v1/assignments/:a/submit` `{answers, question_ids?}` | talaba | ball serverda; bir marta; variantli testda `question_ids` shart va aynan shu talabaning to‘plami bo‘lishi kerak (istalgan tartibda; begona/takror/yetishmagan — `400 invalid_questions`), javoblar tanlov tartibida saqlanadi, `total = per_student`, javobda va natijalarda `question_ids`; oddiy testda `question_ids` e’tiborsiz; **boshlangandan limit + 2 daqiqa**; yakunlangan test — yakunlanishdan oldin boshlaganlarga + 2 daqiqa; kech/takror — `409` → `invalid` |
| `submissions(a)` | `GET /v1/assignments/:a/submissions` | a’zo | ustoz — hamma (har savol `correct`); talaba — faqat o‘zi (`reveal: after_due` bo‘lsa muddat o‘tguncha yoki test yakunlanguncha `correct: null`, ball bor; `submit` va guruh natijalarida ham shunday); begona ustoz va **admin** — `[]` |
| `groupSubmissions(g)` | `GET /v1/groups/:g/submissions` | a’zo | xuddi shunday, guruh bo‘yicha |
| `assignmentKey(a)` | `GET /v1/assignments/:a/key` | ustoz | to‘g‘ri javoblar; boshqalar — `forbidden` |
| `closeAssignment(a)` | `POST /v1/assignments/:a/close` | ustoz | topshiriq sahifasidagi “Testni yakunlash”: yangi urinish yo‘q, boshlaganlarga 2 daqiqa; `after_due` javoblari ochiladi |
| `assignmentProgress(a)` | `GET /v1/assignments/:a/progress` | ustoz | “Katta ekran”: testni boshlagan talabalar `[{user_id, started_at}]` (javoblar topshirilguncha serverda yo‘q); talaba — `403`, begona — `404` |

**Variantli test tanlovi (D-66, `src/variants.ts` ↔ `lib/core/backend/variant_draw.dart`).**
Talaba to‘plami saqlanmaydi — har safar deterministik hisoblanadi: seed = `"<topshiriq id>:<user id>"`;
har savolga `h = hex(SHA-256(seed + ":" + savolId))`; savollar `pool_topics` bo‘yicha qatlamlarga
bo‘linadi (yo‘q — bitta qatlam), qatlam ichida `h` bo‘yicha; qatlamlar `hex(SHA-256(seed + "#" + mavzu))`
bo‘yicha tartiblanadi; so‘ng navbatma-navbat (har qatlamdan 1-chi, keyin 2-chi …) `per_student` ta. Natijada har
talaba mavzular bo‘yicha deyarli teng (±1) ulush oladi. Ikki til uchun umumiy vektorlar —
`cloudflare/test/variant_vectors.json` (vitest va Dart testi ikkalasi tekshiradi).
Ustoz natijalari (savol bo‘yicha, eng qiyin savollar, katta ekran) har savolni **faqat u tushgan talabalar orasida**
hisoblaydi (`submissions.question_ids` bo‘yicha; ilovada `tallyQuestions`).

Worker’da qo‘shimcha (ilova hozircha chaqirmaydi; `Cloudflare adapteri`
ning interfeysdan tashqari metodlari sifatida saqlangan, vakolati o‘sha —
faqat guruh egasi-ustoz):

| Metod va yo‘l | Adapter metodi | Nima |
|---|---|---|
| `DELETE /v1/groups/:g` | `deleteGroup` | guruhni butunlay o‘chirish |
| `POST /v1/groups/:g/code` | `rotateJoinCode` | yangi kod (eski QR ishlamaydi) |
| `DELETE /v1/groups/:g/topics/:t` | `closeTopic` | mavzuni talabalardan yashirish (`PUT` qayta ochadi) |
| `GET/PUT /v1/groups/:g/marks`, `DELETE …/marks/:id` | `marks/putMark/deleteMark` | savol-javob belgilari (`correct/partial/incorrect/skipped`, baho 1–5); talaba faqat o‘ziniki |
| `POST /v1/assignments/:a/open` · `/close` | `openAssignment/closeAssignment` | qoralama sessiyani boshlash / yakunlash |

**Xatolar xaritasi** (`Cloudflare adapteri._call`): 400/409/413/415 →
`invalid`, 401 → `unauthorized` (sessiya o‘chadi, `sessionLost`), 403 →
`forbidden`, 404 → `notFound`, 429 → `rateLimited`, 501/503 → `unavailable`,
502/504 va tarmoq/timeout → `network`, boshqasi → `unknown`. Worker a’zo
bo‘lmaganga guruh borligini bildirmaydi (`404`); kontraktda esa (Supabase RLS
kabi) ro‘yxat o‘qish — bo‘sh ro‘yxat, ustoz/talaba amali — `forbidden`.
Shuning uchun adapter shu metodlarda `404` ni `[]` yoki `forbidden` ga
aylantiradi, aniq kodlar (`no_test`, `member_not_found`) alohida.


### Adminlar boshqaruvi (D-44) — `cloudflare/src/admins.ts`

**Super admin** — maxfiy `LG_ADMIN_EMAILS` dagi email(lar) (egasi). Faqat u
boshqa emailni admin qiladi va olib tashlaydi; super admin API orqali olib
tashlanmaydi (id si yo‘q). Qo‘shilgan admin boshqa barcha admin yo‘llariga
(murojaatlar, tekshiruv…) super admin bilan teng kiradi,
faqat adminlarni boshqarish
bundan mustasno. Har admin amali — **TOTP (aal2)**.

| Endpoint | Kim | Natija |
|---|---|---|
| `GET /v1/admin/admins` | har admin (aal2); 10 daqiqada 60 | `{can_manage, max_granted, admins: [{id\|null, email_masked, kind: super\|granted, active, you, created_at}]}` — email faqat niqoblangan |
| `POST /v1/admin/admins` `{email}` | faqat super admin (aal2); soatiga 10 (noto‘g‘ri so‘rov ham sanaladi) | `201` yozuv; `400 invalid_email`, `409 already_admin` / `already_super_admin` / `too_many_admins` (faol ≤ 20), `403 not_super_admin` |
| `DELETE /v1/admin/admins/:id` | faqat super admin (aal2); soatiga 20 | `204`; `404` (yo‘q, allaqachon olingan yoki super admin) |

Qoidalar:
- `admin_grants`: `email_hmac` (= `users.email_hash` bilan bir xil HMAC), `email_masked`,
  `granted_by_hash` / `revoked_by_hash` (HMAC(user_id)), `created_at`, `revoked_at`.
  Ochiq email hech qayerda yo‘q (vitest tekshiradi).
- Kuchga kirish: hisob bor bo‘lsa — darhol `admins` ga `granted_reason='admin_grant'`;
  bo‘lmasa — o‘sha email kod bilan tasdiqlanganda (`syncAdmin`). Baribir aal2 kerak.
- Olib tashlash: grant `revoked_at`, `admins` dan (faqat `admin_grant`) o‘chadi va
  o‘sha hisob sessiyalari `aal1` ga tushadi — mavjud sessiyalar darhol vakolatsiz
  (har so‘rov `admins` ni o‘qiydi). `manual` va super admin tegilmaydi.
- Audit: `admin_grant_added`, `admin_grant_removed`, `admin_granted`/`admin_revoked`
  (faqat grant id / user id, email yo‘q).
- Hisob o‘chirilsa `admins` yozuvi o‘chadi, grant (email bo‘yicha) qoladi — qayta
  ro‘yxatdan o‘tsa yana admin; kerak bo‘lmasa egasi ilovada olib tashlaydi.
- Testlar: `cloudflare/test/admins.test.ts` (oddiy admin qo‘sha olmaydi, o‘zini
  admin qila olmaydi, aal1 rad, olib tashlangan admin darhol vakolatsiz, validatsiya,
  limitlar, ochiq email saqlanmaydi).

### Egasi admin paneli — `adminconsole.ts`, `complaints.ts`, `support.ts`

Ilovada: Profil → Admin panel. Egasi uchun qo‘llanma: `docs/ADMIN_PANEL_GUIDE.md`.

**Kim admin (egasi qarori, 2026-10-17):** maxfiy `ADMIN_EMAILS` (vergul bilan;
bo‘sh bo‘lsa eski nom `LG_ADMIN_EMAILS`; ikkalasi ham bo‘sh bo‘lsa — kodda
yozilgan egasi emaili `DEFAULT_ADMIN_EMAILS`). Admin oddiy **email kodi** bilan
kiradi; panel yo‘llari **TOTP so‘ramaydi** (`requirePanelAdmin`). Server **har
so‘rovda**: sessiya email kodi bilan ochilganmi (`sessions.via = 'otp'`; Google/Apple
sessiyasi — 403), hisob emailining HMAC i ro‘yxatdagi emaillardan biriga tengmi,
hisob to‘xtatilmaganmi — tekshiradi. Secret o‘zgarsa vakolat **darhol** yo‘qoladi
(mavjud sessiyada ham). Ilovadagi hech qanday belgi ishonilmaydi.

> Xavfsizlik bo‘yicha ochiq aytiladi: TOTP (aal2) talab qilinmasligi avvalgi
> dizayndan **zaifroq** (email qutisi buzilsa — panel ham ochiladi). Bu egasining
> ongli qarori. Qo‘shimcha himoya: faqat email kodi (OTP) sessiyasi, har so‘rovda
> qayta tekshiruv, audit, to‘xtatilgan hisob rad, admin to‘xtatilmaydi va o‘z rolini
> o‘zgartira olmaydi, limitlar. Adminlar jamoasi (D-44, `/v1/admin/admins`) avvalgidek **TOTP bilan**.

| Metod va yo‘l | Kim | Nima |
|---|---|---|
| `GET /v1/admin/stats` | panel admin | faqat sonlar: `registered`, `new_today/7d/30d`, `online_now` (so‘nggi 5 daqiqa), `active_today/7d/30d`, `suspended_accounts`, `by_role`, `by_language`, `new_by_day` (14 Toshkent kuni), `groups{groups, teachers, students, assignments, results}`, `complaints{open, resolved}`, `support{…, awaiting_reply}`. Yuklab olish/sotuv YO‘Q |
| `GET /v1/admin/users?email=\|name=&role=&status=&language=&limit=&offset=` | panel admin | `email` — serverda HMAC, aniq moslik; `name` — guruhdagi taxallus (2–40, `LIKE`, `%` `_` `\` ekranlangan); `{items:[{user_id, email_masked, role, language, registered_on, last_seen_on, status, suspended_at, admin}], total}` |
| `GET /v1/admin/users/:id` | panel admin | yuqoridagi + `you, teacher, groups_owned, groups_joined, support_threads, complaints` |
| `POST /v1/admin/users/:id/role` `{role}` | panel admin | `hamshira/talaba/ustoz`; o‘ziniki — `403 self`; audit `role_changed` |
| `POST /v1/admin/users/:id/suspend` | panel admin | hisobni to‘xtatish: hamma sessiyalari o‘chadi; email kodi, Google, Apple bilan kirish — `403 account_suspended`; admin (`ADMIN_EMAILS` yoki `admins`) — `403 admin`, o‘zi — `403 self`; audit `account_suspended` |
| `POST /v1/admin/users/:id/reactivate` | panel admin | qayta kira oladi; audit `account_reactivated` |
| `POST /v1/admin/accounts/delete` `{email, confirm_user_id}` | panel admin | hisobni aniq email (HMAC) bo‘yicha o‘chirish (D-63): `confirm_user_id` mos kelishi shart (`409 confirmation_mismatch`), o‘zini/adminni emas; `DELETE /v1/me` bilan bir xil yo‘l (`deleteUserData`); audit `account_deleted_by_admin` |
| `POST /v1/complaints` `{kind, body, target_ref?, lang?}` | **hamma** (mehmon ham; token bo‘lsa — hisob bilan, yaroqsiz token — 401) | `kind`: `complaint/inappropriate/bug/ad/other`; matn 5–2000; `target_ref` — `[A-Za-z0-9_.:/-]{1,200}`; **soatiga 5 ta** (hisob; mehmon — IP HMAC bo‘yicha), oshsa `429` + `Retry-After`. `201 {id, status}` |
| `GET /v1/admin/complaints?status=open\|resolved&kind=` | panel admin | `[{id, kind, body, target_ref, lang, status, admin_note, anonymous, user_id, email_masked, created_at, updated_at, resolved_at}]` |
| `GET /v1/admin/complaints/:id` · `POST …/note {note}` · `POST …/status {status}` | panel admin | izoh (≤ 2000), hal qilindi / qayta ochish; audit `complaint_note/resolved/reopened` |
| `GET /v1/admin/audit?limit=` | panel admin | `[{at, action, actor_masked, target, details}]` — nishon faqat id; hash ko‘rinishidagi eski nishonlar chiqmaydi |
| `GET/POST /v1/support/threads`, `GET/POST /v1/support/threads/:t/messages`, `POST /v1/support/threads/:t/read` | sessiya | o‘z murojaatlari (boshqasiniki — 404); kuniga 5 murojaat, soatiga 30 xabar; mavzu 3–120, xabar 1–4000; skrinshot — `400 attachments_unavailable` (R2 yo‘q) |
| `GET /v1/admin/support/threads?status=`, `POST …/:t/reply {body}`, `POST …/:t/status {status}`, `POST …/:t/read` | panel admin | javobni inson yozadi; audit `support_reply/support_status` |

Limitlar (panel admin): o‘qish 10 daqiqada 300, yozish soatiga 120. Faollik:
`requireSession` hisobning `last_seen_at` (daqiqaga yaxlitlangan) va
`last_seen_on` (kun) ni daqiqasiga ko‘pi bilan bir marta yangilaydi — IP/qurilma
saqlanmaydi. 
**Apple 1.2 (foydalanuvchi kontenti):** NurseGuide’da boshqalar ko‘radigan matn faqat guruh
taxalluslari (so‘z filtri bilan: `moderation.ts`). Shunga qaramay ilova ichida xabar berish
(Profil → Aloqa va shikoyat; mehmon ham), admin ko‘rib chiqishi (Admin panel → Ilova shikoyatlari;
maqsad — 24 soat ichida) va hisobni to‘xtatish bor. App Review izohida shu yo‘llarni ko‘rsating.

Testlar: `cloudflare/test/adminconsole.test.ts`, `complaints.test.ts`,
`support.test.ts`, `social.test.ts` (to‘xtatilgan hisob Google/Apple bilan ham kira olmaydi).


## Xavfsizlik

- **Email minimal:** bazada faqat `HMAC-SHA256(email)` (kalit — Worker
  secreti) va niqoblangan `da***@gmail.com`. Ochiq email faqat kod yuborish
  paytida xotirada bo‘ladi. Sessiya ichida email qurilmada saqlanadi.
- **OTP:** 6 raqam (`crypto.getRandomValues`, bir tekis), faqat HMAC holida,
  10 daqiqa, bitta kodga 5 urinish (atomar hisob), bir martalik. Limitlar:
  qayta yuborish 60 s; email bo‘yicha soatiga 5 kod va 15 tekshiruv; IP bo‘yicha
  soatiga 60 so‘rov va 10 daqiqada 100 tekshiruv (sinf bitta NAT ortida
  bo‘lishi mumkin). IP saqlanmaydi — limit kalitida faqat HMAC.
- **Sessiya:** 32 baytli tasodifiy opaque token; D1 da faqat SHA-256; 60 kun;
  chiqish/hamma qurilmadan chiqish; muddati o‘tgani cron bilan o‘chadi.
- **Rollar:** profil roli (`talaba` standart; `hamshira`, `ustoz`) faqat ko‘rinish
  uchun. Guruh ochish huquqi — `POST /v1/me/teacher` bilan ro‘yxatdan o‘tgan
  ustoz hisobi (`teacher_accounts`; hisob faqat email kodi tasdiqlangach
  yaratiladi). Ustoz huquqi faqat o‘zi yaratgan guruhlarda; ustoz admin emas. **Admin** — hech bir API bermaydi: faqat maxfiy
  `ADMIN_EMAILS` (eski nom `LG_ADMIN_EMAILS`) dagi email kod bilan tasdiqlanganda (ro‘yxatdan chiqsa —
  darhol: har so‘rovda qayta tekshiriladi), super admin ilovada qo‘shgan email (D-44,
  `admin_grants`; olib tashlansa — darhol) yoki egasi qo‘lda (`granted_reason='manual'`).
  Admin yo‘llari qo‘shimcha **TOTP (aal2)** talab qiladi; tasdiqlangan faktor
  bor bo‘lsa yangisini qo‘shib bo‘lmaydi; kodni qayta ishlatish rad etiladi.
  Muhim amallar `audit_log` ga (faqat qo‘shiladi). **Istisno — egasi admin
  paneli** (yuqorida): egasi qarori bilan TOTP siz, faqat email kodi sessiyasi.
- **Hisobni to‘xtatish:** `users.suspended_at` — sessiyalar o‘chadi,
  `createSession` (email kodi, Google, Apple) `403 account_suspended`,
  `requireSession` to‘xtatilgan hisobni tan olmaydi. Ilova “Hisobingiz
  to‘xtatilgan, aloqa: …” deydi. Kod faqat email egaligi isbotlangach rad
  etiladi (to‘xtatilganlik holati begonaga oshkor bo‘lmaydi).
- **Ustoz–talaba:** a’zo bo‘lmaganga guruh borligi bildirilmaydi (404);
  talaba boshqa talabaning javobi, belgisi va a’zolar ro‘yxatini ko‘rmaydi;
  kalit faqat ustozga; ball serverda; admin ham guruh mavzusi/natijasini
  ko‘rmaydi. Taxallus — 2–24 belgi, harf/raqam, `@` va havola emas; bo‘lmasa
  tartib raqami (“Talaba NN”, qayta ishlatilmaydi). Guruh kodi taxminiga qarshi: foydalanuvchiga
  15 daqiqada 10, IP ga soatiga 100 urinish.
- **SQL:** faqat parametrli (`?1`) so‘rovlar; test SQL shablonlarida
  tashqi qiymat interpolatsiyasi yo‘qligini ham tekshiradi.
- **CORS:** standart holatda umuman yo‘q (mobil ilovaga kerak emas);
  `LG_ALLOWED_ORIGINS` faqat web build uchun.
- **Xatolar:** `500 {"error":"internal"}` — SQL/stack chiqmaydi; logda faqat
  xato turi (email, kod, kalit logga yozilmaydi). `cache-control: no-store`,
  `nosniff`, tana ≤ 32 KB, faqat `application/json`.
- **Fayllar:** R2 hali ulanmagan — fayl qabul qilinmaydi (yopiq bucket
  rejada).
- **Avtomatik javoblar:** server hech qanday avtomatik/AI javob yubormaydi (Workers AI ishlatilmaydi).

Testlar: `cd cloudflare && npm test` (workerd + lokal D1; 15 fayl: auth, social, roles, groups, contract, security, support, complaints, admins, adminconsole, email, moderation, guards, variants, health).


## Lokal ishlash

```bash
cd cloudflare
npm ci
npm test              # workerd + lokal D1 (tarmoq va hisob kerak emas)
npm run typecheck
npx wrangler dev -c dev/wrangler.local.toml   # lokal sinov Worker (kodlar GET /__outbox da)
```

## Egasi uchun qadamlar (bir marta)

1. **Cloudflare hisob** — LabGuide bilan bir xil (`CLOUDFLARE_ACCOUNT_ID` o‘sha). Yangi baza yarating:
   `npx wrangler d1 create nurseguide-db` → chiqqan `database_id` (UUID) ni GitHub secret
   `CLOUDFLARE_D1_DATABASE_ID` ga yozing. **id repoda saqlanmaydi**: `wrangler.toml` da nol UUID turadi,
   `deploy_api` rejimi uni secretdan almashtiradi. Workers & Pages → **workers.dev subdomeni**
   yoqilganini tekshiring (URL `https://nurseguide-api.<subdomen>.workers.dev`).
2. **API token:** LabGuide uchun yaratilgan token yaroqli (Account → **Workers Scripts: Edit**,
   **D1: Edit**, **Account Settings: Read**). Token barcha Workerlarni tahrirlay oladi — CI faqat
   `nurseguide-api` nomini deploy qiladi; tokenni boshqa joyda ishlatmang. `CLOUDFLARE_ACCOUNT_ID`
   berilgani uchun *User → Memberships: Read* kerak emas.
3. **Resend:** *Domains* → `nfcstore.uz` ni qo‘shib, DNS’ga SPF/DKIM yozuvlarini kiriting va
   tasdiqlang (LabGuide `alideveloper.uz` domenidan yuborardi — domen boshqa). Jo‘natuvchi:
   `NurseGuide <nurseguide@nfcstore.uz>` (`LG_SENDER_EMAIL` berilmasa shu standart). API kalit
   (`RESEND_API_KEY`) LabGuide bilan bir xil bo‘lishi mumkin (Resend hisobi umumiy). Zaxira:
   `EMAIL_PROVIDER=brevo` + `BREVO_API_KEY` + tasdiqlangan `LG_SENDER_EMAIL`.
4. **Server secreti:** `openssl rand -hex 32` → `LG_SERVER_SECRET` (**yangi**, LabGuide’nikidan farqli).
   Parol menejeriga saqlang: u email HMAC kaliti — yo‘qolsa mavjud hisoblar topilmay qoladi.
5. **GitHub → Secrets and variables → Actions:** to‘liq ro‘yxat — `docs/SECRETS_TABLE.md`.
6. **Deploy:** Actions → NurseGuide CI → Run workflow → mode **deploy_api**. Job: Worker testlari →
   D1 migratsiyalari → `nurseguide-api` deploy → secretlar (stdin orqali) → `/v1/health`.
   Secret yetishmasa job xatosiz o‘tkazib yuboriladi va qaysi biri yo‘qligini yozadi.
7. **Ilovani ulash:** Variables → **`LG_API_URL`** = summary’dagi URL (yoki standart).
8. **Birinchi admin kirishi:** `ADMIN_EMAILS` dagi email bilan **email kodi orqali** kiring →
   Profil → Admin panel (TOTP so‘ralmaydi); adminlar jamoasi uchun TOTP (aal2). Kalit yo‘qolsa:
   `npx wrangler d1 execute nurseguide-db --remote --command "DELETE FROM totp_factors WHERE user_id = '<id>'"`.
   Qo‘lda admin: `INSERT INTO admins (user_id, granted_at, granted_reason) VALUES ('<id>', <ms>, 'manual')`.

## Keyin boshqa serverga ko‘chirish

D1 — oddiy SQLite, Worker kodi standart `Request/Response` va WebCrypto.
`npx wrangler d1 export nurseguide-db --remote --output nurseguide.sql` → yangi serverda import.
`createApp()` faqat `env.DB` (D1 interfeysi) ni ishlatadi. Bir xil `LG_SERVER_SECRET` shart
(aks holda email HMAC’lar mos kelmaydi). O‘zbekiston qonunchiligi (shaxsiy ma’lumotlarni
mahalliy saqlash) uchun ko‘chirish rejasini yurist bilan tekshiring (`docs/LEGAL_REVIEW.md`).
