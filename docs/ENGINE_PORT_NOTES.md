# NurseGuide engine port notes (phase 3a)

Source: unmodified LabGuide snapshot (173,844 Dart lines). Now a clean NurseGuide engine, package `nurseguide`.

## Kept (adapted)
- auth (email OTP, Google, Apple), welcome/onboarding, role pick, profile, settings (uz/ru/en, Klassik/Ivory/dark/system, font size, reminder, sound/haptics), support, admin panel.
- classroom: groups, QR join, nickname, topic and general test assignments (minutes and open-days are separate fields), big screen, results, lecture decks 16:9 with TV cast.
- learn: quiz, exam, daily 5, toifa (tests/oral/tickets/practice/mistakes/progress); daily; share; home; library shell (books / saved / sources); design system.
- Feature dirs: admin, auth, classroom, content, daily, home, hub, learn, library, profile, settings, share, support, toifa.

## Removed
- All lab-specific features, assets, l10n, tests, tools. Also community, partners, ads, review, intake, packs, speech channel, Supabase client, reviewer/community client code, build_flags.
- Stale tool/backend_test.sh and make_icons.py; slides/ai steps from tool/run_guards.sh.

## Routes
- Tabs: /home, /procedures (Manipulyatsiyalar, empty state), /workplace (Ish joyi, raised centre, empty state), /library, /learn.
- /welcome (language, auth, otp, role), /terms, /profile (role, theme, privacy, help, contact, support/new, support/thread/:id), /admin (inbox, users, stats, complaints, audit, admins, auth, otp).
- /library/saved|books|books/item/:id|read|sources. /learn/quiz|daily|exam(run,result/:id)|toifa/* |classes (new, test, join, g/:gid/...).
- Invite: nurseguide://app/j?c=.. and https://nurseguide.nfcstore.uz/j/.. redirect to /learn/classes/join.

## Decisions
- Roles Hamshira / Talaba / Ustoz (wire hamshira|talaba|ustoz). Teacher only for signed-in, server-confirmed accounts; sign-out downgrades to student.
- Palette: teal #0F4C5C / #1B6B6B / #7FD1B9 with Ivory warm tones; logo cropped (40px per side), rounded in-app; no cross symbol.
- Backend: Cloudflare Worker (default LG_API_URL https://nurseguide-api.davlatsudekspert.workers.dev), session key nurseguide.api.session; LG_* env names kept; LG_SUPABASE_* and LG_PARTNER_ADS dropped.
- Contact nurseguide@nfcstore.uz, domain nurseguide.nfcstore.uz. Account deletion: Profile, Privacy and data, Delete account.
- Content is placeholder (empty pack, empty toifa bank, empty deck index); screens show empty states. Real-bank guards are vacuous on an empty bank and bite once content lands.
- Tests use fixtures (test/helpers/fixtures.dart) for pack, toifa, lectures and curriculum.
- iPhone bugs fixed: per-class question index, apostrophe normalisation, scroll bounce, teacher own-code panel, title 120 chars and separate minutes/days, teacher "Mavzu testi" choice.

## Guards (test/guards)
- Uzbek Latin only, forbidden words, pubspec assets exist, router screens reachable, question bank, brand, class question index, no lab content (lib, assets, ARB, test, tool, content_src; short allow-list).

## Open issues
- Procedures and Workplace hubs are placeholders until phase 4.
- Real nursing content (pack, toifa bank, decks, curriculum) not yet loaded; curriculum.json is optional.
- Native config (android/ios), icons and store assets belong to the other agent; @drawable/ic_stat_notification must exist natively.
- Local notifications and Apple/Google sign-in need native and server credentials to test on device.
