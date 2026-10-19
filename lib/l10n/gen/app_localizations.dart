import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'FOR NURSES'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navLibrary;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings'**
  String get actionProfile;

  /// No description provided for @actionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get actionLanguage;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionRetry;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get linkCopied;

  /// No description provided for @notAvailableYet.
  ///
  /// In en, this message translates to:
  /// **'Not available yet'**
  String get notAvailableYet;

  /// No description provided for @debugBuildBadge.
  ///
  /// In en, this message translates to:
  /// **'DEBUG · DEMO ADAPTERS'**
  String get debugBuildBadge;

  /// No description provided for @welcomeEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Your nursing companion'**
  String get welcomeEyebrow;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Nursing.\nClear and practical.'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Certification, procedures and learning in one place.'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started / sign up'**
  String get welcomeGetStarted;

  /// No description provided for @welcomeGuest.
  ///
  /// In en, this message translates to:
  /// **'Explore as guest'**
  String get welcomeGuest;

  /// No description provided for @welcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get welcomeSignIn;

  /// No description provided for @welcomeGuestNote.
  ///
  /// In en, this message translates to:
  /// **'Guest mode is just a preview. Tests, practice, daily questions and groups open after you sign up.'**
  String get welcomeGuestNote;

  /// No description provided for @stateLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get stateLoading;

  /// No description provided for @homeTileTests.
  ///
  /// In en, this message translates to:
  /// **'Topic tests with explanations'**
  String get homeTileTests;

  /// No description provided for @homeTileSaved.
  ///
  /// In en, this message translates to:
  /// **'Quick access to bookmarks'**
  String get homeTileSaved;

  /// No description provided for @homeTileExam.
  ///
  /// In en, this message translates to:
  /// **'Timed practice exam'**
  String get homeTileExam;

  /// No description provided for @homeTileClasses.
  ///
  /// In en, this message translates to:
  /// **'Students and assignments'**
  String get homeTileClasses;

  /// No description provided for @homeTileLecture.
  ///
  /// In en, this message translates to:
  /// **'Slides and screen casting'**
  String get homeTileLecture;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get authTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account with email.'**
  String get authSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get authEmailHint;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authEmailInvalid;

  /// No description provided for @authConsent.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms of use and privacy policy.'**
  String get authConsent;

  /// No description provided for @authConsentRequired.
  ///
  /// In en, this message translates to:
  /// **'Accept the terms to continue.'**
  String get authConsentRequired;

  /// No description provided for @authGetCode.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get authGetCode;

  /// No description provided for @authViewTerms.
  ///
  /// In en, this message translates to:
  /// **'View terms'**
  String get authViewTerms;

  /// No description provided for @authDemoNotice.
  ///
  /// In en, this message translates to:
  /// **'Debug build: demo sign-in. No email is sent; the code is shown on the next screen.'**
  String get authDemoNotice;

  /// No description provided for @authUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Email sign-in isn\'t connected yet'**
  String get authUnavailableTitle;

  /// No description provided for @authUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'All reading content is available to guests. Sign-in will be enabled once the email service is configured.'**
  String get authUnavailableBody;

  /// No description provided for @authContinueGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get authContinueGuest;

  /// No description provided for @authRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again in {seconds} s.'**
  String authRateLimited(int seconds);

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Check the connection and try again.'**
  String get authGenericError;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get otpTitle;

  /// No description provided for @otpCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get otpCodeLabel;

  /// No description provided for @otpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerify;

  /// No description provided for @otpDemoCode.
  ///
  /// In en, this message translates to:
  /// **'Demo code: {code}. No email was sent (debug build only).'**
  String otpDemoCode(String code);

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code. Attempts left: {attempts}.'**
  String otpInvalid(int attempts);

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'The code has expired. Request a new one.'**
  String get otpExpired;

  /// No description provided for @otpTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Request a new code.'**
  String get otpTooManyAttempts;

  /// No description provided for @otpNoActiveCode.
  ///
  /// In en, this message translates to:
  /// **'No active code. Request a new one.'**
  String get otpNoActiveCode;

  /// No description provided for @otpFormat.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code.'**
  String get otpFormat;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResend;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds} s'**
  String otpResendIn(int seconds);

  /// No description provided for @otpValidFor.
  ///
  /// In en, this message translates to:
  /// **'The code is valid for {minutes} min.'**
  String otpValidFor(int minutes);

  /// No description provided for @otpResent.
  ///
  /// In en, this message translates to:
  /// **'A new code was issued.'**
  String get otpResent;

  /// No description provided for @rolesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your workspace'**
  String get rolesTitle;

  /// No description provided for @rolesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your main role. You can change it later.'**
  String get rolesSubtitle;

  /// No description provided for @rolesNote.
  ///
  /// In en, this message translates to:
  /// **'The role only adapts the home screen. It doesn\'t grant access to other people\'s classes or data.'**
  String get rolesNote;

  /// No description provided for @roleStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get roleStudent;

  /// No description provided for @roleStudentDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn, practice and prepare'**
  String get roleStudentDesc;

  /// No description provided for @roleTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get roleTeacher;

  /// No description provided for @roleTeacherDesc.
  ///
  /// In en, this message translates to:
  /// **'Groups and assignments'**
  String get roleTeacherDesc;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Knowledge. Confidence. Practice.'**
  String get homeTitle;

  /// No description provided for @homeHeroStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn lessons with understanding'**
  String get homeHeroStudentTitle;

  /// No description provided for @homeHeroStudentBody.
  ///
  /// In en, this message translates to:
  /// **'Topic → test → review.'**
  String get homeHeroStudentBody;

  /// No description provided for @homeHeroStudentCta.
  ///
  /// In en, this message translates to:
  /// **'Start daily questions'**
  String get homeHeroStudentCta;

  /// No description provided for @homeHeroTeacherTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn knowledge into teaching'**
  String get homeHeroTeacherTitle;

  /// No description provided for @homeHeroTeacherBody.
  ///
  /// In en, this message translates to:
  /// **'Groups, explained questions and timed assignments.'**
  String get homeHeroTeacherBody;

  /// No description provided for @homeHeroTeacherCta.
  ///
  /// In en, this message translates to:
  /// **'Open classes'**
  String get homeHeroTeacherCta;

  /// No description provided for @featureTests.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get featureTests;

  /// No description provided for @featureSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get featureSaved;

  /// No description provided for @featureExam.
  ///
  /// In en, this message translates to:
  /// **'Exam'**
  String get featureExam;

  /// No description provided for @featureClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get featureClasses;

  /// No description provided for @testsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get testsFilterAll;

  /// No description provided for @testsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get testsEmptyTitle;

  /// No description provided for @testsClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get testsClearSearch;

  /// No description provided for @contentLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading content…'**
  String get contentLoading;

  /// No description provided for @contentErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Content couldn\'t be loaded'**
  String get contentErrorTitle;

  /// No description provided for @contentErrorBody.
  ///
  /// In en, this message translates to:
  /// **'The content pack failed verification. Unverified data is never shown.'**
  String get contentErrorBody;

  /// No description provided for @sourceNoInterpretation.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide doesn\'t interpret individual results or suggest diagnoses or doses.'**
  String get sourceNoInterpretation;

  /// No description provided for @sourceAccessed.
  ///
  /// In en, this message translates to:
  /// **'Accessed {date}'**
  String sourceAccessed(String date);

  /// No description provided for @sourceReuseRightsVerify.
  ///
  /// In en, this message translates to:
  /// **'Reuse rights: verify before distribution'**
  String get sourceReuseRightsVerify;

  /// No description provided for @sourceReuseCitationOnly.
  ///
  /// In en, this message translates to:
  /// **'Book: cited as a source only, no text copied'**
  String get sourceReuseCitationOnly;

  /// No description provided for @libTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libTitle;

  /// No description provided for @libSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your knowledge in one place.'**
  String get libSubtitle;

  /// No description provided for @libBooks.
  ///
  /// In en, this message translates to:
  /// **'Books and guides'**
  String get libBooks;

  /// No description provided for @libBooksSub.
  ///
  /// In en, this message translates to:
  /// **'Catalog of books, manuals and websites'**
  String get libBooksSub;

  /// No description provided for @libSavedSub.
  ///
  /// In en, this message translates to:
  /// **'Saved materials'**
  String get libSavedSub;

  /// No description provided for @libSources.
  ///
  /// In en, this message translates to:
  /// **'Sources and licences'**
  String get libSources;

  /// No description provided for @libSourcesSub.
  ///
  /// In en, this message translates to:
  /// **'Review and reuse conditions'**
  String get libSourcesSub;

  /// No description provided for @booksEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No books yet'**
  String get booksEmptyTitle;

  /// No description provided for @booksEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Books are added only with confirmed distribution rights. A PDF you add yourself stays for personal study and isn\'t shared.'**
  String get booksEmptyBody;

  /// No description provided for @booksCatalogNote.
  ///
  /// In en, this message translates to:
  /// **'Catalog items link to their official pages. Full text is added to the app only under an open licence or with confirmed distribution rights.'**
  String get booksCatalogNote;

  /// No description provided for @booksResetFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get booksResetFilters;

  /// No description provided for @savedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Select Save on a material page to keep it here.'**
  String get savedEmptyBody;

  /// No description provided for @sourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sources and licences'**
  String get sourcesTitle;

  /// No description provided for @sourcesContent.
  ///
  /// In en, this message translates to:
  /// **'Content sources'**
  String get sourcesContent;

  /// No description provided for @sourcesBody.
  ///
  /// In en, this message translates to:
  /// **'Every published claim links to its original source, access date, scope and review status.'**
  String get sourcesBody;

  /// No description provided for @learnTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn with insight'**
  String get learnTitle;

  /// No description provided for @learnHeroTag.
  ///
  /// In en, this message translates to:
  /// **'Topics and practice'**
  String get learnHeroTag;

  /// No description provided for @learnHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'From knowledge to practice'**
  String get learnHeroTitle;

  /// No description provided for @learnHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Pick a topic and check your knowledge with questions.'**
  String get learnHeroBody;

  /// No description provided for @learnHeroCta.
  ///
  /// In en, this message translates to:
  /// **'Choose a topic'**
  String get learnHeroCta;

  /// No description provided for @learnClassesSub.
  ///
  /// In en, this message translates to:
  /// **'Teacher → assignment → student → results'**
  String get learnClassesSub;

  /// No description provided for @learnQuiz.
  ///
  /// In en, this message translates to:
  /// **'Explained quiz'**
  String get learnQuiz;

  /// No description provided for @learnQuizSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} practice question} other{{count} practice questions}}'**
  String learnQuizSub(int count);

  /// No description provided for @learnExam.
  ///
  /// In en, this message translates to:
  /// **'Exam mode'**
  String get learnExam;

  /// No description provided for @learnExamSub.
  ///
  /// In en, this message translates to:
  /// **'Time, topic and questions'**
  String get learnExamSub;

  /// No description provided for @toifaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qualification category exam prep'**
  String get toifaTitle;

  /// No description provided for @toifaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nursing qualification category'**
  String get toifaSubtitle;

  /// No description provided for @toifaEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Nurse · category'**
  String get toifaEyebrow;

  /// No description provided for @toifaEntryBody.
  ///
  /// In en, this message translates to:
  /// **'Questions from the official certification list: a 50-question test, topic practice, oral ticket and mistake review.'**
  String get toifaEntryBody;

  /// No description provided for @toifaEntryBodyShort.
  ///
  /// In en, this message translates to:
  /// **'Test, oral ticket and mistake review — based on the official list.'**
  String get toifaEntryBodyShort;

  /// No description provided for @toifaEntryTagTest.
  ///
  /// In en, this message translates to:
  /// **'Test · 50 questions'**
  String get toifaEntryTagTest;

  /// No description provided for @toifaEntryTagOral.
  ///
  /// In en, this message translates to:
  /// **'Oral · 5 questions'**
  String get toifaEntryTagOral;

  /// No description provided for @toifaEntryTestActive.
  ///
  /// In en, this message translates to:
  /// **'Test in progress: {done} / {total} answered'**
  String toifaEntryTestActive(int done, int total);

  /// No description provided for @toifaEntryTicketActive.
  ///
  /// In en, this message translates to:
  /// **'Oral ticket in progress: {done} / {total}'**
  String toifaEntryTicketActive(int done, int total);

  /// No description provided for @toifaOpen.
  ///
  /// In en, this message translates to:
  /// **'Start preparing'**
  String get toifaOpen;

  /// No description provided for @toifaContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get toifaContinue;

  /// No description provided for @toifaUzbekOnly.
  ///
  /// In en, this message translates to:
  /// **'Official text — Uzbek'**
  String get toifaUzbekOnly;

  /// No description provided for @toifaUzbekNotice.
  ///
  /// In en, this message translates to:
  /// **'The official text of the certification questions is Uzbek. With a Russian or English interface an auxiliary translation is shown; the original can be opened at any time. Scoring follows the official Uzbek text and key.'**
  String get toifaUzbekNotice;

  /// No description provided for @toifaShowOriginal.
  ///
  /// In en, this message translates to:
  /// **'Show original text'**
  String get toifaShowOriginal;

  /// No description provided for @toifaHideOriginal.
  ///
  /// In en, this message translates to:
  /// **'Hide original text'**
  String get toifaHideOriginal;

  /// No description provided for @toifaOriginalTitle.
  ///
  /// In en, this message translates to:
  /// **'Official text (Uzbek)'**
  String get toifaOriginalTitle;

  /// No description provided for @toifaTranslationAux.
  ///
  /// In en, this message translates to:
  /// **'The translation is auxiliary; scoring follows the official Uzbek text.'**
  String get toifaTranslationAux;

  /// No description provided for @toifaLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not open the question list'**
  String get toifaLoadError;

  /// No description provided for @toifaYourCategory.
  ///
  /// In en, this message translates to:
  /// **'Your category'**
  String get toifaYourCategory;

  /// No description provided for @toifaCatSecond.
  ///
  /// In en, this message translates to:
  /// **'Second category'**
  String get toifaCatSecond;

  /// No description provided for @toifaCatFirst.
  ///
  /// In en, this message translates to:
  /// **'First category'**
  String get toifaCatFirst;

  /// No description provided for @toifaCatHighest.
  ///
  /// In en, this message translates to:
  /// **'Highest category'**
  String get toifaCatHighest;

  /// No description provided for @toifaTransitionNote.
  ///
  /// In en, this message translates to:
  /// **'The category test prepares you for the qualification-category system that applies until 2030. State registration of medical staff starts on 1 July 2027; categories granted before 2030 stay valid until they expire (Presidential Decree PF-192, 10.09.2026).'**
  String get toifaTransitionNote;

  /// No description provided for @toifaCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'The oral ticket is drawn from this category’s list. Test questions are shared by all categories.'**
  String get toifaCategoryHint;

  /// No description provided for @toifaReadyTest.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get toifaReadyTest;

  /// No description provided for @toifaReadyOral.
  ///
  /// In en, this message translates to:
  /// **'Oral'**
  String get toifaReadyOral;

  /// No description provided for @toifaPrepare.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get toifaPrepare;

  /// No description provided for @toifaTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Category test'**
  String get toifaTestTitle;

  /// No description provided for @toifaTestRowSub.
  ///
  /// In en, this message translates to:
  /// **'{count} random questions · {bank} in total'**
  String toifaTestRowSub(int count, int bank);

  /// No description provided for @toifaPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Topic practice'**
  String get toifaPracticeTitle;

  /// No description provided for @toifaPracticeRowSub.
  ///
  /// In en, this message translates to:
  /// **'{count} topics · key and note right after answering'**
  String toifaPracticeRowSub(int count);

  /// No description provided for @toifaOralTitle.
  ///
  /// In en, this message translates to:
  /// **'Oral ticket'**
  String get toifaOralTitle;

  /// No description provided for @toifaOralRowSub.
  ///
  /// In en, this message translates to:
  /// **'{category}: 5 of {count} questions'**
  String toifaOralRowSub(String category, int count);

  /// No description provided for @toifaOralRowPick.
  ///
  /// In en, this message translates to:
  /// **'Choose your category first'**
  String get toifaOralRowPick;

  /// No description provided for @toifaOralRowActive.
  ///
  /// In en, this message translates to:
  /// **'In progress: {done} / {total} rated'**
  String toifaOralRowActive(int done, int total);

  /// No description provided for @toifaMistakesTitle.
  ///
  /// In en, this message translates to:
  /// **'Mistake review'**
  String get toifaMistakesTitle;

  /// No description provided for @toifaMistakesRowSub.
  ///
  /// In en, this message translates to:
  /// **'Test mistakes: {tests} · oral “didn’t know”: {oral}'**
  String toifaMistakesRowSub(int tests, int oral);

  /// No description provided for @toifaMistakesRowEmpty.
  ///
  /// In en, this message translates to:
  /// **'No mistakes yet'**
  String get toifaMistakesRowEmpty;

  /// No description provided for @toifaProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get toifaProgressTitle;

  /// No description provided for @toifaProgressRowSub.
  ///
  /// In en, this message translates to:
  /// **'Results by topic and readiness'**
  String get toifaProgressRowSub;

  /// No description provided for @toifaAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'Source and review'**
  String get toifaAboutTitle;

  /// No description provided for @toifaListSource.
  ///
  /// In en, this message translates to:
  /// **'Source: official certification question list'**
  String get toifaListSource;

  /// No description provided for @toifaAboutList.
  ///
  /// In en, this message translates to:
  /// **'The list has {tests} test and {oral} oral questions (duplicates across categories merged).'**
  String toifaAboutList(int tests, int oral);

  /// No description provided for @toifaAboutKeys.
  ///
  /// In en, this message translates to:
  /// **'The key is the answer marked in the list, and scoring follows it. NurseGuide found the key disputed in {disputed} questions and ambiguous in {ambiguous} — those show a note and source.'**
  String toifaAboutKeys(int disputed, int ambiguous);

  /// No description provided for @toifaAboutKeyless.
  ///
  /// In en, this message translates to:
  /// **'{count} questions have no key marked in the list — they are left out of tests and practice.'**
  String toifaAboutKeyless(int count);

  /// No description provided for @toifaAboutOral.
  ///
  /// In en, this message translates to:
  /// **'Oral answer plans are a study aid prepared by NurseGuide ({ready} / {total} plans with sources).'**
  String toifaAboutOral(int ready, int total);

  /// No description provided for @toifaTestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} questions · drawn from the official list'**
  String toifaTestSubtitle(int count);

  /// No description provided for @toifaFormatTitle.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get toifaFormatTitle;

  /// No description provided for @toifaFormatStep1.
  ///
  /// In en, this message translates to:
  /// **'{count} random questions out of {bank} in the list.'**
  String toifaFormatStep1(int count, int bank);

  /// No description provided for @toifaFormatStep2.
  ///
  /// In en, this message translates to:
  /// **'One answer per question; options in list order.'**
  String get toifaFormatStep2;

  /// No description provided for @toifaFormatStep3.
  ///
  /// In en, this message translates to:
  /// **'At the end: mistake review with the official key and NurseGuide note.'**
  String get toifaFormatStep3;

  /// No description provided for @toifaTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time, minutes'**
  String get toifaTimeLabel;

  /// No description provided for @toifaNoTime.
  ///
  /// In en, this message translates to:
  /// **'No time limit'**
  String get toifaNoTime;

  /// No description provided for @toifaTimeHelper.
  ///
  /// In en, this message translates to:
  /// **'No official time limit is set in the app — choose your own or leave empty.'**
  String get toifaTimeHelper;

  /// No description provided for @toifaTimeError.
  ///
  /// In en, this message translates to:
  /// **'Enter 1 to 240 minutes or leave empty'**
  String get toifaTimeError;

  /// No description provided for @toifaPassLabel.
  ///
  /// In en, this message translates to:
  /// **'Pass mark, %'**
  String get toifaPassLabel;

  /// No description provided for @toifaNoPass.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get toifaNoPass;

  /// No description provided for @toifaPassHelper.
  ///
  /// In en, this message translates to:
  /// **'This is your own threshold, not the official pass mark.'**
  String get toifaPassHelper;

  /// No description provided for @toifaPassError.
  ///
  /// In en, this message translates to:
  /// **'Enter 1 to 100 % or leave empty'**
  String get toifaPassError;

  /// No description provided for @toifaScoringNotice.
  ///
  /// In en, this message translates to:
  /// **'Scoring follows the official key — that is what the exam expects. Where the key is disputed, the results also show a NurseGuide note.'**
  String get toifaScoringNotice;

  /// No description provided for @toifaTestStart.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get toifaTestStart;

  /// No description provided for @toifaTodayEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get toifaTodayEyebrow;

  /// No description provided for @toifaTodayGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal: {count} questions or 1 ticket'**
  String toifaTodayGoal(int count);

  /// No description provided for @toifaTodayDone.
  ///
  /// In en, this message translates to:
  /// **'Today’s goal is done'**
  String get toifaTodayDone;

  /// No description provided for @toifaTodayProgress.
  ///
  /// In en, this message translates to:
  /// **'{answered}/{goal} questions'**
  String toifaTodayProgress(int answered, int goal);

  /// No description provided for @toifaTodayCorrect.
  ///
  /// In en, this message translates to:
  /// **'{percent}% correct'**
  String toifaTodayCorrect(int percent);

  /// No description provided for @toifaTodayTickets.
  ///
  /// In en, this message translates to:
  /// **'tickets: {count}'**
  String toifaTodayTickets(int count);

  /// No description provided for @toifaStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String toifaStreakDays(int count);

  /// No description provided for @toifaTodayNone.
  ///
  /// In en, this message translates to:
  /// **'No practice yet today.'**
  String get toifaTodayNone;

  /// No description provided for @toifaTodayTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow to keep your streak.'**
  String get toifaTodayTomorrow;

  /// No description provided for @toifaWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days: {values}'**
  String toifaWeekLabel(String values);

  /// No description provided for @toifaGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get toifaGoalLabel;

  /// No description provided for @toifaGoalOption.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String toifaGoalOption(int count);

  /// No description provided for @toifaGoalHint.
  ///
  /// In en, this message translates to:
  /// **'Or 1 oral ticket — whichever comes first.'**
  String get toifaGoalHint;

  /// No description provided for @toifaReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide · Qualification'**
  String get toifaReminderTitle;

  /// No description provided for @toifaReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Today’s qualification practice is waiting — {count} questions or 1 ticket'**
  String toifaReminderBody(int count);

  /// No description provided for @toifaReminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Qualification reminder'**
  String get toifaReminderChannel;

  /// No description provided for @toifaOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue tomorrow?'**
  String get toifaOfferTitle;

  /// No description provided for @toifaOfferBody.
  ///
  /// In en, this message translates to:
  /// **'Pick a reminder time. There’s no reminder on days you’ve met the goal.'**
  String get toifaOfferBody;

  /// No description provided for @toifaOfferOn.
  ///
  /// In en, this message translates to:
  /// **'We’ll remind you tomorrow at {time}.'**
  String toifaOfferOn(String time);

  /// No description provided for @toifaModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get toifaModeTitle;

  /// No description provided for @toifaModeExam.
  ///
  /// In en, this message translates to:
  /// **'Exam mode'**
  String get toifaModeExam;

  /// No description provided for @toifaModeExamSub.
  ///
  /// In en, this message translates to:
  /// **'Timed; score and mistakes at the end — like the real exam.'**
  String get toifaModeExamSub;

  /// No description provided for @toifaModePractice.
  ///
  /// In en, this message translates to:
  /// **'Practice mode — mistakes shown right away'**
  String get toifaModePractice;

  /// No description provided for @toifaModePracticeSub.
  ///
  /// In en, this message translates to:
  /// **'After each answer: the correct option and note; no timer.'**
  String get toifaModePracticeSub;

  /// No description provided for @toifaDrillStep2.
  ///
  /// In en, this message translates to:
  /// **'Right after answering you see if it’s correct: the official key and (if any) a note and source.'**
  String get toifaDrillStep2;

  /// No description provided for @toifaDrillStep3.
  ///
  /// In en, this message translates to:
  /// **'Resume where you left off even after closing the app; rework your mistakes at the end.'**
  String get toifaDrillStep3;

  /// No description provided for @toifaDrillStart.
  ///
  /// In en, this message translates to:
  /// **'Start practice'**
  String get toifaDrillStart;

  /// No description provided for @toifaDrillActive.
  ///
  /// In en, this message translates to:
  /// **'Practice in progress: {answered}/{total}'**
  String toifaDrillActive(int answered, int total);

  /// No description provided for @toifaDrillTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice mode'**
  String get toifaDrillTitle;

  /// No description provided for @toifaDrillRework.
  ///
  /// In en, this message translates to:
  /// **'Rework mistakes'**
  String get toifaDrillRework;

  /// No description provided for @toifaDrillScore.
  ///
  /// In en, this message translates to:
  /// **'Correct: {right} · wrong: {wrong}'**
  String toifaDrillScore(int right, int wrong);

  /// No description provided for @toifaDrillFinishEarly.
  ///
  /// In en, this message translates to:
  /// **'Finish now'**
  String get toifaDrillFinishEarly;

  /// No description provided for @toifaDrillFinishBody.
  ///
  /// In en, this message translates to:
  /// **'Unanswered questions count as wrong. Your answers stay in the mistakes list.'**
  String get toifaDrillFinishBody;

  /// No description provided for @toifaDrillDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Abandon this practice?'**
  String get toifaDrillDiscardTitle;

  /// No description provided for @toifaDrillNone.
  ///
  /// In en, this message translates to:
  /// **'No practice in progress'**
  String get toifaDrillNone;

  /// No description provided for @toifaDrillNew.
  ///
  /// In en, this message translates to:
  /// **'New test'**
  String get toifaDrillNew;

  /// No description provided for @toifaDrillUnanswered.
  ///
  /// In en, this message translates to:
  /// **'Unanswered: {count}'**
  String toifaDrillUnanswered(int count);

  /// No description provided for @toifaThinkHint.
  ///
  /// In en, this message translates to:
  /// **'Think through your answer: say it out loud or jot it on paper. Then open the plan and compare.'**
  String get toifaThinkHint;

  /// No description provided for @toifaThinkTimer.
  ///
  /// In en, this message translates to:
  /// **'{minutes}-min think timer'**
  String toifaThinkTimer(int minutes);

  /// No description provided for @toifaThinkLeft.
  ///
  /// In en, this message translates to:
  /// **'Think time: {time}'**
  String toifaThinkLeft(String time);

  /// No description provided for @toifaThinkUp.
  ///
  /// In en, this message translates to:
  /// **'Time’s up — open the plan and compare.'**
  String get toifaThinkUp;

  /// No description provided for @toifaThinkStop.
  ///
  /// In en, this message translates to:
  /// **'Stop timer'**
  String get toifaThinkStop;

  /// No description provided for @toifaChecklistToggle.
  ///
  /// In en, this message translates to:
  /// **'Key points to compare with the plan'**
  String get toifaChecklistToggle;

  /// No description provided for @toifaChecklistHint.
  ///
  /// In en, this message translates to:
  /// **'Tick what your answer covered (on this device only, no typing).'**
  String get toifaChecklistHint;

  /// No description provided for @toifaChecklistCount.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} ticked'**
  String toifaChecklistCount(int done, int total);

  /// No description provided for @toifaRepeatTitle.
  ///
  /// In en, this message translates to:
  /// **'To repeat'**
  String get toifaRepeatTitle;

  /// No description provided for @toifaRepeatNote.
  ///
  /// In en, this message translates to:
  /// **'“Partly” and “Didn’t know” questions come back first in your next tickets.'**
  String get toifaRepeatNote;

  /// No description provided for @toifaRepeatNone.
  ///
  /// In en, this message translates to:
  /// **'You knew them all — new questions in the next ticket.'**
  String get toifaRepeatNone;

  /// No description provided for @toifaPracticeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Key right after each answer'**
  String get toifaPracticeSubtitle;

  /// No description provided for @toifaPracticeMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed: {count} questions'**
  String toifaPracticeMixed(int count);

  /// No description provided for @toifaPracticeMistakes.
  ///
  /// In en, this message translates to:
  /// **'Redo mistakes'**
  String get toifaPracticeMistakes;

  /// No description provided for @toifaBackToTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get toifaBackToTopics;

  /// No description provided for @toifaPracticeRight.
  ///
  /// In en, this message translates to:
  /// **'Your answer matches the official key.'**
  String get toifaPracticeRight;

  /// No description provided for @toifaPracticeWrong.
  ///
  /// In en, this message translates to:
  /// **'Your answer does not match the official key.'**
  String get toifaPracticeWrong;

  /// No description provided for @toifaListNumber.
  ///
  /// In en, this message translates to:
  /// **'No. {number}'**
  String toifaListNumber(int number);

  /// No description provided for @toifaOfficialKey.
  ///
  /// In en, this message translates to:
  /// **'Official key'**
  String get toifaOfficialKey;

  /// No description provided for @toifaNurseGuideNote.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide note'**
  String get toifaNurseGuideNote;

  /// No description provided for @toifaVerdictDisputed.
  ///
  /// In en, this message translates to:
  /// **'Key disputed'**
  String get toifaVerdictDisputed;

  /// No description provided for @toifaVerdictAmbiguous.
  ///
  /// In en, this message translates to:
  /// **'Ambiguous question'**
  String get toifaVerdictAmbiguous;

  /// No description provided for @toifaSuggested.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide suggests: {options}'**
  String toifaSuggested(String options);

  /// No description provided for @toifaScoredByOfficial.
  ///
  /// In en, this message translates to:
  /// **'Scoring follows the official key — that answer is what the exam expects.'**
  String get toifaScoredByOfficial;

  /// No description provided for @toifaNoOfficialKey.
  ///
  /// In en, this message translates to:
  /// **'No key is marked in the list — this question is not scored.'**
  String get toifaNoOfficialKey;

  /// No description provided for @toifaNoteNoSource.
  ///
  /// In en, this message translates to:
  /// **'No source is given for this note.'**
  String get toifaNoteNoSource;

  /// No description provided for @toifaOralSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} questions · prepare and self-assess'**
  String toifaOralSubtitle(int count);

  /// No description provided for @toifaOralPool.
  ///
  /// In en, this message translates to:
  /// **'{category}: {count} questions in the list'**
  String toifaOralPool(String category, int count);

  /// No description provided for @toifaOralHowTitle.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get toifaOralHowTitle;

  /// No description provided for @toifaOralStep1.
  ///
  /// In en, this message translates to:
  /// **'{count} random questions from your category list.'**
  String toifaOralStep1(int count);

  /// No description provided for @toifaOralStep2.
  ///
  /// In en, this message translates to:
  /// **'Prepare your answers — in your head or on paper.'**
  String get toifaOralStep2;

  /// No description provided for @toifaOralStep3.
  ///
  /// In en, this message translates to:
  /// **'Check the answer plan and rate yourself: knew, partly or didn’t know.'**
  String get toifaOralStep3;

  /// No description provided for @toifaPlanDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Answer plans are a study aid prepared by NurseGuide. They are not official answers.'**
  String get toifaPlanDisclaimer;

  /// No description provided for @toifaPickCategoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose a category first'**
  String get toifaPickCategoryFirst;

  /// No description provided for @toifaDrawTicket.
  ///
  /// In en, this message translates to:
  /// **'Draw a ticket'**
  String get toifaDrawTicket;

  /// No description provided for @toifaTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Your ticket'**
  String get toifaTicketTitle;

  /// No description provided for @toifaPrepHint.
  ///
  /// In en, this message translates to:
  /// **'No typing needed. Think through each answer — say it out loud or jot it on paper. Then compare with the answer plan and rate yourself.'**
  String get toifaPrepHint;

  /// No description provided for @toifaShowPlans.
  ///
  /// In en, this message translates to:
  /// **'Answer one by one'**
  String get toifaShowPlans;

  /// No description provided for @toifaShowPlan.
  ///
  /// In en, this message translates to:
  /// **'View answer plan'**
  String get toifaShowPlan;

  /// No description provided for @toifaNewTicket.
  ///
  /// In en, this message translates to:
  /// **'New ticket'**
  String get toifaNewTicket;

  /// No description provided for @toifaNewTicketBody.
  ///
  /// In en, this message translates to:
  /// **'Five new questions replace the current ticket. Ratings you gave are kept.'**
  String get toifaNewTicketBody;

  /// No description provided for @toifaPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Answer plan'**
  String get toifaPlanTitle;

  /// No description provided for @toifaScopeTitle.
  ///
  /// In en, this message translates to:
  /// **'Work area'**
  String get toifaScopeTitle;

  /// No description provided for @toifaScopeHint.
  ///
  /// In en, this message translates to:
  /// **'Questions are taken from the chosen work area.'**
  String get toifaScopeHint;

  /// No description provided for @toifaScopeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get toifaScopeAll;

  /// No description provided for @toifaLiteratureTitle.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get toifaLiteratureTitle;

  /// No description provided for @toifaPlanPending.
  ///
  /// In en, this message translates to:
  /// **'Prepared by NurseGuide'**
  String get toifaPlanPending;

  /// No description provided for @toifaPlanMissing.
  ///
  /// In en, this message translates to:
  /// **'The plan for this question is not ready yet.'**
  String get toifaPlanMissing;

  /// No description provided for @toifaPlanNotChecked.
  ///
  /// In en, this message translates to:
  /// **'No source is attached to this plan yet.'**
  String get toifaPlanNotChecked;

  /// No description provided for @toifaReferenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Reference values'**
  String get toifaReferenceTitle;

  /// No description provided for @toifaCutoffTitle.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic cut-off (guideline)'**
  String get toifaCutoffTitle;

  /// No description provided for @toifaWrongLabel.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get toifaWrongLabel;

  /// No description provided for @toifaRightLabel.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get toifaRightLabel;

  /// No description provided for @toifaNeedsSource.
  ///
  /// In en, this message translates to:
  /// **'Source needed — being checked with a teacher'**
  String get toifaNeedsSource;

  /// No description provided for @toifaUnverifiedNote.
  ///
  /// In en, this message translates to:
  /// **'The note is not confirmed by a source — no answer is suggested.'**
  String get toifaUnverifiedNote;

  /// No description provided for @toifaAgentChecked.
  ///
  /// In en, this message translates to:
  /// **'Compared with sources: {date}'**
  String toifaAgentChecked(String date);

  /// No description provided for @toifaHeld.
  ///
  /// In en, this message translates to:
  /// **'Being clarified'**
  String get toifaHeld;

  /// No description provided for @toifaHeldBody.
  ///
  /// In en, this message translates to:
  /// **'Until the wording is clarified, this question is left out of tickets and scoring.'**
  String get toifaHeldBody;

  /// No description provided for @toifaAboutHeld.
  ///
  /// In en, this message translates to:
  /// **'{count} question(s) are left out of tickets and tests until clarified.'**
  String toifaAboutHeld(int count);

  /// No description provided for @toifaPitfallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Outdated / common mistake'**
  String get toifaPitfallsTitle;

  /// No description provided for @toifaRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate yourself'**
  String get toifaRateTitle;

  /// No description provided for @toifaRateHint.
  ///
  /// In en, this message translates to:
  /// **'The rating stays on this device and appears in Mistake review.'**
  String get toifaRateHint;

  /// No description provided for @toifaRateKnew.
  ///
  /// In en, this message translates to:
  /// **'Knew it'**
  String get toifaRateKnew;

  /// No description provided for @toifaRatePartial.
  ///
  /// In en, this message translates to:
  /// **'Partly'**
  String get toifaRatePartial;

  /// No description provided for @toifaRateUnknown.
  ///
  /// In en, this message translates to:
  /// **'Didn’t know'**
  String get toifaRateUnknown;

  /// No description provided for @toifaTicketDone.
  ///
  /// In en, this message translates to:
  /// **'Ticket complete'**
  String get toifaTicketDone;

  /// No description provided for @toifaTicketSummary.
  ///
  /// In en, this message translates to:
  /// **'Knew: {knew} · partly: {partial} · didn’t know: {unknown}'**
  String toifaTicketSummary(int knew, int partial, int unknown);

  /// No description provided for @toifaRatingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Ratings saved. Tap a question to reopen the plan and change the rating.'**
  String get toifaRatingsSaved;

  /// No description provided for @toifaRatingSaved.
  ///
  /// In en, this message translates to:
  /// **'Rating saved'**
  String get toifaRatingSaved;

  /// No description provided for @toifaMistakesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Test mistakes and oral questions'**
  String get toifaMistakesSubtitle;

  /// No description provided for @toifaMistakesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No mistakes yet'**
  String get toifaMistakesEmpty;

  /// No description provided for @toifaMistakesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Questions you got wrong in tests or practice and oral questions rated “didn’t know” collect here.'**
  String get toifaMistakesEmptyBody;

  /// No description provided for @toifaMistakesTests.
  ///
  /// In en, this message translates to:
  /// **'Test mistakes · {count}'**
  String toifaMistakesTests(int count);

  /// No description provided for @toifaMistakesOralUnknown.
  ///
  /// In en, this message translates to:
  /// **'Oral: didn’t know · {count}'**
  String toifaMistakesOralUnknown(int count);

  /// No description provided for @toifaMistakesOralPartial.
  ///
  /// In en, this message translates to:
  /// **'Oral: partly · {count}'**
  String toifaMistakesOralPartial(int count);

  /// No description provided for @toifaMoreMistakes.
  ///
  /// In en, this message translates to:
  /// **'{count} more mistakes — practise them via Redo mistakes.'**
  String toifaMoreMistakes(int count);

  /// No description provided for @toifaNothingHere.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get toifaNothingHere;

  /// No description provided for @toifaProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Results by topic and readiness'**
  String get toifaProgressSubtitle;

  /// No description provided for @toifaReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated readiness'**
  String get toifaReadyTitle;

  /// No description provided for @toifaReadyCaption.
  ///
  /// In en, this message translates to:
  /// **'Average of test and oral results. A NurseGuide estimate, not an official grade.'**
  String get toifaReadyCaption;

  /// No description provided for @toifaReadyTestDetail.
  ///
  /// In en, this message translates to:
  /// **'Test: {done} / {total} questions mastered'**
  String toifaReadyTestDetail(int done, int total);

  /// No description provided for @toifaReadyOralDetail.
  ///
  /// In en, this message translates to:
  /// **'Oral: {done} / {total} “knew it”'**
  String toifaReadyOralDetail(int done, int total);

  /// No description provided for @toifaProgressPickCategory.
  ///
  /// In en, this message translates to:
  /// **'Oral results use your category list — choose a category:'**
  String get toifaProgressPickCategory;

  /// No description provided for @toifaRecentTests.
  ///
  /// In en, this message translates to:
  /// **'Recent tests'**
  String get toifaRecentTests;

  /// No description provided for @toifaPassedShort.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get toifaPassedShort;

  /// No description provided for @toifaNotPassedShort.
  ///
  /// In en, this message translates to:
  /// **'Below mark'**
  String get toifaNotPassedShort;

  /// No description provided for @toifaByTopicNote.
  ///
  /// In en, this message translates to:
  /// **'Weakest topics first. Test — questions last answered correctly; oral — rated “knew it”.'**
  String get toifaByTopicNote;

  /// No description provided for @toifaBarTest.
  ///
  /// In en, this message translates to:
  /// **'Test: {done} / {total}'**
  String toifaBarTest(int done, int total);

  /// No description provided for @toifaBarOral.
  ///
  /// In en, this message translates to:
  /// **'Oral: {done} / {total}'**
  String toifaBarOral(int done, int total);

  /// No description provided for @examPassMet.
  ///
  /// In en, this message translates to:
  /// **'Mark reached (≥{percent}%)'**
  String examPassMet(int percent);

  /// No description provided for @examPassMissed.
  ///
  /// In en, this message translates to:
  /// **'Below your mark ({percent}%)'**
  String examPassMissed(int percent);

  /// No description provided for @quizProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String quizProgress(int current, int total);

  /// No description provided for @quizCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct.'**
  String get quizCorrect;

  /// No description provided for @quizIncorrect.
  ///
  /// In en, this message translates to:
  /// **'This answer is incorrect.'**
  String get quizIncorrect;

  /// No description provided for @quizNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get quizNext;

  /// No description provided for @quizFinish.
  ///
  /// In en, this message translates to:
  /// **'See result'**
  String get quizFinish;

  /// No description provided for @quizDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice complete'**
  String get quizDoneTitle;

  /// No description provided for @quizScore.
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} correct'**
  String quizScore(int correct, int total);

  /// No description provided for @quizRestart.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get quizRestart;

  /// No description provided for @quizBasis.
  ///
  /// In en, this message translates to:
  /// **'Basis: {basis}'**
  String quizBasis(String basis);

  /// No description provided for @quizSources.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get quizSources;

  /// No description provided for @quizReviewNote.
  ///
  /// In en, this message translates to:
  /// **'Practice questions are for learning; the result is not an official grade.'**
  String get quizReviewNote;

  /// No description provided for @quizMistakes.
  ///
  /// In en, this message translates to:
  /// **'Review your mistakes'**
  String get quizMistakes;

  /// No description provided for @quizNoMistakes.
  ///
  /// In en, this message translates to:
  /// **'No mistakes — well done.'**
  String get quizNoMistakes;

  /// No description provided for @quizYourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get quizYourAnswer;

  /// No description provided for @quizCorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct answer'**
  String get quizCorrectAnswer;

  /// No description provided for @quizChooseTopic.
  ///
  /// In en, this message translates to:
  /// **'Choose a topic'**
  String get quizChooseTopic;

  /// No description provided for @quizTopicMixed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Mixed: 1 random question} other{Mixed: {count} random questions}}'**
  String quizTopicMixed(int count);

  /// No description provided for @quizTopicGeneral.
  ///
  /// In en, this message translates to:
  /// **'General questions'**
  String get quizTopicGeneral;

  /// No description provided for @quizQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question} other{{count} questions}}'**
  String quizQuestionCount(int count);

  /// No description provided for @quizOtherTopic.
  ///
  /// In en, this message translates to:
  /// **'Another topic'**
  String get quizOtherTopic;

  /// No description provided for @dailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily questions'**
  String get dailyTitle;

  /// No description provided for @dailyCardStart.
  ///
  /// In en, this message translates to:
  /// **'Today’s 5 questions'**
  String get dailyCardStart;

  /// No description provided for @dailyCardStartSub.
  ///
  /// In en, this message translates to:
  /// **'2–3 minutes. New questions every day, with an explanation and source after each answer.'**
  String get dailyCardStartSub;

  /// No description provided for @dailyCardProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} answered'**
  String dailyCardProgress(int count, int total);

  /// No description provided for @dailyCardDone.
  ///
  /// In en, this message translates to:
  /// **'Done for today: {correct} of {total} correct'**
  String dailyCardDone(int correct, int total);

  /// No description provided for @dailyCardDoneSub.
  ///
  /// In en, this message translates to:
  /// **'Five new questions tomorrow.'**
  String get dailyCardDoneSub;

  /// No description provided for @dailyStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get dailyStart;

  /// No description provided for @dailyContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get dailyContinue;

  /// No description provided for @dailyShowResult.
  ///
  /// In en, this message translates to:
  /// **'See result'**
  String get dailyShowResult;

  /// No description provided for @dailyStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day in a row} other{{count} days in a row}}'**
  String dailyStreakDays(int count);

  /// No description provided for @dailyStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get dailyStreakTitle;

  /// No description provided for @dailyStreakCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get dailyStreakCurrent;

  /// No description provided for @dailyStreakBest.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get dailyStreakBest;

  /// No description provided for @dailyDaysShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String dailyDaysShort(int count);

  /// No description provided for @dailyFreezeAvailable.
  ///
  /// In en, this message translates to:
  /// **'This week’s freeze is available'**
  String get dailyFreezeAvailable;

  /// No description provided for @dailyFreezeUsed.
  ///
  /// In en, this message translates to:
  /// **'This week’s freeze is used'**
  String get dailyFreezeUsed;

  /// No description provided for @dailyFreezeRule.
  ///
  /// In en, this message translates to:
  /// **'Miss one day and your streak survives — once a week (a freeze). The frozen day doesn’t count towards the streak; miss two days in a row and it starts over.'**
  String get dailyFreezeRule;

  /// No description provided for @dailyFreezeSaved.
  ///
  /// In en, this message translates to:
  /// **'You missed yesterday — a freeze kept your streak.'**
  String get dailyFreezeSaved;

  /// No description provided for @dailyKeepStreak.
  ///
  /// In en, this message translates to:
  /// **'Answer today’s questions to keep your streak.'**
  String get dailyKeepStreak;

  /// No description provided for @dailyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No questions for today'**
  String get dailyEmpty;

  /// No description provided for @dailyReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Today’s questions'**
  String get dailyReviewTitle;

  /// No description provided for @dailySourceToifa.
  ///
  /// In en, this message translates to:
  /// **'Questions come from the official certification list — only those whose key passed the NurseGuide check.'**
  String get dailySourceToifa;

  /// No description provided for @dailyReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide: daily questions'**
  String get dailyReminderTitle;

  /// No description provided for @dailyReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Today’s 5 questions are ready — 2–3 minutes.'**
  String get dailyReminderBody;

  /// No description provided for @dailyReminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminderChannel;

  /// No description provided for @dailyReminderSetting.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get dailyReminderSetting;

  /// No description provided for @dailyReminderAt.
  ///
  /// In en, this message translates to:
  /// **'Every day at {time}'**
  String dailyReminderAt(String time);

  /// No description provided for @dailyReminderOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get dailyReminderOff;

  /// No description provided for @dailyReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get dailyReminderTime;

  /// No description provided for @dailyOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Want a daily reminder?'**
  String get dailyOfferTitle;

  /// No description provided for @dailyOfferBody.
  ///
  /// In en, this message translates to:
  /// **'One notification at the time you choose. No reminder on days you’ve already answered. Turn it off any time.'**
  String get dailyOfferBody;

  /// No description provided for @dailyOfferYes.
  ///
  /// In en, this message translates to:
  /// **'Turn on reminder'**
  String get dailyOfferYes;

  /// No description provided for @dailyOfferNo.
  ///
  /// In en, this message translates to:
  /// **'No thanks'**
  String get dailyOfferNo;

  /// No description provided for @dailyReminderDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission wasn’t granted, so the reminder stays off. Allow notifications for NurseGuide in your phone settings and try again.'**
  String get dailyReminderDenied;

  /// No description provided for @dailyReminderUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t turn on reminders on this device.'**
  String get dailyReminderUnavailable;

  /// No description provided for @dailyReminderOnSnack.
  ///
  /// In en, this message translates to:
  /// **'Reminder on: every day at {time}'**
  String dailyReminderOnSnack(String time);

  /// No description provided for @dailyReminderNote.
  ///
  /// In en, this message translates to:
  /// **'The reminder is scheduled on this device only (no server). Your phone may delay it by a few minutes to save battery. If you don’t open the app for 7 days, reminders stop.'**
  String get dailyReminderNote;

  /// No description provided for @shareResult.
  ///
  /// In en, this message translates to:
  /// **'Share result'**
  String get shareResult;

  /// No description provided for @shareSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Result card'**
  String get shareSheetTitle;

  /// No description provided for @shareSheetBody.
  ///
  /// In en, this message translates to:
  /// **'The image has no name or other personal data.'**
  String get shareSheetBody;

  /// No description provided for @shareFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the share sheet. Please try again.'**
  String get shareFailed;

  /// No description provided for @shareKindDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily questions'**
  String get shareKindDaily;

  /// No description provided for @shareKindExam.
  ///
  /// In en, this message translates to:
  /// **'Practice exam'**
  String get shareKindExam;

  /// No description provided for @shareKindToifa.
  ///
  /// In en, this message translates to:
  /// **'Category test practice'**
  String get shareKindToifa;

  /// No description provided for @shareCorrectCaption.
  ///
  /// In en, this message translates to:
  /// **'correct answers'**
  String get shareCorrectCaption;

  /// No description provided for @shareFooter.
  ///
  /// In en, this message translates to:
  /// **'Nursing reference and practice'**
  String get shareFooter;

  /// No description provided for @shareToifaNote.
  ///
  /// In en, this message translates to:
  /// **'Not official — NurseGuide practice result'**
  String get shareToifaNote;

  /// No description provided for @shareText.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide · {kind}: {correct}/{total} ({percent}%)'**
  String shareText(String kind, int correct, int total, int percent);

  /// No description provided for @quizTopicMistakes.
  ///
  /// In en, this message translates to:
  /// **'Review my mistakes'**
  String get quizTopicMistakes;

  /// No description provided for @quizMastered.
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} correct last time'**
  String quizMastered(int correct, int total);

  /// No description provided for @examTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam mode'**
  String get examTitle;

  /// No description provided for @classesTitle.
  ///
  /// In en, this message translates to:
  /// **'Classes and assignments'**
  String get classesTitle;

  /// No description provided for @classesSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to use classes'**
  String get classesSignInTitle;

  /// No description provided for @classesSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Creating, joining and submitting assignments is tied to an account. Reading content stays open without sign-in.'**
  String get classesSignInBody;

  /// No description provided for @classesSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get classesSignIn;

  /// No description provided for @classesUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'The class server isn\'t connected yet'**
  String get classesUnavailableTitle;

  /// No description provided for @classesUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing is sent or stored. When it\'s connected, teachers see only their own classes and students see only their own results — checked on the server.'**
  String get classesUnavailableBody;

  /// No description provided for @examSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A timed test: pick topics, number of questions and time. Works offline.'**
  String get examSubtitle;

  /// No description provided for @examActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfinished exam'**
  String get examActiveTitle;

  /// No description provided for @examActiveBody.
  ///
  /// In en, this message translates to:
  /// **'{answered}/{total} answered · {time} left'**
  String examActiveBody(int answered, int total, String time);

  /// No description provided for @examResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get examResume;

  /// No description provided for @examDiscard.
  ///
  /// In en, this message translates to:
  /// **'Abandon exam'**
  String get examDiscard;

  /// No description provided for @examDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Abandon this exam?'**
  String get examDiscardTitle;

  /// No description provided for @examDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'Your answers will be deleted and no result will be saved.'**
  String get examDiscardBody;

  /// No description provided for @examDiscardAction.
  ///
  /// In en, this message translates to:
  /// **'Abandon'**
  String get examDiscardAction;

  /// No description provided for @examTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get examTopics;

  /// No description provided for @examAllTopics.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get examAllTopics;

  /// No description provided for @examPoolCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question in the selected topics} other{{count} questions in the selected topics}}'**
  String examPoolCount(int count);

  /// No description provided for @examSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get examSettings;

  /// No description provided for @examCount.
  ///
  /// In en, this message translates to:
  /// **'Number of questions'**
  String get examCount;

  /// No description provided for @examCountHint.
  ///
  /// In en, this message translates to:
  /// **'From 1 to {max}'**
  String examCountHint(int max);

  /// No description provided for @examCountError.
  ///
  /// In en, this message translates to:
  /// **'Enter a number from 1 to {max}'**
  String examCountError(int max);

  /// No description provided for @examCountAll.
  ///
  /// In en, this message translates to:
  /// **'All {count}'**
  String examCountAll(int count);

  /// No description provided for @examTime.
  ///
  /// In en, this message translates to:
  /// **'Time, minutes'**
  String get examTime;

  /// No description provided for @examTimeHint.
  ///
  /// In en, this message translates to:
  /// **'1–180 min · usually 1 min per question'**
  String get examTimeHint;

  /// No description provided for @examTimeError.
  ///
  /// In en, this message translates to:
  /// **'Enter 1 to 180 minutes'**
  String get examTimeError;

  /// No description provided for @examMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String examMinutes(int count);

  /// No description provided for @examRulesNotice.
  ///
  /// In en, this message translates to:
  /// **'Questions and options are shuffled. Until you finish you can change answers and bookmark questions to revisit. The clock keeps running even if the app is closed; when time is up, the exam ends by itself.'**
  String get examRulesNotice;

  /// No description provided for @examStart.
  ///
  /// In en, this message translates to:
  /// **'Start exam'**
  String get examStart;

  /// No description provided for @examReplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'You have an unfinished exam'**
  String get examReplaceTitle;

  /// No description provided for @examReplaceBody.
  ///
  /// In en, this message translates to:
  /// **'Starting a new one deletes the previous exam and its answers.'**
  String get examReplaceBody;

  /// No description provided for @examHistory.
  ///
  /// In en, this message translates to:
  /// **'Result history'**
  String get examHistory;

  /// No description provided for @examHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No exams yet. Your first result will appear here — it’s stored only on this device.'**
  String get examHistoryEmpty;

  /// No description provided for @examHistoryStats.
  ///
  /// In en, this message translates to:
  /// **'Last {count}: average {avg}% · best {best}%'**
  String examHistoryStats(int count, int avg, int best);

  /// No description provided for @examHistoryRow.
  ///
  /// In en, this message translates to:
  /// **'{date} · {correct}/{total} · {time}'**
  String examHistoryRow(String date, int correct, int total, String time);

  /// No description provided for @examHistoryClear.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get examHistoryClear;

  /// No description provided for @examHistoryClearBody.
  ///
  /// In en, this message translates to:
  /// **'All exam results will be deleted from this device.'**
  String get examHistoryClearBody;

  /// No description provided for @examProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent results: {values}'**
  String examProgressLabel(String values);

  /// No description provided for @examProgressOld.
  ///
  /// In en, this message translates to:
  /// **'Older → newer'**
  String get examProgressOld;

  /// No description provided for @examProgressLast.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get examProgressLast;

  /// No description provided for @examSettled.
  ///
  /// In en, this message translates to:
  /// **'Your previous exam ended because time ran out'**
  String get examSettled;

  /// No description provided for @examOpenResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get examOpenResult;

  /// No description provided for @examTitleAll.
  ///
  /// In en, this message translates to:
  /// **'All topics'**
  String get examTitleAll;

  /// No description provided for @examTitleTopics.
  ///
  /// In en, this message translates to:
  /// **'{first} + {more} more'**
  String examTitleTopics(String first, int more);

  /// No description provided for @examReworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Practise your mistakes'**
  String get examReworkTitle;

  /// No description provided for @examQuestionMissing.
  ///
  /// In en, this message translates to:
  /// **'This question isn’t in the current content pack.'**
  String get examQuestionMissing;

  /// No description provided for @examMap.
  ///
  /// In en, this message translates to:
  /// **'Question map'**
  String get examMap;

  /// No description provided for @examFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get examFinish;

  /// No description provided for @examFinishTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish the exam?'**
  String get examFinishTitle;

  /// No description provided for @examFinishBody.
  ///
  /// In en, this message translates to:
  /// **'Unanswered: {unanswered}, bookmarked: {flagged}. You can’t change answers after finishing.'**
  String examFinishBody(int unanswered, int flagged);

  /// No description provided for @examFinishBodyAll.
  ///
  /// In en, this message translates to:
  /// **'All questions are answered. You can’t change answers after finishing.'**
  String get examFinishBodyAll;

  /// No description provided for @examFinishClassTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish the test?'**
  String get examFinishClassTitle;

  /// No description provided for @examFinishClassBody.
  ///
  /// In en, this message translates to:
  /// **'Your answers will be sent to your teacher.'**
  String get examFinishClassBody;

  /// No description provided for @examFlag.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get examFlag;

  /// No description provided for @examFlagged.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get examFlagged;

  /// No description provided for @examLegendAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get examLegendAnswered;

  /// No description provided for @examLegendEmpty.
  ///
  /// In en, this message translates to:
  /// **'Unanswered'**
  String get examLegendEmpty;

  /// No description provided for @examLegendFlagged.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get examLegendFlagged;

  /// No description provided for @examQuestionN.
  ///
  /// In en, this message translates to:
  /// **'Question {n}'**
  String examQuestionN(int n);

  /// No description provided for @examAnsweredOf.
  ///
  /// In en, this message translates to:
  /// **'{answered}/{total} answered'**
  String examAnsweredOf(int answered, int total);

  /// No description provided for @examPrev.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get examPrev;

  /// No description provided for @examNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get examNext;

  /// No description provided for @examTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'Time left: {time}'**
  String examTimeLeft(String time);

  /// No description provided for @examElapsed.
  ///
  /// In en, this message translates to:
  /// **'Elapsed: {time}'**
  String examElapsed(String time);

  /// No description provided for @examNoActive.
  ///
  /// In en, this message translates to:
  /// **'No active exam'**
  String get examNoActive;

  /// No description provided for @examNoActiveBody.
  ///
  /// In en, this message translates to:
  /// **'It was finished or abandoned. Set up and start a new one.'**
  String get examNoActiveBody;

  /// No description provided for @examNew.
  ///
  /// In en, this message translates to:
  /// **'New exam'**
  String get examNew;

  /// No description provided for @examSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving the result…'**
  String get examSaving;

  /// No description provided for @examResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get examResultTitle;

  /// No description provided for @examResultMissing.
  ///
  /// In en, this message translates to:
  /// **'Result not found'**
  String get examResultMissing;

  /// No description provided for @examBand90.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get examBand90;

  /// No description provided for @examBand70.
  ///
  /// In en, this message translates to:
  /// **'Good result!'**
  String get examBand70;

  /// No description provided for @examBand50.
  ///
  /// In en, this message translates to:
  /// **'Not bad — review your mistakes'**
  String get examBand50;

  /// No description provided for @examBand0.
  ///
  /// In en, this message translates to:
  /// **'Keep practising — you’ve got this'**
  String get examBand0;

  /// No description provided for @examCorrectN.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get examCorrectN;

  /// No description provided for @examWrongN.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get examWrongN;

  /// No description provided for @examSkippedN.
  ///
  /// In en, this message translates to:
  /// **'Unanswered'**
  String get examSkippedN;

  /// No description provided for @examSpent.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get examSpent;

  /// No description provided for @examTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Time ran out — finished automatically'**
  String get examTimedOut;

  /// No description provided for @examDeltaUp.
  ///
  /// In en, this message translates to:
  /// **'+{n}% vs last attempt'**
  String examDeltaUp(int n);

  /// No description provided for @examDeltaDown.
  ///
  /// In en, this message translates to:
  /// **'−{n}% vs last attempt'**
  String examDeltaDown(int n);

  /// No description provided for @examDeltaSame.
  ///
  /// In en, this message translates to:
  /// **'Same as last attempt'**
  String get examDeltaSame;

  /// No description provided for @examReworkMistakes.
  ///
  /// In en, this message translates to:
  /// **'Practise mistakes · {count}'**
  String examReworkMistakes(int count);

  /// No description provided for @examAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Mistake analysis'**
  String get examAnalysis;

  /// No description provided for @examFilterMistakes.
  ///
  /// In en, this message translates to:
  /// **'Mistakes · {count}'**
  String examFilterMistakes(int count);

  /// No description provided for @examFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All · {count}'**
  String examFilterAll(int count);

  /// No description provided for @examNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Not answered'**
  String get examNoAnswer;

  /// No description provided for @examWrongTag.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get examWrongTag;

  /// No description provided for @examWhyWrong.
  ///
  /// In en, this message translates to:
  /// **'Why not this answer'**
  String get examWhyWrong;

  /// No description provided for @examNoSource.
  ///
  /// In en, this message translates to:
  /// **'No source is given for this question.'**
  String get examNoSource;

  /// No description provided for @examSourceMissing.
  ///
  /// In en, this message translates to:
  /// **'This exam’s question list isn’t available in the app'**
  String get examSourceMissing;

  /// No description provided for @examMultiHint.
  ///
  /// In en, this message translates to:
  /// **'Several correct answers — select all'**
  String get examMultiHint;

  /// No description provided for @examNoExplanation.
  ///
  /// In en, this message translates to:
  /// **'No explanation has been written for this question yet.'**
  String get examNoExplanation;

  /// No description provided for @examByTopic.
  ///
  /// In en, this message translates to:
  /// **'By topic'**
  String get examByTopic;

  /// No description provided for @examByTopicNote.
  ///
  /// In en, this message translates to:
  /// **'Weakest topic first — start there.'**
  String get examByTopicNote;

  /// No description provided for @classesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A teacher creates a class and sets assignments; students join with a code and solve them.'**
  String get classesSubtitle;

  /// No description provided for @classesTryExam.
  ///
  /// In en, this message translates to:
  /// **'Open the offline exam'**
  String get classesTryExam;

  /// No description provided for @classesLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get classesLoading;

  /// No description provided for @classesInvalid.
  ///
  /// In en, this message translates to:
  /// **'The server didn’t accept this — check the fields.'**
  String get classesInvalid;

  /// No description provided for @classesCodeNotFound.
  ///
  /// In en, this message translates to:
  /// **'No class found with this code. Check the code with your teacher.'**
  String get classesCodeNotFound;

  /// No description provided for @classesCreate.
  ///
  /// In en, this message translates to:
  /// **'Create a class'**
  String get classesCreate;

  /// No description provided for @classesCreateSub.
  ///
  /// In en, this message translates to:
  /// **'For teachers: get a code and set assignments'**
  String get classesCreateSub;

  /// No description provided for @classesJoin.
  ///
  /// In en, this message translates to:
  /// **'Join with a code'**
  String get classesJoin;

  /// No description provided for @classesJoinSub.
  ///
  /// In en, this message translates to:
  /// **'For students: the 8-character code from your teacher'**
  String get classesJoinSub;

  /// No description provided for @classesRoleNote.
  ///
  /// In en, this message translates to:
  /// **'Your role in the app grants no server rights: only an account registered as a teacher can open a class, and only manages its own classes.'**
  String get classesRoleNote;

  /// No description provided for @classesMine.
  ///
  /// In en, this message translates to:
  /// **'My classes'**
  String get classesMine;

  /// No description provided for @classesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No classes yet'**
  String get classesEmpty;

  /// No description provided for @classesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create a class or join one with the code from your teacher.'**
  String get classesEmptyBody;

  /// No description provided for @classesRoleTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get classesRoleTeacher;

  /// No description provided for @classesRoleStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get classesRoleStudent;

  /// No description provided for @classesMembers.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 member} other{{count} members}}'**
  String classesMembers(int count);

  /// No description provided for @classesCreateIntro.
  ///
  /// In en, this message translates to:
  /// **'The teacher who opens a class manages only that class. Students join with your code or QR.'**
  String get classesCreateIntro;

  /// No description provided for @classesGroupName.
  ///
  /// In en, this message translates to:
  /// **'Class name'**
  String get classesGroupName;

  /// No description provided for @classesGroupNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Nursing year 2'**
  String get classesGroupNameHint;

  /// No description provided for @classesLengthError.
  ///
  /// In en, this message translates to:
  /// **'Enter {min}–{max} characters'**
  String classesLengthError(int min, int max);

  /// No description provided for @classesDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Nickname (optional)'**
  String get classesDisplayName;

  /// No description provided for @classesDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Star — leave empty to use a number'**
  String get classesDisplayNameHint;

  /// No description provided for @classesDisplayNameNote.
  ///
  /// In en, this message translates to:
  /// **'Names aren’t stored on the server: students appear by nickname or number. You can note a real name only as a label on your own device.'**
  String get classesDisplayNameNote;

  /// No description provided for @classesCreateAction.
  ///
  /// In en, this message translates to:
  /// **'Create class'**
  String get classesCreateAction;

  /// No description provided for @classesCreated.
  ///
  /// In en, this message translates to:
  /// **'Class created — send the code to your students'**
  String get classesCreated;

  /// No description provided for @classesJoinIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter the code your teacher gave you.'**
  String get classesJoinIntro;

  /// No description provided for @classesCode.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get classesCode;

  /// No description provided for @classesCodeError.
  ///
  /// In en, this message translates to:
  /// **'The code has 8 letters and digits'**
  String get classesCodeError;

  /// No description provided for @classesJoinNote.
  ///
  /// In en, this message translates to:
  /// **'Don’t use your real name. The teacher sees only your nickname (or number) and your results; other students don’t see you. Your email isn’t shown.'**
  String get classesJoinNote;

  /// No description provided for @classesJoinAction.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get classesJoinAction;

  /// No description provided for @classesJoined.
  ///
  /// In en, this message translates to:
  /// **'You joined the class'**
  String get classesJoined;

  /// No description provided for @classesYouTeacher.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You’re the teacher · 1 member} other{You’re the teacher · {count} members}}'**
  String classesYouTeacher(int count);

  /// No description provided for @classesYouStudent.
  ///
  /// In en, this message translates to:
  /// **'You’re a student'**
  String get classesYouStudent;

  /// No description provided for @classesGroupMissing.
  ///
  /// In en, this message translates to:
  /// **'Class not found, or you’re no longer a member'**
  String get classesGroupMissing;

  /// No description provided for @classesBackToList.
  ///
  /// In en, this message translates to:
  /// **'Back to classes'**
  String get classesBackToList;

  /// No description provided for @classesAssignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get classesAssignments;

  /// No description provided for @classesNoAssignmentsTeacher.
  ///
  /// In en, this message translates to:
  /// **'No assignments yet. Pick topics and a number of questions from the list to set one.'**
  String get classesNoAssignmentsTeacher;

  /// No description provided for @classesNoAssignmentsStudent.
  ///
  /// In en, this message translates to:
  /// **'No assignments yet'**
  String get classesNoAssignmentsStudent;

  /// No description provided for @classesNoAssignmentsStudentBody.
  ///
  /// In en, this message translates to:
  /// **'When your teacher sets one, it will appear here.'**
  String get classesNoAssignmentsStudentBody;

  /// No description provided for @classesNoDue.
  ///
  /// In en, this message translates to:
  /// **'no due date'**
  String get classesNoDue;

  /// No description provided for @classesDue.
  ///
  /// In en, this message translates to:
  /// **'due {date}'**
  String classesDue(String date);

  /// No description provided for @classesSubmittedOf.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} submitted'**
  String classesSubmittedOf(int done, int total);

  /// No description provided for @classesMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Students · {count}'**
  String classesMembersTitle(int count);

  /// No description provided for @classesNoStudents.
  ///
  /// In en, this message translates to:
  /// **'No students yet — share the code.'**
  String get classesNoStudents;

  /// No description provided for @classesMemberNoWork.
  ///
  /// In en, this message translates to:
  /// **'Nothing submitted yet'**
  String get classesMemberNoWork;

  /// No description provided for @classesMemberSummary.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} assignments · average {avg}%'**
  String classesMemberSummary(int done, int total, int avg);

  /// No description provided for @classesRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from class'**
  String get classesRemove;

  /// No description provided for @classesRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the class?'**
  String classesRemoveTitle(String name);

  /// No description provided for @classesRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'They’ll no longer see the class or new assignments. Submitted results are kept.'**
  String get classesRemoveBody;

  /// No description provided for @classesRemoveAction.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get classesRemoveAction;

  /// No description provided for @classesStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Submitted · {score}/{total}'**
  String classesStatusDone(int score, int total);

  /// No description provided for @classesStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get classesStatusInProgress;

  /// No description provided for @classesStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Not sent'**
  String get classesStatusPending;

  /// No description provided for @classesStatusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Past due'**
  String get classesStatusOverdue;

  /// No description provided for @classesStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get classesStatusNew;

  /// No description provided for @classesStudentNote.
  ///
  /// In en, this message translates to:
  /// **'Your teacher sees only your name in the class and your assignment results.'**
  String get classesStudentNote;

  /// No description provided for @classesLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave class'**
  String get classesLeave;

  /// No description provided for @classesLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave the class?'**
  String get classesLeaveTitle;

  /// No description provided for @classesLeaveBody.
  ///
  /// In en, this message translates to:
  /// **'To rejoin you’ll need the teacher’s code. Results you’ve submitted stay with the teacher.'**
  String get classesLeaveBody;

  /// No description provided for @classesLeaveAction.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get classesLeaveAction;

  /// No description provided for @classesInviteTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get classesInviteTitle;

  /// No description provided for @classesInviteBody.
  ///
  /// In en, this message translates to:
  /// **'Students scan the QR with the phone camera and tap “Open in app” — or: Learn → Classes and assignments → Join with a code.'**
  String get classesInviteBody;

  /// No description provided for @classesCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get classesCopyCode;

  /// No description provided for @classesCopyInvite.
  ///
  /// In en, this message translates to:
  /// **'Copy invitation text'**
  String get classesCopyInvite;

  /// No description provided for @classesCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get classesCopied;

  /// No description provided for @classesInviteText.
  ///
  /// In en, this message translates to:
  /// **'Join the class “{name}” in the NurseGuide app: Learn → Classes and assignments → Join with a code. Code: {code}'**
  String classesInviteText(String name, String code);

  /// No description provided for @classesAssignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment title'**
  String get classesAssignmentTitle;

  /// No description provided for @classesTimeLimit.
  ///
  /// In en, this message translates to:
  /// **'Time limit, minutes'**
  String get classesTimeLimit;

  /// No description provided for @classesNoLimit.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get classesNoLimit;

  /// No description provided for @classesDueNone.
  ///
  /// In en, this message translates to:
  /// **'No due date'**
  String get classesDueNone;

  /// No description provided for @classesDueDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String classesDueDays(int count);

  /// No description provided for @classesDuePick.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get classesDuePick;

  /// No description provided for @classesDueNoneBody.
  ///
  /// In en, this message translates to:
  /// **'No due date — students can submit any time.'**
  String get classesDueNoneBody;

  /// No description provided for @classesDueAt.
  ///
  /// In en, this message translates to:
  /// **'Due by {date}'**
  String classesDueAt(String date);

  /// No description provided for @classesPreview.
  ///
  /// In en, this message translates to:
  /// **'Selected questions · {count}'**
  String classesPreview(int count);

  /// No description provided for @classesReshuffle.
  ///
  /// In en, this message translates to:
  /// **'Reshuffle'**
  String get classesReshuffle;

  /// No description provided for @classesKeyNotice.
  ///
  /// In en, this message translates to:
  /// **'Students can’t see the answer key in advance — the server does the scoring. Each student submits once.'**
  String get classesKeyNotice;

  /// No description provided for @classesSendAssignment.
  ///
  /// In en, this message translates to:
  /// **'Set assignment'**
  String get classesSendAssignment;

  /// No description provided for @classesSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Answers submitted'**
  String get classesSubmitted;

  /// No description provided for @classesSubmitNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection — answers are saved on this device. Send them again later.'**
  String get classesSubmitNetwork;

  /// No description provided for @classesSubmitRejected.
  ///
  /// In en, this message translates to:
  /// **'The server didn’t accept the answers: time or the due date ran out, or it was already submitted.'**
  String get classesSubmitRejected;

  /// No description provided for @classesAssignmentMissing.
  ///
  /// In en, this message translates to:
  /// **'Assignment not found'**
  String get classesAssignmentMissing;

  /// No description provided for @classesMetricQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get classesMetricQuestions;

  /// No description provided for @classesMetricLimit.
  ///
  /// In en, this message translates to:
  /// **'Time limit'**
  String get classesMetricLimit;

  /// No description provided for @classesMetricDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get classesMetricDue;

  /// No description provided for @classesMetricSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get classesMetricSubmitted;

  /// No description provided for @classesMetricAverage.
  ///
  /// In en, this message translates to:
  /// **'Average score'**
  String get classesMetricAverage;

  /// No description provided for @classesPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Answers not sent yet'**
  String get classesPendingTitle;

  /// No description provided for @classesPendingBody.
  ///
  /// In en, this message translates to:
  /// **'They’re saved on this device. Send them once you’re online — the server accepts them within the time limit.'**
  String get classesPendingBody;

  /// No description provided for @classesResend.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get classesResend;

  /// No description provided for @classesOverdueTitle.
  ///
  /// In en, this message translates to:
  /// **'Past due'**
  String get classesOverdueTitle;

  /// No description provided for @classesOverdueBody.
  ///
  /// In en, this message translates to:
  /// **'This assignment can no longer be submitted.'**
  String get classesOverdueBody;

  /// No description provided for @classesOutdatedPack.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question in this assignment isn’t in your app’s content. Update the app.} other{{count} questions in this assignment aren’t in your app’s content. Update the app.}}'**
  String classesOutdatedPack(int count);

  /// No description provided for @classesStartNotice.
  ///
  /// In en, this message translates to:
  /// **'Once you start you have {minutes} min — the clock doesn’t stop, and answers are sent automatically when time is up. One submission only; sending needs internet.'**
  String classesStartNotice(int minutes);

  /// No description provided for @classesStartNoticeNoLimit.
  ///
  /// In en, this message translates to:
  /// **'No time limit. Answers are sent once and can’t be resubmitted; sending needs internet.'**
  String get classesStartNoticeNoLimit;

  /// No description provided for @classesStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get classesStart;

  /// No description provided for @classesSubmittedAt.
  ///
  /// In en, this message translates to:
  /// **'Submitted {date}'**
  String classesSubmittedAt(String date);

  /// No description provided for @classesServerScore.
  ///
  /// In en, this message translates to:
  /// **'Scored by the server'**
  String get classesServerScore;

  /// No description provided for @classesResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get classesResults;

  /// No description provided for @classesColStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get classesColStudent;

  /// No description provided for @classesColScore.
  ///
  /// In en, this message translates to:
  /// **'Score · %'**
  String get classesColScore;

  /// No description provided for @classesNotSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Not submitted'**
  String get classesNotSubmitted;

  /// No description provided for @classesByQuestion.
  ///
  /// In en, this message translates to:
  /// **'By question'**
  String get classesByQuestion;

  /// No description provided for @classesByQuestionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No one has submitted yet.'**
  String get classesByQuestionEmpty;

  /// No description provided for @classesWrongOf.
  ///
  /// In en, this message translates to:
  /// **'{wrong}/{total} wrong'**
  String classesWrongOf(int wrong, int total);

  /// No description provided for @classesSending.
  ///
  /// In en, this message translates to:
  /// **'Sending answers…'**
  String get classesSending;

  /// No description provided for @classesMyProgress.
  ///
  /// In en, this message translates to:
  /// **'My progress'**
  String get classesMyProgress;

  /// No description provided for @classesDoneOf.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} assignments done'**
  String classesDoneOf(int done, int total);

  /// No description provided for @classesAverage.
  ///
  /// In en, this message translates to:
  /// **'Average score: {avg}%'**
  String classesAverage(int avg);

  /// No description provided for @classesStudentResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Student’s result'**
  String get classesStudentResultTitle;

  /// No description provided for @classesStudentAnswer.
  ///
  /// In en, this message translates to:
  /// **'Student’s answer'**
  String get classesStudentAnswer;

  /// No description provided for @classesInviteMore.
  ///
  /// In en, this message translates to:
  /// **'Invite more students'**
  String get classesInviteMore;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings'**
  String get profileTitle;

  /// No description provided for @profileGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileGuest;

  /// No description provided for @profileGuestSub.
  ///
  /// In en, this message translates to:
  /// **'Content is open without an account'**
  String get profileGuestSub;

  /// No description provided for @profileGuestLocal.
  ///
  /// In en, this message translates to:
  /// **'Data stays on this device only'**
  String get profileGuestLocal;

  /// No description provided for @profileDemoSession.
  ///
  /// In en, this message translates to:
  /// **'Demo session · debug build'**
  String get profileDemoSession;

  /// No description provided for @profileRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get profileRole;

  /// No description provided for @profileRoleSub.
  ///
  /// In en, this message translates to:
  /// **'Home adapts to your role'**
  String get profileRoleSub;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileAppearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeRowSub.
  ///
  /// In en, this message translates to:
  /// **'App colours and title type'**
  String get themeRowSub;

  /// No description provided for @themeCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current theme'**
  String get themeCurrent;

  /// No description provided for @themeClassicName.
  ///
  /// In en, this message translates to:
  /// **'Clear glass'**
  String get themeClassicName;

  /// No description provided for @themeClassicDesc.
  ///
  /// In en, this message translates to:
  /// **'Soft glass and 3D icons'**
  String get themeClassicDesc;

  /// No description provided for @themeIvoryName.
  ///
  /// In en, this message translates to:
  /// **'Ivory'**
  String get themeIvoryName;

  /// No description provided for @themeIvoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Ivory, ink and gold with elegant serif titles'**
  String get themeIvoryDesc;

  /// No description provided for @themeModeSection.
  ///
  /// In en, this message translates to:
  /// **'Light or dark'**
  String get themeModeSection;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data'**
  String get profilePrivacy;

  /// No description provided for @profilePrivacySub.
  ///
  /// In en, this message translates to:
  /// **'Data and account controls'**
  String get profilePrivacySub;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback & help'**
  String get supportTitle;

  /// No description provided for @supportSub.
  ///
  /// In en, this message translates to:
  /// **'Suggestion, bug or question — replies arrive here'**
  String get supportSub;

  /// No description provided for @supportNew.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get supportNew;

  /// No description provided for @supportEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No requests yet'**
  String get supportEmptyTitle;

  /// No description provided for @supportEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Send a suggestion, report a bug or ask a question — the reply appears here.'**
  String get supportEmptyBody;

  /// No description provided for @supportKind.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get supportKind;

  /// No description provided for @supportKindSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get supportKindSuggestion;

  /// No description provided for @supportKindBug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get supportKindBug;

  /// No description provided for @supportKindQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get supportKindQuestion;

  /// No description provided for @supportSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get supportSubject;

  /// No description provided for @supportSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'In short: what is it about?'**
  String get supportSubjectHint;

  /// No description provided for @supportMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get supportMessage;

  /// No description provided for @supportMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Details: which screen, what you did and what you expected'**
  String get supportMessageHint;

  /// No description provided for @supportAttach.
  ///
  /// In en, this message translates to:
  /// **'Attach a screenshot (optional)'**
  String get supportAttach;

  /// No description provided for @supportAttachRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get supportAttachRemove;

  /// No description provided for @supportAttachTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The image is larger than 5 MB. Choose a smaller one.'**
  String get supportAttachTooLarge;

  /// No description provided for @supportAttachType.
  ///
  /// In en, this message translates to:
  /// **'PNG or JPEG only.'**
  String get supportAttachType;

  /// No description provided for @supportPhiNotice.
  ///
  /// In en, this message translates to:
  /// **'Make sure the screenshot shows no patient name, date of birth, record number or other personal data.'**
  String get supportPhiNotice;

  /// No description provided for @supportSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get supportSend;

  /// No description provided for @supportSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get supportSent;

  /// No description provided for @supportReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Write a reply…'**
  String get supportReplyHint;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide team'**
  String get supportTeam;

  /// No description provided for @supportYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get supportYou;

  /// No description provided for @supportUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get supportUser;

  /// No description provided for @supportHumanReplies.
  ///
  /// In en, this message translates to:
  /// **'Replies are written by the NurseGuide team; nothing is sent automatically.'**
  String get supportHumanReplies;

  /// No description provided for @supportStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get supportStatusNew;

  /// No description provided for @supportStatusInReview.
  ///
  /// In en, this message translates to:
  /// **'In review'**
  String get supportStatusInReview;

  /// No description provided for @supportStatusAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get supportStatusAnswered;

  /// No description provided for @supportStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get supportStatusClosed;

  /// No description provided for @supportUnread.
  ///
  /// In en, this message translates to:
  /// **'New reply'**
  String get supportUnread;

  /// No description provided for @supportUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} new {count, plural, =1{reply} other{replies}}'**
  String supportUnreadCount(int count);

  /// No description provided for @supportSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to send a request'**
  String get supportSignInTitle;

  /// No description provided for @supportSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Signing in with email lets us deliver the reply to you. Data on this device stays as it is.'**
  String get supportSignInBody;

  /// No description provided for @supportUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Server not connected yet'**
  String get supportUnavailableTitle;

  /// No description provided for @supportUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'This build has no account, feedback or groups server yet. Once connected, it works right here.'**
  String get supportUnavailableBody;

  /// No description provided for @errNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t connect. Check the internet and try again.'**
  String get errNetwork;

  /// No description provided for @errRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again a bit later.'**
  String get errRateLimited;

  /// No description provided for @errInvalidSupport.
  ///
  /// In en, this message translates to:
  /// **'The subject needs at least 3 characters and the message can’t be empty.'**
  String get errInvalidSupport;

  /// No description provided for @errForbidden.
  ///
  /// In en, this message translates to:
  /// **'You don’t have access to this.'**
  String get errForbidden;

  /// No description provided for @errSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get errSessionExpired;

  /// No description provided for @errGeneric.
  ///
  /// In en, this message translates to:
  /// **'That didn’t work. Please try again.'**
  String get errGeneric;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDelete;

  /// No description provided for @accountDeleteSub.
  ///
  /// In en, this message translates to:
  /// **'Removes your server account, requests and group memberships'**
  String get accountDeleteSub;

  /// No description provided for @accountDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get accountDeleteTitle;

  /// No description provided for @accountDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Your account, sign-in methods (Google/Apple links), group memberships and results and “Feedback & help” requests are permanently removed from the server. If you are a teacher, the groups you created are deleted too. This can’t be undone. The text of complaints you sent in the app stays, no longer linked to the account. Data on this device is cleared as well.'**
  String get accountDeleteBody;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get accountDeleted;

  /// No description provided for @adminTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin panel'**
  String get adminTitle;

  /// No description provided for @adminSub.
  ///
  /// In en, this message translates to:
  /// **'Moderation, support, content, admins'**
  String get adminSub;

  /// No description provided for @adminMfaTitle.
  ///
  /// In en, this message translates to:
  /// **'Two-step protection'**
  String get adminMfaTitle;

  /// No description provided for @adminMfaEnrollBody.
  ///
  /// In en, this message translates to:
  /// **'The admin panel needs an authenticator app (Google Authenticator, Microsoft Authenticator, 1Password…). Add the key to the app and enter the 6-digit code it shows.'**
  String get adminMfaEnrollBody;

  /// No description provided for @adminMfaVerifyBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code from your authenticator app.'**
  String get adminMfaVerifyBody;

  /// No description provided for @adminMfaSecret.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get adminMfaSecret;

  /// No description provided for @adminMfaCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy key'**
  String get adminMfaCopy;

  /// No description provided for @adminMfaOpen.
  ///
  /// In en, this message translates to:
  /// **'Open in authenticator'**
  String get adminMfaOpen;

  /// No description provided for @adminMfaCode.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get adminMfaCode;

  /// No description provided for @adminMfaVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get adminMfaVerify;

  /// No description provided for @adminMfaWrong.
  ///
  /// In en, this message translates to:
  /// **'The code is wrong or expired. Enter the current code from the app.'**
  String get adminMfaWrong;

  /// No description provided for @adminCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get adminCopied;

  /// No description provided for @adminForbiddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Admins only'**
  String get adminForbiddenTitle;

  /// No description provided for @adminForbiddenBody.
  ///
  /// In en, this message translates to:
  /// **'Admin access is granted by the server — the role or email in the app can’t change that.'**
  String get adminForbiddenBody;

  /// No description provided for @adminStats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get adminStats;

  /// No description provided for @adminRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get adminRegistered;

  /// No description provided for @adminNewToday.
  ///
  /// In en, this message translates to:
  /// **'New today'**
  String get adminNewToday;

  /// No description provided for @adminNew7.
  ///
  /// In en, this message translates to:
  /// **'New, 7 days'**
  String get adminNew7;

  /// No description provided for @adminNew30.
  ///
  /// In en, this message translates to:
  /// **'New, 30 days'**
  String get adminNew30;

  /// No description provided for @adminActiveToday.
  ///
  /// In en, this message translates to:
  /// **'Active today'**
  String get adminActiveToday;

  /// No description provided for @adminActive7.
  ///
  /// In en, this message translates to:
  /// **'Active, 7 days'**
  String get adminActive7;

  /// No description provided for @adminActive30.
  ///
  /// In en, this message translates to:
  /// **'Active, 30 days'**
  String get adminActive30;

  /// No description provided for @adminDefinitions.
  ///
  /// In en, this message translates to:
  /// **'Registered — an account whose email was confirmed with a code; guests and unconfirmed sign-ups aren’t counted. New — the day the email was first confirmed. Active — opened the app while signed in at least once in the period. Days use Tashkent time; “7 days” includes today.'**
  String get adminDefinitions;

  /// No description provided for @adminByRole.
  ///
  /// In en, this message translates to:
  /// **'By role'**
  String get adminByRole;

  /// No description provided for @adminByLanguage.
  ///
  /// In en, this message translates to:
  /// **'By language'**
  String get adminByLanguage;

  /// No description provided for @adminNoProfile.
  ///
  /// In en, this message translates to:
  /// **'No profile yet: {count}'**
  String adminNoProfile(int count);

  /// No description provided for @adminInbox.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get adminInbox;

  /// No description provided for @adminAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Awaiting reply: {count}'**
  String adminAwaiting(int count);

  /// No description provided for @adminAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adminAllStatuses;

  /// No description provided for @adminUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminUsers;

  /// No description provided for @adminAudit.
  ///
  /// In en, this message translates to:
  /// **'Action log'**
  String get adminAudit;

  /// No description provided for @adminAuditEmpty.
  ///
  /// In en, this message translates to:
  /// **'No actions yet'**
  String get adminAuditEmpty;

  /// No description provided for @adminSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by email'**
  String get adminSearchHint;

  /// No description provided for @adminAllRoles.
  ///
  /// In en, this message translates to:
  /// **'All roles'**
  String get adminAllRoles;

  /// No description provided for @adminAllLanguages.
  ///
  /// In en, this message translates to:
  /// **'All languages'**
  String get adminAllLanguages;

  /// No description provided for @adminShowEmail.
  ///
  /// In en, this message translates to:
  /// **'Show email (logged)'**
  String get adminShowEmail;

  /// No description provided for @adminPage.
  ///
  /// In en, this message translates to:
  /// **'{from}–{to} of {total}'**
  String adminPage(int from, int to, int total);

  /// No description provided for @adminPrev.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get adminPrev;

  /// No description provided for @adminNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get adminNext;

  /// No description provided for @adminRegisteredOn.
  ///
  /// In en, this message translates to:
  /// **'Registered: {date}'**
  String adminRegisteredOn(String date);

  /// No description provided for @adminLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last active: {date}'**
  String adminLastSeen(String date);

  /// No description provided for @adminNoUsers.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get adminNoUsers;

  /// No description provided for @adminReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Write your reply'**
  String get adminReplyHint;

  /// No description provided for @adminSendReply.
  ///
  /// In en, this message translates to:
  /// **'Send reply'**
  String get adminSendReply;

  /// No description provided for @adminStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminStatus;

  /// No description provided for @adminActionSupportReply.
  ///
  /// In en, this message translates to:
  /// **'Replied to request'**
  String get adminActionSupportReply;

  /// No description provided for @adminActionSupportStatus.
  ///
  /// In en, this message translates to:
  /// **'Request status changed'**
  String get adminActionSupportStatus;

  /// No description provided for @adminActionRevealEmail.
  ///
  /// In en, this message translates to:
  /// **'Email viewed'**
  String get adminActionRevealEmail;

  /// No description provided for @adminActionAdminGranted.
  ///
  /// In en, this message translates to:
  /// **'Admin access granted'**
  String get adminActionAdminGranted;

  /// No description provided for @adminActionAdminRevoked.
  ///
  /// In en, this message translates to:
  /// **'Admin access revoked'**
  String get adminActionAdminRevoked;

  /// No description provided for @profileSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with email'**
  String get profileSignIn;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @profileRestartSetup.
  ///
  /// In en, this message translates to:
  /// **'Restart setup'**
  String get profileRestartSetup;

  /// No description provided for @profileSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get profileSignOutTitle;

  /// No description provided for @profileSignOutBody.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks, notes and practice progress stay on this device. If someone else will use it, delete them too.'**
  String get profileSignOutBody;

  /// No description provided for @profileSignOutDelete.
  ///
  /// In en, this message translates to:
  /// **'Sign out and delete'**
  String get profileSignOutDelete;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String profileVersion(String version);

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and data'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'The core features work without an account (guest mode): settings, bookmarks and practice results stay on this device. An account is optional (email code, Google or Apple) and is needed for groups and “Feedback & help”. Then data is stored on a Cloudflare server (Eastern Europe, outside Uzbekistan): your email only as a hash and a masked form, sign-in method, role, language, last activity time (to the minute); in a group — your nickname or sequence number, test answers and scores; the text of requests and complaints. From Google/Apple only the account identifier and email are used; the token is not stored. A teacher sees only their own group. No ads, analytics or tracking. You can delete your account at any time with the “Delete account” button. Full text: the “Privacy policy” link.'**
  String get privacyBody;

  /// No description provided for @privacyBodyLocal.
  ///
  /// In en, this message translates to:
  /// **'This build has no server connected: the app sends nothing to a server. Settings, bookmarks and practice results stay on this device (they may be included in the device backup). No ads or tracking.'**
  String get privacyBodyLocal;

  /// No description provided for @privacyTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get privacyTerms;

  /// No description provided for @privacyTermsSub.
  ///
  /// In en, this message translates to:
  /// **'Final text to be prepared'**
  String get privacyTermsSub;

  /// No description provided for @privacyDeleteLocal.
  ///
  /// In en, this message translates to:
  /// **'Delete local data'**
  String get privacyDeleteLocal;

  /// No description provided for @privacyDeleteLocalSub.
  ///
  /// In en, this message translates to:
  /// **'Settings, bookmarks, unfinished tests and practice progress'**
  String get privacyDeleteLocalSub;

  /// No description provided for @privacyDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete local data?'**
  String get privacyDeleteConfirmTitle;

  /// No description provided for @privacyDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Settings, bookmarks, unfinished tests and practice progress on this device will be removed. This can’t be undone.'**
  String get privacyDeleteConfirmBody;

  /// No description provided for @privacyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Local data deleted'**
  String get privacyDeleted;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsTitle;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide is a free reference and learning app for nurses. By using the app you agree to these terms.\n\n1. Medical limitation. NurseGuide does not diagnose, prescribe treatment or medicines, and does not replace your institution\'s approved procedures, medicine instructions or a physician\'s orders. Every item shows its source; when making decisions, rely on the original source and your institution\'s rules.\n\n2. Account. Some features (groups, tests, support requests) require signing up with email. You are responsible for your account\'s security and for actions taken through it. You can delete your account at any time: Profile → Privacy and data → Delete account.\n\n3. Teacher and student groups. When a student joins a group, the teacher sees their nickname (or seat number) and test results. Teachers use groups for educational purposes only.\n\n4. User content. You are responsible for what you write in support requests. Abuse, illegal content, advertising, other people\'s personal data and non-consensual intimate images are strictly prohibited. Such content is removed, and the offending account may be restricted or deleted.\n\n5. Copyright. The app\'s texts, slides, tests and design belong to the NurseGuide authors; external sources are shown with their own licences. They may not be copied or distributed for commercial purposes.\n\n6. Service. The app is provided “as is”; outages and errors may occur, and we fix them as quickly as we can. We will notify you in the app if these terms change.\n\n7. Privacy. How your data is used is described in the privacy policy: nurseguide.nfcstore.uz/privacy\n\n8. Contact: nurseguide@nfcstore.uz'**
  String get termsBody;

  /// No description provided for @rightsUnknown.
  ///
  /// In en, this message translates to:
  /// **'Distribution rights not confirmed'**
  String get rightsUnknown;

  /// No description provided for @rightsPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal study only — not distributed'**
  String get rightsPersonal;

  /// No description provided for @rightsPermitted.
  ///
  /// In en, this message translates to:
  /// **'Distribution permission recorded'**
  String get rightsPermitted;

  /// No description provided for @rightsDenied.
  ///
  /// In en, this message translates to:
  /// **'Distribution not permitted'**
  String get rightsDenied;

  /// No description provided for @kindBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get kindBook;

  /// No description provided for @kindManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get kindManual;

  /// No description provided for @kindMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get kindMethod;

  /// No description provided for @kindArticle.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get kindArticle;

  /// No description provided for @kindQuestionSet.
  ///
  /// In en, this message translates to:
  /// **'Question set'**
  String get kindQuestionSet;

  /// No description provided for @kindWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get kindWebsite;

  /// No description provided for @libAccessOpen.
  ///
  /// In en, this message translates to:
  /// **'Open licence · {licence}'**
  String libAccessOpen(String licence);

  /// No description provided for @libAccessFree.
  ///
  /// In en, this message translates to:
  /// **'Free to read · link only'**
  String get libAccessFree;

  /// No description provided for @libAccessCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalogue record only'**
  String get libAccessCatalog;

  /// No description provided for @libOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open the official page'**
  String get libOpenSource;

  /// No description provided for @libChecked.
  ///
  /// In en, this message translates to:
  /// **'Page and licence checked: {date}'**
  String libChecked(String date);

  /// No description provided for @libItemPack.
  ///
  /// In en, this message translates to:
  /// **'Offline pack · {size}'**
  String libItemPack(String size);

  /// No description provided for @libItemSupersedes.
  ///
  /// In en, this message translates to:
  /// **'Newer edition of: {title}'**
  String libItemSupersedes(String title);

  /// No description provided for @libSearchEntry.
  ///
  /// In en, this message translates to:
  /// **'Search books, authors, topics'**
  String get libSearchEntry;

  /// No description provided for @libBooksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sources · search and filters'**
  String libBooksCount(int count);

  /// No description provided for @libContinueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue reading'**
  String get libContinueReading;

  /// No description provided for @libSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search the library'**
  String get libSearchLabel;

  /// No description provided for @libSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Title, author, topic…'**
  String get libSearchHint;

  /// No description provided for @libFilterLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get libFilterLanguage;

  /// No description provided for @libFilterTopic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get libFilterTopic;

  /// No description provided for @libFilterType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get libFilterType;

  /// No description provided for @libFilterSectionField.
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get libFilterSectionField;

  /// No description provided for @libFilterSectionGroup.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get libFilterSectionGroup;

  /// No description provided for @libFilterSectionKind.
  ///
  /// In en, this message translates to:
  /// **'Material type'**
  String get libFilterSectionKind;

  /// No description provided for @libFilterSectionOpen.
  ///
  /// In en, this message translates to:
  /// **'How it opens'**
  String get libFilterSectionOpen;

  /// No description provided for @libResultCount.
  ///
  /// In en, this message translates to:
  /// **'{shown} of {total} materials'**
  String libResultCount(int shown, int total);

  /// No description provided for @libClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get libClearFilters;

  /// No description provided for @libFilteredEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No materials match these filters'**
  String get libFilteredEmptyTitle;

  /// No description provided for @libFilteredEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Remove one filter or try another word — for example an author’s surname.'**
  String get libFilteredEmptyBody;

  /// No description provided for @libOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Link · external website'**
  String get libOpenLink;

  /// No description provided for @libOpenLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Opens in your browser: {host}'**
  String libOpenLinkHint(String host);

  /// No description provided for @libOpenInApp.
  ///
  /// In en, this message translates to:
  /// **'In-app file'**
  String get libOpenInApp;

  /// No description provided for @libOpenInAppHint.
  ///
  /// In en, this message translates to:
  /// **'Read inside the app — no internet needed'**
  String get libOpenInAppHint;

  /// No description provided for @libOpenDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloadable book'**
  String get libOpenDownload;

  /// No description provided for @libOpenDownloadHint.
  ///
  /// In en, this message translates to:
  /// **'Read in the app after download · {size}'**
  String libOpenDownloadHint(String size);

  /// No description provided for @libOpenPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get libOpenPending;

  /// No description provided for @libOpenPendingHint.
  ///
  /// In en, this message translates to:
  /// **'Not received yet — cannot be opened'**
  String get libOpenPendingHint;

  /// No description provided for @libOpenReceivedHint.
  ///
  /// In en, this message translates to:
  /// **'File received and being checked — not available yet'**
  String get libOpenReceivedHint;

  /// No description provided for @libOpenRecordHint.
  ///
  /// In en, this message translates to:
  /// **'No distribution rights recorded — not opened in the app'**
  String get libOpenRecordHint;

  /// No description provided for @libOpenLinkShort.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get libOpenLinkShort;

  /// No description provided for @libOpenInAppShort.
  ///
  /// In en, this message translates to:
  /// **'In the app'**
  String get libOpenInAppShort;

  /// No description provided for @libOpenDownloadShort.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get libOpenDownloadShort;

  /// No description provided for @libOpenRecordShort.
  ///
  /// In en, this message translates to:
  /// **'Record only'**
  String get libOpenRecordShort;

  /// No description provided for @libItemRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get libItemRead;

  /// No description provided for @libItemContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue from page {page}'**
  String libItemContinue(int page);

  /// No description provided for @libItemCannotOpen.
  ///
  /// In en, this message translates to:
  /// **'Cannot be opened'**
  String get libItemCannotOpen;

  /// No description provided for @libDownloadUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The download server is not connected yet — the book can’t be downloaded for now.'**
  String get libDownloadUnavailable;

  /// No description provided for @libDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get libDetailsTitle;

  /// No description provided for @libFieldAuthors.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get libFieldAuthors;

  /// No description provided for @libFieldYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get libFieldYear;

  /// No description provided for @libFieldEdition.
  ///
  /// In en, this message translates to:
  /// **'Edition'**
  String get libFieldEdition;

  /// No description provided for @libFieldPublisher.
  ///
  /// In en, this message translates to:
  /// **'Publisher'**
  String get libFieldPublisher;

  /// No description provided for @libFieldAccess.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get libFieldAccess;

  /// No description provided for @libFieldStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get libFieldStatus;

  /// No description provided for @libFieldRights.
  ///
  /// In en, this message translates to:
  /// **'Distribution rights'**
  String get libFieldRights;

  /// No description provided for @libFieldRightsRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded: {date} · {by}'**
  String libFieldRightsRecorded(String date, String by);

  /// No description provided for @libFieldTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get libFieldTopics;

  /// No description provided for @libFieldPages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get libFieldPages;

  /// No description provided for @libStateNotReceived.
  ///
  /// In en, this message translates to:
  /// **'Not received yet'**
  String get libStateNotReceived;

  /// No description provided for @libStateReceived.
  ///
  /// In en, this message translates to:
  /// **'Received, being checked'**
  String get libStateReceived;

  /// No description provided for @libStateCataloged.
  ///
  /// In en, this message translates to:
  /// **'Catalogued'**
  String get libStateCataloged;

  /// No description provided for @libStateLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked to cards'**
  String get libStateLinked;

  /// No description provided for @libStateReviewed.
  ///
  /// In en, this message translates to:
  /// **'Approved by a teacher'**
  String get libStateReviewed;

  /// No description provided for @libProvidedByTeacher.
  ///
  /// In en, this message translates to:
  /// **'Provided by a teacher'**
  String get libProvidedByTeacher;

  /// No description provided for @libItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'Material not found'**
  String get libItemNotFound;

  /// No description provided for @libItemNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'The content pack may have been updated. Go back to the catalog.'**
  String get libItemNotFoundBody;

  /// No description provided for @libItemUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This material is not available in your language'**
  String get libItemUnavailable;

  /// No description provided for @libItemUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'This material is currently available only in another language. Change the interface language or go back to the catalog.'**
  String get libItemUnavailableBody;

  /// No description provided for @libBackToCatalog.
  ///
  /// In en, this message translates to:
  /// **'Back to catalog'**
  String get libBackToCatalog;

  /// No description provided for @readerTitle.
  ///
  /// In en, this message translates to:
  /// **'Reader'**
  String get readerTitle;

  /// No description provided for @readerPageOf.
  ///
  /// In en, this message translates to:
  /// **'{page} of {total}'**
  String readerPageOf(int page, int total);

  /// No description provided for @readerToc.
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get readerToc;

  /// No description provided for @readerTocEmpty.
  ///
  /// In en, this message translates to:
  /// **'This file has no table of contents'**
  String get readerTocEmpty;

  /// No description provided for @readerTocEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Go to a page or bookmark the place you need.'**
  String get readerTocEmptyBody;

  /// No description provided for @readerBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get readerBookmarks;

  /// No description provided for @readerAddBookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark this page'**
  String get readerAddBookmark;

  /// No description provided for @readerBookmarkName.
  ///
  /// In en, this message translates to:
  /// **'Bookmark name'**
  String get readerBookmarkName;

  /// No description provided for @readerBookmarkNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example: key table'**
  String get readerBookmarkNameHint;

  /// No description provided for @readerBookmarkSaved.
  ///
  /// In en, this message translates to:
  /// **'Bookmark saved: page {page}'**
  String readerBookmarkSaved(int page);

  /// No description provided for @readerBookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'Bookmark removed'**
  String get readerBookmarkRemoved;

  /// No description provided for @readerBookmarkRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove bookmark'**
  String get readerBookmarkRemove;

  /// No description provided for @readerBookmarksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get readerBookmarksEmpty;

  /// No description provided for @readerBookmarksEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'On the page you need, tap “Bookmark this page” — then return with one tap.'**
  String get readerBookmarksEmptyBody;

  /// No description provided for @readerPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String readerPageLabel(int page);

  /// No description provided for @readerGoTo.
  ///
  /// In en, this message translates to:
  /// **'Go to page'**
  String get readerGoTo;

  /// No description provided for @readerGoToShort.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get readerGoToShort;

  /// No description provided for @readerGoToHint.
  ///
  /// In en, this message translates to:
  /// **'1 to {total}'**
  String readerGoToHint(int total);

  /// No description provided for @readerGoToError.
  ///
  /// In en, this message translates to:
  /// **'Enter a number from 1 to {total}'**
  String readerGoToError(int total);

  /// No description provided for @readerGo.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get readerGo;

  /// No description provided for @readerSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get readerSave;

  /// No description provided for @readerRenameBookmark.
  ///
  /// In en, this message translates to:
  /// **'Rename bookmark'**
  String get readerRenameBookmark;

  /// No description provided for @libFieldProvidedBy.
  ///
  /// In en, this message translates to:
  /// **'Provided by'**
  String get libFieldProvidedBy;

  /// No description provided for @libQueryEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Try another word — for example an author’s surname or a topic name.'**
  String get libQueryEmptyBody;

  /// No description provided for @readerZoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get readerZoomIn;

  /// No description provided for @readerZoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get readerZoomOut;

  /// No description provided for @readerResumed.
  ///
  /// In en, this message translates to:
  /// **'Resumed at page {page}'**
  String readerResumed(int page);

  /// No description provided for @readerFromStart.
  ///
  /// In en, this message translates to:
  /// **'From start'**
  String get readerFromStart;

  /// No description provided for @readerLoading.
  ///
  /// In en, this message translates to:
  /// **'Opening the file…'**
  String get readerLoading;

  /// No description provided for @readerFileMissing.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get readerFileMissing;

  /// No description provided for @readerFileMissingBody.
  ///
  /// In en, this message translates to:
  /// **'This file isn’t in the app. Try updating the app.'**
  String get readerFileMissingBody;

  /// No description provided for @readerFileCorrupted.
  ///
  /// In en, this message translates to:
  /// **'The file failed verification'**
  String get readerFileCorrupted;

  /// No description provided for @readerFileCorruptedBody.
  ///
  /// In en, this message translates to:
  /// **'The file size or checksum doesn’t match the catalog — it may be damaged or replaced, so it wasn’t opened.'**
  String get readerFileCorruptedBody;

  /// No description provided for @readerOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the PDF'**
  String get readerOpenFailed;

  /// No description provided for @readerBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Not available in the app'**
  String get readerBlockedTitle;

  /// No description provided for @readerBlockedRights.
  ///
  /// In en, this message translates to:
  /// **'Only files with fully recorded distribution rights open in the app. This material has no such file.'**
  String get readerBlockedRights;

  /// No description provided for @readerBookmarkedPage.
  ///
  /// In en, this message translates to:
  /// **'This page is bookmarked'**
  String get readerBookmarkedPage;

  /// No description provided for @lessonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lesson topics'**
  String get lessonsTitle;

  /// No description provided for @classesSeat.
  ///
  /// In en, this message translates to:
  /// **'Student {n}'**
  String classesSeat(String n);

  /// No description provided for @classesQrLabel.
  ///
  /// In en, this message translates to:
  /// **'Invite code QR: {code}'**
  String classesQrLabel(String code);

  /// No description provided for @classesTeacherRegisterEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get classesTeacherRegisterEyebrow;

  /// No description provided for @classesTeacherRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Register as a teacher'**
  String get classesTeacherRegisterTitle;

  /// No description provided for @classesTeacherRegisterBody.
  ///
  /// In en, this message translates to:
  /// **'A teacher opens their own class and sees only their students’ results. This isn’t admin access and doesn’t affect other classes.'**
  String get classesTeacherRegisterBody;

  /// No description provided for @classesTeacherRegister.
  ///
  /// In en, this message translates to:
  /// **'Register as a teacher'**
  String get classesTeacherRegister;

  /// No description provided for @classesLocalNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Label (this device only)'**
  String get classesLocalNameTitle;

  /// No description provided for @classesLocalNameBody.
  ///
  /// In en, this message translates to:
  /// **'For example, the student’s name. It isn’t sent to the server and the student can’t see it.'**
  String get classesLocalNameBody;

  /// No description provided for @classesLocalNameHint.
  ///
  /// In en, this message translates to:
  /// **'Empty — remove the label'**
  String get classesLocalNameHint;

  /// No description provided for @classesLocalNameSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get classesLocalNameSave;

  /// No description provided for @classroomPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Course plan'**
  String get classroomPlanTitle;

  /// No description provided for @classroomPlanSub.
  ///
  /// In en, this message translates to:
  /// **'Topics by day: lecture, oral questions, test'**
  String get classroomPlanSub;

  /// No description provided for @classroomTopicsTitle.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get classroomTopicsTitle;

  /// No description provided for @classroomTopicsSub.
  ///
  /// In en, this message translates to:
  /// **'Topics and tests your teacher has opened'**
  String get classroomTopicsSub;

  /// No description provided for @classroomProgramEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Curriculum'**
  String get classroomProgramEyebrow;

  /// No description provided for @classroomPlanProgress.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} topic tests finished'**
  String classroomPlanProgress(int done, int total);

  /// No description provided for @classroomStartNone.
  ///
  /// In en, this message translates to:
  /// **'No start date — the plan is shown by day number'**
  String get classroomStartNone;

  /// No description provided for @classroomStartAt.
  ///
  /// In en, this message translates to:
  /// **'Day 1: {date}'**
  String classroomStartAt(String date);

  /// No description provided for @classroomStartNote.
  ///
  /// In en, this message translates to:
  /// **'Dates are approximate (Sundays skipped, holidays not counted) and stored only on this device.'**
  String get classroomStartNote;

  /// No description provided for @classroomStartPick.
  ///
  /// In en, this message translates to:
  /// **'Set the start date'**
  String get classroomStartPick;

  /// No description provided for @classroomDayN.
  ///
  /// In en, this message translates to:
  /// **'Day {n}'**
  String classroomDayN(int n);

  /// No description provided for @classroomWeekN.
  ///
  /// In en, this message translates to:
  /// **'Week {n}'**
  String classroomWeekN(int n);

  /// No description provided for @classroomHours.
  ///
  /// In en, this message translates to:
  /// **'{n} h'**
  String classroomHours(int n);

  /// No description provided for @classroomTypeLecture.
  ///
  /// In en, this message translates to:
  /// **'Lecture'**
  String get classroomTypeLecture;

  /// No description provided for @classroomTypePractical.
  ///
  /// In en, this message translates to:
  /// **'Practical'**
  String get classroomTypePractical;

  /// No description provided for @classroomTypeSeminar.
  ///
  /// In en, this message translates to:
  /// **'Seminar'**
  String get classroomTypeSeminar;

  /// No description provided for @classroomTypeAttestation.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get classroomTypeAttestation;

  /// No description provided for @classroomTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get classroomTypeOther;

  /// No description provided for @classroomStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Not opened'**
  String get classroomStatusClosed;

  /// No description provided for @classroomStatusOpened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get classroomStatusOpened;

  /// No description provided for @classroomStatusLectured.
  ///
  /// In en, this message translates to:
  /// **'Taught'**
  String get classroomStatusLectured;

  /// No description provided for @classroomStatusOral.
  ///
  /// In en, this message translates to:
  /// **'Oral round done'**
  String get classroomStatusOral;

  /// No description provided for @classroomStatusTestRunning.
  ///
  /// In en, this message translates to:
  /// **'Test in progress'**
  String get classroomStatusTestRunning;

  /// No description provided for @classroomStatusTestDone.
  ///
  /// In en, this message translates to:
  /// **'Test finished'**
  String get classroomStatusTestDone;

  /// No description provided for @classroomNoCurriculumTitle.
  ///
  /// In en, this message translates to:
  /// **'The curriculum hasn’t been added yet'**
  String get classroomNoCurriculumTitle;

  /// No description provided for @classroomNoCurriculumBody.
  ///
  /// In en, this message translates to:
  /// **'The course plan (module → topic → materials) will come in a later app version. For now, use class assignments.'**
  String get classroomNoCurriculumBody;

  /// No description provided for @classroomCurriculumError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t read the curriculum'**
  String get classroomCurriculumError;

  /// No description provided for @classroomNoTopicsStudent.
  ///
  /// In en, this message translates to:
  /// **'Your teacher hasn’t opened any topics yet'**
  String get classroomNoTopicsStudent;

  /// No description provided for @classroomNoTopicsStudentBody.
  ///
  /// In en, this message translates to:
  /// **'When a topic opens, its materials and test will appear here.'**
  String get classroomNoTopicsStudentBody;

  /// No description provided for @classroomTopicTitle.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get classroomTopicTitle;

  /// No description provided for @classroomTopicMissing.
  ///
  /// In en, this message translates to:
  /// **'Topic not found in the curriculum'**
  String get classroomTopicMissing;

  /// No description provided for @classroomTopicNotOpened.
  ///
  /// In en, this message translates to:
  /// **'This topic isn’t open yet'**
  String get classroomTopicNotOpened;

  /// No description provided for @classroomOpenNote.
  ///
  /// In en, this message translates to:
  /// **'Once opened, students see the topic materials.'**
  String get classroomOpenNote;

  /// No description provided for @classroomOpenTopic.
  ///
  /// In en, this message translates to:
  /// **'Open to students'**
  String get classroomOpenTopic;

  /// No description provided for @classroomStep.
  ///
  /// In en, this message translates to:
  /// **'Step {n}'**
  String classroomStep(int n);

  /// No description provided for @classroomStageLecture.
  ///
  /// In en, this message translates to:
  /// **'Lecture'**
  String get classroomStageLecture;

  /// No description provided for @classroomStageLectureBody.
  ///
  /// In en, this message translates to:
  /// **'Present the topic as slides on a big screen (works offline too).'**
  String get classroomStageLectureBody;

  /// No description provided for @classroomStageOral.
  ///
  /// In en, this message translates to:
  /// **'Oral questions'**
  String get classroomStageOral;

  /// No description provided for @classroomStageOralBody.
  ///
  /// In en, this message translates to:
  /// **'Question list with answer outlines. Asked: {count}.'**
  String classroomStageOralBody(int count);

  /// No description provided for @classroomStageTest.
  ///
  /// In en, this message translates to:
  /// **'Class test'**
  String get classroomStageTest;

  /// No description provided for @classroomStageTestBody.
  ///
  /// In en, this message translates to:
  /// **'Pick questions and start the test — it opens for students right away.'**
  String get classroomStageTestBody;

  /// No description provided for @classroomStageDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get classroomStageDone;

  /// No description provided for @classroomMarkDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get classroomMarkDone;

  /// No description provided for @classroomOralOpen.
  ///
  /// In en, this message translates to:
  /// **'Question list'**
  String get classroomOralOpen;

  /// No description provided for @classroomTestPrepare.
  ///
  /// In en, this message translates to:
  /// **'Prepare the test'**
  String get classroomTestPrepare;

  /// No description provided for @classroomTestResults.
  ///
  /// In en, this message translates to:
  /// **'Results panel'**
  String get classroomTestResults;

  /// No description provided for @classroomTestFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish the test'**
  String get classroomTestFinish;

  /// No description provided for @classroomTestFinishTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish the test?'**
  String get classroomTestFinishTitle;

  /// No description provided for @classroomTestFinishBody.
  ///
  /// In en, this message translates to:
  /// **'No new attempts are accepted. Those who already started get 2 minutes to send their answers.'**
  String get classroomTestFinishBody;

  /// No description provided for @classroomTestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} students submitted'**
  String classroomTestSubmitted(int done, int total);

  /// No description provided for @classroomTestNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Your teacher hasn’t started the test yet.'**
  String get classroomTestNotStarted;

  /// No description provided for @classroomTestOpenStudent.
  ///
  /// In en, this message translates to:
  /// **'Test open — take it'**
  String get classroomTestOpenStudent;

  /// No description provided for @classroomMaterials.
  ///
  /// In en, this message translates to:
  /// **'Topic materials'**
  String get classroomMaterials;

  /// No description provided for @classroomNoMaterials.
  ///
  /// In en, this message translates to:
  /// **'The app has no linked materials for this topic yet.'**
  String get classroomNoMaterials;

  /// No description provided for @classroomGapNote.
  ///
  /// In en, this message translates to:
  /// **'The app has little material on this topic — the teacher adds their own sources.'**
  String get classroomGapNote;

  /// Shown next to M9 practical-day topics whose title is a NurseGuide recommendation (the timetable gives only a generic title); the teacher may change it.
  ///
  /// In en, this message translates to:
  /// **'NurseGuide recommended practical plan'**
  String get classroomPlanRecommended;

  /// No description provided for @classroomOralNotice.
  ///
  /// In en, this message translates to:
  /// **'Questions are auto-picked candidates; answer outlines are a study aid. “Asked” marks and grades stay on this device only.'**
  String get classroomOralNotice;

  /// No description provided for @classroomOralEmpty.
  ///
  /// In en, this message translates to:
  /// **'No oral questions for this topic'**
  String get classroomOralEmpty;

  /// No description provided for @classroomCandidate.
  ///
  /// In en, this message translates to:
  /// **'Candidate question {n}'**
  String classroomCandidate(int n);

  /// No description provided for @classroomOralPlan.
  ///
  /// In en, this message translates to:
  /// **'Short answer outline'**
  String get classroomOralPlan;

  /// No description provided for @classroomOralNoPlan.
  ///
  /// In en, this message translates to:
  /// **'No answer outline yet.'**
  String get classroomOralNoPlan;

  /// No description provided for @classroomOralAsked.
  ///
  /// In en, this message translates to:
  /// **'Asked'**
  String get classroomOralAsked;

  /// No description provided for @classroomOralGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade students ({count})'**
  String classroomOralGrade(int count);

  /// No description provided for @classroomOralGradeTitle.
  ///
  /// In en, this message translates to:
  /// **'How each student answered'**
  String get classroomOralGradeTitle;

  /// No description provided for @classroomOralGradeNote.
  ///
  /// In en, this message translates to:
  /// **'This device only; not sent to the server.'**
  String get classroomOralGradeNote;

  /// No description provided for @classroomGradeKnew.
  ///
  /// In en, this message translates to:
  /// **'Knew'**
  String get classroomGradeKnew;

  /// No description provided for @classroomGradePartial.
  ///
  /// In en, this message translates to:
  /// **'Partly'**
  String get classroomGradePartial;

  /// No description provided for @classroomGradeDidNot.
  ///
  /// In en, this message translates to:
  /// **'Didn’t know'**
  String get classroomGradeDidNot;

  /// No description provided for @classroomCandidatesNotice.
  ///
  /// In en, this message translates to:
  /// **'Candidate questions were auto-picked. Look through each one and its key: the score is computed on the server using the key shown.'**
  String get classroomCandidatesNotice;

  /// No description provided for @classroomCandidatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Candidates · picked {picked}/{total}'**
  String classroomCandidatesTitle(int picked, int total);

  /// No description provided for @classroomPickAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get classroomPickAll;

  /// No description provided for @classroomPickNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get classroomPickNone;

  /// No description provided for @classroomKeyShown.
  ///
  /// In en, this message translates to:
  /// **'Key: {answer}'**
  String classroomKeyShown(String answer);

  /// No description provided for @classroomKeyFlagged.
  ///
  /// In en, this message translates to:
  /// **'Disputed key'**
  String get classroomKeyFlagged;

  /// No description provided for @classroomPickAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one question'**
  String get classroomPickAtLeastOne;

  /// No description provided for @classroomPickMax.
  ///
  /// In en, this message translates to:
  /// **'At most 50 questions'**
  String get classroomPickMax;

  /// No description provided for @classroomTestStart.
  ///
  /// In en, this message translates to:
  /// **'Start the test · {count} questions'**
  String classroomTestStart(int count);

  /// No description provided for @classroomTestStarted.
  ///
  /// In en, this message translates to:
  /// **'Test started — open for students'**
  String get classroomTestStarted;

  /// No description provided for @classroomTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Test: {topic}'**
  String classroomTestTitle(String topic);

  /// No description provided for @classroomTestAlready.
  ///
  /// In en, this message translates to:
  /// **'This topic’s test has already started'**
  String get classroomTestAlready;

  /// No description provided for @classroomTestNoCandidates.
  ///
  /// In en, this message translates to:
  /// **'No test questions for this topic'**
  String get classroomTestNoCandidates;

  /// No description provided for @classroomTestNoCandidatesBody.
  ///
  /// In en, this message translates to:
  /// **'You can build an assignment by hand (New assignment).'**
  String get classroomTestNoCandidatesBody;

  /// No description provided for @lectureTitle.
  ///
  /// In en, this message translates to:
  /// **'Lecture'**
  String get lectureTitle;

  /// No description provided for @lectureListTitle.
  ///
  /// In en, this message translates to:
  /// **'Lecture mode'**
  String get lectureListTitle;

  /// No description provided for @lectureListSub.
  ///
  /// In en, this message translates to:
  /// **'Pick a topic — slides on a big screen, offline'**
  String get lectureListSub;

  /// No description provided for @lectureStart.
  ///
  /// In en, this message translates to:
  /// **'Start the lecture'**
  String get lectureStart;

  /// No description provided for @lectureClose.
  ///
  /// In en, this message translates to:
  /// **'Close the lecture'**
  String get lectureClose;

  /// No description provided for @lectureCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String lectureCounter(int current, int total);

  /// No description provided for @lecturePrev.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get lecturePrev;

  /// No description provided for @lectureNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get lectureNext;

  /// No description provided for @lectureGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get lectureGoals;

  /// No description provided for @lectureKeyPoints.
  ///
  /// In en, this message translates to:
  /// **'Key concepts'**
  String get lectureKeyPoints;

  /// No description provided for @lectureQuestionN.
  ///
  /// In en, this message translates to:
  /// **'Question {n}'**
  String lectureQuestionN(int n);

  /// No description provided for @lectureEndEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get lectureEndEyebrow;

  /// No description provided for @lectureEndTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions and test'**
  String get lectureEndTitle;

  /// No description provided for @lectureEndOral.
  ///
  /// In en, this message translates to:
  /// **'Oral questions — asked by the teacher'**
  String get lectureEndOral;

  /// No description provided for @lectureEndTest.
  ///
  /// In en, this message translates to:
  /// **'Class test — in the app, timed'**
  String get lectureEndTest;

  /// No description provided for @lectureUzOnly.
  ///
  /// In en, this message translates to:
  /// **'This presentation is in Uzbek only for now'**
  String get lectureUzOnly;

  /// No description provided for @lectureNotesShow.
  ///
  /// In en, this message translates to:
  /// **'Show teacher notes'**
  String get lectureNotesShow;

  /// No description provided for @lectureNotesHide.
  ///
  /// In en, this message translates to:
  /// **'Hide teacher notes'**
  String get lectureNotesHide;

  /// No description provided for @lectureTeacherNote.
  ///
  /// In en, this message translates to:
  /// **'Teacher note'**
  String get lectureTeacherNote;

  /// No description provided for @cmAdminDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get cmAdminDone;

  /// No description provided for @admYouSuper.
  ///
  /// In en, this message translates to:
  /// **'You are the owner (super admin)'**
  String get admYouSuper;

  /// No description provided for @admYouAdmin.
  ///
  /// In en, this message translates to:
  /// **'You are an admin'**
  String get admYouAdmin;

  /// No description provided for @adm2faOn.
  ///
  /// In en, this message translates to:
  /// **'Two-step protection (2FA) is confirmed. It is required for every admin action.'**
  String get adm2faOn;

  /// No description provided for @admNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected on this server yet'**
  String get admNotConnected;

  /// No description provided for @admTeam.
  ///
  /// In en, this message translates to:
  /// **'Admin management'**
  String get admTeam;

  /// No description provided for @admTeamCount.
  ///
  /// In en, this message translates to:
  /// **'Admins: {count}'**
  String admTeamCount(int count);

  /// No description provided for @admTeamSubManage.
  ///
  /// In en, this message translates to:
  /// **'Add by email and remove'**
  String get admTeamSubManage;

  /// No description provided for @admTeamSubView.
  ///
  /// In en, this message translates to:
  /// **'List (only the owner can change it)'**
  String get admTeamSubView;

  /// No description provided for @admLegacyNote.
  ///
  /// In en, this message translates to:
  /// **'Statistics, users and action history are not on this server yet — they will appear here when ready.'**
  String get admLegacyNote;

  /// No description provided for @admOther.
  ///
  /// In en, this message translates to:
  /// **'Other sections'**
  String get admOther;

  /// No description provided for @admTeamIntro.
  ///
  /// In en, this message translates to:
  /// **'An admin gets full access to every admin section: support threads, users, complaints. Only the server grants this, and every action needs a 2FA code.'**
  String get admTeamIntro;

  /// No description provided for @admTeamOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'Only the owner (super admin) can add and remove admins.'**
  String get admTeamOwnerOnly;

  /// No description provided for @admAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add an admin'**
  String get admAddTitle;

  /// No description provided for @admAddEmail.
  ///
  /// In en, this message translates to:
  /// **'Email (e.g. Gmail)'**
  String get admAddEmail;

  /// No description provided for @admAddHint.
  ///
  /// In en, this message translates to:
  /// **'Access takes effect once they sign in with this email and set up 2FA; if the account exists — right away.'**
  String get admAddHint;

  /// No description provided for @admAddButton.
  ///
  /// In en, this message translates to:
  /// **'Make admin'**
  String get admAddButton;

  /// No description provided for @admAddConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Make this person an admin?'**
  String get admAddConfirmTitle;

  /// No description provided for @admAddConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'{email} will get full access to every admin section. You can remove them at any time.'**
  String admAddConfirmBody(String email);

  /// No description provided for @admAdded.
  ///
  /// In en, this message translates to:
  /// **'Added: {email}'**
  String admAdded(String email);

  /// No description provided for @admInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email. For example: name@gmail.com'**
  String get admInvalidEmail;

  /// No description provided for @admErrAlready.
  ///
  /// In en, this message translates to:
  /// **'This email is already an admin.'**
  String get admErrAlready;

  /// No description provided for @admErrSuper.
  ///
  /// In en, this message translates to:
  /// **'This is the owner’s email (super admin) — already an admin.'**
  String get admErrSuper;

  /// No description provided for @admErrTooMany.
  ///
  /// In en, this message translates to:
  /// **'Admin limit: {max}. Remove someone first.'**
  String admErrTooMany(int max);

  /// No description provided for @admListTitle.
  ///
  /// In en, this message translates to:
  /// **'Admins ({count})'**
  String admListTitle(int count);

  /// No description provided for @admKindSuper.
  ///
  /// In en, this message translates to:
  /// **'Owner · super admin'**
  String get admKindSuper;

  /// No description provided for @admKindGranted.
  ///
  /// In en, this message translates to:
  /// **'Admin · added {date}'**
  String admKindGranted(String date);

  /// No description provided for @admNotSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Not signed in yet — access starts at first sign-in'**
  String get admNotSignedIn;

  /// No description provided for @admYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get admYou;

  /// No description provided for @admRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get admRemove;

  /// No description provided for @admRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove this admin?'**
  String get admRemoveTitle;

  /// No description provided for @admRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'{email} loses admin access immediately — on every device. Their account and data are not deleted.'**
  String admRemoveBody(String email);

  /// No description provided for @admRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed: {email}'**
  String admRemoved(String email);

  /// No description provided for @admSuperNote.
  ///
  /// In en, this message translates to:
  /// **'The owner is set in a secret server setting (LG_ADMIN_EMAILS) and cannot be removed from the app.'**
  String get admSuperNote;

  /// No description provided for @admNoGranted.
  ///
  /// In en, this message translates to:
  /// **'No admins added yet.'**
  String get admNoGranted;

  /// No description provided for @adminActionGrantAdded.
  ///
  /// In en, this message translates to:
  /// **'Admin added'**
  String get adminActionGrantAdded;

  /// No description provided for @adminActionGrantRemoved.
  ///
  /// In en, this message translates to:
  /// **'Admin removed'**
  String get adminActionGrantRemoved;

  /// No description provided for @contactPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get contactPrivacyPolicy;

  /// No description provided for @autoPresTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic presentation'**
  String get autoPresTitle;

  /// No description provided for @autoPresEntrySub.
  ///
  /// In en, this message translates to:
  /// **'Slides built from the app’s sourced content'**
  String get autoPresEntrySub;

  /// No description provided for @autoPresShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show answer'**
  String get autoPresShowAnswer;

  /// No description provided for @autoPresHideAnswer.
  ///
  /// In en, this message translates to:
  /// **'Hide answer'**
  String get autoPresHideAnswer;

  /// No description provided for @contactRowTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact & reports'**
  String get contactRowTitle;

  /// No description provided for @contactRowSub.
  ///
  /// In en, this message translates to:
  /// **'Questions, complaints, report a problem'**
  String get contactRowSub;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactIntro.
  ///
  /// In en, this message translates to:
  /// **'Works without internet or an account: the message is sent from your mail app.'**
  String get contactIntro;

  /// No description provided for @contactEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmailLabel;

  /// No description provided for @contactCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy address'**
  String get contactCopy;

  /// No description provided for @contactCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied'**
  String get contactCopied;

  /// No description provided for @contactNoMailApp.
  ///
  /// In en, this message translates to:
  /// **'Could not open a mail app. The address was copied: send your message from any mail service.'**
  String get contactNoMailApp;

  /// No description provided for @contactQuestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions and suggestions'**
  String get contactQuestionTitle;

  /// No description provided for @contactQuestionBody.
  ///
  /// In en, this message translates to:
  /// **'Ask about the app, suggest a topic or an improvement.'**
  String get contactQuestionBody;

  /// No description provided for @contactQuestionAction.
  ///
  /// In en, this message translates to:
  /// **'Write an email'**
  String get contactQuestionAction;

  /// No description provided for @contactReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get contactReportTitle;

  /// No description provided for @contactReportBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us about wrong medical content or inappropriate user content.'**
  String get contactReportBody;

  /// No description provided for @contactReportHint.
  ///
  /// In en, this message translates to:
  /// **'Please name the section or card so we can find it quickly.'**
  String get contactReportHint;

  /// No description provided for @contactReportAction.
  ///
  /// In en, this message translates to:
  /// **'Send a report'**
  String get contactReportAction;

  /// No description provided for @contactResponseNote.
  ///
  /// In en, this message translates to:
  /// **'We read every report and fix confirmed errors, but we cannot promise a reply time. This address is not for medical emergencies.'**
  String get contactResponseNote;

  /// No description provided for @contactPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'If you write to us, we see your email address and what you write.'**
  String get contactPrivacyNote;

  /// Prefilled email body (no personal data)
  ///
  /// In en, this message translates to:
  /// **'Your question or suggestion:\n\n\n---\nApp: NurseGuide {version}\nPlatform: {platform}'**
  String contactMailBodyQuestion(String version, String platform);

  /// Prefilled email body (no personal data)
  ///
  /// In en, this message translates to:
  /// **'Section / card name:\nWhat is wrong:\n(Please do not include patient data.)\n\n\n---\nApp: NurseGuide {version}\nPlatform: {platform}'**
  String contactMailBodyReport(String version, String platform);

  /// Divider text between the email form and the Google/Apple sign-in buttons
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get authOr;

  /// Apple button label (Apple HIG wording)
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get authSignInApple;

  /// Google button label (Google branding wording)
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get authSignInGoogle;

  /// Shown when Google/Apple sign-in fails (not when the user cancels)
  ///
  /// In en, this message translates to:
  /// **'Couldn’t sign in. Check the connection and try again, or use the email code.'**
  String get authSocialFailed;

  /// Shown when the provider reports the email as unverified
  ///
  /// In en, this message translates to:
  /// **'This account’s email isn’t verified, so it can’t be used to sign in. Use the email code instead.'**
  String get authSocialEmailUnverified;

  /// Shown when the provider gave no email on first sign-in
  ///
  /// In en, this message translates to:
  /// **'This account didn’t share an email address. Use the email code instead.'**
  String get authSocialEmailRequired;

  /// Added to the delete-account dialog for accounts linked to Apple
  ///
  /// In en, this message translates to:
  /// **'You signed in with Apple, so Apple will ask you to confirm before the account is deleted. This also disconnects NurseGuide from your Apple ID.'**
  String get accountDeleteAppleNote;

  /// Snackbar when the user cancels the Apple confirmation during account deletion
  ///
  /// In en, this message translates to:
  /// **'Nothing was deleted: Apple confirmation was cancelled.'**
  String get accountDeleteAppleCancelled;

  /// No description provided for @admPanelAccess.
  ///
  /// In en, this message translates to:
  /// **'Access: the owner email (ADMIN_EMAILS) and an email code. The server re-checks every request.'**
  String get admPanelAccess;

  /// No description provided for @admOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get admOverview;

  /// No description provided for @admOverviewSub.
  ///
  /// In en, this message translates to:
  /// **'Registered: {total} · online: {online} · new in 7 days: {week}'**
  String admOverviewSub(int total, int online, int week);

  /// No description provided for @admComplaintsRow.
  ///
  /// In en, this message translates to:
  /// **'In-app complaints'**
  String get admComplaintsRow;

  /// No description provided for @admComplaintsRowSub.
  ///
  /// In en, this message translates to:
  /// **'Open: {count}'**
  String admComplaintsRowSub(int count);

  /// No description provided for @admEmailNote.
  ///
  /// In en, this message translates to:
  /// **'Complaints and questions sent by email arrive at {email} — check them in the mailbox (they do not reach the app).'**
  String admEmailNote(String email);

  /// No description provided for @admUsersSub.
  ///
  /// In en, this message translates to:
  /// **'Search by email or nickname, role, suspension'**
  String get admUsersSub;

  /// No description provided for @admAuditSub.
  ///
  /// In en, this message translates to:
  /// **'Every admin action is recorded'**
  String get admAuditSub;

  /// No description provided for @admStoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Downloads and sales'**
  String get admStoreTitle;

  /// No description provided for @admStoreBody.
  ///
  /// In en, this message translates to:
  /// **'The server cannot see store downloads — App Store Connect and Google Play Console show them. The app has no analytics SDK (privacy policy). Numbers in this panel are accounts that confirmed their email.'**
  String get admStoreBody;

  /// No description provided for @admSales.
  ///
  /// In en, this message translates to:
  /// **'Sales: 0 (no payments yet)'**
  String get admSales;

  /// No description provided for @admAppStoreConnect.
  ///
  /// In en, this message translates to:
  /// **'App Store Connect'**
  String get admAppStoreConnect;

  /// No description provided for @admPlayConsole.
  ///
  /// In en, this message translates to:
  /// **'Google Play Console'**
  String get admPlayConsole;

  /// No description provided for @admStatsAccounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get admStatsAccounts;

  /// No description provided for @admOnlineNow.
  ///
  /// In en, this message translates to:
  /// **'Online now (5 minutes)'**
  String get admOnlineNow;

  /// No description provided for @admSuspendedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Suspended accounts'**
  String get admSuspendedAccounts;

  /// No description provided for @admStatsActiveNote.
  ///
  /// In en, this message translates to:
  /// **'Online and active — accounts that made a request to the server. Only the minute and day are stored; no IP or device.'**
  String get admStatsActiveNote;

  /// No description provided for @admChartTitle.
  ///
  /// In en, this message translates to:
  /// **'New accounts — last 14 days'**
  String get admChartTitle;

  /// No description provided for @admChartBar.
  ///
  /// In en, this message translates to:
  /// **'{date}: {count} new accounts'**
  String admChartBar(String date, int count);

  /// No description provided for @admChartTotal.
  ///
  /// In en, this message translates to:
  /// **'Total in 14 days: {count}'**
  String admChartTotal(int count);

  /// No description provided for @admStatsObjects.
  ///
  /// In en, this message translates to:
  /// **'Main objects'**
  String get admStatsObjects;

  /// No description provided for @admStatsGroupsCount.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get admStatsGroupsCount;

  /// No description provided for @admStatsTeachers.
  ///
  /// In en, this message translates to:
  /// **'Registered teachers'**
  String get admStatsTeachers;

  /// No description provided for @admStatsStudents.
  ///
  /// In en, this message translates to:
  /// **'Students in groups'**
  String get admStatsStudents;

  /// No description provided for @admStatsAssignments.
  ///
  /// In en, this message translates to:
  /// **'Test sessions'**
  String get admStatsAssignments;

  /// No description provided for @admStatsResults.
  ///
  /// In en, this message translates to:
  /// **'Test results'**
  String get admStatsResults;

  /// No description provided for @admStatsComplaintsOpen.
  ///
  /// In en, this message translates to:
  /// **'Open complaints'**
  String get admStatsComplaintsOpen;

  /// No description provided for @admStatsComplaintsResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved complaints'**
  String get admStatsComplaintsResolved;

  /// No description provided for @admStatsAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Messages: awaiting reply'**
  String get admStatsAwaiting;

  /// No description provided for @admStatsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated: {time}'**
  String admStatsUpdated(String time);

  /// No description provided for @admComplaintsTitle.
  ///
  /// In en, this message translates to:
  /// **'In-app complaints'**
  String get admComplaintsTitle;

  /// No description provided for @admApple12Note.
  ///
  /// In en, this message translates to:
  /// **'Handle reports of objectionable content promptly (Apple 1.2 requires timely action; target — 24 hours).'**
  String get admApple12Note;

  /// No description provided for @admFilterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get admFilterOpen;

  /// No description provided for @admFilterResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get admFilterResolved;

  /// No description provided for @admAllKinds.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get admAllKinds;

  /// No description provided for @complaintKindComplaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaintKindComplaint;

  /// No description provided for @complaintKindInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate content'**
  String get complaintKindInappropriate;

  /// No description provided for @complaintKindBug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get complaintKindBug;

  /// No description provided for @complaintKindAd.
  ///
  /// In en, this message translates to:
  /// **'Advertising'**
  String get complaintKindAd;

  /// No description provided for @complaintKindOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get complaintKindOther;

  /// No description provided for @admComplaintsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No complaints in this list'**
  String get admComplaintsEmpty;

  /// No description provided for @admComplaintAnon.
  ///
  /// In en, this message translates to:
  /// **'Guest (no account)'**
  String get admComplaintAnon;

  /// No description provided for @admComplaintFrom.
  ///
  /// In en, this message translates to:
  /// **'From: {email}'**
  String admComplaintFrom(String email);

  /// No description provided for @admComplaintTarget.
  ///
  /// In en, this message translates to:
  /// **'Reference: {ref}'**
  String admComplaintTarget(String ref);

  /// No description provided for @admComplaintNote.
  ///
  /// In en, this message translates to:
  /// **'Admin note'**
  String get admComplaintNote;

  /// No description provided for @admComplaintNoteHint.
  ///
  /// In en, this message translates to:
  /// **'What was done? (admins only)'**
  String get admComplaintNoteHint;

  /// No description provided for @admComplaintSaveNote.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get admComplaintSaveNote;

  /// No description provided for @admComplaintResolve.
  ///
  /// In en, this message translates to:
  /// **'Mark resolved'**
  String get admComplaintResolve;

  /// No description provided for @admComplaintReopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get admComplaintReopen;

  /// No description provided for @admComplaintResolvedOn.
  ///
  /// In en, this message translates to:
  /// **'Resolved: {date}'**
  String admComplaintResolvedOn(String date);

  /// No description provided for @admSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get admSaved;

  /// No description provided for @admSearchModeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get admSearchModeEmail;

  /// No description provided for @admSearchModeName.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get admSearchModeName;

  /// No description provided for @admSearchEmail.
  ///
  /// In en, this message translates to:
  /// **'Full email (exact match)'**
  String get admSearchEmail;

  /// No description provided for @admSearchName.
  ///
  /// In en, this message translates to:
  /// **'Group nickname (at least 2 characters)'**
  String get admSearchName;

  /// No description provided for @admUsersSearchNote.
  ///
  /// In en, this message translates to:
  /// **'Emails are not stored in plain text: an account is found only by its full email and is shown masked.'**
  String get admUsersSearchNote;

  /// No description provided for @admSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get admSearch;

  /// No description provided for @admStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get admStatusActive;

  /// No description provided for @admStatusSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get admStatusSuspended;

  /// No description provided for @admUserAdminTag.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admUserAdminTag;

  /// No description provided for @admUserTitle.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get admUserTitle;

  /// No description provided for @admUserRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get admUserRole;

  /// No description provided for @admRoleChanged.
  ///
  /// In en, this message translates to:
  /// **'Role changed'**
  String get admRoleChanged;

  /// No description provided for @admRoleSelfNote.
  ///
  /// In en, this message translates to:
  /// **'You cannot change your own role or status here.'**
  String get admRoleSelfNote;

  /// No description provided for @admUserFacts.
  ///
  /// In en, this message translates to:
  /// **'Groups: {owned} (teacher) · {joined} (student) · messages: {threads} · complaints: {complaints}'**
  String admUserFacts(int owned, int joined, int threads, int complaints);

  /// No description provided for @admAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account status'**
  String get admAccountTitle;

  /// No description provided for @admAccountSuspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend account'**
  String get admAccountSuspend;

  /// No description provided for @admAccountSuspendTitle.
  ///
  /// In en, this message translates to:
  /// **'Suspend the account?'**
  String get admAccountSuspendTitle;

  /// No description provided for @admAccountSuspendBody.
  ///
  /// In en, this message translates to:
  /// **'The user is signed out on all devices and cannot sign in again (email code, Google, Apple). The app shows them the contact address. The action is logged.'**
  String get admAccountSuspendBody;

  /// No description provided for @admAccountReactivate.
  ///
  /// In en, this message translates to:
  /// **'Reactivate'**
  String get admAccountReactivate;

  /// No description provided for @admAccountReactivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Reactivate the account?'**
  String get admAccountReactivateTitle;

  /// No description provided for @admAccountReactivateBody.
  ///
  /// In en, this message translates to:
  /// **'The user can sign in again. The action is logged.'**
  String get admAccountReactivateBody;

  /// No description provided for @admAccountAdminNote.
  ///
  /// In en, this message translates to:
  /// **'An admin account cannot be suspended.'**
  String get admAccountAdminNote;

  /// No description provided for @admErrOwner.
  ///
  /// In en, this message translates to:
  /// **'The owner account cannot be suspended.'**
  String get admErrOwner;

  /// No description provided for @admErrSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot apply this action to yourself.'**
  String get admErrSelf;

  /// No description provided for @admErrName.
  ///
  /// In en, this message translates to:
  /// **'Nickname must be 2–40 characters.'**
  String get admErrName;

  /// No description provided for @admAuditBy.
  ///
  /// In en, this message translates to:
  /// **'By: {actor}'**
  String admAuditBy(String actor);

  /// No description provided for @admAuditSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get admAuditSystem;

  /// No description provided for @adminActionAccountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get adminActionAccountDeleted;

  /// No description provided for @adminActionMfa.
  ///
  /// In en, this message translates to:
  /// **'2FA enabled'**
  String get adminActionMfa;

  /// No description provided for @adminActionTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher registered'**
  String get adminActionTeacher;

  /// No description provided for @adminActionRoleChanged.
  ///
  /// In en, this message translates to:
  /// **'Role changed'**
  String get adminActionRoleChanged;

  /// No description provided for @adminActionAccountSuspended.
  ///
  /// In en, this message translates to:
  /// **'Account suspended'**
  String get adminActionAccountSuspended;

  /// No description provided for @adminActionAccountReactivated.
  ///
  /// In en, this message translates to:
  /// **'Account reactivated'**
  String get adminActionAccountReactivated;

  /// No description provided for @adminActionComplaintNote.
  ///
  /// In en, this message translates to:
  /// **'Complaint note added'**
  String get adminActionComplaintNote;

  /// No description provided for @adminActionComplaintResolved.
  ///
  /// In en, this message translates to:
  /// **'Complaint resolved'**
  String get adminActionComplaintResolved;

  /// No description provided for @adminActionComplaintReopened.
  ///
  /// In en, this message translates to:
  /// **'Complaint reopened'**
  String get adminActionComplaintReopened;

  /// No description provided for @adminActionIdentityLinked.
  ///
  /// In en, this message translates to:
  /// **'Sign-in method linked'**
  String get adminActionIdentityLinked;

  /// No description provided for @complaintFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Send a complaint in the app'**
  String get complaintFormTitle;

  /// No description provided for @complaintFormBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us about objectionable content, a bug or another problem — the NurseGuide team will review it (usually within 24 hours).'**
  String get complaintFormBody;

  /// No description provided for @complaintKindLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get complaintKindLabel;

  /// No description provided for @complaintText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get complaintText;

  /// No description provided for @complaintTextHint.
  ///
  /// In en, this message translates to:
  /// **'What happened? Which screen or post?'**
  String get complaintTextHint;

  /// No description provided for @complaintTarget.
  ///
  /// In en, this message translates to:
  /// **'Reference: {ref}'**
  String complaintTarget(String ref);

  /// No description provided for @complaintSend.
  ///
  /// In en, this message translates to:
  /// **'Send complaint'**
  String get complaintSend;

  /// No description provided for @complaintSent.
  ///
  /// In en, this message translates to:
  /// **'Sent. Thank you — we will review it.'**
  String get complaintSent;

  /// No description provided for @complaintTooShort.
  ///
  /// In en, this message translates to:
  /// **'Write at least 5 characters.'**
  String get complaintTooShort;

  /// No description provided for @complaintRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many complaints: up to 5 per hour. Try again in {minutes} min.'**
  String complaintRateLimited(int minutes);

  /// No description provided for @complaintAnonNote.
  ///
  /// In en, this message translates to:
  /// **'Without an account we cannot reply to you. If you need a reply, sign in or send an email.'**
  String get complaintAnonNote;

  /// No description provided for @complaintPhiNote.
  ///
  /// In en, this message translates to:
  /// **'Do not include patient names or other personal data.'**
  String get complaintPhiNote;

  /// No description provided for @complaintFailed.
  ///
  /// In en, this message translates to:
  /// **'Not sent. Check your connection and try again.'**
  String get complaintFailed;

  /// No description provided for @authAccountSuspended.
  ///
  /// In en, this message translates to:
  /// **'Your account has been suspended. If you have questions, write to: {email}'**
  String authAccountSuspended(String email);

  /// No description provided for @admSectionComplaints.
  ///
  /// In en, this message translates to:
  /// **'Complaints'**
  String get admSectionComplaints;

  /// No description provided for @lectureSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search presentations'**
  String get lectureSearchLabel;

  /// No description provided for @lectureSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Topic or slide title'**
  String get lectureSearchHint;

  /// No description provided for @lectureFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get lectureFilterAll;

  /// No description provided for @lectureFilterProtocols.
  ///
  /// In en, this message translates to:
  /// **'Practical protocols'**
  String get lectureFilterProtocols;

  /// No description provided for @lectureFilterModule.
  ///
  /// In en, this message translates to:
  /// **'Module {n}'**
  String lectureFilterModule(int n);

  /// No description provided for @lectureLangAll.
  ///
  /// In en, this message translates to:
  /// **'All languages'**
  String get lectureLangAll;

  /// No description provided for @lectureDecksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} presentation} other{{count} presentations}}'**
  String lectureDecksCount(int count);

  /// No description provided for @lectureSlidesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} slide} other{{count} slides}}'**
  String lectureSlidesCount(int count);

  /// No description provided for @lectureSlidesMatch.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} slide matches} other{{count} slides match}}'**
  String lectureSlidesMatch(int count);

  /// No description provided for @lectureMoreSlides.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String lectureMoreSlides(int count);

  /// No description provided for @lectureResultsFound.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} presentation found} other{{count} presentations found}}'**
  String lectureResultsFound(int count);

  /// No description provided for @lectureNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get lectureNoResultsTitle;

  /// No description provided for @lectureNoResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try another word or filter. Search works in Uzbek (Latin or Cyrillic), Russian and English.'**
  String get lectureNoResultsBody;

  /// No description provided for @lectureClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear search and filters'**
  String get lectureClearFilters;

  /// No description provided for @lectureLangFallback.
  ///
  /// In en, this message translates to:
  /// **'This presentation is not available in {wanted}; shown in {shown}'**
  String lectureLangFallback(String wanted, String shown);

  /// No description provided for @lectureDeckLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the presentation'**
  String get lectureDeckLoadFailed;

  /// No description provided for @lectureFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Full screen'**
  String get lectureFullscreen;

  /// No description provided for @lectureFullscreenExit.
  ///
  /// In en, this message translates to:
  /// **'Exit full screen'**
  String get lectureFullscreenExit;

  /// No description provided for @lectureSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Slide sources'**
  String get lectureSourcesTitle;

  /// No description provided for @lectureSourcesOpen.
  ///
  /// In en, this message translates to:
  /// **'Show full sources'**
  String get lectureSourcesOpen;

  /// No description provided for @lectureSourcesCount.
  ///
  /// In en, this message translates to:
  /// **'Sources: {count}'**
  String lectureSourcesCount(int count);

  /// No description provided for @lectureSourceLocator.
  ///
  /// In en, this message translates to:
  /// **'Section/page: {loc}'**
  String lectureSourceLocator(String loc);

  /// No description provided for @lectureSourcesHint.
  ///
  /// In en, this message translates to:
  /// **'The full list is on the last “References” slide.'**
  String get lectureSourcesHint;

  /// No description provided for @lectureRotateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rotate the screen to landscape?'**
  String get lectureRotateTitle;

  /// No description provided for @lectureRotateBody.
  ///
  /// In en, this message translates to:
  /// **'In landscape the slide fills the whole screen. “No” keeps the current orientation.'**
  String get lectureRotateBody;

  /// No description provided for @lectureRotateCastBody.
  ///
  /// In en, this message translates to:
  /// **'TVs and monitors are landscape, so landscape is recommended when casting.'**
  String get lectureRotateCastBody;

  /// No description provided for @lectureRotateYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get lectureRotateYes;

  /// No description provided for @lectureRotateNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get lectureRotateNo;

  /// No description provided for @lectureRotateRemember.
  ///
  /// In en, this message translates to:
  /// **'Don’t ask again'**
  String get lectureRotateRemember;

  /// No description provided for @lectureOrientationMenu.
  ///
  /// In en, this message translates to:
  /// **'Screen orientation when presenting'**
  String get lectureOrientationMenu;

  /// No description provided for @lectureOrientationAsk.
  ///
  /// In en, this message translates to:
  /// **'Always ask'**
  String get lectureOrientationAsk;

  /// No description provided for @lectureOrientationLandscape.
  ///
  /// In en, this message translates to:
  /// **'Always landscape'**
  String get lectureOrientationLandscape;

  /// No description provided for @lectureOrientationKeep.
  ///
  /// In en, this message translates to:
  /// **'Don’t rotate'**
  String get lectureOrientationKeep;

  /// No description provided for @lectureMore.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get lectureMore;

  /// No description provided for @lectureCast.
  ///
  /// In en, this message translates to:
  /// **'Show on TV'**
  String get lectureCast;

  /// No description provided for @lectureCastTitle.
  ///
  /// In en, this message translates to:
  /// **'Show on a TV or monitor'**
  String get lectureCastTitle;

  /// No description provided for @lectureCastHow.
  ///
  /// In en, this message translates to:
  /// **'Casting uses your phone’s built-in screen mirroring: the TV shows the phone screen. In presentation mode the screen shows only the slide (no buttons) and stays on.'**
  String get lectureCastHow;

  /// No description provided for @lectureCastStepsAndroid.
  ///
  /// In en, this message translates to:
  /// **'1. Connect the phone and the TV to the same Wi‑Fi network.\n2. Open “Cast screen” (Cast, Smart View, Miracast — the name depends on the phone) and pick the TV.\n3. Come back to the app and tap “Start presentation”.'**
  String get lectureCastStepsAndroid;

  /// No description provided for @lectureCastStepsIos.
  ///
  /// In en, this message translates to:
  /// **'1. Connect the iPhone/iPad and the TV (Apple TV or AirPlay-compatible) to the same Wi‑Fi network.\n2. Open Control Center (swipe down from the top-right corner) → Screen Mirroring → pick the TV.\n3. Come back to the app and tap “Start presentation”.'**
  String get lectureCastStepsIos;

  /// No description provided for @lectureCastOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open cast settings'**
  String get lectureCastOpenSettings;

  /// No description provided for @lectureCastSettingsFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the settings — find “Cast screen” in Settings or in the quick settings panel.'**
  String get lectureCastSettingsFailed;

  /// No description provided for @lectureCastStart.
  ///
  /// In en, this message translates to:
  /// **'Start presentation'**
  String get lectureCastStart;

  /// No description provided for @lecturePresenter.
  ///
  /// In en, this message translates to:
  /// **'Presenter view'**
  String get lecturePresenter;

  /// No description provided for @lecturePresenterNext.
  ///
  /// In en, this message translates to:
  /// **'Next slide'**
  String get lecturePresenterNext;

  /// No description provided for @lecturePresenterLast.
  ///
  /// In en, this message translates to:
  /// **'This is the last slide'**
  String get lecturePresenterLast;

  /// No description provided for @lecturePresenterTimer.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get lecturePresenterTimer;

  /// No description provided for @lecturePresenterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset timer'**
  String get lecturePresenterReset;

  /// No description provided for @lecturePresenterNote.
  ///
  /// In en, this message translates to:
  /// **'Presenter view is on this device only. When mirroring, the TV shows the same view — use “Full screen” for the audience.'**
  String get lecturePresenterNote;

  /// No description provided for @topicTestAction.
  ///
  /// In en, this message translates to:
  /// **'Topic test'**
  String get topicTestAction;

  /// No description provided for @topicTestPreparing.
  ///
  /// In en, this message translates to:
  /// **'Questions for this topic are being prepared'**
  String get topicTestPreparing;

  /// No description provided for @topicTestPreparingShort.
  ///
  /// In en, this message translates to:
  /// **'Questions in preparation'**
  String get topicTestPreparingShort;

  /// No description provided for @topicTestPreparingBody.
  ///
  /// In en, this message translates to:
  /// **'Only verified questions go into the test. This topic has {count} so far — at least 3 are needed.'**
  String topicTestPreparingBody(int count);

  /// No description provided for @topicTestIntro.
  ///
  /// In en, this message translates to:
  /// **'{count} questions · the correct answer and explanation after each one'**
  String topicTestIntro(int count);

  /// No description provided for @topicTestSavedNote.
  ///
  /// In en, this message translates to:
  /// **'If you leave, your answers are kept — you will continue from the same place.'**
  String get topicTestSavedNote;

  /// No description provided for @topicTestSourcesNote.
  ///
  /// In en, this message translates to:
  /// **'Questions come only from verified sources: official certification questions with a confirmed key and practice questions with a cited source.'**
  String get topicTestSourcesNote;

  /// No description provided for @topicTestStart.
  ///
  /// In en, this message translates to:
  /// **'Start the test'**
  String get topicTestStart;

  /// No description provided for @topicTestBest.
  ///
  /// In en, this message translates to:
  /// **'Best score: {score}/{total}'**
  String topicTestBest(int score, int total);

  /// No description provided for @topicTestBadgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Topic test, best score {score} of {total}'**
  String topicTestBadgeLabel(int score, int total);

  /// No description provided for @topicTestRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get topicTestRetake;

  /// No description provided for @topicTestNextTopic.
  ///
  /// In en, this message translates to:
  /// **'Next topic'**
  String get topicTestNextTopic;

  /// No description provided for @topicTestOpenSlide.
  ///
  /// In en, this message translates to:
  /// **'View slide'**
  String get topicTestOpenSlide;

  /// No description provided for @topicTestOpenDeckStart.
  ///
  /// In en, this message translates to:
  /// **'Open the presentation from the start'**
  String get topicTestOpenDeckStart;

  /// No description provided for @topicTestHistory.
  ///
  /// In en, this message translates to:
  /// **'Result history'**
  String get topicTestHistory;

  /// No description provided for @topicTestAssign.
  ///
  /// In en, this message translates to:
  /// **'Assign to a group'**
  String get topicTestAssign;

  /// No description provided for @topicTestLimitBody.
  ///
  /// In en, this message translates to:
  /// **'Each student gets {minutes} min from the moment they start. When time runs out, answers are submitted automatically.'**
  String topicTestLimitBody(int minutes);

  /// No description provided for @topicTestLimitNoneBody.
  ///
  /// In en, this message translates to:
  /// **'No time limit — students can take the test any time before the deadline.'**
  String get topicTestLimitNoneBody;

  /// No description provided for @topicTestOpenFor.
  ///
  /// In en, this message translates to:
  /// **'How long the test stays open'**
  String get topicTestOpenFor;

  /// No description provided for @topicTestAssignSub.
  ///
  /// In en, this message translates to:
  /// **'Students join by QR or code; you see the results'**
  String get topicTestAssignSub;

  /// No description provided for @topicTestSelf.
  ///
  /// In en, this message translates to:
  /// **'Try it myself'**
  String get topicTestSelf;

  /// No description provided for @topicTestSelfSub.
  ///
  /// In en, this message translates to:
  /// **'Saved only on your device; not sent to students'**
  String get topicTestSelfSub;

  /// No description provided for @topicTestAssignIntro.
  ///
  /// In en, this message translates to:
  /// **'Students take the test on their own phones before the deadline; the score is calculated on the server.'**
  String get topicTestAssignIntro;

  /// No description provided for @topicTestGroups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get topicTestGroups;

  /// No description provided for @topicTestNoGroups.
  ///
  /// In en, this message translates to:
  /// **'You have no groups yet'**
  String get topicTestNoGroups;

  /// No description provided for @topicTestNoGroupsBody.
  ///
  /// In en, this message translates to:
  /// **'Create a group and invite students first — then assign the test from here.'**
  String get topicTestNoGroupsBody;

  /// No description provided for @topicTestPickGroup.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one group'**
  String get topicTestPickGroup;

  /// No description provided for @topicTestReveal.
  ///
  /// In en, this message translates to:
  /// **'Correct answers shown to students'**
  String get topicTestReveal;

  /// No description provided for @topicTestRevealNow.
  ///
  /// In en, this message translates to:
  /// **'Right after submitting'**
  String get topicTestRevealNow;

  /// No description provided for @topicTestRevealAfterDue.
  ///
  /// In en, this message translates to:
  /// **'After the deadline'**
  String get topicTestRevealAfterDue;

  /// No description provided for @topicTestRevealNeedsDue.
  ///
  /// In en, this message translates to:
  /// **'Choose a deadline to use “After the deadline”'**
  String get topicTestRevealNeedsDue;

  /// No description provided for @topicTestSent.
  ///
  /// In en, this message translates to:
  /// **'Test sent to groups: {count}'**
  String topicTestSent(int count);

  /// No description provided for @topicTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Topic test: {title}'**
  String topicTestTitle(String title);

  /// No description provided for @topicTestSentList.
  ///
  /// In en, this message translates to:
  /// **'Sent tests'**
  String get topicTestSentList;

  /// No description provided for @topicTestAnswersLater.
  ///
  /// In en, this message translates to:
  /// **'Correct answers open after the deadline ({date}) or when the teacher closes the test'**
  String topicTestAnswersLater(String date);

  /// No description provided for @topicTestDistribution.
  ///
  /// In en, this message translates to:
  /// **'Score distribution'**
  String get topicTestDistribution;

  /// No description provided for @topicTestHardest.
  ///
  /// In en, this message translates to:
  /// **'Hardest questions'**
  String get topicTestHardest;

  /// No description provided for @topicTestAssignedTitle.
  ///
  /// In en, this message translates to:
  /// **'Assigned tests'**
  String get topicTestAssignedTitle;

  /// No description provided for @topicTestMenu.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get topicTestMenu;

  /// No description provided for @topicTestOpenLecture.
  ///
  /// In en, this message translates to:
  /// **'Open the presentation'**
  String get topicTestOpenLecture;

  /// No description provided for @topicTestCreateGroup.
  ///
  /// In en, this message translates to:
  /// **'Create a group'**
  String get topicTestCreateGroup;

  /// No description provided for @topicTestStudents.
  ///
  /// In en, this message translates to:
  /// **'Students: {count}'**
  String topicTestStudents(int count);

  /// No description provided for @topicTestReworkMistakes.
  ///
  /// In en, this message translates to:
  /// **'Review mistakes · {count}'**
  String topicTestReworkMistakes(int count);

  /// No description provided for @admDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get admDeleteTitle;

  /// No description provided for @admDeleteNote.
  ///
  /// In en, this message translates to:
  /// **'For deletion requests received by email (completed within 30 days). To confirm, enter the user\'s full email — the server checks that it belongs to exactly this account. The account, group memberships, support threads and sign-in methods are deleted permanently; for Sign in with Apple users the server attempts to revoke the Apple token. This cannot be undone; the action is logged.'**
  String get admDeleteNote;

  /// No description provided for @admDeleteEmail.
  ///
  /// In en, this message translates to:
  /// **'User\'s full email'**
  String get admDeleteEmail;

  /// No description provided for @admDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete account permanently'**
  String get admDeleteButton;

  /// No description provided for @admDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this account permanently?'**
  String get admDeleteConfirmTitle;

  /// No description provided for @admDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'The account {email} and all data linked to it will be deleted. This cannot be undone.'**
  String admDeleteConfirmBody(String email);

  /// No description provided for @admDeleteDone.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get admDeleteDone;

  /// No description provided for @admDeleteMismatch.
  ///
  /// In en, this message translates to:
  /// **'This email does not belong to this account — check it and try again.'**
  String get admDeleteMismatch;

  /// Exam: the result is internal practice, not an official grade.
  ///
  /// In en, this message translates to:
  /// **'The result is for internal practice, not an official grade.'**
  String get examPracticeNotice;

  /// No description provided for @classesPasteLink.
  ///
  /// In en, this message translates to:
  /// **'Paste link'**
  String get classesPasteLink;

  /// No description provided for @classesPasteNoCode.
  ///
  /// In en, this message translates to:
  /// **'No invite code in the copied text. Copy the link or code your teacher sent.'**
  String get classesPasteNoCode;

  /// No description provided for @classesScanTip.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code with your phone camera and tap “Open in app” on the page that opens — the code fills in by itself.'**
  String get classesScanTip;

  /// No description provided for @qrScanAction.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get qrScanAction;

  /// No description provided for @qrScanHint.
  ///
  /// In en, this message translates to:
  /// **'Fit the group or test QR code from your teacher inside the frame'**
  String get qrScanHint;

  /// No description provided for @qrScanTorchOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on flashlight'**
  String get qrScanTorchOn;

  /// No description provided for @qrScanTorchOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off flashlight'**
  String get qrScanTorchOff;

  /// No description provided for @qrScanTypeCode.
  ///
  /// In en, this message translates to:
  /// **'Type or paste the code'**
  String get qrScanTypeCode;

  /// No description provided for @qrScanNotInvite.
  ///
  /// In en, this message translates to:
  /// **'This QR code is not a NurseGuide group invite'**
  String get qrScanNotInvite;

  /// No description provided for @qrScanDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access is off'**
  String get qrScanDeniedTitle;

  /// No description provided for @qrScanDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'To read the QR code, allow NurseGuide to use the camera in Settings. The camera image is read on the phone only — it is not saved or sent. Or type the code yourself or paste the link.'**
  String get qrScanDeniedBody;

  /// No description provided for @qrScanOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get qrScanOpenSettings;

  /// No description provided for @qrScanFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t open the camera'**
  String get qrScanFailedTitle;

  /// No description provided for @qrScanFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Type the code yourself or paste the link from your teacher.'**
  String get qrScanFailedBody;

  /// No description provided for @qrScanStarting.
  ///
  /// In en, this message translates to:
  /// **'Opening camera…'**
  String get qrScanStarting;

  /// No description provided for @classesJoinOpensTest.
  ///
  /// In en, this message translates to:
  /// **'After joining, your teacher’s test opens right away.'**
  String get classesJoinOpensTest;

  /// No description provided for @classesJoinSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to join the group'**
  String get classesJoinSignInTitle;

  /// No description provided for @classesJoinSignInBody.
  ///
  /// In en, this message translates to:
  /// **'With Google, Apple or an email code — it takes a minute. Your result reaches the teacher through this account; the invite code is kept.'**
  String get classesJoinSignInBody;

  /// No description provided for @classesNicknameTaken.
  ///
  /// In en, this message translates to:
  /// **'This nickname is taken in the group — choose another.'**
  String get classesNicknameTaken;

  /// No description provided for @classesNicknameAbusive.
  ///
  /// In en, this message translates to:
  /// **'The nickname contains an inappropriate word — choose another.'**
  String get classesNicknameAbusive;

  /// No description provided for @classesTestQr.
  ///
  /// In en, this message translates to:
  /// **'Test QR'**
  String get classesTestQr;

  /// No description provided for @classesTestQrBody.
  ///
  /// In en, this message translates to:
  /// **'Students scan → sign in → nickname → this test opens. Results on this page update by themselves.'**
  String get classesTestQrBody;

  /// No description provided for @classesInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get classesInviteLink;

  /// No description provided for @classesLiveNote.
  ///
  /// In en, this message translates to:
  /// **'Results refresh every 10 seconds. Pull down to refresh now.'**
  String get classesLiveNote;

  /// No description provided for @boardOpen.
  ///
  /// In en, this message translates to:
  /// **'Big screen'**
  String get boardOpen;

  /// No description provided for @boardJoined.
  ///
  /// In en, this message translates to:
  /// **'In group'**
  String get boardJoined;

  /// No description provided for @boardStarted.
  ///
  /// In en, this message translates to:
  /// **'Solving'**
  String get boardStarted;

  /// No description provided for @boardSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get boardSubmitted;

  /// No description provided for @boardStatusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get boardStatusWaiting;

  /// No description provided for @boardStatusSolving.
  ///
  /// In en, this message translates to:
  /// **'Solving…'**
  String get boardStatusSolving;

  /// No description provided for @boardScan.
  ///
  /// In en, this message translates to:
  /// **'Scan to join'**
  String get boardScan;

  /// No description provided for @boardAnswersAfterClose.
  ///
  /// In en, this message translates to:
  /// **'Correct answers appear after the test is closed.'**
  String get boardAnswersAfterClose;

  /// No description provided for @boardEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nobody yet — scan the QR.'**
  String get boardEmpty;

  /// No description provided for @boardClose.
  ///
  /// In en, this message translates to:
  /// **'Exit big screen'**
  String get boardClose;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @variantToggle.
  ///
  /// In en, this message translates to:
  /// **'Different questions for each student'**
  String get variantToggle;

  /// No description provided for @variantOnBody.
  ///
  /// In en, this message translates to:
  /// **'Each student gets {n} of the topic’s {pool} questions, balanced across sub-topics.'**
  String variantOnBody(int pool, int n);

  /// No description provided for @variantOffBody.
  ///
  /// In en, this message translates to:
  /// **'Everyone gets the same questions (in shuffled order).'**
  String get variantOffBody;

  /// No description provided for @variantDisabledBody.
  ///
  /// In en, this message translates to:
  /// **'This topic has {pool} questions — different sets need at least {need} (twice the question count). Lower the question count.'**
  String variantDisabledBody(int pool, int need);

  /// No description provided for @variantUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Variant tests are not supported by this server.'**
  String get variantUnsupported;

  /// No description provided for @variantPoolTitle.
  ///
  /// In en, this message translates to:
  /// **'Question pool ({pool})'**
  String variantPoolTitle(int pool);

  /// No description provided for @variantLabel.
  ///
  /// In en, this message translates to:
  /// **'Variant test'**
  String get variantLabel;

  /// No description provided for @variantPerStudent.
  ///
  /// In en, this message translates to:
  /// **'{n} questions per student from a pool of {pool}'**
  String variantPerStudent(int n, int pool);

  /// No description provided for @variantReceived.
  ///
  /// In en, this message translates to:
  /// **'Given to {n} students'**
  String variantReceived(int n);

  /// No description provided for @homeResumeCta.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get homeResumeCta;

  /// No description provided for @homeResumeBody.
  ///
  /// In en, this message translates to:
  /// **'Last opened: {title}'**
  String homeResumeBody(String title);

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & contact'**
  String get helpTitle;

  /// No description provided for @helpSub.
  ///
  /// In en, this message translates to:
  /// **'In the app or by email — question, suggestion, complaint'**
  String get helpSub;

  /// No description provided for @helpIntro.
  ///
  /// In en, this message translates to:
  /// **'Choose what suits you: an in-app message thread (the reply arrives here) or email (complaint, privacy request).'**
  String get helpIntro;

  /// No description provided for @classesNicknameInvalid.
  ///
  /// In en, this message translates to:
  /// **'A nickname may contain only letters, digits, spaces and . _ \' -, and must start and end with a letter or digit (no emoji or symbols like !?@).'**
  String get classesNicknameInvalid;

  /// No description provided for @classesGroupFull.
  ///
  /// In en, this message translates to:
  /// **'The group is full (200 people) — tell your teacher.'**
  String get classesGroupFull;

  /// No description provided for @classesCodeAmbiguous.
  ///
  /// In en, this message translates to:
  /// **'Codes never contain 0, O, 1 or I. Check the code with your teacher or scan the QR.'**
  String get classesCodeAmbiguous;

  /// No description provided for @classesOwnGroupTitle.
  ///
  /// In en, this message translates to:
  /// **'You are this group\'s teacher'**
  String get classesOwnGroupTitle;

  /// No description provided for @classesOwnGroupBody.
  ///
  /// In en, this message translates to:
  /// **'This account created the group, so it can\'t join it as a student (switching the role in Profile doesn\'t change that). To try it as a student, sign in with another account or take the test in student view.'**
  String get classesOwnGroupBody;

  /// No description provided for @classesOwnGroupOpen.
  ///
  /// In en, this message translates to:
  /// **'Open as teacher'**
  String get classesOwnGroupOpen;

  /// No description provided for @classesSwitchAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in with another account'**
  String get classesSwitchAccount;

  /// No description provided for @classesPreviewAsStudent.
  ///
  /// In en, this message translates to:
  /// **'Try as a student'**
  String get classesPreviewAsStudent;

  /// No description provided for @classesPreviewNote.
  ///
  /// In en, this message translates to:
  /// **'Trial mode: answers are not sent to the server and don\'t appear in the results.'**
  String get classesPreviewNote;

  /// No description provided for @classesPreviewResult.
  ///
  /// In en, this message translates to:
  /// **'Trial finished: {correct} / {total} correct. Nothing was submitted.'**
  String classesPreviewResult(int correct, int total);

  /// No description provided for @classesGiveTopicTest.
  ///
  /// In en, this message translates to:
  /// **'Give a topic test'**
  String get classesGiveTopicTest;

  /// No description provided for @classesGiveTopicTestSub.
  ///
  /// In en, this message translates to:
  /// **'Pick a topic — the next page sets the number of questions, variants, due date and when answers open.'**
  String get classesGiveTopicTestSub;

  /// No description provided for @classesTopicSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search topics (e.g. anaemia)'**
  String get classesTopicSearchHint;

  /// No description provided for @classesTopicNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No topic with a ready test found'**
  String get classesTopicNoMatch;

  /// No description provided for @classesTopicQuestions.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String classesTopicQuestions(int count);

  /// No description provided for @examDeadlineAt.
  ///
  /// In en, this message translates to:
  /// **'Due: {date}'**
  String examDeadlineAt(String date);

  /// No description provided for @classesScanAskNick.
  ///
  /// In en, this message translates to:
  /// **'Before joining, enter a nickname — your teacher sees your result under it (optional: leave empty to show your seat number). Then tap “Join”.'**
  String get classesScanAskNick;

  /// No description provided for @classesMyNickname.
  ///
  /// In en, this message translates to:
  /// **'My nickname'**
  String get classesMyNickname;

  /// No description provided for @classesNoNickname.
  ///
  /// In en, this message translates to:
  /// **'None — your teacher sees your seat number'**
  String get classesNoNickname;

  /// No description provided for @classesNicknameSaved.
  ///
  /// In en, this message translates to:
  /// **'Nickname saved'**
  String get classesNicknameSaved;

  /// No description provided for @classesNicknameNote.
  ///
  /// In en, this message translates to:
  /// **'Don\'t use your real name. Leave empty to show your seat number.'**
  String get classesNicknameNote;

  /// No description provided for @rolesTeacherRegisterNote.
  ///
  /// In en, this message translates to:
  /// **'“Continue” registers your account as a teacher: you manage only the groups you create and see their results (not admin rights).'**
  String get rolesTeacherRegisterNote;

  /// No description provided for @rolesTeacherSignInNote.
  ///
  /// In en, this message translates to:
  /// **'The teacher role is for signed-in accounts only. Sign in (email, Google or Apple), then choose the role in Profile.'**
  String get rolesTeacherSignInNote;

  /// No description provided for @classesGiveGeneralTest.
  ///
  /// In en, this message translates to:
  /// **'Give a general test'**
  String get classesGiveGeneralTest;

  /// No description provided for @generalTestSub.
  ///
  /// In en, this message translates to:
  /// **'From several topics — up to 50 questions'**
  String get generalTestSub;

  /// No description provided for @generalTestIntro.
  ///
  /// In en, this message translates to:
  /// **'Pick topics — questions are spread evenly across them. Students take the test on their phones; the server scores it.'**
  String get generalTestIntro;

  /// No description provided for @generalTestSources.
  ///
  /// In en, this message translates to:
  /// **'Where questions come from'**
  String get generalTestSources;

  /// No description provided for @generalTestSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search topics (e.g. anaemia)'**
  String get generalTestSearchHint;

  /// No description provided for @generalSourceToifa.
  ///
  /// In en, this message translates to:
  /// **'Category exam questions'**
  String get generalSourceToifa;

  /// No description provided for @generalSourceToifaSub.
  ///
  /// In en, this message translates to:
  /// **'Official list, keys checked'**
  String get generalSourceToifaSub;

  /// No description provided for @generalSourceLecture.
  ///
  /// In en, this message translates to:
  /// **'Lecture topics'**
  String get generalSourceLecture;

  /// No description provided for @generalSourceLectureSub.
  ///
  /// In en, this message translates to:
  /// **'A whole module or single days'**
  String get generalSourceLectureSub;

  /// No description provided for @generalSourcePack.
  ///
  /// In en, this message translates to:
  /// **'By practice questions'**
  String get generalSourcePack;

  /// No description provided for @generalSourcePackSub.
  ///
  /// In en, this message translates to:
  /// **'Questions from topic groups'**
  String get generalSourcePackSub;

  /// No description provided for @generalSourceToifaShort.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get generalSourceToifaShort;

  /// No description provided for @generalSourceLectureShort.
  ///
  /// In en, this message translates to:
  /// **'Lectures'**
  String get generalSourceLectureShort;

  /// No description provided for @generalSourcePackShort.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get generalSourcePackShort;

  /// No description provided for @generalSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get generalSelectAll;

  /// No description provided for @generalAllShort.
  ///
  /// In en, this message translates to:
  /// **'all'**
  String get generalAllShort;

  /// No description provided for @generalDays.
  ///
  /// In en, this message translates to:
  /// **'Days · {count}'**
  String generalDays(int count);

  /// No description provided for @generalSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected: {topics} topics · {questions} questions'**
  String generalSelected(int topics, int questions);

  /// No description provided for @generalPickTopic.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one topic'**
  String get generalPickTopic;

  /// No description provided for @generalTestTitle.
  ///
  /// In en, this message translates to:
  /// **'General test: {topics}'**
  String generalTestTitle(String topics);

  /// No description provided for @generalTestNameHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. Midterm 1'**
  String get generalTestNameHint;

  /// No description provided for @navProcedures.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get navProcedures;

  /// No description provided for @navWorkplace.
  ///
  /// In en, this message translates to:
  /// **'Workplace'**
  String get navWorkplace;

  /// No description provided for @roleNurse.
  ///
  /// In en, this message translates to:
  /// **'Nurse'**
  String get roleNurse;

  /// No description provided for @roleNurseDesc.
  ///
  /// In en, this message translates to:
  /// **'Certification and procedures'**
  String get roleNurseDesc;

  /// No description provided for @procTitle.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get procTitle;

  /// No description provided for @procSub.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step practical guides'**
  String get procSub;

  /// No description provided for @procEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get procEmptyTitle;

  /// No description provided for @procEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'The procedure list did not load.'**
  String get procEmptyBody;

  /// No description provided for @workDirTitle.
  ///
  /// In en, this message translates to:
  /// **'Your work area'**
  String get workDirTitle;

  /// No description provided for @workDirHint.
  ///
  /// In en, this message translates to:
  /// **'Daily questions are matched to this area.'**
  String get workDirHint;

  /// No description provided for @workDirPick.
  ///
  /// In en, this message translates to:
  /// **'Choose your work area — daily questions will follow it.'**
  String get workDirPick;

  /// No description provided for @workDirNursing.
  ///
  /// In en, this message translates to:
  /// **'Nursing'**
  String get workDirNursing;

  /// No description provided for @workDirHigher.
  ///
  /// In en, this message translates to:
  /// **'Higher nursing'**
  String get workDirHigher;

  /// No description provided for @workDirPatronage.
  ///
  /// In en, this message translates to:
  /// **'Patronage'**
  String get workDirPatronage;

  /// No description provided for @workDirDmed.
  ///
  /// In en, this message translates to:
  /// **'DMED'**
  String get workDirDmed;

  /// No description provided for @workTodayDmed.
  ///
  /// In en, this message translates to:
  /// **'Today: 5 DMED questions and answers; the daily test uses general nursing questions'**
  String get workTodayDmed;

  /// No description provided for @dmedTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'DMED questions of the day'**
  String get dmedTodayTitle;

  /// No description provided for @dmedAll.
  ///
  /// In en, this message translates to:
  /// **'All DMED questions and answers'**
  String get dmedAll;

  /// No description provided for @workTodayOwn.
  ///
  /// In en, this message translates to:
  /// **'Today: questions from your work area'**
  String get workTodayOwn;

  /// No description provided for @workTodayGeneral.
  ///
  /// In en, this message translates to:
  /// **'Today: general questions (for every area)'**
  String get workTodayGeneral;

  /// No description provided for @workTodayMixed.
  ///
  /// In en, this message translates to:
  /// **'Today: mixed — 3 from your area, 2 general'**
  String get workTodayMixed;

  /// No description provided for @workPlan.
  ///
  /// In en, this message translates to:
  /// **'Weekly plan: Monday–Thursday your area, Friday–Saturday general questions, Sunday mixed.'**
  String get workPlan;

  /// No description provided for @procGoal.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get procGoal;

  /// No description provided for @procIndications.
  ///
  /// In en, this message translates to:
  /// **'Indications'**
  String get procIndications;

  /// No description provided for @procContra.
  ///
  /// In en, this message translates to:
  /// **'Contraindications'**
  String get procContra;

  /// No description provided for @procEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get procEquipment;

  /// No description provided for @procSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get procSteps;

  /// No description provided for @procChecklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get procChecklist;

  /// No description provided for @procRisks.
  ///
  /// In en, this message translates to:
  /// **'Risks and complications'**
  String get procRisks;

  /// No description provided for @procStepsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} steps'**
  String procStepsCount(int count);

  /// No description provided for @procSourceNote.
  ///
  /// In en, this message translates to:
  /// **'Based on the textbook. Compare with your facility\'s current instruction and Ministry of Health orders.'**
  String get procSourceNote;

  /// No description provided for @procNotFound.
  ///
  /// In en, this message translates to:
  /// **'Procedure not found'**
  String get procNotFound;

  /// No description provided for @glossaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Glossary'**
  String get glossaryTitle;

  /// No description provided for @glossarySub.
  ///
  /// In en, this message translates to:
  /// **'Exact definitions from the textbook'**
  String get glossarySub;

  /// No description provided for @glossaryCount.
  ///
  /// In en, this message translates to:
  /// **'{count} terms'**
  String glossaryCount(int count);

  /// No description provided for @glossarySearch.
  ///
  /// In en, this message translates to:
  /// **'Search terms'**
  String get glossarySearch;

  /// No description provided for @glossaryNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get glossaryNothing;

  /// No description provided for @dmedTitle.
  ///
  /// In en, this message translates to:
  /// **'DMED: questions and answers'**
  String get dmedTitle;

  /// No description provided for @dmedSub.
  ///
  /// In en, this message translates to:
  /// **'How to work in the DMED system: roles, admission, inpatient care, forms'**
  String get dmedSub;

  /// No description provided for @dmedSearch.
  ///
  /// In en, this message translates to:
  /// **'Search questions and answers'**
  String get dmedSearch;

  /// No description provided for @dmedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String dmedCount(int count);

  /// No description provided for @dmedNote.
  ///
  /// In en, this message translates to:
  /// **'Based on a DMED training-video quiz (June 2025) and the ARGOS MED table. Not an official instruction: button and section names may change when the system is updated.'**
  String get dmedNote;

  /// No description provided for @dmedShow.
  ///
  /// In en, this message translates to:
  /// **'Show answer'**
  String get dmedShow;

  /// No description provided for @dmedHide.
  ///
  /// In en, this message translates to:
  /// **'Hide answer'**
  String get dmedHide;

  /// No description provided for @dmedAllGroups.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get dmedAllGroups;

  /// No description provided for @litCardsN.
  ///
  /// In en, this message translates to:
  /// **'{count} DMED Q&A'**
  String litCardsN(int count);

  /// No description provided for @refUzbekOnly.
  ///
  /// In en, this message translates to:
  /// **'Text is in Uzbek (from the textbook); translation comes in a later update.'**
  String get refUzbekOnly;

  /// No description provided for @workVitalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Vital signs'**
  String get workVitalsTitle;

  /// No description provided for @workVitalTemp.
  ///
  /// In en, this message translates to:
  /// **'Body temperature'**
  String get workVitalTemp;

  /// No description provided for @workVitalPulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get workVitalPulse;

  /// No description provided for @workVitalResp.
  ///
  /// In en, this message translates to:
  /// **'Respiratory rate'**
  String get workVitalResp;

  /// No description provided for @workVitalPerMin.
  ///
  /// In en, this message translates to:
  /// **'per minute'**
  String get workVitalPerMin;

  /// No description provided for @workVitalSource.
  ///
  /// In en, this message translates to:
  /// **'Source: Inomov Q.S., “Fundamentals of Nursing” (Hamshiralik ishi asoslari), 4th ed., Tashkent, 2007, pp. 170/173/177 (PDF).'**
  String get workVitalSource;

  /// No description provided for @litTitle.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get litTitle;

  /// No description provided for @litSub.
  ///
  /// In en, this message translates to:
  /// **'Sources the questions and reference material rely on'**
  String get litSub;

  /// No description provided for @litNote.
  ///
  /// In en, this message translates to:
  /// **'Book text is not stored in the app: material is in our own words with the source shown under each item.'**
  String get litNote;

  /// No description provided for @litTextbooks.
  ///
  /// In en, this message translates to:
  /// **'Textbooks'**
  String get litTextbooks;

  /// No description provided for @litOfficial.
  ///
  /// In en, this message translates to:
  /// **'Official documents'**
  String get litOfficial;

  /// No description provided for @litOpen.
  ///
  /// In en, this message translates to:
  /// **'Openly licensed sources'**
  String get litOpen;

  /// No description provided for @litOther.
  ///
  /// In en, this message translates to:
  /// **'Other international sources'**
  String get litOther;

  /// No description provided for @litMainBadge.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get litMainBadge;

  /// No description provided for @litRelies.
  ///
  /// In en, this message translates to:
  /// **'Used by'**
  String get litRelies;

  /// No description provided for @litQuestionsN.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String litQuestionsN(int count);

  /// No description provided for @litProceduresN.
  ///
  /// In en, this message translates to:
  /// **'{count} procedures'**
  String litProceduresN(int count);

  /// No description provided for @litTermsN.
  ///
  /// In en, this message translates to:
  /// **'{count} terms'**
  String litTermsN(int count);

  /// No description provided for @litTopics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get litTopics;

  /// No description provided for @litOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get litOpenLink;

  /// No description provided for @litMore.
  ///
  /// In en, this message translates to:
  /// **'and {count} more'**
  String litMore(int count);

  /// No description provided for @litLicense.
  ///
  /// In en, this message translates to:
  /// **'Licence'**
  String get litLicense;

  /// No description provided for @litDetailEmpty.
  ///
  /// In en, this message translates to:
  /// **'No material relies on this source.'**
  String get litDetailEmpty;

  /// No description provided for @admByPlatform.
  ///
  /// In en, this message translates to:
  /// **'Platforms'**
  String get admByPlatform;

  /// No description provided for @admPlatformIos.
  ///
  /// In en, this message translates to:
  /// **'iPhone (iOS)'**
  String get admPlatformIos;

  /// No description provided for @admPlatformAndroid.
  ///
  /// In en, this message translates to:
  /// **'Android'**
  String get admPlatformAndroid;

  /// No description provided for @admUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get admUnknown;

  /// No description provided for @admByLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign-up method'**
  String get admByLogin;

  /// No description provided for @admLoginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email code'**
  String get admLoginEmail;

  /// No description provided for @accountRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Please sign up'**
  String get accountRequiredTitle;

  /// No description provided for @accountRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This section is for registered users only: tests, practice, daily questions, procedures and terms. Signing in with Apple, Google or email is free and takes a minute.'**
  String get accountRequiredBody;

  /// No description provided for @accountRequiredCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in or sign up'**
  String get accountRequiredCta;

  /// No description provided for @accountRequiredHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get accountRequiredHome;

  /// No description provided for @workTitle.
  ///
  /// In en, this message translates to:
  /// **'Workplace'**
  String get workTitle;

  /// No description provided for @workSub.
  ///
  /// In en, this message translates to:
  /// **'Quick reference for your shift'**
  String get workSub;

  /// No description provided for @workEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get workEmptyTitle;

  /// No description provided for @workEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'In the next update: sterilisation regimes, an infection-control reference and calculators. Figures come only from the sanitary rules (SanQvaM) and official sources, with the source shown.'**
  String get workEmptyBody;

  /// No description provided for @hubGoLearn.
  ///
  /// In en, this message translates to:
  /// **'Go to Learn'**
  String get hubGoLearn;

  /// No description provided for @homeHeroNurseTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare for certification with confidence'**
  String get homeHeroNurseTitle;

  /// No description provided for @homeHeroNurseBody.
  ///
  /// In en, this message translates to:
  /// **'Certification questions, oral answers and daily practice in one place.'**
  String get homeHeroNurseBody;

  /// No description provided for @homeHeroNurseCta.
  ///
  /// In en, this message translates to:
  /// **'Certification prep'**
  String get homeHeroNurseCta;

  /// No description provided for @homeTileToifa.
  ///
  /// In en, this message translates to:
  /// **'Test, oral ticket and mistakes'**
  String get homeTileToifa;

  /// No description provided for @homeTileProcedures.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step guides'**
  String get homeTileProcedures;

  /// No description provided for @homeTileWorkplace.
  ///
  /// In en, this message translates to:
  /// **'Quick reference for your shift'**
  String get homeTileWorkplace;

  /// No description provided for @featureLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get featureLessons;

  /// No description provided for @homeTileLessons.
  ///
  /// In en, this message translates to:
  /// **'Lecture decks'**
  String get homeTileLessons;

  /// No description provided for @catFundamentals.
  ///
  /// In en, this message translates to:
  /// **'Fundamentals'**
  String get catFundamentals;

  /// No description provided for @catClinicalNursing.
  ///
  /// In en, this message translates to:
  /// **'Clinical nursing'**
  String get catClinicalNursing;

  /// No description provided for @catProcedures.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get catProcedures;

  /// No description provided for @catPharmacology.
  ///
  /// In en, this message translates to:
  /// **'Pharmacology'**
  String get catPharmacology;

  /// No description provided for @catExams.
  ///
  /// In en, this message translates to:
  /// **'Exams and certification'**
  String get catExams;

  /// No description provided for @kindGuideline.
  ///
  /// In en, this message translates to:
  /// **'Guideline'**
  String get kindGuideline;

  /// No description provided for @rolesTeacherLocked.
  ///
  /// In en, this message translates to:
  /// **'For signed-in accounts only'**
  String get rolesTeacherLocked;

  /// No description provided for @rolesTeacherFailed.
  ///
  /// In en, this message translates to:
  /// **'The server did not confirm the teacher role. Check your connection and try again.'**
  String get rolesTeacherFailed;

  /// No description provided for @toifaTopicOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get toifaTopicOther;

  /// No description provided for @lectureUnverifiedNotice.
  ///
  /// In en, this message translates to:
  /// **'This deck has not been verified yet — review the content before class'**
  String get lectureUnverifiedNotice;

  /// No description provided for @classroomKindProtocol.
  ///
  /// In en, this message translates to:
  /// **'Deck'**
  String get classroomKindProtocol;

  /// No description provided for @lectureProtocols.
  ///
  /// In en, this message translates to:
  /// **'Ready decks'**
  String get lectureProtocols;

  /// No description provided for @quizEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions are coming soon'**
  String get quizEmptyTitle;

  /// No description provided for @quizEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Practice questions will appear here once they are verified.'**
  String get quizEmptyBody;

  /// No description provided for @profileFontSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get profileFontSize;

  /// No description provided for @fontSizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get fontSizeSmall;

  /// No description provided for @fontSizeNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get fontSizeNormal;

  /// No description provided for @fontSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get fontSizeLarge;

  /// No description provided for @fontSizeXLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra large'**
  String get fontSizeXLarge;

  /// No description provided for @profileFeedback.
  ///
  /// In en, this message translates to:
  /// **'Sound and haptics'**
  String get profileFeedback;

  /// No description provided for @profileHaptics.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get profileHaptics;

  /// No description provided for @profileSounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get profileSounds;

  /// No description provided for @welcomeBenefitNurseTitle.
  ///
  /// In en, this message translates to:
  /// **'For nurses'**
  String get welcomeBenefitNurseTitle;

  /// No description provided for @welcomeBenefitNurseBody.
  ///
  /// In en, this message translates to:
  /// **'Certification tests, oral tickets and procedures'**
  String get welcomeBenefitNurseBody;

  /// No description provided for @welcomeBenefitStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'For students'**
  String get welcomeBenefitStudentTitle;

  /// No description provided for @welcomeBenefitStudentBody.
  ///
  /// In en, this message translates to:
  /// **'Lessons, explained tests and exams'**
  String get welcomeBenefitStudentBody;

  /// No description provided for @welcomeBenefitTeacherTitle.
  ///
  /// In en, this message translates to:
  /// **'For teachers'**
  String get welcomeBenefitTeacherTitle;

  /// No description provided for @welcomeBenefitTeacherBody.
  ///
  /// In en, this message translates to:
  /// **'Groups, assignments and big screen'**
  String get welcomeBenefitTeacherBody;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionUnsave.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get actionUnsave;

  /// No description provided for @toifaEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Certification questions are coming soon'**
  String get toifaEmptyTitle;

  /// No description provided for @toifaEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Official list questions will appear here once verified: test, oral ticket and mistakes review.'**
  String get toifaEmptyBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
