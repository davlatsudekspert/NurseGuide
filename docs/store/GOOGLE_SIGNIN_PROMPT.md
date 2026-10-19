# Prompt for the browser assistant — fix "Sign in with Google" on iOS

Paste everything below the line into the browser assistant (Chrome, signed in to the owner's
Google Cloud Console and GitHub). It contains no secret values. Never paste or read out passwords,
client secrets, tokens or 2FA codes; if a login or 2FA step appears, stop and ask the owner.

---

Problem: in the iOS TestFlight build of NurseGuide (bundle ID `uz.nurseguide.app`, Apple Team ID `5Z9CT2W378`),
"Google bilan kirish" opens accounts.google.com with **"Error 401: invalid_client — The OAuth client was not found."**
The iOS app is built from the GitHub repository `davlatsudekspert/nurseguide` (Actions → "NurseGuide CI").
Until this is fixed the Google button is hidden on iOS (the build only shows it when the repository variable
`NG_GOOGLE_IOS_ENABLED` is `true`). Apple sign-in and e-mail code sign-in work and are not part of this task.

Do these steps in order and report the result of each. Do not create anything in the LabGuide project.

1. Google Cloud Console → pick the Google Cloud project the owner uses for NurseGuide (if there is no NurseGuide
   project, ask the owner which project to use — do not guess). APIs & Services → Credentials. List the existing
   OAuth 2.0 client IDs and write down only their **type, name and the first 8 characters of the client ID**.
2. Check there is a **Web application** client for NurseGuide (this is the "server" client; the server checks tokens
   against it). If there is none, create one named `NurseGuide server (web)`; no redirect URIs are needed.
3. Create an **iOS** OAuth client: name `NurseGuide iOS`, Bundle ID `uz.nurseguide.app`, Team ID `5Z9CT2W378`
   (App Store ID may stay empty). Copy its Client ID (looks like `123456789-abcdef.apps.googleusercontent.com`).
   Client IDs are not secret, but do not paste them anywhere except the fields below.
4. OAuth consent screen: make sure the app is in "Production" (or the owner's Google account is a test user),
   user type External, scopes only `openid`, `email`, `profile`. Application home page `https://nurseguide.nfcstore.uz/`,
   Privacy policy `https://nurseguide.nfcstore.uz/privacy/`, Terms `https://nurseguide.nfcstore.uz/terms/`.
5. GitHub → repository `davlatsudekspert/nurseguide` → Settings → Secrets and variables → Actions → **Variables** tab:
   - `LG_GOOGLE_CLIENT_ID` = the Web client ID from step 2 (create or update the variable).
   - `LG_GOOGLE_IOS_CLIENT_ID` = the iOS client ID from step 3.
   - `NG_GOOGLE_IOS_ENABLED` = `true`.
   Then **Secrets** tab: make sure the secret `GOOGLE_CLIENT_IDS` contains the Web client ID from step 2
   (comma-separated if several). If you must change it, tell the owner exactly what you changed, without printing the value back.
6. Do not run workflows yourself. Report to the owner: which clients existed, which you created, which variables/secrets you set (names only),
   and that the owner can now ask for a new TestFlight build. After the new build the owner will test Google sign-in on the phone.
