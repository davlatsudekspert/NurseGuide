# NurseGuide — App Store Connect texts (English, version 1.0)

Everything below is ready to paste. Character limits are checked by `tool/store/check_listing.py`.
No secret values appear in this file.

## App information

| Field | Value |
|---|---|
| Name | `NurseGuide — Hamshira` |
| Subtitle | `Nursing exam prep & guides` |
| Bundle ID | `uz.nurseguide.app` |
| Primary category | Education |
| Secondary category | Medical |
| Copyright | `2026 Abduraxmonov Yo'ldoshali` |
| Support URL | `https://nurseguide.nfcstore.uz/` |
| Marketing URL | `https://nurseguide.nfcstore.uz/` |
| Privacy Policy URL | `https://nurseguide.nfcstore.uz/privacy/` |
| Terms of Use (optional custom EULA link, put in Description footer) | `https://nurseguide.nfcstore.uz/terms/` |
| Price | Free (no in-app purchases, no subscriptions) |
| Availability | All countries and regions except Mainland China |
| Version | `1.0` |
| Release | Manually release this version |

## Promotional text (max 170)

```
Study for your nursing certification: step-by-step procedures, daily questions, practice tests and DMED guides — every answer with its source. No ads.
```

## Description (max 4000)

```
NurseGuide is a study and reference app for nurses, nursing students and nursing teachers in Uzbekistan. It is built around the nurse's real workday and the qualification-category (attestation) exam.

Study content is mostly in Uzbek. The app interface is available in Uzbek, Russian and English.

WORKPLACE
• Choose your work area — Nursing, Higher nursing, Patronage or DMED — and get 5 new questions every day, matched to it. After each answer you see the source and, where available, an explanation.
• A short vital-signs reference (temperature, pulse, respiratory rate) with its textbook source.
• DMED: 150 questions and answers on working in the DMED system (roles, patient admission, inpatient care, document forms) and on basic computer skills (Word, Excel, PowerPoint, the Internet). Each card shows where it comes from.

PROCEDURES
Step-by-step guides with a checklist: intradermal, subcutaneous, intramuscular and intravenous injections, blood pressure, body temperature, pulse, bladder catheterisation and cleansing enema. Every guide shows its steps and the textbook page it is based on.

LEARN
• Practice tests by topic and by work area, with the right answer and its source shown right after you choose.
• Exam simulator: 50 questions drawn from the official question lists, with or without a time limit, followed by a review of your mistakes.
• Oral exam tickets with answer plans and references (the exam text is in Uzbek).
• Teacher groups: a teacher assigns a test, joins students by code or QR, and sees results.

LIBRARY
• A glossary of exact textbook definitions.
• A references list that shows exactly which books, official documents and open sources each item relies on.

PRINCIPLES
• Every item shows its source. We do not invent medical facts.
• No ads. No paid features. No tracking or analytics SDKs.
• Guests can browse the home screen, the procedures list, the workplace and the library. Tests, practice, daily questions, procedure details and groups need a free account (sign in with Apple or an e-mail code). You can delete your account inside the app at any time.

IMPORTANT
NurseGuide is an educational and reference app. It does not replace official orders, clinical protocols or the clinical judgement of a physician and a nursing professional, and it does not diagnose or prescribe treatment. Always follow your facility's current instructions.

Privacy policy: https://nurseguide.nfcstore.uz/privacy/
Terms of use: https://nurseguide.nfcstore.uz/terms/
Contact: nurseguide@nfcstore.uz
```

## Keywords (max 100, comma-separated, no spaces)

```
hamshira,медсестра,nurse,toifa,manipulyatsiya,patronaj,attestatsiya,DMED,inyeksiya,nursing
```

## Screenshots

Source files (English interface, real screens; 7 per device):

- iPhone 6.9" (1290 × 2796): `docs/store/screenshots/iphone_6_9/01_home.png … 07_dmed.png`
- iPad 13" (2064 × 2752): `docs/store/screenshots/ipad_13/01_home.png … 07_dmed.png`

Raw URLs (same names for 01…07): replace `NAME` with the file name.

```
https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/iphone_6_9/NAME
https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/ipad_13/NAME
```

Names: `01_home.png`, `02_procedures.png`, `03_procedure_steps.png`, `04_workplace.png`, `05_learn.png`, `06_library.png`, `07_dmed.png`.

