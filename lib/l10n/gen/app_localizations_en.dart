// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTagline => 'FOR NURSES';

  @override
  String get navHome => 'Home';

  @override
  String get navLibrary => 'Library';

  @override
  String get navLearn => 'Learn';

  @override
  String get actionBack => 'Back';

  @override
  String get actionProfile => 'Profile and settings';

  @override
  String get actionLanguage => 'Language';

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get linkCopied => 'Link copied';

  @override
  String get notAvailableYet => 'Not available yet';

  @override
  String get debugBuildBadge => 'DEBUG · DEMO ADAPTERS';

  @override
  String get welcomeEyebrow => 'Your nursing companion';

  @override
  String get welcomeTitle => 'Nursing.\nClear and practical.';

  @override
  String get welcomeSubtitle =>
      'Certification, procedures and learning in one place.';

  @override
  String get welcomeGetStarted => 'Get started / sign up';

  @override
  String get welcomeGuest => 'Explore as guest';

  @override
  String get welcomeSignIn => 'Sign in';

  @override
  String get welcomeGuestNote =>
      'No account is needed to read content. Sign-in is used for sync and classes.';

  @override
  String get stateLoading => 'Loading…';

  @override
  String get homeTileTests => 'Topic tests with explanations';

  @override
  String get homeTileSaved => 'Quick access to bookmarks';

  @override
  String get homeTileExam => 'Timed practice exam';

  @override
  String get homeTileClasses => 'Students and assignments';

  @override
  String get homeTileLecture => 'Slides and screen casting';

  @override
  String get authTitle => 'Welcome';

  @override
  String get authSubtitle => 'Sign in or create an account with email.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'name@example.com';

  @override
  String get authEmailInvalid => 'Enter a valid email address.';

  @override
  String get authConsent => 'I accept the terms of use and privacy policy.';

  @override
  String get authConsentRequired => 'Accept the terms to continue.';

  @override
  String get authGetCode => 'Get code';

  @override
  String get authViewTerms => 'View terms';

  @override
  String get authDemoNotice =>
      'Debug build: demo sign-in. No email is sent; the code is shown on the next screen.';

  @override
  String get authUnavailableTitle => 'Email sign-in isn\'t connected yet';

  @override
  String get authUnavailableBody =>
      'All reading content is available to guests. Sign-in will be enabled once the email service is configured.';

  @override
  String get authContinueGuest => 'Continue as guest';

  @override
  String authRateLimited(int seconds) {
    return 'Too many requests. Try again in $seconds s.';
  }

  @override
  String get authGenericError =>
      'Something went wrong. Check the connection and try again.';

  @override
  String get otpTitle => 'Verify your email';

  @override
  String get otpCodeLabel => '6-digit code';

  @override
  String get otpVerify => 'Verify';

  @override
  String otpDemoCode(String code) {
    return 'Demo code: $code. No email was sent (debug build only).';
  }

  @override
  String otpInvalid(int attempts) {
    return 'Incorrect code. Attempts left: $attempts.';
  }

  @override
  String get otpExpired => 'The code has expired. Request a new one.';

  @override
  String get otpTooManyAttempts => 'Too many attempts. Request a new code.';

  @override
  String get otpNoActiveCode => 'No active code. Request a new one.';

  @override
  String get otpFormat => 'Enter the 6-digit code.';

  @override
  String get otpResend => 'Resend code';

  @override
  String otpResendIn(int seconds) {
    return 'Resend in $seconds s';
  }

  @override
  String otpValidFor(int minutes) {
    return 'The code is valid for $minutes min.';
  }

  @override
  String get otpResent => 'A new code was issued.';

  @override
  String get rolesTitle => 'Your workspace';

  @override
  String get rolesSubtitle => 'Choose your main role. You can change it later.';

  @override
  String get rolesNote =>
      'The role only adapts the home screen. It doesn\'t grant access to other people\'s classes or data.';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleStudentDesc => 'Learn, practice and prepare';

  @override
  String get roleTeacher => 'Teacher';

  @override
  String get roleTeacherDesc => 'Groups and assignments';

  @override
  String get homeTitle => 'Knowledge. Confidence. Practice.';

  @override
  String get homeHeroStudentTitle => 'Learn lessons with understanding';

  @override
  String get homeHeroStudentBody => 'Topic → test → review.';

  @override
  String get homeHeroStudentCta => 'Start daily questions';

  @override
  String get homeHeroTeacherTitle => 'Turn knowledge into teaching';

  @override
  String get homeHeroTeacherBody =>
      'Groups, explained questions and timed assignments.';

  @override
  String get homeHeroTeacherCta => 'Open classes';

  @override
  String get featureTests => 'Tests';

  @override
  String get featureSaved => 'Saved';

  @override
  String get featureExam => 'Exam';

  @override
  String get featureClasses => 'Classes';

  @override
  String get testsFilterAll => 'All';

  @override
  String get testsEmptyTitle => 'No results';

  @override
  String get testsClearSearch => 'Clear search';

  @override
  String get contentLoading => 'Loading content…';

  @override
  String get contentErrorTitle => 'Content couldn\'t be loaded';

  @override
  String get contentErrorBody =>
      'The content pack failed verification. Unverified data is never shown.';

  @override
  String get sourceNoInterpretation =>
      'NurseGuide doesn\'t interpret individual results or suggest diagnoses or doses.';

  @override
  String sourceAccessed(String date) {
    return 'Accessed $date';
  }

  @override
  String get sourceReuseRightsVerify =>
      'Reuse rights: verify before distribution';

  @override
  String get sourceReuseCitationOnly =>
      'Book: cited as a source only, no text copied';

  @override
  String get libTitle => 'Library';

  @override
  String get libSubtitle => 'Your knowledge in one place.';

  @override
  String get libBooks => 'Books and guides';

  @override
  String get libBooksSub => 'Catalog of books, manuals and websites';

  @override
  String get libSavedSub => 'Saved materials';

  @override
  String get libSources => 'Sources and licences';

  @override
  String get libSourcesSub => 'Review and reuse conditions';

  @override
  String get booksEmptyTitle => 'No books yet';

  @override
  String get booksEmptyBody =>
      'Books are added only with confirmed distribution rights. A PDF you add yourself stays for personal study and isn\'t shared.';

  @override
  String get booksCatalogNote =>
      'Catalog items link to their official pages. Full text is added to the app only under an open licence or with confirmed distribution rights.';

  @override
  String get booksResetFilters => 'Clear filters';

  @override
  String get savedEmptyTitle => 'No bookmarks yet';

  @override
  String get savedEmptyBody =>
      'Select Save on a material page to keep it here.';

  @override
  String get sourcesTitle => 'Sources and licences';

  @override
  String get sourcesContent => 'Content sources';

  @override
  String get sourcesBody =>
      'Every published claim links to its original source, access date, scope and review status.';

  @override
  String get learnTitle => 'Learn with insight';

  @override
  String get learnHeroTag => 'Topics and practice';

  @override
  String get learnHeroTitle => 'From knowledge to practice';

  @override
  String get learnHeroBody =>
      'Pick a topic and check your knowledge with questions.';

  @override
  String get learnHeroCta => 'Choose a topic';

  @override
  String get learnClassesSub => 'Teacher → assignment → student → results';

  @override
  String get learnQuiz => 'Explained quiz';

  @override
  String learnQuizSub(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count practice questions',
      one: '$count practice question',
    );
    return '$_temp0';
  }

  @override
  String get learnExam => 'Exam mode';

  @override
  String get learnExamSub => 'Time, topic and questions';

  @override
  String get toifaTitle => 'Qualification category exam prep';

  @override
  String get toifaSubtitle => 'Nursing qualification category';

  @override
  String get toifaEyebrow => 'Nurse · category';

  @override
  String get toifaEntryBody =>
      'Questions from the official certification list: a 50-question test, topic practice, oral ticket and mistake review.';

  @override
  String get toifaEntryBodyShort =>
      'Test, oral ticket and mistake review — based on the official list.';

  @override
  String get toifaEntryTagTest => 'Test · 50 questions';

  @override
  String get toifaEntryTagOral => 'Oral · 5 questions';

  @override
  String toifaEntryTestActive(int done, int total) {
    return 'Test in progress: $done / $total answered';
  }

  @override
  String toifaEntryTicketActive(int done, int total) {
    return 'Oral ticket in progress: $done / $total';
  }

  @override
  String get toifaOpen => 'Start preparing';

  @override
  String get toifaContinue => 'Continue';

  @override
  String get toifaUzbekOnly => 'Official text — Uzbek';

  @override
  String get toifaUzbekNotice =>
      'The official text of the certification questions is Uzbek. With a Russian or English interface an auxiliary translation is shown; the original can be opened at any time. Scoring follows the official Uzbek text and key.';

  @override
  String get toifaShowOriginal => 'Show original text';

  @override
  String get toifaHideOriginal => 'Hide original text';

  @override
  String get toifaOriginalTitle => 'Official text (Uzbek)';

  @override
  String get toifaTranslationAux =>
      'The translation is auxiliary; scoring follows the official Uzbek text.';

  @override
  String get toifaLoadError => 'Could not open the question list';

  @override
  String get toifaYourCategory => 'Your category';

  @override
  String get toifaCatSecond => 'Second category';

  @override
  String get toifaCatFirst => 'First category';

  @override
  String get toifaCatHighest => 'Highest category';

  @override
  String get toifaTransitionNote =>
      'The category test prepares you for the qualification-category system that applies until 2030. State registration of medical staff starts on 1 July 2027; categories granted before 2030 stay valid until they expire (Presidential Decree PF-192, 10.09.2026).';

  @override
  String get toifaCategoryHint =>
      'The oral ticket is drawn from this category’s list. Test questions are shared by all categories.';

  @override
  String get toifaReadyTest => 'Test';

  @override
  String get toifaReadyOral => 'Oral';

  @override
  String get toifaPrepare => 'Preparation';

  @override
  String get toifaTestTitle => 'Category test';

  @override
  String toifaTestRowSub(int count, int bank) {
    return '$count random questions · $bank in total';
  }

  @override
  String get toifaPracticeTitle => 'Topic practice';

  @override
  String toifaPracticeRowSub(int count) {
    return '$count topics · key and note right after answering';
  }

  @override
  String get toifaOralTitle => 'Oral ticket';

  @override
  String toifaOralRowSub(String category, int count) {
    return '$category: 5 of $count questions';
  }

  @override
  String get toifaOralRowPick => 'Choose your category first';

  @override
  String toifaOralRowActive(int done, int total) {
    return 'In progress: $done / $total rated';
  }

  @override
  String get toifaMistakesTitle => 'Mistake review';

  @override
  String toifaMistakesRowSub(int tests, int oral) {
    return 'Test mistakes: $tests · oral “didn’t know”: $oral';
  }

  @override
  String get toifaMistakesRowEmpty => 'No mistakes yet';

  @override
  String get toifaProgressTitle => 'Progress';

  @override
  String get toifaProgressRowSub => 'Results by topic and readiness';

  @override
  String get toifaAboutTitle => 'Source and review';

  @override
  String get toifaListSource => 'Source: official certification question list';

  @override
  String toifaAboutList(int tests, int oral) {
    return 'The list has $tests test and $oral oral questions (duplicates across categories merged).';
  }

  @override
  String toifaAboutKeys(int disputed, int ambiguous) {
    return 'The key is the answer marked in the list, and scoring follows it. NurseGuide found the key disputed in $disputed questions and ambiguous in $ambiguous — those show a note and source.';
  }

  @override
  String toifaAboutKeyless(int count) {
    return '$count questions have no key marked in the list — they are left out of tests and practice.';
  }

  @override
  String toifaAboutOral(int ready, int total) {
    return 'Oral answer plans are a study aid prepared by NurseGuide ($ready / $total plans with sources).';
  }

  @override
  String toifaTestSubtitle(int count) {
    return '$count questions · drawn from the official list';
  }

  @override
  String get toifaFormatTitle => 'Format';

  @override
  String toifaFormatStep1(int count, int bank) {
    return '$count random questions out of $bank in the list.';
  }

  @override
  String get toifaFormatStep2 =>
      'One answer per question; options in list order.';

  @override
  String get toifaFormatStep3 =>
      'At the end: mistake review with the official key and NurseGuide note.';

  @override
  String get toifaTimeLabel => 'Time, minutes';

  @override
  String get toifaNoTime => 'No time limit';

  @override
  String get toifaTimeHelper =>
      'No official time limit is set in the app — choose your own or leave empty.';

  @override
  String get toifaTimeError => 'Enter 1 to 240 minutes or leave empty';

  @override
  String get toifaPassLabel => 'Pass mark, %';

  @override
  String get toifaNoPass => 'Not set';

  @override
  String get toifaPassHelper =>
      'This is your own threshold, not the official pass mark.';

  @override
  String get toifaPassError => 'Enter 1 to 100 % or leave empty';

  @override
  String get toifaScoringNotice =>
      'Scoring follows the official key — that is what the exam expects. Where the key is disputed, the results also show a NurseGuide note.';

  @override
  String get toifaTestStart => 'Start test';

  @override
  String get toifaTodayEyebrow => 'Today';

  @override
  String toifaTodayGoal(int count) {
    return 'Goal: $count questions or 1 ticket';
  }

  @override
  String get toifaTodayDone => 'Today’s goal is done';

  @override
  String toifaTodayProgress(int answered, int goal) {
    return '$answered/$goal questions';
  }

  @override
  String toifaTodayCorrect(int percent) {
    return '$percent% correct';
  }

  @override
  String toifaTodayTickets(int count) {
    return 'tickets: $count';
  }

  @override
  String toifaStreakDays(int count) {
    return '$count-day streak';
  }

  @override
  String get toifaTodayNone => 'No practice yet today.';

  @override
  String get toifaTodayTomorrow => 'Come back tomorrow to keep your streak.';

  @override
  String toifaWeekLabel(String values) {
    return 'Last 7 days: $values';
  }

  @override
  String get toifaGoalLabel => 'Daily goal';

  @override
  String toifaGoalOption(int count) {
    return '$count questions';
  }

  @override
  String get toifaGoalHint => 'Or 1 oral ticket — whichever comes first.';

  @override
  String get toifaReminderTitle => 'NurseGuide · Qualification';

  @override
  String toifaReminderBody(int count) {
    return 'Today’s qualification practice is waiting — $count questions or 1 ticket';
  }

  @override
  String get toifaReminderChannel => 'Qualification reminder';

  @override
  String get toifaOfferTitle => 'Continue tomorrow?';

  @override
  String get toifaOfferBody =>
      'Pick a reminder time. There’s no reminder on days you’ve met the goal.';

  @override
  String toifaOfferOn(String time) {
    return 'We’ll remind you tomorrow at $time.';
  }

  @override
  String get toifaModeTitle => 'Mode';

  @override
  String get toifaModeExam => 'Exam mode';

  @override
  String get toifaModeExamSub =>
      'Timed; score and mistakes at the end — like the real exam.';

  @override
  String get toifaModePractice => 'Practice mode — mistakes shown right away';

  @override
  String get toifaModePracticeSub =>
      'After each answer: the correct option and note; no timer.';

  @override
  String get toifaDrillStep2 =>
      'Right after answering you see if it’s correct: the official key and (if any) a note and source.';

  @override
  String get toifaDrillStep3 =>
      'Resume where you left off even after closing the app; rework your mistakes at the end.';

  @override
  String get toifaDrillStart => 'Start practice';

  @override
  String toifaDrillActive(int answered, int total) {
    return 'Practice in progress: $answered/$total';
  }

  @override
  String get toifaDrillTitle => 'Practice mode';

  @override
  String get toifaDrillRework => 'Rework mistakes';

  @override
  String toifaDrillScore(int right, int wrong) {
    return 'Correct: $right · wrong: $wrong';
  }

  @override
  String get toifaDrillFinishEarly => 'Finish now';

  @override
  String get toifaDrillFinishBody =>
      'Unanswered questions count as wrong. Your answers stay in the mistakes list.';

  @override
  String get toifaDrillDiscardTitle => 'Abandon this practice?';

  @override
  String get toifaDrillNone => 'No practice in progress';

  @override
  String get toifaDrillNew => 'New test';

  @override
  String toifaDrillUnanswered(int count) {
    return 'Unanswered: $count';
  }

  @override
  String get toifaThinkHint =>
      'Think through your answer: say it out loud or jot it on paper. Then open the plan and compare.';

  @override
  String toifaThinkTimer(int minutes) {
    return '$minutes-min think timer';
  }

  @override
  String toifaThinkLeft(String time) {
    return 'Think time: $time';
  }

  @override
  String get toifaThinkUp => 'Time’s up — open the plan and compare.';

  @override
  String get toifaThinkStop => 'Stop timer';

  @override
  String get toifaChecklistToggle => 'Key points to compare with the plan';

  @override
  String get toifaChecklistHint =>
      'Tick what your answer covered (on this device only, no typing).';

  @override
  String toifaChecklistCount(int done, int total) {
    return '$done/$total ticked';
  }

  @override
  String get toifaRepeatTitle => 'To repeat';

  @override
  String get toifaRepeatNote =>
      '“Partly” and “Didn’t know” questions come back first in your next tickets.';

  @override
  String get toifaRepeatNone =>
      'You knew them all — new questions in the next ticket.';

  @override
  String get toifaPracticeSubtitle => 'Key right after each answer';

  @override
  String toifaPracticeMixed(int count) {
    return 'Mixed: $count questions';
  }

  @override
  String get toifaPracticeMistakes => 'Redo mistakes';

  @override
  String get toifaBackToTopics => 'Topics';

  @override
  String get toifaPracticeRight => 'Your answer matches the official key.';

  @override
  String get toifaPracticeWrong =>
      'Your answer does not match the official key.';

  @override
  String toifaListNumber(int number) {
    return 'No. $number';
  }

  @override
  String get toifaOfficialKey => 'Official key';

  @override
  String get toifaNurseGuideNote => 'NurseGuide note';

  @override
  String get toifaVerdictDisputed => 'Key disputed';

  @override
  String get toifaVerdictAmbiguous => 'Ambiguous question';

  @override
  String toifaSuggested(String options) {
    return 'NurseGuide suggests: $options';
  }

  @override
  String get toifaScoredByOfficial =>
      'Scoring follows the official key — that answer is what the exam expects.';

  @override
  String get toifaNoOfficialKey =>
      'No key is marked in the list — this question is not scored.';

  @override
  String get toifaNoteNoSource => 'No source is given for this note.';

  @override
  String toifaOralSubtitle(int count) {
    return '$count questions · prepare and self-assess';
  }

  @override
  String toifaOralPool(String category, int count) {
    return '$category: $count questions in the list';
  }

  @override
  String get toifaOralHowTitle => 'How it works';

  @override
  String toifaOralStep1(int count) {
    return '$count random questions from your category list.';
  }

  @override
  String get toifaOralStep2 =>
      'Prepare your answers — in your head or on paper.';

  @override
  String get toifaOralStep3 =>
      'Check the answer plan and rate yourself: knew, partly or didn’t know.';

  @override
  String get toifaPlanDisclaimer =>
      'Answer plans are a study aid prepared by NurseGuide. They are not official answers.';

  @override
  String get toifaPickCategoryFirst => 'Choose a category first';

  @override
  String get toifaDrawTicket => 'Draw a ticket';

  @override
  String get toifaTicketTitle => 'Your ticket';

  @override
  String get toifaPrepHint =>
      'No typing needed. Think through each answer — say it out loud or jot it on paper. Then compare with the answer plan and rate yourself.';

  @override
  String get toifaShowPlans => 'Answer one by one';

  @override
  String get toifaShowPlan => 'View answer plan';

  @override
  String get toifaNewTicket => 'New ticket';

  @override
  String get toifaNewTicketBody =>
      'Five new questions replace the current ticket. Ratings you gave are kept.';

  @override
  String get toifaPlanTitle => 'Answer plan';

  @override
  String get toifaPlanPending => 'Prepared by NurseGuide';

  @override
  String get toifaPlanMissing => 'The plan for this question is not ready yet.';

  @override
  String get toifaPlanNotChecked => 'No source is attached to this plan yet.';

  @override
  String get toifaReferenceTitle => 'Reference values';

  @override
  String get toifaCutoffTitle => 'Diagnostic cut-off (guideline)';

  @override
  String get toifaWrongLabel => 'Wrong';

  @override
  String get toifaRightLabel => 'Right';

  @override
  String get toifaNeedsSource => 'Source needed — being checked with a teacher';

  @override
  String get toifaUnverifiedNote =>
      'The note is not confirmed by a source — no answer is suggested.';

  @override
  String toifaAgentChecked(String date) {
    return 'Compared with sources: $date';
  }

  @override
  String get toifaHeld => 'Being clarified';

  @override
  String get toifaHeldBody =>
      'Until the wording is clarified, this question is left out of tickets and scoring.';

  @override
  String toifaAboutHeld(int count) {
    return '$count question(s) are left out of tickets and tests until clarified.';
  }

  @override
  String get toifaPitfallsTitle => 'Outdated / common mistake';

  @override
  String get toifaRateTitle => 'Rate yourself';

  @override
  String get toifaRateHint =>
      'The rating stays on this device and appears in Mistake review.';

  @override
  String get toifaRateKnew => 'Knew it';

  @override
  String get toifaRatePartial => 'Partly';

  @override
  String get toifaRateUnknown => 'Didn’t know';

  @override
  String get toifaTicketDone => 'Ticket complete';

  @override
  String toifaTicketSummary(int knew, int partial, int unknown) {
    return 'Knew: $knew · partly: $partial · didn’t know: $unknown';
  }

  @override
  String get toifaRatingsSaved =>
      'Ratings saved. Tap a question to reopen the plan and change the rating.';

  @override
  String get toifaRatingSaved => 'Rating saved';

  @override
  String get toifaMistakesSubtitle => 'Test mistakes and oral questions';

  @override
  String get toifaMistakesEmpty => 'No mistakes yet';

  @override
  String get toifaMistakesEmptyBody =>
      'Questions you got wrong in tests or practice and oral questions rated “didn’t know” collect here.';

  @override
  String toifaMistakesTests(int count) {
    return 'Test mistakes · $count';
  }

  @override
  String toifaMistakesOralUnknown(int count) {
    return 'Oral: didn’t know · $count';
  }

  @override
  String toifaMistakesOralPartial(int count) {
    return 'Oral: partly · $count';
  }

  @override
  String toifaMoreMistakes(int count) {
    return '$count more mistakes — practise them via Redo mistakes.';
  }

  @override
  String get toifaNothingHere => 'Nothing here yet.';

  @override
  String get toifaProgressSubtitle => 'Results by topic and readiness';

  @override
  String get toifaReadyTitle => 'Estimated readiness';

  @override
  String get toifaReadyCaption =>
      'Average of test and oral results. A NurseGuide estimate, not an official grade.';

  @override
  String toifaReadyTestDetail(int done, int total) {
    return 'Test: $done / $total questions mastered';
  }

  @override
  String toifaReadyOralDetail(int done, int total) {
    return 'Oral: $done / $total “knew it”';
  }

  @override
  String get toifaProgressPickCategory =>
      'Oral results use your category list — choose a category:';

  @override
  String get toifaRecentTests => 'Recent tests';

  @override
  String get toifaPassedShort => 'Passed';

  @override
  String get toifaNotPassedShort => 'Below mark';

  @override
  String get toifaByTopicNote =>
      'Weakest topics first. Test — questions last answered correctly; oral — rated “knew it”.';

  @override
  String toifaBarTest(int done, int total) {
    return 'Test: $done / $total';
  }

  @override
  String toifaBarOral(int done, int total) {
    return 'Oral: $done / $total';
  }

  @override
  String examPassMet(int percent) {
    return 'Mark reached (≥$percent%)';
  }

  @override
  String examPassMissed(int percent) {
    return 'Below your mark ($percent%)';
  }

  @override
  String quizProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get quizCorrect => 'Correct.';

  @override
  String get quizIncorrect => 'This answer is incorrect.';

  @override
  String get quizNext => 'Next';

  @override
  String get quizFinish => 'See result';

  @override
  String get quizDoneTitle => 'Practice complete';

  @override
  String quizScore(int correct, int total) {
    return '$correct of $total correct';
  }

  @override
  String get quizRestart => 'Try again';

  @override
  String quizBasis(String basis) {
    return 'Basis: $basis';
  }

  @override
  String get quizSources => 'Source';

  @override
  String get quizReviewNote =>
      'Practice questions are for learning; the result is not an official grade.';

  @override
  String get quizMistakes => 'Review your mistakes';

  @override
  String get quizNoMistakes => 'No mistakes — well done.';

  @override
  String get quizYourAnswer => 'Your answer';

  @override
  String get quizCorrectAnswer => 'Correct answer';

  @override
  String get quizChooseTopic => 'Choose a topic';

  @override
  String quizTopicMixed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mixed: $count random questions',
      one: 'Mixed: 1 random question',
    );
    return '$_temp0';
  }

  @override
  String get quizTopicGeneral => 'General questions';

  @override
  String quizQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
    );
    return '$_temp0';
  }

  @override
  String get quizOtherTopic => 'Another topic';

  @override
  String get dailyTitle => 'Daily questions';

  @override
  String get dailyCardStart => 'Today’s 5 questions';

  @override
  String get dailyCardStartSub =>
      '2–3 minutes. New questions every day, with an explanation and source after each answer.';

  @override
  String dailyCardProgress(int count, int total) {
    return '$count of $total answered';
  }

  @override
  String dailyCardDone(int correct, int total) {
    return 'Done for today: $correct of $total correct';
  }

  @override
  String get dailyCardDoneSub => 'Five new questions tomorrow.';

  @override
  String get dailyStart => 'Start';

  @override
  String get dailyContinue => 'Continue';

  @override
  String get dailyShowResult => 'See result';

  @override
  String dailyStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days in a row',
      one: '$count day in a row',
    );
    return '$_temp0';
  }

  @override
  String get dailyStreakTitle => 'Streak';

  @override
  String get dailyStreakCurrent => 'Current streak';

  @override
  String get dailyStreakBest => 'Longest streak';

  @override
  String dailyDaysShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get dailyFreezeAvailable => 'This week’s freeze is available';

  @override
  String get dailyFreezeUsed => 'This week’s freeze is used';

  @override
  String get dailyFreezeRule =>
      'Miss one day and your streak survives — once a week (a freeze). The frozen day doesn’t count towards the streak; miss two days in a row and it starts over.';

  @override
  String get dailyFreezeSaved =>
      'You missed yesterday — a freeze kept your streak.';

  @override
  String get dailyKeepStreak => 'Answer today’s questions to keep your streak.';

  @override
  String get dailyEmpty => 'No questions for today';

  @override
  String get dailyReviewTitle => 'Today’s questions';

  @override
  String get dailySourceToifa =>
      'Questions come from the official certification list — only those whose key passed the NurseGuide check.';

  @override
  String get dailyReminderTitle => 'NurseGuide: daily questions';

  @override
  String get dailyReminderBody =>
      'Today’s 5 questions are ready — 2–3 minutes.';

  @override
  String get dailyReminderChannel => 'Daily reminder';

  @override
  String get dailyReminderSetting => 'Daily reminder';

  @override
  String dailyReminderAt(String time) {
    return 'Every day at $time';
  }

  @override
  String get dailyReminderOff => 'Off';

  @override
  String get dailyReminderTime => 'Reminder time';

  @override
  String get dailyOfferTitle => 'Want a daily reminder?';

  @override
  String get dailyOfferBody =>
      'One notification at the time you choose. No reminder on days you’ve already answered. Turn it off any time.';

  @override
  String get dailyOfferYes => 'Turn on reminder';

  @override
  String get dailyOfferNo => 'No thanks';

  @override
  String get dailyReminderDenied =>
      'Notification permission wasn’t granted, so the reminder stays off. Allow notifications for NurseGuide in your phone settings and try again.';

  @override
  String get dailyReminderUnavailable =>
      'Couldn’t turn on reminders on this device.';

  @override
  String dailyReminderOnSnack(String time) {
    return 'Reminder on: every day at $time';
  }

  @override
  String get dailyReminderNote =>
      'The reminder is scheduled on this device only (no server). Your phone may delay it by a few minutes to save battery. If you don’t open the app for 7 days, reminders stop.';

  @override
  String get shareResult => 'Share result';

  @override
  String get shareSheetTitle => 'Result card';

  @override
  String get shareSheetBody => 'The image has no name or other personal data.';

  @override
  String get shareFailed => 'Couldn’t open the share sheet. Please try again.';

  @override
  String get shareKindDaily => 'Daily questions';

  @override
  String get shareKindExam => 'Practice exam';

  @override
  String get shareKindToifa => 'Category test practice';

  @override
  String get shareCorrectCaption => 'correct answers';

  @override
  String get shareFooter => 'Nursing reference and practice';

  @override
  String get shareToifaNote => 'Not official — NurseGuide practice result';

  @override
  String shareText(String kind, int correct, int total, int percent) {
    return 'NurseGuide · $kind: $correct/$total ($percent%)';
  }

  @override
  String get quizTopicMistakes => 'Review my mistakes';

  @override
  String quizMastered(int correct, int total) {
    return '$correct of $total correct last time';
  }

  @override
  String get examTitle => 'Exam mode';

  @override
  String get classesTitle => 'Classes and assignments';

  @override
  String get classesSignInTitle => 'Sign in to use classes';

  @override
  String get classesSignInBody =>
      'Creating, joining and submitting assignments is tied to an account. Reading content stays open without sign-in.';

  @override
  String get classesSignIn => 'Sign in';

  @override
  String get classesUnavailableTitle => 'The class server isn\'t connected yet';

  @override
  String get classesUnavailableBody =>
      'Nothing is sent or stored. When it\'s connected, teachers see only their own classes and students see only their own results — checked on the server.';

  @override
  String get examSubtitle =>
      'A timed test: pick topics, number of questions and time. Works offline.';

  @override
  String get examActiveTitle => 'Unfinished exam';

  @override
  String examActiveBody(int answered, int total, String time) {
    return '$answered/$total answered · $time left';
  }

  @override
  String get examResume => 'Resume';

  @override
  String get examDiscard => 'Abandon exam';

  @override
  String get examDiscardTitle => 'Abandon this exam?';

  @override
  String get examDiscardBody =>
      'Your answers will be deleted and no result will be saved.';

  @override
  String get examDiscardAction => 'Abandon';

  @override
  String get examTopics => 'Topics';

  @override
  String get examAllTopics => 'All';

  @override
  String examPoolCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions in the selected topics',
      one: '1 question in the selected topics',
    );
    return '$_temp0';
  }

  @override
  String get examSettings => 'Settings';

  @override
  String get examCount => 'Number of questions';

  @override
  String examCountHint(int max) {
    return 'From 1 to $max';
  }

  @override
  String examCountError(int max) {
    return 'Enter a number from 1 to $max';
  }

  @override
  String examCountAll(int count) {
    return 'All $count';
  }

  @override
  String get examTime => 'Time, minutes';

  @override
  String get examTimeHint => '1–180 min · usually 1 min per question';

  @override
  String get examTimeError => 'Enter 1 to 180 minutes';

  @override
  String examMinutes(int count) {
    return '$count min';
  }

  @override
  String get examRulesNotice =>
      'Questions and options are shuffled. Until you finish you can change answers and bookmark questions to revisit. The clock keeps running even if the app is closed; when time is up, the exam ends by itself.';

  @override
  String get examStart => 'Start exam';

  @override
  String get examReplaceTitle => 'You have an unfinished exam';

  @override
  String get examReplaceBody =>
      'Starting a new one deletes the previous exam and its answers.';

  @override
  String get examHistory => 'Result history';

  @override
  String get examHistoryEmpty =>
      'No exams yet. Your first result will appear here — it’s stored only on this device.';

  @override
  String examHistoryStats(int count, int avg, int best) {
    return 'Last $count: average $avg% · best $best%';
  }

  @override
  String examHistoryRow(String date, int correct, int total, String time) {
    return '$date · $correct/$total · $time';
  }

  @override
  String get examHistoryClear => 'Clear history';

  @override
  String get examHistoryClearBody =>
      'All exam results will be deleted from this device.';

  @override
  String examProgressLabel(String values) {
    return 'Recent results: $values';
  }

  @override
  String get examProgressOld => 'Older → newer';

  @override
  String get examProgressLast => 'Latest';

  @override
  String get examSettled => 'Your previous exam ended because time ran out';

  @override
  String get examOpenResult => 'Result';

  @override
  String get examTitleAll => 'All topics';

  @override
  String examTitleTopics(String first, int more) {
    return '$first + $more more';
  }

  @override
  String get examReworkTitle => 'Practise your mistakes';

  @override
  String get examQuestionMissing =>
      'This question isn’t in the current content pack.';

  @override
  String get examMap => 'Question map';

  @override
  String get examFinish => 'Finish';

  @override
  String get examFinishTitle => 'Finish the exam?';

  @override
  String examFinishBody(int unanswered, int flagged) {
    return 'Unanswered: $unanswered, bookmarked: $flagged. You can’t change answers after finishing.';
  }

  @override
  String get examFinishBodyAll =>
      'All questions are answered. You can’t change answers after finishing.';

  @override
  String get examFinishClassTitle => 'Finish the test?';

  @override
  String get examFinishClassBody =>
      'Your answers will be sent to your teacher.';

  @override
  String get examFlag => 'Bookmark';

  @override
  String get examFlagged => 'Bookmarked';

  @override
  String get examLegendAnswered => 'Answered';

  @override
  String get examLegendEmpty => 'Unanswered';

  @override
  String get examLegendFlagged => 'Bookmarked';

  @override
  String examQuestionN(int n) {
    return 'Question $n';
  }

  @override
  String examAnsweredOf(int answered, int total) {
    return '$answered/$total answered';
  }

  @override
  String get examPrev => 'Previous';

  @override
  String get examNext => 'Next';

  @override
  String examTimeLeft(String time) {
    return 'Time left: $time';
  }

  @override
  String examElapsed(String time) {
    return 'Elapsed: $time';
  }

  @override
  String get examNoActive => 'No active exam';

  @override
  String get examNoActiveBody =>
      'It was finished or abandoned. Set up and start a new one.';

  @override
  String get examNew => 'New exam';

  @override
  String get examSaving => 'Saving the result…';

  @override
  String get examResultTitle => 'Result';

  @override
  String get examResultMissing => 'Result not found';

  @override
  String get examBand90 => 'Excellent!';

  @override
  String get examBand70 => 'Good result!';

  @override
  String get examBand50 => 'Not bad — review your mistakes';

  @override
  String get examBand0 => 'Keep practising — you’ve got this';

  @override
  String get examCorrectN => 'Correct';

  @override
  String get examWrongN => 'Wrong';

  @override
  String get examSkippedN => 'Unanswered';

  @override
  String get examSpent => 'Time';

  @override
  String get examTimedOut => 'Time ran out — finished automatically';

  @override
  String examDeltaUp(int n) {
    return '+$n% vs last attempt';
  }

  @override
  String examDeltaDown(int n) {
    return '−$n% vs last attempt';
  }

  @override
  String get examDeltaSame => 'Same as last attempt';

  @override
  String examReworkMistakes(int count) {
    return 'Practise mistakes · $count';
  }

  @override
  String get examAnalysis => 'Mistake analysis';

  @override
  String examFilterMistakes(int count) {
    return 'Mistakes · $count';
  }

  @override
  String examFilterAll(int count) {
    return 'All · $count';
  }

  @override
  String get examNoAnswer => 'Not answered';

  @override
  String get examWrongTag => 'Wrong';

  @override
  String get examWhyWrong => 'Why not this answer';

  @override
  String get examNoSource => 'No source is given for this question.';

  @override
  String get examSourceMissing =>
      'This exam’s question list isn’t available in the app';

  @override
  String get examMultiHint => 'Several correct answers — select all';

  @override
  String get examNoExplanation =>
      'No explanation has been written for this question yet.';

  @override
  String get examByTopic => 'By topic';

  @override
  String get examByTopicNote => 'Weakest topic first — start there.';

  @override
  String get classesSubtitle =>
      'A teacher creates a class and sets assignments; students join with a code and solve them.';

  @override
  String get classesTryExam => 'Open the offline exam';

  @override
  String get classesLoading => 'Loading…';

  @override
  String get classesInvalid =>
      'The server didn’t accept this — check the fields.';

  @override
  String get classesCodeNotFound =>
      'No class found with this code. Check the code with your teacher.';

  @override
  String get classesCreate => 'Create a class';

  @override
  String get classesCreateSub => 'For teachers: get a code and set assignments';

  @override
  String get classesJoin => 'Join with a code';

  @override
  String get classesJoinSub =>
      'For students: the 8-character code from your teacher';

  @override
  String get classesRoleNote =>
      'Your role in the app grants no server rights: only an account registered as a teacher can open a class, and only manages its own classes.';

  @override
  String get classesMine => 'My classes';

  @override
  String get classesEmpty => 'No classes yet';

  @override
  String get classesEmptyBody =>
      'Create a class or join one with the code from your teacher.';

  @override
  String get classesRoleTeacher => 'Teacher';

  @override
  String get classesRoleStudent => 'Student';

  @override
  String classesMembers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 member',
    );
    return '$_temp0';
  }

  @override
  String get classesCreateIntro =>
      'The teacher who opens a class manages only that class. Students join with your code or QR.';

  @override
  String get classesGroupName => 'Class name';

  @override
  String get classesGroupNameHint => 'e.g. Nursing year 2';

  @override
  String classesLengthError(int min, int max) {
    return 'Enter $min–$max characters';
  }

  @override
  String get classesDisplayName => 'Nickname (optional)';

  @override
  String get classesDisplayNameHint =>
      'e.g. Star — leave empty to use a number';

  @override
  String get classesDisplayNameNote =>
      'Names aren’t stored on the server: students appear by nickname or number. You can note a real name only as a label on your own device.';

  @override
  String get classesCreateAction => 'Create class';

  @override
  String get classesCreated => 'Class created — send the code to your students';

  @override
  String get classesJoinIntro => 'Enter the code your teacher gave you.';

  @override
  String get classesCode => 'Invite code';

  @override
  String get classesCodeError => 'The code has 8 letters and digits';

  @override
  String get classesJoinNote =>
      'Don’t use your real name. The teacher sees only your nickname (or number) and your results; other students don’t see you. Your email isn’t shown.';

  @override
  String get classesJoinAction => 'Join';

  @override
  String get classesJoined => 'You joined the class';

  @override
  String classesYouTeacher(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You’re the teacher · $count members',
      one: 'You’re the teacher · 1 member',
    );
    return '$_temp0';
  }

  @override
  String get classesYouStudent => 'You’re a student';

  @override
  String get classesGroupMissing =>
      'Class not found, or you’re no longer a member';

  @override
  String get classesBackToList => 'Back to classes';

  @override
  String get classesAssignments => 'Assignments';

  @override
  String get classesNoAssignmentsTeacher =>
      'No assignments yet. Pick topics and a number of questions from the list to set one.';

  @override
  String get classesNoAssignmentsStudent => 'No assignments yet';

  @override
  String get classesNoAssignmentsStudentBody =>
      'When your teacher sets one, it will appear here.';

  @override
  String get classesNoDue => 'no due date';

  @override
  String classesDue(String date) {
    return 'due $date';
  }

  @override
  String classesSubmittedOf(int done, int total) {
    return '$done/$total submitted';
  }

  @override
  String classesMembersTitle(int count) {
    return 'Students · $count';
  }

  @override
  String get classesNoStudents => 'No students yet — share the code.';

  @override
  String get classesMemberNoWork => 'Nothing submitted yet';

  @override
  String classesMemberSummary(int done, int total, int avg) {
    return '$done/$total assignments · average $avg%';
  }

  @override
  String get classesRemove => 'Remove from class';

  @override
  String classesRemoveTitle(String name) {
    return 'Remove $name from the class?';
  }

  @override
  String get classesRemoveBody =>
      'They’ll no longer see the class or new assignments. Submitted results are kept.';

  @override
  String get classesRemoveAction => 'Remove';

  @override
  String classesStatusDone(int score, int total) {
    return 'Submitted · $score/$total';
  }

  @override
  String get classesStatusInProgress => 'In progress';

  @override
  String get classesStatusPending => 'Not sent';

  @override
  String get classesStatusOverdue => 'Past due';

  @override
  String get classesStatusNew => 'New';

  @override
  String get classesStudentNote =>
      'Your teacher sees only your name in the class and your assignment results.';

  @override
  String get classesLeave => 'Leave class';

  @override
  String get classesLeaveTitle => 'Leave the class?';

  @override
  String get classesLeaveBody =>
      'To rejoin you’ll need the teacher’s code. Results you’ve submitted stay with the teacher.';

  @override
  String get classesLeaveAction => 'Leave';

  @override
  String get classesInviteTitle => 'Invite code';

  @override
  String get classesInviteBody =>
      'Students scan the QR with the phone camera and tap “Open in app” — or: Learn → Classes and assignments → Join with a code.';

  @override
  String get classesCopyCode => 'Copy code';

  @override
  String get classesCopyInvite => 'Copy invitation text';

  @override
  String get classesCopied => 'Copied';

  @override
  String classesInviteText(String name, String code) {
    return 'Join the class “$name” in the NurseGuide app: Learn → Classes and assignments → Join with a code. Code: $code';
  }

  @override
  String get classesAssignmentTitle => 'Assignment title';

  @override
  String get classesTimeLimit => 'Time limit, minutes';

  @override
  String get classesNoLimit => 'No limit';

  @override
  String get classesDueNone => 'No due date';

  @override
  String classesDueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get classesDuePick => 'Pick a date';

  @override
  String get classesDueNoneBody =>
      'No due date — students can submit any time.';

  @override
  String classesDueAt(String date) {
    return 'Due by $date';
  }

  @override
  String classesPreview(int count) {
    return 'Selected questions · $count';
  }

  @override
  String get classesReshuffle => 'Reshuffle';

  @override
  String get classesKeyNotice =>
      'Students can’t see the answer key in advance — the server does the scoring. Each student submits once.';

  @override
  String get classesSendAssignment => 'Set assignment';

  @override
  String get classesSubmitted => 'Answers submitted';

  @override
  String get classesSubmitNetwork =>
      'No connection — answers are saved on this device. Send them again later.';

  @override
  String get classesSubmitRejected =>
      'The server didn’t accept the answers: time or the due date ran out, or it was already submitted.';

  @override
  String get classesAssignmentMissing => 'Assignment not found';

  @override
  String get classesMetricQuestions => 'Questions';

  @override
  String get classesMetricLimit => 'Time limit';

  @override
  String get classesMetricDue => 'Due';

  @override
  String get classesMetricSubmitted => 'Submitted';

  @override
  String get classesMetricAverage => 'Average score';

  @override
  String get classesPendingTitle => 'Answers not sent yet';

  @override
  String get classesPendingBody =>
      'They’re saved on this device. Send them once you’re online — the server accepts them within the time limit.';

  @override
  String get classesResend => 'Send again';

  @override
  String get classesOverdueTitle => 'Past due';

  @override
  String get classesOverdueBody =>
      'This assignment can no longer be submitted.';

  @override
  String classesOutdatedPack(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count questions in this assignment aren’t in your app’s content. Update the app.',
      one: '1 question in this assignment isn’t in your app’s content. Update the app.',
    );
    return '$_temp0';
  }

  @override
  String classesStartNotice(int minutes) {
    return 'Once you start you have $minutes min — the clock doesn’t stop, and answers are sent automatically when time is up. One submission only; sending needs internet.';
  }

  @override
  String get classesStartNoticeNoLimit =>
      'No time limit. Answers are sent once and can’t be resubmitted; sending needs internet.';

  @override
  String get classesStart => 'Start';

  @override
  String classesSubmittedAt(String date) {
    return 'Submitted $date';
  }

  @override
  String get classesServerScore => 'Scored by the server';

  @override
  String get classesResults => 'Results';

  @override
  String get classesColStudent => 'Student';

  @override
  String get classesColScore => 'Score · %';

  @override
  String get classesNotSubmitted => 'Not submitted';

  @override
  String get classesByQuestion => 'By question';

  @override
  String get classesByQuestionEmpty => 'No one has submitted yet.';

  @override
  String classesWrongOf(int wrong, int total) {
    return '$wrong/$total wrong';
  }

  @override
  String get classesSending => 'Sending answers…';

  @override
  String get classesMyProgress => 'My progress';

  @override
  String classesDoneOf(int done, int total) {
    return '$done/$total assignments done';
  }

  @override
  String classesAverage(int avg) {
    return 'Average score: $avg%';
  }

  @override
  String get classesStudentResultTitle => 'Student’s result';

  @override
  String get classesStudentAnswer => 'Student’s answer';

  @override
  String get classesInviteMore => 'Invite more students';

  @override
  String get profileTitle => 'Profile and settings';

  @override
  String get profileGuest => 'Guest';

  @override
  String get profileGuestSub => 'Content is open without an account';

  @override
  String get profileGuestLocal => 'Data stays on this device only';

  @override
  String get profileDemoSession => 'Demo session · debug build';

  @override
  String get profileRole => 'Role';

  @override
  String get profileRoleSub => 'Home adapts to your role';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeRowSub => 'App colours and title type';

  @override
  String get themeCurrent => 'Current theme';

  @override
  String get themeClassicName => 'Clear glass';

  @override
  String get themeClassicDesc => 'Soft glass and 3D icons';

  @override
  String get themeIvoryName => 'Ivory';

  @override
  String get themeIvoryDesc => 'Ivory, ink and gold with elegant serif titles';

  @override
  String get themeModeSection => 'Light or dark';

  @override
  String get profilePrivacy => 'Privacy and data';

  @override
  String get profilePrivacySub => 'Data and account controls';

  @override
  String get supportTitle => 'Feedback & help';

  @override
  String get supportSub => 'Suggestion, bug or question — replies arrive here';

  @override
  String get supportNew => 'New request';

  @override
  String get supportEmptyTitle => 'No requests yet';

  @override
  String get supportEmptyBody =>
      'Send a suggestion, report a bug or ask a question — the reply appears here.';

  @override
  String get supportKind => 'Type';

  @override
  String get supportKindSuggestion => 'Suggestion';

  @override
  String get supportKindBug => 'Bug';

  @override
  String get supportKindQuestion => 'Question';

  @override
  String get supportSubject => 'Subject';

  @override
  String get supportSubjectHint => 'In short: what is it about?';

  @override
  String get supportMessage => 'Message';

  @override
  String get supportMessageHint =>
      'Details: which screen, what you did and what you expected';

  @override
  String get supportAttach => 'Attach a screenshot (optional)';

  @override
  String get supportAttachRemove => 'Remove image';

  @override
  String get supportAttachTooLarge =>
      'The image is larger than 5 MB. Choose a smaller one.';

  @override
  String get supportAttachType => 'PNG or JPEG only.';

  @override
  String get supportPhiNotice =>
      'Make sure the screenshot shows no patient name, date of birth, record number or other personal data.';

  @override
  String get supportSend => 'Send';

  @override
  String get supportSent => 'Request sent';

  @override
  String get supportReplyHint => 'Write a reply…';

  @override
  String get supportTeam => 'NurseGuide team';

  @override
  String get supportYou => 'You';

  @override
  String get supportUser => 'User';

  @override
  String get supportHumanReplies =>
      'Replies are written by the NurseGuide team; nothing is sent automatically.';

  @override
  String get supportStatusNew => 'New';

  @override
  String get supportStatusInReview => 'In review';

  @override
  String get supportStatusAnswered => 'Answered';

  @override
  String get supportStatusClosed => 'Closed';

  @override
  String get supportUnread => 'New reply';

  @override
  String supportUnreadCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'replies',
      one: 'reply',
    );
    return '$count new $_temp0';
  }

  @override
  String get supportSignInTitle => 'Sign in to send a request';

  @override
  String get supportSignInBody =>
      'Signing in with email lets us deliver the reply to you. Data on this device stays as it is.';

  @override
  String get supportUnavailableTitle => 'Server not connected yet';

  @override
  String get supportUnavailableBody =>
      'This build has no account, feedback or groups server yet. Once connected, it works right here.';

  @override
  String get errNetwork =>
      'Couldn’t connect. Check the internet and try again.';

  @override
  String get errRateLimited => 'Too many requests. Try again a bit later.';

  @override
  String get errInvalidSupport =>
      'The subject needs at least 3 characters and the message can’t be empty.';

  @override
  String get errForbidden => 'You don’t have access to this.';

  @override
  String get errSessionExpired =>
      'Your session has expired. Please sign in again.';

  @override
  String get errGeneric => 'That didn’t work. Please try again.';

  @override
  String get accountDelete => 'Delete account';

  @override
  String get accountDeleteSub =>
      'Removes your server account, requests and group memberships';

  @override
  String get accountDeleteTitle => 'Delete your account?';

  @override
  String get accountDeleteBody =>
      'Your account, sign-in methods (Google/Apple links), group memberships and results and “Feedback & help” requests are permanently removed from the server. If you are a teacher, the groups you created are deleted too. This can’t be undone. The text of complaints you sent in the app stays, no longer linked to the account. Data on this device is cleared as well.';

  @override
  String get accountDeleted => 'Account deleted';

  @override
  String get adminTitle => 'Admin panel';

  @override
  String get adminSub => 'Moderation, support, content, admins';

  @override
  String get adminMfaTitle => 'Two-step protection';

  @override
  String get adminMfaEnrollBody =>
      'The admin panel needs an authenticator app (Google Authenticator, Microsoft Authenticator, 1Password…). Add the key to the app and enter the 6-digit code it shows.';

  @override
  String get adminMfaVerifyBody =>
      'Enter the 6-digit code from your authenticator app.';

  @override
  String get adminMfaSecret => 'Key';

  @override
  String get adminMfaCopy => 'Copy key';

  @override
  String get adminMfaOpen => 'Open in authenticator';

  @override
  String get adminMfaCode => '6-digit code';

  @override
  String get adminMfaVerify => 'Verify';

  @override
  String get adminMfaWrong =>
      'The code is wrong or expired. Enter the current code from the app.';

  @override
  String get adminCopied => 'Copied';

  @override
  String get adminForbiddenTitle => 'Admins only';

  @override
  String get adminForbiddenBody =>
      'Admin access is granted by the server — the role or email in the app can’t change that.';

  @override
  String get adminStats => 'Statistics';

  @override
  String get adminRegistered => 'Registered';

  @override
  String get adminNewToday => 'New today';

  @override
  String get adminNew7 => 'New, 7 days';

  @override
  String get adminNew30 => 'New, 30 days';

  @override
  String get adminActiveToday => 'Active today';

  @override
  String get adminActive7 => 'Active, 7 days';

  @override
  String get adminActive30 => 'Active, 30 days';

  @override
  String get adminDefinitions =>
      'Registered — an account whose email was confirmed with a code; guests and unconfirmed sign-ups aren’t counted. New — the day the email was first confirmed. Active — opened the app while signed in at least once in the period. Days use Tashkent time; “7 days” includes today.';

  @override
  String get adminByRole => 'By role';

  @override
  String get adminByLanguage => 'By language';

  @override
  String adminNoProfile(int count) {
    return 'No profile yet: $count';
  }

  @override
  String get adminInbox => 'Requests';

  @override
  String adminAwaiting(int count) {
    return 'Awaiting reply: $count';
  }

  @override
  String get adminAllStatuses => 'All';

  @override
  String get adminUsers => 'Users';

  @override
  String get adminAudit => 'Action log';

  @override
  String get adminAuditEmpty => 'No actions yet';

  @override
  String get adminSearchHint => 'Search by email';

  @override
  String get adminAllRoles => 'All roles';

  @override
  String get adminAllLanguages => 'All languages';

  @override
  String get adminShowEmail => 'Show email (logged)';

  @override
  String adminPage(int from, int to, int total) {
    return '$from–$to of $total';
  }

  @override
  String get adminPrev => 'Previous';

  @override
  String get adminNext => 'Next';

  @override
  String adminRegisteredOn(String date) {
    return 'Registered: $date';
  }

  @override
  String adminLastSeen(String date) {
    return 'Last active: $date';
  }

  @override
  String get adminNoUsers => 'No users found';

  @override
  String get adminReplyHint => 'Write your reply';

  @override
  String get adminSendReply => 'Send reply';

  @override
  String get adminStatus => 'Status';

  @override
  String get adminActionSupportReply => 'Replied to request';

  @override
  String get adminActionSupportStatus => 'Request status changed';

  @override
  String get adminActionRevealEmail => 'Email viewed';

  @override
  String get adminActionAdminGranted => 'Admin access granted';

  @override
  String get adminActionAdminRevoked => 'Admin access revoked';

  @override
  String get profileSignIn => 'Sign in with email';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileRestartSetup => 'Restart setup';

  @override
  String get profileSignOutTitle => 'Sign out?';

  @override
  String get profileSignOutBody =>
      'Bookmarks, notes and practice progress stay on this device. If someone else will use it, delete them too.';

  @override
  String get profileSignOutDelete => 'Sign out and delete';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get privacyTitle => 'Privacy and data';

  @override
  String get privacyBody =>
      'The core features work without an account (guest mode): settings, bookmarks and practice results stay on this device. An account is optional (email code, Google or Apple) and is needed for groups and “Feedback & help”. Then data is stored on a Cloudflare server (Eastern Europe, outside Uzbekistan): your email only as a hash and a masked form, sign-in method, role, language, last activity time (to the minute); in a group — your nickname or sequence number, test answers and scores; the text of requests and complaints. From Google/Apple only the account identifier and email are used; the token is not stored. A teacher sees only their own group. No ads, analytics or tracking. You can delete your account at any time with the “Delete account” button. Full text: the “Privacy policy” link.';

  @override
  String get privacyBodyLocal =>
      'This build has no server connected: the app sends nothing to a server. Settings, bookmarks and practice results stay on this device (they may be included in the device backup). No ads or tracking.';

  @override
  String get privacyTerms => 'Terms of use';

  @override
  String get privacyTermsSub => 'Final text to be prepared';

  @override
  String get privacyDeleteLocal => 'Delete local data';

  @override
  String get privacyDeleteLocalSub =>
      'Settings, bookmarks, unfinished tests and practice progress';

  @override
  String get privacyDeleteConfirmTitle => 'Delete local data?';

  @override
  String get privacyDeleteConfirmBody =>
      'Settings, bookmarks, unfinished tests and practice progress on this device will be removed. This can’t be undone.';

  @override
  String get privacyDeleted => 'Local data deleted';

  @override
  String get termsTitle => 'Terms of use';

  @override
  String get termsBody =>
      'NurseGuide is a free reference and learning app for nurses. By using the app you agree to these terms.\n\n1. Medical limitation. NurseGuide does not diagnose, prescribe treatment or medicines, and does not replace your institution\'s approved procedures, medicine instructions or a physician\'s orders. Every item shows its source; when making decisions, rely on the original source and your institution\'s rules.\n\n2. Account. Some features (groups, tests, support requests) require signing up with email. You are responsible for your account\'s security and for actions taken through it. You can delete your account at any time: Profile → Privacy and data → Delete account.\n\n3. Teacher and student groups. When a student joins a group, the teacher sees their nickname (or seat number) and test results. Teachers use groups for educational purposes only.\n\n4. User content. You are responsible for what you write in support requests. Abuse, illegal content, advertising, other people\'s personal data and non-consensual intimate images are strictly prohibited. Such content is removed, and the offending account may be restricted or deleted.\n\n5. Copyright. The app\'s texts, slides, tests and design belong to the NurseGuide authors; external sources are shown with their own licences. They may not be copied or distributed for commercial purposes.\n\n6. Service. The app is provided “as is”; outages and errors may occur, and we fix them as quickly as we can. We will notify you in the app if these terms change.\n\n7. Privacy. How your data is used is described in the privacy policy: nurseguide.nfcstore.uz/privacy\n\n8. Contact: nurseguide@nfcstore.uz';

  @override
  String get rightsUnknown => 'Distribution rights not confirmed';

  @override
  String get rightsPersonal => 'Personal study only — not distributed';

  @override
  String get rightsPermitted => 'Distribution permission recorded';

  @override
  String get rightsDenied => 'Distribution not permitted';

  @override
  String get kindBook => 'Book';

  @override
  String get kindManual => 'Manual';

  @override
  String get kindMethod => 'Method';

  @override
  String get kindArticle => 'Article';

  @override
  String get kindQuestionSet => 'Question set';

  @override
  String get kindWebsite => 'Website';

  @override
  String libAccessOpen(String licence) {
    return 'Open licence · $licence';
  }

  @override
  String get libAccessFree => 'Free to read · link only';

  @override
  String get libAccessCatalog => 'Catalogue record only';

  @override
  String get libOpenSource => 'Open the official page';

  @override
  String libChecked(String date) {
    return 'Page and licence checked: $date';
  }

  @override
  String libItemPack(String size) {
    return 'Offline pack · $size';
  }

  @override
  String libItemSupersedes(String title) {
    return 'Newer edition of: $title';
  }

  @override
  String get libSearchEntry => 'Search books, authors, topics';

  @override
  String libBooksCount(int count) {
    return '$count sources · search and filters';
  }

  @override
  String get libContinueReading => 'Continue reading';

  @override
  String get libSearchLabel => 'Search the library';

  @override
  String get libSearchHint => 'Title, author, topic…';

  @override
  String get libFilterLanguage => 'Language';

  @override
  String get libFilterTopic => 'Topic';

  @override
  String get libFilterType => 'Type';

  @override
  String get libFilterSectionField => 'Field';

  @override
  String get libFilterSectionGroup => 'Topic';

  @override
  String get libFilterSectionKind => 'Material type';

  @override
  String get libFilterSectionOpen => 'How it opens';

  @override
  String libResultCount(int shown, int total) {
    return '$shown of $total materials';
  }

  @override
  String get libClearFilters => 'Clear';

  @override
  String get libFilteredEmptyTitle => 'No materials match these filters';

  @override
  String get libFilteredEmptyBody =>
      'Remove one filter or try another word — for example an author’s surname.';

  @override
  String get libOpenLink => 'Link · external website';

  @override
  String libOpenLinkHint(String host) {
    return 'Opens in your browser: $host';
  }

  @override
  String get libOpenInApp => 'In-app file';

  @override
  String get libOpenInAppHint => 'Read inside the app — no internet needed';

  @override
  String get libOpenDownload => 'Downloadable book';

  @override
  String libOpenDownloadHint(String size) {
    return 'Read in the app after download · $size';
  }

  @override
  String get libOpenPending => 'Pending';

  @override
  String get libOpenPendingHint => 'Not received yet — cannot be opened';

  @override
  String get libOpenReceivedHint =>
      'File received and being checked — not available yet';

  @override
  String get libOpenRecordHint =>
      'No distribution rights recorded — not opened in the app';

  @override
  String get libOpenLinkShort => 'Link';

  @override
  String get libOpenInAppShort => 'In the app';

  @override
  String get libOpenDownloadShort => 'Download';

  @override
  String get libOpenRecordShort => 'Record only';

  @override
  String get libItemRead => 'Read';

  @override
  String libItemContinue(int page) {
    return 'Continue from page $page';
  }

  @override
  String get libItemCannotOpen => 'Cannot be opened';

  @override
  String get libDownloadUnavailable =>
      'The download server is not connected yet — the book can’t be downloaded for now.';

  @override
  String get libDetailsTitle => 'Details';

  @override
  String get libFieldAuthors => 'Author';

  @override
  String get libFieldYear => 'Year';

  @override
  String get libFieldEdition => 'Edition';

  @override
  String get libFieldPublisher => 'Publisher';

  @override
  String get libFieldAccess => 'Access';

  @override
  String get libFieldStatus => 'Status';

  @override
  String get libFieldRights => 'Distribution rights';

  @override
  String libFieldRightsRecorded(String date, String by) {
    return 'Recorded: $date · $by';
  }

  @override
  String get libFieldTopics => 'Topics';

  @override
  String get libFieldPages => 'Pages';

  @override
  String get libStateNotReceived => 'Not received yet';

  @override
  String get libStateReceived => 'Received, being checked';

  @override
  String get libStateCataloged => 'Catalogued';

  @override
  String get libStateLinked => 'Linked to cards';

  @override
  String get libStateReviewed => 'Approved by a teacher';

  @override
  String get libProvidedByTeacher => 'Provided by a teacher';

  @override
  String get libItemNotFound => 'Material not found';

  @override
  String get libItemNotFoundBody =>
      'The content pack may have been updated. Go back to the catalog.';

  @override
  String get libItemUnavailable =>
      'This material is not available in your language';

  @override
  String get libItemUnavailableBody =>
      'This material is currently available only in another language. Change the interface language or go back to the catalog.';

  @override
  String get libBackToCatalog => 'Back to catalog';

  @override
  String get readerTitle => 'Reader';

  @override
  String readerPageOf(int page, int total) {
    return '$page of $total';
  }

  @override
  String get readerToc => 'Contents';

  @override
  String get readerTocEmpty => 'This file has no table of contents';

  @override
  String get readerTocEmptyBody =>
      'Go to a page or bookmark the place you need.';

  @override
  String get readerBookmarks => 'Bookmarks';

  @override
  String get readerAddBookmark => 'Bookmark this page';

  @override
  String get readerBookmarkName => 'Bookmark name';

  @override
  String get readerBookmarkNameHint => 'For example: key table';

  @override
  String readerBookmarkSaved(int page) {
    return 'Bookmark saved: page $page';
  }

  @override
  String get readerBookmarkRemoved => 'Bookmark removed';

  @override
  String get readerBookmarkRemove => 'Remove bookmark';

  @override
  String get readerBookmarksEmpty => 'No bookmarks yet';

  @override
  String get readerBookmarksEmptyBody =>
      'On the page you need, tap “Bookmark this page” — then return with one tap.';

  @override
  String readerPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get readerGoTo => 'Go to page';

  @override
  String get readerGoToShort => 'Page';

  @override
  String readerGoToHint(int total) {
    return '1 to $total';
  }

  @override
  String readerGoToError(int total) {
    return 'Enter a number from 1 to $total';
  }

  @override
  String get readerGo => 'Go';

  @override
  String get readerSave => 'Save';

  @override
  String get readerRenameBookmark => 'Rename bookmark';

  @override
  String get libFieldProvidedBy => 'Provided by';

  @override
  String get libQueryEmptyBody =>
      'Try another word — for example an author’s surname or a topic name.';

  @override
  String get readerZoomIn => 'Zoom in';

  @override
  String get readerZoomOut => 'Zoom out';

  @override
  String readerResumed(int page) {
    return 'Resumed at page $page';
  }

  @override
  String get readerFromStart => 'From start';

  @override
  String get readerLoading => 'Opening the file…';

  @override
  String get readerFileMissing => 'File not found';

  @override
  String get readerFileMissingBody =>
      'This file isn’t in the app. Try updating the app.';

  @override
  String get readerFileCorrupted => 'The file failed verification';

  @override
  String get readerFileCorruptedBody =>
      'The file size or checksum doesn’t match the catalog — it may be damaged or replaced, so it wasn’t opened.';

  @override
  String get readerOpenFailed => 'Couldn’t open the PDF';

  @override
  String get readerBlockedTitle => 'Not available in the app';

  @override
  String get readerBlockedRights =>
      'Only files with fully recorded distribution rights open in the app. This material has no such file.';

  @override
  String get readerBookmarkedPage => 'This page is bookmarked';

  @override
  String get lessonsTitle => 'Lesson topics';

  @override
  String classesSeat(String n) {
    return 'Student $n';
  }

  @override
  String classesQrLabel(String code) {
    return 'Invite code QR: $code';
  }

  @override
  String get classesTeacherRegisterEyebrow => 'Teacher';

  @override
  String get classesTeacherRegisterTitle => 'Register as a teacher';

  @override
  String get classesTeacherRegisterBody =>
      'A teacher opens their own class and sees only their students’ results. This isn’t admin access and doesn’t affect other classes.';

  @override
  String get classesTeacherRegister => 'Register as a teacher';

  @override
  String get classesLocalNameTitle => 'Label (this device only)';

  @override
  String get classesLocalNameBody =>
      'For example, the student’s name. It isn’t sent to the server and the student can’t see it.';

  @override
  String get classesLocalNameHint => 'Empty — remove the label';

  @override
  String get classesLocalNameSave => 'Save';

  @override
  String get classroomPlanTitle => 'Course plan';

  @override
  String get classroomPlanSub => 'Topics by day: lecture, oral questions, test';

  @override
  String get classroomTopicsTitle => 'Topics';

  @override
  String get classroomTopicsSub => 'Topics and tests your teacher has opened';

  @override
  String get classroomProgramEyebrow => 'Curriculum';

  @override
  String classroomPlanProgress(int done, int total) {
    return '$done/$total topic tests finished';
  }

  @override
  String get classroomStartNone =>
      'No start date — the plan is shown by day number';

  @override
  String classroomStartAt(String date) {
    return 'Day 1: $date';
  }

  @override
  String get classroomStartNote =>
      'Dates are approximate (Sundays skipped, holidays not counted) and stored only on this device.';

  @override
  String get classroomStartPick => 'Set the start date';

  @override
  String classroomDayN(int n) {
    return 'Day $n';
  }

  @override
  String classroomWeekN(int n) {
    return 'Week $n';
  }

  @override
  String classroomHours(int n) {
    return '$n h';
  }

  @override
  String get classroomTypeLecture => 'Lecture';

  @override
  String get classroomTypePractical => 'Practical';

  @override
  String get classroomTypeSeminar => 'Seminar';

  @override
  String get classroomTypeAttestation => 'Assessment';

  @override
  String get classroomTypeOther => 'Session';

  @override
  String get classroomStatusClosed => 'Not opened';

  @override
  String get classroomStatusOpened => 'Opened';

  @override
  String get classroomStatusLectured => 'Taught';

  @override
  String get classroomStatusOral => 'Oral round done';

  @override
  String get classroomStatusTestRunning => 'Test in progress';

  @override
  String get classroomStatusTestDone => 'Test finished';

  @override
  String get classroomNoCurriculumTitle =>
      'The curriculum hasn’t been added yet';

  @override
  String get classroomNoCurriculumBody =>
      'The course plan (module → topic → materials) will come in a later app version. For now, use class assignments.';

  @override
  String get classroomCurriculumError => 'Couldn’t read the curriculum';

  @override
  String get classroomNoTopicsStudent =>
      'Your teacher hasn’t opened any topics yet';

  @override
  String get classroomNoTopicsStudentBody =>
      'When a topic opens, its materials and test will appear here.';

  @override
  String get classroomTopicTitle => 'Topic';

  @override
  String get classroomTopicMissing => 'Topic not found in the curriculum';

  @override
  String get classroomTopicNotOpened => 'This topic isn’t open yet';

  @override
  String get classroomOpenNote =>
      'Once opened, students see the topic materials.';

  @override
  String get classroomOpenTopic => 'Open to students';

  @override
  String classroomStep(int n) {
    return 'Step $n';
  }

  @override
  String get classroomStageLecture => 'Lecture';

  @override
  String get classroomStageLectureBody =>
      'Present the topic as slides on a big screen (works offline too).';

  @override
  String get classroomStageOral => 'Oral questions';

  @override
  String classroomStageOralBody(int count) {
    return 'Question list with answer outlines. Asked: $count.';
  }

  @override
  String get classroomStageTest => 'Class test';

  @override
  String get classroomStageTestBody =>
      'Pick questions and start the test — it opens for students right away.';

  @override
  String get classroomStageDone => 'Done';

  @override
  String get classroomMarkDone => 'Mark as done';

  @override
  String get classroomOralOpen => 'Question list';

  @override
  String get classroomTestPrepare => 'Prepare the test';

  @override
  String get classroomTestResults => 'Results panel';

  @override
  String get classroomTestFinish => 'Finish the test';

  @override
  String get classroomTestFinishTitle => 'Finish the test?';

  @override
  String get classroomTestFinishBody =>
      'No new attempts are accepted. Those who already started get 2 minutes to send their answers.';

  @override
  String classroomTestSubmitted(int done, int total) {
    return '$done/$total students submitted';
  }

  @override
  String get classroomTestNotStarted =>
      'Your teacher hasn’t started the test yet.';

  @override
  String get classroomTestOpenStudent => 'Test open — take it';

  @override
  String get classroomMaterials => 'Topic materials';

  @override
  String get classroomNoMaterials =>
      'The app has no linked materials for this topic yet.';

  @override
  String get classroomGapNote =>
      'The app has little material on this topic — the teacher adds their own sources.';

  @override
  String get classroomPlanRecommended =>
      'NurseGuide recommended practical plan';

  @override
  String get classroomOralNotice =>
      'Questions are auto-picked candidates; answer outlines are a study aid. “Asked” marks and grades stay on this device only.';

  @override
  String get classroomOralEmpty => 'No oral questions for this topic';

  @override
  String classroomCandidate(int n) {
    return 'Candidate question $n';
  }

  @override
  String get classroomOralPlan => 'Short answer outline';

  @override
  String get classroomOralNoPlan => 'No answer outline yet.';

  @override
  String get classroomOralAsked => 'Asked';

  @override
  String classroomOralGrade(int count) {
    return 'Grade students ($count)';
  }

  @override
  String get classroomOralGradeTitle => 'How each student answered';

  @override
  String get classroomOralGradeNote =>
      'This device only; not sent to the server.';

  @override
  String get classroomGradeKnew => 'Knew';

  @override
  String get classroomGradePartial => 'Partly';

  @override
  String get classroomGradeDidNot => 'Didn’t know';

  @override
  String get classroomCandidatesNotice =>
      'Candidate questions were auto-picked. Look through each one and its key: the score is computed on the server using the key shown.';

  @override
  String classroomCandidatesTitle(int picked, int total) {
    return 'Candidates · picked $picked/$total';
  }

  @override
  String get classroomPickAll => 'All';

  @override
  String get classroomPickNone => 'None';

  @override
  String classroomKeyShown(String answer) {
    return 'Key: $answer';
  }

  @override
  String get classroomKeyFlagged => 'Disputed key';

  @override
  String get classroomPickAtLeastOne => 'Pick at least one question';

  @override
  String get classroomPickMax => 'At most 50 questions';

  @override
  String classroomTestStart(int count) {
    return 'Start the test · $count questions';
  }

  @override
  String get classroomTestStarted => 'Test started — open for students';

  @override
  String classroomTestTitle(String topic) {
    return 'Test: $topic';
  }

  @override
  String get classroomTestAlready => 'This topic’s test has already started';

  @override
  String get classroomTestNoCandidates => 'No test questions for this topic';

  @override
  String get classroomTestNoCandidatesBody =>
      'You can build an assignment by hand (New assignment).';

  @override
  String get lectureTitle => 'Lecture';

  @override
  String get lectureListTitle => 'Lecture mode';

  @override
  String get lectureListSub => 'Pick a topic — slides on a big screen, offline';

  @override
  String get lectureStart => 'Start the lecture';

  @override
  String get lectureClose => 'Close the lecture';

  @override
  String lectureCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get lecturePrev => 'Back';

  @override
  String get lectureNext => 'Next';

  @override
  String get lectureGoals => 'Goals';

  @override
  String get lectureKeyPoints => 'Key concepts';

  @override
  String lectureQuestionN(int n) {
    return 'Question $n';
  }

  @override
  String get lectureEndEyebrow => 'Next step';

  @override
  String get lectureEndTitle => 'Questions and test';

  @override
  String get lectureEndOral => 'Oral questions — asked by the teacher';

  @override
  String get lectureEndTest => 'Class test — in the app, timed';

  @override
  String get lectureUzOnly => 'This presentation is in Uzbek only for now';

  @override
  String get lectureNotesShow => 'Show teacher notes';

  @override
  String get lectureNotesHide => 'Hide teacher notes';

  @override
  String get lectureTeacherNote => 'Teacher note';

  @override
  String get cmAdminDone => 'Done';

  @override
  String get admYouSuper => 'You are the owner (super admin)';

  @override
  String get admYouAdmin => 'You are an admin';

  @override
  String get adm2faOn =>
      'Two-step protection (2FA) is confirmed. It is required for every admin action.';

  @override
  String get admNotConnected => 'Not connected on this server yet';

  @override
  String get admTeam => 'Admin management';

  @override
  String admTeamCount(int count) {
    return 'Admins: $count';
  }

  @override
  String get admTeamSubManage => 'Add by email and remove';

  @override
  String get admTeamSubView => 'List (only the owner can change it)';

  @override
  String get admLegacyNote =>
      'Statistics, users and action history are not on this server yet — they will appear here when ready.';

  @override
  String get admOther => 'Other sections';

  @override
  String get admTeamIntro =>
      'An admin gets full access to every admin section: support threads, users, complaints. Only the server grants this, and every action needs a 2FA code.';

  @override
  String get admTeamOwnerOnly =>
      'Only the owner (super admin) can add and remove admins.';

  @override
  String get admAddTitle => 'Add an admin';

  @override
  String get admAddEmail => 'Email (e.g. Gmail)';

  @override
  String get admAddHint =>
      'Access takes effect once they sign in with this email and set up 2FA; if the account exists — right away.';

  @override
  String get admAddButton => 'Make admin';

  @override
  String get admAddConfirmTitle => 'Make this person an admin?';

  @override
  String admAddConfirmBody(String email) {
    return '$email will get full access to every admin section. You can remove them at any time.';
  }

  @override
  String admAdded(String email) {
    return 'Added: $email';
  }

  @override
  String get admInvalidEmail => 'Invalid email. For example: name@gmail.com';

  @override
  String get admErrAlready => 'This email is already an admin.';

  @override
  String get admErrSuper =>
      'This is the owner’s email (super admin) — already an admin.';

  @override
  String admErrTooMany(int max) {
    return 'Admin limit: $max. Remove someone first.';
  }

  @override
  String admListTitle(int count) {
    return 'Admins ($count)';
  }

  @override
  String get admKindSuper => 'Owner · super admin';

  @override
  String admKindGranted(String date) {
    return 'Admin · added $date';
  }

  @override
  String get admNotSignedIn =>
      'Not signed in yet — access starts at first sign-in';

  @override
  String get admYou => 'You';

  @override
  String get admRemove => 'Remove';

  @override
  String get admRemoveTitle => 'Remove this admin?';

  @override
  String admRemoveBody(String email) {
    return '$email loses admin access immediately — on every device. Their account and data are not deleted.';
  }

  @override
  String admRemoved(String email) {
    return 'Removed: $email';
  }

  @override
  String get admSuperNote =>
      'The owner is set in a secret server setting (LG_ADMIN_EMAILS) and cannot be removed from the app.';

  @override
  String get admNoGranted => 'No admins added yet.';

  @override
  String get adminActionGrantAdded => 'Admin added';

  @override
  String get adminActionGrantRemoved => 'Admin removed';

  @override
  String get contactPrivacyPolicy => 'Privacy Policy';

  @override
  String get autoPresTitle => 'Automatic presentation';

  @override
  String get autoPresEntrySub => 'Slides built from the app’s sourced content';

  @override
  String get autoPresShowAnswer => 'Show answer';

  @override
  String get autoPresHideAnswer => 'Hide answer';

  @override
  String get contactRowTitle => 'Contact & reports';

  @override
  String get contactRowSub => 'Questions, complaints, report a problem';

  @override
  String get contactTitle => 'Contact';

  @override
  String get contactIntro =>
      'Works without internet or an account: the message is sent from your mail app.';

  @override
  String get contactEmailLabel => 'Email';

  @override
  String get contactCopy => 'Copy address';

  @override
  String get contactCopied => 'Address copied';

  @override
  String get contactNoMailApp =>
      'Could not open a mail app. The address was copied: send your message from any mail service.';

  @override
  String get contactQuestionTitle => 'Questions and suggestions';

  @override
  String get contactQuestionBody =>
      'Ask about the app, suggest a topic or an improvement.';

  @override
  String get contactQuestionAction => 'Write an email';

  @override
  String get contactReportTitle => 'Report a problem';

  @override
  String get contactReportBody =>
      'Tell us about wrong medical content or inappropriate user content.';

  @override
  String get contactReportHint =>
      'Please name the section or card so we can find it quickly.';

  @override
  String get contactReportAction => 'Send a report';

  @override
  String get contactResponseNote =>
      'We read every report and fix confirmed errors, but we cannot promise a reply time. This address is not for medical emergencies.';

  @override
  String get contactPrivacyNote =>
      'If you write to us, we see your email address and what you write.';

  @override
  String contactMailBodyQuestion(String version, String platform) {
    return 'Your question or suggestion:\n\n\n---\nApp: NurseGuide $version\nPlatform: $platform';
  }

  @override
  String contactMailBodyReport(String version, String platform) {
    return 'Section / card name:\nWhat is wrong:\n(Please do not include patient data.)\n\n\n---\nApp: NurseGuide $version\nPlatform: $platform';
  }

  @override
  String get authOr => 'or';

  @override
  String get authSignInApple => 'Sign in with Apple';

  @override
  String get authSignInGoogle => 'Sign in with Google';

  @override
  String get authSocialFailed =>
      'Couldn’t sign in. Check the connection and try again, or use the email code.';

  @override
  String get authSocialEmailUnverified =>
      'This account’s email isn’t verified, so it can’t be used to sign in. Use the email code instead.';

  @override
  String get authSocialEmailRequired =>
      'This account didn’t share an email address. Use the email code instead.';

  @override
  String get accountDeleteAppleNote =>
      'You signed in with Apple, so Apple will ask you to confirm before the account is deleted. This also disconnects NurseGuide from your Apple ID.';

  @override
  String get accountDeleteAppleCancelled =>
      'Nothing was deleted: Apple confirmation was cancelled.';

  @override
  String get admPanelAccess =>
      'Access: the owner email (ADMIN_EMAILS) and an email code. The server re-checks every request.';

  @override
  String get admOverview => 'Overview';

  @override
  String admOverviewSub(int total, int online, int week) {
    return 'Registered: $total · online: $online · new in 7 days: $week';
  }

  @override
  String get admComplaintsRow => 'In-app complaints';

  @override
  String admComplaintsRowSub(int count) {
    return 'Open: $count';
  }

  @override
  String admEmailNote(String email) {
    return 'Complaints and questions sent by email arrive at $email — check them in the mailbox (they do not reach the app).';
  }

  @override
  String get admUsersSub => 'Search by email or nickname, role, suspension';

  @override
  String get admAuditSub => 'Every admin action is recorded';

  @override
  String get admStoreTitle => 'Downloads and sales';

  @override
  String get admStoreBody =>
      'The server cannot see store downloads — App Store Connect and Google Play Console show them. The app has no analytics SDK (privacy policy). Numbers in this panel are accounts that confirmed their email.';

  @override
  String get admSales => 'Sales: 0 (no payments yet)';

  @override
  String get admAppStoreConnect => 'App Store Connect';

  @override
  String get admPlayConsole => 'Google Play Console';

  @override
  String get admStatsAccounts => 'Accounts';

  @override
  String get admOnlineNow => 'Online now (5 minutes)';

  @override
  String get admSuspendedAccounts => 'Suspended accounts';

  @override
  String get admStatsActiveNote =>
      'Online and active — accounts that made a request to the server. Only the minute and day are stored; no IP or device.';

  @override
  String get admChartTitle => 'New accounts — last 14 days';

  @override
  String admChartBar(String date, int count) {
    return '$date: $count new accounts';
  }

  @override
  String admChartTotal(int count) {
    return 'Total in 14 days: $count';
  }

  @override
  String get admStatsObjects => 'Main objects';

  @override
  String get admStatsGroupsCount => 'Groups';

  @override
  String get admStatsTeachers => 'Registered teachers';

  @override
  String get admStatsStudents => 'Students in groups';

  @override
  String get admStatsAssignments => 'Test sessions';

  @override
  String get admStatsResults => 'Test results';

  @override
  String get admStatsComplaintsOpen => 'Open complaints';

  @override
  String get admStatsComplaintsResolved => 'Resolved complaints';

  @override
  String get admStatsAwaiting => 'Messages: awaiting reply';

  @override
  String admStatsUpdated(String time) {
    return 'Updated: $time';
  }

  @override
  String get admComplaintsTitle => 'In-app complaints';

  @override
  String get admApple12Note =>
      'Handle reports of objectionable content promptly (Apple 1.2 requires timely action; target — 24 hours).';

  @override
  String get admFilterOpen => 'Open';

  @override
  String get admFilterResolved => 'Resolved';

  @override
  String get admAllKinds => 'All types';

  @override
  String get complaintKindComplaint => 'Complaint';

  @override
  String get complaintKindInappropriate => 'Inappropriate content';

  @override
  String get complaintKindBug => 'Bug';

  @override
  String get complaintKindAd => 'Advertising';

  @override
  String get complaintKindOther => 'Other';

  @override
  String get admComplaintsEmpty => 'No complaints in this list';

  @override
  String get admComplaintAnon => 'Guest (no account)';

  @override
  String admComplaintFrom(String email) {
    return 'From: $email';
  }

  @override
  String admComplaintTarget(String ref) {
    return 'Reference: $ref';
  }

  @override
  String get admComplaintNote => 'Admin note';

  @override
  String get admComplaintNoteHint => 'What was done? (admins only)';

  @override
  String get admComplaintSaveNote => 'Save note';

  @override
  String get admComplaintResolve => 'Mark resolved';

  @override
  String get admComplaintReopen => 'Reopen';

  @override
  String admComplaintResolvedOn(String date) {
    return 'Resolved: $date';
  }

  @override
  String get admSaved => 'Saved';

  @override
  String get admSearchModeEmail => 'Email';

  @override
  String get admSearchModeName => 'Nickname';

  @override
  String get admSearchEmail => 'Full email (exact match)';

  @override
  String get admSearchName => 'Group nickname (at least 2 characters)';

  @override
  String get admUsersSearchNote =>
      'Emails are not stored in plain text: an account is found only by its full email and is shown masked.';

  @override
  String get admSearch => 'Search';

  @override
  String get admStatusActive => 'Active';

  @override
  String get admStatusSuspended => 'Suspended';

  @override
  String get admUserAdminTag => 'Admin';

  @override
  String get admUserTitle => 'User';

  @override
  String get admUserRole => 'Role';

  @override
  String get admRoleChanged => 'Role changed';

  @override
  String get admRoleSelfNote =>
      'You cannot change your own role or status here.';

  @override
  String admUserFacts(int owned, int joined, int threads, int complaints) {
    return 'Groups: $owned (teacher) · $joined (student) · messages: $threads · complaints: $complaints';
  }

  @override
  String get admAccountTitle => 'Account status';

  @override
  String get admAccountSuspend => 'Suspend account';

  @override
  String get admAccountSuspendTitle => 'Suspend the account?';

  @override
  String get admAccountSuspendBody =>
      'The user is signed out on all devices and cannot sign in again (email code, Google, Apple). The app shows them the contact address. The action is logged.';

  @override
  String get admAccountReactivate => 'Reactivate';

  @override
  String get admAccountReactivateTitle => 'Reactivate the account?';

  @override
  String get admAccountReactivateBody =>
      'The user can sign in again. The action is logged.';

  @override
  String get admAccountAdminNote => 'An admin account cannot be suspended.';

  @override
  String get admErrOwner => 'The owner account cannot be suspended.';

  @override
  String get admErrSelf => 'You cannot apply this action to yourself.';

  @override
  String get admErrName => 'Nickname must be 2–40 characters.';

  @override
  String admAuditBy(String actor) {
    return 'By: $actor';
  }

  @override
  String get admAuditSystem => 'System';

  @override
  String get adminActionAccountDeleted => 'Account deleted';

  @override
  String get adminActionMfa => '2FA enabled';

  @override
  String get adminActionTeacher => 'Teacher registered';

  @override
  String get adminActionRoleChanged => 'Role changed';

  @override
  String get adminActionAccountSuspended => 'Account suspended';

  @override
  String get adminActionAccountReactivated => 'Account reactivated';

  @override
  String get adminActionComplaintNote => 'Complaint note added';

  @override
  String get adminActionComplaintResolved => 'Complaint resolved';

  @override
  String get adminActionComplaintReopened => 'Complaint reopened';

  @override
  String get adminActionIdentityLinked => 'Sign-in method linked';

  @override
  String get complaintFormTitle => 'Send a complaint in the app';

  @override
  String get complaintFormBody =>
      'Tell us about objectionable content, a bug or another problem — the NurseGuide team will review it (usually within 24 hours).';

  @override
  String get complaintKindLabel => 'Type';

  @override
  String get complaintText => 'Text';

  @override
  String get complaintTextHint => 'What happened? Which screen or post?';

  @override
  String complaintTarget(String ref) {
    return 'Reference: $ref';
  }

  @override
  String get complaintSend => 'Send complaint';

  @override
  String get complaintSent => 'Sent. Thank you — we will review it.';

  @override
  String get complaintTooShort => 'Write at least 5 characters.';

  @override
  String complaintRateLimited(int minutes) {
    return 'Too many complaints: up to 5 per hour. Try again in $minutes min.';
  }

  @override
  String get complaintAnonNote =>
      'Without an account we cannot reply to you. If you need a reply, sign in or send an email.';

  @override
  String get complaintPhiNote =>
      'Do not include patient names or other personal data.';

  @override
  String get complaintFailed =>
      'Not sent. Check your connection and try again.';

  @override
  String authAccountSuspended(String email) {
    return 'Your account has been suspended. If you have questions, write to: $email';
  }

  @override
  String get admSectionComplaints => 'Complaints';

  @override
  String get lectureSearchLabel => 'Search presentations';

  @override
  String get lectureSearchHint => 'Topic or slide title';

  @override
  String get lectureFilterAll => 'All';

  @override
  String get lectureFilterProtocols => 'Practical protocols';

  @override
  String lectureFilterModule(int n) {
    return 'Module $n';
  }

  @override
  String get lectureLangAll => 'All languages';

  @override
  String lectureDecksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count presentations',
      one: '$count presentation',
    );
    return '$_temp0';
  }

  @override
  String lectureSlidesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slides',
      one: '$count slide',
    );
    return '$_temp0';
  }

  @override
  String lectureSlidesMatch(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count slides match',
      one: '$count slide matches',
    );
    return '$_temp0';
  }

  @override
  String lectureMoreSlides(int count) {
    return '+$count more';
  }

  @override
  String lectureResultsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count presentations found',
      one: '$count presentation found',
    );
    return '$_temp0';
  }

  @override
  String get lectureNoResultsTitle => 'Nothing found';

  @override
  String get lectureNoResultsBody =>
      'Try another word or filter. Search works in Uzbek (Latin or Cyrillic), Russian and English.';

  @override
  String get lectureClearFilters => 'Clear search and filters';

  @override
  String lectureLangFallback(String wanted, String shown) {
    return 'This presentation is not available in $wanted; shown in $shown';
  }

  @override
  String get lectureDeckLoadFailed => 'Could not open the presentation';

  @override
  String get lectureFullscreen => 'Full screen';

  @override
  String get lectureFullscreenExit => 'Exit full screen';

  @override
  String get lectureSourcesTitle => 'Slide sources';

  @override
  String get lectureSourcesOpen => 'Show full sources';

  @override
  String lectureSourcesCount(int count) {
    return 'Sources: $count';
  }

  @override
  String lectureSourceLocator(String loc) {
    return 'Section/page: $loc';
  }

  @override
  String get lectureSourcesHint =>
      'The full list is on the last “References” slide.';

  @override
  String get lectureRotateTitle => 'Rotate the screen to landscape?';

  @override
  String get lectureRotateBody =>
      'In landscape the slide fills the whole screen. “No” keeps the current orientation.';

  @override
  String get lectureRotateCastBody =>
      'TVs and monitors are landscape, so landscape is recommended when casting.';

  @override
  String get lectureRotateYes => 'Yes';

  @override
  String get lectureRotateNo => 'No';

  @override
  String get lectureRotateRemember => 'Don’t ask again';

  @override
  String get lectureOrientationMenu => 'Screen orientation when presenting';

  @override
  String get lectureOrientationAsk => 'Always ask';

  @override
  String get lectureOrientationLandscape => 'Always landscape';

  @override
  String get lectureOrientationKeep => 'Don’t rotate';

  @override
  String get lectureMore => 'More actions';

  @override
  String get lectureCast => 'Show on TV';

  @override
  String get lectureCastTitle => 'Show on a TV or monitor';

  @override
  String get lectureCastHow =>
      'Casting uses your phone’s built-in screen mirroring: the TV shows the phone screen. In presentation mode the screen shows only the slide (no buttons) and stays on.';

  @override
  String get lectureCastStepsAndroid =>
      '1. Connect the phone and the TV to the same Wi‑Fi network.\n2. Open “Cast screen” (Cast, Smart View, Miracast — the name depends on the phone) and pick the TV.\n3. Come back to the app and tap “Start presentation”.';

  @override
  String get lectureCastStepsIos =>
      '1. Connect the iPhone/iPad and the TV (Apple TV or AirPlay-compatible) to the same Wi‑Fi network.\n2. Open Control Center (swipe down from the top-right corner) → Screen Mirroring → pick the TV.\n3. Come back to the app and tap “Start presentation”.';

  @override
  String get lectureCastOpenSettings => 'Open cast settings';

  @override
  String get lectureCastSettingsFailed =>
      'Could not open the settings — find “Cast screen” in Settings or in the quick settings panel.';

  @override
  String get lectureCastStart => 'Start presentation';

  @override
  String get lecturePresenter => 'Presenter view';

  @override
  String get lecturePresenterNext => 'Next slide';

  @override
  String get lecturePresenterLast => 'This is the last slide';

  @override
  String get lecturePresenterTimer => 'Time';

  @override
  String get lecturePresenterReset => 'Reset timer';

  @override
  String get lecturePresenterNote =>
      'Presenter view is on this device only. When mirroring, the TV shows the same view — use “Full screen” for the audience.';

  @override
  String get topicTestAction => 'Topic test';

  @override
  String get topicTestPreparing =>
      'Questions for this topic are being prepared';

  @override
  String get topicTestPreparingShort => 'Questions in preparation';

  @override
  String topicTestPreparingBody(int count) {
    return 'Only verified questions go into the test. This topic has $count so far — at least 3 are needed.';
  }

  @override
  String topicTestIntro(int count) {
    return '$count questions · the correct answer and explanation after each one';
  }

  @override
  String get topicTestSavedNote =>
      'If you leave, your answers are kept — you will continue from the same place.';

  @override
  String get topicTestSourcesNote =>
      'Questions come only from verified sources: official certification questions with a confirmed key and practice questions with a cited source.';

  @override
  String get topicTestStart => 'Start the test';

  @override
  String topicTestBest(int score, int total) {
    return 'Best score: $score/$total';
  }

  @override
  String topicTestBadgeLabel(int score, int total) {
    return 'Topic test, best score $score of $total';
  }

  @override
  String get topicTestRetake => 'Retake';

  @override
  String get topicTestNextTopic => 'Next topic';

  @override
  String get topicTestOpenSlide => 'View slide';

  @override
  String get topicTestOpenDeckStart => 'Open the presentation from the start';

  @override
  String get topicTestHistory => 'Result history';

  @override
  String get topicTestAssign => 'Assign to a group';

  @override
  String topicTestLimitBody(int minutes) {
    return 'Each student gets $minutes min from the moment they start. When time runs out, answers are submitted automatically.';
  }

  @override
  String get topicTestLimitNoneBody =>
      'No time limit — students can take the test any time before the deadline.';

  @override
  String get topicTestOpenFor => 'How long the test stays open';

  @override
  String get topicTestAssignSub =>
      'Students join by QR or code; you see the results';

  @override
  String get topicTestSelf => 'Try it myself';

  @override
  String get topicTestSelfSub =>
      'Saved only on your device; not sent to students';

  @override
  String get topicTestAssignIntro =>
      'Students take the test on their own phones before the deadline; the score is calculated on the server.';

  @override
  String get topicTestGroups => 'Groups';

  @override
  String get topicTestNoGroups => 'You have no groups yet';

  @override
  String get topicTestNoGroupsBody =>
      'Create a group and invite students first — then assign the test from here.';

  @override
  String get topicTestPickGroup => 'Pick at least one group';

  @override
  String get topicTestReveal => 'Correct answers shown to students';

  @override
  String get topicTestRevealNow => 'Right after submitting';

  @override
  String get topicTestRevealAfterDue => 'After the deadline';

  @override
  String get topicTestRevealNeedsDue =>
      'Choose a deadline to use “After the deadline”';

  @override
  String topicTestSent(int count) {
    return 'Test sent to groups: $count';
  }

  @override
  String topicTestTitle(String title) {
    return 'Topic test: $title';
  }

  @override
  String get topicTestSentList => 'Sent tests';

  @override
  String topicTestAnswersLater(String date) {
    return 'Correct answers open after the deadline ($date) or when the teacher closes the test';
  }

  @override
  String get topicTestDistribution => 'Score distribution';

  @override
  String get topicTestHardest => 'Hardest questions';

  @override
  String get topicTestAssignedTitle => 'Assigned tests';

  @override
  String get topicTestMenu => 'Actions';

  @override
  String get topicTestOpenLecture => 'Open the presentation';

  @override
  String get topicTestCreateGroup => 'Create a group';

  @override
  String topicTestStudents(int count) {
    return 'Students: $count';
  }

  @override
  String topicTestReworkMistakes(int count) {
    return 'Review mistakes · $count';
  }

  @override
  String get admDeleteTitle => 'Delete account';

  @override
  String get admDeleteNote =>
      'For deletion requests received by email (completed within 30 days). To confirm, enter the user\'s full email — the server checks that it belongs to exactly this account. The account, group memberships, support threads and sign-in methods are deleted permanently; for Sign in with Apple users the server attempts to revoke the Apple token. This cannot be undone; the action is logged.';

  @override
  String get admDeleteEmail => 'User\'s full email';

  @override
  String get admDeleteButton => 'Delete account permanently';

  @override
  String get admDeleteConfirmTitle => 'Delete this account permanently?';

  @override
  String admDeleteConfirmBody(String email) {
    return 'The account $email and all data linked to it will be deleted. This cannot be undone.';
  }

  @override
  String get admDeleteDone => 'Account deleted';

  @override
  String get admDeleteMismatch =>
      'This email does not belong to this account — check it and try again.';

  @override
  String get examPracticeNotice =>
      'The result is for internal practice, not an official grade.';

  @override
  String get classesPasteLink => 'Paste link';

  @override
  String get classesPasteNoCode =>
      'No invite code in the copied text. Copy the link or code your teacher sent.';

  @override
  String get classesScanTip =>
      'Scan the QR code with your phone camera and tap “Open in app” on the page that opens — the code fills in by itself.';

  @override
  String get qrScanAction => 'Scan QR code';

  @override
  String get qrScanHint =>
      'Fit the group or test QR code from your teacher inside the frame';

  @override
  String get qrScanTorchOn => 'Turn on flashlight';

  @override
  String get qrScanTorchOff => 'Turn off flashlight';

  @override
  String get qrScanTypeCode => 'Type or paste the code';

  @override
  String get qrScanNotInvite => 'This QR code is not a NurseGuide group invite';

  @override
  String get qrScanDeniedTitle => 'Camera access is off';

  @override
  String get qrScanDeniedBody =>
      'To read the QR code, allow NurseGuide to use the camera in Settings. The camera image is read on the phone only — it is not saved or sent. Or type the code yourself or paste the link.';

  @override
  String get qrScanOpenSettings => 'Open settings';

  @override
  String get qrScanFailedTitle => 'Couldn’t open the camera';

  @override
  String get qrScanFailedBody =>
      'Type the code yourself or paste the link from your teacher.';

  @override
  String get qrScanStarting => 'Opening camera…';

  @override
  String get classesJoinOpensTest =>
      'After joining, your teacher’s test opens right away.';

  @override
  String get classesJoinSignInTitle => 'Sign in to join the group';

  @override
  String get classesJoinSignInBody =>
      'With Google, Apple or an email code — it takes a minute. Your result reaches the teacher through this account; the invite code is kept.';

  @override
  String get classesNicknameTaken =>
      'This nickname is taken in the group — choose another.';

  @override
  String get classesNicknameAbusive =>
      'The nickname contains an inappropriate word — choose another.';

  @override
  String get classesTestQr => 'Test QR';

  @override
  String get classesTestQrBody =>
      'Students scan → sign in → nickname → this test opens. Results on this page update by themselves.';

  @override
  String get classesInviteLink => 'Copy link';

  @override
  String get classesLiveNote =>
      'Results refresh every 10 seconds. Pull down to refresh now.';

  @override
  String get boardOpen => 'Big screen';

  @override
  String get boardJoined => 'In group';

  @override
  String get boardStarted => 'Solving';

  @override
  String get boardSubmitted => 'Submitted';

  @override
  String get boardStatusWaiting => 'Waiting';

  @override
  String get boardStatusSolving => 'Solving…';

  @override
  String get boardScan => 'Scan to join';

  @override
  String get boardAnswersAfterClose =>
      'Correct answers appear after the test is closed.';

  @override
  String get boardEmpty => 'Nobody yet — scan the QR.';

  @override
  String get boardClose => 'Exit big screen';

  @override
  String get actionClose => 'Close';

  @override
  String get variantToggle => 'Different questions for each student';

  @override
  String variantOnBody(int pool, int n) {
    return 'Each student gets $n of the topic’s $pool questions, balanced across sub-topics.';
  }

  @override
  String get variantOffBody =>
      'Everyone gets the same questions (in shuffled order).';

  @override
  String variantDisabledBody(int pool, int need) {
    return 'This topic has $pool questions — different sets need at least $need (twice the question count). Lower the question count.';
  }

  @override
  String get variantUnsupported =>
      'Variant tests are not supported by this server.';

  @override
  String variantPoolTitle(int pool) {
    return 'Question pool ($pool)';
  }

  @override
  String get variantLabel => 'Variant test';

  @override
  String variantPerStudent(int n, int pool) {
    return '$n questions per student from a pool of $pool';
  }

  @override
  String variantReceived(int n) {
    return 'Given to $n students';
  }

  @override
  String get homeResumeCta => 'Continue';

  @override
  String homeResumeBody(String title) {
    return 'Last opened: $title';
  }

  @override
  String get helpTitle => 'Help & contact';

  @override
  String get helpSub =>
      'In the app or by email — question, suggestion, complaint';

  @override
  String get helpIntro =>
      'Choose what suits you: an in-app message thread (the reply arrives here) or email (complaint, privacy request).';

  @override
  String get classesNicknameInvalid =>
      'A nickname may contain only letters, digits, spaces and . _ \' -, and must start and end with a letter or digit (no emoji or symbols like !?@).';

  @override
  String get classesGroupFull =>
      'The group is full (200 people) — tell your teacher.';

  @override
  String get classesCodeAmbiguous =>
      'Codes never contain 0, O, 1 or I. Check the code with your teacher or scan the QR.';

  @override
  String get classesOwnGroupTitle => 'You are this group\'s teacher';

  @override
  String get classesOwnGroupBody =>
      'This account created the group, so it can\'t join it as a student (switching the role in Profile doesn\'t change that). To try it as a student, sign in with another account or take the test in student view.';

  @override
  String get classesOwnGroupOpen => 'Open as teacher';

  @override
  String get classesSwitchAccount => 'Sign in with another account';

  @override
  String get classesPreviewAsStudent => 'Try as a student';

  @override
  String get classesPreviewNote =>
      'Trial mode: answers are not sent to the server and don\'t appear in the results.';

  @override
  String classesPreviewResult(int correct, int total) {
    return 'Trial finished: $correct / $total correct. Nothing was submitted.';
  }

  @override
  String get classesGiveTopicTest => 'Give a topic test';

  @override
  String get classesGiveTopicTestSub =>
      'Pick a topic — the next page sets the number of questions, variants, due date and when answers open.';

  @override
  String get classesTopicSearchHint => 'Search topics (e.g. anaemia)';

  @override
  String get classesTopicNoMatch => 'No topic with a ready test found';

  @override
  String classesTopicQuestions(int count) {
    return '$count questions';
  }

  @override
  String examDeadlineAt(String date) {
    return 'Due: $date';
  }

  @override
  String get classesScanAskNick =>
      'Before joining, enter a nickname — your teacher sees your result under it (optional: leave empty to show your seat number). Then tap “Join”.';

  @override
  String get classesMyNickname => 'My nickname';

  @override
  String get classesNoNickname => 'None — your teacher sees your seat number';

  @override
  String get classesNicknameSaved => 'Nickname saved';

  @override
  String get classesNicknameNote =>
      'Don\'t use your real name. Leave empty to show your seat number.';

  @override
  String get rolesTeacherRegisterNote =>
      '“Continue” registers your account as a teacher: you manage only the groups you create and see their results (not admin rights).';

  @override
  String get rolesTeacherSignInNote =>
      'The teacher role is for signed-in accounts only. Sign in (email, Google or Apple), then choose the role in Profile.';

  @override
  String get classesGiveGeneralTest => 'Give a general test';

  @override
  String get generalTestSub => 'From several topics — up to 50 questions';

  @override
  String get generalTestIntro =>
      'Pick topics — questions are spread evenly across them. Students take the test on their phones; the server scores it.';

  @override
  String get generalTestSources => 'Where questions come from';

  @override
  String get generalTestSearchHint => 'Search topics (e.g. anaemia)';

  @override
  String get generalSourceToifa => 'Category exam questions';

  @override
  String get generalSourceToifaSub => 'Official list, keys checked';

  @override
  String get generalSourceLecture => 'Lecture topics';

  @override
  String get generalSourceLectureSub => 'A whole module or single days';

  @override
  String get generalSourcePack => 'By practice questions';

  @override
  String get generalSourcePackSub => 'Questions from topic groups';

  @override
  String get generalSourceToifaShort => 'Category';

  @override
  String get generalSourceLectureShort => 'Lectures';

  @override
  String get generalSourcePackShort => 'Practice';

  @override
  String get generalSelectAll => 'Select all';

  @override
  String get generalAllShort => 'all';

  @override
  String generalDays(int count) {
    return 'Days · $count';
  }

  @override
  String generalSelected(int topics, int questions) {
    return 'Selected: $topics topics · $questions questions';
  }

  @override
  String get generalPickTopic => 'Pick at least one topic';

  @override
  String generalTestTitle(String topics) {
    return 'General test: $topics';
  }

  @override
  String get generalTestNameHint => 'E.g. Midterm 1';

  @override
  String get navProcedures => 'Procedures';

  @override
  String get navWorkplace => 'Workplace';

  @override
  String get roleNurse => 'Nurse';

  @override
  String get roleNurseDesc => 'Certification and procedures';

  @override
  String get procTitle => 'Procedures';

  @override
  String get procSub => 'Step-by-step practical guides';

  @override
  String get procEmptyTitle => 'Procedures';

  @override
  String get procEmptyBody => 'The procedure list did not load.';

  @override
  String get workDirTitle => 'Your work area';

  @override
  String get workDirHint => 'Daily questions are matched to this area.';

  @override
  String get workDirPick =>
      'Choose your work area — daily questions will follow it.';

  @override
  String get workDirNursing => 'Nursing';

  @override
  String get workDirHigher => 'Higher nursing';

  @override
  String get workDirPatronage => 'Patronage';

  @override
  String get workTodayOwn => 'Today: questions from your work area';

  @override
  String get workTodayGeneral => 'Today: general questions (for every area)';

  @override
  String get workTodayMixed => 'Today: mixed — 3 from your area, 2 general';

  @override
  String get workPlan =>
      'Weekly plan: Monday–Thursday your area, Friday–Saturday general questions, Sunday mixed.';

  @override
  String get procGoal => 'Purpose';

  @override
  String get procIndications => 'Indications';

  @override
  String get procContra => 'Contraindications';

  @override
  String get procEquipment => 'Equipment';

  @override
  String get procSteps => 'Steps';

  @override
  String get procChecklist => 'Checklist';

  @override
  String get procRisks => 'Risks and complications';

  @override
  String procStepsCount(int count) {
    return '$count steps';
  }

  @override
  String get procSourceNote =>
      'Based on the textbook. Compare with your facility\'s current instruction and Ministry of Health orders.';

  @override
  String get procNotFound => 'Procedure not found';

  @override
  String get glossaryTitle => 'Glossary';

  @override
  String get glossarySub => 'Exact definitions from the textbook';

  @override
  String glossaryCount(int count) {
    return '$count terms';
  }

  @override
  String get glossarySearch => 'Search terms';

  @override
  String get glossaryNothing => 'Nothing found';

  @override
  String get refUzbekOnly =>
      'Text is in Uzbek (from the textbook); translation comes in a later update.';

  @override
  String get workVitalsTitle => 'Vital signs';

  @override
  String get workVitalTemp => 'Body temperature';

  @override
  String get workVitalPulse => 'Pulse';

  @override
  String get workVitalResp => 'Respiratory rate';

  @override
  String get workVitalPerMin => 'per minute';

  @override
  String get workVitalSource =>
      'Source: Inomov Q.S., “Fundamentals of Nursing” (Hamshiralik ishi asoslari), 4th ed., Tashkent, 2007, pp. 170/173/177 (PDF).';

  @override
  String get litTitle => 'References';

  @override
  String get litSub => 'Sources the questions and reference material rely on';

  @override
  String get litNote =>
      'Book text is not stored in the app: material is in our own words with the source shown under each item.';

  @override
  String get litTextbooks => 'Textbooks';

  @override
  String get litOfficial => 'Official documents';

  @override
  String get litOpen => 'Openly licensed sources';

  @override
  String get litOther => 'Other international sources';

  @override
  String get litMainBadge => 'Main';

  @override
  String get litRelies => 'Used by';

  @override
  String litQuestionsN(int count) {
    return '$count questions';
  }

  @override
  String litProceduresN(int count) {
    return '$count procedures';
  }

  @override
  String litTermsN(int count) {
    return '$count terms';
  }

  @override
  String get litTopics => 'Topics';

  @override
  String get litOpenLink => 'Open';

  @override
  String litMore(int count) {
    return 'and $count more';
  }

  @override
  String get litLicense => 'Licence';

  @override
  String get litDetailEmpty => 'No material relies on this source.';

  @override
  String get workTitle => 'Workplace';

  @override
  String get workSub => 'Quick reference for your shift';

  @override
  String get workEmptyTitle => 'Coming soon';

  @override
  String get workEmptyBody =>
      'In the next update: sterilisation regimes, an infection-control reference and calculators. Figures come only from the sanitary rules (SanQvaM) and official sources, with the source shown.';

  @override
  String get hubGoLearn => 'Go to Learn';

  @override
  String get homeHeroNurseTitle => 'Prepare for certification with confidence';

  @override
  String get homeHeroNurseBody =>
      'Certification questions, oral answers and daily practice in one place.';

  @override
  String get homeHeroNurseCta => 'Certification prep';

  @override
  String get homeTileToifa => 'Test, oral ticket and mistakes';

  @override
  String get homeTileProcedures => 'Step-by-step guides';

  @override
  String get homeTileWorkplace => 'Quick reference for your shift';

  @override
  String get featureLessons => 'Lessons';

  @override
  String get homeTileLessons => 'Lecture decks';

  @override
  String get catFundamentals => 'Fundamentals';

  @override
  String get catClinicalNursing => 'Clinical nursing';

  @override
  String get catProcedures => 'Procedures';

  @override
  String get catPharmacology => 'Pharmacology';

  @override
  String get catExams => 'Exams and certification';

  @override
  String get kindGuideline => 'Guideline';

  @override
  String get rolesTeacherLocked => 'For signed-in accounts only';

  @override
  String get rolesTeacherFailed =>
      'The server did not confirm the teacher role. Check your connection and try again.';

  @override
  String get toifaTopicOther => 'Other';

  @override
  String get lectureUnverifiedNotice =>
      'This deck has not been verified yet — review the content before class';

  @override
  String get classroomKindProtocol => 'Deck';

  @override
  String get lectureProtocols => 'Ready decks';

  @override
  String get quizEmptyTitle => 'Questions are coming soon';

  @override
  String get quizEmptyBody =>
      'Practice questions will appear here once they are verified.';

  @override
  String get profileFontSize => 'Text size';

  @override
  String get fontSizeSmall => 'Small';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get fontSizeLarge => 'Large';

  @override
  String get fontSizeXLarge => 'Extra large';

  @override
  String get profileFeedback => 'Sound and haptics';

  @override
  String get profileHaptics => 'Haptic feedback';

  @override
  String get profileSounds => 'Sounds';

  @override
  String get welcomeBenefitNurseTitle => 'For nurses';

  @override
  String get welcomeBenefitNurseBody =>
      'Certification tests, oral tickets and procedures';

  @override
  String get welcomeBenefitStudentTitle => 'For students';

  @override
  String get welcomeBenefitStudentBody => 'Lessons, explained tests and exams';

  @override
  String get welcomeBenefitTeacherTitle => 'For teachers';

  @override
  String get welcomeBenefitTeacherBody => 'Groups, assignments and big screen';

  @override
  String get actionSave => 'Save';

  @override
  String get actionUnsave => 'Remove from saved';

  @override
  String get toifaEmptyTitle => 'Certification questions are coming soon';

  @override
  String get toifaEmptyBody =>
      'Official list questions will appear here once verified: test, oral ticket and mistakes review.';
}
