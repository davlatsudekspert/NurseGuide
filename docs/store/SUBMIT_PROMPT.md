# Browser assistant: submit NurseGuide 1.0 to App Review

Give the text below to the browser assistant (Chrome, App Store Connect already
signed in). It contains no secrets. If a login or 2FA step appears, it stops and
tells the owner. The owner has approved the submission: it may press
"Add for Review" and "Submit for Review" at the end.

```
Task: finish and submit iOS version 1.0 of "NurseGuide — Hamshira" (bundle ID uz.nurseguide.app).
Open App Store Connect > My Apps > NurseGuide — Hamshira > iOS App > 1.0 Prepare for Submission.
Never type, read aloud or store passwords, API keys, tokens or 2FA codes. If a login or 2FA
step appears, stop and tell me. Do exactly the steps below; if something does not match, stop and report.

Files (public):
- Texts, answers and review notes: https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/APP_STORE_LISTING.md
- Screenshots (download each to a local folder first, then upload with the file chooser):
  iPhone 6.9": https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/iphone_6_9/NAME
  iPad 13":    https://raw.githubusercontent.com/davlatsudekspert/nurseguide/main/docs/store/screenshots/ipad_13/NAME
  NAME, in this order: 01_home.png, 02_procedure_steps.png, 03_toifa_test_question.png,
  04_oral_ticket.png, 05_workplace.png, 06_literature.png, 07_teacher_results.png
  (All seven in both folders. All screenshots are Uzbek interface and are new: they replace the old ones.)

1. Build: in the Build section remove the currently selected build (if any) and click "Add Build".
   Select build 1.0.0 (13) ["Version 1.0, build 13"]. If it is missing or says "Processing", wait a few minutes
   and refresh; if it still does not appear, stop and report. Export compliance: "None of the algorithms
   mentioned above" (the app only uses standard HTTPS).
2. Screenshots: for EVERY localization of this version (open the language selector at the top) and for both
   device slots (6.9" iPhone and 13" iPad): first DELETE all existing screenshots, then upload the seven new
   files in the order above. If the file chooser cannot be automated, do NOT read other files or browser
   storage; tell me exactly which files to drag in and continue with the next step.
3. Texts: open the listing file and compare each field of the version page with it; where it differs, replace
   it with the text from the file: Promotional Text, Description, Keywords, Support URL, Marketing URL,
   Copyright, "What's New in This Version" (only if the field is shown and empty or different), Version = 1.0.
   Do the same for every localization that exists. Name and Subtitle: App Information page, same rule.
4. App Review Information: contact name and e-mail from the listing file; phone — ask me (never invent one);
   "Sign-in required" unchecked; paste the reviewer-notes block from the listing file. Version Release:
   "Manually release this version".
5. This version has NO in-app purchases or subscriptions: do not attach any, and do not create any.
6. Press Save. Open the page again and make sure no required field is empty and no red warning remains.
   If a warning needs a decision that is not in the listing file (for example a new compliance question),
   stop and ask me with the exact wording.
7. When all fields are complete: click "Add for Review", then "Submit for Review". Answer the submission
   questions exactly as in the listing file (content rights, advertising identifier = No, export compliance
   as above). Confirm the dialog.
8. Report: the build number selected, number of screenshots per device and localization, every field you
   changed (name only), any warnings, and the final status shown by App Store Connect ("Waiting for Review").
```
