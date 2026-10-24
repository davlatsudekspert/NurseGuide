# Browser assistant: create subscriptions (App Store Connect + Google Play)

Give the text below to the browser assistant. It creates the products only;
it must not submit the app for review and must not change any other setting.

```
Task: create the NurseGuide Pro subscription products. Bundle / package: uz.nurseguide.app.

Plan table (USD base price; use the closest valid price point; other regions: accept the store's automatic price conversion):
- Student    monthly $1.49  id uz.nurseguide.app.student.monthly | yearly $9.99   id uz.nurseguide.app.student.yearly
- Teacher    monthly $2.49  id uz.nurseguide.app.teacher.monthly | yearly $24.99  id uz.nurseguide.app.teacher.yearly
- Specialist monthly $3.49  id uz.nurseguide.app.pro.monthly     | yearly $34.99  id uz.nurseguide.app.pro.yearly
Do NOT add any free trial / introductory offer: the 30-day trial is handled by the app and server.

A) App Store Connect > NurseGuide > Monetization > Subscriptions
1. Create one subscription group named "NurseGuide Pro".
2. Create the 6 subscriptions with exactly the product IDs above (reference name = plan + period).
   Duration: 1 month or 1 year. Order inside the group (highest first): Specialist > Teacher > Student, same-tier yearly above monthly.
3. Price each one as in the table (start price, United States; accept auto-conversion for other territories).
4. Do NOT add an introductory offer (no free trial).
5. Localizations for each subscription (display name + description), three languages:
   - English: "Student" / "Tests, practice, exam mode, oral tickets"; "Specialist" / "Everything in Student plus DMED questions and glossary"; "Teacher" / "Everything in Specialist plus groups and results".
   - Russian: «Студент» / «Тесты, практика, режим экзамена, устные билеты»; «Специалист» / «Всё из плана «Студент», плюс вопросы DMED и глоссарий»; «Преподаватель» / «Всё из плана «Специалист», плюс группы и результаты».
   - Uzbek (Latin, if the language is available; otherwise skip): Talaba, Mutaxassis, Ustoz with matching descriptions.
6. Subscription group localization (display name "NurseGuide Pro").
7. Review screenshot for each subscription: use any current app screenshot from docs/store/screenshots/iphone_6_9 (paywall screenshot is not required for the first submission).
8. Leave each subscription in "Ready to Submit". DO NOT submit the app version.
9. Under App Information confirm the Privacy Policy URL and add "Terms of Use (EULA)" if asked: https://nurseguide.nfcstore.uz/terms/ (use the real URLs from docs/store/APP_STORE_LISTING.md).

B) Google Play Console > NurseGuide > Monetize with Play > Products > Subscriptions
1. Create 3 subscriptions with product IDs: uz.nurseguide.app.student, uz.nurseguide.app.pro, uz.nurseguide.app.teacher
   (names: Student, Specialist, Teacher). Each has 2 base plans: id "monthly" (1 month, auto-renewing) and "yearly" (1 year, auto-renewing), prices from the table (USD, auto-convert other countries).
   NOTE: if Play requires the same product-id style as the iOS ids, report the exact ids it produced; the app expects uz.nurseguide.app.<plan>.<period>. If Play does not accept dots/underscores in a base-plan id, tell me and stop.
2. Do NOT add any free-trial offer.
3. Activate the base plans. Add the license testers (Settings > License testing) only if I give you emails.
4. If Play says a payments profile or merchant account is required, stop and report exactly what is missing.

Report: every created product id, price, trial status, and anything that blocked you. Do not guess; if a field is unclear, stop and ask.
```
