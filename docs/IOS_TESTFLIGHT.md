# iOS: Mac'siz build va TestFlight (GitHub Actions)

Workflow: `.github/workflows/ci.yml` (“NurseGuide CI”). `main` ga har push va PR’da imzosiz
tekshiruv (testlar, Android sinov APK, iOS build) o‘zi ishlaydi.

**Holat:** NurseGuide hali TestFlight’ga yuklanmagan. Birinchi yuklash: App Store Connect’da
ilova yozuvini yarating (2-bo‘lim), so‘ng **Run workflow → mode: testflight** (build raqami avtomatik oshadi).
Hamma `ASC_*` / `IOS_*` secretlar LabGuide bilan **bir xil** (bitta Apple Developer jamoasi) — repo
secretlarini NurseGuide repo’siga ham kiriting (`docs/SECRETS_TABLE.md`).

## 1. Imzosiz tekshiruv (secret kerak emas)

**Actions → NurseGuide CI → Run workflow** — branch `main`, **mode: build** (yoki shunchaki
`main` ga push). Linux’da `flutter analyze` + testlar, Android sinov APK’lari (artefakt) va
macOS’da imzosiz iOS release build.

## 2. TestFlight uchun bir martalik sozlash

### Secretlar
LabGuide uchun yaratilgan App Store Connect API kaliti (Admin) shu jamoa uchun yaroqli — uni qayta ishlatsangiz bo‘ladi;
yangi kalit kerak bo‘lsa:

1. App Store Connect → **Users and Access → Integrations → App Store Connect API → Team Keys
   → +**. Nomi masalan `NurseGuide CI`, ruxsat **Admin** (bulut sertifikati bilan imzolash
   uchun kerak). `AuthKey_XXXX.p8` faylini yuklab oling — u faqat bir marta beriladi.
2. Shu sahifadan **Issuer ID** va kalitning **Key ID** sini oling.
3. GitHub → **Settings → Secrets and variables → Actions → New repository secret**:

| Secret | Qiymat |
|---|---|
| `ASC_KEY_ID` | Key ID |
| `ASC_ISSUER_ID` | Issuer ID |
| `ASC_KEY_P8_BASE64` | `.p8` faylning matni (Notepad’da ochib, hammasini nusxalang) yoki base64 |
| `IOS_TEAM_ID` | ixtiyoriy: `5Z9CT2W378` |

`.p12` sertifikat **shart emas**: `IOS_CERTIFICATE_*` secretlari bo‘lmasa, workflow arxivni
imzosiz yig‘adi va eksportda Apple’ning bulutdagi (cloud-managed) Distribution sertifikati
bilan imzolaydi; App Store profilini Xcode o‘zi yaratadi (`-allowProvisioningUpdates`).
O‘z sertifikatingiz bilan imzolamoqchi bo‘lsangiz — `IOS_CERTIFICATE_P12_BASE64` va
`IOS_CERTIFICATE_PASSWORD` qo‘shing (qo‘lda imzo yo‘li).

Kalit public repoda xavfsizmi: secretlar shifrlangan holda saqlanadi, loglarda yashiriladi va
fork’dan kelgan PR’larga berilmaydi; TestFlight rejimini faqat yozish huquqi borlar ishga
tushiradi.

### Bundle ID va profil
**Run workflow → mode: testflight, apple_setup: ✓**. Workflow App Store Connect API orqali
`uz.nurseguide.app` bundle ID ni ro‘yxatdan o‘tkazadi (qo‘lda imzo yo‘lida “NurseGuide AppStore
CI” profilini ham yaratadi). Ilova yozuvi hali yo‘q bo‘lsa, shu yerda aniq xabar bilan to‘xtaydi — bu kutilgan.

### Ilova yozuvi (faqat qo‘lda — API buni qila olmaydi)
App Store Connect → **Apps → + → New App**: platforma iOS, nomi **NurseGuide** (band bo‘lsa,
masalan “NurseGuide UZ” — qurilmadagi nom baribir NurseGuide), asosiy til, Bundle ID
**uz.nurseguide.app**, SKU (masalan `nurseguide-ios`).

## 3. TestFlight’ga yuklash

**Run workflow → mode: testflight**. Imzolangan IPA yasaladi, tekshiriladi (bundle ID,
versiya, SDK, entitlements), `altool` (ishlamasa `xcodebuild -exportArchive`) bilan TestFlight’ga yuklanadi va processing holati
kutiladi. Build raqami App Store Connect’dagi oxirgisidan bittaga katta (avtomatik).
App Store review’ga **yuborilmaydi**, reliz **qilinmaydi**.

**Sign in with Apple (D-56) va TestFlight:** `com.apple.developer.applesignin` entitlement’i
(`ios/Runner/Runner.entitlements`) IPA’ga **faqat** repo variable `LG_APPLE_SIGNIN=true` bo‘lganda qo‘shiladi
(App ID’da imkoniyat yoqilgach; tartibi: `docs/AUTH_SOCIAL_LOGIN.md`, 1-bo‘lim). Variable yo‘q/`false` bo‘lsa
build avvalgidek, Apple tugmasi ilovada yo‘q. Qo‘lda imzoda profilda imkoniyat bo‘lmasa job ogohlantirib
entitlement’siz davom etadi; `true` bo‘lib IPA’da entitlement chiqmasa “IPA tekshiruvi” aniq xabar bilan to‘xtaydi.
Google (iOS) uchun `LG_GOOGLE_IOS_CLIENT_ID` variable’i — CI uni runner’dagi `Info.plist` ga URL sxemasi qilib yozadi.

## 4. Telefonda ochish (ichki test)

App Store Connect → **Apps → NurseGuide → TestFlight → Internal Testing → +** (guruh yarating)
→ o‘zingizni (App Store Connect foydalanuvchisi) qo‘shing → build’ni guruhga qo‘shing.
iPhone’da **TestFlight** ilovasini o‘rnating va o‘sha Apple ID bilan kiring — NurseGuide
ro‘yxatda chiqadi. Ichki test uchun Apple review kerak emas. Eksport muvofiqligi so‘ralmaydi
(`ITSAppUsesNonExemptEncryption = NO`).