## App Privacy (nutrition label) — all answers

**Do you or your third-party partners collect data from this app?** Yes.
**Tracking:** No data is used for tracking. No third-party advertising, no analytics SDKs. (Answer "No" to "Do you use data for tracking?".)

Data types collected. For every row: **Linked to the user's identity = Yes**, **Used for tracking = No**.

| Category → Data type | Purpose (select only these) | Why |
|---|---|---|
| Contact Info → Email Address | App Functionality | Sign-in code and account recognition (stored only as a signature and a masked form). |
| Contact Info → Name | App Functionality | Optional nickname shown only inside a teacher's group. |
| Identifiers → User ID | App Functionality | Identifier issued by Apple when the user chooses Sign in with Apple. |
| User Content → Other User Content | App Functionality | Test answers and scores in a teacher's group; text of "Suggestions and help" requests and reports. |
| Usage Data → Product Interaction | App Functionality, Analytics | Time of last activity and app platform (iOS or Android), used for the administrator's overall statistics. |

Not collected: Health & Fitness, Financial Info, Location, Sensitive Info, Contacts, Browsing History, Search History, Purchases, Diagnostics (crash logs), Photos or Videos, Audio, Advertising Data.

## Age rating questionnaire

| Question | Answer |
|---|---|
| Parental Controls | No |
| Age Assurance | No |
| Unrestricted Web Access | No |
| User-Generated Content | No |
| Messaging and Chat | No (users can only send support requests to the administrator; no user-to-user messages) |
| Advertising | No |
| Medical or Treatment Information | Frequent/Intense (educational nursing content; do not lower this answer) |
| Health or Wellness Topics | Frequent/Intense |
| Profanity or Crude Humor | None |
| Horror/Fear Themes | None |
| Alcohol, Tobacco, or Drug Use or References | None |
| Mature/Suggestive Themes, Sexual Content or Nudity | None |
| Realistic Violence, Cartoon Violence, Guns/Weapons | None |
| Simulated Gambling, Contests, Gambling | None |

Report to the owner the age rating that App Store Connect calculates. Do not change the answers to get a lower rating.

## Other App Store Connect answers

| Item | Answer |
|---|---|
| Export compliance (encryption) | The app only uses standard HTTPS/TLS provided by the operating system. In the algorithm question choose **"None of the algorithms mentioned above"**. (The build already sets `ITSAppUsesNonExemptEncryption = NO`.) |
| EU Digital Services Act trader status | **"I am not a trader"** |
| Content rights | The app shows official public question lists and own-wording answers with named sources. Select the option the owner confirms; if unsure, stop and report instead of guessing. |
| Sign-in required for review? | Not required to open the app (guest mode). Account features need sign-in; see the review notes. |
| Advertising Identifier (IDFA) | No |
| Sign in with Apple | Offered (together with the e-mail code). |

## App Review Information

Contact: Abduraxmonov Yo'ldoshali · e-mail `nurseguide@nfcstore.uz` · phone: the owner's number (ask the owner; never invent it).

Notes for the reviewer (paste as is):

```
NurseGuide is an educational and reference app for nurses (Uzbekistan). It is not a medical device, does not diagnose, and shows the source under every item.

HOW TO SEE THE APP
1. Guest mode, no account: on the first screen tap "Explore as guest" ("Continue as guest"). Guests can open Home, Procedures (list), Workplace and Library.
2. Full access: tap "Sign in or sign up" and use any of:
   • Sign in with Apple (works with any Apple ID), or
   • E-mail: enter your own e-mail address; a one-time 6-digit code is sent to it (valid 10 minutes). No demo account or password is needed.
3. After sign-in you can open: Learn (qualification-category test, practice, oral tickets, daily questions), procedure details, glossary, DMED questions and answers (Library → DMED, or Workplace → choose DMED), and Groups.

NOTES
• Study content is in Uzbek (the interface is Uzbek, Russian or English). The qualification-category exam sections (tests, practice, oral tickets) are available in every interface language; their text is in Uzbek.
• Camera is used only to scan a teacher's group QR code; nothing is saved.
• Account deletion: Profile → Privacy and data → Delete account (immediate). Web page: https://nurseguide.nfcstore.uz/delete-account/
• No ads, no purchases, no tracking SDKs.
```
