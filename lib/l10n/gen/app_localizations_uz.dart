// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTagline => 'HAMSHIRALAR UCHUN';

  @override
  String get navHome => 'Bosh sahifa';

  @override
  String get navLibrary => 'Kutubxona';

  @override
  String get navLearn => 'O‘rganish';

  @override
  String get actionBack => 'Orqaga';

  @override
  String get actionProfile => 'Profil va sozlamalar';

  @override
  String get actionLanguage => 'Til';

  @override
  String get actionRetry => 'Qayta urinish';

  @override
  String get actionContinue => 'Davom etish';

  @override
  String get actionCancel => 'Bekor qilish';

  @override
  String get actionDelete => 'O‘chirish';

  @override
  String get linkCopied => 'Havola nusxalandi';

  @override
  String get notAvailableYet => 'Hali mavjud emas';

  @override
  String get debugBuildBadge => 'DEBUG · DEMO ADAPTERLAR';

  @override
  String get welcomeEyebrow => 'Hamshira yordamchingiz';

  @override
  String get welcomeTitle => 'Hamshiralik ishi.\nAniq va amaliy.';

  @override
  String get welcomeSubtitle =>
      'Attestatsiya, manipulyatsiyalar va o‘rganish — bir joyda.';

  @override
  String get welcomeGetStarted => 'Boshlash / ro‘yxatdan o‘tish';

  @override
  String get welcomeGuest => 'Mehmon sifatida ko‘rish';

  @override
  String get welcomeSignIn => 'Kirish';

  @override
  String get welcomeGuestNote =>
      'Kontentni o‘qish uchun hisob shart emas. Kirish sinxronlash va guruhlar uchun kerak.';

  @override
  String get stateLoading => 'Yuklanmoqda…';

  @override
  String get homeTileTests => 'Mavzu bo‘yicha izohli test';

  @override
  String get homeTileSaved => 'Belgilanganlarga tez qaytish';

  @override
  String get homeTileExam => 'Vaqtli sinov imtihoni';

  @override
  String get homeTileClasses => 'Talabalar va topshiriqlar';

  @override
  String get homeTileLecture => 'Taqdimot va ekranga uzatish';

  @override
  String get authTitle => 'Xush kelibsiz';

  @override
  String get authSubtitle => 'Email orqali kirish yoki yangi hisob ochish.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'name@example.com';

  @override
  String get authEmailInvalid => 'To‘g‘ri email manzil kiriting.';

  @override
  String get authConsent =>
      'Foydalanish shartlari va maxfiylik siyosatini qabul qilaman.';

  @override
  String get authConsentRequired =>
      'Davom etish uchun shartlarni qabul qiling.';

  @override
  String get authGetCode => 'Kod olish';

  @override
  String get authViewTerms => 'Shartlarni ko‘rish';

  @override
  String get authDemoNotice =>
      'Debug build: demo kirish. Email yuborilmaydi; kod keyingi ekranda ko‘rsatiladi.';

  @override
  String get authUnavailableTitle => 'Email orqali kirish hali ulanmagan';

  @override
  String get authUnavailableBody =>
      'Barcha o‘qish kontenti mehmon uchun ochiq. Email xizmati sozlangach kirish yoqiladi.';

  @override
  String get authContinueGuest => 'Mehmon sifatida davom etish';

  @override
  String authRateLimited(int seconds) {
    return 'So‘rovlar juda ko‘p. $seconds soniyadan keyin urinib ko‘ring.';
  }

  @override
  String get authGenericError =>
      'Nimadir xato ketdi. Ulanishni tekshirib, qayta urinib ko‘ring.';

  @override
  String get otpTitle => 'Emailni tasdiqlash';

  @override
  String get otpCodeLabel => '6 xonali kod';

  @override
  String get otpVerify => 'Tasdiqlash';

  @override
  String otpDemoCode(String code) {
    return 'Demo kod: $code. Email yuborilmadi (faqat debug build).';
  }

  @override
  String otpInvalid(int attempts) {
    return 'Kod noto‘g‘ri. Qolgan urinishlar: $attempts.';
  }

  @override
  String get otpExpired => 'Kod muddati tugadi. Yangi kod oling.';

  @override
  String get otpTooManyAttempts => 'Urinishlar juda ko‘p. Yangi kod oling.';

  @override
  String get otpNoActiveCode => 'Faol kod yo‘q. Yangi kod oling.';

  @override
  String get otpFormat => '6 xonali kodni kiriting.';

  @override
  String get otpResend => 'Kodni qayta olish';

  @override
  String otpResendIn(int seconds) {
    return '$seconds soniyadan keyin qayta olish';
  }

  @override
  String otpValidFor(int minutes) {
    return 'Kod $minutes daqiqa amal qiladi.';
  }

  @override
  String get otpResent => 'Yangi kod berildi.';

  @override
  String get rolesTitle => 'Sizga mos ish maydoni';

  @override
  String get rolesSubtitle =>
      'Asosiy yo‘nalishni tanlang. Keyin o‘zgartirish mumkin.';

  @override
  String get rolesNote =>
      'Rol faqat bosh sahifani moslaydi. U boshqa guruhlar yoki ma’lumotlarga ruxsat bermaydi.';

  @override
  String get roleStudent => 'Talaba';

  @override
  String get roleStudentDesc => 'Tushunish, mashq va imtihon';

  @override
  String get roleTeacher => 'Ustoz';

  @override
  String get roleTeacherDesc => 'Guruhlar va topshiriqlar';

  @override
  String get homeTitle => 'Bilim. Ishonch. Amaliyot.';

  @override
  String get homeHeroStudentTitle => 'Darslarni tushunib o‘rganing';

  @override
  String get homeHeroStudentBody => 'Mavzu → test → takrorlash.';

  @override
  String get homeHeroStudentCta => 'Kunlik savollarni boshlash';

  @override
  String get homeHeroTeacherTitle => 'Bilimni darsga aylantiring';

  @override
  String get homeHeroTeacherBody =>
      'Guruhlar, izohli savollar va muddatli topshiriqlar.';

  @override
  String get homeHeroTeacherCta => 'Guruhlarni ochish';

  @override
  String get featureTests => 'Testlar';

  @override
  String get featureSaved => 'Saqlanganlar';

  @override
  String get featureExam => 'Imtihon';

  @override
  String get featureClasses => 'Guruhlar';

  @override
  String get testsFilterAll => 'Barchasi';

  @override
  String get testsEmptyTitle => 'Natija topilmadi';

  @override
  String get testsClearSearch => 'Qidiruvni tozalash';

  @override
  String get contentLoading => 'Kontent yuklanmoqda…';

  @override
  String get contentErrorTitle => 'Kontentni yuklab bo‘lmadi';

  @override
  String get contentErrorBody =>
      'Kontent paketi tekshiruvdan o‘tmadi. Tekshirilmagan ma’lumot hech qachon ko‘rsatilmaydi.';

  @override
  String get sourceNoInterpretation =>
      'NurseGuide alohida natijani talqin qilmaydi, tashxis yoki doza taklif qilmaydi.';

  @override
  String sourceAccessed(String date) {
    return 'Murojaat sanasi: $date';
  }

  @override
  String get sourceReuseRightsVerify =>
      'Foydalanish huquqi: tarqatishdan oldin tekshirilishi kerak';

  @override
  String get sourceReuseCitationOnly =>
      'Kitob: faqat manba sifatida keltirilgan, matn ko‘chirilmagan';

  @override
  String get libTitle => 'Kutubxona';

  @override
  String get libSubtitle => 'Bilimlaringiz bir joyda.';

  @override
  String get libBooks => 'Kitob va qo‘llanmalar';

  @override
  String get libBooksSub => 'Kitob, qo‘llanma va saytlar katalogi';

  @override
  String get libSavedSub => 'Saqlangan materiallar';

  @override
  String get libSources => 'Manbalar va litsenziyalar';

  @override
  String get libSourcesSub => 'Tekshiruv va foydalanish shartlari';

  @override
  String get booksEmptyTitle => 'Hali kitoblar yo‘q';

  @override
  String get booksEmptyBody =>
      'Kitoblar faqat tarqatish huquqi tasdiqlangandan keyin qo‘shiladi. O‘zingiz qo‘shgan PDF shaxsiy o‘rganish uchun qoladi va tarqatilmaydi.';

  @override
  String get booksCatalogNote =>
      'Katalogdagi materiallar rasmiy sahifaga havola sifatida beriladi. To‘liq matn ilovaga faqat ochiq litsenziya yoki tarqatish ruxsati tasdiqlangandan keyin qo‘shiladi.';

  @override
  String get booksResetFilters => 'Filtrlarni tozalash';

  @override
  String get savedEmptyTitle => 'Hali xatcho‘p yo‘q';

  @override
  String get savedEmptyBody =>
      'Material sahifasida “Saqlash”ni bosing — u shu yerda turadi.';

  @override
  String get sourcesTitle => 'Manbalar va litsenziyalar';

  @override
  String get sourcesContent => 'Kontent manbalari';

  @override
  String get sourcesBody =>
      'Nashr etiladigan har bir da’vo asl manba, murojaat sanasi, qamrov va tekshiruv holatiga bog‘lanadi.';

  @override
  String get learnTitle => 'Tushunib o‘rganing';

  @override
  String get learnHeroTag => 'Mavzular va mashq';

  @override
  String get learnHeroTitle => 'Bilimdan amaliyotgacha';

  @override
  String get learnHeroBody =>
      'Mavzu tanlab, savollar bilan bilimingizni tekshiring.';

  @override
  String get learnHeroCta => 'Mavzuni tanlash';

  @override
  String get learnClassesSub => 'Ustoz → topshiriq → talaba → natija';

  @override
  String get learnQuiz => 'Izohli test';

  @override
  String learnQuizSub(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ta mashq savoli',
    );
    return '$_temp0';
  }

  @override
  String get learnExam => 'Imtihon rejimi';

  @override
  String get learnExamSub => 'Vaqt, mavzu va savollar';

  @override
  String get toifaTitle => 'Toifa imtihoniga tayyorgarlik';

  @override
  String get toifaSubtitle => 'Hamshiralik ishi bo‘yicha malaka toifasi';

  @override
  String get toifaEyebrow => 'Hamshira · malaka toifasi';

  @override
  String get toifaEntryBody =>
      'Rasmiy attestatsiya ro‘yxatidagi savollar: 50 savollik test, mavzu bo‘yicha mashq, og‘zaki bilet va xatolar ustida ishlash.';

  @override
  String get toifaEntryBodyShort =>
      'Test, og‘zaki bilet va xatolar ustida ishlash — rasmiy ro‘yxat asosida.';

  @override
  String get toifaEntryTagTest => 'Test · 50 savol';

  @override
  String get toifaEntryTagOral => 'Og‘zaki · 5 savol';

  @override
  String toifaEntryTestActive(int done, int total) {
    return 'Test davom etmoqda: $done / $total javob';
  }

  @override
  String toifaEntryTicketActive(int done, int total) {
    return 'Og‘zaki bilet davom etmoqda: $done / $total';
  }

  @override
  String get toifaOpen => 'Tayyorgarlikni boshlash';

  @override
  String get toifaContinue => 'Davom ettirish';

  @override
  String get toifaUzbekOnly => 'Rasmiy matn — o‘zbekcha';

  @override
  String get toifaUzbekNotice =>
      'Attestatsiya savollarining rasmiy matni o‘zbekcha. Interfeys tili rus yoki ingliz bo‘lsa — yordamchi tarjima ko‘rsatiladi, asl matnni istalgan vaqt ko‘rish mumkin. Baholash rasmiy o‘zbekcha matn va kalit bo‘yicha.';

  @override
  String get toifaShowOriginal => 'Asl matnni ko‘rish';

  @override
  String get toifaHideOriginal => 'Asl matnni yashirish';

  @override
  String get toifaOriginalTitle => 'Rasmiy matn (o‘zbekcha)';

  @override
  String get toifaTranslationAux =>
      'Tarjima yordamchi; baholash rasmiy o‘zbekcha matn bo‘yicha.';

  @override
  String get toifaLoadError => 'Savollar bankini ochib bo‘lmadi';

  @override
  String get toifaYourCategory => 'Toifangiz';

  @override
  String get toifaCatSecond => '2-toifa';

  @override
  String get toifaCatFirst => '1-toifa';

  @override
  String get toifaCatHighest => 'Oliy toifa';

  @override
  String get toifaTransitionNote =>
      'Toifa testi — 2030-yilgacha amal qiladigan malaka toifasi tizimiga tayyorgarlik. 2027-yil 1-iyuldan davlat ro‘yxatidan o‘tkazish joriy etiladi; 2030-yilgacha berilgan toifalar amal qilish muddati tugaguncha o‘z kuchini saqlaydi (PF-192, 10.09.2026).';

  @override
  String get toifaCategoryHint =>
      'Og‘zaki bilet shu toifa ro‘yxatidan tuziladi. Test savollari barcha toifalar uchun umumiy.';

  @override
  String get toifaReadyTest => 'Test';

  @override
  String get toifaReadyOral => 'Og‘zaki';

  @override
  String get toifaPrepare => 'Tayyorgarlik';

  @override
  String get toifaTestTitle => 'Toifa testi';

  @override
  String toifaTestRowSub(int count, int bank) {
    return '$count ta tasodifiy savol · bankda $bank ta';
  }

  @override
  String get toifaPracticeTitle => 'Mavzu bo‘yicha mashq';

  @override
  String toifaPracticeRowSub(int count) {
    return '$count ta mavzu · javobdan keyin kalit va izoh';
  }

  @override
  String get toifaOralTitle => 'Og‘zaki bilet';

  @override
  String toifaOralRowSub(String category, int count) {
    return '$category: $count ta savoldan 5 tasi';
  }

  @override
  String get toifaOralRowPick => 'Avval toifangizni tanlang';

  @override
  String toifaOralRowActive(int done, int total) {
    return 'Davom etmoqda: $done / $total baholandi';
  }

  @override
  String get toifaMistakesTitle => 'Xatolar ustida ishlash';

  @override
  String toifaMistakesRowSub(int tests, int oral) {
    return 'Test xatolari: $tests · og‘zaki “bilmadim”: $oral';
  }

  @override
  String get toifaMistakesRowEmpty => 'Hozircha xato yo‘q';

  @override
  String get toifaProgressTitle => 'Rivojlanish';

  @override
  String get toifaProgressRowSub => 'Mavzular bo‘yicha natija va tayyorlik';

  @override
  String get toifaAboutTitle => 'Manba va tekshiruv';

  @override
  String get toifaListSource => 'Manba: Rasmiy attestatsiya savollari ro‘yxati';

  @override
  String toifaAboutList(int tests, int oral) {
    return 'Ro‘yxatda $tests ta test va $oral ta og‘zaki savol (toifalar bo‘yicha takrorlar birlashtirilgan).';
  }

  @override
  String toifaAboutKeys(int disputed, int ambiguous) {
    return 'Kalit — ro‘yxatda belgilangan javob, ball shu bo‘yicha hisoblanadi. NurseGuide $disputed ta savolda kalitni bahsli, $ambiguous tasida noaniq deb topdi — ularda izoh va manba ko‘rsatiladi.';
  }

  @override
  String toifaAboutKeyless(int count) {
    return '$count ta savolda ro‘yxatda kalit belgilanmagan — ular test va mashqqa kiritilmadi.';
  }

  @override
  String toifaAboutOral(int ready, int total) {
    return 'Og‘zaki javob rejalari — NurseGuide tayyorlagan o‘quv yordami ($ready / $total ta reja manbalar bilan).';
  }

  @override
  String toifaTestSubtitle(int count) {
    return '$count ta savol · rasmiy ro‘yxatdan tasodifiy';
  }

  @override
  String get toifaFormatTitle => 'Format';

  @override
  String toifaFormatStep1(int count, int bank) {
    return 'Bankdagi $bank ta savoldan tasodifiy $count tasi.';
  }

  @override
  String get toifaFormatStep2 =>
      'Har savolda bitta javob; variantlar ro‘yxatdagi tartibda.';

  @override
  String get toifaFormatStep3 =>
      'Yakunda xatolar tahlili: rasmiy kalit va NurseGuide izohi.';

  @override
  String get toifaTimeLabel => 'Vaqt, daqiqa';

  @override
  String get toifaNoTime => 'Vaqtsiz';

  @override
  String get toifaTimeHelper =>
      'Rasmiy vaqt chegarasi ilovada belgilanmagan — o‘zingiz tanlang yoki bo‘sh qoldiring.';

  @override
  String get toifaTimeError =>
      '1 dan 240 gacha daqiqa kiriting yoki bo‘sh qoldiring';

  @override
  String get toifaPassLabel => 'O‘tish chegarasi, %';

  @override
  String get toifaNoPass => 'Belgilanmagan';

  @override
  String get toifaPassHelper =>
      'Bu siz tanlagan chegara, rasmiy o‘tish bali emas.';

  @override
  String get toifaPassError =>
      '1 dan 100 gacha foiz kiriting yoki bo‘sh qoldiring';

  @override
  String get toifaScoringNotice =>
      'Ball rasmiy kalit bo‘yicha hisoblanadi — imtihonda shu javob talab qilinadi. Kalit bahsli savollarda natijada NurseGuide izohi ham ko‘rsatiladi.';

  @override
  String get toifaTestStart => 'Testni boshlash';

  @override
  String get toifaTodayEyebrow => 'Bugun';

  @override
  String toifaTodayGoal(int count) {
    return 'Maqsad: $count ta savol yoki 1 bilet';
  }

  @override
  String get toifaTodayDone => 'Bugungi maqsad bajarildi';

  @override
  String toifaTodayProgress(int answered, int goal) {
    return '$answered/$goal savol';
  }

  @override
  String toifaTodayCorrect(int percent) {
    return '$percent% to‘g‘ri';
  }

  @override
  String toifaTodayTickets(int count) {
    return 'biletlar: $count';
  }

  @override
  String toifaStreakDays(int count) {
    return '$count kun ketma-ket';
  }

  @override
  String get toifaTodayNone => 'Bugun hali mashg‘ulot bo‘lmadi.';

  @override
  String get toifaTodayTomorrow => 'Ertaga ham davom eting — seriya uzilmasin.';

  @override
  String toifaWeekLabel(String values) {
    return 'So‘nggi 7 kun: $values';
  }

  @override
  String get toifaGoalLabel => 'Kunlik maqsad';

  @override
  String toifaGoalOption(int count) {
    return '$count savol';
  }

  @override
  String get toifaGoalHint =>
      'Yoki 1 ta og‘zaki bilet — qaysi biri oldin bajarilsa.';

  @override
  String get toifaReminderTitle => 'NurseGuide · Toifa';

  @override
  String toifaReminderBody(int count) {
    return 'Bugungi toifa mashg‘uloti sizni kutmoqda — $count ta savol yoki 1 bilet';
  }

  @override
  String get toifaReminderChannel => 'Toifa eslatmasi';

  @override
  String get toifaOfferTitle => 'Ertaga davom etamizmi?';

  @override
  String get toifaOfferBody =>
      'Eslatma vaqtini tanlang. Maqsadni bajargan kuningiz eslatma kelmaydi.';

  @override
  String toifaOfferOn(String time) {
    return 'Ertaga soat $time da eslatamiz.';
  }

  @override
  String get toifaModeTitle => 'Rejim';

  @override
  String get toifaModeExam => 'Imtihon rejimi';

  @override
  String get toifaModeExamSub =>
      'Vaqt bilan; ball va xatolar oxirida — haqiqiy imtihondek.';

  @override
  String get toifaModePractice => 'Mashq rejimi — xato darhol ko‘rinadi';

  @override
  String get toifaModePracticeSub =>
      'Har javobdan keyin to‘g‘ri javob va izoh; vaqt yo‘q.';

  @override
  String get toifaDrillStep2 =>
      'Javob bergan zahoti to‘g‘ri yoki xato ko‘rinadi: rasmiy kalit va (bo‘lsa) izoh, manba.';

  @override
  String get toifaDrillStep3 =>
      'Ilova yopilsa ham joyidan davom etasiz; yakunda xatolarni qayta ishlash.';

  @override
  String get toifaDrillStart => 'Mashqni boshlash';

  @override
  String toifaDrillActive(int answered, int total) {
    return 'Mashq davom etmoqda: $answered/$total';
  }

  @override
  String get toifaDrillTitle => 'Mashq rejimi';

  @override
  String get toifaDrillRework => 'Xatolarni qayta ishlash';

  @override
  String toifaDrillScore(int right, int wrong) {
    return 'To‘g‘ri: $right · xato: $wrong';
  }

  @override
  String get toifaDrillFinishEarly => 'Hozircha yakunlash';

  @override
  String get toifaDrillFinishBody =>
      'Javobsiz savollar noto‘g‘ri sanaladi. Berilgan javoblar xatolar ro‘yxatida qoladi.';

  @override
  String get toifaDrillDiscardTitle => 'Mashq to‘xtatilsinmi?';

  @override
  String get toifaDrillNone => 'Davom etayotgan mashq yo‘q';

  @override
  String get toifaDrillNew => 'Yangi test';

  @override
  String toifaDrillUnanswered(int count) {
    return 'Javobsiz: $count';
  }

  @override
  String get toifaThinkHint =>
      'Javobni o‘ylab ko‘ring: ovoz chiqarib ayting yoki qog‘ozga yozing. So‘ng rejani ochib solishtiring.';

  @override
  String toifaThinkTimer(int minutes) {
    return '$minutes daqiqa o‘ylash';
  }

  @override
  String toifaThinkLeft(String time) {
    return 'O‘ylash vaqti: $time';
  }

  @override
  String get toifaThinkUp => 'Vaqt tugadi — endi rejani ochib solishtiring.';

  @override
  String get toifaThinkStop => 'Taymerni to‘xtatish';

  @override
  String get toifaChecklistToggle =>
      'Javob rejasini taqqoslash uchun asosiy so‘zlar';

  @override
  String get toifaChecklistHint =>
      'Javobingizda bo‘lganlarini belgilang (faqat qurilmada, yozish shart emas).';

  @override
  String toifaChecklistCount(int done, int total) {
    return '$done/$total belgilandi';
  }

  @override
  String get toifaRepeatTitle => 'Takrorlash kerak';

  @override
  String get toifaRepeatNote =>
      '“Qisman” va “Bilmadim” savollari keyingi biletlarda birinchi bo‘lib qaytadi.';

  @override
  String get toifaRepeatNone =>
      'Hammasini bildingiz — keyingi biletda yangi savollar.';

  @override
  String get toifaPracticeSubtitle => 'Javobdan keyin darhol kalit';

  @override
  String toifaPracticeMixed(int count) {
    return 'Aralash: $count ta savol';
  }

  @override
  String get toifaPracticeMistakes => 'Xatolarni qayta ishlash';

  @override
  String get toifaBackToTopics => 'Mavzular';

  @override
  String get toifaPracticeRight => 'Javobingiz rasmiy kalitga mos.';

  @override
  String get toifaPracticeWrong => 'Javobingiz rasmiy kalitga mos emas.';

  @override
  String toifaListNumber(int number) {
    return '№ $number';
  }

  @override
  String get toifaOfficialKey => 'Rasmiy kalit';

  @override
  String get toifaNurseGuideNote => 'NurseGuide izohi';

  @override
  String get toifaVerdictDisputed => 'Kalit bahsli';

  @override
  String get toifaVerdictAmbiguous => 'Savol noaniq';

  @override
  String toifaSuggested(String options) {
    return 'NurseGuide fikricha: $options';
  }

  @override
  String get toifaScoredByOfficial =>
      'Ball rasmiy kalit bo‘yicha hisoblanadi — imtihonda shu javob talab qilinadi.';

  @override
  String get toifaNoOfficialKey =>
      'Ro‘yxatda kalit belgilanmagan — bu savol baholanmaydi.';

  @override
  String get toifaNoteNoSource => 'Izoh uchun manba ko‘rsatilmagan.';

  @override
  String toifaOralSubtitle(int count) {
    return '$count ta savol · tayyorlanish va o‘zini baholash';
  }

  @override
  String toifaOralPool(String category, int count) {
    return '$category: ro‘yxatda $count ta savol';
  }

  @override
  String get toifaOralHowTitle => 'Qanday ishlaydi';

  @override
  String toifaOralStep1(int count) {
    return 'Toifangiz ro‘yxatidan tasodifiy $count ta savol.';
  }

  @override
  String get toifaOralStep2 => 'Javoblarni o‘ylab yoki yozib tayyorlaning.';

  @override
  String get toifaOralStep3 =>
      'Javob rejasini ko‘rib, o‘zingizni baholang: bildim, qisman yoki bilmadim.';

  @override
  String get toifaPlanDisclaimer =>
      'Javob rejalari — NurseGuide tayyorlagan o‘quv yordami. Ular rasmiy javob emas.';

  @override
  String get toifaPickCategoryFirst => 'Avval toifani tanlang';

  @override
  String get toifaDrawTicket => 'Bilet olish';

  @override
  String get toifaTicketTitle => 'Biletingiz';

  @override
  String get toifaPrepHint =>
      'Ilovaga yozish shart emas. Har savolga javobni o‘ylab ko‘ring — ovoz chiqarib ayting yoki qog‘ozga yozing. So‘ng javob rejasi bilan solishtirib, o‘zingizni baholaysiz.';

  @override
  String get toifaShowPlans => 'Savollarga birma-bir javob berish';

  @override
  String get toifaShowPlan => 'Javob rejasini ko‘rish';

  @override
  String get toifaNewTicket => 'Yangi bilet';

  @override
  String get toifaNewTicketBody =>
      'Joriy bilet o‘rniga yangi 5 ta savol olinadi. Berilgan baholar saqlanib qoladi.';

  @override
  String get toifaPlanTitle => 'Javob rejasi';

  @override
  String get toifaPlanPending => 'NurseGuide tayyorlagan';

  @override
  String get toifaPlanMissing => 'Bu savol uchun reja hali tayyorlanmagan.';

  @override
  String get toifaPlanNotChecked => 'Bu rejaga manba hali biriktirilmagan.';

  @override
  String get toifaReferenceTitle => 'Me’yoriy ko‘rsatkichlar';

  @override
  String get toifaCutoffTitle => 'Diagnostik chegara (qo‘llanma)';

  @override
  String get toifaWrongLabel => 'Noto‘g‘ri';

  @override
  String get toifaRightLabel => 'To‘g‘ri';

  @override
  String get toifaNeedsSource => 'Manba kerak — ustozdan aniqlashtirilmoqda';

  @override
  String get toifaUnverifiedNote =>
      'Izoh manba bilan tasdiqlanmagan — taklif berilmaydi.';

  @override
  String toifaAgentChecked(String date) {
    return 'Manbalar bilan solishtirilgan: $date';
  }

  @override
  String get toifaHeld => 'Aniqlashtirilmoqda';

  @override
  String get toifaHeldBody =>
      'Savol matni aniqlashtirilguncha biletga va baholashga kirmaydi.';

  @override
  String toifaAboutHeld(int count) {
    return '$count ta savol aniqlashtirilguncha bilet va testdan chiqarilgan.';
  }

  @override
  String get toifaPitfallsTitle => 'Eskirgan / ko‘p uchraydigan xato';

  @override
  String get toifaRateTitle => 'O‘zingizni baholang';

  @override
  String get toifaRateHint =>
      'Baho faqat shu qurilmada saqlanadi va “Xatolar ustida ishlash”da ko‘rinadi.';

  @override
  String get toifaRateKnew => 'Bildim';

  @override
  String get toifaRatePartial => 'Qisman';

  @override
  String get toifaRateUnknown => 'Bilmadim';

  @override
  String get toifaTicketDone => 'Bilet yakunlandi';

  @override
  String toifaTicketSummary(int knew, int partial, int unknown) {
    return 'Bildim: $knew · qisman: $partial · bilmadim: $unknown';
  }

  @override
  String get toifaRatingsSaved =>
      'Baholar saqlandi. Savolni bosib rejani qayta ko‘rish va bahoni o‘zgartirish mumkin.';

  @override
  String get toifaRatingSaved => 'Baho saqlandi';

  @override
  String get toifaMistakesSubtitle => 'Test xatolari va og‘zaki savollar';

  @override
  String get toifaMistakesEmpty => 'Hozircha xato yo‘q';

  @override
  String get toifaMistakesEmptyBody =>
      'Test yoki mashqda xato qilgan savollaringiz va og‘zaki biletda “bilmadim” degan savollaringiz shu yerda yig‘iladi.';

  @override
  String toifaMistakesTests(int count) {
    return 'Test xatolari · $count';
  }

  @override
  String toifaMistakesOralUnknown(int count) {
    return 'Og‘zaki: bilmadim · $count';
  }

  @override
  String toifaMistakesOralPartial(int count) {
    return 'Og‘zaki: qisman · $count';
  }

  @override
  String toifaMoreMistakes(int count) {
    return 'Yana $count ta xato — “Xatolarni qayta ishlash” orqali mashq qiling.';
  }

  @override
  String get toifaNothingHere => 'Bu yerda hozircha hech narsa yo‘q.';

  @override
  String get toifaProgressSubtitle => 'Mavzular bo‘yicha natija va tayyorlik';

  @override
  String get toifaReadyTitle => 'Taxminiy tayyorlik';

  @override
  String get toifaReadyCaption =>
      'Test va og‘zaki natijalar o‘rtachasi. NurseGuide hisobi — rasmiy baho emas.';

  @override
  String toifaReadyTestDetail(int done, int total) {
    return 'Test: $done / $total savol o‘zlashtirildi';
  }

  @override
  String toifaReadyOralDetail(int done, int total) {
    return 'Og‘zaki: $done / $total “bildim”';
  }

  @override
  String get toifaProgressPickCategory =>
      'Og‘zaki natija toifangiz ro‘yxati bo‘yicha hisoblanadi — toifani tanlang:';

  @override
  String get toifaRecentTests => 'So‘nggi testlar';

  @override
  String get toifaPassedShort => 'Chegaradan o‘tdi';

  @override
  String get toifaNotPassedShort => 'Chegaraga yetmadi';

  @override
  String get toifaByTopicNote =>
      'Eng zaif mavzular birinchi. Test — oxirgi javobi to‘g‘ri savollar; og‘zaki — “bildim” deb baholanganlar.';

  @override
  String toifaBarTest(int done, int total) {
    return 'Test: $done / $total';
  }

  @override
  String toifaBarOral(int done, int total) {
    return 'Og‘zaki: $done / $total';
  }

  @override
  String examPassMet(int percent) {
    return 'Chegaradan o‘tdi (≥$percent%)';
  }

  @override
  String examPassMissed(int percent) {
    return 'Chegaraga yetmadi ($percent%)';
  }

  @override
  String quizProgress(int current, int total) {
    return 'Savol $current / $total';
  }

  @override
  String get quizCorrect => 'To‘g‘ri.';

  @override
  String get quizIncorrect => 'Bu javob to‘g‘ri emas.';

  @override
  String get quizNext => 'Keyingi';

  @override
  String get quizFinish => 'Natijani ko‘rish';

  @override
  String get quizDoneTitle => 'Mashq yakunlandi';

  @override
  String quizScore(int correct, int total) {
    return '$total tadan $correct ta to‘g‘ri';
  }

  @override
  String get quizRestart => 'Qayta boshlash';

  @override
  String quizBasis(String basis) {
    return 'Asos: $basis';
  }

  @override
  String get quizSources => 'Manba';

  @override
  String get quizReviewNote =>
      'Mashq savollari o‘quv maqsadida; natija rasmiy baho emas.';

  @override
  String get quizMistakes => 'Xatolar ustida ishlash';

  @override
  String get quizNoMistakes => 'Xato yo‘q — barakalla.';

  @override
  String get quizYourAnswer => 'Sizning javobingiz';

  @override
  String get quizCorrectAnswer => 'To‘g‘ri javob';

  @override
  String get quizChooseTopic => 'Mavzuni tanlang';

  @override
  String quizTopicMixed(int count) {
    return 'Aralash: $count ta tasodifiy savol';
  }

  @override
  String get quizTopicGeneral => 'Umumiy savollar';

  @override
  String quizQuestionCount(int count) {
    return '$count ta savol';
  }

  @override
  String get quizOtherTopic => 'Boshqa mavzu';

  @override
  String get dailyTitle => 'Kunlik savol';

  @override
  String get dailyCardStart => 'Bugungi 5 ta savol';

  @override
  String get dailyCardStartSub =>
      '2–3 daqiqa. Har kuni yangi savollar, javobdan keyin izoh va manba.';

  @override
  String dailyCardProgress(int count, int total) {
    return '$total tadan $count tasiga javob berildi';
  }

  @override
  String dailyCardDone(int correct, int total) {
    return 'Bugun bajarildi: $total tadan $correct ta to‘g‘ri';
  }

  @override
  String get dailyCardDoneSub => 'Ertaga yangi 5 ta savol bo‘ladi.';

  @override
  String get dailyStart => 'Boshlash';

  @override
  String get dailyContinue => 'Davom etish';

  @override
  String get dailyShowResult => 'Natijani ko‘rish';

  @override
  String dailyStreakDays(int count) {
    return '$count kun ketma-ket';
  }

  @override
  String get dailyStreakTitle => 'Ketma-ketlik';

  @override
  String get dailyStreakCurrent => 'Joriy seriya';

  @override
  String get dailyStreakBest => 'Eng uzun seriya';

  @override
  String dailyDaysShort(int count) {
    return '$count kun';
  }

  @override
  String get dailyFreezeAvailable => 'Bu haftalik muzlatish bor';

  @override
  String get dailyFreezeUsed => 'Bu haftalik muzlatish ishlatildi';

  @override
  String get dailyFreezeRule =>
      'Bir kunni o‘tkazib yuborsangiz, seriya uzilmaydi — haftasiga bir marta (muzlatish). Muzlatilgan kun seriyaga qo‘shilmaydi; ketma-ket ikki kun o‘tkazilsa, seriya qaytadan boshlanadi.';

  @override
  String get dailyFreezeSaved =>
      'Kecha o‘tkazib yuborildi — muzlatish seriyani saqlab qoldi.';

  @override
  String get dailyKeepStreak =>
      'Seriyani saqlash uchun bugungi savollarni bajaring.';

  @override
  String get dailyEmpty => 'Bugun uchun savol topilmadi';

  @override
  String get dailyReviewTitle => 'Bugungi savollar';

  @override
  String get dailySourceToifa =>
      'Savollar toifa imtihonining rasmiy ro‘yxatidan olinadi — faqat kaliti NurseGuide tekshiruvidan o‘tganlari.';

  @override
  String get dailyReminderTitle => 'NurseGuide: kunlik savol';

  @override
  String get dailyReminderBody => 'Bugungi 5 ta savol tayyor — 2–3 daqiqa.';

  @override
  String get dailyReminderChannel => 'Kunlik eslatma';

  @override
  String get dailyReminderSetting => 'Kunlik eslatma';

  @override
  String dailyReminderAt(String time) {
    return 'Har kuni soat $time da';
  }

  @override
  String get dailyReminderOff => 'O‘chiq';

  @override
  String get dailyReminderTime => 'Eslatma vaqti';

  @override
  String get dailyOfferTitle => 'Har kuni eslatib turaymi?';

  @override
  String get dailyOfferBody =>
      'Tanlagan vaqtingizda bitta bildirishnoma. Savollarni bajargan kuningiz eslatma kelmaydi. Istalgan payt o‘chirib qo‘yasiz.';

  @override
  String get dailyOfferYes => 'Eslatmani yoqish';

  @override
  String get dailyOfferNo => 'Kerak emas';

  @override
  String get dailyReminderDenied =>
      'Bildirishnomaga ruxsat berilmadi, eslatma o‘chiq qoldi. Telefon sozlamalarida NurseGuide uchun bildirishnomalarni yoqib, qayta urinib ko‘ring.';

  @override
  String get dailyReminderUnavailable =>
      'Bu qurilmada eslatmani yoqib bo‘lmadi.';

  @override
  String dailyReminderOnSnack(String time) {
    return 'Eslatma yoqildi: har kuni soat $time da';
  }

  @override
  String get dailyReminderNote =>
      'Eslatma faqat shu qurilmada rejalashtiriladi (server yo‘q). Telefon quvvatni tejash uchun uni bir necha daqiqa kechiktirishi mumkin. Ilova 7 kun ochilmasa, eslatmalar to‘xtaydi.';

  @override
  String get shareResult => 'Natijani ulashish';

  @override
  String get shareSheetTitle => 'Natija kartochkasi';

  @override
  String get shareSheetBody =>
      'Rasmda ismingiz yoki boshqa shaxsiy ma’lumot yo‘q.';

  @override
  String get shareFailed =>
      'Ulashish oynasini ochib bo‘lmadi. Qayta urinib ko‘ring.';

  @override
  String get shareKindDaily => 'Kunlik savol';

  @override
  String get shareKindExam => 'Mashq imtihoni';

  @override
  String get shareKindToifa => 'Toifa testi mashqi';

  @override
  String get shareCorrectCaption => 'to‘g‘ri javob';

  @override
  String get shareFooter => 'Hamshiralar uchun qo‘llanma va mashqlar';

  @override
  String get shareToifaNote => 'Rasmiy emas, NurseGuide mashq natijasi';

  @override
  String shareText(String kind, int correct, int total, int percent) {
    return 'NurseGuide · $kind: $correct/$total ($percent%)';
  }

  @override
  String get quizTopicMistakes => 'Xatolarim ustida ishlash';

  @override
  String quizMastered(int correct, int total) {
    return '$total tadan $correct tasi oxirgi safar to‘g‘ri';
  }

  @override
  String get examTitle => 'Imtihon rejimi';

  @override
  String get classesTitle => 'Guruh va topshiriqlar';

  @override
  String get classesSignInTitle => 'Guruhlar uchun hisobga kiring';

  @override
  String get classesSignInBody =>
      'Guruh yaratish, qo‘shilish va topshiriq yuborish hisobga bog‘langan. Kontentni o‘qish kirishsiz ochiq qoladi.';

  @override
  String get classesSignIn => 'Kirish';

  @override
  String get classesUnavailableTitle => 'Guruhlar serveri hali ulanmagan';

  @override
  String get classesUnavailableBody =>
      'Hech narsa yuborilmaydi va saqlanmaydi. Ulanganda ustoz faqat o‘z guruhini, talaba faqat o‘z natijasini ko‘radi — bu serverda tekshiriladi.';

  @override
  String get examSubtitle =>
      'Vaqtli sinov: mavzular, savollar soni va vaqtni tanlang. Internetsiz ishlaydi.';

  @override
  String get examActiveTitle => 'Tugallanmagan imtihon';

  @override
  String examActiveBody(int answered, int total, String time) {
    return '$answered/$total javob · $time qoldi';
  }

  @override
  String get examResume => 'Davom ettirish';

  @override
  String get examDiscard => 'Imtihonni to‘xtatish';

  @override
  String get examDiscardTitle => 'Imtihon to‘xtatilsinmi?';

  @override
  String get examDiscardBody =>
      'Javoblar o‘chadi va natija tarixga yozilmaydi.';

  @override
  String get examDiscardAction => 'To‘xtatish';

  @override
  String get examTopics => 'Mavzular';

  @override
  String get examAllTopics => 'Hammasi';

  @override
  String examPoolCount(int count) {
    return 'Tanlangan mavzularda $count ta savol';
  }

  @override
  String get examSettings => 'Sozlamalar';

  @override
  String get examCount => 'Savollar soni';

  @override
  String examCountHint(int max) {
    return '1 dan $max gacha';
  }

  @override
  String examCountError(int max) {
    return '1 dan $max gacha son kiriting';
  }

  @override
  String examCountAll(int count) {
    return 'Barcha $count ta';
  }

  @override
  String get examTime => 'Vaqt, daqiqa';

  @override
  String get examTimeHint => '1–180 daqiqa · odatda 1 daqiqa / savol';

  @override
  String get examTimeError => '1 dan 180 gacha daqiqa kiriting';

  @override
  String examMinutes(int count) {
    return '$count daq';
  }

  @override
  String get examRulesNotice =>
      'Savollar va variantlar tasodifiy tartibda. Yakunlashgacha javobni o‘zgartirish, savolni belgilab keyin qaytish mumkin. Vaqt ilova yopiq bo‘lsa ham davom etadi; tugasa, imtihon o‘zi yakunlanadi.';

  @override
  String get examStart => 'Imtihonni boshlash';

  @override
  String get examReplaceTitle => 'Tugallanmagan imtihon bor';

  @override
  String get examReplaceBody =>
      'Yangisini boshlasangiz, oldingisi javoblari bilan o‘chadi.';

  @override
  String get examHistory => 'Natijalar tarixi';

  @override
  String get examHistoryEmpty =>
      'Hali imtihon topshirilmagan. Birinchi natijangiz shu yerda chiqadi — u faqat shu qurilmada saqlanadi.';

  @override
  String examHistoryStats(int count, int avg, int best) {
    return 'So‘nggi $count ta: o‘rtacha $avg% · eng yaxshi $best%';
  }

  @override
  String examHistoryRow(String date, int correct, int total, String time) {
    return '$date · $correct/$total · $time';
  }

  @override
  String get examHistoryClear => 'Tarixni tozalash';

  @override
  String get examHistoryClearBody =>
      'Barcha imtihon natijalari shu qurilmadan o‘chiriladi.';

  @override
  String examProgressLabel(String values) {
    return 'So‘nggi natijalar: $values';
  }

  @override
  String get examProgressOld => 'Eskiroq → yangi';

  @override
  String get examProgressLast => 'Oxirgisi';

  @override
  String get examSettled => 'Oldingi imtihon vaqti tugagani uchun yakunlandi';

  @override
  String get examOpenResult => 'Natija';

  @override
  String get examTitleAll => 'Barcha mavzular';

  @override
  String examTitleTopics(String first, int more) {
    return '$first va yana $more ta';
  }

  @override
  String get examReworkTitle => 'Xatolar ustida ishlash';

  @override
  String get examQuestionMissing => 'Bu savol joriy kontent to‘plamida yo‘q.';

  @override
  String get examMap => 'Savollar xaritasi';

  @override
  String get examFinish => 'Yakunlash';

  @override
  String get examFinishTitle => 'Imtihon yakunlansinmi?';

  @override
  String examFinishBody(int unanswered, int flagged) {
    return 'Javobsiz: $unanswered ta, belgilangan: $flagged ta. Yakunlangach javoblarni o‘zgartirib bo‘lmaydi.';
  }

  @override
  String get examFinishBodyAll =>
      'Barcha savollarga javob berildi. Yakunlangach javoblarni o‘zgartirib bo‘lmaydi.';

  @override
  String get examFinishClassTitle => 'Test yakunlansinmi?';

  @override
  String get examFinishClassBody => 'Javoblar ustozga yuboriladi.';

  @override
  String get examFlag => 'Belgilash';

  @override
  String get examFlagged => 'Belgilangan';

  @override
  String get examLegendAnswered => 'Javob berilgan';

  @override
  String get examLegendEmpty => 'Javobsiz';

  @override
  String get examLegendFlagged => 'Belgilangan';

  @override
  String examQuestionN(int n) {
    return '$n-savol';
  }

  @override
  String examAnsweredOf(int answered, int total) {
    return '$answered/$total javob berildi';
  }

  @override
  String get examPrev => 'Oldingi';

  @override
  String get examNext => 'Keyingi';

  @override
  String examTimeLeft(String time) {
    return 'Qolgan vaqt: $time';
  }

  @override
  String examElapsed(String time) {
    return 'O‘tgan vaqt: $time';
  }

  @override
  String get examNoActive => 'Faol imtihon yo‘q';

  @override
  String get examNoActiveBody =>
      'U yakunlangan yoki to‘xtatilgan. Yangi imtihonni sozlab boshlang.';

  @override
  String get examNew => 'Yangi imtihon';

  @override
  String get examSaving => 'Natija saqlanmoqda…';

  @override
  String get examResultTitle => 'Natija';

  @override
  String get examResultMissing => 'Natija topilmadi';

  @override
  String get examBand90 => 'A’lo natija!';

  @override
  String get examBand70 => 'Yaxshi natija!';

  @override
  String get examBand50 => 'Yomon emas — xatolarni ko‘rib chiqing';

  @override
  String get examBand0 => 'Mashq qiling — siz uddalaysiz';

  @override
  String get examCorrectN => 'To‘g‘ri';

  @override
  String get examWrongN => 'Xato';

  @override
  String get examSkippedN => 'Javobsiz';

  @override
  String get examSpent => 'Vaqt';

  @override
  String get examTimedOut => 'Vaqt tugadi — avtomatik yakunlandi';

  @override
  String examDeltaUp(int n) {
    return 'Oldingi urinishdan +$n%';
  }

  @override
  String examDeltaDown(int n) {
    return 'Oldingi urinishdan −$n%';
  }

  @override
  String get examDeltaSame => 'Oldingi urinish bilan bir xil';

  @override
  String examReworkMistakes(int count) {
    return 'Xatolarni qayta ishlash · $count';
  }

  @override
  String get examAnalysis => 'Xatolar tahlili';

  @override
  String examFilterMistakes(int count) {
    return 'Xatolar · $count';
  }

  @override
  String examFilterAll(int count) {
    return 'Hammasi · $count';
  }

  @override
  String get examNoAnswer => 'Javob berilmagan';

  @override
  String get examWrongTag => 'Xato';

  @override
  String get examWhyWrong => 'Nega bu javob emas';

  @override
  String get examNoSource => 'Bu savolga manba ko‘rsatilmagan.';

  @override
  String get examSourceMissing =>
      'Bu imtihonning savollar banki ilovada topilmadi';

  @override
  String get examMultiHint => 'Bir nechta to‘g‘ri javob — hammasini belgilang';

  @override
  String get examNoExplanation => 'Bu savolga izoh hali yozilmagan.';

  @override
  String get examByTopic => 'Mavzular bo‘yicha';

  @override
  String get examByTopicNote =>
      'Eng past natijali mavzu birinchi — shundan boshlang.';

  @override
  String get classesSubtitle =>
      'Ustoz guruh ochadi va topshiriq beradi, talabalar kod bilan qo‘shilib yechadi.';

  @override
  String get classesTryExam => 'Internetsiz imtihonni ochish';

  @override
  String get classesLoading => 'Yuklanmoqda…';

  @override
  String get classesInvalid =>
      'Server ma’lumotni qabul qilmadi — maydonlarni tekshiring.';

  @override
  String get classesCodeNotFound =>
      'Bu kod bilan guruh topilmadi. Kodni ustozdan qayta tekshirib oling.';

  @override
  String get classesCreate => 'Guruh yaratish';

  @override
  String get classesCreateSub => 'Ustoz uchun: kod oling va topshiriq bering';

  @override
  String get classesJoin => 'Kod bilan qo‘shilish';

  @override
  String get classesJoinSub => 'Talaba uchun: ustoz bergan 8 belgili kod';

  @override
  String get classesRoleNote =>
      'Ilovadagi rol server huquqi bermaydi: guruhni faqat o‘zini ustoz sifatida ro‘yxatdan o‘tkazgan hisob ochadi va faqat o‘z guruhlarini boshqaradi.';

  @override
  String get classesMine => 'Mening guruhlarim';

  @override
  String get classesEmpty => 'Hali guruh yo‘q';

  @override
  String get classesEmptyBody =>
      'Guruh yarating yoki ustozingiz bergan kod bilan qo‘shiling.';

  @override
  String get classesRoleTeacher => 'Ustoz';

  @override
  String get classesRoleStudent => 'Talaba';

  @override
  String classesMembers(int count) {
    return '$count a’zo';
  }

  @override
  String get classesCreateIntro =>
      'Guruhni ochgan ustoz faqat shu guruhni boshqaradi. Talabalar siz bergan kod yoki QR bilan qo‘shiladi.';

  @override
  String get classesGroupName => 'Guruh nomi';

  @override
  String get classesGroupNameHint => 'Masalan, Hamshiralik ishi 2-kurs';

  @override
  String classesLengthError(int min, int max) {
    return '$min–$max belgi kiriting';
  }

  @override
  String get classesDisplayName => 'Taxallus (ixtiyoriy)';

  @override
  String get classesDisplayNameHint =>
      'Masalan, Yulduz — bo‘sh qoldirsangiz, tartib raqami';

  @override
  String get classesDisplayNameNote =>
      'Ism-familiya serverda saqlanmaydi: talabalar taxallus yoki tartib raqami bilan ko‘rinadi. Real ismni faqat o‘z qurilmangizda belgi sifatida yozishingiz mumkin.';

  @override
  String get classesCreateAction => 'Guruhni yaratish';

  @override
  String get classesCreated => 'Guruh yaratildi — kodni talabalarga yuboring';

  @override
  String get classesJoinIntro => 'Ustozingiz bergan kodni kiriting.';

  @override
  String get classesCode => 'Taklif kodi';

  @override
  String get classesCodeError => 'Kod 8 ta harf va raqamdan iborat';

  @override
  String get classesJoinNote =>
      'Haqiqiy ismingizni yozmang. Ustoz faqat taxallusingiz (yoki tartib raqamingiz) va topshiriq natijalaringizni ko‘radi; boshqa talabalar sizni ko‘rmaydi. Emailingiz ko‘rsatilmaydi.';

  @override
  String get classesJoinAction => 'Qo‘shilish';

  @override
  String get classesJoined => 'Guruhga qo‘shildingiz';

  @override
  String classesYouTeacher(int count) {
    return 'Siz — ustoz · $count a’zo';
  }

  @override
  String get classesYouStudent => 'Siz — talaba';

  @override
  String get classesGroupMissing =>
      'Guruh topilmadi yoki siz endi a’zo emassiz';

  @override
  String get classesBackToList => 'Guruhlar ro‘yxatiga';

  @override
  String get classesAssignments => 'Topshiriqlar';

  @override
  String get classesNoAssignmentsTeacher =>
      'Hali topshiriq yo‘q. Savol bankidan mavzu va sonni tanlab topshiriq bering.';

  @override
  String get classesNoAssignmentsStudent => 'Hozircha topshiriq yo‘q';

  @override
  String get classesNoAssignmentsStudentBody =>
      'Ustoz topshiriq berganda shu yerda paydo bo‘ladi.';

  @override
  String get classesNoDue => 'muddatsiz';

  @override
  String classesDue(String date) {
    return 'muddat $date';
  }

  @override
  String classesSubmittedOf(int done, int total) {
    return '$done/$total topshirdi';
  }

  @override
  String classesMembersTitle(int count) {
    return 'Talabalar · $count';
  }

  @override
  String get classesNoStudents => 'Hali talaba qo‘shilmagan — kodni yuboring.';

  @override
  String get classesMemberNoWork => 'Hali topshirmagan';

  @override
  String classesMemberSummary(int done, int total, int avg) {
    return '$done/$total topshiriq · o‘rtacha $avg%';
  }

  @override
  String get classesRemove => 'Guruhdan chiqarish';

  @override
  String classesRemoveTitle(String name) {
    return '$name guruhdan chiqarilsinmi?';
  }

  @override
  String get classesRemoveBody =>
      'U guruhni va yangi topshiriqlarni ko‘rmaydi. Topshirgan natijalari o‘chmaydi.';

  @override
  String get classesRemoveAction => 'Chiqarish';

  @override
  String classesStatusDone(int score, int total) {
    return 'Topshirildi · $score/$total';
  }

  @override
  String get classesStatusInProgress => 'Davom etmoqda';

  @override
  String get classesStatusPending => 'Yuborilmagan';

  @override
  String get classesStatusOverdue => 'Muddat o‘tgan';

  @override
  String get classesStatusNew => 'Yangi';

  @override
  String get classesStudentNote =>
      'Ustoz faqat siz yozgan ismni va topshiriq natijalaringizni ko‘radi.';

  @override
  String get classesLeave => 'Guruhdan chiqish';

  @override
  String get classesLeaveTitle => 'Guruhdan chiqasizmi?';

  @override
  String get classesLeaveBody =>
      'Qayta qo‘shilish uchun ustozdan kod kerak bo‘ladi. Topshirgan natijalaringiz ustozda qoladi.';

  @override
  String get classesLeaveAction => 'Chiqish';

  @override
  String get classesInviteTitle => 'Taklif kodi';

  @override
  String get classesInviteBody =>
      'Talabalar QR kodni telefon kamerasi bilan skanerlaydi va “Ilovada ochish” ni bosadi — yoki: O‘rganish → Guruh va topshiriqlar → Kod bilan qo‘shilish.';

  @override
  String get classesCopyCode => 'Kodni nusxalash';

  @override
  String get classesCopyInvite => 'Taklif matnini nusxalash';

  @override
  String get classesCopied => 'Nusxalandi';

  @override
  String classesInviteText(String name, String code) {
    return 'NurseGuide ilovasidagi “$name” guruhiga qo‘shiling: O‘rganish → Guruh va topshiriqlar → Kod bilan qo‘shilish. Kod: $code';
  }

  @override
  String get classesAssignmentTitle => 'Topshiriq nomi';

  @override
  String get classesTimeLimit => 'Vaqt chegarasi, daqiqa';

  @override
  String get classesNoLimit => 'Vaqtsiz';

  @override
  String get classesDueNone => 'Muddatsiz';

  @override
  String classesDueDays(int count) {
    return '$count kun';
  }

  @override
  String get classesDuePick => 'Sana tanlash';

  @override
  String get classesDueNoneBody =>
      'Muddat yo‘q — talabalar istalgan vaqtda topshiradi.';

  @override
  String classesDueAt(String date) {
    return 'Muddat: $date gacha';
  }

  @override
  String classesPreview(int count) {
    return 'Tanlangan savollar · $count';
  }

  @override
  String get classesReshuffle => 'Boshqa savollar';

  @override
  String get classesKeyNotice =>
      'Talabalar to‘g‘ri javoblarni oldindan ko‘rmaydi — ball serverda hisoblanadi. Har talaba bir marta topshiradi.';

  @override
  String get classesSendAssignment => 'Topshiriqni berish';

  @override
  String get classesSubmitted => 'Javoblar yuborildi';

  @override
  String get classesSubmitNetwork =>
      'Internet yo‘q — javoblar qurilmada saqlandi. Keyin qayta yuboring.';

  @override
  String get classesSubmitRejected =>
      'Server javoblarni qabul qilmadi: vaqt yoki muddat tugagan, yoki topshiriq avval topshirilgan.';

  @override
  String get classesAssignmentMissing => 'Topshiriq topilmadi';

  @override
  String get classesMetricQuestions => 'Savollar';

  @override
  String get classesMetricLimit => 'Vaqt chegarasi';

  @override
  String get classesMetricDue => 'Muddat';

  @override
  String get classesMetricSubmitted => 'Topshirdi';

  @override
  String get classesMetricAverage => 'O‘rtacha ball';

  @override
  String get classesPendingTitle => 'Javoblar hali yuborilmagan';

  @override
  String get classesPendingBody =>
      'Ular qurilmada saqlangan. Internet ulanganda qayta yuboring — server vaqt chegarasi ichida qabul qiladi.';

  @override
  String get classesResend => 'Qayta yuborish';

  @override
  String get classesOverdueTitle => 'Muddat o‘tgan';

  @override
  String get classesOverdueBody => 'Bu topshiriqni endi topshirib bo‘lmaydi.';

  @override
  String classesOutdatedPack(int count) {
    return 'Bu topshiriqdagi $count ta savol ilovangizdagi to‘plamda yo‘q. Ilovani yangilang.';
  }

  @override
  String classesStartNotice(int minutes) {
    return 'Boshlaganingizdan so‘ng $minutes daqiqa beriladi — vaqt to‘xtamaydi, tugaganda javoblar o‘zi yuboriladi. Bir marta topshiriladi; yuborish uchun internet kerak.';
  }

  @override
  String get classesStartNoticeNoLimit =>
      'Vaqt chegarasi yo‘q. Javoblar bir marta yuboriladi, qayta topshirib bo‘lmaydi; yuborish uchun internet kerak.';

  @override
  String get classesStart => 'Boshlash';

  @override
  String classesSubmittedAt(String date) {
    return 'Topshirildi: $date';
  }

  @override
  String get classesServerScore => 'Ball serverda hisoblandi';

  @override
  String get classesResults => 'Natijalar';

  @override
  String get classesColStudent => 'Talaba';

  @override
  String get classesColScore => 'Ball · %';

  @override
  String get classesNotSubmitted => 'Topshirmagan';

  @override
  String get classesByQuestion => 'Savollar bo‘yicha';

  @override
  String get classesByQuestionEmpty => 'Hali hech kim topshirmagan.';

  @override
  String classesWrongOf(int wrong, int total) {
    return '$wrong/$total xato';
  }

  @override
  String get classesSending => 'Javoblar yuborilmoqda…';

  @override
  String get classesMyProgress => 'Mening natijalarim';

  @override
  String classesDoneOf(int done, int total) {
    return '$done/$total topshiriq bajarildi';
  }

  @override
  String classesAverage(int avg) {
    return 'O‘rtacha ball: $avg%';
  }

  @override
  String get classesStudentResultTitle => 'Talaba natijasi';

  @override
  String get classesStudentAnswer => 'Talaba javobi';

  @override
  String get classesInviteMore => 'Yana talaba taklif qilish';

  @override
  String get profileTitle => 'Profil va sozlamalar';

  @override
  String get profileGuest => 'Mehmon';

  @override
  String get profileGuestSub => 'Kontent hisobsiz ochiq';

  @override
  String get profileGuestLocal => 'Ma’lumotlar faqat shu qurilmada';

  @override
  String get profileDemoSession => 'Demo sessiya · debug build';

  @override
  String get profileRole => 'Yo‘nalish';

  @override
  String get profileRoleSub => 'Bosh sahifa sizga moslashadi';

  @override
  String get profileLanguage => 'Til';

  @override
  String get profileAppearance => 'Tashqi ko‘rinish';

  @override
  String get themeSystem => 'Tizim';

  @override
  String get themeLight => 'Kunduzgi';

  @override
  String get themeDark => 'Tungi';

  @override
  String get themeTitle => 'Mavzu';

  @override
  String get themeRowSub => 'Ilova ranglari va sarlavha shrifti';

  @override
  String get themeCurrent => 'Joriy mavzu';

  @override
  String get themeClassicName => 'Klassik';

  @override
  String get themeClassicDesc => 'NurseGuide yashil ranglari';

  @override
  String get themeIvoryName => 'Ivory';

  @override
  String get themeIvoryDesc =>
      'Fil suyagi, qora va oltin, nafis serif sarlavhalar';

  @override
  String get themeModeSection => 'Kunduzgi yoki tungi';

  @override
  String get profilePrivacy => 'Maxfiylik va ma’lumotlar';

  @override
  String get profilePrivacySub => 'Ma’lumotlar va hisob boshqaruvi';

  @override
  String get supportTitle => 'Taklif va yordam';

  @override
  String get supportSub => 'Taklif, xatolik yoki savol — javob shu yerda';

  @override
  String get supportNew => 'Yangi murojaat';

  @override
  String get supportEmptyTitle => 'Hali murojaat yo‘q';

  @override
  String get supportEmptyBody =>
      'Taklif, xatolik yoki savolingizni yozing — javob shu yerda ko‘rinadi.';

  @override
  String get supportKind => 'Turi';

  @override
  String get supportKindSuggestion => 'Taklif';

  @override
  String get supportKindBug => 'Xatolik';

  @override
  String get supportKindQuestion => 'Savol';

  @override
  String get supportSubject => 'Mavzu';

  @override
  String get supportSubjectHint => 'Qisqacha: nima haqida?';

  @override
  String get supportMessage => 'Xabar';

  @override
  String get supportMessageHint =>
      'Batafsil yozing: qaysi ekranda, nima qildingiz, nima kutgan edingiz';

  @override
  String get supportAttach => 'Skrinshot biriktirish (ixtiyoriy)';

  @override
  String get supportAttachRemove => 'Rasmni olib tashlash';

  @override
  String get supportAttachTooLarge =>
      'Rasm 5 MB dan katta. Kichikroq rasm tanlang.';

  @override
  String get supportAttachType => 'Faqat PNG yoki JPEG rasm.';

  @override
  String get supportPhiNotice =>
      'Skrinshotda bemorning ismi, tug‘ilgan sanasi, karta raqami yoki boshqa shaxsiy ma’lumoti bo‘lmasin.';

  @override
  String get supportSend => 'Yuborish';

  @override
  String get supportSent => 'Murojaat yuborildi';

  @override
  String get supportReplyHint => 'Javob yozing…';

  @override
  String get supportTeam => 'NurseGuide jamoasi';

  @override
  String get supportYou => 'Siz';

  @override
  String get supportUser => 'Foydalanuvchi';

  @override
  String get supportHumanReplies =>
      'Javoblarni NurseGuide jamoasi o‘zi yozadi; avtomatik javob yuborilmaydi.';

  @override
  String get supportStatusNew => 'Yangi';

  @override
  String get supportStatusInReview => 'Ko‘rib chiqilmoqda';

  @override
  String get supportStatusAnswered => 'Javob berildi';

  @override
  String get supportStatusClosed => 'Yopildi';

  @override
  String get supportUnread => 'Yangi javob';

  @override
  String supportUnreadCount(int count) {
    return '$count ta yangi javob';
  }

  @override
  String get supportSignInTitle => 'Murojaat uchun hisobga kiring';

  @override
  String get supportSignInBody =>
      'Javobni sizga yetkazish uchun email bilan kirish kerak. Qurilmadagi ma’lumotlaringiz o‘zgarmaydi.';

  @override
  String get supportUnavailableTitle => 'Server hali ulanmagan';

  @override
  String get supportUnavailableBody =>
      'Bu buildda hisoblar, murojaatlar va guruhlar serveri ulanmagan. Ulangach shu yerda ishlaydi.';

  @override
  String get errNetwork => 'Internetga ulanib bo‘lmadi. Qayta urinib ko‘ring.';

  @override
  String get errRateLimited =>
      'Juda ko‘p so‘rov. Birozdan keyin urinib ko‘ring.';

  @override
  String get errInvalidSupport =>
      'Mavzu kamida 3 belgi bo‘lsin, xabar bo‘sh bo‘lmasin.';

  @override
  String get errForbidden => 'Bu amal uchun ruxsat yo‘q.';

  @override
  String get errSessionExpired => 'Sessiya tugagan. Qaytadan kiring.';

  @override
  String get errGeneric => 'Bajarib bo‘lmadi. Qayta urinib ko‘ring.';

  @override
  String get accountDelete => 'Hisobni o‘chirish';

  @override
  String get accountDeleteSub =>
      'Serverdagi hisob, murojaatlar va guruh a’zoligi o‘chadi';

  @override
  String get accountDeleteTitle => 'Hisob o‘chirilsinmi?';

  @override
  String get accountDeleteBody =>
      'Hisobingiz, kirish usullari (Google/Apple bog‘lanishi), guruhlardagi a’zolik va natijalaringiz hamda “Taklif va yordam” murojaatlari serverdan butunlay o‘chiriladi. Ustoz bo‘lsangiz, yaratgan guruhlaringiz ham o‘chadi. Buni qaytarib bo‘lmaydi. Ilova ichida yuborgan shikoyatlar matni hisobga bog‘lanmagan holda qoladi. Qurilmadagi ma’lumotlar ham tozalanadi.';

  @override
  String get accountDeleted => 'Hisob o‘chirildi';

  @override
  String get adminTitle => 'Admin panel';

  @override
  String get adminSub => 'Moderatsiya, murojaatlar, kontent, adminlar';

  @override
  String get adminMfaTitle => 'Ikki bosqichli himoya';

  @override
  String get adminMfaEnrollBody =>
      'Admin panel uchun autentifikator ilovasi kerak (Google Authenticator, Microsoft Authenticator, 1Password…). Kalitni ilovaga qo‘shing va u ko‘rsatgan 6 xonali kodni kiriting.';

  @override
  String get adminMfaVerifyBody =>
      'Autentifikator ilovasidagi 6 xonali kodni kiriting.';

  @override
  String get adminMfaSecret => 'Kalit';

  @override
  String get adminMfaCopy => 'Kalitni nusxalash';

  @override
  String get adminMfaOpen => 'Autentifikatorda ochish';

  @override
  String get adminMfaCode => '6 xonali kod';

  @override
  String get adminMfaVerify => 'Tasdiqlash';

  @override
  String get adminMfaWrong =>
      'Kod noto‘g‘ri yoki eskirgan. Ilovadagi yangi kodni kiriting.';

  @override
  String get adminCopied => 'Nusxalandi';

  @override
  String get adminForbiddenTitle => 'Faqat admin uchun';

  @override
  String get adminForbiddenBody =>
      'Admin vakolatini server beradi — ilovadagi rol yoki email buni o‘zgartirmaydi.';

  @override
  String get adminStats => 'Statistika';

  @override
  String get adminRegistered => 'Ro‘yxatdan o‘tgan';

  @override
  String get adminNewToday => 'Bugun yangi';

  @override
  String get adminNew7 => '7 kunda yangi';

  @override
  String get adminNew30 => '30 kunda yangi';

  @override
  String get adminActiveToday => 'Bugun faol';

  @override
  String get adminActive7 => '7 kunda faol';

  @override
  String get adminActive30 => '30 kunda faol';

  @override
  String get adminDefinitions =>
      'Ro‘yxatdan o‘tgan — emailini kod bilan tasdiqlagan hisob; mehmonlar va kodni tasdiqlamaganlar sanalmaydi. Yangi — email birinchi tasdiqlangan kun. Faol — davr ichida ilovani hisobiga kirgan holda kamida bir marta ochgan. Kunlar Toshkent vaqti bo‘yicha; “7 kun” bugun bilan birga.';

  @override
  String get adminByRole => 'Rollar bo‘yicha';

  @override
  String get adminByLanguage => 'Tillar bo‘yicha';

  @override
  String adminNoProfile(int count) {
    return 'Profil hali yaratilmagan: $count';
  }

  @override
  String get adminInbox => 'Murojaatlar';

  @override
  String adminAwaiting(int count) {
    return 'Javob kutmoqda: $count';
  }

  @override
  String get adminAllStatuses => 'Hammasi';

  @override
  String get adminUsers => 'Foydalanuvchilar';

  @override
  String get adminAudit => 'Amallar tarixi';

  @override
  String get adminAuditEmpty => 'Hali amal yo‘q';

  @override
  String get adminSearchHint => 'Email bo‘yicha qidirish';

  @override
  String get adminAllRoles => 'Barcha rollar';

  @override
  String get adminAllLanguages => 'Barcha tillar';

  @override
  String get adminShowEmail => 'Emailni ko‘rsatish (jurnalga yoziladi)';

  @override
  String adminPage(int from, int to, int total) {
    return '$from–$to / $total';
  }

  @override
  String get adminPrev => 'Oldingi';

  @override
  String get adminNext => 'Keyingi';

  @override
  String adminRegisteredOn(String date) {
    return 'Ro‘yxatdan: $date';
  }

  @override
  String adminLastSeen(String date) {
    return 'Oxirgi faollik: $date';
  }

  @override
  String get adminNoUsers => 'Foydalanuvchi topilmadi';

  @override
  String get adminReplyHint => 'Javob matnini o‘zingiz yozing';

  @override
  String get adminSendReply => 'Javob yuborish';

  @override
  String get adminStatus => 'Holat';

  @override
  String get adminActionSupportReply => 'Murojaatga javob';

  @override
  String get adminActionSupportStatus => 'Murojaat holati o‘zgardi';

  @override
  String get adminActionRevealEmail => 'Email ko‘rildi';

  @override
  String get adminActionAdminGranted => 'Admin vakolati berildi';

  @override
  String get adminActionAdminRevoked => 'Admin vakolati olindi';

  @override
  String get profileSignIn => 'Email orqali kirish';

  @override
  String get profileSignOut => 'Chiqish';

  @override
  String get profileRestartSetup => 'Sozlashni boshidan boshlash';

  @override
  String get profileSignOutTitle => 'Hisobdan chiqilsinmi?';

  @override
  String get profileSignOutBody =>
      'Xatcho‘plar, eslatmalar va mashq natijalari shu qurilmada qoladi. Qurilmadan boshqa odam foydalanadigan bo‘lsa, ularni ham o‘chiring.';

  @override
  String get profileSignOutDelete => 'Chiqish va o‘chirish';

  @override
  String profileVersion(String version) {
    return 'Versiya $version';
  }

  @override
  String get privacyTitle => 'Maxfiylik va ma’lumotlar';

  @override
  String get privacyBody =>
      'Asosiy bo‘limlar hisobsiz (mehmon rejimida) ishlaydi: sozlamalar, xatcho‘plar va mashq natijalari shu qurilmada saqlanadi. Hisob ixtiyoriy (email kodi, Google yoki Apple bilan) — guruhlar va “Taklif va yordam” uchun kerak. Bunda ma’lumotlar Cloudflare serverida (Sharqiy Yevropa, O‘zbekistondan tashqarida) saqlanadi: email faqat hash va niqoblangan ko‘rinishda, kirish usuli, rol, til, oxirgi faollik vaqti (daqiqagacha); guruhda — taxallus yoki tartib raqami, test javoblari va ballar; murojaat va shikoyat matnlari. Google/Apple’dan faqat hisob identifikatori va email olinadi, token saqlanmaydi. Ustoz faqat o‘z guruhini ko‘radi. Reklama, analitika va kuzatuv yo‘q. Hisobni “Hisobni o‘chirish” tugmasi bilan istalgan vaqtda o‘chirishingiz mumkin. To‘liq matn — “Maxfiylik siyosati” havolasida.';

  @override
  String get privacyBodyLocal =>
      'Bu buildda server ulanmagan: ilova serverga hech narsa yubormaydi. Sozlamalar, xatcho‘plar va mashq natijalari shu qurilmada saqlanadi (qurilmaning o‘z zaxira nusxasiga kirishi mumkin). Reklama va kuzatuv yo‘q.';

  @override
  String get privacyTerms => 'Foydalanish shartlari';

  @override
  String get privacyTermsSub => 'Yakuniy matn tayyorlanadi';

  @override
  String get privacyDeleteLocal => 'Lokal ma’lumotlarni o‘chirish';

  @override
  String get privacyDeleteLocalSub =>
      'Sozlamalar, xatcho‘plar, tugallanmagan testlar va mashq natijalari';

  @override
  String get privacyDeleteConfirmTitle => 'Lokal ma’lumotlar o‘chirilsinmi?';

  @override
  String get privacyDeleteConfirmBody =>
      'Shu qurilmadagi sozlamalar, xatcho‘plar, tugallanmagan testlar va mashq natijalari o‘chiriladi. Buni qaytarib bo‘lmaydi.';

  @override
  String get privacyDeleted => 'Lokal ma’lumotlar o‘chirildi';

  @override
  String get termsTitle => 'Foydalanish shartlari';

  @override
  String get termsBody =>
      'NurseGuide — hamshiralar uchun bepul ma’lumotnoma va o‘quv ilovasi. Ilovadan foydalanib, siz quyidagi shartlarga rozilik bildirasiz.\n\n1. Tibbiy cheklov. NurseGuide tashxis qo‘ymaydi, davolash yoki dori buyurmaydi va muassasangizning tasdiqlangan tartiblari, dori vositalari yo‘riqnomalari hamda shifokor buyrug‘ini almashtirmaydi. Har bir ma’lumot ostida manbasi ko‘rsatilgan; qaror qabul qilishda asl manba va o‘z muassasangiz qoidalariga tayaning.\n\n2. Hisob. Ba’zi imkoniyatlar (guruhlar, testlar, murojaatlar) uchun email orqali ro‘yxatdan o‘tish kerak. Hisobingiz xavfsizligi va u orqali qilingan harakatlar uchun o‘zingiz javobgarsiz. Hisobni istalgan vaqtda Profil → Maxfiylik va ma’lumotlar → Hisobni o‘chirish orqali o‘chirishingiz mumkin.\n\n3. Ustoz va talaba guruhlari. Talaba guruhga qo‘shilganda ustoz uning taxallusi (yoki tartib raqami) va test natijalarini ko‘radi. Ustoz guruhni faqat o‘quv maqsadida boshqaradi.\n\n4. Foydalanuvchi kontenti. Murojaatlarda yozganlaringiz uchun o‘zingiz javobgarsiz. Haqoratli, noqonuniy, reklama, boshqa shaxsning shaxsiy ma’lumoti yoki roziligisiz intim tasvirlar joylash qat’iyan taqiqlanadi. Bunday kontent o‘chiriladi, qoidabuzar hisobi cheklanishi yoki o‘chirilishi mumkin.\n\n5. Mualliflik huquqi. Ilova matnlari, slaydlari, testlari va dizayni NurseGuide mualliflariga tegishli; tashqi manbalar o‘z litsenziyasi bilan ko‘rsatilgan. Ularni tijorat maqsadida nusxalash va tarqatish mumkin emas.\n\n6. Xizmat. Ilova “boricha” taqdim etiladi; uzilishlar va xatolar bo‘lishi mumkin, biz ularni imkon qadar tez tuzatamiz. Shartlar o‘zgarsa, ilovada xabar beramiz.\n\n7. Maxfiylik. Ma’lumotlaringiz qanday ishlatilishi maxfiylik siyosatida yozilgan: nurseguide.nfcstore.uz/privacy\n\n8. Aloqa: nurseguide@nfcstore.uz';

  @override
  String get rightsUnknown => 'Tarqatish huquqi tasdiqlanmagan';

  @override
  String get rightsPersonal => 'Faqat shaxsiy o‘rganish uchun — tarqatilmaydi';

  @override
  String get rightsPermitted => 'Tarqatish ruxsati qayd etilgan';

  @override
  String get rightsDenied => 'Tarqatishga ruxsat yo‘q';

  @override
  String get kindBook => 'Kitob';

  @override
  String get kindManual => 'Qo‘llanma';

  @override
  String get kindMethod => 'Metodika';

  @override
  String get kindArticle => 'Maqola';

  @override
  String get kindQuestionSet => 'Savollar to‘plami';

  @override
  String get kindWebsite => 'Veb-resurs';

  @override
  String libAccessOpen(String licence) {
    return 'Ochiq litsenziya · $licence';
  }

  @override
  String get libAccessFree => 'Bepul o‘qish · faqat havola';

  @override
  String get libAccessCatalog => 'Faqat katalog yozuvi';

  @override
  String get libOpenSource => 'Rasmiy sahifani ochish';

  @override
  String libChecked(String date) {
    return 'Sahifa va litsenziya tekshirilgan: $date';
  }

  @override
  String libItemPack(String size) {
    return 'Oflayn paket · $size';
  }

  @override
  String libItemSupersedes(String title) {
    return 'Yangi nashr. Oldingisi: $title';
  }

  @override
  String get libSearchEntry => 'Kitob, muallif, mavzu qidirish';

  @override
  String libBooksCount(int count) {
    return '$count ta manba · qidiruv va filtrlar';
  }

  @override
  String get libContinueReading => 'O‘qishni davom ettirish';

  @override
  String get libSearchLabel => 'Kutubxonadan qidirish';

  @override
  String get libSearchHint => 'Nomi, muallif, mavzu…';

  @override
  String get libFilterLanguage => 'Til';

  @override
  String get libFilterTopic => 'Mavzu';

  @override
  String get libFilterType => 'Turi';

  @override
  String get libFilterSectionField => 'Yo‘nalish';

  @override
  String get libFilterSectionGroup => 'Mavzu';

  @override
  String get libFilterSectionKind => 'Material turi';

  @override
  String get libFilterSectionOpen => 'Qanday ochiladi';

  @override
  String libResultCount(int shown, int total) {
    return '$total ta materialdan $shown tasi';
  }

  @override
  String get libClearFilters => 'Tozalash';

  @override
  String get libFilteredEmptyTitle => 'Bu filtrlar bo‘yicha material yo‘q';

  @override
  String get libFilteredEmptyBody =>
      'Bitta filtrni olib tashlang yoki boshqa so‘z bilan qidiring — masalan, muallif familiyasi.';

  @override
  String get libOpenLink => 'Havola · tashqi sayt';

  @override
  String libOpenLinkHint(String host) {
    return 'Brauzerda ochiladi: $host';
  }

  @override
  String get libOpenInApp => 'Ilova ichidagi fayl';

  @override
  String get libOpenInAppHint => 'Ilova ichida o‘qiladi — internet shart emas';

  @override
  String get libOpenDownload => 'Yuklab olinadigan kitob';

  @override
  String libOpenDownloadHint(String size) {
    return 'Yuklab olingach ilova ichida o‘qiladi · $size';
  }

  @override
  String get libOpenPending => 'Kutilmoqda';

  @override
  String get libOpenPendingHint => 'Material hali olinmagan — ochib bo‘lmaydi';

  @override
  String get libOpenReceivedHint =>
      'Fayl qabul qilindi va tekshirilmoqda — hali ochilmaydi';

  @override
  String get libOpenRecordHint =>
      'Faylni tarqatish huquqi qayd etilmagan — ilovada ochilmaydi';

  @override
  String get libOpenLinkShort => 'Havola';

  @override
  String get libOpenInAppShort => 'Ilova ichida';

  @override
  String get libOpenDownloadShort => 'Yuklab olinadigan';

  @override
  String get libOpenRecordShort => 'Faqat yozuv';

  @override
  String get libItemRead => 'O‘qish';

  @override
  String libItemContinue(int page) {
    return '$page-sahifadan davom etish';
  }

  @override
  String get libItemCannotOpen => 'Ochib bo‘lmaydi';

  @override
  String get libDownloadUnavailable =>
      'Yuklab olish serveri hali ulanmagan — kitobni hozircha yuklab bo‘lmaydi.';

  @override
  String get libDetailsTitle => 'Ma’lumotlar';

  @override
  String get libFieldAuthors => 'Muallif';

  @override
  String get libFieldYear => 'Yil';

  @override
  String get libFieldEdition => 'Nashr';

  @override
  String get libFieldPublisher => 'Nashriyot';

  @override
  String get libFieldAccess => 'Kirish';

  @override
  String get libFieldStatus => 'Holat';

  @override
  String get libFieldRights => 'Tarqatish huquqi';

  @override
  String libFieldRightsRecorded(String date, String by) {
    return 'Qayd etilgan: $date · $by';
  }

  @override
  String get libFieldTopics => 'Mavzular';

  @override
  String get libFieldPages => 'Sahifalar';

  @override
  String get libStateNotReceived => 'Hali olinmagan';

  @override
  String get libStateReceived => 'Qabul qilindi, tekshirilmoqda';

  @override
  String get libStateCataloged => 'Kataloglangan';

  @override
  String get libStateLinked => 'Kartalarga bog‘langan';

  @override
  String get libStateReviewed => 'Domla tasdiqlagan';

  @override
  String get libProvidedByTeacher => 'Domla bergan material';

  @override
  String get libItemNotFound => 'Material topilmadi';

  @override
  String get libItemNotFoundBody =>
      'Kontent paketi yangilangan bo‘lishi mumkin. Katalogga qayting.';

  @override
  String get libItemUnavailable => 'Material sizning tilingizda mavjud emas';

  @override
  String get libItemUnavailableBody =>
      'Bu material hozircha faqat boshqa tilda mavjud. Interfeys tilini o‘zgartiring yoki katalogga qayting.';

  @override
  String get libBackToCatalog => 'Katalogga qaytish';

  @override
  String get readerTitle => 'O‘quvchi';

  @override
  String readerPageOf(int page, int total) {
    return '$page / $total';
  }

  @override
  String get readerToc => 'Mundarija';

  @override
  String get readerTocEmpty => 'Bu faylda mundarija yo‘q';

  @override
  String get readerTocEmptyBody =>
      'Sahifaga o‘ting yoki kerakli joyga xatcho‘p qo‘ying.';

  @override
  String get readerBookmarks => 'Xatcho‘plar';

  @override
  String get readerAddBookmark => 'Shu sahifani belgilash';

  @override
  String get readerBookmarkName => 'Xatcho‘p nomi';

  @override
  String get readerBookmarkNameHint => 'Masalan: muhim jadval';

  @override
  String readerBookmarkSaved(int page) {
    return 'Xatcho‘p saqlandi: $page-sahifa';
  }

  @override
  String get readerBookmarkRemoved => 'Xatcho‘p o‘chirildi';

  @override
  String get readerBookmarkRemove => 'Xatcho‘pni o‘chirish';

  @override
  String get readerBookmarksEmpty => 'Hali xatcho‘p yo‘q';

  @override
  String get readerBookmarksEmptyBody =>
      'Kerakli sahifada “Shu sahifani belgilash”ni bosing — keyin bir bosishda qaytasiz.';

  @override
  String readerPageLabel(int page) {
    return '$page-sahifa';
  }

  @override
  String get readerGoTo => 'Sahifaga o‘tish';

  @override
  String get readerGoToShort => 'Sahifa';

  @override
  String readerGoToHint(int total) {
    return '1 dan $total gacha';
  }

  @override
  String readerGoToError(int total) {
    return '1 dan $total gacha raqam kiriting';
  }

  @override
  String get readerGo => 'O‘tish';

  @override
  String get readerSave => 'Saqlash';

  @override
  String get readerRenameBookmark => 'Xatcho‘p nomini o‘zgartirish';

  @override
  String get libFieldProvidedBy => 'Kimdan';

  @override
  String get libQueryEmptyBody =>
      'Boshqa so‘z bilan qidiring — masalan, muallif familiyasi yoki mavzu nomi.';

  @override
  String get readerZoomIn => 'Kattalashtirish';

  @override
  String get readerZoomOut => 'Kichiklashtirish';

  @override
  String readerResumed(int page) {
    return 'Oxirgi o‘qilgan joy: $page-sahifa';
  }

  @override
  String get readerFromStart => 'Boshidan';

  @override
  String get readerLoading => 'Fayl ochilmoqda…';

  @override
  String get readerFileMissing => 'Fayl topilmadi';

  @override
  String get readerFileMissingBody =>
      'Bu fayl ilova ichida yo‘q. Ilovani yangilab ko‘ring.';

  @override
  String get readerFileCorrupted => 'Fayl tekshiruvdan o‘tmadi';

  @override
  String get readerFileCorruptedBody =>
      'Fayl hajmi yoki nazorat yig‘indisi katalogdagiga mos emas — u buzilgan yoki almashtirilgan bo‘lishi mumkin, shuning uchun ochilmadi.';

  @override
  String get readerOpenFailed => 'PDF ochilmadi';

  @override
  String get readerBlockedTitle => 'Ilova ichida ochilmaydi';

  @override
  String get readerBlockedRights =>
      'Ilovada faqat to‘liq tarqatish huquqi qayd etilgan fayllar ochiladi. Bu material uchun bunday fayl yo‘q.';

  @override
  String get readerBookmarkedPage => 'Bu sahifa belgilangan';

  @override
  String get lessonsTitle => 'Dars mavzulari';

  @override
  String classesSeat(String n) {
    return 'Talaba $n';
  }

  @override
  String classesQrLabel(String code) {
    return 'Taklif kodi QR: $code';
  }

  @override
  String get classesTeacherRegisterEyebrow => 'Ustoz';

  @override
  String get classesTeacherRegisterTitle =>
      'O‘zingizni ustoz sifatida ro‘yxatdan o‘tkazing';

  @override
  String get classesTeacherRegisterBody =>
      'Ustoz o‘z guruhini ochadi va faqat o‘z talabalari natijasini ko‘radi. Bu admin huquqi emas va boshqa guruhlarga ta’sir qilmaydi.';

  @override
  String get classesTeacherRegister => 'Ustoz sifatida ro‘yxatdan o‘tish';

  @override
  String get classesLocalNameTitle => 'Belgi (faqat shu qurilmada)';

  @override
  String get classesLocalNameBody =>
      'Masalan, talabaning ismi. Serverga yuborilmaydi va talaba ko‘rmaydi.';

  @override
  String get classesLocalNameHint => 'Bo‘sh — belgini o‘chirish';

  @override
  String get classesLocalNameSave => 'Saqlash';

  @override
  String get classroomPlanTitle => 'O‘quv rejasi';

  @override
  String get classroomPlanSub =>
      'Kunlar bo‘yicha mavzular: ma’ruza, savol-javob, test';

  @override
  String get classroomTopicsTitle => 'Mavzular';

  @override
  String get classroomTopicsSub => 'Ustoz ochgan mavzular va testlar';

  @override
  String get classroomProgramEyebrow => 'O‘quv dasturi';

  @override
  String classroomPlanProgress(int done, int total) {
    return '$done/$total mavzu testi yakunlangan';
  }

  @override
  String get classroomStartNone =>
      'Boshlanish sanasi belgilanmagan — jadval kun tartibi bilan';

  @override
  String classroomStartAt(String date) {
    return '1-o‘quv kuni: $date';
  }

  @override
  String get classroomStartNote =>
      'Sanalar taxminiy (yakshanba o‘tkaziladi, bayramlar hisobga olinmaydi) va faqat shu qurilmada saqlanadi.';

  @override
  String get classroomStartPick => 'Boshlanish sanasini belgilash';

  @override
  String classroomDayN(int n) {
    return '$n-kun';
  }

  @override
  String classroomWeekN(int n) {
    return '$n-hafta';
  }

  @override
  String classroomHours(int n) {
    return '$n soat';
  }

  @override
  String get classroomTypeLecture => 'Ma’ruza';

  @override
  String get classroomTypePractical => 'Amaliy';

  @override
  String get classroomTypeSeminar => 'Seminar';

  @override
  String get classroomTypeAttestation => 'Attestatsiya';

  @override
  String get classroomTypeOther => 'Mashg‘ulot';

  @override
  String get classroomStatusClosed => 'Ochilmagan';

  @override
  String get classroomStatusOpened => 'Ochildi';

  @override
  String get classroomStatusLectured => 'O‘tildi';

  @override
  String get classroomStatusOral => 'Savol-javob o‘tdi';

  @override
  String get classroomStatusTestRunning => 'Test davom etmoqda';

  @override
  String get classroomStatusTestDone => 'Test yakunlandi';

  @override
  String get classroomNoCurriculumTitle => 'O‘quv dasturi hali qo‘shilmagan';

  @override
  String get classroomNoCurriculumBody =>
      'Kurs jadvali (modul → mavzu → materiallar) ilovaning keyingi versiyasida keladi. Hozircha guruh topshiriqlaridan foydalaning.';

  @override
  String get classroomCurriculumError => 'O‘quv dasturini o‘qib bo‘lmadi';

  @override
  String get classroomNoTopicsStudent => 'Ustoz hali mavzu ochmagan';

  @override
  String get classroomNoTopicsStudentBody =>
      'Mavzu ochilganda materiallar va test shu yerda chiqadi.';

  @override
  String get classroomTopicTitle => 'Mavzu';

  @override
  String get classroomTopicMissing => 'Mavzu o‘quv dasturida topilmadi';

  @override
  String get classroomTopicNotOpened => 'Bu mavzu hali ochilmagan';

  @override
  String get classroomOpenNote =>
      'Ochilgandan keyin talabalar mavzu materiallarini ko‘radi.';

  @override
  String get classroomOpenTopic => 'Talabalarga ochish';

  @override
  String classroomStep(int n) {
    return '$n-bosqich';
  }

  @override
  String get classroomStageLecture => 'Ma’ruza';

  @override
  String get classroomStageLectureBody =>
      'Mavzuni katta ekranda slaydlar bilan ko‘rsating (internetsiz ham ishlaydi).';

  @override
  String get classroomStageOral => 'Og‘zaki savol-javob';

  @override
  String classroomStageOralBody(int count) {
    return 'Savollar ro‘yxati va javob rejasi. So‘ralgan: $count.';
  }

  @override
  String get classroomStageTest => 'Guruh testi';

  @override
  String get classroomStageTestBody =>
      'Savollarni tanlang va testni boshlang — talabalarda darhol ochiladi.';

  @override
  String get classroomStageDone => 'O‘tildi';

  @override
  String get classroomMarkDone => 'O‘tildi deb belgilash';

  @override
  String get classroomOralOpen => 'Savollar ro‘yxati';

  @override
  String get classroomTestPrepare => 'Testni tayyorlash';

  @override
  String get classroomTestResults => 'Natijalar paneli';

  @override
  String get classroomTestFinish => 'Testni yakunlash';

  @override
  String get classroomTestFinishTitle => 'Test yakunlansinmi?';

  @override
  String get classroomTestFinishBody =>
      'Yangi urinish qabul qilinmaydi. Boshlab qo‘yganlar javobini yuborishi uchun 2 daqiqa qoladi.';

  @override
  String classroomTestSubmitted(int done, int total) {
    return '$done/$total talaba topshirdi';
  }

  @override
  String get classroomTestNotStarted => 'Ustoz hali testni boshlamagan.';

  @override
  String get classroomTestOpenStudent => 'Test ochiq — yechish';

  @override
  String get classroomMaterials => 'Mavzu materiallari';

  @override
  String get classroomNoMaterials =>
      'Ilovada bu mavzuga bog‘langan material hali yo‘q.';

  @override
  String get classroomGapNote =>
      'Ilovada bu mavzu bo‘yicha material kam — ustoz o‘z manbalaridan to‘ldiradi.';

  @override
  String get classroomPlanRecommended => 'NurseGuide tavsiya etgan amaliy reja';

  @override
  String get classroomOralNotice =>
      'Savollar avtomatik tanlangan nomzodlar; javob rejasi — o‘quv yordami. “So‘raldi” va baholar faqat shu qurilmada saqlanadi.';

  @override
  String get classroomOralEmpty => 'Bu mavzu uchun og‘zaki savol topilmadi';

  @override
  String classroomCandidate(int n) {
    return 'Nomzod savol $n';
  }

  @override
  String get classroomOralPlan => 'Qisqa javob rejasi';

  @override
  String get classroomOralNoPlan => 'Javob rejasi hali yozilmagan.';

  @override
  String get classroomOralAsked => 'So‘raldi';

  @override
  String classroomOralGrade(int count) {
    return 'Talabalarni baholash ($count)';
  }

  @override
  String get classroomOralGradeTitle => 'Kim qanday javob berdi';

  @override
  String get classroomOralGradeNote =>
      'Faqat shu qurilmada; serverga yuborilmaydi.';

  @override
  String get classroomGradeKnew => 'Bildi';

  @override
  String get classroomGradePartial => 'Qisman';

  @override
  String get classroomGradeDidNot => 'Bilmadi';

  @override
  String get classroomCandidatesNotice =>
      'Nomzod savollar avtomatik tanlangan. Har birini va kalitini ko‘rib chiqing: ball ko‘rsatilgan kalit bo‘yicha serverda hisoblanadi.';

  @override
  String classroomCandidatesTitle(int picked, int total) {
    return 'Nomzodlar · tanlandi $picked/$total';
  }

  @override
  String get classroomPickAll => 'Hammasi';

  @override
  String get classroomPickNone => 'Bekor qilish';

  @override
  String classroomKeyShown(String answer) {
    return 'Kalit: $answer';
  }

  @override
  String get classroomKeyFlagged => 'Kalit bahsli';

  @override
  String get classroomPickAtLeastOne => 'Kamida bitta savol tanlang';

  @override
  String get classroomPickMax => 'Ko‘pi bilan 50 ta savol';

  @override
  String classroomTestStart(int count) {
    return 'Testni boshlash · $count savol';
  }

  @override
  String get classroomTestStarted => 'Test boshlandi — talabalarda ochildi';

  @override
  String classroomTestTitle(String topic) {
    return 'Test: $topic';
  }

  @override
  String get classroomTestAlready => 'Bu mavzu testi allaqachon boshlangan';

  @override
  String get classroomTestNoCandidates =>
      'Bu mavzu uchun test savoli topilmadi';

  @override
  String get classroomTestNoCandidatesBody =>
      'Guruh topshirig‘ini qo‘lda tuzishingiz mumkin (Yangi topshiriq).';

  @override
  String get lectureTitle => 'Ma’ruza';

  @override
  String get lectureListTitle => 'Ma’ruza rejimi';

  @override
  String get lectureListSub =>
      'Mavzuni tanlang — slaydlar katta ekranda, internetsiz';

  @override
  String get lectureStart => 'Ma’ruzani boshlash';

  @override
  String get lectureClose => 'Ma’ruzani yopish';

  @override
  String lectureCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get lecturePrev => 'Orqaga';

  @override
  String get lectureNext => 'Oldinga';

  @override
  String get lectureGoals => 'Maqsad';

  @override
  String get lectureKeyPoints => 'Asosiy tushunchalar';

  @override
  String lectureQuestionN(int n) {
    return 'Savol $n';
  }

  @override
  String get lectureEndEyebrow => 'Keyingi qadam';

  @override
  String get lectureEndTitle => 'Savol-javob va test';

  @override
  String get lectureEndOral => 'Og‘zaki savol-javob — ustoz so‘raydi';

  @override
  String get lectureEndTest => 'Guruh testi — ilovada, vaqt bilan';

  @override
  String get lectureUzOnly => 'Bu taqdimot hozircha faqat o‘zbek tilida';

  @override
  String get lectureNotesShow => 'Ustoz izohini ko‘rsatish';

  @override
  String get lectureNotesHide => 'Ustoz izohini yashirish';

  @override
  String get lectureTeacherNote => 'Ustoz uchun izoh';

  @override
  String get cmAdminDone => 'Bajarildi';

  @override
  String get admYouSuper => 'Siz — egasi (super admin)';

  @override
  String get admYouAdmin => 'Siz — admin';

  @override
  String get adm2faOn =>
      'Ikki bosqichli himoya (2FA) tasdiqlangan. Har bir admin amali uchun so‘raladi.';

  @override
  String get admNotConnected => 'Bu serverda hali ulanmagan';

  @override
  String get admTeam => 'Adminlar boshqaruvi';

  @override
  String admTeamCount(int count) {
    return 'Adminlar: $count';
  }

  @override
  String get admTeamSubManage => 'Email bo‘yicha qo‘shish va olib tashlash';

  @override
  String get admTeamSubView => 'Ro‘yxat (o‘zgartirish — faqat egasi)';

  @override
  String get admLegacyNote =>
      'Statistika, foydalanuvchilar va amallar tarixi bo‘limlari bu serverga hali ko‘chirilmagan — tayyor bo‘lganda shu yerda chiqadi.';

  @override
  String get admOther => 'Boshqa bo‘limlar';

  @override
  String get admTeamIntro =>
      'Admin barcha admin bo‘limlariga to‘liq kiradi: murojaatlar, foydalanuvchilar, shikoyatlar. Vakolatni faqat server beradi va har amal uchun 2FA kodi so‘raladi.';

  @override
  String get admTeamOwnerOnly =>
      'Adminlarni faqat egasi (super admin) qo‘shadi va olib tashlaydi.';

  @override
  String get admAddTitle => 'Admin qo‘shish';

  @override
  String get admAddEmail => 'Email (masalan, Gmail)';

  @override
  String get admAddHint =>
      'Vakolat shu email bilan kirib, 2FA ni yoqqanda kuchga kiradi; hisobi bo‘lsa — darhol.';

  @override
  String get admAddButton => 'Admin qilish';

  @override
  String get admAddConfirmTitle => 'Admin qilinsinmi?';

  @override
  String admAddConfirmBody(String email) {
    return '$email barcha admin bo‘limlariga to‘liq kiradi. Istalgan vaqtda olib tashlashingiz mumkin.';
  }

  @override
  String admAdded(String email) {
    return 'Qo‘shildi: $email';
  }

  @override
  String get admInvalidEmail => 'Email noto‘g‘ri. Masalan: ism@gmail.com';

  @override
  String get admErrAlready => 'Bu email allaqachon admin.';

  @override
  String get admErrSuper =>
      'Bu email — egasi (super admin), u allaqachon admin.';

  @override
  String admErrTooMany(int max) {
    return 'Adminlar chegarasi: $max ta. Avval birini olib tashlang.';
  }

  @override
  String admListTitle(int count) {
    return 'Adminlar ($count)';
  }

  @override
  String get admKindSuper => 'Egasi · super admin';

  @override
  String admKindGranted(String date) {
    return 'Admin · qo‘shilgan $date';
  }

  @override
  String get admNotSignedIn =>
      'Hali kirmagan — vakolat birinchi kirishda kuchga kiradi';

  @override
  String get admYou => 'Siz';

  @override
  String get admRemove => 'Olib tashlash';

  @override
  String get admRemoveTitle => 'Admin olib tashlansinmi?';

  @override
  String admRemoveBody(String email) {
    return '$email admin vakolatini darhol yo‘qotadi — barcha qurilmalarda. Hisobi va boshqa ma’lumotlari o‘chmaydi.';
  }

  @override
  String admRemoved(String email) {
    return 'Olib tashlandi: $email';
  }

  @override
  String get admSuperNote =>
      'Egasi maxfiy server sozlamasida (LG_ADMIN_EMAILS) — ilovadan olib tashlanmaydi.';

  @override
  String get admNoGranted => 'Hali qo‘shilgan admin yo‘q.';

  @override
  String get adminActionGrantAdded => 'Admin qo‘shildi';

  @override
  String get adminActionGrantRemoved => 'Admin olib tashlandi';

  @override
  String get contactPrivacyPolicy => 'Maxfiylik siyosati';

  @override
  String get autoPresTitle => 'Avtomatik taqdimot';

  @override
  String get autoPresEntrySub => 'Ilovadagi manbali mazmundan slaydlar';

  @override
  String get autoPresShowAnswer => 'Javobni ko‘rsatish';

  @override
  String get autoPresHideAnswer => 'Javobni yashirish';

  @override
  String get contactRowTitle => 'Aloqa va shikoyat';

  @override
  String get contactRowSub => 'Savol, shikoyat, xato haqida xabar';

  @override
  String get contactTitle => 'Aloqa';

  @override
  String get contactIntro =>
      'Internetsiz va hisobsiz ham ishlaydi: xat pochta ilovangiz orqali yuboriladi.';

  @override
  String get contactEmailLabel => 'Elektron pochta';

  @override
  String get contactCopy => 'Manzilni nusxalash';

  @override
  String get contactCopied => 'Manzil nusxalandi';

  @override
  String get contactNoMailApp =>
      'Pochta ilovasi ochilmadi. Manzil nusxalandi: xatni istalgan pochta xizmatidan yuboring.';

  @override
  String get contactQuestionTitle => 'Savol va takliflar';

  @override
  String get contactQuestionBody =>
      'Ilova haqida savol bering, mavzu yoki yaxshilash bo‘yicha taklif yuboring.';

  @override
  String get contactQuestionAction => 'Xat yozish';

  @override
  String get contactReportTitle => 'Shikoyat / xato haqida xabar';

  @override
  String get contactReportBody =>
      'Noto‘g‘ri tibbiy ma’lumot yoki nomaqbul foydalanuvchi kontenti haqida yozing.';

  @override
  String get contactReportHint =>
      'Xatda bo‘lim yoki karta nomini yozing: tezroq topamiz.';

  @override
  String get contactReportAction => 'Shikoyat yuborish';

  @override
  String get contactResponseNote =>
      'Har bir xabarni o‘qiymiz va tasdiqlangan xatolarni tuzatamiz, lekin javob muddatini va’da qila olmaymiz. Bu manzil shoshilinch tibbiy yordam uchun emas.';

  @override
  String get contactPrivacyNote =>
      'Bizga yozsangiz, email manzilingiz va yozganingiz bizga ko‘rinadi.';

  @override
  String contactMailBodyQuestion(String version, String platform) {
    return 'Savol yoki taklifingiz:\n\n\n---\nIlova: NurseGuide $version\nPlatforma: $platform';
  }

  @override
  String contactMailBodyReport(String version, String platform) {
    return 'Bo‘lim / karta nomi:\nNima noto‘g‘ri:\n(Bemor ma’lumotlarini yozmang.)\n\n\n---\nIlova: NurseGuide $version\nPlatforma: $platform';
  }

  @override
  String get authOr => 'yoki';

  @override
  String get authSignInApple => 'Apple bilan kirish';

  @override
  String get authSignInGoogle => 'Google bilan kirish';

  @override
  String get authSocialFailed =>
      'Kirib bo‘lmadi. Ulanishni tekshirib qayta urinib ko‘ring yoki email kodidan foydalaning.';

  @override
  String get authSocialEmailUnverified =>
      'Bu hisobning emaili tasdiqlanmagan, shuning uchun u bilan kirib bo‘lmaydi. Email kodidan foydalaning.';

  @override
  String get authSocialEmailRequired =>
      'Bu hisob email manzilini bermadi. Email kodidan foydalaning.';

  @override
  String get accountDeleteAppleNote =>
      'Siz Apple orqali kirgansiz, shuning uchun hisobni o‘chirishdan oldin Apple tasdiq so‘raydi. Bu NurseGuide’ni Apple ID’ngizdan ham uzadi.';

  @override
  String get accountDeleteAppleCancelled =>
      'Hech narsa o‘chirilmadi: Apple tasdig‘i bekor qilindi.';

  @override
  String get admPanelAccess =>
      'Kirish: egasi emaili (ADMIN_EMAILS) va email kodi. Server har so‘rovda qayta tekshiradi.';

  @override
  String get admOverview => 'Umumiy ko‘rsatkichlar';

  @override
  String admOverviewSub(int total, int online, int week) {
    return 'Ro‘yxatdan o‘tgan: $total · onlayn: $online · 7 kunda yangi: $week';
  }

  @override
  String get admComplaintsRow => 'Ilova shikoyatlari';

  @override
  String admComplaintsRowSub(int count) {
    return 'Ochiq: $count';
  }

  @override
  String admEmailNote(String email) {
    return 'Email orqali yozilgan shikoyat va savollar $email manziliga keladi — ularni pochtada ko‘ring (ilovaga tushmaydi).';
  }

  @override
  String get admUsersSub =>
      'Email yoki taxallus bo‘yicha qidirish, rol, to‘xtatish';

  @override
  String get admAuditSub => 'Har bir admin amali yoziladi';

  @override
  String get admStoreTitle => 'Yuklab olishlar va sotuvlar';

  @override
  String get admStoreBody =>
      'Do‘kondan yuklab olishlar sonini server ko‘rmaydi — uni App Store Connect va Google Play Console ko‘rsatadi. Ilovada analitika SDK yo‘q (maxfiylik siyosati). Bu paneldagi sonlar — emailini tasdiqlab ro‘yxatdan o‘tgan hisoblar.';

  @override
  String get admSales => 'Sotuvlar: 0 (hozircha to‘lov yo‘q)';

  @override
  String get admAppStoreConnect => 'App Store Connect';

  @override
  String get admPlayConsole => 'Google Play Console';

  @override
  String get admStatsAccounts => 'Hisoblar';

  @override
  String get admOnlineNow => 'Hozir onlayn (5 daqiqa)';

  @override
  String get admSuspendedAccounts => 'To‘xtatilgan hisoblar';

  @override
  String get admStatsActiveNote =>
      'Onlayn va faol — ilovadan serverga so‘rov yuborgan hisob. Faqat daqiqa va kun yoziladi; IP va qurilma saqlanmaydi.';

  @override
  String get admChartTitle => 'Yangi hisoblar — oxirgi 14 kun';

  @override
  String admChartBar(String date, int count) {
    return '$date: $count ta yangi hisob';
  }

  @override
  String admChartTotal(int count) {
    return '14 kunda jami: $count';
  }

  @override
  String get admStatsObjects => 'Asosiy obyektlar';

  @override
  String get admStatsGroupsCount => 'Guruhlar';

  @override
  String get admStatsTeachers => 'Ro‘yxatdan o‘tgan ustozlar';

  @override
  String get admStatsStudents => 'Guruhlardagi talabalar';

  @override
  String get admStatsAssignments => 'Test sessiyalari';

  @override
  String get admStatsResults => 'Test natijalari';

  @override
  String get admStatsComplaintsOpen => 'Ochiq shikoyatlar';

  @override
  String get admStatsComplaintsResolved => 'Hal qilingan shikoyatlar';

  @override
  String get admStatsAwaiting => 'Murojaatlar: javob kutmoqda';

  @override
  String admStatsUpdated(String time) {
    return 'Yangilandi: $time';
  }

  @override
  String get admComplaintsTitle => 'Ilova shikoyatlari';

  @override
  String get admApple12Note =>
      'Nomaqbul kontent haqidagi shikoyatlarni tez ko‘rib chiqing (Apple 1.2 — o‘z vaqtida javob talab qilinadi; maqsad — 24 soat).';

  @override
  String get admFilterOpen => 'Ochiq';

  @override
  String get admFilterResolved => 'Hal qilingan';

  @override
  String get admAllKinds => 'Barcha turlar';

  @override
  String get complaintKindComplaint => 'Shikoyat';

  @override
  String get complaintKindInappropriate => 'Nomaqbul kontent';

  @override
  String get complaintKindBug => 'Xato';

  @override
  String get complaintKindAd => 'Reklama';

  @override
  String get complaintKindOther => 'Boshqa';

  @override
  String get admComplaintsEmpty => 'Bu ro‘yxatda shikoyat yo‘q';

  @override
  String get admComplaintAnon => 'Mehmon (hisobsiz)';

  @override
  String admComplaintFrom(String email) {
    return 'Yuboruvchi: $email';
  }

  @override
  String admComplaintTarget(String ref) {
    return 'Ishora: $ref';
  }

  @override
  String get admComplaintNote => 'Admin izohi';

  @override
  String get admComplaintNoteHint => 'Nima qilindi? (faqat adminlar ko‘radi)';

  @override
  String get admComplaintSaveNote => 'Izohni saqlash';

  @override
  String get admComplaintResolve => 'Hal qilindi';

  @override
  String get admComplaintReopen => 'Qayta ochish';

  @override
  String admComplaintResolvedOn(String date) {
    return 'Hal qilingan: $date';
  }

  @override
  String get admSaved => 'Saqlandi';

  @override
  String get admSearchModeEmail => 'Email';

  @override
  String get admSearchModeName => 'Taxallus';

  @override
  String get admSearchEmail => 'To‘liq email (aniq moslik)';

  @override
  String get admSearchName => 'Guruhdagi taxallus (kamida 2 belgi)';

  @override
  String get admUsersSearchNote =>
      'Email serverda ochiq saqlanmaydi: hisob faqat to‘liq email bo‘yicha topiladi va niqoblangan ko‘rinishda chiqadi.';

  @override
  String get admSearch => 'Qidirish';

  @override
  String get admStatusActive => 'Faol';

  @override
  String get admStatusSuspended => 'To‘xtatilgan';

  @override
  String get admUserAdminTag => 'Admin';

  @override
  String get admUserTitle => 'Foydalanuvchi';

  @override
  String get admUserRole => 'Rol';

  @override
  String get admRoleChanged => 'Rol o‘zgartirildi';

  @override
  String get admRoleSelfNote =>
      'O‘z rolingizni va holatingizni bu yerda o‘zgartirib bo‘lmaydi.';

  @override
  String admUserFacts(int owned, int joined, int threads, int complaints) {
    return 'Guruhlar: $owned (ustoz) · $joined (talaba) · murojaatlar: $threads · shikoyatlar: $complaints';
  }

  @override
  String get admAccountTitle => 'Hisob holati';

  @override
  String get admAccountSuspend => 'Hisobni to‘xtatish';

  @override
  String get admAccountSuspendTitle => 'Hisob to‘xtatilsinmi?';

  @override
  String get admAccountSuspendBody =>
      'Barcha qurilmalardan chiqariladi va qayta kira olmaydi (email kodi, Google, Apple). Ilova unga aloqa manzilini ko‘rsatadi. Amal jurnalga yoziladi.';

  @override
  String get admAccountReactivate => 'Qayta faollashtirish';

  @override
  String get admAccountReactivateTitle => 'Hisob qayta faollashtirilsinmi?';

  @override
  String get admAccountReactivateBody =>
      'Foydalanuvchi yana kira oladi. Amal jurnalga yoziladi.';

  @override
  String get admAccountAdminNote => 'Admin hisobini to‘xtatib bo‘lmaydi.';

  @override
  String get admErrOwner => 'Egasi hisobini to‘xtatib bo‘lmaydi.';

  @override
  String get admErrSelf => 'O‘zingizga bu amalni qo‘llab bo‘lmaydi.';

  @override
  String get admErrName => 'Taxallus 2–40 belgi bo‘lsin.';

  @override
  String admAuditBy(String actor) {
    return 'Bajaruvchi: $actor';
  }

  @override
  String get admAuditSystem => 'Tizim';

  @override
  String get adminActionAccountDeleted => 'Hisob o‘chirildi';

  @override
  String get adminActionMfa => '2FA yoqildi';

  @override
  String get adminActionTeacher => 'Ustoz ro‘yxatdan o‘tdi';

  @override
  String get adminActionRoleChanged => 'Rol o‘zgartirildi';

  @override
  String get adminActionAccountSuspended => 'Hisob to‘xtatildi';

  @override
  String get adminActionAccountReactivated => 'Hisob qayta faollashtirildi';

  @override
  String get adminActionComplaintNote => 'Shikoyatga izoh yozildi';

  @override
  String get adminActionComplaintResolved => 'Shikoyat hal qilindi';

  @override
  String get adminActionComplaintReopened => 'Shikoyat qayta ochildi';

  @override
  String get adminActionIdentityLinked => 'Kirish usuli bog‘landi';

  @override
  String get complaintFormTitle => 'Ilova ichidan shikoyat yuborish';

  @override
  String get complaintFormBody =>
      'Nomaqbul kontent, xato yoki boshqa muammo haqida yozing — NurseGuide jamoasi ko‘rib chiqadi (odatda 24 soat ichida).';

  @override
  String get complaintKindLabel => 'Turi';

  @override
  String get complaintText => 'Matn';

  @override
  String get complaintTextHint => 'Nima bo‘ldi? Qaysi ekran yoki post?';

  @override
  String complaintTarget(String ref) {
    return 'Ishora: $ref';
  }

  @override
  String get complaintSend => 'Shikoyat yuborish';

  @override
  String get complaintSent => 'Yuborildi. Rahmat — ko‘rib chiqamiz.';

  @override
  String get complaintTooShort => 'Kamida 5 belgi yozing.';

  @override
  String complaintRateLimited(int minutes) {
    return 'Juda ko‘p yuborildi: soatiga 5 ta. $minutes daqiqadan keyin qayta urinib ko‘ring.';
  }

  @override
  String get complaintAnonNote =>
      'Hisobsiz yuborsangiz, sizga javob bera olmaymiz. Javob kerak bo‘lsa — hisobga kiring yoki email yozing.';

  @override
  String get complaintPhiNote =>
      'Bemorning ismi yoki boshqa shaxsiy ma’lumotini yozmang.';

  @override
  String get complaintFailed =>
      'Yuborilmadi. Internetni tekshirib, qayta urinib ko‘ring.';

  @override
  String authAccountSuspended(String email) {
    return 'Hisobingiz to‘xtatilgan. Savol bo‘lsa, yozing: $email';
  }

  @override
  String get admSectionComplaints => 'Shikoyatlar';

  @override
  String get lectureSearchLabel => 'Taqdimotlarni qidirish';

  @override
  String get lectureSearchHint => 'Mavzu yoki slayd sarlavhasi';

  @override
  String get lectureFilterAll => 'Hammasi';

  @override
  String get lectureFilterProtocols => 'Amaliy protokollar';

  @override
  String lectureFilterModule(int n) {
    return '$n-modul';
  }

  @override
  String get lectureLangAll => 'Barcha tillar';

  @override
  String lectureDecksCount(int count) {
    return '$count ta taqdimot';
  }

  @override
  String lectureSlidesCount(int count) {
    return '$count slayd';
  }

  @override
  String lectureSlidesMatch(int count) {
    return '$count ta slayd mos';
  }

  @override
  String lectureMoreSlides(int count) {
    return 'yana $count ta';
  }

  @override
  String lectureResultsFound(int count) {
    return '$count ta taqdimot topildi';
  }

  @override
  String get lectureNoResultsTitle => 'Hech narsa topilmadi';

  @override
  String get lectureNoResultsBody =>
      'Boshqa so‘z yoki filtrni sinab ko‘ring. Qidiruv o‘zbekcha (lotin yoki kirill), ruscha va inglizcha ishlaydi.';

  @override
  String get lectureClearFilters => 'Qidiruv va filtrni tozalash';

  @override
  String lectureLangFallback(String wanted, String shown) {
    return 'Bu taqdimot $wanted tilida yo‘q — $shown tilida ko‘rsatilmoqda';
  }

  @override
  String get lectureDeckLoadFailed => 'Taqdimotni ochib bo‘lmadi';

  @override
  String get lectureFullscreen => 'To‘liq ekran';

  @override
  String get lectureFullscreenExit => 'To‘liq ekrandan chiqish';

  @override
  String get lectureSourcesTitle => 'Slayd manbalari';

  @override
  String get lectureSourcesOpen => 'Manbalarni to‘liq ko‘rish';

  @override
  String lectureSourcesCount(int count) {
    return 'Manbalar: $count';
  }

  @override
  String lectureSourceLocator(String loc) {
    return 'Bo‘lim/sahifa: $loc';
  }

  @override
  String get lectureSourcesHint =>
      'To‘liq ro‘yxat — oxirgi «Adabiyotlar» slaydida.';

  @override
  String get lectureRotateTitle =>
      'Ekranni gorizontal (albom) holatga aylantiraymizmi?';

  @override
  String get lectureRotateBody =>
      'Gorizontal holatda slayd butun ekranni egallaydi. «Yo‘q» — ekran aylanmaydi, slayd joriy holatda ko‘rsatiladi.';

  @override
  String get lectureRotateCastBody =>
      'Televizor va monitorlar gorizontal: uzatishda gorizontal holat tavsiya etiladi.';

  @override
  String get lectureRotateYes => 'Ha';

  @override
  String get lectureRotateNo => 'Yo‘q';

  @override
  String get lectureRotateRemember => 'Qayta so‘ramaslik';

  @override
  String get lectureOrientationMenu => 'Taqdimotda ekran holati';

  @override
  String get lectureOrientationAsk => 'Doim so‘rash';

  @override
  String get lectureOrientationLandscape => 'Doim gorizontal';

  @override
  String get lectureOrientationKeep => 'Aylantirmaslik';

  @override
  String get lectureMore => 'Boshqa amallar';

  @override
  String get lectureCast => 'Ekranga uzatish';

  @override
  String get lectureCastTitle => 'Televizor yoki monitorga uzatish';

  @override
  String get lectureCastHow =>
      'Uzatish telefonning o‘z «ekranni takrorlash» funksiyasi orqali ishlaydi: televizorda telefon ekrani ko‘rinadi. Taqdimot rejimida ekranda faqat slayd bo‘ladi (tugmalarsiz), ekran o‘chmaydi.';

  @override
  String get lectureCastStepsAndroid =>
      '1. Telefon va televizor bitta Wi‑Fi tarmog‘ida bo‘lsin.\n2. «Ekranni uzatish» (Cast, Smart View, Miracast — nomi telefonga qarab) ni oching va televizorni tanlang.\n3. Ilovaga qayting va «Taqdimotni boshlash» ni bosing.';

  @override
  String get lectureCastStepsIos =>
      '1. iPhone/iPad va televizor (Apple TV yoki AirPlay qo‘llaydigan) bitta Wi‑Fi tarmog‘ida bo‘lsin.\n2. Boshqaruv markazini oching (yuqori o‘ng burchakdan pastga suring) → «Ekranni takrorlash» (Screen Mirroring) → televizorni tanlang.\n3. Ilovaga qayting va «Taqdimotni boshlash» ni bosing.';

  @override
  String get lectureCastOpenSettings => 'Uzatish sozlamasini ochish';

  @override
  String get lectureCastSettingsFailed =>
      'Sozlamani ochib bo‘lmadi — telefon sozlamalari yoki tezkor panelidan «Ekranni uzatish» ni toping.';

  @override
  String get lectureCastStart => 'Taqdimotni boshlash';

  @override
  String get lecturePresenter => 'Taqdimotchi rejimi';

  @override
  String get lecturePresenterNext => 'Keyingi slayd';

  @override
  String get lecturePresenterLast => 'Bu oxirgi slayd';

  @override
  String get lecturePresenterTimer => 'Vaqt';

  @override
  String get lecturePresenterReset => 'Vaqtni qaytadan boshlash';

  @override
  String get lecturePresenterNote =>
      'Taqdimotchi rejimi faqat shu qurilmada. Televizorga uzatilsa, televizorda ham shu ko‘rinish chiqadi (ekran takrorlanadi) — auditoriya uchun «To‘liq ekran» dan foydalaning.';

  @override
  String get topicTestAction => 'Mavzu testi';

  @override
  String get topicTestPreparing => 'Bu mavzu uchun savollar tayyorlanmoqda';

  @override
  String get topicTestPreparingShort => 'Savollar tayyorlanmoqda';

  @override
  String topicTestPreparingBody(int count) {
    return 'Testga faqat tekshirilgan savollar qo‘yiladi. Hozircha bu mavzu bo‘yicha $count ta bor — kamida 3 ta kerak.';
  }

  @override
  String topicTestIntro(int count) {
    return '$count ta savol · har javobdan keyin to‘g‘ri javob va izoh';
  }

  @override
  String get topicTestSavedNote =>
      'Chiqib ketsangiz ham javoblar saqlanadi — keyin shu joydan davom ettirasiz.';

  @override
  String get topicTestSourcesNote =>
      'Savollar faqat tekshirilgan manbalardan: kaliti tasdiqlangan rasmiy toifa savollari va manbasi ko‘rsatilgan mashq savollari.';

  @override
  String get topicTestStart => 'Testni boshlash';

  @override
  String topicTestBest(int score, int total) {
    return 'Eng yaxshi natija: $score/$total';
  }

  @override
  String topicTestBadgeLabel(int score, int total) {
    return 'Mavzu testi, eng yaxshi natija $score / $total';
  }

  @override
  String get topicTestRetake => 'Qayta topshirish';

  @override
  String get topicTestNextTopic => 'Keyingi mavzu';

  @override
  String get topicTestOpenSlide => 'Slaydni ko‘rish';

  @override
  String get topicTestOpenDeckStart => 'Taqdimotni boshidan ko‘rish';

  @override
  String get topicTestHistory => 'Natijalar tarixi';

  @override
  String get topicTestAssign => 'Guruhga topshirish';

  @override
  String topicTestLimitBody(int minutes) {
    return 'Har bir talabaga boshlagan paytidan $minutes daqiqa beriladi. Vaqt tugasa, javoblar o‘zi yuboriladi.';
  }

  @override
  String get topicTestLimitNoneBody =>
      'Vaqt chegarasi yo‘q — talaba testni muddat ichida istalgan vaqtda yechadi.';

  @override
  String get topicTestOpenFor => 'Test qancha vaqt ochiq turadi';

  @override
  String get topicTestAssignSub =>
      'Talabalar QR yoki kod bilan qo\'shilib yechadi, natijalar sizda chiqadi';

  @override
  String get topicTestSelf => 'O\'zim yechib ko\'rish';

  @override
  String get topicTestSelfSub =>
      'Faqat sizda saqlanadi, talabalarga yuborilmaydi';

  @override
  String get topicTestAssignIntro =>
      'Talabalar testni o‘z telefonida muddatgacha topshiradi; ball serverda hisoblanadi.';

  @override
  String get topicTestGroups => 'Guruhlar';

  @override
  String get topicTestNoGroups => 'Sizda hali guruh yo‘q';

  @override
  String get topicTestNoGroupsBody =>
      'Avval guruh oching va talabalarni taklif qiling — keyin testni shu yerdan topshirasiz.';

  @override
  String get topicTestPickGroup => 'Kamida bitta guruhni tanlang';

  @override
  String get topicTestReveal => 'To‘g‘ri javoblar talabaga';

  @override
  String get topicTestRevealNow => 'Topshirgach darhol';

  @override
  String get topicTestRevealAfterDue => 'Muddat tugagach';

  @override
  String get topicTestRevealNeedsDue =>
      '“Muddat tugagach” uchun topshirish muddatini tanlang';

  @override
  String topicTestSent(int count) {
    return 'Test yuborildi: $count ta guruh';
  }

  @override
  String topicTestTitle(String title) {
    return 'Mavzu testi: $title';
  }

  @override
  String get topicTestSentList => 'Yuborilgan testlar';

  @override
  String topicTestAnswersLater(String date) {
    return 'To‘g‘ri javoblar muddat tugagach ($date) yoki ustoz testni yakunlaganda ochiladi';
  }

  @override
  String get topicTestDistribution => 'Natijalar taqsimoti';

  @override
  String get topicTestHardest => 'Eng qiyin savollar';

  @override
  String get topicTestAssignedTitle => 'Topshirilgan testlar';

  @override
  String get topicTestMenu => 'Amallar';

  @override
  String get topicTestOpenLecture => 'Taqdimotni ochish';

  @override
  String get topicTestCreateGroup => 'Guruh ochish';

  @override
  String topicTestStudents(int count) {
    return '$count ta talaba';
  }

  @override
  String topicTestReworkMistakes(int count) {
    return 'Xatolarni takrorlash · $count';
  }

  @override
  String get admDeleteTitle => 'Hisobni o‘chirish';

  @override
  String get admDeleteNote =>
      'Email orqali kelgan o‘chirish so‘rovi uchun (30 kun ichida bajariladi). Tasdiq uchun foydalanuvchining to‘liq emailini kiriting — server uning aynan shu hisobga tegishliligini tekshiradi. Hisob, guruh a’zoligi, murojaatlar va kirish usullari butunlay o‘chadi; Apple bilan kirgan bo‘lsa, Apple tokenini bekor qilish urinib ko‘riladi. Qaytarib bo‘lmaydi; amal jurnalga yoziladi.';

  @override
  String get admDeleteEmail => 'Foydalanuvchining to‘liq emaili';

  @override
  String get admDeleteButton => 'Hisobni butunlay o‘chirish';

  @override
  String get admDeleteConfirmTitle => 'Hisob butunlay o‘chirilsinmi?';

  @override
  String admDeleteConfirmBody(String email) {
    return '$email hisobi va unga bog‘liq hamma ma’lumot o‘chiriladi. Bu amalni qaytarib bo‘lmaydi.';
  }

  @override
  String get admDeleteDone => 'Hisob o‘chirildi';

  @override
  String get admDeleteMismatch =>
      'Bu email shu hisobga tegishli emas — tekshirib, qayta kiriting.';

  @override
  String get examPracticeNotice =>
      'Natija — ichki mashq uchun, rasmiy baho emas.';

  @override
  String get classesPasteLink => 'Havolani qo‘yish';

  @override
  String get classesPasteNoCode =>
      'Nusxada taklif kodi topilmadi. Ustoz yuborgan havola yoki kodni nusxalang.';

  @override
  String get classesScanTip =>
      'QR kodni telefon kamerasi bilan skanerlang va ochilgan sahifada “Ilovada ochish” ni bosing — kod shu yerga o‘zi tushadi.';

  @override
  String get qrScanAction => 'QR kodni skanerlash';

  @override
  String get qrScanHint =>
      'Ustoz bergan guruh yoki test QR kodini ramka ichiga to‘g‘rilang';

  @override
  String get qrScanTorchOn => 'Chiroqni yoqish';

  @override
  String get qrScanTorchOff => 'Chiroqni o‘chirish';

  @override
  String get qrScanTypeCode => 'Kodni yozish yoki qo‘yish';

  @override
  String get qrScanNotInvite => 'Bu QR kod NurseGuide guruh taklifi emas';

  @override
  String get qrScanDeniedTitle => 'Kameraga ruxsat berilmagan';

  @override
  String get qrScanDeniedBody =>
      'QR kodni o‘qish uchun sozlamalarda NurseGuide’ga kamera ruxsatini bering. Kamera kadri faqat telefonda o‘qiladi — rasm saqlanmaydi va yuborilmaydi. Yoki kodni qo‘lda yozing yoki havolani qo‘ying.';

  @override
  String get qrScanOpenSettings => 'Sozlamalarni ochish';

  @override
  String get qrScanFailedTitle => 'Kamerani ochib bo‘lmadi';

  @override
  String get qrScanFailedBody =>
      'Kodni qo‘lda yozing yoki ustoz yuborgan havolani qo‘ying.';

  @override
  String get qrScanStarting => 'Kamera ochilmoqda…';

  @override
  String get classesJoinOpensTest =>
      'Qo‘shilgach ustoz bergan test darhol ochiladi.';

  @override
  String get classesJoinSignInTitle => 'Guruhga qo‘shilish uchun kiring';

  @override
  String get classesJoinSignInBody =>
      'Google, Apple yoki email kodi bilan — bir daqiqa. Natijangiz ustozga shu hisob orqali boradi; taklif kodi saqlanib qoladi.';

  @override
  String get classesNicknameTaken =>
      'Bu taxallus guruhda band — boshqasini yozing.';

  @override
  String get classesNicknameAbusive =>
      'Taxallusda nojo‘ya so‘z bor — boshqasini yozing.';

  @override
  String get classesTestQr => 'Test QR';

  @override
  String get classesTestQrBody =>
      'Talabalar skanerlaydi → kiradi → taxallus → shu test ochiladi. Natijalar shu sahifada o‘zi yangilanadi.';

  @override
  String get classesInviteLink => 'Havolani nusxalash';

  @override
  String get classesLiveNote =>
      'Natijalar har 10 soniyada o‘zi yangilanadi. Pastga torting — hozir yangilash.';

  @override
  String get boardOpen => 'Katta ekran';

  @override
  String get boardJoined => 'Guruhda';

  @override
  String get boardStarted => 'Yechmoqda';

  @override
  String get boardSubmitted => 'Topshirdi';

  @override
  String get boardStatusWaiting => 'Kutilmoqda';

  @override
  String get boardStatusSolving => 'Yechmoqda…';

  @override
  String get boardScan => 'Skanerlang va qo‘shiling';

  @override
  String get boardAnswersAfterClose =>
      'To‘g‘ri javoblar test yakunlangach ko‘rsatiladi.';

  @override
  String get boardEmpty => 'Hali hech kim yo‘q — QR ni skanerlang.';

  @override
  String get boardClose => 'Katta ekrandan chiqish';

  @override
  String get actionClose => 'Yopish';

  @override
  String get variantToggle => 'Har bir talabaga boshqa savollar';

  @override
  String variantOnBody(int pool, int n) {
    return 'Har talabaga mavzudagi $pool ta savoldan $n tasi tushadi — kichik mavzular bo‘yicha teng taqsimlanadi.';
  }

  @override
  String get variantOffBody =>
      'Hamma talabaga bir xil savollar (tartibi aralashtiriladi).';

  @override
  String variantDisabledBody(int pool, int need) {
    return 'Mavzuda $pool ta savol bor — har talabaga boshqa to‘plam uchun kamida $need ta kerak (savollar sonidan 2 barobar). Savollar sonini kamaytiring.';
  }

  @override
  String get variantUnsupported => 'Variantli test bu serverda qo‘llanmaydi.';

  @override
  String variantPoolTitle(int pool) {
    return 'Savollar hovuzi ($pool)';
  }

  @override
  String get variantLabel => 'Variantli test';

  @override
  String variantPerStudent(int n, int pool) {
    return 'Har talabaga $n ta savol, hovuzda $pool ta';
  }

  @override
  String variantReceived(int n) {
    return '$n ta talabaga tushdi';
  }

  @override
  String get homeResumeCta => 'Davom ettirish';

  @override
  String homeResumeBody(String title) {
    return 'Oxirgi ochilgan: $title';
  }

  @override
  String get helpTitle => 'Yordam va aloqa';

  @override
  String get helpSub => 'Ilovada yozish yoki email — savol, taklif, shikoyat';

  @override
  String get helpIntro =>
      'Qulay yo‘lni tanlang: ilova ichidagi yozishma (javob shu yerga keladi) yoki email (shikoyat, maxfiylik so‘rovi).';

  @override
  String get classesNicknameInvalid =>
      'Taxallusda faqat harf, raqam, bo‘shliq va . _ \' - bo‘lishi mumkin; harf yoki raqam bilan boshlanib tugasin (emoji va !?@ kabi belgilarsiz).';

  @override
  String get classesGroupFull =>
      'Guruh to‘lgan (200 kishi) — ustozingizga ayting.';

  @override
  String get classesCodeAmbiguous =>
      'Kodda 0, O, 1 va I belgilari bo‘lmaydi. Kodni ustozdan qayta tekshiring yoki QR’ni skanerlang.';

  @override
  String get classesOwnGroupTitle => 'Siz bu guruhning ustozisiz';

  @override
  String get classesOwnGroupBody =>
      'Bu hisob guruhni ochgan, shuning uchun unga talaba bo‘lib qo‘shila olmaydi (Profildagi rolni almashtirish buni o‘zgartirmaydi). Talaba sifatida sinash uchun boshqa hisob bilan kiring yoki testni talaba ko‘rinishida sinab ko‘ring.';

  @override
  String get classesOwnGroupOpen => 'Ustoz sifatida ochish';

  @override
  String get classesSwitchAccount => 'Boshqa hisob bilan kirish';

  @override
  String get classesPreviewAsStudent => 'Talaba ko‘rinishida sinash';

  @override
  String get classesPreviewNote =>
      'Sinov rejimi: javoblar serverga yuborilmaydi va natijalar ro‘yxatida ko‘rinmaydi.';

  @override
  String classesPreviewResult(int correct, int total) {
    return 'Sinov tugadi: $correct / $total to‘g‘ri. Natija yuborilmadi.';
  }

  @override
  String get classesGiveTopicTest => 'Mavzu testi berish';

  @override
  String get classesGiveTopicTestSub =>
      'Mavzuni tanlang — keyingi sahifada savollar soni, variantli test, muddat va javoblar qachon ochilishi.';

  @override
  String get classesTopicSearchHint => 'Mavzuni qidiring (masalan, anemiya)';

  @override
  String get classesTopicNoMatch => 'Testi tayyor mavzu topilmadi';

  @override
  String classesTopicQuestions(int count) {
    return '$count ta savol';
  }

  @override
  String examDeadlineAt(String date) {
    return 'Muddat: $date';
  }

  @override
  String get classesScanAskNick =>
      'Qo‘shilishdan oldin taxallusingizni yozing — ustoz natijangizni shu nom bilan ko‘radi (ixtiyoriy: bo‘sh qoldirsangiz, tartib raqami). So‘ng «Qo‘shilish».';

  @override
  String get classesMyNickname => 'Taxallusim';

  @override
  String get classesNoNickname => 'Yo‘q — ustozda tartib raqamingiz ko‘rinadi';

  @override
  String get classesNicknameSaved => 'Taxallus saqlandi';

  @override
  String get classesNicknameNote =>
      'Haqiqiy ismingizni yozmang. Bo‘sh qoldirsangiz — tartib raqami.';

  @override
  String get rolesTeacherRegisterNote =>
      '«Davom etish» hisobingizni ustoz sifatida ro‘yxatdan o‘tkazadi: faqat o‘zingiz ochgan guruhlarni boshqarasiz va ularning natijalarini ko‘rasiz (admin huquqi emas).';

  @override
  String get rolesTeacherSignInNote =>
      'Ustoz roli faqat hisobga kirgan foydalanuvchilar uchun. Hisobga kiring (email, Google yoki Apple) — keyin rolni Profildan tanlaysiz.';

  @override
  String get classesGiveGeneralTest => 'Umumiy test berish';

  @override
  String get generalTestSub => 'Bir nechta mavzudan — 50 tagacha savol';

  @override
  String get generalTestIntro =>
      'Mavzularni tanlang — savollar ular orasida teng taqsimlanadi. Talabalar testni o‘z telefonida topshiradi, ball serverda hisoblanadi.';

  @override
  String get generalTestSources => 'Savollar qayerdan';

  @override
  String get generalTestSearchHint => 'Mavzuni qidiring (masalan, anemiya)';

  @override
  String get generalSourceToifa => 'Toifa savollari';

  @override
  String get generalSourceToifaSub => 'Rasmiy ro‘yxat, kalitlari tekshirilgan';

  @override
  String get generalSourceLecture => 'Ma’ruza mavzulari';

  @override
  String get generalSourceLectureSub => 'Butun modul yoki alohida kun';

  @override
  String get generalSourcePack => 'Mashq savollari bo‘yicha';

  @override
  String get generalSourcePackSub => 'Mavzu guruhlari savollari';

  @override
  String get generalSourceToifaShort => 'Toifa';

  @override
  String get generalSourceLectureShort => 'Ma’ruza';

  @override
  String get generalSourcePackShort => 'Mashq';

  @override
  String get generalSelectAll => 'Hammasini tanlash';

  @override
  String get generalAllShort => 'hammasi';

  @override
  String generalDays(int count) {
    return 'Kunlar · $count';
  }

  @override
  String generalSelected(int topics, int questions) {
    return 'Tanlandi: $topics ta mavzu · $questions ta savol';
  }

  @override
  String get generalPickTopic => 'Kamida bitta mavzuni tanlang';

  @override
  String generalTestTitle(String topics) {
    return 'Umumiy test: $topics';
  }

  @override
  String get generalTestNameHint => 'Masalan, 1-oraliq nazorat';

  @override
  String get navProcedures => 'Manipulyatsiyalar';

  @override
  String get navWorkplace => 'Ish joyi';

  @override
  String get roleNurse => 'Hamshira';

  @override
  String get roleNurseDesc => 'Attestatsiya va manipulyatsiyalar';

  @override
  String get procTitle => 'Manipulyatsiyalar';

  @override
  String get procSub => 'Bosqichma-bosqich amaliy ko‘rsatmalar';

  @override
  String get procEmptyTitle => 'Tez orada';

  @override
  String get procEmptyBody =>
      'Manipulyatsiyalar bo‘limi tayyorlanmoqda. Tekshirilgan, manbali ko‘rsatmalar keyingi yangilanishda paydo bo‘ladi.';

  @override
  String get workTitle => 'Ish joyi';

  @override
  String get workSub => 'Smena davomida kerak bo‘ladigan ma’lumotlar';

  @override
  String get workEmptyTitle => 'Tez orada';

  @override
  String get workEmptyBody =>
      'Ish joyi bo‘limi tayyorlanmoqda: dori dozalari, hisoblagichlar va tezkor ma’lumotnoma shu yerda bo‘ladi.';

  @override
  String get hubGoLearn => 'O‘rganishga o‘tish';

  @override
  String get homeHeroNurseTitle => 'Attestatsiyaga ishonch bilan tayyorlaning';

  @override
  String get homeHeroNurseBody =>
      'Toifa savollari, og‘zaki javoblar va kunlik mashq — bir joyda.';

  @override
  String get homeHeroNurseCta => 'Toifa tayyorgarligi';

  @override
  String get homeTileToifa => 'Test, og‘zaki bilet va xatolar';

  @override
  String get homeTileProcedures => 'Bosqichma-bosqich ko‘rsatmalar';

  @override
  String get homeTileWorkplace => 'Smena uchun tezkor ma’lumot';

  @override
  String get featureLessons => 'Darslar';

  @override
  String get homeTileLessons => 'Ma’ruza taqdimotlari';

  @override
  String get catFundamentals => 'Asoslar';

  @override
  String get catClinicalNursing => 'Klinik hamshiralik';

  @override
  String get catProcedures => 'Manipulyatsiyalar';

  @override
  String get catPharmacology => 'Farmakologiya';

  @override
  String get catExams => 'Imtihon va attestatsiya';

  @override
  String get kindGuideline => 'Klinik tavsiya';

  @override
  String get rolesTeacherLocked => 'Hisobga kirgan foydalanuvchilar uchun';

  @override
  String get rolesTeacherFailed =>
      'Server ustoz rolini tasdiqlamadi. Internetni tekshirib, qayta urinib ko‘ring.';

  @override
  String get toifaTopicOther => 'Boshqa';

  @override
  String get lectureUnverifiedNotice =>
      'Taqdimot hali tekshiruvdan o‘tmagan — darsdan oldin mazmunni ko‘rib chiqing';

  @override
  String get classroomKindProtocol => 'Taqdimot';

  @override
  String get lectureProtocols => 'Tayyor taqdimotlar';

  @override
  String get quizEmptyTitle => 'Savollar tez orada';

  @override
  String get quizEmptyBody =>
      'Mashq savollari tekshiruvdan o‘tgach shu yerda paydo bo‘ladi.';

  @override
  String get profileFontSize => 'Matn o‘lchami';

  @override
  String get fontSizeSmall => 'Kichik';

  @override
  String get fontSizeNormal => 'Oddiy';

  @override
  String get fontSizeLarge => 'Katta';

  @override
  String get fontSizeXLarge => 'Juda katta';

  @override
  String get profileFeedback => 'Tovush va tebranish';

  @override
  String get profileHaptics => 'Tebranish (haptik)';

  @override
  String get profileSounds => 'Tovushlar';

  @override
  String get welcomeBenefitNurseTitle => 'Hamshira uchun';

  @override
  String get welcomeBenefitNurseBody =>
      'Toifa testlari, og‘zaki biletlar va manipulyatsiyalar';

  @override
  String get welcomeBenefitStudentTitle => 'Talaba uchun';

  @override
  String get welcomeBenefitStudentBody => 'Darslar, izohli testlar va imtihon';

  @override
  String get welcomeBenefitTeacherTitle => 'Ustoz uchun';

  @override
  String get welcomeBenefitTeacherBody =>
      'Guruhlar, topshiriqlar va katta ekran';

  @override
  String get actionSave => 'Saqlash';

  @override
  String get actionUnsave => 'Saqlanganlardan olib tashlash';

  @override
  String get toifaEmptyTitle => 'Toifa savollari tez orada';

  @override
  String get toifaEmptyBody =>
      'Rasmiy ro‘yxat savollari tekshiruvdan o‘tgach shu yerda paydo bo‘ladi: test, og‘zaki bilet va xatolar ustida ishlash.';
}
