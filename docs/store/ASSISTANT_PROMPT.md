# Prompt for the browser assistant — publish NurseGuide

Paste everything below the line into the browser assistant (Chrome with the owner's
Cloudflare, GitHub and App Store Connect accounts already signed in).
It contains no secret values. Never ask the owner to paste passwords, API keys or
verification codes into the chat; if a login or 2FA step appears, stop and tell the owner.

---

You are helping the owner publish the iOS app **NurseGuide — Hamshira** (bundle ID `uz.nurseguide.app`).
Work in three parts, in order. Do each step, check it, and write a one-line result for it.
If something does not match these instructions, stop and report instead of guessing.
Never type, read aloud or store any password, API key, token or 2FA code.

Files you will use (all public):
- Repository: `https://github.com/davlatsudekspert/nurseguide` (branch `main`)
- Website source folder in the repository: `site/`
- All App Store texts, answers and the review notes: `docs/store/APP_STORE_LISTING.md`
  (raw: `https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/APP_STORE_LISTING.md`)
- Screenshots (raw URLs, replace NAME):
  - iPhone 6.9": `https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/iphone_6_9/NAME`
  - iPad 13": `https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/ipad_13/NAME`
  - NAME = `01_home.png`, `02_procedures.png`, `03_procedure_steps.png`, `04_workplace.png`, `05_learn.png`, `06_library.png`, `07_dmed.png`

## PART A — Cloudflare: publish the website at nurseguide.nfcstore.uz

Goal: `https://nurseguide.nfcstore.uz/` serves the static folder `site/` exactly like
`https://labguide.nfcstore.uz/` serves LabGuide's site.

1. Open Cloudflare dashboard → Workers & Pages. Find how **labguide.nfcstore.uz** is served
   (a Pages project or a Worker with static assets) and note its settings (build command,
   output directory, production branch, custom domain). Do not change LabGuide.
2. Create the same kind of project for NurseGuide:
   - Name: `nurseguide-site`.
   - Source: GitHub repository `davlatsudekspert/nurseguide`, production branch `main`.
   - Framework preset: None. Build command: leave empty. **Build output directory: `site`**.
   - If the dashboard asks to install or authorise the Cloudflare GitHub app, let the owner
     do the authorisation click; you only choose the repository.
3. Wait until the first deployment is green.
4. Add the custom domain `nurseguide.nfcstore.uz` to this project. The zone `nfcstore.uz` is in
   the same Cloudflare account: accept the DNS record Cloudflare proposes (CNAME to the
   `*.pages.dev` address, proxied). Wait until the domain shows **Active** and the certificate is issued.
5. Verify in the browser (each must open without errors, valid HTTPS, status 200):
   - `https://nurseguide.nfcstore.uz/` — title "NurseGuide", links to privacy, terms and delete-account.
   - `https://nurseguide.nfcstore.uz/privacy/` — has Uzbek, Russian and English sections (UZ / RU / EN links at the top work).
   - `https://nurseguide.nfcstore.uz/terms/`
   - `https://nurseguide.nfcstore.uz/delete-account/`
   - `https://nurseguide.nfcstore.uz/j/?c=TEST1234` — shows "Join a group" with the code `TEST1234`.
   - `https://nurseguide.nfcstore.uz/robots.txt`
6. Report: project name, deployment URL, domain status, and the result of each URL.

## PART B — App Store Connect: fill in version 1.0

Open App Store Connect → My Apps → **NurseGuide — Hamshira** → iOS App → **1.0 Prepare for Submission**.
Open `APP_STORE_LISTING.md` (link above) and copy each value exactly as written there.

1. **App Information** (left menu): Name, Subtitle, Primary category (Education), Secondary category (Medical),
   Content Rights (see the table in the listing file — if it asks for something you are unsure about, stop and report),
   **Age Rating** → complete the questionnaire with the answers in the listing file; write down the rating App Store Connect calculates.
2. **Pricing and Availability**: Price = Free. Availability = all countries and regions **except Mainland China**.
3. **App Privacy**: Privacy Policy URL `https://nurseguide.nfcstore.uz/privacy/`; answer the data-collection
   questions exactly as in the "App Privacy" table (five data types, all linked to identity, none for tracking). Publish the privacy answers.
4. **Trader status (Digital Services Act)**: choose **"I am not a trader"** (Business → Compliance, or the prompt shown in the app record).
5. **Version 1.0 page**:
   - **Screenshots**: for the 6.9" iPhone slot and the 13" iPad slot upload the seven images each, in the order 01 → 07.
     Download each image from its raw URL to a local folder first, then upload with the file chooser.
     If the native file chooser cannot be automated in your browser, do NOT work around it by reading other files or
     browser storage — stop, tell the owner exactly which files to drag in, and continue with the next step.
   - Promotional Text, Description, Keywords, Support URL, Marketing URL, Version = `1.0`, Copyright — from the listing file.
   - **Build**: click "Add Build" and select the TestFlight build **`<BUILD NUMBER — the owner will tell you>`**
     for version 1.0. If it is not listed, or shows "Processing" / missing compliance, report and wait.
     Export compliance: choose "None of the algorithms mentioned above" (the app only uses standard HTTPS).
   - **App Review Information**: contact name and e-mail from the listing file; phone = the owner's number
     (ask the owner, never invent one); "Sign-in required" unchecked; paste the reviewer notes block from the listing file.
   - **Version Release**: "Manually release this version".
6. Press **Save**. Re-open each page once and check that nothing shows a red warning or an empty required field.
   Write down every warning exactly as shown.

## PART C — LAST STEP (hard stop)

**Do NOT click "Add for Review" or "Submit for Review" on your own.**
Stop after Part B and send the owner a report:
- Part A: result for every URL;
- Part B: a checklist of every field (done / not done / needs the owner), the calculated age rating, the selected build number,
  the number of screenshots uploaded per device, and any warnings;
- the list of anything you could not do and why.

Press "Add for Review" / "Submit for Review" **only after the owner writes the exact word "yubor"** in this chat.
Any other message (including "ok", "tayyor", "yes") is not permission. After "yubor": click **Add for Review**,
confirm the submission dialog, and report the final status shown by App Store Connect ("Waiting for Review").
